Return-Path: <linux-fsdevel+bounces-73324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E55D15965
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D23830249C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1E2BE64A;
	Mon, 12 Jan 2026 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG6Xj12p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116DF2853F7;
	Mon, 12 Jan 2026 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257356; cv=none; b=Lz2SOB5BQArrkM81lOrRYfgPOsVttQShRcfw/2bRZ91b9JTgx6qps1kutz7b9HKHAaQWmpeLQ1tq1ZQqclGh1aeXhUcqx2fdTgfDf4oGZIYJtg4XZmJW9xTsagq3gWjAcxi90X/OTvkn4ErGIGIv7jcfFRcl9ANiN/W9ZNmrbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257356; c=relaxed/simple;
	bh=AsobJndhDgMkQEPZWtjuM0Hl8EH91mSK5VJv/nea+VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDbItBseuzD+OMM2vNthzYKs7Zuollh4TNeePNe3FKU5EjowxuY2fiTgEPCqUZZwjys1q0u3JXBG+vhC8+JXIKOP0Ng1DgoyP1cx/PK/GSilcADqbucE2D/wo9r5q+tIs+lsSTh+h/3Q2/nPNCRp0fODZ/KyCfvXNE4rU/2mkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG6Xj12p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92342C116D0;
	Mon, 12 Jan 2026 22:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768257355;
	bh=AsobJndhDgMkQEPZWtjuM0Hl8EH91mSK5VJv/nea+VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rG6Xj12p4ZiwHe7/NnVTsappStpuKq7X4KI+Ep4HcIyacFi8XE7fGPnP6+Mo/zQmP
	 SOH7eSWUbwjw8Hb6aUoabViWGARxuHC0qCmSQqf3hUt8sO1D1ADpdm8T/9KsBADs/Y
	 C9FMSZz+K7E8w9vgWSL7Qo/7H+jV4pirfTXGtqjLtkVlElMLbk77VuTUGe5jB07Te6
	 EQUijV9djCcXTYDtgNqSTG5+2vBg5vvG18SPxii05Ot9+NWlarwgzZVa7bRJJhdu+E
	 txXI5q6/B8Hm+O2F34d+KhGQ54ESHtaARoG8T7+Y/1I6Fap6yOQKpgKf31fSSLF2Py
	 iUU7bug3enCSw==
Date: Mon, 12 Jan 2026 14:35:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 5/22] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20260112223555.GL15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <fm6mhsjqpa4tgpubffqp6rdeinvjkp6ugdmpafzelydx6sxep2@vriwphnloylb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fm6mhsjqpa4tgpubffqp6rdeinvjkp6ugdmpafzelydx6sxep2@vriwphnloylb>

On Mon, Jan 12, 2026 at 03:50:26PM +0100, Andrey Albershteyn wrote:
> This patch adds fs-verity verification into iomap's read path. After
> BIO's io operation is complete the data are verified against
> fs-verity's Merkle tree. Verification work is done in a separate
> workqueue.
> 
> The read path ioend iomap_read_ioend are stored side by side with
> BIOs if FS_VERITY is enabled.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/bio.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  fs/iomap/buffered-io.c | 12 ++++++++-
>  fs/iomap/ioend.c       | 41 +++++++++++++++++++++++++++++++-
>  include/linux/iomap.h  | 11 ++++++++
>  4 files changed, 123 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index fc045f2e4c..ac6c16b1f8 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/iomap.h>
>  #include <linux/pagemap.h>
> +#include <linux/fsverity.h>
>  #include "internal.h"
>  #include "trace.h"
>  
> @@ -18,6 +19,60 @@
>  	bio_put(bio);
>  }
>  
> +#ifdef CONFIG_FS_VERITY

Should all this stuff go into fs/iomap/fsverity.c instead of ifdef'd
around the iomap code?

<shrug>

> +static void
> +iomap_read_fsverify_end_io_work(struct work_struct *work)
> +{
> +	struct iomap_fsverity_bio *fbio =
> +		container_of(work, struct iomap_fsverity_bio, work);
> +
> +	fsverity_verify_bio(&fbio->bio);
> +	iomap_read_end_io(&fbio->bio);
> +}
> +
> +static void
> +iomap_read_fsverity_end_io(struct bio *bio)
> +{
> +	struct iomap_fsverity_bio *fbio =
> +		container_of(bio, struct iomap_fsverity_bio, bio);
> +
> +	INIT_WORK(&fbio->work, iomap_read_fsverify_end_io_work);
> +	fsverity_enqueue_verify_work(&fbio->work);
> +}
> +
> +static struct bio *
> +iomap_fsverity_read_bio_alloc(struct inode *inode, struct block_device *bdev,
> +			    int nr_vecs, gfp_t gfp)
> +{
> +	struct bio *bio;
> +
> +	bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
> +			iomap_fsverity_bioset);
> +	if (bio)
> +		bio->bi_end_io = iomap_read_fsverity_end_io;
> +	return bio;
> +}
> +
> +#else
> +# define iomap_fsverity_read_bio_alloc(...)	(NULL)
> +# define iomap_fsverity_tree_end_align(...)	(false)
> +#endif /* CONFIG_FS_VERITY */
> +
> +static struct bio *iomap_read_bio_alloc(struct inode *inode,
> +		const struct iomap *iomap, int nr_vecs, gfp_t gfp)
> +{
> +	struct bio *bio;
> +	struct block_device *bdev = iomap->bdev;
> +
> +	if (!(iomap->flags & IOMAP_F_BEYOND_EOF) && fsverity_active(inode))
> +		return iomap_fsverity_read_bio_alloc(inode, bdev, nr_vecs, gfp);
> +
> +	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
> +	if (bio)
> +		bio->bi_end_io = iomap_read_end_io;
> +	return bio;
> +}
> +
>  static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
>  {
>  	struct bio *bio = ctx->read_ctx;
> @@ -42,26 +97,27 @@
>  	    !bio_add_folio(bio, folio, plen, poff)) {
>  		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
> -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>  
>  		if (bio)
>  			submit_bio(bio);
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
> -				     gfp);
> +		bio = iomap_read_bio_alloc(iter->inode, iomap,
> +				bio_max_segs(DIV_ROUND_UP(length, PAGE_SIZE)),
> +				gfp);
> +
>  		/*
>  		 * If the bio_alloc fails, try it again for a single page to
>  		 * avoid having to deal with partial page reads.  This emulates
>  		 * what do_mpage_read_folio does.
>  		 */
>  		if (!bio)
> -			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> +			bio = iomap_read_bio_alloc(iter->inode, iomap, 1,
> +						   orig_gfp);
>  		if (ctx->rac)
>  			bio->bi_opf |= REQ_RAHEAD;
>  		bio->bi_iter.bi_sector = sector;
> -		bio->bi_end_io = iomap_read_end_io;
>  		bio_add_folio_nofail(bio, folio, plen, poff);
>  		ctx->read_ctx = bio;
>  	}
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 79d1c97f02..481f7e1cff 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -8,6 +8,7 @@
>  #include <linux/writeback.h>
>  #include <linux/swap.h>
>  #include <linux/migrate.h>
> +#include <linux/fsverity.h>
>  #include "internal.h"
>  #include "trace.h"
>  
> @@ -532,10 +533,19 @@
>  		if (plen == 0)
>  			return 0;
>  
> +		/* end of fs-verity region*/
> +		if ((iomap->flags & IOMAP_F_BEYOND_EOF) && (iomap->type == IOMAP_HOLE)) {

Overly long line.

Also, when do we get the combination of BEYOND_EOF && HOLE?  Is that for
sparse regions in only the merkle tree?  IIRC (and I could be wrong)
fsverity still wants to checksum sparse holes in the regular file data,
right?

> +			folio_zero_range(folio, poff, plen);
> +			iomap_set_range_uptodate(folio, poff, plen);
> +		}
>  		/* zero post-eof blocks as the page may be mapped */
> -		if (iomap_block_needs_zeroing(iter, pos) &&
> +		else if (iomap_block_needs_zeroing(iter, pos) &&

		} else if (...

(nitpicking indentation)

>  		    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
>  			folio_zero_range(folio, poff, plen);
> +			if (fsverity_active(iter->inode) &&
> +			    !fsverity_verify_blocks(folio, plen, poff)) {
> +				return -EIO;
> +			}
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
>  			if (!*bytes_submitted)
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 86f44922ed..30c0de3c75 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -9,6 +9,8 @@
>  #include "internal.h"
>  #include "trace.h"
>  
> +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))

How do we arrive at this pool size?  How is it important to have a
larger bio reserve pool for *larger* base page sizes?

--D

> +
>  struct bio_set iomap_ioend_bioset;
>  EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
>  
> @@ -423,9 +425,46 @@
>  }
>  EXPORT_SYMBOL_GPL(iomap_split_ioend);
>  
> +#ifdef CONFIG_FS_VERITY
> +struct bio_set *iomap_fsverity_bioset;
> +EXPORT_SYMBOL_GPL(iomap_fsverity_bioset);
> +int iomap_fsverity_init_bioset(void)
> +{
> +	struct bio_set *bs, *old;
> +	int error;
> +
> +	bs = kzalloc(sizeof(*bs), GFP_KERNEL);
> +	if (!bs)
> +		return -ENOMEM;
> +
> +	error = bioset_init(bs, IOMAP_POOL_SIZE,
> +			    offsetof(struct iomap_fsverity_bio, bio),
> +			    BIOSET_NEED_BVECS);
> +	if (error) {
> +		kfree(bs);
> +		return error;
> +	}
> +
> +	/*
> +	 * This has to be atomic as readaheads can race to create the
> +	 * bioset.  If someone set the pointer before us, we drop ours.
> +	 */
> +	old = cmpxchg(&iomap_fsverity_bioset, NULL, bs);
> +	if (old) {
> +		bioset_exit(bs);
> +		kfree(bs);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iomap_fsverity_init_bioset);
> +#else
> +# define iomap_fsverity_init_bioset(...)	(-EOPNOTSUPP)
> +#endif
> +
>  static int __init iomap_ioend_init(void)
>  {
> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> +	return bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
>  			   offsetof(struct iomap_ioend, io_bio),
>  			   BIOSET_NEED_BVECS);
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 7a7e31c499..b451ab3426 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -342,6 +342,17 @@
>  		iter->srcmap.type == IOMAP_MAPPED;
>  }
>  
> +#ifdef CONFIG_FS_VERITY
> +extern struct bio_set *iomap_fsverity_bioset;
> +
> +struct iomap_fsverity_bio {
> +	struct work_struct	work;
> +	struct bio		bio;
> +};
> +
> +int iomap_fsverity_init_bioset(void);
> +#endif
> +
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private);
> 
> -- 
> - Andrey
> 
> 

