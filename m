Return-Path: <linux-fsdevel+bounces-41310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A68A2DB5D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 07:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE5118870B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1C140E30;
	Sun,  9 Feb 2025 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SoOGjmoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AD4C9F;
	Sun,  9 Feb 2025 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739083232; cv=none; b=mOdBVsKhUk8CQq4LF3Sfxokr+1aQcuFm9HoaX+qVRynarQEalaQjqs52GEPy5JrFiNUMl9dXHegfYqjlM9832swhn6C+Zk7YP0Sdr60axgI4fpJm1oHllI4BzevUzikDufi0yQlbtrEuKt79aL8aG/GQKYu/N7bFzaKJUsRpIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739083232; c=relaxed/simple;
	bh=I+n6YL4BVvpvdCEXFuSfEXS7J45BosY6sb8Q2vj8/V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMfv7qwT24cSbl75pMvv+qtuJ60FQcgXBY0Fo/ZPHfBfyGPpsR6ffoa/2hOfmn6EpCRO7tYlxNxy/zX5MfAR1xGKrTnFAEkZqrYBRKzqu1HiEpOFdHd2pG7e9pYDIVnOmkkSs+p61k3xuUDeWiweKWyKLMGGLu+z9xQ83VrS2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SoOGjmoT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9oFpwbEwOTCngZ/mwbnn+Iorxg6hPP7eCgH77WuWom4=; b=SoOGjmoTduqo6ZxdSo1Tr+LvGe
	rtQbnZjMosxqY6xfNh3tXrvllkPb51vCqX+jQE/6gKCnjFBM4CbKG1bXkcygZFY6KWHcb9xjTvMi5
	9CF9+FePuAJVxvVj137XhgQQvq9zOixFOreiPk1HzAaqsLV2X+A89NnFMzuDMCmgfGYgrJF/CkvHT
	woMEtGJTVrE9uAPBszJyFBzxUm1OZBsd8zT7IH0ejDJILUgnsHow0/C02EzgYCqzIIhRmlbajC+Ms
	CNkhmT2KVfNwmEwd9648B/azK2XK13p9+wRA8NCvuE+MFaawBtNYJbCJdAd6gp94fN7HEf58Dc4lQ
	62GXDvCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1th0zT-00000008Dpp-0COW;
	Sun, 09 Feb 2025 06:40:27 +0000
Date: Sun, 9 Feb 2025 06:40:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] VFS: Add ability to exclusively lock a dentry and
 use for create/remove  operations.
Message-ID: <20250209064027.GV1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-12-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-12-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:48PM +1100, NeilBrown wrote:

> +bool d_update_lock(struct dentry *dentry,
> +		   struct dentry *base, const struct qstr *last,
> +		   unsigned int subclass)
> +{
> +	lock_acquire_exclusive(&dentry->d_update_map, subclass, 0, NULL, _THIS_IP_);
> +again:
> +	spin_lock(&dentry->d_lock);
> +	wait_var_event_spinlock(&dentry->d_flags,
> +				!check_dentry_locked(dentry),
> +				&dentry->d_lock);
> +	if (d_is_positive(dentry)) {
> +		rcu_read_lock(); /* needed for d_same_name() */

It isn't.  You are holding ->d_lock there.

> +		if (
> +			/* Was unlinked while we waited ?*/
> +			d_unhashed(dentry) ||
> +			/* Or was dentry renamed ?? */
> +			dentry->d_parent != base ||
> +			dentry->d_name.hash != last->hash ||
> +			!d_same_name(dentry, base, last)

Negatives can't be moved, but they bloody well can be unhashed.  So skipping
the d_unhashed() part for negatives is wrong.

> +		) {
> +			rcu_read_unlock();
> +			spin_unlock(&dentry->d_lock);
> +			lock_map_release(&dentry->d_update_map);
> +			return false;
> +		}
> +		rcu_read_unlock();
> +	}
> +	/* Must ensure DCACHE_PAR_UPDATE in child is visible before reading
> +	 * from parent
> +	 */
> +	smp_store_mb(dentry->d_flags, dentry->d_flags | DCACHE_PAR_UPDATE);

... paired with?

> +	if (base->d_flags & DCACHE_PAR_UPDATE) {
> +		/* We cannot grant DCACHE_PAR_UPDATE on a dentry while
> +		 * it is held on the parent
> +		 */
> +		dentry->d_flags &= ~DCACHE_PAR_UPDATE;
> +		spin_unlock(&dentry->d_lock);
> +		spin_lock(&base->d_lock);
> +		wait_var_event_spinlock(&base->d_flags,
> +					!check_dentry_locked(base),
> +					&base->d_lock);

Oh?  So you might also be waiting on the parent?  That's a deadlock fodder right
there - caller might be holding ->i_rwsem on the same parent, so you have waiting
on _->d_flags nested both outside and inside _->d_inode->i_rwsem.

Just in case anyone goes "->i_rwsem will only be held shared" - that wouldn't help.
Throw fchmod() into the mix and enjoy your deadlock -
	A: holds ->i_rwsem shared, waits for C to clear DCACHE_PAR_UPDATE.
	B: blocked trying to grab ->i_rwsem exclusive
	C: has DCACHE_PAR_UPDATE set, is blocked trying to grab ->i_rwsem shared
and there you go...

> +		spin_unlock(&base->d_lock);
> +		goto again;
> +	}
> +	spin_unlock(&dentry->d_lock);
> +	return true;
> +}

The entire thing is refcount-neutral for both dentry and base.  Which makes this

> @@ -1759,8 +1863,9 @@ static struct dentry *lookup_and_lock_nested(const struct qstr *last,
>  
>  	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
>  		inode_lock_nested(base->d_inode, subclass);
> -
> -	dentry = lookup_one_qstr(last, base, lookup_flags);
> +	do {
> +		dentry = lookup_one_qstr(last, base, lookup_flags);
> +	} while (!IS_ERR(dentry) && !d_update_lock(dentry, base, last, subclass));

... a refcount leak waiting to happen.

