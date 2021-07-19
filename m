Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE523CEA27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbhGSRIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353348AbhGSREL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05BEF610FB;
        Mon, 19 Jul 2021 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716682;
        bh=gwGuV8sGJDDh7S/VDyRXUZPBUpAgXRbjYPrdH+XeSO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SL3ib1NOoZSgayuaZnqguxYWuQOyGocRJ+73vpqXYKXlyCzH024iH//UfHfJopNp2
         wfg5Wag3Ejll+8wOKxcsPqvMv1QxFT59wrX8/Yuh1ecvgGOxXf000ZBScuwPgGFbwj
         zycTTxazZQQnV4Ue0zd6yoKAdkhsBIIy98DsmkoyuQlyRRL5nIqw3S7Zc6h/bpVFdY
         9MMGdqxMuOpjDSprFcO/vShX2QUm0k+GFU+U5SOAJVv8GSyezp/Ja/Vhna9it4Jmkd
         UVFA5pucTnCKXbL+U7B3zMNnlhbspiDxQqAfXmjbMqz5jGV84IkCRLrlj+XXMJacrh
         X2TFWm4il5/Sw==
Date:   Mon, 19 Jul 2021 10:44:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 23/27] iomap: rework unshare flag
Message-ID: <20210719174441.GJ22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-24-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:35:16PM +0200, Christoph Hellwig wrote:
> Instead of another internal flags namespace inside of buffered-io.c,
> just pass a UNSHARE hint in the main iomap flags field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 23 +++++++++--------------
>  include/linux/iomap.h  |  1 +
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index daabbe8d7edfb5..eb5d742b5bf8b7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -511,10 +511,6 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  EXPORT_SYMBOL_GPL(iomap_migrate_page);
>  #endif /* CONFIG_MIGRATION */
>  
> -enum {
> -	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
> -};

Oh good, this finally dies.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> -
>  static void
>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  {
> @@ -544,7 +540,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
>  }
>  
>  static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> -		unsigned len, int flags, struct page *page)
> +		unsigned len, struct page *page)
>  {
>  	struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct iomap_page *iop = iomap_page_create(iter->inode, page);
> @@ -563,13 +559,13 @@ static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  		if (plen == 0)
>  			break;
>  
> -		if (!(flags & IOMAP_WRITE_F_UNSHARE) &&
> +		if (!(iter->flags & IOMAP_UNSHARE) &&
>  		    (from <= poff || from >= poff + plen) &&
>  		    (to <= poff || to >= poff + plen))
>  			continue;
>  
>  		if (iomap_block_needs_zeroing(iter, block_start)) {
> -			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
> +			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
>  				return -EIO;
>  			zero_user_segments(page, poff, from, to, poff + plen);
>  		} else {
> @@ -585,7 +581,7 @@ static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  }
>  
>  static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
> -		unsigned flags, struct page **pagep)
> +		struct page **pagep)
>  {
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -617,7 +613,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
>  	else if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
> -		status = __iomap_write_begin(iter, pos, len, flags, page);
> +		status = __iomap_write_begin(iter, pos, len, page);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
> @@ -748,7 +744,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter, pos, bytes, 0, &page);
> +		status = iomap_write_begin(iter, pos, bytes, &page);
>  		if (unlikely(status))
>  			break;
>  
> @@ -825,8 +821,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
>  		struct page *page;
>  
> -		status = iomap_write_begin(iter, pos, bytes,
> -				IOMAP_WRITE_F_UNSHARE, &page);
> +		status = iomap_write_begin(iter, pos, bytes, &page);
>  		if (unlikely(status))
>  			return status;
>  
> @@ -854,7 +849,7 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		.inode		= inode,
>  		.pos		= pos,
>  		.len		= len,
> -		.flags		= IOMAP_WRITE,
> +		.flags		= IOMAP_WRITE | IOMAP_UNSHARE,
>  	};
>  	int ret;
>  
> @@ -871,7 +866,7 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  	unsigned offset = offset_in_page(pos);
>  	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
>  
> -	status = iomap_write_begin(iter, pos, bytes, 0, &page);
> +	status = iomap_write_begin(iter, pos, bytes, &page);
>  	if (status)
>  		return status;
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 2f13e34c2c0b0b..719798814bdfdb 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -122,6 +122,7 @@ struct iomap_page_ops {
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
> +#define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.30.2
> 
