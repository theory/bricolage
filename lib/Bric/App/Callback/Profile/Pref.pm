package Bric::App::Callback::Profile::Pref;

use base qw(Bric::App::Callback::Profile);
__PACKAGE__->register_subclass;
use constant CLASS_KEY => 'pref';

use strict;
use Bric::App::Event qw(log_event);
use Bric::App::Util qw(:all);

my $disp_name = 'Preference';


sub save : Callback {
    my $self = shift;

    return unless $self->has_perms;

    my $param = $self->params;
    my $pref = $self->obj;

    my $name = $pref->get_name;
    $pref->set_value($param->{value});
    $pref->save;
    log_event('pref_save', $pref);
    add_msg("$disp_name \"[_1]\" updated.", $name);
    $self->set_redirect('/admin/manager/pref');
}


1;
