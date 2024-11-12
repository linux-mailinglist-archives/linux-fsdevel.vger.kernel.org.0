Return-Path: <linux-fsdevel+bounces-34482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6449C5D6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA74A1F21BC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3420697B;
	Tue, 12 Nov 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9RrT33C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6709F20650E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429380; cv=none; b=mJype/E8JWfdxZnTCKmYQW1Klf0SmZNEjQi5MvZw1nKGV6xYrIJLzm9DJ5bXE8j0dIr2iltkkYH4iFkaoU6AmHeAywKtbBq+0bO2t7BOHBk5vHKcXwzlG3AW5wrcQRFEjnMsYRLb6fN+5nxIwVHZhSvIju/4CTAblpgsrRv7N04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429380; c=relaxed/simple;
	bh=O8YWXr0yLvNtoKRSJ3Vixa5YPoUh9gJ0YaA225ooMQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhkIPzhC/NPXSW0vs1b9PKvpwttkRG4KDWBlQLiMTnZB1gD3REZpbA+carhI43x4FRRK5CZ+5oFqc7VPf/9GVcghunbdLztq9HVfbQ06gV9X1HFd9RyFrHW5fdv08NxqyMNhRaNxNIZlmCcFptNPXYkhD6oalJnSFYa+DrRs/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9RrT33C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731429377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vshv/5C+8AN3xRIpFFRaIA6JN4+z8qS1tz/4w33plCw=;
	b=c9RrT33CUkupnJztz9jyw5MfEtIUtjliiTgK2AMDI1wIHVtl4ToHoV/Q1YGNezvXMKR5vT
	fzlghsvdGUDm893NMVCzNrW5UL2jwDnBNwoLGAyyHr/fmWDIpUmI02JtgX+mEJHhbGmPeN
	KXIHshx0HWEGNhAO02sY0uCFTDf8qNQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-2e90iJDzPXGIadG2_ei9PQ-1; Tue,
 12 Nov 2024 11:36:14 -0500
X-MC-Unique: 2e90iJDzPXGIadG2_ei9PQ-1
X-Mimecast-MFC-AGG-ID: 2e90iJDzPXGIadG2_ei9PQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7CEF19560B8;
	Tue, 12 Nov 2024 16:36:12 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFDC819560A3;
	Tue, 12 Nov 2024 16:36:10 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:37:43 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/16] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <ZzOEVwWpGEaq6wE7@bfoster>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-14-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234842.2024180-14-axboe@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 11, 2024 at 04:37:40PM -0700, Jens Axboe wrote:
> Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
> set for a write, mark the folios being written with drop_writeback. Then

s/drop_writeback/uncached/ ?

BTW, this might be getting into wonky "don't care that much" territory,
but something else to be aware of is that certain writes can potentially
change pagecache state as a side effect outside of the actual buffered
write itself.

For example, xfs calls iomap_zero_range() on write extension (i.e. pos >
isize), which uses buffered writes and thus could populate a pagecache
folio without setting it uncached, even if done on behalf of an uncached
write.

I've only made a first pass and could be missing some details, but IIUC
I _think_ this means something like writing out a stream of small,
sparse and file extending uncached writes could actually end up behaving
more like sync I/O. Again, not saying that's something we really care
about, just raising it in case it's worth considering or documenting..

Brian

> writeback completion will drop the pages. The write_iter handler simply
> kicks off writeback for the pages, and writeback completion will take
> care of the rest.
> 
> This still needs the user of the iomap buffered write helpers to call
> iocb_uncached_write() upon successful issue of the writes.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/iomap/buffered-io.c | 15 +++++++++++++--
>  include/linux/iomap.h  |  4 +++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ef0b68bccbb6..2f2a5db04a68 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -603,6 +603,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>  
>  	if (iter->flags & IOMAP_NOWAIT)
>  		fgp |= FGP_NOWAIT;
> +	if (iter->flags & IOMAP_UNCACHED)
> +		fgp |= FGP_UNCACHED;
>  	fgp |= fgf_set_order(len);
>  
>  	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> @@ -1023,8 +1025,9 @@ ssize_t
>  iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  		const struct iomap_ops *ops, void *private)
>  {
> +	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct iomap_iter iter = {
> -		.inode		= iocb->ki_filp->f_mapping->host,
> +		.inode		= mapping->host,
>  		.pos		= iocb->ki_pos,
>  		.len		= iov_iter_count(i),
>  		.flags		= IOMAP_WRITE,
> @@ -1034,9 +1037,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iter.flags |= IOMAP_NOWAIT;
> +	if (iocb->ki_flags & IOCB_UNCACHED)
> +		iter.flags |= IOMAP_UNCACHED;
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		if (iocb->ki_flags & IOCB_UNCACHED)
> +			iter.iomap.flags |= IOMAP_F_UNCACHED;
>  		iter.processed = iomap_write_iter(&iter, i);
> +	}
>  
>  	if (unlikely(iter.pos == iocb->ki_pos))
>  		return ret;
> @@ -1770,6 +1778,9 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  	size_t poff = offset_in_folio(folio, pos);
>  	int error;
>  
> +	if (folio_test_uncached(folio))
> +		wpc->iomap.flags |= IOMAP_F_UNCACHED;
> +
>  	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
>  new_ioend:
>  		error = iomap_submit_ioend(wpc, 0);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f61407e3b121..2efc72df19a2 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -64,6 +64,7 @@ struct vm_fault;
>  #define IOMAP_F_BUFFER_HEAD	0
>  #endif /* CONFIG_BUFFER_HEAD */
>  #define IOMAP_F_XATTR		(1U << 5)
> +#define IOMAP_F_UNCACHED	(1U << 6)
>  
>  /*
>   * Flags set by the core iomap code during operations:
> @@ -173,8 +174,9 @@ struct iomap_folio_ops {
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
>  #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
> +#define IOMAP_UNCACHED		(1 << 8) /* uncached IO */
>  #ifdef CONFIG_FS_DAX
> -#define IOMAP_DAX		(1 << 8) /* DAX mapping */
> +#define IOMAP_DAX		(1 << 9) /* DAX mapping */
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> -- 
> 2.45.2
> 
> 


