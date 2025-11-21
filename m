Return-Path: <linux-fsdevel+bounces-69446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A52C7B39D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94BE14F01E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74B350A27;
	Fri, 21 Nov 2025 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBgTcmnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90634F248;
	Fri, 21 Nov 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748304; cv=none; b=Hq/lNVfJ5jlkKYUzMudG9p7TtKsKyodYrLwN6xGjjKNzubblh18rIgP0+QKi9kZcAZUX1a247lkyrGywgdbAJdfSPer4aQc0mMdnwujjzSoknLjB2MQmc60wWB8mlbDwdfsablrjlX6DyT5US3UKKTD0Qbvv9gZQ4l2Is0BmxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748304; c=relaxed/simple;
	bh=6jQ6lGWb2XGclgEVJ+zij91b54xGPUPNrXP9Fgrtip4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7zkIp+mcNqOtVoyvfDaxAwgtbuwx2j/09GTmx3uCTWzFB4jXK0OFsGOvClQ24qPKzR2cSEqLwBuGIpN8KsTEcvvjhvc5z9vJmD957F91J3eOyuYD9xcVIjVqd96q+L+VUp+IfhHUF7hMuLWUBjF9/TA9M5QQTB5e61b+KJ3Rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBgTcmnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231CCC116C6;
	Fri, 21 Nov 2025 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748303;
	bh=6jQ6lGWb2XGclgEVJ+zij91b54xGPUPNrXP9Fgrtip4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBgTcmnwJrZ1+/3QcGrLPplzwWBbMG+3sWVbJLN1FsK+6Kd7TvClQcCxFCTylY8zh
	 bfV/FQTodj3YEi+N3PF57piWGirT4j0ZXDbtvQRA80cYog4nLcINqIjq4+8pVQlCEO
	 diWY6pz2yAwitgblNOcfwLJCKnM02+OEkF4tkSSiusXhvzMDGAX+K+LiEMpobifCDa
	 tAga5HiW01jocQrnJg4JeQVKaoFqpO1fukO2xgYHh/Hf+Ubi+MZ792YjRom0ISUGgL
	 XRNkFcXIL5uYrSSuBvlL4gQPCkE0wTsQO2lFHsDOD58f+G8DRIuICTeZpXjS/gcaSO
	 JOIzIy32Es22g==
Date: Fri, 21 Nov 2025 18:05:01 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] f2fs: improve readahead for POSIX_FADV_WILLNEED
Message-ID: <aSCpzRW8mUhNnjHB@google.com>
References: <20251121014202.1969909-1-jaegeuk@kernel.org>
 <aSALfvLUObUGSx-e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSALfvLUObUGSx-e@infradead.org>

On 11/20, Christoph Hellwig wrote:
> On Fri, Nov 21, 2025 at 01:42:01AM +0000, Jaegeuk Kim wrote:
> > This patch boosts readahead for POSIX_FADV_WILLNEED.
> 
> How?  That's not a good changelog.
> 
> Also open coding the read-ahead logic is not a good idea.  The only
> f2fs-specific bits are the compression check, and the extent precaching,
> but you surely should be able to share a read-ahead helper with common
> code instead of duplicating the logic.

Ok, let me try to write up and post a generic version of the changes.

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/f2fs/f2fs.h |  1 +
> >  fs/f2fs/file.c |  9 +++++---
> >  3 files changed, 68 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index a0433c8a4d84..d95974d79fb3 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2710,6 +2710,67 @@ static void f2fs_readahead(struct readahead_control *rac)
> >  	f2fs_mpage_readpages(inode, rac, NULL);
> >  }
> >  
> > +int f2fs_readahead_pages(struct file *file, loff_t offset, loff_t len)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +	struct address_space *mapping = file->f_mapping;
> > +	pgoff_t start_index = offset >> PAGE_SHIFT;
> > +	loff_t endbyte = offset + len;
> > +	pgoff_t end_index;
> > +	unsigned long nrpages;
> > +	unsigned long ra_pages = (16 * 1024 * 1024) / PAGE_SIZE;
> > +	DEFINE_READAHEAD(ractl, NULL, &file->f_ra, mapping, start_index);
> > +
> > +	if (!S_ISREG(inode->i_mode))
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Should be read only. */
> > +	if (!(file->f_mode & FMODE_READ))
> > +		return -EBADF;
> > +
> > +	/* Do not support compressed file for large folio. */
> > +	if (f2fs_compressed_file(inode))
> > +		return -EINVAL;
> > +
> > +	if (!mapping || len < 0)
> > +		return -EINVAL;
> > +
> > +	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
> > +		return -EINVAL;
> > +
> > +	/* Load extent cache at the first readahead. */
> > +	f2fs_precache_extents(inode);
> > +
> > +	/*
> > +	 * Careful about overflows. Len == 0 means "as much as possible".  Use
> > +	 * unsigned math because signed overflows are undefined and UBSan
> > +	 * complains.
> > +	 */
> > +	if (!len || endbyte > i_size_read(inode) || endbyte < len)
> > +		endbyte = i_size_read(inode) - 1;
> > +	else
> > +		endbyte--;		/* inclusive */
> > +
> > +	/* First and last PARTIAL page! */
> > +	end_index = endbyte >> PAGE_SHIFT;
> > +
> > +	if (start_index > end_index)
> > +		return 0;
> > +
> > +	nrpages = end_index - start_index + 1;
> > +
> > +	while (nrpages) {
> > +		unsigned long this_chunk = min(nrpages, ra_pages);
> > +
> > +		ractl.ra->ra_pages = this_chunk;
> > +
> > +		page_cache_sync_ra(&ractl, this_chunk << 1);
> > +
> > +		nrpages -= this_chunk;
> > +	}
> > +	return 0;
> > +}
> > +
> >  int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
> >  {
> >  	struct inode *inode = fio_inode(fio);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 3340db04a7c2..934287cc5624 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -4047,6 +4047,7 @@ int f2fs_init_bio_entry_cache(void);
> >  void f2fs_destroy_bio_entry_cache(void);
> >  void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
> >  			  enum page_type type);
> > +int f2fs_readahead_pages(struct file *file, loff_t offset, loff_t len);
> >  int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
> >  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
> >  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index d7047ca6b98d..b6f71efd6d2a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -5305,9 +5305,12 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
> >  		filp->f_mode &= ~FMODE_RANDOM;
> >  		spin_unlock(&filp->f_lock);
> >  		return 0;
> > -	} else if (advice == POSIX_FADV_WILLNEED && offset == 0) {
> > -		/* Load extent cache at the first readahead. */
> > -		f2fs_precache_extents(inode);
> > +	} else if (advice == POSIX_FADV_WILLNEED) {
> > +		if (offset == 0 && len == -1) {
> > +			f2fs_precache_extents(inode);
> > +			return 0;
> > +		}
> > +		return f2fs_readahead_pages(filp, offset, len);
> >  	}
> >  
> >  	err = generic_fadvise(filp, offset, len, advice);
> > -- 
> > 2.52.0.487.g5c8c507ade-goog
> > 
> > 
> ---end quoted text---

