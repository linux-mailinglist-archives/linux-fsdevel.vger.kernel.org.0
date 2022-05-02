Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B168517350
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbiEBP4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiEBP4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 11:56:35 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F3362E6;
        Mon,  2 May 2022 08:53:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0C8B0200B; Mon,  2 May 2022 11:53:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0C8B0200B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651506786;
        bh=snDi6YtSWBXTdZ7f66jrxTMf31tWY6I1l9C+UelI4BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UynK4d68ZDN5gnvhLihOYouYBSepokCxNHcAI5JX8Czw3FL9DXqXFMsfiT5OmvlDp
         sPZR+8AhBOgh+ry0w54L7xpf4kT6sEMTFjtjwq/lz+TtfTuzpN/bKOfDUfj9F6aTKm
         K8iv5MpM9uk22uhGtpD5Z2vBK51Jsc0JZRyHv09E=
Date:   Mon, 2 May 2022 11:53:06 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v24 5/7] fs/lock: add 2 callbacks to
 lock_manager_operations to resolve conflict
Message-ID: <20220502155306.GE30550@fieldses.org>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
 <1651426696-15509-6-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651426696-15509-6-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 01, 2022 at 10:38:14AM -0700, Dai Ngo wrote:
> Add 2 new callbacks, lm_lock_expirable and lm_expire_lock, to
> lock_manager_operations to allow the lock manager to take appropriate
> action to resolve the lock conflict if possible.
> 
> A new field, lm_mod_owner, is also added to lock_manager_operations.
> The lm_mod_owner is used by the fs/lock code to make sure the lock
> manager module such as nfsd, is not freed while lock conflict is being
> resolved.
> 
> lm_lock_expirable checks and returns true to indicate that the lock
> conflict can be resolved else return false. This callback must be
> called with the flc_lock held so it can not block.
> 
> lm_expire_lock is called to resolve the lock conflict if the returned
> value from lm_lock_expirable is true. This callback is called without
> the flc_lock held since it's allowed to block. Upon returning from
> this callback, the lock conflict should be resolved and the caller is
> expected to restart the conflict check from the beginnning of the list.
> 
> Lock manager, such as NFSv4 courteous server, uses this callback to
> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> (client that has expired but allowed to maintains its states) that owns
> the lock.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  4 ++++
>  fs/locks.c                            | 45 ++++++++++++++++++++++++++++++++---
>  include/linux/fs.h                    |  3 +++
>  3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index c26d854275a0..0997a258361a 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -428,6 +428,8 @@ prototypes::
>  	void (*lm_break)(struct file_lock *); /* break_lease callback */
>  	int (*lm_change)(struct file_lock **, int);
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +        bool (*lm_lock_expirable)(struct file_lock *);
> +        void (*lm_expire_lock)(void);
>  
>  locking rules:
>  
> @@ -439,6 +441,8 @@ lm_grant:		no		no			no
>  lm_break:		yes		no			no
>  lm_change		yes		no			no
>  lm_breaker_owns_lease:	yes     	no			no
> +lm_lock_expirable	yes		no			no
> +lm_expire_lock		no		no			yes
>  ======================	=============	=================	=========
>  
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index c369841ef7d1..17917da06463 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -902,6 +902,9 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>  	struct file_lock *cfl;
>  	struct file_lock_context *ctx;
>  	struct inode *inode = locks_inode(filp);
> +	void *owner;
> +	bool ret;
> +	void (*func)(void);
>  
>  	ctx = smp_load_acquire(&inode->i_flctx);
>  	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> @@ -909,12 +912,28 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>  		return;
>  	}
>  
> +retry:
>  	spin_lock(&ctx->flc_lock);
>  	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> -		if (posix_locks_conflict(fl, cfl)) {
> -			locks_copy_conflock(fl, cfl);
> -			goto out;
> +		if (!posix_locks_conflict(fl, cfl))
> +			continue;
> +		if (cfl->fl_lmops && cfl->fl_lmops->lm_mod_owner &&
> +				cfl->fl_lmops->lm_lock_expirable &&
> +				cfl->fl_lmops->lm_expire_lock) {
> +			ret = (*cfl->fl_lmops->lm_lock_expirable)(cfl);
> +			if (!ret)
> +				goto conflict;
> +			owner = cfl->fl_lmops->lm_mod_owner;
> +			func = cfl->fl_lmops->lm_expire_lock;
> +			__module_get(owner);
> +			spin_unlock(&ctx->flc_lock);
> +			(*func)();
> +			module_put(owner);
> +			goto retry;
>  		}
> +conflict:
> +		locks_copy_conflock(fl, cfl);
> +		goto out;
>  	}
>  	fl->fl_type = F_UNLCK;
>  out:
> @@ -1088,6 +1107,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  	int error;
>  	bool added = false;
>  	LIST_HEAD(dispose);
> +	void *owner;
> +	bool ret;
> +	void (*func)(void);
>  
>  	ctx = locks_get_lock_context(inode, request->fl_type);
>  	if (!ctx)
> @@ -1106,6 +1128,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		new_fl2 = locks_alloc_lock();
>  	}
>  
> +retry:
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
>  	/*
> @@ -1117,6 +1140,22 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>  			if (!posix_locks_conflict(request, fl))
>  				continue;
> +			if (fl->fl_lmops && fl->fl_lmops->lm_mod_owner &&

The check for lm_mod_owner isn't necessary.

> +					fl->fl_lmops->lm_lock_expirable &&
> +					fl->fl_lmops->lm_expire_lock) {

Let's also drop the check for lm_expire_lock.  Any lock manager defining
one of those methods must define the other.

> +				ret = (*fl->fl_lmops->lm_lock_expirable)(fl);
> +				if (!ret)
> +					goto conflict;

So, I would make this:

			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
				&& fl->fl_lmops->lm_lock_expirable(fl))

and leave out the "conflict" goto.

With that change, feel free to add

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>

--b.

> +				owner = fl->fl_lmops->lm_mod_owner;
> +				func = fl->fl_lmops->lm_expire_lock;
> +				__module_get(owner);
> +				spin_unlock(&ctx->flc_lock);
> +				percpu_up_read(&file_rwsem);
> +				(*func)();
> +				module_put(owner);
> +				goto retry;
> +			}
> +conflict:
>  			if (conflock)
>  				locks_copy_conflock(conflock, fl);
>  			error = -EAGAIN;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b8ed7f974fb4..aa6c1bbdb8c4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1029,6 +1029,7 @@ struct file_lock_operations {
>  };
>  
>  struct lock_manager_operations {
> +	void *lm_mod_owner;
>  	fl_owner_t (*lm_get_owner)(fl_owner_t);
>  	void (*lm_put_owner)(fl_owner_t);
>  	void (*lm_notify)(struct file_lock *);	/* unblock callback */
> @@ -1037,6 +1038,8 @@ struct lock_manager_operations {
>  	int (*lm_change)(struct file_lock *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lock *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_expirable)(struct file_lock *cfl);
> +	void (*lm_expire_lock)(void);
>  };
>  
>  struct lock_manager {
> -- 
> 2.9.5
