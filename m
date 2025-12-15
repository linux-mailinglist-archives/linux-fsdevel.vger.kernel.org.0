Return-Path: <linux-fsdevel+bounces-71357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3D6CBF14C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235C630595A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F463491F5;
	Mon, 15 Dec 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kRr4X6wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED843491CD;
	Mon, 15 Dec 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817636; cv=none; b=K4sbDwpReiEOkHo7z5ipVZsXEGDsQZcNrblJBDwYvmml422/JqrJIyThX2Vpkhd4I//jySPNDDvEfP/4EgVtNptTIL2nQqsDU0MoBygb5mTZ+YyVLLqiLzjh/X62ludJJ0fyVgxYZTAIS6NIQe1PKrpOIg09wmzHWiELFVvYSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817636; c=relaxed/simple;
	bh=3PDKLjM2Q+xHOisoXzCoVHaZ2UNzSxSiM8ZGoRdI3/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdlphhDR67cPUXTlagnaWhbum2oZ2zzoggq0cJFjF0qliLqirlURHQ2Kb26IfBxC9Pp4HJHL36vuiOxWHuN8t7YKfbNOlW/qjq+1SLOfDhu+te8TvdfsKW/Dgq/98LykAd0VZREZxa4sILBElNObYPelGRfNe6DrfRR+NgPRXUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kRr4X6wk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qjBYN1Tci3ZVIWi/TSuAzsf7+GxGQ6HoqfFTZ1yJ4AE=; b=kRr4X6wkVTpgA3bNsnEpKsbvR2
	BGAB8jd9/WOcUlmuq8vLROADAmmqM2hbvaqmdLjwzmcuK61sY/KBBJAHuBf0Dcu8MYkTbUf4XvtXD
	eNXEYP3OK7sx5eeZK4diekmW3VVwkDiSZjbvbnKr9rhlMB5QaeMDMqbL0fJIlsATy1pw/mVUKJ9iS
	8HkSx+imaei/CJArvpu5k7kzmIDOaKEAFIXIyx83Hq11zndXafj1HP2T7EgAAJ68/lmtbV6pL3DXj
	nq03gA63vKlMpyO0PD5r9FZ7fUUtD43LN11HvTCvsH5Q3xkoHYDzuJCDTWXpPy+eTp5FCoQDw8HcQ
	JiRpcDLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVBq1-00000007bu6-2Dvr;
	Mon, 15 Dec 2025 16:54:21 +0000
Date: Mon, 15 Dec 2025 16:54:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hugh Dickins <hughd@google.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] shmem: fix recovery on rename failures
Message-ID: <20251215165421.GN1712166@ZenIV>
References: <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV>
 <20251214032734.GL1712166@ZenIV>
 <20251214033049.GB460900@ZenIV>
 <02e4f1d6-f16e-4c0f-89d3-c75eea93b96f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e4f1d6-f16e-4c0f-89d3-c75eea93b96f@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 15, 2025 at 11:03:58AM -0500, Chuck Lever wrote:
> > @@ -388,31 +388,23 @@ int simple_offset_rename_exchange(struct inode *old_dir,
> >  	long new_index = dentry2offset(new_dentry);
> >  	int ret;
> >  
> > -	simple_offset_remove(old_ctx, old_dentry);
> > -	simple_offset_remove(new_ctx, new_dentry);
> > +	if (WARN_ON(!old_index || !new_index))
> > +		return -EINVAL;
> >  
> > -	ret = simple_offset_replace(new_ctx, old_dentry, new_index);
> > -	if (ret)
> > -		goto out_restore;
> > +	ret = mtree_store(&new_ctx->mt, new_index, old_dentry, GFP_KERNEL);
> > +	if (WARN_ON(ret))
> > +		return ret;
> >  
> > -	ret = simple_offset_replace(old_ctx, new_dentry, old_index);
> > -	if (ret) {
> > -		simple_offset_remove(new_ctx, old_dentry);
> > -		goto out_restore;
> > +	ret = mtree_store(&old_ctx->mt, old_index, new_dentry, GFP_KERNEL);
> > +	if (WARN_ON(ret)) {
> > +		mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
> 
> Under extreme memory pressure, this mtree_store() might also fail?

Neither should, really; adding after entry removal, as the mainline
does, might need allocations.  But mtree_store() when entry exists
and isn't a part of a range should not allocate anything.

What happens is that mas_wr_store_type() will return wr_exact_fit to
mas_wr_preallocate(), which will shove it into ->store_type before
calling mas_prealloc_calc(), getting ->node_request set to 0 by the
latter, seeing that and buggering off without allocating anything.

So these WARN_ON() are of the "if it triggers, something's really wrong -
either lib/maple_tree.c had an odd change of behaviour, or we have
our tree in unexpected state" variety, not "warn that operation's
failing due to OOM" one.

