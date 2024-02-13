Return-Path: <linux-fsdevel+bounces-11385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4A8535DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94581F25FB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972F5F878;
	Tue, 13 Feb 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKOzhuXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED615F856;
	Tue, 13 Feb 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841208; cv=none; b=GSxdjbJ/99AClbH6f+5UonXqy8JVAkgPg0No4SlzyqqqYfYIeAyspD2ZXPRSdQ+UWC0HW3G3i7RjVlrI3P5sy26qhwaIHKTAJe4rtogIMwOknlZNk60vkbR8TaWWgyG5l6qJux2bTkfOdSaQ6dsMhI3opb5tBfcvCQAo9pvCeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841208; c=relaxed/simple;
	bh=gtslvFppOKZfPzRmik0crgUkQQcbarTzf8jQux+iYrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1LJkohk3jXzbER9DdeFbbqqa2kCxaVhe8q+8emDopbM+ymER5F36IiLWQq1LfyOIf6kWcGOuXnUHfUhXt2nMFFVIVrrB72UPgym4qAOpGVqB86Onz+4ncAou7ndnCe9byhmKwD/R/TSPqBQvAN/G6m/gyNWscb/KTCcVddXEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKOzhuXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AA0C433C7;
	Tue, 13 Feb 2024 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841207;
	bh=gtslvFppOKZfPzRmik0crgUkQQcbarTzf8jQux+iYrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKOzhuXFkW+ip0VWmWFMZ9X9xKNlSkv53BRhjGo3KjnathEkp3wXBz1RwEwDe3sll
	 HipdSEAULux2Mln4CXRaufvcwlgPXUZO8C8q/OrslYUJa+3InYHD7Kg9RJg4wY9lbH
	 FAbcUR6svShKB45qjgx50o9ktNu/dW0TJRNftgtq81gudCeLQ+nWb152fhiL6ocdkR
	 KiSS52BVlJBiW1caVXhN2fI2PCeXmeWVak7Nojyssh5lDd1n9iFcnKecyFVOrkHHA5
	 dQtgZSiVYtEnOaWNffOXkc6bpNIUkcmOVftkC/UtNbqWeqTyiVCgqKg3K09USAktQz
	 OB/dKJL4dEFXw==
Date: Tue, 13 Feb 2024 08:20:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 14/14] xfs: enable block size larger than page size
 support
Message-ID: <20240213162007.GO6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-15-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-15-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:13AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size. Enable it in XFS under CONFIG_XFS_LBS.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/xfs/xfs_icache.c | 8 ++++++--
>  fs/xfs/xfs_super.c  | 8 +++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index dba514a2c84d..9de81caf7ad4 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -73,6 +73,7 @@ xfs_inode_alloc(
>  	xfs_ino_t		ino)
>  {
>  	struct xfs_inode	*ip;
> +	int			min_order = 0;
>  
>  	/*
>  	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
> @@ -88,7 +89,8 @@ xfs_inode_alloc(
>  	/* VFS doesn't initialise i_mode or i_state! */
>  	VFS_I(ip)->i_mode = 0;
>  	VFS_I(ip)->i_state = 0;
> -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> +	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
> +	mapping_set_folio_orders(VFS_I(ip)->i_mapping, min_order, MAX_PAGECACHE_ORDER);
>  
>  	XFS_STATS_INC(mp, vn_active);
>  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> @@ -313,6 +315,7 @@ xfs_reinit_inode(
>  	dev_t			dev = inode->i_rdev;
>  	kuid_t			uid = inode->i_uid;
>  	kgid_t			gid = inode->i_gid;
> +	int			min_order = 0;
>  
>  	error = inode_init_always(mp->m_super, inode);
>  
> @@ -323,7 +326,8 @@ xfs_reinit_inode(
>  	inode->i_rdev = dev;
>  	inode->i_uid = uid;
>  	inode->i_gid = gid;
> -	mapping_set_large_folios(inode->i_mapping);
> +	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
> +	mapping_set_folio_orders(inode->i_mapping, min_order, MAX_PAGECACHE_ORDER);

Twice now I've seen this, which makes me think "refactor this into a
single function."

But then, this is really just:

	mapping_set_folio_orders(inode->i_mapping,
			max(0, inode->i_sb->s_blocksize_bits - PAGE_SHIFT),
			MAX_PAGECACHE_ORDER);

Can we make that a generic inode_set_pagecache_orders helper?

>  	return error;
>  }
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 5a2512d20bd0..6a3f0f6727eb 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1625,13 +1625,11 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
> -	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> +	if (!IS_ENABLED(CONFIG_XFS_LBS) && mp->m_sb.sb_blocksize > PAGE_SIZE) {
>  		xfs_warn(mp,
>  		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> +		"Only pagesize (%ld) or less will currently work. "
> +		"Enable Experimental CONFIG_XFS_LBS for this support",
>  				mp->m_sb.sb_blocksize, PAGE_SIZE);

Please log a warning about the EXPERIMENTAL bs>ps feature being used
on this mount for the CONFIG_XFS_LBS=y case.

--D

>  		error = -ENOSYS;
>  		goto out_free_sb;
> -- 
> 2.43.0
> 
> 

