Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1700543BC0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhJZVJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 17:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239440AbhJZVIu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:08:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E19660C4A;
        Tue, 26 Oct 2021 21:06:24 +0000 (UTC)
Date:   Tue, 26 Oct 2021 23:06:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fs/namespace: Boost the mount_lock.lock owner instead of
 spinning on PREEMPT_RT.
Message-ID: <20211026210621.yeg56reluq2cqrqs@wittgenstein>
References: <20211021220102.bm5bvldjtzsabbfn@linutronix.de>
 <20211025091504.6k7d57awbfpqmmqs@wittgenstein>
 <20211025152218.opvcqfku2lhqvp4o@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025152218.opvcqfku2lhqvp4o@linutronix.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 05:22:18PM +0200, Sebastian Andrzej Siewior wrote:
> The MNT_WRITE_HOLD flag is used to hold back any new writers while the
> mount point is about to be made read-only. __mnt_want_write() then loops
> with disabled preemption until this flag disappears. Callers of
> mnt_hold_writers() (which sets the flag) hold the spinlock_t of
> mount_lock (seqlock_t) which disables preemption on !PREEMPT_RT and
> ensures the task is not scheduled away so that the spinning side spins
> for a long time.
> 
> On PREEMPT_RT the spinlock_t does not disable preemption and so it is
> possible that the task setting MNT_WRITE_HOLD is preempted by task with
> higher priority which then spins infinitely waiting for MNT_WRITE_HOLD
> to get removed.
> 
> Acquire mount_lock::lock which is held by setter of MNT_WRITE_HOLD. This
> will PI-boost the owner and wait until the lock is dropped and which
> means that MNT_WRITE_HOLD is cleared again.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

I'm not an expert in real-time locking but this solution is way less
intrusive and easier to explain and understand than the first version.
Based on how I understand priority inheritance this solution seems good.

The scenario that we seem to mostly worry is:
Let's assume a low-priority task A is holding lock_mount_hash() and
writes MNT_WRITE_HOLD to mnt->mnt_flags. Another high-priority task B is
spinning waiting for MNT_WRITE_HOLD to be cleared.
On rt kernels task A could be scheduled away causing the high-priority
task B to spin for a long time. However, if we force the high-priority
task B to grab lock_mount_hash() we thereby priority boost low-priorty
task A causing it to relinquish the lock quickly preventing task B from
spinning for a long time.

Under the assumption I got this right:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  fs/namespace.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 659a8f39c61af..3ab45b47b2860 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -343,8 +343,24 @@ int __mnt_want_write(struct vfsmount *m)
>  	 * incremented count after it has set MNT_WRITE_HOLD.
>  	 */
>  	smp_mb();
> -	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD)
> -		cpu_relax();
> +	might_lock(&mount_lock.lock);
> +	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +			cpu_relax();

IS_ENABLED will have the same effect as using ifdef, i.e. compiling the
irrelevant branch out, I hope.

> +		} else {
> +			/*
> +			 * This prevents priority inversion, if the task
> +			 * setting MNT_WRITE_HOLD got preempted on a remote
> +			 * CPU, and it prevents life lock if the task setting
> +			 * MNT_WRITE_HOLD has a lower priority and is bound to
> +			 * the same CPU as the task that is spinning here.
> +			 */
> +			preempt_enable();
> +			lock_mount_hash();
> +			unlock_mount_hash();
> +			preempt_disable();
> +		}
> +	}
