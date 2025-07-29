Return-Path: <linux-fsdevel+bounces-56292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC4B155E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C9B1724B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3318286413;
	Tue, 29 Jul 2025 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBByRH2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A72749DA;
	Tue, 29 Jul 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831313; cv=none; b=r4ztwqYgRx6h64IHXluHQT5OfJQQP2EFGpgclkMTq5DIB1H9/hl0JCIFmnqIHirlbr9IwsUwvpmnU+Z/SMayeZwjyTsserh87S93XnHG7qByQGQKhTpu/TTh8+6pevLnK14++khSwxGvkDVN8Ea46wA0gSHDh9olEXFnKpfa+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831313; c=relaxed/simple;
	bh=XGXPTsXjSoXxokVLjEMmsbbayKlM+E2fBYHv0MbsMoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/pK7EFojjWpUZT/evjHo5j38XSUHpbLkWx7DaFov9rDSJj30Kj+IjbKFdWuqUL9zwSOa+kShdHW0cUdG1u0cYZNMxgoq6zBhhLEC0MOhdGA3ieGWfDwi9B2lWa7SmJ9bdkU/jPTOtXFka5HMFawb6IwZFGgNwyIGTF5L1kE4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBByRH2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE68C4CEF6;
	Tue, 29 Jul 2025 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831312;
	bh=XGXPTsXjSoXxokVLjEMmsbbayKlM+E2fBYHv0MbsMoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBByRH2laThjlzT/uajg7XV9gfBYa8hVpyzY6DJM33TBOdXTW87NO6oBRXkbLHl2D
	 gbkNz56mK4n1SO7LjUt9aRkcLg247tSXp+SHoLO9/6edbjVNCoWY4AnXOTcMPkVMZa
	 JXbpuem8wnkZZYg3JAv7VWyBgts0ec6xjzDPoCPAj1tZWKtn2WSNPKbFhjn8Tn8w6f
	 bnvg+yV6zdhq/wV4UVjyGdbOASgra79Mj/ALXwUlTB8EPEeKbPW3+q/sGFOBRdXbYZ
	 TqUXJBqaGN0k348Vj1gB2I14+WX2QKHZ4IJxhnTAGqM8ZvBPKzoAiEzgH5ma2Jk90K
	 XzUZP/mjJUQNQ==
Date: Tue, 29 Jul 2025 16:21:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 13/29] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20250729232152.GP2672049@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-13-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-13-9e5443af0e34@kernel.org>

On Mon, Jul 28, 2025 at 10:30:17PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> This patch adds fs-verity verification into iomap's read path. After
> BIO's io operation is complete the data are verified against
> fs-verity's Merkle tree. Verification work is done in a separate
> workqueue.
> 
> The read path ioend iomap_read_ioend are stored side by side with
> BIOs if FS_VERITY is enabled.
> 
> [djwong: fix doc warning]
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/iomap/ioend.c       |  41 +++++++++++++-
>  include/linux/iomap.h  |  13 +++++
>  3 files changed, 198 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e959a206cba9..87c974e543e0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> +#include <linux/fsverity.h>
>  #include <linux/iomap.h>
>  #include <linux/pagemap.h>
>  #include <linux/uio.h>
> @@ -363,6 +364,116 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  		pos >= i_size_read(iter->inode);
>  }
>  
> +#ifdef CONFIG_FS_VERITY
> +int iomap_init_fsverity(struct super_block *sb, unsigned int wq_flags,
> +			int max_active)
> +{
> +	int ret;
> +
> +	if (!iomap_fsverity_bioset) {
> +		ret = iomap_fsverity_init_bioset();
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return fsverity_init_wq(sb, wq_flags, max_active);
> +}
> +EXPORT_SYMBOL_GPL(iomap_init_fsverity);
> +
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
> +	queue_work(bio->bi_private, &fbio->work);
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
> +	if (bio) {
> +		bio->bi_private = inode->i_sb->s_verity_wq;
> +		bio->bi_end_io = iomap_read_fsverity_end_io;
> +	}
> +	return bio;
> +}
> +
> +/*
> + * True if tree is not aligned with fs block/folio size and we need zero tail
> + * part of the folio
> + */
> +static bool
> +iomap_fsverity_tree_end_align(struct iomap_iter *iter, struct folio *folio,
> +		loff_t pos, size_t plen)
> +{
> +	int error;
> +	u8 log_blocksize;
> +	u64 tree_size, tree_mask, last_block_tree, last_block_pos;
> +
> +	/* Not a Merkle tree */
> +	if (!(iter->iomap.flags & IOMAP_F_BEYOND_EOF))
> +		return false;
> +
> +	if (plen == folio_size(folio))
> +		return false;
> +
> +	if (iter->inode->i_blkbits == folio_shift(folio))
> +		return false;
> +
> +	error = fsverity_merkle_tree_geometry(iter->inode, &log_blocksize, NULL,
> +			&tree_size);
> +	if (error)
> +		return false;
> +
> +	/*
> +	 * We are beyond EOF reading Merkle tree. Therefore, it has highest
> +	 * offset. Mask pos with a tree size to get a position whare are we in
> +	 * the tree. Then, compare index of a last tree block and the index of
> +	 * current pos block.
> +	 */
> +	last_block_tree = (tree_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	tree_mask = (1 << fls64(tree_size)) - 1;
> +	last_block_pos = ((pos & tree_mask) >> PAGE_SHIFT) + 1;
> +
> +	return last_block_tree == last_block_pos;
> +}
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
> +	if (fsverity_active(inode) && !(iomap->flags & IOMAP_F_BEYOND_EOF))
> +		return iomap_fsverity_read_bio_alloc(inode, bdev, nr_vecs, gfp);
> +
> +	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
> +	if (bio)
> +		bio->bi_end_io = iomap_read_end_io;
> +	return bio;
> +}
> +
>  static int iomap_readpage_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> @@ -375,6 +486,10 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	sector_t sector;
>  	int ret;
>  
> +	/* Fail reads from broken fsverity files immediately. */
> +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
> +		return -EIO;
> +
>  	if (iomap->type == IOMAP_INLINE) {
>  		ret = iomap_read_inline_data(iter, folio);
>  		if (ret)
> @@ -391,6 +506,11 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	if (iomap_block_needs_zeroing(iter, pos) &&
>  	    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
>  		folio_zero_range(folio, poff, plen);
> +		if (fsverity_active(iter->inode) &&
> +		    !fsverity_verify_blocks(folio, plen, poff)) {
> +			return -EIO;
> +		}
> +
>  		iomap_set_range_uptodate(folio, poff, plen);
>  		goto done;
>  	}
> @@ -408,32 +528,51 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
>  		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
> -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>  
>  		if (ctx->bio)
>  			submit_bio(ctx->bio);
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> +
> +		ctx->bio = iomap_read_bio_alloc(iter->inode, iomap,
> +				bio_max_segs(DIV_ROUND_UP(length, PAGE_SIZE)),
> +				gfp);
> +
>  		/*
>  		 * If the bio_alloc fails, try it again for a single page to
>  		 * avoid having to deal with partial page reads.  This emulates
>  		 * what do_mpage_read_folio does.
>  		 */
>  		if (!ctx->bio) {
> -			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
> -					     orig_gfp);
> +			ctx->bio = iomap_read_bio_alloc(iter->inode,
> +					iomap, 1, orig_gfp);
>  		}
>  		if (ctx->rac)
>  			ctx->bio->bi_opf |= REQ_RAHEAD;
>  		ctx->bio->bi_iter.bi_sector = sector;
> -		ctx->bio->bi_end_io = iomap_read_end_io;
>  		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
>  	}
>  
>  done:
> +	/*
> +	 * For post EOF region, zero part of the folio which won't be read. This
> +	 * happens at the end of the region. So far, the only user is
> +	 * fs-verity which stores continuous data region.

Is it ever the case that the zeroed region actually has merkle tree
content on disk?  Or if this region truly was never written by the
fsverity construction code, then why would it access the unwritten
region later?

Or am I misunderstanding something here?

(Probably...)

--D

> +	 * We also check the fs block size as plen could be smaller than the
> +	 * block size. If we zero part of the block and mark the whole block
> +	 * (iomap_set_range_uptodate() works with fsblocks) as uptodate the
> +	 * iomap_finish_folio_read() will toggle the uptodate bit when the folio
> +	 * is read.
> +	 */
> +	if (iomap_fsverity_tree_end_align(iter, folio, pos, plen)) {
> +		folio_zero_range(folio, poff + plen,
> +				folio_size(folio) - (poff + plen));
> +		iomap_set_range_uptodate(folio, poff + plen,
> +				folio_size(folio) - (poff + plen));
> +	}
> +
>  	/*
>  	 * Move the caller beyond our range so that it keeps making progress.
>  	 * For that, we have to include any leading non-uptodate ranges, but
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 18894ebba6db..400751d82313 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -6,6 +6,8 @@
>  #include <linux/list_sort.h>
>  #include "internal.h"
>  
> +#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
> +
>  struct bio_set iomap_ioend_bioset;
>  EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
>  
> @@ -207,9 +209,46 @@ struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
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
> index 73288f28543f..f845876ad8d2 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -339,6 +339,19 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
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
> +int iomap_init_fsverity(struct super_block *sb, unsigned int wq_flags,
> +			int max_active);
> +int iomap_fsverity_init_bioset(void);
> +#endif
> +
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
> 
> -- 
> 2.50.0
> 
> 

