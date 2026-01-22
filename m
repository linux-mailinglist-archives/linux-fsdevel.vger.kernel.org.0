Return-Path: <linux-fsdevel+bounces-74956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJY4I4p2cWngHgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:59:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB56025A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A69D13C5AEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5BE31A05E;
	Thu, 22 Jan 2026 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmVGGU6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1C3191B4;
	Thu, 22 Jan 2026 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043578; cv=none; b=ID/DjzwaPn9FsNqAdnFlfmlqU0vbtqomcTKYJRpiTgGBSOJA8li5zlNbO5MQ+Z1xoeUIX7/WiIqFyoweBjBqbrvkK4L42eifbmcQoOCN95H07+4QKUEXWHfxMFveMaYCgQpa3gU+OAWGLoIJMqFpYg2cqftM29igD+IUyYwwdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043578; c=relaxed/simple;
	bh=xJZg5xNTIQ61gqB8pV0MVwLYISWmZSjRvSqPRIu1+F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyOxSgF7KPx5e8nesAFsVRg5AeUVLMNnLrS/c315twgrfa7GcxKZKKEm9weo9T3JEXoNru3yjzExNwMSkvNNJp1q20vGBgH2yKI6BF6aPSyLKXlhnEud0oBv6sWB2w1IlqZNVhP2w5CHoxmDC35haKbItSX5kaJFN+x4XMPIW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmVGGU6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB76C116D0;
	Thu, 22 Jan 2026 00:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043577;
	bh=xJZg5xNTIQ61gqB8pV0MVwLYISWmZSjRvSqPRIu1+F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmVGGU6B9QDQ4cYqEfYz2IOoyFq3XVYptBKm1a1k71QKA4LfAv4oTfMIkq9ucaq5b
	 17hzBnQ2m5MLIbAd4vVc15ZVAotfM3WnOsKMZ10/3lPfOVq1Ow6IC8Z3pZNBBQ+/lX
	 DGpXyyGtcewhrxM+74LJFJ93Xq6WMTBAItHZkcTvWxKZDJgUkUGM+epSJV6ZPfLHBj
	 KQHU/7Ebf/FZ8DLVhtcNF4sw56HG1Nf+wxmMvklX/xlCuqoT13Ii8T4EqGc8Pl1n/6
	 JDi55TFj/KDSv0x0stTSEHuOC/xdIOgOzWosmLUu5TtsDfACDDW769F2pKx3YTsB+9
	 leck/ARzdxlLA==
Date: Wed, 21 Jan 2026 16:59:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 14/15] iomap: support T10 protection information
Message-ID: <20260122005936.GR5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-15-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-74956-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ACB56025A
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:22AM +0100, Christoph Hellwig wrote:
> Add support for generating / verifying protection information in iomap.
> This is done by hooking into the bio submission and then using the
> generic PI helpers.  Compared to just using the block layer auto PI
> this extends the protection envelope and also prepares for eventually
> passing through PI from userspace at least for direct I/O.
> 
> To generate or verify PI, the file system needs to set the
> IOMAP_F_INTEGRITY flag on the iomap for the request, and ensure the
> ioends are used for all integrity I/O.  Additionally the file system
> should defer read I/O completions to user context so that the guard

  must ?

> tag validation isn't run from interrupt context.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/bio.c        | 24 +++++++++++++++++++++---
>  fs/iomap/direct-io.c  | 15 ++++++++++++++-
>  fs/iomap/internal.h   | 13 +++++++++++++
>  fs/iomap/ioend.c      | 20 ++++++++++++++++++--
>  include/linux/iomap.h |  7 +++++++
>  5 files changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index b4de67bdd513..f989ffcaac96 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (C) 2016-2023 Christoph Hellwig.
>   */
> +#include <linux/bio-integrity.h>
>  #include <linux/iomap.h>
>  #include <linux/pagemap.h>
>  #include "internal.h"
> @@ -17,6 +18,8 @@ static u32 __iomap_read_end_io(struct bio *bio, int error)
>  		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
>  		folio_count++;
>  	}
> +	if (bio_integrity(bio))
> +		fs_bio_integrity_free(bio);
>  	bio_put(bio);
>  	return folio_count;
>  }
> @@ -34,7 +37,11 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
>  static void iomap_bio_submit_read(const struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx)
>  {
> -	submit_bio(ctx->read_ctx);
> +	struct bio *bio = ctx->read_ctx;
> +
> +	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
> +		fs_bio_integrity_alloc(bio);
> +	submit_bio(bio);
>  }
>  
>  static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
> @@ -91,6 +98,7 @@ int iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  
>  	if (!bio ||
>  	    bio_end_sector(bio) != iomap_sector(&iter->iomap, iter->pos) ||
> +	    bio->bi_iter.bi_size > iomap_max_bio_size(&iter->iomap) - plen ||
>  	    !bio_add_folio(bio, folio, plen, offset_in_folio(folio, iter->pos)))
>  		iomap_read_alloc_bio(iter, ctx, plen);
>  	return 0;
> @@ -107,11 +115,21 @@ int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
>  		struct folio *folio, loff_t pos, size_t len)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	sector_t sector = iomap_sector(srcmap, pos);
>  	struct bio_vec bvec;
>  	struct bio bio;
> +	int error;
>  
>  	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> -	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> +	bio.bi_iter.bi_sector = sector;
>  	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
> -	return submit_bio_wait(&bio);
> +	if (srcmap->flags & IOMAP_F_INTEGRITY)
> +		fs_bio_integrity_alloc(&bio);
> +	error = submit_bio_wait(&bio);
> +	if (srcmap->flags & IOMAP_F_INTEGRITY) {
> +		if (!error)
> +			error = fs_bio_integrity_verify(&bio, sector, len);
> +		fs_bio_integrity_free(&bio);
> +	}
> +	return error;
>  }
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 842fc7fecb2d..831378a6ced4 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (c) 2016-2025 Christoph Hellwig.
>   */
> +#include <linux/bio-integrity.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/fscrypt.h>
>  #include <linux/pagemap.h>
> @@ -215,6 +216,9 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
>  
> +	if (bio_integrity(bio))
> +		fs_bio_integrity_free(bio);
> +
>  	if (dio->flags & IOMAP_DIO_BOUNCE) {
>  		bio_iov_iter_unbounce(bio, !!dio->error,
>  				dio->flags & IOMAP_DIO_USER_BACKED);
> @@ -325,8 +329,10 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> +
>  	if (dio->flags & IOMAP_DIO_BOUNCE)
> -		ret = bio_iov_iter_bounce(bio, dio->submit.iter, UINT_MAX);
> +		ret = bio_iov_iter_bounce(bio, dio->submit.iter,
> +				iomap_max_bio_size(&iter->iomap));
>  	else
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
>  					     alignment - 1);
> @@ -343,6 +349,13 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>  		goto out_put_bio;
>  	}
>  
> +	if (iter->iomap.flags & IOMAP_F_INTEGRITY) {
> +		if (dio->flags & IOMAP_DIO_WRITE)
> +			fs_bio_integrity_generate(bio);
> +		else
> +			fs_bio_integrity_alloc(bio);
> +	}
> +
>  	if (dio->flags & IOMAP_DIO_WRITE)
>  		task_io_account_write(ret);
>  	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index b39dbc17e3f0..cfe63de9e5c7 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -4,6 +4,19 @@
>  
>  #define IOEND_BATCH_SIZE	4096
>  
> +/*
> + * Normally we can build bios as big as the data structure supports.
> + *
> + * But for integrity protected I/O we need to respect the maximum size of the
> + * single contiguous allocation for the integrity buffer.
> + */
> +static inline size_t iomap_max_bio_size(const struct iomap *iomap)
> +{
> +	if (iomap->flags & IOMAP_F_INTEGRITY)
> +		return max_integrity_io_size(bdev_limits(iomap->bdev));
> +	return SIZE_MAX;
> +}
> +
>  u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend);
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>  
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 72f20e8c8893..a2931f8c454c 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) 2016-2025 Christoph Hellwig.
>   */
> +#include <linux/bio-integrity.h>
>  #include <linux/iomap.h>
>  #include <linux/list_sort.h>
>  #include <linux/pagemap.h>
> @@ -59,6 +60,8 @@ static u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
>  		folio_count++;
>  	}
>  
> +	if (bio_integrity(bio))
> +		fs_bio_integrity_free(bio);
>  	bio_put(bio);	/* frees the ioend */
>  	return folio_count;
>  }
> @@ -92,6 +95,8 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
>  		return error;
>  	}
>  
> +	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
> +		fs_bio_integrity_generate(&ioend->io_bio);
>  	submit_bio(&ioend->io_bio);
>  	return 0;
>  }
> @@ -113,10 +118,13 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  }
>  
>  static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
> -		u16 ioend_flags)
> +		unsigned int map_len, u16 ioend_flags)
>  {
>  	struct iomap_ioend *ioend = wpc->wb_ctx;
>  
> +	if (ioend->io_bio.bi_iter.bi_size >
> +	    iomap_max_bio_size(&wpc->iomap) - map_len)
> +		return false;
>  	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
>  		return false;
>  	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=

Unrelated question: should iomap_can_add_to_ioend return false if it did
an IOMAP_F_ANON_WRITE and the bdevs aren't the same, even if the sectors
match?  Currently not a problem for XFS, but some day we might want to
have a file that maps to zones on different devices.

The changes here otherwise look ok to me.

--D

> @@ -181,7 +189,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
>  		ioend_flags |= IOMAP_IOEND_BOUNDARY;
>  
> -	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> +	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, map_len, ioend_flags)) {
>  new_ioend:
>  		if (ioend) {
>  			error = wpc->ops->writeback_submit(wpc, 0);
> @@ -258,6 +266,14 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  
>  	if (!atomic_dec_and_test(&ioend->io_remaining))
>  		return 0;
> +
> +	if (!ioend->io_error &&
> +	    bio_integrity(&ioend->io_bio) &&
> +	    bio_op(&ioend->io_bio) == REQ_OP_READ) {
> +		ioend->io_error = fs_bio_integrity_verify(&ioend->io_bio,
> +			ioend->io_sector, ioend->io_size);
> +	}
> +
>  	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
>  		return iomap_finish_ioend_direct(ioend);
>  	if (bio_op(&ioend->io_bio) == REQ_OP_READ)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 24f884b6b0c4..bde16d619654 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -65,6 +65,8 @@ struct vm_fault;
>   *
>   * IOMAP_F_ATOMIC_BIO indicates that (write) I/O will be issued as an atomic
>   * bio, i.e. set REQ_ATOMIC.
> + *
> + * IOMAP_F_INTEGRITY indicates that the filesystems handles integrity metadata.
>   */
>  #define IOMAP_F_NEW		(1U << 0)
>  #define IOMAP_F_DIRTY		(1U << 1)
> @@ -79,6 +81,11 @@ struct vm_fault;
>  #define IOMAP_F_BOUNDARY	(1U << 6)
>  #define IOMAP_F_ANON_WRITE	(1U << 7)
>  #define IOMAP_F_ATOMIC_BIO	(1U << 8)
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +#define IOMAP_F_INTEGRITY	(1U << 9)
> +#else
> +#define IOMAP_F_INTEGRITY	0
> +#endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
>  /*
>   * Flag reserved for file system specific usage
> -- 
> 2.47.3
> 
> 

