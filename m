Return-Path: <linux-fsdevel+bounces-2603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746487E700C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE234B20CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC322329;
	Thu,  9 Nov 2023 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHiLSKvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559422316
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3F2C433C8;
	Thu,  9 Nov 2023 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699550412;
	bh=qrIpLt54IIKF4iVXr/dwpNzUgTbj28UvZxdtnPP3nDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHiLSKvUH3Eofk4/pcdYnta5amEYkRuKcjkKke1Wy9cigapMK6gCsRiKsnhbfsSH6
	 YxqTsyKTyycChmnYnOcKXWsur8RP1hFEa+tmh8oNyC+zuwqS7/uhrto3ZgNm12xEwy
	 kJXrK4/Ewe/4EAdITQjJSx+C+ixq6YwvKGurhUCxux9YTc8+5o6+4icvAb9w3+s1M7
	 XaEDb1tEFDXPe1DUUGjWdc52GPi7T54k4C4zkfpB7JurzT1zELNCO4lUMKURpuc7XW
	 qK1KqDY0rOgEnCGFAfCvBQr07N3EFudhwNkJMQBPShaEjUKdlE10zGZaJ9DN6RfTHU
	 mbIiZUCCLKOFA==
Date: Thu, 9 Nov 2023 18:20:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/22] don't try to cut corners in shrink_lock_dentry()
Message-ID: <20231109-designen-menschheit-7e4120584db1@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-17-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-17-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:51AM +0000, Al Viro wrote:
> That is to say, do *not* treat the ->d_inode or ->d_parent changes
> as "it's hard, return false; somebody must have grabbed it, so
> even if has zero refcount, we don't need to bother killing it -
> final dput() from whoever grabbed it would've done everything".
> 
> First of all, that is not guaranteed.  It might have been dropped
> by shrink_kill() handling of victim's parent, which would've found
> it already on a shrink list (ours) and decided that they don't need
> to put it on their shrink list.
> 
> What's more, dentry_kill() is doing pretty much the same thing,
> cutting its own set of corners (it assumes that dentry can't
> go from positive to negative, so its inode can change but only once
> and only in one direction).
> 
> Doing that right allows to get rid of that not-quite-duplication
> and removes the only reason for re-incrementing refcount before
> the call of dentry_kill().
> 
> Replacement is called lock_for_kill(); called under rcu_read_lock
> and with ->d_lock held.  If it returns false, dentry has non-zero
> refcount and the same locks are held.  If it returns true,
> dentry has zero refcount and all locks required by __dentry_kill()
> are taken.
> 
> Part of __lock_parent() had been lifted into lock_parent() to
> allow its reuse.  Now it's called with rcu_read_lock already
> held and dentry already unlocked.
> 
> Note that this is not the final change - locking requirements for
> __dentry_kill() are going to change later in the series and the
> set of locks taken by lock_for_kill() will be adjusted.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

It's a bit unfortunate that __lock_parent() locks the parent *and* may
lock the child which isn't really obvious from the name. It just becomes
clear that this is assumed by how callers release the child's lock.

>  fs/dcache.c | 159 ++++++++++++++++++++++------------------------------
>  1 file changed, 66 insertions(+), 93 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 23afcd48c1a9..801502871671 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -625,8 +625,6 @@ static void __dentry_kill(struct dentry *dentry)
>  static struct dentry *__lock_parent(struct dentry *dentry)
>  {
>  	struct dentry *parent;
> -	rcu_read_lock();
> -	spin_unlock(&dentry->d_lock);
>  again:
>  	parent = READ_ONCE(dentry->d_parent);
>  	spin_lock(&parent->d_lock);
> @@ -642,7 +640,6 @@ static struct dentry *__lock_parent(struct dentry *dentry)
>  		spin_unlock(&parent->d_lock);
>  		goto again;
>  	}
> -	rcu_read_unlock();
>  	if (parent != dentry)
>  		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>  	else
> @@ -657,7 +654,64 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
>  		return NULL;
>  	if (likely(spin_trylock(&parent->d_lock)))
>  		return parent;
> -	return __lock_parent(dentry);
> +	rcu_read_lock();
> +	spin_unlock(&dentry->d_lock);
> +	parent = __lock_parent(dentry);
> +	rcu_read_unlock();
> +	return parent;
> +}
> +
> +/*
> + * Lock a dentry for feeding it to __dentry_kill().
> + * Called under rcu_read_lock() and dentry->d_lock; the former
> + * guarantees that nothing we access will be freed under us.
> + * Note that dentry is *not* protected from concurrent dentry_kill(),
> + * d_delete(), etc.
> + *
> + * Return false if dentry is busy.  Otherwise, return true and have
> + * that dentry's inode and parent both locked.
> + */
> +
> +static bool lock_for_kill(struct dentry *dentry)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	struct dentry *parent = dentry->d_parent;
> +
> +	if (unlikely(dentry->d_lockref.count))
> +		return false;
> +
> +	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
> +		goto slow;
> +	if (dentry == parent)
> +		return true;
> +	if (likely(spin_trylock(&parent->d_lock)))
> +		return true;
> +
> +	if (inode)
> +		spin_unlock(&inode->i_lock);
> +slow:
> +	spin_unlock(&dentry->d_lock);
> +
> +	for (;;) {
> +		if (inode)
> +			spin_lock(&inode->i_lock);
> +		parent = __lock_parent(dentry);

We're under rcu here. Are we sure that this can't trigger rcu timeouts
because we're spinning? Maybe there's a reason that's not an issue here.

That spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED) in
__lock_parent() is there for the sake of lockdep to verify that the
parent lock is always aqcuired before the child lock?

