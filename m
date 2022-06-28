Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9DE55E68B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbiF1Phn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347917AbiF1PhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:37:04 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0228E3525E;
        Tue, 28 Jun 2022 08:37:00 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id j6so12436820vsi.0;
        Tue, 28 Jun 2022 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8C38ywPu4/ShgK2nrzOsytyZdNLWmF+NjvMeDKthJy4=;
        b=fJI3SM/rhvuBg9fZy4agGCrD5JKsFevoDjzgrzlDRuktpJ3P48SWT9lOXUni2pYtdg
         mUUhdYbSSDtvLPO95Ymy2618MM0nLrNGTcGBTtWt2R98tvpOPQkeARAMhjzsQr88GtLv
         hZ6Lz/Vj6H6vGCUX1sbrjBi2sYiIsdpxQoR50hugR0sVSKjPGySeti+voCF1etgm3lGC
         n/R9gDvyiPdDwrJNjEroQNZq5ZqGY+t79VEZD2dTVY+Lv2Py5x9DjSA730WwneFDCnwr
         TdwYliEeq3WEkxuj3pAPCs7LFS8iSn7FGwiL9MR9577hD8Q4vOArcwKNzYCI3AMd2ESy
         0zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8C38ywPu4/ShgK2nrzOsytyZdNLWmF+NjvMeDKthJy4=;
        b=M3nPzqSw+FmGUmdXf4EiUG/QhzZ3vnbSR0MffTiUgu/G0/hJJ/IzLYmNgnN3bKgc4i
         E8BIqeiRZzLuFXDDzior1i4SHO6cBsiMHg6b1a8BOCI+R1TbSX5QEe2+v8XfHy6Gv6ww
         gxe9Pra8LEluuXTmNE/suTs5mja1I0i/mTnQKl7fcuWVzqFPfQMNqhkFXRoFsHVl6yIa
         QrKmjVSNLoDSJsv0hiyQtA1c9USguJQ9eUq60HU6OggJ/fUqtoYDBW0YQHiAdaBw1TBc
         +Sm3x2AGEEhBXAM918M6l+8Fxb9XwDOVdjGIAgufhSkmeJN+nHqtbD1avu/a3PSZd3lE
         4kCg==
X-Gm-Message-State: AJIora8ZcwJE4XkgLMr393VjUfzaMQmbwfUW+57v3WLHFADnpJO2bKm1
        vdA603NOCK9E1Regr07/A8X/rc1h8BBy0ORivuU=
X-Google-Smtp-Source: AGRyM1tUipRI64aGOXEQIaIPnub1xqJ4ECXWtnxh9RFrkDcVAspm9IKurjUu1d/LETtMdfIaQOl6m8keaghiB7n+a+Y=
X-Received: by 2002:a67:fa01:0:b0:354:3136:c62e with SMTP id
 i1-20020a67fa01000000b003543136c62emr1839365vsq.2.1656430619398; Tue, 28 Jun
 2022 08:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220628101413.10432-1-duguoweisz@gmail.com> <20220628104528.no4jarh2ihm5gxau@quack3>
 <20220628104853.c3gcsvabqv2zzckd@wittgenstein> <CAC+1NxtAfbKOcW1hykyygScJgN7DsPKxLeuqNNZXLqekHgsG=Q@mail.gmail.com>
 <CAOQ4uxgtZDihnydqZ04wjm2XCYjui0nnkO0VGzyq-+ERW20pJw@mail.gmail.com>
 <20220628125617.pljcpsr2xkzrrpxr@quack3> <CAOQ4uxjbKgEoRM4DXBq0T3-jP96FCHjUY0PLsqVE0_s-hS3xLg@mail.gmail.com>
 <20220628142532.rinam6psfflxkimv@wittgenstein>
In-Reply-To: <20220628142532.rinam6psfflxkimv@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jun 2022 18:36:47 +0300
Message-ID: <CAOQ4uxjfPy_q9ETH_Jvu9WvVewj4bottXMXGgM9UQ9MnS6u7aA@mail.gmail.com>
Subject: Re: [PATCH 6/6] fanotify: add current_user_instances node
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, guowei du <duguoweisz@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duguowei <duguowei@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 5:25 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 04:55:25PM +0300, Amir Goldstein wrote:
> > On Tue, Jun 28, 2022 at 3:56 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 28-06-22 15:29:08, Amir Goldstein wrote:
> > > > On Tue, Jun 28, 2022 at 2:50 PM guowei du <duguoweisz@gmail.com> wrote:
> > > > >
> > > > > hi, Mr Kara, Mr Brauner,
> > > > >
> > > > > I want to know how many fanotify readers are monitoring the fs event.
> > > > > If userspace daemons monitoring all file system events are too many, maybe there will be an impact on performance.
> > > >
> > > > I want something else which is more than just the number of groups.
> > > >
> > > > I want to provide the admin the option to enumerate over all groups and
> > > > list their marks and blocked events.
> > >
> > > Listing all groups and marks makes sense to me. Often enough I was
> > > extracting this information from a crashdump :).
> > >
> > > Dumping of events may be a bit more challenging (especially as we'd need to
> > > format the events which has some non-trivial implications) so I'm not 100%
> > > convinced about that. I agree it might be useful but I'd have to see the
> > > implementation...
> > >
> >
> > I don't really care about the events.
> > I would like to list the tasks that are blocked on permission events
> > and the fanotify reader process that blocks them, so that it could be killed.
> >
> > Technically, it is enough to list the blocked task pids in fanotify_fdinfo().
> > But it is also low hanging to print the number of queued events
> > in fanotify_fdinfo() and inotify_fdinfo().
>
> That's always going to be racy, right? You might list the blocked tasks
> but it's impossible for userspace to ensure that the pids it parses
> still refer to the same processes by the time it tries to kill them.
>
> You would need an interface that allows you to kill specific blocked
> tasks or at least all blocked tasks. You could just make this an - ahem
> - ioctl on a suitable fanotify fd and somehow ensure that the task is
> actually the one you want to kill?

I don't want to kill the blocked tasks
I want to kill the permission event reader process that is blocking them
or abort the blocking group without terminating the process in some
technique similar to fuse connection abort.

It is an emergency button for admin when all users get blocked
from accessing files.

The problem with mandatory locks IMO was not the fact that they
could be used to DoS other users, but the fact that there was no
escape door for admin override.

Windows servers have mandatory file locks, but they also have
an escape door for admin override:
https://www.technipages.com/windows-how-to-release-file-lock.

fanotify could be used to DoS users and admin has no
good tools to cope with that now.

>
> If you can avoid adding a whole new /sys/kernel/fanotify/ interface
> that'd be quite nice for userspace, I think.

On the contrary. I think that user will like enumerating the groups
in /sys/kernel/fanotify/ better then enumerating all fds of all procs
looking for fanotify fds - the lsof method is not efficient and not
scalable when you have many thousands of tasks and just one blocker.

w.r.t races, it is possible that /sys/kernel/fanotify/ could be used
to acquire some sort of fanotify fd clones that can only be used for
ioctls and not for read/write.

An ioctl can return the number of blocked tasks and possibly
their pidfd's for further inspection.

And of course an ABORT or SHUTDOWN ioctl to cancel all
blocked permission events and stop queueing events.

The same fd clone could also be acquired by opening
/proc/<fanotify_proc>/fd/<fanotify_fd>
to perform ABORT in case killing the process does not
work because the process itself is blocked on IO.

Current fanotify is not immune against this sort of deadlocks
similar deadlocks are described in FUSE documentation
in the section explaining about connection abort:
https://www.kernel.org/doc/html/latest/filesystems/fuse.html#aborting-a-filesystem-connection

Thanks,
Amir.
