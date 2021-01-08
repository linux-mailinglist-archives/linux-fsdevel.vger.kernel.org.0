Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B815D2EED8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 07:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhAHGrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 01:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHGrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:47:24 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4BC0612F4;
        Thu,  7 Jan 2021 22:46:44 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxlXj-008GYs-26; Fri, 08 Jan 2021 06:46:39 +0000
Date:   Fri, 8 Jan 2021 06:46:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
Message-ID: <20210108064639.GN3579531@ZenIV.linux.org.uk>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <20210108052651.GM3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108052651.GM3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 05:26:51AM +0000, Al Viro wrote:
> On Tue, Jan 05, 2021 at 11:29:11AM -0700, Jens Axboe wrote:
> > Song reported a boot regression in a kvm image with 5.11-rc, and bisected
> > it down to the below patch. Debugging this issue, turns out that the boot
> > stalled when a task is waiting on a pipe being released. As we no longer
> > run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
> > task goes idle without running the task_work. This prevents ->release()
> > from being called on the pipe, which another boot task is waiting on.
> > 
> > Use TWA_SIGNAL for the file fput work to ensure it's run before the task
> > goes idle.
> > 
> > Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
> > Reported-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > ---
> > 
> > The other alternative here is obviously to re-instate the:
> > 
> > if (unlikely(current->task_works))
> > 	task_work_run();
> > 
> > in get_signal() that we had before this change. Might be safer in case
> > there are other cases that need to ensure the work is run in a timely
> > fashion, though I do think it's cleaner to long term to correctly mark
> > task_work with the needed notification type. Comments welcome...
> 
> Interesting...  I think I've missed the discussion of that thing; could
> you forward the relevant thread my way or give an archive link to it?

Actually, why do we need TWA_RESUME at all?  OK, a while ago you've added
a way for task_work_add() to do wake_up_signal().  Fine, so if the sucker
had been asleep in get_signal(), it gets woken up and the work gets run
fast.  Irrelevant for those who did task_work_add() for themselves.
With that commit, though, you've suddenly changed the default behaviour -
now if you do that task_work_add() for current *and* get asleep in
get_signal(), task_work_add() gets delayed - potentially for a very
long time.

Now the default (TWA_RESUME) has changed semantics; matter of fact,
TWA_SIGNAL seems to be a lot closer than what we used to have.  I'm
too sleepy right now to check if there are valid usecases for your
new TWA_RESUME behaviour, but I very much doubt that old callers
(before the TWA_RESUME/TWA_SIGNAL split) want that.

In particular, for mntput_no_expire() we definitely do *not* want
that, same as with fput().  Same, AFAICS, for YAMA report_access().
And for binder_deferred_fd_close().  And task_tick_numa() looks
that way as well...

Anyway, bedtime for me; right now it looks like at least for task == current
we always want TWA_SIGNAL.  I'll look into that more tomorrow when I get
up, but so far it smells like switching everything to TWA_SIGNAL would
be the right thing to do, if not going back to bool notify for
task_work_add()...
