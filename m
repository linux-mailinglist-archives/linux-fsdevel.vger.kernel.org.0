Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26E2520327
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 19:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiEIRHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbiEIRHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 13:07:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC12CF2B7;
        Mon,  9 May 2022 10:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49263B8180C;
        Mon,  9 May 2022 17:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5F2C385AC;
        Mon,  9 May 2022 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652115826;
        bh=wJyU7wzo3CjszPD4qTi073iXFb+N1T6arHrKfPQzC1g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pRepy3IQHjeEuFMQyr+J1XJneQucc4nBnAPA2T+2qP3zb6evpLtLMeuhAk4tK8tvH
         xOPu8O/1RTpmtQYyV1qBlpke6mU+ndb9qyXtSs5ykm+UCh8RCNfH/vDJDqIeye6z7h
         ROFbSB6FejOmVPJ75zuK28meUJ6fTS4uGcfhGVv+tsupgOF/xQroV7W7yhfZaIBj6K
         94CTU1St9Dwxxbws8TO/d2yWbrojKIKuUIByLqhNDdnWQR70FLgS4LfWFFKe9s2F38
         7H0VzR/Gf1yZShQugzuoWqX6C/4xYjPRI1OyUt6apzQXDaSa2uTOPDpJfAfkPIuYlW
         5g7RyZmAb+vAQ==
Message-ID: <a6f58f452568f46cb2782ca7946f72ac1dc79f83.camel@kernel.org>
Subject: Re: [PATCH RFC v25 5/7] fs/lock: add 2 callbacks to
 lock_manager_operations to resolve conflict
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 09 May 2022 13:03:44 -0400
In-Reply-To: <1651526367-1522-6-git-send-email-dai.ngo@oracle.com>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
         <1651526367-1522-6-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-02 at 14:19 -0700, Dai Ngo wrote:
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
> Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  4 ++++
>  fs/locks.c                            | 33 ++++++++++++++++++++++++++++++---
>  include/linux/fs.h                    |  3 +++
>  3 files changed, 37 insertions(+), 3 deletions(-)
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
> index c369841ef7d1..ca28e0e50e56 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -902,6 +902,8 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>  	struct file_lock *cfl;
>  	struct file_lock_context *ctx;
>  	struct inode *inode = locks_inode(filp);
> +	void *owner;
> +	void (*func)(void);
>  
>  	ctx = smp_load_acquire(&inode->i_flctx);
>  	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> @@ -909,12 +911,23 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
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
> +		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
> +			&& (*cfl->fl_lmops->lm_lock_expirable)(cfl)) {
> +			owner = cfl->fl_lmops->lm_mod_owner;
> +			func = cfl->fl_lmops->lm_expire_lock;
> +			__module_get(owner);
> +			spin_unlock(&ctx->flc_lock);
> +			(*func)();
> +			module_put(owner);
> +			goto retry;
>  		}
> +		locks_copy_conflock(fl, cfl);
> +		goto out;
>  	}
>  	fl->fl_type = F_UNLCK;
>  out:
> @@ -1088,6 +1101,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  	int error;
>  	bool added = false;
>  	LIST_HEAD(dispose);
> +	void *owner;
> +	void (*func)(void);
>  
>  	ctx = locks_get_lock_context(inode, request->fl_type);
>  	if (!ctx)
> @@ -1106,6 +1121,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		new_fl2 = locks_alloc_lock();
>  	}
>  
> +retry:
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
>  	/*
> @@ -1117,6 +1133,17 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>  			if (!posix_locks_conflict(request, fl))
>  				continue;
> +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
> +				&& (*fl->fl_lmops->lm_lock_expirable)(fl)) {
> +				owner = fl->fl_lmops->lm_mod_owner;
> +				func = fl->fl_lmops->lm_expire_lock;
> +				__module_get(owner);
> +				spin_unlock(&ctx->flc_lock);
> +				percpu_up_read(&file_rwsem);
> +				(*func)();
> +				module_put(owner);
> +				goto retry;
> +			}
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
