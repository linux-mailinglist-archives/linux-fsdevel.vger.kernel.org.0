Return-Path: <linux-fsdevel+bounces-51193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9672DAD4433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0463A563D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D624266EE7;
	Tue, 10 Jun 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Nira1/62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1C4685
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589057; cv=none; b=qAQdExRYPYxAXPNHL539Sdfd5qD7XePc/xE2Q17Z7wRkgybTFZ4NKjiX1l1z1BCtqH1k5M46yWOBJV4pHSVjbID8w+WvbY5QKFD7yLo+QJbq3FH6ZUkF5ddgSsR5vAbV2XDjAB+nHghlO9aqREkRpRuOQC019A3vToiqC5DFQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589057; c=relaxed/simple;
	bh=BBgr64CDzTotwb6plr7CtwqYPZIXvq92wtsic+1GVDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG8an0fHD/Jox9bz8JZPH//hOuvZN4in0gU44J/QKiLYBrl73vqONELQiH9pRZ5heLBlas+jDVCyRIeyYxIeEoqeZ3tDYymg8qKs82rZzSqtiDxhvP3C0bmnNTIc1R/PAnLdI1HCbLgBOdP3DMJEt3NV7MsDHmoYTmo6URjd7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Nira1/62; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sovDEbQ90kch4M7DkLBHTQVsPC6OGFrLou8MYbCbi0o=; b=Nira1/62kUo3VLDAYFPAzCidCA
	GoPeOckkp6NVZoSC6QZXdry8pWyObwpzYo1lt9LtrKWnNUxF8bmUwT9bVZ6MTmnGmyZfviod+8Cbr
	C9liUKQTZ9fDoCwAlssdn87IsSI4E6Mw/ec7yGpqH4ZMAZhjEFsHcBZYh60NDIuPF5Ye76xjNC17U
	/LUvQkitKBH9peMk0zI/mTMm6iMye5jte84PN6paRkhLbqRCrxXguka6FgDawPm6yGY7CvDLqCx/p
	k+fd+f+Jlg88V0Ss4wYA/9muc82IrWkWQVa/H0HYKvEkupadxdYHkHOPzDUG4MQO1D4IRurT9SA3h
	/EegknPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP62G-0000000BZ2a-3gQi;
	Tue, 10 Jun 2025 20:57:33 +0000
Date: Tue, 10 Jun 2025 21:57:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/8] Introduce S_DYING which warns that S_DEAD might
 follow.
Message-ID: <20250610205732.GG299672@ZenIV>
References: <20250609075950.159417-1-neil@brown.name>
 <20250609075950.159417-6-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609075950.159417-6-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 09, 2025 at 05:34:10PM +1000, NeilBrown wrote:
> Once we support directory operations (e.g. create) without requiring the
> parent to be locked, the current practice locking a directory while
> processing rmdir() or similar will not be sufficient to wait for
> operations to complete and to block further operations.
> 
> This patch introduced a new inode flag S_DYING.  It indicates that
> a rmdir or similar is being processed and new directory operations must
> not commence in the directory.  They should not abort either as the
> rmdir might fail - instead they should block.  They can do this by
> waiting for a lock on the inode.
> 
> A new interface rmdir_lock() locks the inode, sets this flag, and waits
> for any children with DCACHE_LOCK set to complete their operation, and
> for any d_in_lookup() children to complete the lookup.  It should be
> called before attempted to delete the directory or set S_DEAD.  Matching
> rmdir_unlock() clears the flag and unlocks the inode.
> 
> dentry_lock() and d_alloc_parallel() are changed to block while this
> flag it set and to fail if the parent IS_DEADDIR(), though dentry_lock()
> doesn't block for d_in_lookup() dentries.

> diff --git a/fs/namei.c b/fs/namei.c
> index 4ad76df21677..c590f25d0d49 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1770,8 +1770,11 @@ static bool __dentry_lock(struct dentry *dentry,
>  			  struct dentry *base, const struct qstr *last,
>  			  unsigned int subclass, int state)
>  {
> +	struct dentry *parent;
> +	struct inode *dir;
>  	int err;
>  
> +retry:
>  	lock_acquire_exclusive(&dentry->dentry_map, subclass, 0, NULL, _THIS_IP_);
>  	spin_lock(&dentry->d_lock);
>  	err = wait_var_event_any_lock(&dentry->d_flags,
> @@ -1782,10 +1785,43 @@ static bool __dentry_lock(struct dentry *dentry,
>  		spin_unlock(&dentry->d_lock);
>  		return false;
>  	}
> -
> -	dentry->d_flags |= DCACHE_LOCK;
> +	parent = dentry->d_parent;

Why will it stay the parent?  Matter of fact, why will it stay positive?

> +	dir = igrab(parent->d_inode);

... and not oops right here?

> +	lock_map_release(&dentry->dentry_map);
>  	spin_unlock(&dentry->d_lock);
> -	return true;
> +
> +	if (state == TASK_KILLABLE) {
> +		err = down_write_killable(&dir->i_rwsem);
> +		if (err) {
> +			iput(dir);
> +			return false;
> +		}
> +	} else
> +		inode_lock(dir);
> +	/* S_DYING much be clear now */
> +	inode_unlock(dir);
> +	iput(dir);
> +	goto retry;

OK, I'm really confused now.  Is it allowed to call dentry_lock() while holding
->i_rwsem of the parent?

Where does your dentry lock nest wrt ->i_rwsem?  As a bonus (well, malus, I guess)
question, where does it nest wrt parent *and* child inodes' ->i_rwsem for rmdir
and rename?

Tangentially connected question: which locks are held for ->unlink() in your
scheme?  You do need *something* on the victim inode to protect ->i_nlink
modifications, and anything on dentries of victim or their parent directories
is not going to give that.

