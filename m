Return-Path: <linux-fsdevel+bounces-41261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA2A2CEB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9556166F34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB8E1ADFFB;
	Fri,  7 Feb 2025 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iWpA14qo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E12195FE5;
	Fri,  7 Feb 2025 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962423; cv=none; b=CAIZNjcOPnv5PaTGqAg5zO/YYQiHDatadp0iscW07mbVKu/dstrs7iDhO2t9JJUIYRHpWgz9KUbES33TSq+IXRr9vQ83fgh9z4/ohGOKWUOnvgij/PjFTrjAl/yZQWABaSNqs27jiwGHgraOyOvlWso+QHw+S3kgMb1JCywUTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962423; c=relaxed/simple;
	bh=4GKrQ5U797hVfpWQA1VnqUs/BrKDPGseYOGmUXO/MIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSgKSzlD9NpD9UH5olpkHH6WJUqtSIUsPZOKVl/XKbN0tC92luT9Pcr2GhLfk4/tEX1wvDxykciEfrIVXqppP5TTC4dlE6MOYfYPBFAR1UUf2MNx0zra9Ox++wBjJDpbXfuwoVg/ELdLRBhYq3zpC7wzIWI5WqsSCaCqCkQ+DAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iWpA14qo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VMfQNKakdosGgCE/nHD9nb+3Jp3yPfJ7LJDKlDdWB5k=; b=iWpA14qo54Sb7PjVBey/Q6AvOA
	NFOlKNJJxPlTs01B7EYlp6oKUYIkdeE60dInD30jyJibzY1SRX7IUW8IWzg2EOHFtGiS6bVCNBW9d
	hM4ZBL77EHHl+zXhh6KgfzE9wZ6ljBgRtbaWCYIYy7hFsSVZvkZrcvxR5SqQgecKEM/U8O5l6gjui
	rsPfM6PtGTSiu4c+/QDdPeGuHGnX2ahtKFBebcqFAQ9aw+JcBej8F5LVCRQy24zsVc4tHW7cjfeIg
	1xBfCenWMKpXiTOeRolDYmuJxyNwrdRemWwaxli51Hyiew3MXcR579Eq/3fUQXkcQbqmPAE2piBmF
	3bC+cgtg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgVYw-00000006axk-3l8e;
	Fri, 07 Feb 2025 21:06:58 +0000
Date: Fri, 7 Feb 2025 21:06:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/19] VFS: Ensure no async updates happening in
 directory being removed.
Message-ID: <20250207210658.GK1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-15-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-15-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:51PM +1100, NeilBrown wrote:
> vfs_rmdir takes an exclusive lock on the target directory to ensure
> nothing new is created in it while the rmdir progresses.  With the
> possibility of async updates continuing after the inode lock is dropped
> we now need extra protection.
> 
> Any async updates will have DCACHE_PAR_UPDATE set on the dentry.  We
> simply wait for that flag to be cleared on all children.

> +static void d_update_wait(struct dentry *dentry, unsigned int subclass)
> +{
> +	/* Note this may only ever be called in a context where we have
> +	 * a lock preventing this dentry from becoming locked, possibly
> +	 * an update lock on the parent dentry.  The must be a smp_mb()
> +	 * after that lock is taken and before this is called so that
> +	 * the following test is safe. d_update_lock() provides that
> +	 * barrier.
> +	 */
> +	if (!(dentry->d_flags & DCACHE_PAR_UPDATE))
> +		return
> +	lock_acquire_exclusive(&dentry->d_update_map, subclass,
> +			       0, NULL, _THIS_IP_);

What the fuck?

> +	spin_lock(&dentry->d_lock);
> +	wait_var_event_spinlock(&dentry->d_flags,
> +				!check_dentry_locked(dentry),
> +				&dentry->d_lock);
> +	spin_unlock(&dentry->d_lock);
> +	lock_map_release(&dentry->d_update_map);
> +}

OK, I realize that it compiles, but it should've raised all
kinds of red flags for anyone reading that.  return + <newline> is
already fishy, but having the next line indented *less* than that
return is firmly in the "somebody's trying to hide something nasty
here" territory, even without parsing the damn thing.

