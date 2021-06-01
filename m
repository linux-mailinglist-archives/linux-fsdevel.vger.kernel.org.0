Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91423972BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 13:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhFALsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 07:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233657AbhFALsO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E77F2610A0;
        Tue,  1 Jun 2021 11:46:31 +0000 (UTC)
Date:   Tue, 1 Jun 2021 13:46:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <20210601114628.f3w33yyca5twgfho@wittgenstein>
References: <cover.1621473846.git.repnop@google.com>
 <20210520135527.GD18952@quack2.suse.cz>
 <YKeIR+LiSXqUHL8Q@google.com>
 <20210521104056.GG18952@quack2.suse.cz>
 <YKhDFCUWX7iU7AzM@google.com>
 <20210524084746.GB32705@quack2.suse.cz>
 <20210525103133.uctijrnffehlvjr3@wittgenstein>
 <YK2GV7hLamMpcO8i@google.com>
 <20210526180529.egrtfruccbioe7az@wittgenstein>
 <YLYT/oeBCcnbfMzE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLYT/oeBCcnbfMzE@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:03:26PM +1000, Matthew Bobrowski wrote:
> On Wed, May 26, 2021 at 08:05:29PM +0200, Christian Brauner wrote:
> > On Wed, May 26, 2021 at 09:20:55AM +1000, Matthew Bobrowski wrote:
> > > On Tue, May 25, 2021 at 12:31:33PM +0200, Christian Brauner wrote:
> > > > On Mon, May 24, 2021 at 10:47:46AM +0200, Jan Kara wrote:
> > > > > On Sat 22-05-21 09:32:36, Matthew Bobrowski wrote:
> > > > > > On Fri, May 21, 2021 at 12:40:56PM +0200, Jan Kara wrote:
> > > > > > > On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> > > > > > > > On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > > > > > > > There's one thing that I'd like to mention, and it's something in
> > > > > > > > regards to the overall approach we've taken that I'm not particularly
> > > > > > > > happy about and I'd like to hear all your thoughts. Basically, with
> > > > > > > > this approach the pidfd creation is done only once an event has been
> > > > > > > > queued and the notification worker wakes up and picks up the event
> > > > > > > > from the queue processes it. There's a subtle latency introduced when
> > > > > > > > taking such an approach which at times leads to pidfd creation
> > > > > > > > failures. As in, by the time pidfd_create() is called the struct pid
> > > > > > > > has already been reaped, which then results in FAN_NOPIDFD being
> > > > > > > > returned in the pidfd info record.
> > > > > > > > 
> > > > > > > > Having said that, I'm wondering what the thoughts are on doing pidfd
> > > > > > > > creation earlier on i.e. in the event allocation stages? This way, the
> > > > > > > > struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> > > > > > > > returned in the pidfd info record because the struct pid has been
> > > > > > > > already reaped, userspace application will atleast receive a valid
> > > > > > > > pidfd which can be used to check whether the process still exists or
> > > > > > > > not. I think it'll just set the expectation better from an API
> > > > > > > > perspective.
> > > > > > > 
> > > > > > > Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
> > > > > > > be sure the original process doesn't exist anymore. So is it useful to
> > > > > > > still receive pidfd of the dead process?
> > > > > > 
> > > > > > Well, you're absolutely right. However, FWIW I was approaching this
> > > > > > from two different angles:
> > > > > > 
> > > > > > 1) I wanted to keep the pattern in which the listener checks for the
> > > > > >    existence/recycling of the process consistent. As in, the listener
> > > > > >    would receive the pidfd, then send the pidfd a signal via
> > > > > >    pidfd_send_signal() and check for -ESRCH which clearly indicates
> > > > > >    that the target process has terminated.
> > > > > > 
> > > > > > 2) I didn't want to mask failed pidfd creation because of early
> > > > > >    process termination and other possible failures behind a single
> > > > > >    FAN_NOPIDFD. IOW, if we take the -ESRCH approach above, the
> > > > > >    listener can take clear corrective branches as what's to be done
> > > > > >    next if a race is to have been detected, whereas simply returning
> > > > > >    FAN_NOPIDFD at this stage can mean multiple things.
> > > > > > 
> > > > > > Now that I've written the above and keeping in mind that we'd like to
> > > > > > refrain from doing anything in the event allocation stages, perhaps we
> > > > > > could introduce a different error code for detecting early process
> > > > > > termination while attempting to construct the info record. WDYT?
> > > > > 
> > > > > Sure, I wouldn't like to overengineer it but having one special fd value for
> > > > > "process doesn't exist anymore" and another for general "creating pidfd
> > > > > failed" looks OK to me.
> > > > 
> > > > FAN_EPIDFD -> "creation failed"
> > > > FAN_NOPIDFD -> "no such process"
> > > 
> > > Yes, I was thinking something along the lines of this...
> > > 
> > > With the approach that I've proposed in this series, the pidfd
> > > creation failure trips up in pidfd_create() at the following
> > > condition:
> > > 
> > > 	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > > 	   	 return -EINVAL;
> > > 
> > > Specifically, the following check:
> > > 	!pid_has_task(pid, PIDTYPE_TGID)
> > > 
> > > In order to properly report either FAN_NOPIDFD/FAN_EPIDFD to
> > > userspace, AFAIK I'll have to do one of either two things to better
> > > distinguish between why the pidfd creation had failed:
> > 
> > Ok, I see. You already do have a reference to a struct pid and in that
> > case we should just always return a pidfd to the caller. For
> > pidfd_open() for example we only report an error when
> > find_get_pid(<pidnr>) doesn't find a struct pid to refer to. But in your
> > case here you already have a struct pid so I think we should just keep
> > this simple and always return a pidfd to the caller and in fact do
> > burden them with figuring out that the process is gone via
> > pidfd_send_signal() instead of complicating our lives here.
> 
> Ah, actually Christian... Before, I go ahead and send through the updated
> series. Given what you've mentioned above I'm working with the assumption
> that you're OK with dropping the pid_has_task() check from pidfd_create()
> [0]. Is that right?
> 
> If so, I don't know how I feel about this given that pidfd_create() is now
> to be exposed to the rest of the kernel and the pidfd API, as it stands,
> doesn't support the creation of pidfds for non-thread-group leaders. I
> suppose what I don't want is other kernel subsystems, if any, thinking it's
> OK to call pidfd_create() with an arbitrary struct pid and setting the
> expectation that a fully functional pidfd will be returned.
> 
> The way I see it, I think we've got two options here:
> 
> 1) Leave the pid_has_task() check within pidfd_create() and perform another
>    explicit pid_has_task() check from the fanotify code before calling
>    pidfd_create(). If it returns false, we set something like FAN_NOPIDFD
>    indicating to userspace that there's no such process when the event was
>    created.
> 
> 2) Scrap using pidfd_create() all together and implement a fanotify
>    specific pidfd creation wrapper which would allow for more
>    control. Something along the lines of what you've done in kernel/fork.c
>    [1]. Not the biggest fan of this idea just yet given the possibility of
>    it leading to an API drift over time.
> 
> WDYT?

Hm, why would you have to drop the pid_has_task() check again?
