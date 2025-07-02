Return-Path: <linux-fsdevel+bounces-53683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDDAF602D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB54E510A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5678E303DE6;
	Wed,  2 Jul 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9q42e0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EB2F5095;
	Wed,  2 Jul 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477948; cv=none; b=GJlGnwZRbzllLXbeW8EpAZAZasj669BbQVki0yHnOzRL1eDDCbtIE8owXIH0pmFvF69joAse5kPM7tiiG4MO63MkubRlZ6ECTJtbH0UuOGyIh+ffuI5MQ/62xSCSKnxIzGxM2P1JvWrIp0YsnvaBa3TJCIF/wPrl3f/TU7ORr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477948; c=relaxed/simple;
	bh=pcwhQQwTu5/uOiYHXx8tsLIxk2oNfyTiPoHLYlkyz74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erowXzmr0/E9WipTdF34UZBPOTC4C4p+vRnA5mBtMxfeya3oeKg6bpK1H1YqCE1dFjb4NouNZRnA6dlqDFJw0Vqzlg0PVx2L69HqLNdG9x4vLa+uugi0pr6ja14TColYs54h3OhcQLGThXLzcXT45OPDEQmsaCqIuFhsnp9f5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9q42e0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C705C4CEE7;
	Wed,  2 Jul 2025 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751477948;
	bh=pcwhQQwTu5/uOiYHXx8tsLIxk2oNfyTiPoHLYlkyz74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9q42e0sUlOGkhruYE6GBACYY7UGdwPDda6QmZva8T5HkRl0pwlMq6raGamieEp+K
	 Btc46auBIvGLpzxpPq6m7u/yAcqwieIXCXXeoTrtNuYTiGp1NfUGu0evZ0M6h4KkwV
	 +D+DRiKJCeCcGTPCq/NIZgKQAFKyz/NEjNBYYCWznpw+3lD70BhqC4Bbk1vMgoP3fH
	 qVJgi1xb5Cy2wgjCilQbTK/eucenPRBYQqdp1fY+RS+YSnPlhE//IU1u+A+TQ8+h74
	 xwl5IpFVSnMONnvabTjrdX269daZcNeuhAhijmMxUAHmkSjFcTSeGDbwUVP1iodfcg
	 7LZUV5+fvyzSQ==
Date: Wed, 2 Jul 2025 10:39:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 05/16] iomap: add public helpers for uptodate state
 manipulation
Message-ID: <20250702173908.GY10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-6-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:24PM -0700, Joanne Koong wrote:
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
> index 50cfddff1393..b4a8d2241d70 100644
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
> @@ -1668,7 +1680,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len)
>  {
>  	struct iomap_ioend *ioend = wpc->wb_ctx;
> -	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	unsigned int ioend_flags = 0;
>  	unsigned int map_len = min_t(u64, dirty_len,
> @@ -1711,8 +1722,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
>  		goto new_ioend;
>  
> -	if (ifs)
> -		atomic_add(map_len, &ifs->write_bytes_pending);
> +	iomap_start_folio_write(wpc->inode, folio, map_len);
>  
>  	/*
>  	 * Clamp io_offset and io_size to the incore EOF so that ondisk
> @@ -1880,7 +1890,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		 * all blocks.
>  		 */
>  		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
> -		atomic_inc(&ifs->write_bytes_pending);
> +		iomap_start_folio_write(inode, folio, 1);
>  	}
>  
>  	/*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 047100f94092..bfd178fb7cfc 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -460,6 +460,11 @@ void iomap_sort_ioends(struct list_head *ioend_list);
>  ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len);
>  int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
> +
> +void iomap_start_folio_write(struct inode *inode, struct folio *folio,
> +		size_t len);
> +void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
> +		size_t len);
>  int iomap_writepages(struct iomap_writepage_ctx *wpc);
>  
>  /*
> -- 
> 2.47.1
> 
> 

