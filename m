Return-Path: <linux-fsdevel+bounces-53707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289CAF6135
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE334A0E7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598122E499C;
	Wed,  2 Jul 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/9wXhO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D02E4989;
	Wed,  2 Jul 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480738; cv=none; b=BBwYNejfJlEfQMky+iqBeS1WS27EaxJvROLiU9oZylSH97nJ3IxYrtFtAvLR9gA4VfUYLAvczf5lvTYnPsK+R1bLURJcSEtC1LuCdtamzLW0zlTQpeMUcqnE4IaSKyovZhFCFz7m4i0VnSOwoaaJA4E0r4mfzIGCTAqBS7PJRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480738; c=relaxed/simple;
	bh=3DFdtFbJWzbggFvCiW+KwOA87/UqxMcgEkRE2COMIlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLB9jAmkHCDytVlRg4Tyk8XtJLXHwGRZs5jT1tu1xsCWqf97MpdFrvrhFrofNMVx1VtkUny2LlDBRiqgzRfg822kPV3pgJmhIxJjMP33ki4OP3nATXJQKoPqiV/+qx4xCjxx0PmHLsFG5PNeqTd+Q+jT1L8Wz7wS1KbrTTDKxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/9wXhO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7BCC4CEE7;
	Wed,  2 Jul 2025 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480738;
	bh=3DFdtFbJWzbggFvCiW+KwOA87/UqxMcgEkRE2COMIlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/9wXhO9iDFbWhf3d35NU2O1nCqt8WDt7/7zHhZ/VdYbFd19eQFw8Hr4LyTliCS+3
	 4CRk6vQSTdKr/Oa7S3jvJsnQ8SPnbrpNDUxNwRuFTpWAkM1vwqbActXRgLzMmgVaka
	 IM4hnMnMBCYPeUt9Fo8tCycYM8cXzVyjVHZ2RpQpdYiLLkagu8SoomnsSIjuzIrWlu
	 V+bmeNsd7XGoV7n4AoRVx9AqrcbY3LiS3VecxCRbjQ/TZ2tZXjciAd0LXeQzb1wCke
	 X0+7bU1S9+/Vm+wSfYlNbenO6UB8DWrqQC9Y/Vd0Gsgp2kERbDnT6XLnnLvLdt6q2h
	 P2diCt1JghHsg==
Date: Wed, 2 Jul 2025 11:25:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 05/12] iomap: add public helpers for uptodate state
 manipulation
Message-ID: <20250702182537.GR10009@frogsfrogsfrogs>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-6-hch@lst.de>

On Fri, Jun 27, 2025 at 09:02:38AM +0200, Christoph Hellwig wrote:
> From: Joanne Koong <joannelkoong@gmail.com>
> 
> Add a new iomap_start_folio_write helper to abstract away the
> write_bytes_pending handling, and export it and the existing
> iomap_finish_folio_write for non-iomap writeback in fuse.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> [hch: split from a larger patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 20 +++++++++++++++-----
>  include/linux/iomap.h  |  5 +++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a72ab487c8ab..d152456d41a8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1535,7 +1535,18 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
>  }
>  EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
>  
> -static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
> +void iomap_start_folio_write(struct inode *inode, struct folio *folio,
> +		size_t len)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> +	if (ifs)
> +		atomic_add(len, &ifs->write_bytes_pending);
> +}
> +EXPORT_SYMBOL_GPL(iomap_start_folio_write);
> +
> +void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> @@ -1546,6 +1557,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
>  		folio_end_writeback(folio);
>  }
> +EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
>  
>  /*
>   * We're now finished for good with this ioend structure.  Update the page
> @@ -1668,7 +1680,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len)
>  {
>  	struct iomap_ioend *ioend = wpc->wb_ctx;
> -	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	unsigned int ioend_flags = 0;
>  	unsigned int map_len = min_t(u64, dirty_len,
> @@ -1711,8 +1722,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
>  	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
>  		goto new_ioend;
>  
> -	if (ifs)
> -		atomic_add(map_len, &ifs->write_bytes_pending);
> +	iomap_start_folio_write(wpc->inode, folio, map_len);
>  
>  	/*
>  	 * Clamp io_offset and io_size to the incore EOF so that ondisk
> @@ -1880,7 +1890,7 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
>  		 * all blocks.
>  		 */
>  		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
> -		atomic_inc(&ifs->write_bytes_pending);
> +		iomap_start_folio_write(inode, folio, 1);
>  	}
>  
>  	/*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b65951cdb0b5..1a07d8fa9459 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -460,6 +460,11 @@ void iomap_sort_ioends(struct list_head *ioend_list);
>  ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len);
>  int ioend_writeback_submit(struct iomap_writeback_ctx *wpc, int error);
> +
> +void iomap_start_folio_write(struct inode *inode, struct folio *folio,
> +		size_t len);
> +void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
> +		size_t len);
>  int iomap_writepages(struct iomap_writeback_ctx *wpc);
>  
>  /*
> -- 
> 2.47.2
> 
> 

