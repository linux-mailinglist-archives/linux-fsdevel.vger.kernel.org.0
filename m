Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D223CEA26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347420AbhGSRH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244827AbhGSRD0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B0B6113A;
        Mon, 19 Jul 2021 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716644;
        bh=kW1l1kaum3Tpsa+sz63uanvZPNmQHO4sxydiOUWyvj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=El+xfRLj2mg/bGMIws6GMhs7JnBKPKKO2Gab2mn96havpF7CV4Wdhvj3mcL7CvSEk
         UNpVsp5pVq/8n0v+7IXBDeVDNLb/s3wLqv/+z64OiTftgqshyEjV+tkfJcVIDZFTAQ
         /d3cjWwxAaeCsHU2mBFjFiRWaJci44a84uTZ3ewLcOBinKnxn5E/iFcox7BLY7vQmV
         qUu676PiiHCDXrRBiztErPIrzFJOUw0tVLngs/Z0lGWIpGQ9X3y5hFMA4PWyzSowsr
         qJwJBHBtFgZl3EuSU1xcWE9dxI+P0eQOBnwELORK65y2LHPCuHSq0HkBtENvvm+pUI
         hHuyBeLsd9Y8A==
Date:   Mon, 19 Jul 2021 10:44:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 27/27] iomap: constify iomap_iter_srcmap
Message-ID: <20210719174403.GI22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-28-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:35:20PM +0200, Christoph Hellwig wrote:
> The srcmap returned from iomap_iter_srcmap is never modified, so mark
> the iomap returned from it const and constify a lot of code that never
> modifies the iomap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 32 ++++++++++++++++----------------
>  include/linux/iomap.h  |  2 +-
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index eb5d742b5bf8b7..a2dd42f3115cfa 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -226,20 +226,20 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>  	SetPageUptodate(page);
>  }
>  
> -static inline bool iomap_block_needs_zeroing(struct iomap_iter *iter,
> +static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  		loff_t pos)
>  {
> -	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  
>  	return srcmap->type != IOMAP_MAPPED ||
>  		(srcmap->flags & IOMAP_F_NEW) ||
>  		pos >= i_size_read(iter->inode);
>  }
>  
> -static loff_t iomap_readpage_iter(struct iomap_iter *iter,
> +static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx, loff_t offset)
>  {
> -	struct iomap *iomap = &iter->iomap;
> +	const struct iomap *iomap = &iter->iomap;
>  	loff_t pos = iter->pos + offset;
>  	loff_t length = iomap_length(iter) - offset;
>  	struct page *page = ctx->cur_page;
> @@ -355,7 +355,7 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_readpage);
>  
> -static loff_t iomap_readahead_iter(struct iomap_iter *iter,
> +static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
>  	loff_t length = iomap_length(iter);
> @@ -539,10 +539,10 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
>  	return submit_bio_wait(&bio);
>  }
>  
> -static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> +static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  		unsigned len, struct page *page)
>  {
> -	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct iomap_page *iop = iomap_page_create(iter->inode, page);
>  	loff_t block_size = i_blocksize(iter->inode);
>  	loff_t block_start = round_down(pos, block_size);
> @@ -580,11 +580,11 @@ static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	return 0;
>  }
>  
> -static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
> -		struct page **pagep)
> +static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> +		unsigned len, struct page **pagep)
>  {
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> -	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct page *page;
>  	int status = 0;
>  
> @@ -655,10 +655,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	return copied;
>  }
>  
> -static size_t iomap_write_end_inline(struct iomap_iter *iter, struct page *page,
> -		loff_t pos, size_t copied)
> +static size_t iomap_write_end_inline(const struct iomap_iter *iter,
> +		struct page *page, loff_t pos, size_t copied)
>  {
> -	struct iomap *iomap = &iter->iomap;
> +	const struct iomap *iomap = &iter->iomap;
>  	void *addr;
>  
>  	WARN_ON_ONCE(!PageUptodate(page));
> @@ -678,7 +678,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		size_t copied, struct page *page)
>  {
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> -	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t old_size = iter->inode->i_size;
>  	size_t ret;
>  
> @@ -803,7 +803,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
> -	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
>  	long status = 0;
> @@ -879,7 +879,7 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
>  	struct iomap *iomap = &iter->iomap;
> -	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
>  	loff_t written = 0;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 719798814bdfdb..a1fb0d22efbd40 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -193,7 +193,7 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
>   * for a given operation, which may or may no be identical to the destination
>   * map in &i->iomap.
>   */
> -static inline struct iomap *iomap_iter_srcmap(struct iomap_iter *i)
> +static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
>  {
>  	if (i->srcmap.type != IOMAP_HOLE)
>  		return &i->srcmap;
> -- 
> 2.30.2
> 
