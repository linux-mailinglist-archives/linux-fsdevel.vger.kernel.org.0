Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB3479584
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 21:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhLQUfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 15:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhLQUfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:35:18 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ADDC061574;
        Fri, 17 Dec 2021 12:35:18 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 285AE7044; Fri, 17 Dec 2021 15:35:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 285AE7044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639773317;
        bh=61mGqsJNRdUB3hSLOQ+aDWOt0wd9XFNYAegUOaMKwrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mlr87DVDy4FBMQc1GYIXzOtc07vfD/HSDj1RZ1T7cU80q0Ac9vfpgF9aLi6RJv8U9
         vKeXDPQdJQjjylyZNilTFegiZLDHA1ETxCcOQkvJH/rzMNzy6QNIodxxLIyLnOPWla
         0/OebUGDd06FvNGnllyZ770/DVLSB5I70hhDq2VY=
Date:   Fri, 17 Dec 2021 15:35:17 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Message-ID: <20211217203517.GJ28098@fieldses.org>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
 <20211213172423.49021-2-dai.ngo@oracle.com>
 <0C2E5E30-86A3-489E-9366-DC4FF109DD93@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C2E5E30-86A3-489E-9366-DC4FF109DD93@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:41:41PM +0000, Chuck Lever III wrote:
> 
> 
> > On Dec 13, 2021, at 12:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > 
> > Add new callback, lm_expire_lock, to lock_manager_operations to allow
> > the lock manager to take appropriate action to resolve the lock conflict
> > if possible. The callback takes 2 arguments, file_lock of the blocker
> > and a testonly flag:
> > 
> > testonly = 1  check and return lock manager's private data if lock conflict
> >              can be resolved else return NULL.
> > testonly = 0  resolve the conflict if possible, return true if conflict
> >              was resolved esle return false.
> > 
> > Lock manager, such as NFSv4 courteous server, uses this callback to
> > resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> > (client that has expired but allowed to maintains its states) that owns
> > the lock.
> > 
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> > fs/locks.c         | 40 +++++++++++++++++++++++++++++++++++++---
> > include/linux/fs.h |  1 +
> > 2 files changed, 38 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 3d6fb4ae847b..5f3ea40ce2aa 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -952,8 +952,11 @@ void
> > posix_test_lock(struct file *filp, struct file_lock *fl)
> > {
> > 	struct file_lock *cfl;
> > +	struct file_lock *checked_cfl = NULL;
> > 	struct file_lock_context *ctx;
> > 	struct inode *inode = locks_inode(filp);
> > +	void *res_data;
> > +	void *(*func)(void *priv, bool testonly);
> > 
> > 	ctx = smp_load_acquire(&inode->i_flctx);
> > 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> > @@ -962,11 +965,24 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
> > 	}
> > 
> > 	spin_lock(&ctx->flc_lock);
> > +retry:
> > 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> > -		if (posix_locks_conflict(fl, cfl)) {
> > -			locks_copy_conflock(fl, cfl);
> > -			goto out;
> > +		if (!posix_locks_conflict(fl, cfl))
> > +			continue;
> > +		if (checked_cfl != cfl && cfl->fl_lmops &&
> > +				cfl->fl_lmops->lm_expire_lock) {
> > +			res_data = cfl->fl_lmops->lm_expire_lock(cfl, true);
> > +			if (res_data) {
> > +				func = cfl->fl_lmops->lm_expire_lock;
> > +				spin_unlock(&ctx->flc_lock);
> > +				func(res_data, false);
> > +				spin_lock(&ctx->flc_lock);
> > +				checked_cfl = cfl;
> > +				goto retry;
> > +			}
> > 		}
> 
> Dai and I discussed this offline. Depending on a pointer to represent
> exactly the same struct file_lock across a dropped spinlock is racy.

Yes.  There's also no need for that (checked_cfl != cfl) check, though.
By the time func() returns, that lock should be gone from the list
anyway.

It's a little inefficient to have to restart the list every time--but
that theoretical n^2 behavior won't matter much compared to the time
spent waiting for clients to expire.  And this approach has the benefit
of being simple.

--b.

> Dai plans to investigate other mechanisms to perform this check
> reliably.
> 
> 
> > +		locks_copy_conflock(fl, cfl);
> > +		goto out;
> > 	}
> > 	fl->fl_type = F_UNLCK;
> > out:
> > @@ -1136,10 +1152,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> > 	struct file_lock *new_fl2 = NULL;
> > 	struct file_lock *left = NULL;
> > 	struct file_lock *right = NULL;
> > +	struct file_lock *checked_fl = NULL;
> > 	struct file_lock_context *ctx;
> > 	int error;
> > 	bool added = false;
> > 	LIST_HEAD(dispose);
> > +	void *res_data;
> > +	void *(*func)(void *priv, bool testonly);
> > 
> > 	ctx = locks_get_lock_context(inode, request->fl_type);
> > 	if (!ctx)
> > @@ -1166,9 +1185,24 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> > 	 * blocker's list of waiters and the global blocked_hash.
> > 	 */
> > 	if (request->fl_type != F_UNLCK) {
> > +retry:
> > 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> > 			if (!posix_locks_conflict(request, fl))
> > 				continue;
> > +			if (checked_fl != fl && fl->fl_lmops &&
> > +					fl->fl_lmops->lm_expire_lock) {
> > +				res_data = fl->fl_lmops->lm_expire_lock(fl, true);
> > +				if (res_data) {
> > +					func = fl->fl_lmops->lm_expire_lock;
> > +					spin_unlock(&ctx->flc_lock);
> > +					percpu_up_read(&file_rwsem);
> > +					func(res_data, false);
> > +					percpu_down_read(&file_rwsem);
> > +					spin_lock(&ctx->flc_lock);
> > +					checked_fl = fl;
> > +					goto retry;
> > +				}
> > +			}
> > 			if (conflock)
> > 				locks_copy_conflock(conflock, fl);
> > 			error = -EAGAIN;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e7a633353fd2..8cb910c3a394 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
> > 	int (*lm_change)(struct file_lock *, int, struct list_head *);
> > 	void (*lm_setup)(struct file_lock *, void **);
> > 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> > +	void *(*lm_expire_lock)(void *priv, bool testonly);
> > };
> > 
> > struct lock_manager {
> > -- 
> > 2.9.5
> > 
> 
> --
> Chuck Lever
> 
> 
