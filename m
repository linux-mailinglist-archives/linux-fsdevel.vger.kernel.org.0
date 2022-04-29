Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8E514F06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378246AbiD2PTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiD2PTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:19:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E7D240A1;
        Fri, 29 Apr 2022 08:16:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A8B168B1; Fri, 29 Apr 2022 11:16:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A8B168B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651245378;
        bh=30AGXwEw1Pc3Zxe7+OVYS0kG7UCtnbqt/4JKSHukKOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiE1KyrIPvz5swuYaIeKNGJlBtF88Lpk5SzxT6YCgVPM4fkHHl0MqYHU+boe+3z3H
         3gHw7nHVYHxuoptR7gunpfjxZsC5kVgbx5ko6VK8MLcxOZR0Rp4jS361D+64bgUpIv
         /kLCQJhoV5XwGJpvxWt3MHalGe9uGKDPsyvkj5rI=
Date:   Fri, 29 Apr 2022 11:16:18 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v23 5/7] fs/lock: add 2 callbacks to
 lock_manager_operations to resolve conflict
Message-ID: <20220429151618.GF7107@fieldses.org>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-6-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651129595-6904-6-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:06:33AM -0700, Dai Ngo wrote:
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
>  fs/locks.c                            | 45 +++++++++++++++++++++++++++++++----
>  include/linux/fs.h                    |  3 +++
>  3 files changed, 48 insertions(+), 4 deletions(-)
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
> index c369841ef7d1..d48c3f455657 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -896,6 +896,37 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
>  	return locks_conflict(caller_fl, sys_fl);
>  }
>  
> +static bool
> +resolve_lock_conflict_locked(struct file_lock_context *ctx,
> +			struct file_lock *cfl, bool rwsem)
> +{
> +	void *owner;
> +	bool ret;
> +	void (*func)(void);
> +
> +	if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable &&
> +				cfl->fl_lmops->lm_expire_lock) {
> +		ret = (*cfl->fl_lmops->lm_lock_expirable)(cfl);
> +		if (!ret)
> +			return false;
> +		owner = cfl->fl_lmops->lm_mod_owner;
> +		if (!owner)
> +			return false;
> +		func = cfl->fl_lmops->lm_expire_lock;
> +		__module_get(owner);
> +		if (rwsem)
> +			percpu_up_read(&file_rwsem);
> +		spin_unlock(&ctx->flc_lock);

Dropping and reacquiring locks inside a function like this makes me
nervous.  It means it's not obvious in the caller that the lock isn't
held throughout.

I know it's more verbose, but let's just open-code this logic in the
callers.

(And, thanks for catching the test_lock case, I'd forgotten it.)

Also: do we *really* need to drop the file_rwsem?  Were you seeing it
that cause problems?  The only possible conflict is with someone trying
to read /proc/locks, and I'm surprised that it'd be a problem to let
them wait here.

--b.

> +		(*func)();
> +		module_put(owner);
> +		if (rwsem)
> +			percpu_down_read(&file_rwsem);
> +		spin_lock(&ctx->flc_lock);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  void
>  posix_test_lock(struct file *filp, struct file_lock *fl)
>  {
> @@ -910,11 +941,14 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>  	}
>  
>  	spin_lock(&ctx->flc_lock);
> +retry:
>  	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> -		if (posix_locks_conflict(fl, cfl)) {
> -			locks_copy_conflock(fl, cfl);
> -			goto out;
> -		}
> +		if (!posix_locks_conflict(fl, cfl))
> +			continue;
> +		if (resolve_lock_conflict_locked(ctx, cfl, false))
> +			goto retry;
> +		locks_copy_conflock(fl, cfl);
> +		goto out;
>  	}
>  	fl->fl_type = F_UNLCK;
>  out:
> @@ -1108,6 +1142,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
> +retry:
>  	/*
>  	 * New lock request. Walk all POSIX locks and look for conflicts. If
>  	 * there are any, either return error or put the request on the
> @@ -1117,6 +1152,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>  			if (!posix_locks_conflict(request, fl))
>  				continue;
> +			if (resolve_lock_conflict_locked(ctx, fl, true))
> +				goto retry;
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
