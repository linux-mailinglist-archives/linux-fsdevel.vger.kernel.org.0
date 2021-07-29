Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D893DA740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhG2PNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhG2PNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:13:21 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B2C061765;
        Thu, 29 Jul 2021 08:13:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 185so7610690iou.10;
        Thu, 29 Jul 2021 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nua3Rn1N6LerhfGPLxEEhXWOndG8+5p+OI6P+akMl1A=;
        b=m4YScbaD9QIw9AwZPdFEsnfKjf7ZokjEP+7zKsRsyxsJDvbbbKF1pQ1pmjZRRrBPaX
         a0sJgR8LcZ0qcHhjSJl7Z/OZNFFFoPIx1sdrnGGjBlh07ciQN6Ix5HP4jPaUvxCa5zUO
         vCHysTNEENyAZdx8/I1LYV/dkunMI61NmME40d+W407ULeVljLlL35mxrWO9QGJJ+/E+
         ENwER+OW6xqeZbRG2zme++s8Xp/nRwdxA0AKDYR04jUVlJ0f1+YNrBwqRmGJg6X4vs49
         HiZoCndQD+SoEIXIBwSbmaQXmvAhoZwSVtVSU4aRD69bdhwnSSaD6/8u6M73gyt8m2Ot
         e7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nua3Rn1N6LerhfGPLxEEhXWOndG8+5p+OI6P+akMl1A=;
        b=HY0d2ec7HU5OKxyi2PIcjevpRbzAx3veB5kufdVB+REZY6r2lTjXt8KHIJwfs22wRF
         i+GXRiy+cLR2pFT03Jq2bX+2dPbWM6nSs76SIlnKQR9xbR2b2d290ksP7MpVwGsRK1Zj
         pfHIZh4b9tCe/HvA/7wRENNCIWFQglqUoGon7sc6SpTmTzOzJu+MN/3e/vSWIrUcfU2v
         0zyEwmDrkK9+kO49TorDANiMUnnaQe8fpBW0+X2iDPLCICpO+nYczu/Ts6U9f9BGBX7z
         LEyONNc3vfLBtH/fDxwnfSfzuUwViLSdbgL0NmCR6yVwAU+rMYW6BRVmgEN2NCHhrKVb
         LbKg==
X-Gm-Message-State: AOAM531EI3pGCsRXrVzxMHtWESnpvWc7rwgdBlRJLiWZFEKiSmbW5q8Y
        kmHrQnrg3XFar3T4Dz7NhP6xS8qJN/rF1o0Yj3Y=
X-Google-Smtp-Source: ABdhPJzq8YUSxUBQ+7HsVo5gRtsHjBLgc3FRx4IqJOEvM9Zq6mv8yuNFWRbzXaemsL3JY8KVeTK65vtcBG0oQ1txDX0=
X-Received: by 2002:a6b:3bc3:: with SMTP id i186mr4539502ioa.64.1627571596658;
 Thu, 29 Jul 2021 08:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com> <20210729133953.GL29619@quack2.suse.cz>
In-Reply-To: <20210729133953.GL29619@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Jul 2021 18:13:05 +0300
Message-ID: <CAOQ4uxi70KXGwpcBnRiyPXZCjFQfifaWaYVSDK2chaaZSyXXhQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
To:     Jan Kara <jack@suse.cz>
Cc:     Jann Horn <jannh@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 4:39 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 27-07-21 07:19:43, Amir Goldstein wrote:
> > On Tue, Jul 27, 2021 at 3:24 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > > > allows userspace applications to control whether a pidfd info record
> > > > containing a pidfd is to be returned with each event.
> > > >
> > > > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > > > struct fanotify_event_info_pidfd object will be supplied alongside the
> > > > generic struct fanotify_event_metadata within a single event. This
> > > > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > > > the event structure is supplied to the userspace application. Usage of
> > > > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > > > permitted, and in this case a struct fanotify_event_info_pidfd object
> > > > will follow any struct fanotify_event_info_fid object.
> > > >
> > > > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > > > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > > > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > > > limited to privileged processes only i.e. listeners that are running
> > > > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > > > these initialization flags with FAN_REPORT_PIDFD will result with
> > > > EINVAL being returned to the caller.
> > > >
> > > > In the event of a pidfd creation error, there are two types of error
> > > > values that can be reported back to the listener. There is
> > > > FAN_NOPIDFD, which will be reported in cases where the process
> > > > responsible for generating the event has terminated prior to fanotify
> > > > being able to create pidfd for event->pid via pidfd_create(). The
> > > > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > > > creation error occurred when calling pidfd_create().
> > > [...]
> > > > @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > > >         }
> > > >         metadata.fd = fd;
> > > >
> > > > +       if (pidfd_mode) {
> > > > +               /*
> > > > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > > > +                * exclusion is ever lifted. At the time of incoporating pidfd
> > > > +                * support within fanotify, the pidfd API only supported the
> > > > +                * creation of pidfds for thread-group leaders.
> > > > +                */
> > > > +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > > > +
> > > > +               /*
> > > > +                * The PIDTYPE_TGID check for an event->pid is performed
> > > > +                * preemptively in attempt to catch those rare instances where
> > > > +                * the process responsible for generating the event has
> > > > +                * terminated prior to calling into pidfd_create() and acquiring
> > > > +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> > > > +                * cases. All other pidfd creation errors are represented as
> > > > +                * FAN_EPIDFD.
> > > > +                */
> > > > +               if (metadata.pid == 0 ||
> > > > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > > > +                       pidfd = FAN_NOPIDFD;
> > > > +               } else {
> > > > +                       pidfd = pidfd_create(event->pid, 0);
> > > > +                       if (pidfd < 0)
> > > > +                               pidfd = FAN_EPIDFD;
> > > > +               }
> > > > +       }
> > > > +
> > >
> > > As a general rule, f_op->read callbacks aren't allowed to mess with
> > > the file descriptor table of the calling process. A process should be
> > > able to receive a file descriptor from an untrusted source and call
> > > functions like read() on it without worrying about affecting its own
> > > file descriptor table state with that.
> > >
> >
> > Interesting. I've never considered this interface flaw.
> > Thanks for bringing this up!
>
> Me neither. But I guess it's one more reason why any fd-generating variant
> of fanotify should stay priviledged.
>
> > > I realize that existing fanotify code appears to be violating that
> > > rule already, and that you're limiting creation of fanotify file
> > > descriptors that can hit this codepath to CAP_SYS_ADMIN, but still, I
> > > think fanotify_read() probably ought to be an ioctl, or something
> > > along those lines, instead of an f_op->read handler if it messes with
> > > the caller's fd table?
> >
> > Naturally, we cannot change the legacy interface.
> > However, since fanotify has a modern FAN_REPORT_FID interface
> > which does not mess with fd table maybe this is an opportunity not
> > to repeat the same mistake for the FAN_REPORT_FID interface.
> >
> > Matthew, can you explain what is the use case of the consumer
> > application of pidfd. I am guessing this is for an audit user case?
> > because if it were for permission events, event->pid would have been
> > sufficient.
> >
> > If that is the case, then I presume that the application does not really
> > need to operate on the pidfd, it only need to avoid reporting wrong
> > process details after pid wraparound?
> >
> > If that is the case, then maybe a model similar to inode generation
> > can be used to report a "pid generation" in addition to event->pid
> > and export pid generation in /proc/<pid>/status?
> >
> > Or am I completely misunderstanding the use case?
>
> Well, but pidfd also makes sure that /proc/<pid>/ keeps belonging to the
> same process while you read various data from it. And you cannot achieve
> that with pid+generation thing you've suggested. Plus the additional
> concept and its complexity is non-trivial So I tend to agree with
> Christian that we really want to return pidfd.
>
> Given returning pidfd is CAP_SYS_ADMIN priviledged operation I'm undecided
> whether it is worth the trouble to come up with some other mechanism how to
> return pidfd with the event. We could return some cookie which could be
> then (by some ioctl or so) either transformed into real pidfd or released
> (so that we can release pid handle in the kernel) but it looks ugly and
> complicates things for everybody without bringing significant security
> improvement (we already can pass fd with the event). So I'm pondering
> whether there's some other way how we could make the interface safer - e.g.
> so that the process receiving the event (not the one creating the group)
> would also need to opt in for getting fds created in its file table.
>
> But so far nothing bright has come to my mind. :-|
>

There is a way, it is not bright, but it is pretty simple -
store an optional pid in group->fanotify_data.fd_reader.

With flag FAN_REPORT_PIDFD, both pidfd and event->fd reporting
will be disabled to any process other than fd_reader.
Without FAN_REPORT_PIDFD, event->fd reporting will be disabled
if fd_reaader is set to a process other than the reader.

A process can call ioctl START_FD_READER to set fd_reader to itself.
With FAN_REPORT_PIDFD, if reaader_fd is NULL and the reader
process has CAP_SYS_ADMIN, read() sets fd_reader to itself.

Permission wise, START_FD_READER is allowed with
CAP_SYS_ADMIN or if fd_reader is not owned by another process.
We may consider YIELD_FD_READER ioctl if needed.

I think that this is a pretty cheap price for implementation
and maybe acceptable overhead for complicating the API?
Note that without passing fd, there is no need for any ioctl.

An added security benefit is that the ioctl adds is a way for the
caller of fanotify_init() to make sure that even if the fanotify_fd is
leaked, that event->fd will not be leaked, regardless of flag
FAN_REPORT_PIDFD.

So the START_FD_READER ioctl feature could be implemented
and documented first.
And then FAN_REPORT_PIDFD could use the feature with a
very minor API difference:
- Without the flag, other processes can read fds by default and
  group initiator can opt-out
- With the flag, other processes cannot read fds by default and
  need to opt-in

Thanks,
Amir.
