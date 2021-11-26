Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9660545EF35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbhKZNgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 08:36:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42384 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbhKZNet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:34:49 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 08:34:49 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7086DB827E0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Nov 2021 13:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E44C93056;
        Fri, 26 Nov 2021 13:24:17 +0000 (UTC)
Date:   Fri, 26 Nov 2021 14:24:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST] fs/namespace: Boost the mount_lock.lock owner
 instead of spinning on PREEMPT_RT.
Message-ID: <20211126132414.aunpl5gfbju6ajtn@wittgenstein>
References: <20211125120711.dgbsienyrsxfzpoi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211125120711.dgbsienyrsxfzpoi@linutronix.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 01:07:11PM +0100, Sebastian Andrzej Siewior wrote:
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
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Link: https://lore.kernel.org/r/20211025152218.opvcqfku2lhqvp4o@linutronix.de
> ---

I thought you'd carry this in -rt, Sebastian and Thomas. So I've picked
this up and moved this into -next as we want it there soon so it can sit
there for as long as possible. I'll drop it if Al objects to the patch
or prefers to carry it.

Christian

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
>  	/*
>  	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
>  	 * be set to match its requirements. So we must not load that until
> -- 
> 2.34.0
> 
