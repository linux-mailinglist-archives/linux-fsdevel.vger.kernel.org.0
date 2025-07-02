Return-Path: <linux-fsdevel+bounces-53700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDAEAF60EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED423AEC6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8B315508;
	Wed,  2 Jul 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oraOvWI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0021770C;
	Wed,  2 Jul 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480114; cv=none; b=q205pFGE2FBg06U0TXcw0qfsyTkMOzn2h0WMnoZ6WgkMTGPB1sug7AsNdvyZaRuimB2UBERZRpvjdwEHBcmzGCb3t3ggBQIMiiv2DjMYUIbuFmkJyRoYu22be7t66ZFCIQQ2o+6+5SB9sQY6Ain8xUo63BPD2RWcDDXjFkzIfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480114; c=relaxed/simple;
	bh=CNiTdgDPyHA5SNxqNVT3s7Ja4sppZ88um/f5Spk4PGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXD6552aAQQe3qltjnv5byJjZEfYSSzeBwTDVZgWQwRPQk+B52cbic+gE9d4ygyvkPa9toxN8QNivz96PGJdnd55AD0kVDCbES3SyKFKApXD2UQoVbOdQeJUwwwZS2X10vFiuaXraGwZzDdzHNacWLx8CxCVEXR/rmtiTqiI410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oraOvWI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B64C4CEE7;
	Wed,  2 Jul 2025 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480114;
	bh=CNiTdgDPyHA5SNxqNVT3s7Ja4sppZ88um/f5Spk4PGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oraOvWI6e6AIuo+hDQPK4DISnr7kJk+41gEJsNulSMCVOmZxllsuCwASjFsMLz9ey
	 LkSOMHw/BXwXQ9iLokaXD9XPLP2wImzmqgzNvJ7U9YDubVqy8ei9HTvtqcd5wtiL7A
	 CHGFzQjFY9a5mScABY3LiTh7b/g1x8QM9EMZ49t89nJyRhT7LFcKDjmu0OXx24tJNq
	 KLCoRCoXaKgbJJz/khXOk5Q+7XyHWFqesRhRIPIZz8DCgY0GVmCR3S+/K/FDP7Q/m7
	 ERcv/ePBaoPI/elB8uTTB1CHx+ZKOeKM9j/p+YUuBuQhyghZsZW/so8wJJ3WozDLbY
	 fKAcMye1hNjDA==
Date: Wed, 2 Jul 2025 11:15:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 16/16] fuse: refactor writeback to use
 iomap_writepage_ctx inode
Message-ID: <20250702181513.GK10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-17-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-17-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:35PM -0700, Joanne Koong wrote:
> struct iomap_writepage_ctx includes a pointer to the file inode. In
> writeback, use that instead of also passing the inode into
> fuse_fill_wb_data.
> 
> No functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 865d04b8ef31..4f17ba69ddfc 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2070,16 +2070,16 @@ struct fuse_fill_wb_data {
>  	unsigned int nr_bytes;
>  };
>  
> -static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
> +static bool fuse_pages_realloc(struct fuse_fill_wb_data *data,
> +			       unsigned int max_pages)
>  {
>  	struct fuse_args_pages *ap = &data->wpa->ia.ap;
> -	struct fuse_conn *fc = get_fuse_conn(data->inode);
>  	struct folio **folios;
>  	struct fuse_folio_desc *descs;
>  	unsigned int nfolios = min_t(unsigned int,
>  				     max_t(unsigned int, data->max_folios * 2,
>  					   FUSE_DEFAULT_MAX_PAGES_PER_REQ),
> -				    fc->max_pages);
> +				    max_pages);
>  	WARN_ON(nfolios <= data->max_folios);
>  
>  	folios = fuse_folios_alloc(nfolios, GFP_NOFS, &descs);
> @@ -2096,10 +2096,10 @@ static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
>  	return true;
>  }
>  
> -static void fuse_writepages_send(struct fuse_fill_wb_data *data)
> +static void fuse_writepages_send(struct inode *inode,
> +				 struct fuse_fill_wb_data *data)
>  {
>  	struct fuse_writepage_args *wpa = data->wpa;
> -	struct inode *inode = data->inode;
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  
>  	spin_lock(&fi->lock);
> @@ -2134,7 +2134,8 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
>  		return true;
>  
>  	/* Need to grow the pages array?  If so, did the expansion fail? */
> -	if (ap->num_folios == data->max_folios && !fuse_pages_realloc(data))
> +	if (ap->num_folios == data->max_folios &&
> +	    !fuse_pages_realloc(data, fc->max_pages))
>  		return true;
>  
>  	return false;
> @@ -2147,7 +2148,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  	struct fuse_fill_wb_data *data = wpc->wb_ctx;
>  	struct fuse_writepage_args *wpa = data->wpa;
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
> -	struct inode *inode = data->inode;
> +	struct inode *inode = wpc->inode;
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	loff_t offset = offset_in_folio(folio, pos);
> @@ -2165,7 +2166,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  	iomap_start_folio_write(inode, folio, 1);
>  
>  	if (wpa && fuse_writepage_need_send(fc, folio, offset, len, ap, data)) {
> -		fuse_writepages_send(data);
> +		fuse_writepages_send(inode, data);
>  		data->wpa = NULL;
>  		data->nr_bytes = 0;
>  	}
> @@ -2199,7 +2200,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
>  
>  	if (data->wpa) {
>  		WARN_ON(!data->wpa->ia.ap.num_folios);
> -		fuse_writepages_send(data);
> +		fuse_writepages_send(wpc->inode, data);
>  	}
>  
>  	if (data->ff)
> @@ -2218,9 +2219,7 @@ static int fuse_writepages(struct address_space *mapping,
>  {
>  	struct inode *inode = mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> -	struct fuse_fill_wb_data data = {
> -		.inode = inode,
> -	};
> +	struct fuse_fill_wb_data data = {};
>  	struct iomap_writepage_ctx wpc = {
>  		.inode = inode,
>  		.iomap.type = IOMAP_MAPPED,
> @@ -2242,9 +2241,7 @@ static int fuse_writepages(struct address_space *mapping,
>  static int fuse_launder_folio(struct folio *folio)
>  {
>  	int err = 0;
> -	struct fuse_fill_wb_data data = {
> -		.inode = folio->mapping->host,
> -	};
> +	struct fuse_fill_wb_data data = {};
>  	struct iomap_writepage_ctx wpc = {
>  		.inode = folio->mapping->host,
>  		.iomap.type = IOMAP_MAPPED,
> -- 
> 2.47.1
> 
> 

