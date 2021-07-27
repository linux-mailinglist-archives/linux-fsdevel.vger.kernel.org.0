Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE83D711E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhG0IWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 04:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235920AbhG0IWe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F248260F58;
        Tue, 27 Jul 2021 08:22:32 +0000 (UTC)
Date:   Tue, 27 Jul 2021 10:22:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <20210727082230.7qf5ar7ut3otjkkl@wittgenstein>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
 <YP+VNZt2y+jP3BNR@google.com>
 <CAOQ4uxgD3xBzffqtRx-UPbj1wHoi2TXZoWx3DKyknUHspevP1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgD3xBzffqtRx-UPbj1wHoi2TXZoWx3DKyknUHspevP1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:03:20AM +0300, Amir Goldstein wrote:
> On Tue, Jul 27, 2021 at 8:10 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > On Tue, Jul 27, 2021 at 07:19:43AM +0300, Amir Goldstein wrote:
> > > On Tue, Jul 27, 2021 at 3:24 AM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > > > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > > > > allows userspace applications to control whether a pidfd info record
> > > > > containing a pidfd is to be returned with each event.
> > > > >
> > > > > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > > > > struct fanotify_event_info_pidfd object will be supplied alongside the
> > > > > generic struct fanotify_event_metadata within a single event. This
> > > > > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > > > > the event structure is supplied to the userspace application. Usage of
> > > > > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > > > > permitted, and in this case a struct fanotify_event_info_pidfd object
> > > > > will follow any struct fanotify_event_info_fid object.
> > > > >
> > > > > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > > > > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > > > > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > > > > limited to privileged processes only i.e. listeners that are running
> > > > > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > > > > these initialization flags with FAN_REPORT_PIDFD will result with
> > > > > EINVAL being returned to the caller.
> > > > >
> > > > > In the event of a pidfd creation error, there are two types of error
> > > > > values that can be reported back to the listener. There is
> > > > > FAN_NOPIDFD, which will be reported in cases where the process
> > > > > responsible for generating the event has terminated prior to fanotify
> > > > > being able to create pidfd for event->pid via pidfd_create(). The
> > > > > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > > > > creation error occurred when calling pidfd_create().
> > > > [...]
> > > > > @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > > > >         }
> > > > >         metadata.fd = fd;
> > > > >
> > > > > +       if (pidfd_mode) {
> > > > > +               /*
> > > > > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > > > > +                * exclusion is ever lifted. At the time of incoporating pidfd
> > > > > +                * support within fanotify, the pidfd API only supported the
> > > > > +                * creation of pidfds for thread-group leaders.
> > > > > +                */
> > > > > +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > > > > +
> > > > > +               /*
> > > > > +                * The PIDTYPE_TGID check for an event->pid is performed
> > > > > +                * preemptively in attempt to catch those rare instances where
> > > > > +                * the process responsible for generating the event has
> > > > > +                * terminated prior to calling into pidfd_create() and acquiring
> > > > > +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> > > > > +                * cases. All other pidfd creation errors are represented as
> > > > > +                * FAN_EPIDFD.
> > > > > +                */
> > > > > +               if (metadata.pid == 0 ||
> > > > > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > > > > +                       pidfd = FAN_NOPIDFD;
> > > > > +               } else {
> > > > > +                       pidfd = pidfd_create(event->pid, 0);
> > > > > +                       if (pidfd < 0)
> > > > > +                               pidfd = FAN_EPIDFD;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > >
> > > > As a general rule, f_op->read callbacks aren't allowed to mess with
> > > > the file descriptor table of the calling process. A process should be
> > > > able to receive a file descriptor from an untrusted source and call
> > > > functions like read() on it without worrying about affecting its own
> > > > file descriptor table state with that.
> > > >
> > >
> > > Interesting. I've never considered this interface flaw.
> > > Thanks for bringing this up!
> > >
> > > > I realize that existing fanotify code appears to be violating that
> > > > rule already, and that you're limiting creation of fanotify file
> > > > descriptors that can hit this codepath to CAP_SYS_ADMIN, but still, I
> > > > think fanotify_read() probably ought to be an ioctl, or something
> > > > along those lines, instead of an f_op->read handler if it messes with
> > > > the caller's fd table?
> > >
> > > Naturally, we cannot change the legacy interface.
> > > However, since fanotify has a modern FAN_REPORT_FID interface
> > > which does not mess with fd table maybe this is an opportunity not
> > > to repeat the same mistake for the FAN_REPORT_FID interface.
> >
> > You mean the FAN_REPORT_PIDFD interface, right?
> 
> No, I mean FAN_REPORT_FID.
> We have a new interface that does not pollute reader process fd table
> with fds of event->fd, so maybe let's try to avoiding regressing this
> use case by polluting the reader process fd table with pidfds.
> 
> >
> > > Matthew, can you explain what is the use case of the consumer
> > > application of pidfd. I am guessing this is for an audit user case?
> > > because if it were for permission events, event->pid would have been
> > > sufficient.
> >
> > Yes, the primary use case would be for reliable auditing i.e. what actual
> > process had accessed what filesystem object of interest. Generally, finding
> > what process is a little unreliable at the moment given that the reporting
> > event->pid and crawling through /proc based on that has been observed to
> > lead to certain inaccuracy in the past i.e. reporting an access that was in
> > fact not performed by event->pid.
> >
> > The permission model doesn't work in this case given that it takes the
> > "blocking" approach and not it's not something that can always be
> > afforded...
> >
> > > If that is the case, then I presume that the application does not really
> > > need to operate on the pidfd, it only need to avoid reporting wrong
> > > process details after pid wraparound?
> >
> > The idea is that the event listener, or receiver will use the
> > pidfd_send_signal(2) and specify event->info->pidfd as one of its arguments
> > in order to _reliably_ determine whether the process that generated the
> > event is still around. If so, it can freely ascertain further contextual
> > information from /proc reliably.
> >
> > > If that is the case, then maybe a model similar to inode generation
> > > can be used to report a "pid generation" in addition to event->pid
> > > and export pid generation in /proc/<pid>/stat
> >
> > TBH, I don't fully understand what you mean by this model...
> >
> 
> The model is this:
> 
> FAN_REPORT_UPID (or something) will report an info record
> with a unique identifier of the generating process or thread, because
> there is no restriction imposed by pidfd to support only group leaders.
> 
> That unique identifier may be obtained from /proc, e.g.:
> $ cat /proc/self/upid
> 633733.0
> 
> In this case .0 represents generation 0.
> If pid numbers would wrap around in that pid namespace
> generation would be bumped and next process to get pid
> 633733 would have a unique id 633733.1.
> 
> There are probably more pid namespace considerations of how
> that /proc API will be designed exactly.

I'm not a fan of this at all to be honest. This very much reminds me of
(a weak version of) pid uuids which has been very controversial. This
sounds all kinds of messy. If the pid gets recycled then you bump the
generation number in all pid namespace where that pid has been recycled
and not in the others and then you expose it through /proc. Then if a
process from one pid namespaces looks at a process from another pid
namespace through the proc file what would it see as the generation
number? That can probably all be solved but the API sounds justy very
unpleasant and hacky.
