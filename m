Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3F23DA479
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhG2NkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 09:40:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58332 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbhG2Nj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:39:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E6D620032;
        Thu, 29 Jul 2021 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627565994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBB8iKzSWglbn2svjqbyBvTur1gSGSRi7WJk5pLBV6Q=;
        b=Ht7KdXAjYk8/OBd+yUBiT3MTqqm+qYTTeCfuBfNzExiwdD85Qo/NE+05yVyFOhgSzaqtb2
        HGqyrPNYAlFXOH72O0LifxKBWHkreWvEhHsS3HYX+qh4l8w+lQhuCSc+RtN+8AkfavCQUV
        IeGp7pvMJMCz4HqU+8WNshW9I3af02g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627565994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBB8iKzSWglbn2svjqbyBvTur1gSGSRi7WJk5pLBV6Q=;
        b=IURGsvfIWmGvVidBBqqlR5iODG93nueHi3K3f8L6u25xXVia1kkYcTLqzRoMS1pgW0goIt
        cqUXByw+a3OFcbCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2543EA3B8C;
        Thu, 29 Jul 2021 13:39:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0469B1E12F7; Thu, 29 Jul 2021 15:39:54 +0200 (CEST)
Date:   Thu, 29 Jul 2021 15:39:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <20210729133953.GL29619@quack2.suse.cz>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-07-21 07:19:43, Amir Goldstein wrote:
> On Tue, Jul 27, 2021 at 3:24 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > > allows userspace applications to control whether a pidfd info record
> > > containing a pidfd is to be returned with each event.
> > >
> > > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > > struct fanotify_event_info_pidfd object will be supplied alongside the
> > > generic struct fanotify_event_metadata within a single event. This
> > > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > > the event structure is supplied to the userspace application. Usage of
> > > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > > permitted, and in this case a struct fanotify_event_info_pidfd object
> > > will follow any struct fanotify_event_info_fid object.
> > >
> > > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > > limited to privileged processes only i.e. listeners that are running
> > > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > > these initialization flags with FAN_REPORT_PIDFD will result with
> > > EINVAL being returned to the caller.
> > >
> > > In the event of a pidfd creation error, there are two types of error
> > > values that can be reported back to the listener. There is
> > > FAN_NOPIDFD, which will be reported in cases where the process
> > > responsible for generating the event has terminated prior to fanotify
> > > being able to create pidfd for event->pid via pidfd_create(). The
> > > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > > creation error occurred when calling pidfd_create().
> > [...]
> > > @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > >         }
> > >         metadata.fd = fd;
> > >
> > > +       if (pidfd_mode) {
> > > +               /*
> > > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > > +                * exclusion is ever lifted. At the time of incoporating pidfd
> > > +                * support within fanotify, the pidfd API only supported the
> > > +                * creation of pidfds for thread-group leaders.
> > > +                */
> > > +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > > +
> > > +               /*
> > > +                * The PIDTYPE_TGID check for an event->pid is performed
> > > +                * preemptively in attempt to catch those rare instances where
> > > +                * the process responsible for generating the event has
> > > +                * terminated prior to calling into pidfd_create() and acquiring
> > > +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> > > +                * cases. All other pidfd creation errors are represented as
> > > +                * FAN_EPIDFD.
> > > +                */
> > > +               if (metadata.pid == 0 ||
> > > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > > +                       pidfd = FAN_NOPIDFD;
> > > +               } else {
> > > +                       pidfd = pidfd_create(event->pid, 0);
> > > +                       if (pidfd < 0)
> > > +                               pidfd = FAN_EPIDFD;
> > > +               }
> > > +       }
> > > +
> >
> > As a general rule, f_op->read callbacks aren't allowed to mess with
> > the file descriptor table of the calling process. A process should be
> > able to receive a file descriptor from an untrusted source and call
> > functions like read() on it without worrying about affecting its own
> > file descriptor table state with that.
> >
> 
> Interesting. I've never considered this interface flaw.
> Thanks for bringing this up!

Me neither. But I guess it's one more reason why any fd-generating variant
of fanotify should stay priviledged.

> > I realize that existing fanotify code appears to be violating that
> > rule already, and that you're limiting creation of fanotify file
> > descriptors that can hit this codepath to CAP_SYS_ADMIN, but still, I
> > think fanotify_read() probably ought to be an ioctl, or something
> > along those lines, instead of an f_op->read handler if it messes with
> > the caller's fd table?
> 
> Naturally, we cannot change the legacy interface.
> However, since fanotify has a modern FAN_REPORT_FID interface
> which does not mess with fd table maybe this is an opportunity not
> to repeat the same mistake for the FAN_REPORT_FID interface.
> 
> Matthew, can you explain what is the use case of the consumer
> application of pidfd. I am guessing this is for an audit user case?
> because if it were for permission events, event->pid would have been
> sufficient.
> 
> If that is the case, then I presume that the application does not really
> need to operate on the pidfd, it only need to avoid reporting wrong
> process details after pid wraparound?
> 
> If that is the case, then maybe a model similar to inode generation
> can be used to report a "pid generation" in addition to event->pid
> and export pid generation in /proc/<pid>/status?
> 
> Or am I completely misunderstanding the use case?

Well, but pidfd also makes sure that /proc/<pid>/ keeps belonging to the
same process while you read various data from it. And you cannot achieve
that with pid+generation thing you've suggested. Plus the additional
concept and its complexity is non-trivial So I tend to agree with
Christian that we really want to return pidfd.

Given returning pidfd is CAP_SYS_ADMIN priviledged operation I'm undecided
whether it is worth the trouble to come up with some other mechanism how to
return pidfd with the event. We could return some cookie which could be
then (by some ioctl or so) either transformed into real pidfd or released
(so that we can release pid handle in the kernel) but it looks ugly and
complicates things for everybody without bringing significant security
improvement (we already can pass fd with the event). So I'm pondering
whether there's some other way how we could make the interface safer - e.g.
so that the process receiving the event (not the one creating the group)
would also need to opt in for getting fds created in its file table.

But so far nothing bright has come to my mind. :-|

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
