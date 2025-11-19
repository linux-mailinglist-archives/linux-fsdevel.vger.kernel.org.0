Return-Path: <linux-fsdevel+bounces-69139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A1C70DF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B37A734B15C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447436C599;
	Wed, 19 Nov 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ykmp0BCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB7371DDF;
	Wed, 19 Nov 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581341; cv=none; b=Ysgula82wfxCvWblrOThGZlzQ2LyygBdKgvWMPj+dfanL2M4vIxMDs45wHHeI5D8h+WrKfrDqMxas7Xj/w/dZrB2D5yoITltGWdeL/lmdiI7LaPUOzDmBjQ60IAm90ZOetFoq4dcmCAIGpJIKHFpxMZR5sm5o5zSBj0Et8CdNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581341; c=relaxed/simple;
	bh=e+MXGgPYu/y9YlAdq0yLrWQ4izdoTxUApImwA15N1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY8Y19MFiYjuzwO+1ErYtujOlU/4+QFxXBDTTEk9Sm8gw4CJbmwS5N3YK7o5Ed9mP6Ik7XaOCENgqEXjwWjC8NW8uIWeULvkas51yYDUKdD/+TSkxEecNaP5yPmmfH+Ivq30H8EzHqV5lJovaSz7ZbeQ9YfszaQkwuC/GeoiLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ykmp0BCS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Voq1aNw3Keg07dCZMP8ZMLDN3mQ3oin/i/4uzlWGxEE=; b=Ykmp0BCSplvB2hTCgagTXa/0b/
	4Nz9lufJpi3fiT2kuAjHpHfTf+PMij/Y6VAXqdLJU/6q7AY7RCBnCKlBEEXHgEO0nh6SYIPha7b9/
	Pr+/yHCwk95zZ5f3QBGY8m/yZQ7tbdLspyWEW7iM6zEJgBz3//LEEjUQ3oUVnnVW/4xr6RKzEh7CY
	tUhWeIY8atrKXKqBFtRyoqrdNdDNEvVox5jH6/+rBo+D0qGTiuz4C1kIpXtPEfR5UoQSPqk6UGsAW
	fkP/yC4mh0XudlZvs+In951/I+XAoNRhQDT2Nz+td5N5YKc4rsvdFD2bkCM4Jhyicaj8TEPWwHJDw
	Qu5r6NZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLo4A-000000099hi-43QO;
	Wed, 19 Nov 2025 19:42:11 +0000
Date: Wed, 19 Nov 2025 19:42:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: inline step_into() and walk_component()
Message-ID: <20251119194210.GO2441659@ZenIV>
References: <20251119184001.2942865-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119184001.2942865-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 19, 2025 at 07:40:01PM +0100, Mateusz Guzik wrote:

> -static const char *pick_link(struct nameidata *nd, struct path *link,
> +static noinline const char *pick_link(struct nameidata *nd, struct path *link,
>  		     struct inode *inode, int flags)
>  {
>  	struct saved *last;
>  	const char *res;
> -	int error = reserve_stack(nd, link);
> +	int error;
> +
> +	if (nd->flags & LOOKUP_RCU) {
> +		/* make sure that d_is_symlink above matches inode */

Where would that "above" be?  Have some pity on the readers...

> +static __always_inline const char *step_into(struct nameidata *nd, int flags,
> +		     struct dentry *dentry)
> +{
> +	struct path path;
> +	struct inode *inode;
> +
> +	path.mnt = nd->path.mnt;
> +	path.dentry = dentry;
> +	if (!(nd->flags & LOOKUP_RCU))
> +		goto slowpath;
> +	if (unlikely(dentry->d_flags & DCACHE_MANAGED_DENTRY))
> +		goto slowpath;
> +	inode = path.dentry->d_inode;
> +	if (unlikely(d_is_symlink(path.dentry)))
> +		goto slowpath;
> +	if (read_seqcount_retry(&path.dentry->d_seq, nd->next_seq))
> +		return ERR_PTR(-ECHILD);
> +	if (unlikely(!inode))
> +		return ERR_PTR(-ENOENT);
> +	nd->path = path;
> +	nd->inode = inode;
> +	nd->seq = nd->next_seq;
> +	return NULL;
> +slowpath:
> +	return step_into_slowpath(nd, flags, dentry);
> +}

Is there any point keeping that struct path here?  Hell, what's wrong
with

static __always_inline const char *step_into(struct nameidata *nd, int flags,
		     struct dentry *dentry)
{
	if (likely((nd->flags & LOOKUP_RCU) &&
	    !(dentry->d_flags & DCACHE_MANAGED_DENTRY) &&
	    !d_is_symlink(dentry))) {
		// Simple case: no messing with refcounts and
		// neither a symlink nor mountpoint.
		struct inode *inode = dentry->d_inode;

		if (read_seqcount_retry(&dentry->d_seq, nd->next_seq))
			return ERR_PTR(-ECHILD);
		if (unlikely(!inode))
			return ERR_PTR(-ENOENT);
		nd->path.dentry = dentry;
		nd->inode = inode;
		nd->seq = nd->next_seq;
		return NULL;
	}
	return step_into_slowpath(nd, flags, dentry);
}

for that matter?

