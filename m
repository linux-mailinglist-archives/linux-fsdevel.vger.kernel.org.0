Return-Path: <linux-fsdevel+bounces-56390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8DBB1706D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08D95680DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920472BEC32;
	Thu, 31 Jul 2025 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh5+hvNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381A2264C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961680; cv=none; b=cZRhOWgGFA0lZodLv4h5iZzb750QT6qioexazJuFdh+iVE9IPN5F7w5H4KQJENGM6lrmFC9wE9OtB/7EpMNKyD/Q4Kmhr1ObQJDdiKUpnxn81eAVdTmWEfiUW9GQwDiSqUXqvG9WqxwqmDbS2s2RsJbR4uUOQ7w4foRaBrBt+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961680; c=relaxed/simple;
	bh=1y/Zo/lSEB/Fk9LFo90eHbV7ymK42YnCVP9XzCjHHlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXBzOSd3Gf+vvGpE6kJEfDH9hauyfItD7fzvKut5u2DSsvOojQP9ohYt9iKu+TbPbmNceYKoE37IPjrHNvhFDc6BIAkgetgF2/WojyXSjnLeuvRMMdxGLCQXOmQDcUrDPtA0L8YOXO5FE9EC0BXKBRH5EEMeJRmgxrUW0QW3Yjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kh5+hvNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753961677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzA8GugouwSPOp8MLwKZ10q7duF8uy9sV/hJy9Wdq5c=;
	b=Kh5+hvNnQulMCcJBFvV9P0xMS1WoDEJvnGAmfeM6ty3kYqgojyRJG0V0VFEsP+OAKHYQSQ
	nN5e9a5caKRWxR6ikH07/B0cfYJX+aervLVp6oFp68KDlWofs1cEJh+4YDMWInf3qEQASF
	q8YrDvUZ0/8LggSGCW7RWMCTTXbNjWM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Z-YPxI7VMs-MCTkLOfZAkA-1; Thu, 31 Jul 2025 07:34:28 -0400
X-MC-Unique: Z-YPxI7VMs-MCTkLOfZAkA-1
X-Mimecast-MFC-AGG-ID: Z-YPxI7VMs-MCTkLOfZAkA_1753961667
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-af8f5f48b5bso87693266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 04:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753961667; x=1754566467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzA8GugouwSPOp8MLwKZ10q7duF8uy9sV/hJy9Wdq5c=;
        b=SlYVqFK3xQub0YDsicGk+tHq/p9+CAYTFNSVGyEbK1nLiXbEyLJowENDbCyz2qTmdV
         RWJFrPyqDF7n/NEG+dS+o7WcFp2vsCJvigX1SaU/Xla+Mc4TXazLKVLMX/K5/LI6Hi6O
         ZBP82W1aSq8cYVmpFHA6do7LNwSnOR9+lpMjhVkI9MQ9WLgHgyNzhHcCwH6U0m+flWhK
         K9y2tRLmpcbZLsV69hjVZboslaZkQgZJe3oqwQJmxnqmIy6HEaG3rMxQLC10Ie0R7xdb
         2xbn8Md8DQPWrW8hbA0TG6/SZXkpEEE8xnJB4WsfALPjH2XkOuEeRs5Zk9yqnUB3qW2y
         I5/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWMo1v2IMDfP93htW/iQl7T11j+UDEKc34X2v1/Nv8PgqtvwBp1FLRY2kfnv3ujQdZsVBKGG5gkv5V2P4W@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2Wwy58nsDpDFYT6T/IZsxDXwNrLWLnVU3lh/G9uaCH3ja3z2
	2hJTMHD9BwgsFM+3G6UV2kAerYYT2CklK4cU627N4Acit/Ks0HS3LIdusEFARbTpO9nyaQI7X5G
	9o6hUUBicJvLyqN2EB4LKLOJFiyoItJCcrw7fgaH7RzNtHBuUL1BKhZhxvaRVPs5KrWuh3iKjZA
	==
X-Gm-Gg: ASbGncvb7SZmVqtGAZA1LbdTiGrghGpLniRoWSD9cYgEGPzze2KUpART6ykjMyfBblR
	dCbW5fwd55xpsTmbcKnK2kr3bZIoN39jfpyrBajB82sJU55AllSP/0Nd+EylXkOk5j0kc5Zt3zO
	XhGN0tc7PdH543NAQx5Na/JgNebVj7ZxaFnLUlsQPd4TRIOk6/DI9umPm86zfYIX2KEAaYdY9CD
	cpqJ7yMtkEeSki85iJ3bdEZDv1TYw6KOo/6YkTRGM+vH03w2rX973+2uUbnKVITZ5PcZHwdDFYe
	oquzGSqHO5IWhURHlVyss9VBkdHmtqlCuXJtBWqgVcg05d5BKPF4a6xrY6Y=
X-Received: by 2002:a17:906:730d:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-af91bdd3c6bmr195223866b.16.1753961666579;
        Thu, 31 Jul 2025 04:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKAHLGQZxBEP+us0JAlF6fYX18OP/zg5OsAyh5jFH4x6ZcoJFlTCLXN30mB+Dnt4D/i2T6XA==
X-Received: by 2002:a17:906:730d:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-af91bdd3c6bmr195220066b.16.1753961666002;
        Thu, 31 Jul 2025 04:34:26 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3792sm96117666b.50.2025.07.31.04.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:34:25 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:34:24 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org, hch@lst.de, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 13/29] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <f767jjbn25ffuigxnigsi7kz6tqvfqkbk4j2xs3mobtyhnmqip@24mjx53j3axv>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-13-9e5443af0e34@kernel.org>
 <20250729232152.GP2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729232152.GP2672049@frogsfrogsfrogs>

On 2025-07-29 16:21:52, Darrick J. Wong wrote:
> On Mon, Jul 28, 2025 at 10:30:17PM +0200, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > This patch adds fs-verity verification into iomap's read path. After
> > BIO's io operation is complete the data are verified against
> > fs-verity's Merkle tree. Verification work is done in a separate
> > workqueue.
> > 
> > The read path ioend iomap_read_ioend are stored side by side with
> > BIOs if FS_VERITY is enabled.
> > 
> > [djwong: fix doc warning]
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/iomap/ioend.c       |  41 +++++++++++++-
> >  include/linux/iomap.h  |  13 +++++
> >  3 files changed, 198 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index e959a206cba9..87c974e543e0 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/module.h>
> >  #include <linux/compiler.h>
> >  #include <linux/fs.h>
> > +#include <linux/fsverity.h>
> >  #include <linux/iomap.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/uio.h>
> > @@ -363,6 +364,116 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> >  		pos >= i_size_read(iter->inode);
> >  }
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +int iomap_init_fsverity(struct super_block *sb, unsigned int wq_flags,
> > +			int max_active)
> > +{
> > +	int ret;
> > +
> > +	if (!iomap_fsverity_bioset) {
> > +		ret = iomap_fsverity_init_bioset();
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return fsverity_init_wq(sb, wq_flags, max_active);
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_init_fsverity);
> > +
> > +static void
> > +iomap_read_fsverify_end_io_work(struct work_struct *work)
> > +{
> > +	struct iomap_fsverity_bio *fbio =
> > +		container_of(work, struct iomap_fsverity_bio, work);
> > +
> > +	fsverity_verify_bio(&fbio->bio);
> > +	iomap_read_end_io(&fbio->bio);
> > +}
> > +
> > +static void
> > +iomap_read_fsverity_end_io(struct bio *bio)
> > +{
> > +	struct iomap_fsverity_bio *fbio =
> > +		container_of(bio, struct iomap_fsverity_bio, bio);
> > +
> > +	INIT_WORK(&fbio->work, iomap_read_fsverify_end_io_work);
> > +	queue_work(bio->bi_private, &fbio->work);
> > +}
> > +
> > +static struct bio *
> > +iomap_fsverity_read_bio_alloc(struct inode *inode, struct block_device *bdev,
> > +			    int nr_vecs, gfp_t gfp)
> > +{
> > +	struct bio *bio;
> > +
> > +	bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
> > +			iomap_fsverity_bioset);
> > +	if (bio) {
> > +		bio->bi_private = inode->i_sb->s_verity_wq;
> > +		bio->bi_end_io = iomap_read_fsverity_end_io;
> > +	}
> > +	return bio;
> > +}
> > +
> > +/*
> > + * True if tree is not aligned with fs block/folio size and we need zero tail
> > + * part of the folio
> > + */
> > +static bool
> > +iomap_fsverity_tree_end_align(struct iomap_iter *iter, struct folio *folio,
> > +		loff_t pos, size_t plen)
> > +{
> > +	int error;
> > +	u8 log_blocksize;
> > +	u64 tree_size, tree_mask, last_block_tree, last_block_pos;
> > +
> > +	/* Not a Merkle tree */
> > +	if (!(iter->iomap.flags & IOMAP_F_BEYOND_EOF))
> > +		return false;
> > +
> > +	if (plen == folio_size(folio))
> > +		return false;
> > +
> > +	if (iter->inode->i_blkbits == folio_shift(folio))
> > +		return false;
> > +
> > +	error = fsverity_merkle_tree_geometry(iter->inode, &log_blocksize, NULL,
> > +			&tree_size);
> > +	if (error)
> > +		return false;
> > +
> > +	/*
> > +	 * We are beyond EOF reading Merkle tree. Therefore, it has highest
> > +	 * offset. Mask pos with a tree size to get a position whare are we in
> > +	 * the tree. Then, compare index of a last tree block and the index of
> > +	 * current pos block.
> > +	 */
> > +	last_block_tree = (tree_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +	tree_mask = (1 << fls64(tree_size)) - 1;
> > +	last_block_pos = ((pos & tree_mask) >> PAGE_SHIFT) + 1;
> > +
> > +	return last_block_tree == last_block_pos;
> > +}
> > +#else
> > +# define iomap_fsverity_read_bio_alloc(...)	(NULL)
> > +# define iomap_fsverity_tree_end_align(...)	(false)
> > +#endif /* CONFIG_FS_VERITY */
> > +
> > +static struct bio *iomap_read_bio_alloc(struct inode *inode,
> > +		const struct iomap *iomap, int nr_vecs, gfp_t gfp)
> > +{
> > +	struct bio *bio;
> > +	struct block_device *bdev = iomap->bdev;
> > +
> > +	if (fsverity_active(inode) && !(iomap->flags & IOMAP_F_BEYOND_EOF))
> > +		return iomap_fsverity_read_bio_alloc(inode, bdev, nr_vecs, gfp);
> > +
> > +	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
> > +	if (bio)
> > +		bio->bi_end_io = iomap_read_end_io;
> > +	return bio;
> > +}
> > +
> >  static int iomap_readpage_iter(struct iomap_iter *iter,
> >  		struct iomap_readpage_ctx *ctx)
> >  {
> > @@ -375,6 +486,10 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
> >  	sector_t sector;
> >  	int ret;
> >  
> > +	/* Fail reads from broken fsverity files immediately. */
> > +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
> > +		return -EIO;
> > +
> >  	if (iomap->type == IOMAP_INLINE) {
> >  		ret = iomap_read_inline_data(iter, folio);
> >  		if (ret)
> > @@ -391,6 +506,11 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
> >  	if (iomap_block_needs_zeroing(iter, pos) &&
> >  	    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
> >  		folio_zero_range(folio, poff, plen);
> > +		if (fsverity_active(iter->inode) &&
> > +		    !fsverity_verify_blocks(folio, plen, poff)) {
> > +			return -EIO;
> > +		}
> > +
> >  		iomap_set_range_uptodate(folio, poff, plen);
> >  		goto done;
> >  	}
> > @@ -408,32 +528,51 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
> >  	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
> >  		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> >  		gfp_t orig_gfp = gfp;
> > -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> >  
> >  		if (ctx->bio)
> >  			submit_bio(ctx->bio);
> >  
> >  		if (ctx->rac) /* same as readahead_gfp_mask */
> >  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> > -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> > -				     REQ_OP_READ, gfp);
> > +
> > +		ctx->bio = iomap_read_bio_alloc(iter->inode, iomap,
> > +				bio_max_segs(DIV_ROUND_UP(length, PAGE_SIZE)),
> > +				gfp);
> > +
> >  		/*
> >  		 * If the bio_alloc fails, try it again for a single page to
> >  		 * avoid having to deal with partial page reads.  This emulates
> >  		 * what do_mpage_read_folio does.
> >  		 */
> >  		if (!ctx->bio) {
> > -			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
> > -					     orig_gfp);
> > +			ctx->bio = iomap_read_bio_alloc(iter->inode,
> > +					iomap, 1, orig_gfp);
> >  		}
> >  		if (ctx->rac)
> >  			ctx->bio->bi_opf |= REQ_RAHEAD;
> >  		ctx->bio->bi_iter.bi_sector = sector;
> > -		ctx->bio->bi_end_io = iomap_read_end_io;
> >  		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
> >  	}
> >  
> >  done:
> > +	/*
> > +	 * For post EOF region, zero part of the folio which won't be read. This
> > +	 * happens at the end of the region. So far, the only user is
> > +	 * fs-verity which stores continuous data region.
> 
> Is it ever the case that the zeroed region actually has merkle tree
> content on disk?  Or if this region truly was never written by the
> fsverity construction code, then why would it access the unwritten
> region later?
> 
> Or am I misunderstanding something here?
> 
> (Probably...)

The zeroed region is never written. With 1k fs block and 1k merkle
tree block and 4k page size we could end up reading only single
block, at the end of the tree. But we have to pass PAGE to the
fsverity. So, only the 1/4 of the page is read. This if-case zeroes
the rest of the page to make it uptodate. In the normal read path
this is bound by EOF, but here I use tree size. So, we don't read
this unwritten region but zero the folio.

The fsverity does zeroing of unused space while construction, but
this works only for full fs blocks, therefore, 4k fs block and 1k
merkle tree block.

-- 
- Andrey


