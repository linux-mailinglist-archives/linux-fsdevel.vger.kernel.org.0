Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393DC179052
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 13:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgCDM0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 07:26:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387919AbgCDM0L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:26:11 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157422146E;
        Wed,  4 Mar 2020 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583324770;
        bh=Schwq0Exu/YFnqdajuZIF0iUkVHTdZxrxvRFFIH4D0c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UpMWQaVrQb1Ty19BpWLKKvBS+4Tcjz40/eTJPFOvLa5U/Cd9weUU3tEiWZXZ2ph1D
         6MBY6QwjrNVTvynHamL4M4q/G8ECaoyuN+rJaEeW7UGIGhFMehe7kz9dwi2wPHwJ8F
         RBXIA1T0+R44ROHRYLB3tRFWw6meL2kRiJ9rOR1s=
Message-ID: <c542702fd57606ee4874d632364303558ec33220.camel@kernel.org>
Subject: Re: [PATCH] locks: fix a potential use-after-free problem when
 wakeup a waiter
From:   Jeff Layton <jlayton@kernel.org>
To:     yangerkun <yangerkun@huawei.com>, viro@zeniv.linux.org.uk,
        neilb@suse.com
Cc:     linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com
Date:   Wed, 04 Mar 2020 07:26:08 -0500
In-Reply-To: <20200304072556.2762-1-yangerkun@huawei.com>
References: <20200304072556.2762-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-03-04 at 15:25 +0800, yangerkun wrote:
> '16306a61d3b7 ("fs/locks: always delete_block after waiting.")' add the
> logic to check waiter->fl_blocker without blocked_lock_lock. And it will
> trigger a UAF when we try to wakeup some waiter：
> 
> Thread 1 has create a write flock a on file, and now thread 2 try to
> unlock and delete flock a, thread 3 try to add flock b on the same file.
> 
> Thread2                         Thread3
>                                 flock syscall(create flock b)
> 	                        ...flock_lock_inode_wait
> 				    flock_lock_inode(will insert
> 				    our fl_blocked_member list
> 				    to flock a's fl_blocked_requests)
> 				   sleep
> flock syscall(unlock)
> ...flock_lock_inode_wait
>     locks_delete_lock_ctx
>     ...__locks_wake_up_blocks
>         __locks_delete_blocks(
> 	b->fl_blocker = NULL)
> 	...
>                                    break by a signal
> 				   locks_delete_block
> 				    b->fl_blocker == NULL &&
> 				    list_empty(&b->fl_blocked_requests)
> 	                            success, return directly
> 				 locks_free_lock b
> 	wake_up(&b->fl_waiter)
> 	trigger UAF
> 
> Fix it by remove this logic, and this patch may also fix CVE-2019-19769.
> 
> Fixes: 16306a61d3b7 ("fs/locks: always delete_block after waiting.")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/locks.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 44b6da032842..426b55d333d5 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -753,20 +753,6 @@ int locks_delete_block(struct file_lock *waiter)
>  {
>  	int status = -ENOENT;
>  
> -	/*
> -	 * If fl_blocker is NULL, it won't be set again as this thread
> -	 * "owns" the lock and is the only one that might try to claim
> -	 * the lock.  So it is safe to test fl_blocker locklessly.
> -	 * Also if fl_blocker is NULL, this waiter is not listed on
> -	 * fl_blocked_requests for some lock, so no other request can
> -	 * be added to the list of fl_blocked_requests for this
> -	 * request.  So if fl_blocker is NULL, it is safe to
> -	 * locklessly check if fl_blocked_requests is empty.  If both
> -	 * of these checks succeed, there is no need to take the lock.
> -	 */
> -	if (waiter->fl_blocker == NULL &&
> -	    list_empty(&waiter->fl_blocked_requests))
> -		return status;
>  	spin_lock(&blocked_lock_lock);
>  	if (waiter->fl_blocker)
>  		status = 0;

Well spotted, but is this sufficient to fix the issue?

If Thread2 gets scheduled off before the wake_up but after removing the
block, then it seems like it could hit the same problem regardless of
whether you took the spinlock or not in that codepath.

The core problem seems to be that we don't have any guarantee that
waiter "b" will still be around once the spinlock has been dropped in
the unlock codepath.

-- 
Jeff Layton <jlayton@kernel.org>

