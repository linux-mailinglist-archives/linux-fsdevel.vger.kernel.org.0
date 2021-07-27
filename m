Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446B83D6DD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 07:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhG0FK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 01:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbhG0FK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:10:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791A2C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 22:10:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b1-20020a17090a8001b029017700de3903so1964267pjn.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 22:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wnweKz/Ottn5ayrcDC1y6YrOG1Hz+EnZc7Xat9fmnNs=;
        b=i3tiMRvRtJVwI7ib/eHYW7TuIEAFPAyY0vqnYPhXcNhlZIhzKiVG7un2aaHE6RnoX3
         u7S0DLqrxk23zwgxwlG2NZPQZwYtYRhhMw5GLPjqkTb4Qf1WXhaV6OLiU3R4aRKLGcV9
         gT8Ute80w4kFwJ6QnrNAiXpvFPukFPwqyGpHJkz+wiFfvWVOE7c7kbHTM7iZ6a/bBwuy
         hfloGazVLP1x3WIJRXEOE7SDCBOZBDGjOxqA0G5DHkdKFT/7DdWCX2w0T5T3qeJRNeUI
         tTL+yCvABFODUVqgLe3oIcmgp4idmUOj+NgI+AVBSQYFDSI5lVwULfW+gpC4rVzxlDI3
         oskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wnweKz/Ottn5ayrcDC1y6YrOG1Hz+EnZc7Xat9fmnNs=;
        b=eiinwyqIkQIOsjAhHaG3r/q/hb2MVYLgfgEzz3XCe097MJlzy/ADb3FL9ELA6lSApb
         /GQM9GOe9qh51jtXi2obfnbs8S1p5+I3lqWRbFjilkZYOVjA7K7ap4LVi9Zirz+pYGxg
         IuI/9EXURl14WcCMyxKa+HHxPYKrX0mKNAU0BNndVubkEk0sRLfWGSAkJj0slh770Dm1
         xuFJrbz5WO2He6Be6JmHc08QqzbokoS02CXrqV1v3nITObu8AxwQjWXAATyQQo9JE42O
         vEzXgSSUtELzlWUIoDlEIK/82SO3yaez88lmi5gYj6crS/gSBGAp1CFgAHgpizTT11Et
         1VHg==
X-Gm-Message-State: AOAM531LmIqjjhK0RfbSGpJi02fXfoy6McRxj7PH8SYVSkrbD20HQ3dV
        r6VvjehHL+hbQboNPYBhgedOeQ==
X-Google-Smtp-Source: ABdhPJzkjr06ED4Psbz9ieknzLJM96sOyoxfBFKJhtd65Vi4OvScGtK0PBVO/v4n4k8M9Yts4bduKA==
X-Received: by 2002:a63:5425:: with SMTP id i37mr21412077pgb.234.1627362626801;
        Mon, 26 Jul 2021 22:10:26 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c253:e6ea:83ee:c870])
        by smtp.gmail.com with ESMTPSA id f3sm1893958pfk.206.2021.07.26.22.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:10:25 -0700 (PDT)
Date:   Tue, 27 Jul 2021 15:10:13 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YP+VNZt2y+jP3BNR@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 07:19:43AM +0300, Amir Goldstein wrote:
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
> 
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

You mean the FAN_REPORT_PIDFD interface, right?

> Matthew, can you explain what is the use case of the consumer
> application of pidfd. I am guessing this is for an audit user case?
> because if it were for permission events, event->pid would have been
> sufficient.

Yes, the primary use case would be for reliable auditing i.e. what actual
process had accessed what filesystem object of interest. Generally, finding
what process is a little unreliable at the moment given that the reporting
event->pid and crawling through /proc based on that has been observed to
lead to certain inaccuracy in the past i.e. reporting an access that was in
fact not performed by event->pid.

The permission model doesn't work in this case given that it takes the
"blocking" approach and not it's not something that can always be
afforded...

> If that is the case, then I presume that the application does not really
> need to operate on the pidfd, it only need to avoid reporting wrong
> process details after pid wraparound?

The idea is that the event listener, or receiver will use the
pidfd_send_signal(2) and specify event->info->pidfd as one of its arguments
in order to _reliably_ determine whether the process that generated the
event is still around. If so, it can freely ascertain further contextual
information from /proc reliably.

> If that is the case, then maybe a model similar to inode generation
> can be used to report a "pid generation" in addition to event->pid
> and export pid generation in /proc/<pid>/status?

TBH, I don't fully understand what you mean by this model...

/M
