Return-Path: <linux-fsdevel+bounces-69358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF220C779B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9C7C35CA05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D133508E;
	Fri, 21 Nov 2025 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfFscgXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B8334374;
	Fri, 21 Nov 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763707790; cv=none; b=S1xrSFG04gAu+jiZJsy5iogMQRQ8ECsNTNcTpDQWzivEtxMSpeDkUZ6caWZ0ekI/Arg8+8Hx2V/HMQblPAlQPwimj3/ORz1kluEioVetiNm9/aBJ1rNZXG7oQ814fZtQy6KI9/HQlx2XqzumL1CS9+r9B8TNMsvJ0/ylsPcw1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763707790; c=relaxed/simple;
	bh=Oy/3exAGfxwDg3eFLTOEHnCYzIB8o5gq5VjqAAj6IGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcN9QezoJ7h/trzGpO6F4Tuw5h7szNcY0SVTD0iymkQEIb1jAxh0TyniawW/KbCAS68baTazBmG8fNcjqDdvakpZa3v2WtuEvT8VY1YsMrZly4iW3Zrg3hOtoOk47QMSok39UBoK8GaxS6Xv9ScfrsUXtGkVFNK7T3yvasZQXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfFscgXA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6Z2wSgy2zyNNpnV1+nFigOTTA+9f/wicUJMD/M0cv00=; b=LfFscgXAyljwTAzbKdofiwBSIr
	YWYUsofssn/tG0skiwGrltv9b8ePvZePS7jNfK4RiziTFvUhkQwfCVX/Lhj34YMREUQNJtx3cnCgo
	7h6LtpoUjQ/SHzly93tP7y0XPAcX+U9M/upev6JqoLrk4y1DP9fa1XHxIggGAPOwcKCENGyKgCkoS
	l7IE7EycCTEb4p1yAlk1+4qtFZu0vsjCOPrWRmB2Rfq+uRivgN5cuIFXfFhaRUGjJTorUn1WlZCXR
	MePwiN9IDZ21Z1yUzef3f1Kaz1xYhy1CXVJqw8KHuyYeBDZBIBIgusRaoCC+kZf163AJiYgRPDfEr
	QKnUeDaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMKxa-00000007wJZ-1QWX;
	Fri, 21 Nov 2025 06:49:34 +0000
Date: Thu, 20 Nov 2025 22:49:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] f2fs: improve readahead for POSIX_FADV_WILLNEED
Message-ID: <aSALfvLUObUGSx-e@infradead.org>
References: <20251121014202.1969909-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121014202.1969909-1-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 21, 2025 at 01:42:01AM +0000, Jaegeuk Kim wrote:
> This patch boosts readahead for POSIX_FADV_WILLNEED.

How?  That's not a good changelog.

Also open coding the read-ahead logic is not a good idea.  The only
f2fs-specific bits are the compression check, and the extent precaching,
but you surely should be able to share a read-ahead helper with common
code instead of duplicating the logic.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h |  1 +
>  fs/f2fs/file.c |  9 +++++---
>  3 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a0433c8a4d84..d95974d79fb3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2710,6 +2710,67 @@ static void f2fs_readahead(struct readahead_control *rac)
>  	f2fs_mpage_readpages(inode, rac, NULL);
>  }
>  
> +int f2fs_readahead_pages(struct file *file, loff_t offset, loff_t len)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct address_space *mapping = file->f_mapping;
> +	pgoff_t start_index = offset >> PAGE_SHIFT;
> +	loff_t endbyte = offset + len;
> +	pgoff_t end_index;
> +	unsigned long nrpages;
> +	unsigned long ra_pages = (16 * 1024 * 1024) / PAGE_SIZE;
> +	DEFINE_READAHEAD(ractl, NULL, &file->f_ra, mapping, start_index);
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return -EOPNOTSUPP;
> +
> +	/* Should be read only. */
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> +	/* Do not support compressed file for large folio. */
> +	if (f2fs_compressed_file(inode))
> +		return -EINVAL;
> +
> +	if (!mapping || len < 0)
> +		return -EINVAL;
> +
> +	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
> +		return -EINVAL;
> +
> +	/* Load extent cache at the first readahead. */
> +	f2fs_precache_extents(inode);
> +
> +	/*
> +	 * Careful about overflows. Len == 0 means "as much as possible".  Use
> +	 * unsigned math because signed overflows are undefined and UBSan
> +	 * complains.
> +	 */
> +	if (!len || endbyte > i_size_read(inode) || endbyte < len)
> +		endbyte = i_size_read(inode) - 1;
> +	else
> +		endbyte--;		/* inclusive */
> +
> +	/* First and last PARTIAL page! */
> +	end_index = endbyte >> PAGE_SHIFT;
> +
> +	if (start_index > end_index)
> +		return 0;
> +
> +	nrpages = end_index - start_index + 1;
> +
> +	while (nrpages) {
> +		unsigned long this_chunk = min(nrpages, ra_pages);
> +
> +		ractl.ra->ra_pages = this_chunk;
> +
> +		page_cache_sync_ra(&ractl, this_chunk << 1);
> +
> +		nrpages -= this_chunk;
> +	}
> +	return 0;
> +}
> +
>  int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
>  {
>  	struct inode *inode = fio_inode(fio);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3340db04a7c2..934287cc5624 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4047,6 +4047,7 @@ int f2fs_init_bio_entry_cache(void);
>  void f2fs_destroy_bio_entry_cache(void);
>  void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
>  			  enum page_type type);
> +int f2fs_readahead_pages(struct file *file, loff_t offset, loff_t len);
>  int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
>  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index d7047ca6b98d..b6f71efd6d2a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5305,9 +5305,12 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
>  		filp->f_mode &= ~FMODE_RANDOM;
>  		spin_unlock(&filp->f_lock);
>  		return 0;
> -	} else if (advice == POSIX_FADV_WILLNEED && offset == 0) {
> -		/* Load extent cache at the first readahead. */
> -		f2fs_precache_extents(inode);
> +	} else if (advice == POSIX_FADV_WILLNEED) {
> +		if (offset == 0 && len == -1) {
> +			f2fs_precache_extents(inode);
> +			return 0;
> +		}
> +		return f2fs_readahead_pages(filp, offset, len);
>  	}
>  
>  	err = generic_fadvise(filp, offset, len, advice);
> -- 
> 2.52.0.487.g5c8c507ade-goog
> 
> 
---end quoted text---

