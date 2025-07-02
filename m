Return-Path: <linux-fsdevel+bounces-53698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB20BAF60E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403D13AEC6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CEE31550B;
	Wed,  2 Jul 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeB+2rO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1083303DF4;
	Wed,  2 Jul 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480084; cv=none; b=IJOrIkmgUt/kHDfVQuL22S6prgmDq2TcOsDvUg5U77CGhFEk+Cc8d8FUhZkBz3IqShXx1oAGsgoee1Stbta1IEPIpIb3Fjv2JYUVTurWj7aYgbYXNqMXB68Frfj10/jD+KPICWb00Gum52qcEcBGe38ZXjWCdzXk8y/YMtMNoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480084; c=relaxed/simple;
	bh=Qz64CdV/WgpVwVW6IuN51DYFnjqRrdZAc+dMBXvX+mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kpetkd+M08I+qUGiCr7Hk6HrH78cCNYVTALTasOl8OZBmdLzJjl8sZua+5BqvQTE+2w6UjUvKuijDQHWZndlp2Hm4ch+W3paPprA/UIDO3co0VzfZsoEbry9Sij9eUHuOpnxahRtepTj2125ZpUP4R9FkpWk+/dmCg6znuPkRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeB+2rO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCC5C4CEE7;
	Wed,  2 Jul 2025 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480081;
	bh=Qz64CdV/WgpVwVW6IuN51DYFnjqRrdZAc+dMBXvX+mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AeB+2rO0ydcyHvdxXCc7qQx/onLcBg9FDFq5WDftiDVwNqVZK28H38ypqCNUHNsJo
	 kVXd4V6JAig71Ebs5OrPynZVgIvktghl1MQeP7jd+II7lu+iFoVzqclXOyA+VeQEAr
	 9bd7sXRlpwJThmLoTLlRHf8XrZM9CxwKGKv/sQH5nYAQPDVhaQ0c1DfEeDXkgaQ7oR
	 69DpTVZVjn29WIpgCVxWFwj+CrHL1cWpc2GiJPjGJIWq0507MTrmmxJrFZiPn8rrbG
	 bGVnsCLvbIj4/gBQMMSCU7YpQU0g2/0DAfb03qg13D+972EvLCFuQwq5HF1plMeNFn
	 O89q6LoVXkEVw==
Date: Wed, 2 Jul 2025 11:14:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 14/16] fuse: use iomap for folio laundering
Message-ID: <20250702181440.GI10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-15-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-15-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:33PM -0700, Joanne Koong wrote:
> Use iomap for folio laundering, which will do granular dirty
> writeback when laundering a large folio.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 52 ++++++++++++--------------------------------------
>  1 file changed, 12 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2b4b950eaeed..35ecc03c0c48 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2062,45 +2062,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
>  	return wpa;
>  }
>  
> -static int fuse_writepage_locked(struct folio *folio)
> -{
> -	struct address_space *mapping = folio->mapping;
> -	struct inode *inode = mapping->host;
> -	struct fuse_inode *fi = get_fuse_inode(inode);
> -	struct fuse_writepage_args *wpa;
> -	struct fuse_args_pages *ap;
> -	struct fuse_file *ff;
> -	int error = -EIO;
> -
> -	ff = fuse_write_file_get(fi);
> -	if (!ff)
> -		goto err;
> -
> -	wpa = fuse_writepage_args_setup(folio, 0, ff);
> -	error = -ENOMEM;
> -	if (!wpa)
> -		goto err_writepage_args;
> -
> -	ap = &wpa->ia.ap;
> -	ap->num_folios = 1;
> -
> -	folio_start_writeback(folio);
> -	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
> -
> -	spin_lock(&fi->lock);
> -	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
> -	fuse_flush_writepages(inode);
> -	spin_unlock(&fi->lock);
> -
> -	return 0;
> -
> -err_writepage_args:
> -	fuse_file_put(ff, false);
> -err:
> -	mapping_set_error(folio->mapping, error);
> -	return error;
> -}
> -
>  struct fuse_fill_wb_data {
>  	struct fuse_writepage_args *wpa;
>  	struct fuse_file *ff;
> @@ -2281,8 +2242,19 @@ static int fuse_writepages(struct address_space *mapping,
>  static int fuse_launder_folio(struct folio *folio)
>  {
>  	int err = 0;
> +	struct fuse_fill_wb_data data = {
> +		.inode = folio->mapping->host,
> +	};
> +	struct iomap_writepage_ctx wpc = {
> +		.inode = folio->mapping->host,
> +		.iomap.type = IOMAP_MAPPED,
> +		.ops = &fuse_writeback_ops,
> +		.wb_ctx	= &data,
> +	};
> +
>  	if (folio_clear_dirty_for_io(folio)) {
> -		err = fuse_writepage_locked(folio);
> +		err = iomap_writeback_folio(&wpc, folio);
> +		err = fuse_iomap_writeback_submit(&wpc, err);

Weird krobot complaints aside, this looks like a reasonable way to write
a single folio similar to what writepage used to do.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		if (!err)
>  			folio_wait_writeback(folio);
>  	}
> -- 
> 2.47.1
> 
> 

