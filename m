Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2AF3E0019
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhHDLXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 07:23:01 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51038 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237510AbhHDLXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:23:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UhyTT5j_1628076164;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UhyTT5j_1628076164)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 19:22:45 +0800
Date:   Wed, 4 Aug 2021 19:22:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Tao Ma <boyu.mt@taobao.com>
Subject: Re: [PATCH v2 3/3] erofs: convert all uncompressed cases to iomap
Message-ID: <YQp4hH5URykk3Bbm@B-P7TQMD6M-0146.local>
Mail-Followup-To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Tao Ma <boyu.mt@taobao.com>
References: <20210730194625.93856-1-hsiangkao@linux.alibaba.com>
 <20210730194625.93856-4-hsiangkao@linux.alibaba.com>
 <76f9241e-5e7b-1de4-6cef-c92aa1de7498@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76f9241e-5e7b-1de4-6cef-c92aa1de7498@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 04, 2021 at 03:17:50PM +0800, Chao Yu wrote:
> On 2021/7/31 3:46, Gao Xiang wrote:
> > Since tail-packing inline has been supported by iomap now, let's
> > convert all EROFS uncompressed data I/O to iomap, which is pretty
> > straight-forward.
> > 
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   fs/erofs/data.c | 288 ++++++++----------------------------------------
> >   1 file changed, 49 insertions(+), 239 deletions(-)
> > 
> > diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > index 911521293b20..6b98156bb5ca 100644
> > --- a/fs/erofs/data.c
> > +++ b/fs/erofs/data.c
> > @@ -9,29 +9,6 @@
> >   #include <linux/dax.h>
> >   #include <trace/events/erofs.h>
> > -static void erofs_readendio(struct bio *bio)
> > -{
> > -	struct bio_vec *bvec;
> > -	blk_status_t err = bio->bi_status;
> > -	struct bvec_iter_all iter_all;
> > -
> > -	bio_for_each_segment_all(bvec, bio, iter_all) {
> > -		struct page *page = bvec->bv_page;
> > -
> > -		/* page is already locked */
> > -		DBG_BUGON(PageUptodate(page));
> > -
> > -		if (err)
> > -			SetPageError(page);
> > -		else
> > -			SetPageUptodate(page);
> > -
> > -		unlock_page(page);
> > -		/* page could be reclaimed now */
> > -	}
> > -	bio_put(bio);
> > -}
> > -
> >   struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
> >   {
> >   	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
> > @@ -109,206 +86,6 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
> >   	return err;
> >   }
> > -static inline struct bio *erofs_read_raw_page(struct bio *bio,
> > -					      struct address_space *mapping,
> > -					      struct page *page,
> > -					      erofs_off_t *last_block,
> > -					      unsigned int nblocks,
> > -					      unsigned int *eblks,
> > -					      bool ra)
> > -{
> > -	struct inode *const inode = mapping->host;
> > -	struct super_block *const sb = inode->i_sb;
> > -	erofs_off_t current_block = (erofs_off_t)page->index;
> > -	int err;
> > -
> > -	DBG_BUGON(!nblocks);
> > -
> > -	if (PageUptodate(page)) {
> > -		err = 0;
> > -		goto has_updated;
> > -	}
> > -
> > -	/* note that for readpage case, bio also equals to NULL */
> > -	if (bio &&
> > -	    (*last_block + 1 != current_block || !*eblks)) {
> > -submit_bio_retry:
> > -		submit_bio(bio);
> > -		bio = NULL;
> > -	}
> > -
> > -	if (!bio) {
> > -		struct erofs_map_blocks map = {
> > -			.m_la = blknr_to_addr(current_block),
> > -		};
> > -		erofs_blk_t blknr;
> > -		unsigned int blkoff;
> > -
> > -		err = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
> > -		if (err)
> > -			goto err_out;
> > -
> > -		/* zero out the holed page */
> > -		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> > -			zero_user_segment(page, 0, PAGE_SIZE);
> > -			SetPageUptodate(page);
> > -
> > -			/* imply err = 0, see erofs_map_blocks */
> > -			goto has_updated;
> > -		}
> > -
> > -		/* for RAW access mode, m_plen must be equal to m_llen */
> > -		DBG_BUGON(map.m_plen != map.m_llen);
> > -
> > -		blknr = erofs_blknr(map.m_pa);
> > -		blkoff = erofs_blkoff(map.m_pa);
> > -
> > -		/* deal with inline page */
> > -		if (map.m_flags & EROFS_MAP_META) {
> > -			void *vsrc, *vto;
> > -			struct page *ipage;
> > -
> > -			DBG_BUGON(map.m_plen > PAGE_SIZE);
> > -
> > -			ipage = erofs_get_meta_page(inode->i_sb, blknr);
> > -
> > -			if (IS_ERR(ipage)) {
> > -				err = PTR_ERR(ipage);
> > -				goto err_out;
> > -			}
> > -
> > -			vsrc = kmap_atomic(ipage);
> > -			vto = kmap_atomic(page);
> > -			memcpy(vto, vsrc + blkoff, map.m_plen);
> > -			memset(vto + map.m_plen, 0, PAGE_SIZE - map.m_plen);
> > -			kunmap_atomic(vto);
> > -			kunmap_atomic(vsrc);
> > -			flush_dcache_page(page);
> > -
> > -			SetPageUptodate(page);
> > -			/* TODO: could we unlock the page earlier? */
> > -			unlock_page(ipage);
> > -			put_page(ipage);
> > -
> > -			/* imply err = 0, see erofs_map_blocks */
> > -			goto has_updated;
> > -		}
> > -
> > -		/* pa must be block-aligned for raw reading */
> > -		DBG_BUGON(erofs_blkoff(map.m_pa));
> > -
> > -		/* max # of continuous pages */
> > -		if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
> > -			nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
> > -
> > -		*eblks = bio_max_segs(nblocks);
> > -		bio = bio_alloc(GFP_NOIO, *eblks);
> > -
> > -		bio->bi_end_io = erofs_readendio;
> > -		bio_set_dev(bio, sb->s_bdev);
> > -		bio->bi_iter.bi_sector = (sector_t)blknr <<
> > -			LOG_SECTORS_PER_BLOCK;
> > -		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
> > -	}
> > -
> > -	err = bio_add_page(bio, page, PAGE_SIZE, 0);
> > -	/* out of the extent or bio is full */
> > -	if (err < PAGE_SIZE)
> > -		goto submit_bio_retry;
> > -	--*eblks;
> > -	*last_block = current_block;
> > -	return bio;
> > -
> > -err_out:
> > -	/* for sync reading, set page error immediately */
> > -	if (!ra) {
> > -		SetPageError(page);
> > -		ClearPageUptodate(page);
> > -	}
> > -has_updated:
> > -	unlock_page(page);
> > -
> > -	/* if updated manually, continuous pages has a gap */
> > -	if (bio)
> > -		submit_bio(bio);
> > -	return err ? ERR_PTR(err) : NULL;
> > -}
> > -
> > -/*
> > - * since we dont have write or truncate flows, so no inode
> > - * locking needs to be held at the moment.
> > - */
> > -static int erofs_raw_access_readpage(struct file *file, struct page *page)
> > -{
> > -	erofs_off_t last_block;
> > -	unsigned int eblks;
> > -	struct bio *bio;
> > -
> > -	trace_erofs_readpage(page, true);
> > -
> > -	bio = erofs_read_raw_page(NULL, page->mapping,
> > -				  page, &last_block, 1, &eblks, false);
> > -
> > -	if (IS_ERR(bio))
> > -		return PTR_ERR(bio);
> > -
> > -	if (bio)
> > -		submit_bio(bio);
> > -	return 0;
> > -}
> > -
> > -static void erofs_raw_access_readahead(struct readahead_control *rac)
> > -{
> > -	erofs_off_t last_block;
> > -	unsigned int eblks;
> > -	struct bio *bio = NULL;
> > -	struct page *page;
> > -
> > -	trace_erofs_readpages(rac->mapping->host, readahead_index(rac),
> > -			readahead_count(rac), true);
> > -
> > -	while ((page = readahead_page(rac))) {
> > -		prefetchw(&page->flags);
> > -
> > -		bio = erofs_read_raw_page(bio, rac->mapping, page, &last_block,
> > -				readahead_count(rac), &eblks, true);
> > -
> > -		/* all the page errors are ignored when readahead */
> > -		if (IS_ERR(bio)) {
> > -			pr_err("%s, readahead error at page %lu of nid %llu\n",
> > -			       __func__, page->index,
> > -			       EROFS_I(rac->mapping->host)->nid);
> > -
> > -			bio = NULL;
> > -		}
> > -
> > -		put_page(page);
> > -	}
> > -
> > -	if (bio)
> > -		submit_bio(bio);
> > -}
> > -
> > -static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> > -{
> > -	struct inode *inode = mapping->host;
> > -	struct erofs_map_blocks map = {
> > -		.m_la = blknr_to_addr(block),
> > -	};
> > -
> > -	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
> > -		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
> > -
> > -		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> > -			return 0;
> > -	}
> > -
> > -	if (!erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW))
> > -		return erofs_blknr(map.m_pa);
> > -
> > -	return 0;
> > -}
> > -
> >   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> >   {
> > @@ -327,6 +104,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   	iomap->offset = map.m_la;
> >   	iomap->length = map.m_llen;
> >   	iomap->flags = 0;
> > +	iomap->private = NULL;
> >   	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> >   		iomap->type = IOMAP_HOLE;
> > @@ -336,20 +114,61 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   		return 0;
> >   	}
> > -	/* that shouldn't happen for now */
> >   	if (map.m_flags & EROFS_MAP_META) {
> > -		DBG_BUGON(1);
> > -		return -ENOTBLK;
> > +		struct page *ipage;
> > +
> > +		iomap->type = IOMAP_INLINE;
> > +		ipage = erofs_get_meta_page(inode->i_sb,
> > +					    erofs_blknr(map.m_pa));
> 
> Error handling for erofs_get_meta_page()?

Yes, will update. Thanks for pointing out.

Thanks,
Gao Xiang

> 
> Thanks
> 
> > +		iomap->inline_data = page_address(ipage) +
> > +					erofs_blkoff(map.m_pa);
> > +		iomap->private = ipage;
> > +	} else {
> > +		iomap->type = IOMAP_MAPPED;
> > +		iomap->addr = map.m_pa;
> >   	}
> > -	iomap->type = IOMAP_MAPPED;
> > -	iomap->addr = map.m_pa;
> >   	return 0;
> >   }
> > +static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> > +		ssize_t written, unsigned flags, struct iomap *iomap)
> > +{
> > +	struct page *ipage = iomap->private;
> > +
> > +	if (ipage) {
> > +		DBG_BUGON(iomap->type != IOMAP_INLINE);
> > +		unlock_page(ipage);
> > +		put_page(ipage);
> > +	} else {
> > +		DBG_BUGON(iomap->type == IOMAP_INLINE);
> > +	}
> > +	return written;
> > +}
> > +
> >   const struct iomap_ops erofs_iomap_ops = {
> >   	.iomap_begin = erofs_iomap_begin,
> > +	.iomap_end = erofs_iomap_end,
> >   };
> > +/*
> > + * since we dont have write or truncate flows, so no inode
> > + * locking needs to be held at the moment.
> > + */
> > +static int erofs_readpage(struct file *file, struct page *page)
> > +{
> > +	return iomap_readpage(page, &erofs_iomap_ops);
> > +}
> > +
> > +static void erofs_readahead(struct readahead_control *rac)
> > +{
> > +	return iomap_readahead(rac, &erofs_iomap_ops);
> > +}
> > +
> > +static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> > +{
> > +	return iomap_bmap(mapping, block, &erofs_iomap_ops);
> > +}
> > +
> >   static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
> >   {
> >   	struct inode *inode = file_inode(iocb->ki_filp);
> > @@ -365,15 +184,6 @@ static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
> >   	if (align & blksize_mask)
> >   		return -EINVAL;
> > -
> > -	/*
> > -	 * Temporarily fall back tail-packing inline to buffered I/O instead
> > -	 * since tail-packing inline support relies on an iomap core update.
> > -	 */
> > -	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE &&
> > -	    iocb->ki_pos + iov_iter_count(to) >
> > -			rounddown(inode->i_size, EROFS_BLKSIZ))
> > -		return 1;
> >   	return 0;
> >   }
> > @@ -409,8 +219,8 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >   /* for uncompressed (aligned) files and raw access for other files */
> >   const struct address_space_operations erofs_raw_access_aops = {
> > -	.readpage = erofs_raw_access_readpage,
> > -	.readahead = erofs_raw_access_readahead,
> > +	.readpage = erofs_readpage,
> > +	.readahead = erofs_readahead,
> >   	.bmap = erofs_bmap,
> >   	.direct_IO = noop_direct_IO,
> >   };
> > 
