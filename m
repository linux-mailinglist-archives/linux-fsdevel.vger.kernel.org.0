Return-Path: <linux-fsdevel+bounces-56429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6556B173C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E491C2588E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912A1ACED9;
	Thu, 31 Jul 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNxZoOxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB70190477;
	Thu, 31 Jul 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974499; cv=none; b=IyLrauuJDLipc+5Dw1DG0YSyoRHyWGZnyfXSOCuaKqvRtDOrkP8rU6/oyyG/jY6eUW1zle23hbqMqu5EkXuknDioJipBHyxgjv3lFJThl49PCLijK7KaoUIHFvcp1cwYu8olV+thQCspsVkQNgyp2W0mzvo9JxP/u6OkrTbVnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974499; c=relaxed/simple;
	bh=yJTpMpn3Xo67C3sQjAKMGM/F1kwdS7qjBQf3ameXedY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YElkyuqI6xq4H2dLPVFId4SAWa3sy8JBRbNioD+Mer3v+89vIlScCb3HPeagCb5fu0mi/CPSneUAjxqg7w35ysXHmLuIAzvtuObtFOsueEp132jkVT2ie8eA0o7EUoERRdSOMEQBni4qDROIWjzu1EloSMVlw6wN4n4924wItwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNxZoOxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F00EC4CEEF;
	Thu, 31 Jul 2025 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753974499;
	bh=yJTpMpn3Xo67C3sQjAKMGM/F1kwdS7qjBQf3ameXedY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNxZoOxZsvv9wg2bmo6O5TzcMKL97v6dxCscTC1Ezfty8SYYNQXhCSC4Xod3qUyT1
	 FNzHt/0SrzfsFHxIFHiq1fmQ6T5dkAFv29aUBHEL+0JVaxmSgE1SGnrOxXZKfX26sB
	 Q4PMpNNdAczqcd+JA/xPIjIWHVbTdrJgaJCLJYEY/mHyjebcyT8MaY7QuCPL0d4d/t
	 rE4hfybM8giavz3ZaMybX1SJj6vC3k1D1rLnUQaaWa805cLOjyvniQ0XiwIlRKeqMk
	 L9bDHRXqQ1GxFEbASL0qvuOBh84yi73xMoJK7dXhjXMhq2aWnYAnemSkloQoZ5+MkN
	 SuPUNznLs4Ceg==
Date: Thu, 31 Jul 2025 08:08:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 13/29] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <20250731150818.GC2672029@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-13-9e5443af0e34@kernel.org>
 <20250729232152.GP2672049@frogsfrogsfrogs>
 <f767jjbn25ffuigxnigsi7kz6tqvfqkbk4j2xs3mobtyhnmqip@24mjx53j3axv>
 <20250731145233.GA2672029@frogsfrogsfrogs>
 <oy45h4xpktjswnwnwgzp6ihqif2bgplslwgctbcotdjum4jh5v@wbnx7syzucvk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oy45h4xpktjswnwnwgzp6ihqif2bgplslwgctbcotdjum4jh5v@wbnx7syzucvk>

On Thu, Jul 31, 2025 at 05:01:48PM +0200, Andrey Albershteyn wrote:
> On 2025-07-31 07:52:33, Darrick J. Wong wrote:
> > On Thu, Jul 31, 2025 at 01:34:24PM +0200, Andrey Albershteyn wrote:
> > > On 2025-07-29 16:21:52, Darrick J. Wong wrote:
> > > > On Mon, Jul 28, 2025 at 10:30:17PM +0200, Andrey Albershteyn wrote:
> > > > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > 
> > > > > This patch adds fs-verity verification into iomap's read path. After
> > > > > BIO's io operation is complete the data are verified against
> > > > > fs-verity's Merkle tree. Verification work is done in a separate
> > > > > workqueue.
> > > > > 
> > > > > The read path ioend iomap_read_ioend are stored side by side with
> > > > > BIOs if FS_VERITY is enabled.
> > > > > 
> > > > > [djwong: fix doc warning]
> > > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > > ---
> > > > >  fs/iomap/buffered-io.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++--
> > > > >  fs/iomap/ioend.c       |  41 +++++++++++++-
> > > > >  include/linux/iomap.h  |  13 +++++
> > > > >  3 files changed, 198 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > > index e959a206cba9..87c974e543e0 100644
> > > > > --- a/fs/iomap/buffered-io.c
> > > > > +++ b/fs/iomap/buffered-io.c
> > > > > @@ -6,6 +6,7 @@
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/compiler.h>
> > > > >  #include <linux/fs.h>
> > > > > +#include <linux/fsverity.h>
> > > > >  #include <linux/iomap.h>
> > > > >  #include <linux/pagemap.h>
> > > > >  #include <linux/uio.h>
> > > > > @@ -363,6 +364,116 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> > > > >  		pos >= i_size_read(iter->inode);
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_FS_VERITY
> > > > > +int iomap_init_fsverity(struct super_block *sb, unsigned int wq_flags,
> > > > > +			int max_active)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	if (!iomap_fsverity_bioset) {
> > > > > +		ret = iomap_fsverity_init_bioset();
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +	}
> > > > > +
> > > > > +	return fsverity_init_wq(sb, wq_flags, max_active);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(iomap_init_fsverity);
> > > > > +
> > > > > +static void
> > > > > +iomap_read_fsverify_end_io_work(struct work_struct *work)
> > > > > +{
> > > > > +	struct iomap_fsverity_bio *fbio =
> > > > > +		container_of(work, struct iomap_fsverity_bio, work);
> > > > > +
> > > > > +	fsverity_verify_bio(&fbio->bio);
> > > > > +	iomap_read_end_io(&fbio->bio);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +iomap_read_fsverity_end_io(struct bio *bio)
> > > > > +{
> > > > > +	struct iomap_fsverity_bio *fbio =
> > > > > +		container_of(bio, struct iomap_fsverity_bio, bio);
> > > > > +
> > > > > +	INIT_WORK(&fbio->work, iomap_read_fsverify_end_io_work);
> > > > > +	queue_work(bio->bi_private, &fbio->work);
> > > > > +}
> > > > > +
> > > > > +static struct bio *
> > > > > +iomap_fsverity_read_bio_alloc(struct inode *inode, struct block_device *bdev,
> > > > > +			    int nr_vecs, gfp_t gfp)
> > > > > +{
> > > > > +	struct bio *bio;
> > > > > +
> > > > > +	bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
> > > > > +			iomap_fsverity_bioset);
> > > > > +	if (bio) {
> > > > > +		bio->bi_private = inode->i_sb->s_verity_wq;
> > > > > +		bio->bi_end_io = iomap_read_fsverity_end_io;
> > > > > +	}
> > > > > +	return bio;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * True if tree is not aligned with fs block/folio size and we need zero tail
> > > > > + * part of the folio
> > > > > + */
> > > > > +static bool
> > > > > +iomap_fsverity_tree_end_align(struct iomap_iter *iter, struct folio *folio,
> > > > > +		loff_t pos, size_t plen)
> > > > > +{
> > > > > +	int error;
> > > > > +	u8 log_blocksize;
> > > > > +	u64 tree_size, tree_mask, last_block_tree, last_block_pos;
> > > > > +
> > > > > +	/* Not a Merkle tree */
> > > > > +	if (!(iter->iomap.flags & IOMAP_F_BEYOND_EOF))
> > > > > +		return false;
> > > > > +
> > > > > +	if (plen == folio_size(folio))
> > > > > +		return false;
> > > > > +
> > > > > +	if (iter->inode->i_blkbits == folio_shift(folio))
> > > > > +		return false;
> > > > > +
> > > > > +	error = fsverity_merkle_tree_geometry(iter->inode, &log_blocksize, NULL,
> > > > > +			&tree_size);
> > > > > +	if (error)
> > > > > +		return false;
> > > > > +
> > > > > +	/*
> > > > > +	 * We are beyond EOF reading Merkle tree. Therefore, it has highest
> > > > > +	 * offset. Mask pos with a tree size to get a position whare are we in
> > > > > +	 * the tree. Then, compare index of a last tree block and the index of
> > > > > +	 * current pos block.
> > > > > +	 */
> > > > > +	last_block_tree = (tree_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > > > +	tree_mask = (1 << fls64(tree_size)) - 1;
> > > > > +	last_block_pos = ((pos & tree_mask) >> PAGE_SHIFT) + 1;
> > > > > +
> > > > > +	return last_block_tree == last_block_pos;
> > > > > +}
> > > > > +#else
> > > > > +# define iomap_fsverity_read_bio_alloc(...)	(NULL)
> > > > > +# define iomap_fsverity_tree_end_align(...)	(false)
> > > > > +#endif /* CONFIG_FS_VERITY */
> > > > > +
> > > > > +static struct bio *iomap_read_bio_alloc(struct inode *inode,
> > > > > +		const struct iomap *iomap, int nr_vecs, gfp_t gfp)
> > > > > +{
> > > > > +	struct bio *bio;
> > > > > +	struct block_device *bdev = iomap->bdev;
> > > > > +
> > > > > +	if (fsverity_active(inode) && !(iomap->flags & IOMAP_F_BEYOND_EOF))
> > > > > +		return iomap_fsverity_read_bio_alloc(inode, bdev, nr_vecs, gfp);
> > > > > +
> > > > > +	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
> > > > > +	if (bio)
> > > > > +		bio->bi_end_io = iomap_read_end_io;
> > > > > +	return bio;
> > > > > +}
> > > > > +
> > > > >  static int iomap_readpage_iter(struct iomap_iter *iter,
> > > > >  		struct iomap_readpage_ctx *ctx)
> > > > >  {
> > > > > @@ -375,6 +486,10 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
> > > > >  	sector_t sector;
> > > > >  	int ret;
> > > > >  
> > > > > +	/* Fail reads from broken fsverity files immediately. */
> > > > > +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
> > > > > +		return -EIO;
> > > > > +
> > > > >  	if (iomap->type == IOMAP_INLINE) {
> > > > >  		ret = iomap_read_inline_data(iter, folio);
> > > > >  		if (ret)
> > > > > @@ -391,6 +506,11 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
> > > > >  	if (iomap_block_needs_zeroing(iter, pos) &&
> > > > >  	    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
> > > > >  		folio_zero_range(folio, poff, plen);
> > > > > +		if (fsverity_active(iter->inode) &&
> > > > > +		    !fsverity_verify_blocks(folio, plen, poff)) {
> > > > > +			return -EIO;
> > > > > +		}
> > > > > +
> > > > >  		iomap_set_range_uptodate(folio, poff, plen);
> > > > >  		goto done;
> > > > >  	}
> > > > > @@ -408,32 +528,51 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
> > > > >  	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
> > > > >  		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> > > > >  		gfp_t orig_gfp = gfp;
> > > > > -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> > > > >  
> > > > >  		if (ctx->bio)
> > > > >  			submit_bio(ctx->bio);
> > > > >  
> > > > >  		if (ctx->rac) /* same as readahead_gfp_mask */
> > > > >  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> > > > > -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> > > > > -				     REQ_OP_READ, gfp);
> > > > > +
> > > > > +		ctx->bio = iomap_read_bio_alloc(iter->inode, iomap,
> > > > > +				bio_max_segs(DIV_ROUND_UP(length, PAGE_SIZE)),
> > > > > +				gfp);
> > > > > +
> > > > >  		/*
> > > > >  		 * If the bio_alloc fails, try it again for a single page to
> > > > >  		 * avoid having to deal with partial page reads.  This emulates
> > > > >  		 * what do_mpage_read_folio does.
> > > > >  		 */
> > > > >  		if (!ctx->bio) {
> > > > > -			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
> > > > > -					     orig_gfp);
> > > > > +			ctx->bio = iomap_read_bio_alloc(iter->inode,
> > > > > +					iomap, 1, orig_gfp);
> > > > >  		}
> > > > >  		if (ctx->rac)
> > > > >  			ctx->bio->bi_opf |= REQ_RAHEAD;
> > > > >  		ctx->bio->bi_iter.bi_sector = sector;
> > > > > -		ctx->bio->bi_end_io = iomap_read_end_io;
> > > > >  		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
> > > > >  	}
> > > > >  
> > > > >  done:
> > > > > +	/*
> > > > > +	 * For post EOF region, zero part of the folio which won't be read. This
> > > > > +	 * happens at the end of the region. So far, the only user is
> > > > > +	 * fs-verity which stores continuous data region.
> > > > 
> > > > Is it ever the case that the zeroed region actually has merkle tree
> > > > content on disk?  Or if this region truly was never written by the
> > > > fsverity construction code, then why would it access the unwritten
> > > > region later?
> > > > 
> > > > Or am I misunderstanding something here?
> > > > 
> > > > (Probably...)
> > > 
> > > The zeroed region is never written. With 1k fs block and 1k merkle
> > > tree block and 4k page size we could end up reading only single
> > > block, at the end of the tree. But we have to pass PAGE to the
> > > fsverity. So, only the 1/4 of the page is read. This if-case zeroes
> > > the rest of the page to make it uptodate. In the normal read path
> > > this is bound by EOF, but here I use tree size. So, we don't read
> > > this unwritten region but zero the folio.
> > > 
> > > The fsverity does zeroing of unused space while construction, but
> > > this works only for full fs blocks, therefore, 4k fs block and 1k
> > > merkle tree block.
> > 
> > But if the regions you have to zero are outside the merkle tree, then
> > fsverity shouldn't ever see those bytes, so why zero them?  Or does it
> > actually check the uptodate bit?  So then you want the folio to have
> > well defined contents?
> 
> verity doesn't check uptodate, but I do in xfs_fsverity_read_merkle().
> I think we need to check as it tells that iomap is done reading,
> but that's true that zeroing is not necessary.

Ok sounds good to me.

--D

> > 
> > (At this point I'm picking at nits :P)
> > 
> > --D
> > 
> > > -- 
> > > - Andrey
> > > 
> > > 
> > 
> 
> -- 
> - Andrey
> 
> 

