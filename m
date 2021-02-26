Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186E23268D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 21:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBZUjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 15:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhBZUjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:39:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F62C061574;
        Fri, 26 Feb 2021 12:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=maO8ObxTGDUzuFfFag72xIw0dI8dqhj08XEWkq0F3uA=; b=WtxxTBFPgeFfCKuX6YWeCWXojP
        ci6tbQMrAJr7BWcWBj/yrV3B2fMXR8eI8WeWvuNr77YTFbA9rn1CVGdp9clLMJrHeDSO/7V7S4wf4
        A/bpgoUa7MoIYCdV9TTlbcEzBAa8/6AUi6o4aXbhU8EGYEju1xLv+2NmTTJswxjUHEjAXFCzl7xzA
        fx9A1aQpG2sH/5dGA6eqEgc+n34Uuf2n8FMoBvtVs6TVFhnBwdeVtjMpIOjSOH/uGwVI8fwxj+dYY
        wGVuQZm81IfHTcUBs6jBzBnlUZ58PeZDtMGqMSjk5ab9ecCKSB/3C5qBo5h6TZGdQnANOdYiowl/Y
        BfN7SWIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFjsR-00CTz1-QC; Fri, 26 Feb 2021 20:38:22 +0000
Date:   Fri, 26 Feb 2021 20:38:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: Add bio_max_segs
Message-ID: <20210226203819.GH2723601@casper.infradead.org>
References: <20210129043857.2236940-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129043857.2236940-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This seems to have missed the merge window ;-(

On Fri, Jan 29, 2021 at 04:38:57AM +0000, Matthew Wilcox (Oracle) wrote:
> It's often inconvenient to use BIO_MAX_PAGES due to min() requiring the
> sign to be the same.  Introduce bio_max_segs() and change BIO_MAX_PAGES to
> be unsigned to make it easier for the users.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2:
>  - Rename from bio_limit() to bio_max_segs()
>  - Rebase on next-20210128
>  - Use DIV_ROUND_UP in dm-log-writes.c
>  - Use DIV_ROUND_UP in iomap/buffered-io.c
> 
>  block/blk-map.c                     |  4 +---
>  drivers/block/xen-blkback/blkback.c |  4 +---
>  drivers/md/dm-io.c                  |  4 ++--
>  drivers/md/dm-log-writes.c          | 10 +++++-----
>  drivers/nvme/target/io-cmd-bdev.c   |  8 ++++----
>  drivers/nvme/target/passthru.c      |  4 ++--
>  drivers/target/target_core_iblock.c |  9 +++------
>  drivers/target/target_core_pscsi.c  |  2 +-
>  fs/block_dev.c                      | 10 +++++-----
>  fs/direct-io.c                      |  2 +-
>  fs/erofs/data.c                     |  4 +---
>  fs/ext4/readpage.c                  |  3 +--
>  fs/f2fs/data.c                      |  3 +--
>  fs/f2fs/node.c                      |  2 +-
>  fs/iomap/buffered-io.c              |  4 ++--
>  fs/mpage.c                          |  4 +---
>  fs/nfs/blocklayout/blocklayout.c    |  6 +++---
>  fs/xfs/xfs_bio_io.c                 |  2 +-
>  fs/xfs/xfs_buf.c                    |  4 ++--
>  include/linux/bio.h                 |  7 ++++++-
>  20 files changed, 44 insertions(+), 52 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 21630dccac62..369e204d14d0 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -150,9 +150,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
>  	bmd->is_our_pages = !map_data;
>  	bmd->is_null_mapped = (map_data && map_data->null_mapped);
>  
> -	nr_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> -	if (nr_pages > BIO_MAX_PAGES)
> -		nr_pages = BIO_MAX_PAGES;
> +	nr_pages = bio_max_segs(DIV_ROUND_UP(offset + len, PAGE_SIZE));
>  
>  	ret = -ENOMEM;
>  	bio = bio_kmalloc(gfp_mask, nr_pages);
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 9ebf53903d7b..2d5ebf2c321b 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -1322,9 +1322,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
>  				     pages[i]->page,
>  				     seg[i].nsec << 9,
>  				     seg[i].offset) == 0)) {
> -
> -			int nr_iovecs = min_t(int, (nseg-i), BIO_MAX_PAGES);
> -			bio = bio_alloc(GFP_KERNEL, nr_iovecs);
> +			bio = bio_alloc(GFP_KERNEL, bio_max_segs(nseg - i));
>  			if (unlikely(bio == NULL))
>  				goto fail_put_bio;
>  
> diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
> index 4312007d2d34..2d3cda0acacb 100644
> --- a/drivers/md/dm-io.c
> +++ b/drivers/md/dm-io.c
> @@ -341,8 +341,8 @@ static void do_region(int op, int op_flags, unsigned region,
>  			num_bvecs = 1;
>  			break;
>  		default:
> -			num_bvecs = min_t(int, BIO_MAX_PAGES,
> -					  dm_sector_div_up(remaining, (PAGE_SIZE >> SECTOR_SHIFT)));
> +			num_bvecs = bio_max_segs(dm_sector_div_up(remaining,
> +						(PAGE_SIZE >> SECTOR_SHIFT)));
>  		}
>  
>  		bio = bio_alloc_bioset(GFP_NOIO, num_bvecs, &io->client->bios);
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index e3d35c6c9f71..57882654ffee 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -264,15 +264,14 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
>  			     size_t entrylen, void *data, size_t datalen,
>  			     sector_t sector)
>  {
> -	int num_pages, bio_pages, pg_datalen, pg_sectorlen, i;
> +	int bio_pages, pg_datalen, pg_sectorlen, i;
>  	struct page *page;
>  	struct bio *bio;
>  	size_t ret;
>  	void *ptr;
>  
>  	while (datalen) {
> -		num_pages = ALIGN(datalen, PAGE_SIZE) >> PAGE_SHIFT;
> -		bio_pages = min(num_pages, BIO_MAX_PAGES);
> +		bio_pages = bio_max_segs(DIV_ROUND_UP(datalen, PAGE_SIZE));
>  
>  		atomic_inc(&lc->io_blocks);
>  
> @@ -364,7 +363,7 @@ static int log_one_block(struct log_writes_c *lc,
>  		goto out;
>  
>  	atomic_inc(&lc->io_blocks);
> -	bio = bio_alloc(GFP_KERNEL, min(block->vec_cnt, BIO_MAX_PAGES));
> +	bio = bio_alloc(GFP_KERNEL, bio_max_segs(block->vec_cnt));
>  	if (!bio) {
>  		DMERR("Couldn't alloc log bio");
>  		goto error;
> @@ -386,7 +385,8 @@ static int log_one_block(struct log_writes_c *lc,
>  		if (ret != block->vecs[i].bv_len) {
>  			atomic_inc(&lc->io_blocks);
>  			submit_bio(bio);
> -			bio = bio_alloc(GFP_KERNEL, min(block->vec_cnt - i, BIO_MAX_PAGES));
> +			bio = bio_alloc(GFP_KERNEL,
> +					bio_max_segs(block->vec_cnt - i));
>  			if (!bio) {
>  				DMERR("Couldn't alloc log bio");
>  				goto error;
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index bf6e0ac9ad28..86703a0bdc2a 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -185,7 +185,7 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
>  	}
>  
>  	bip = bio_integrity_alloc(bio, GFP_NOIO,
> -		min_t(unsigned int, req->metadata_sg_cnt, BIO_MAX_PAGES));
> +					bio_max_segs(req->metadata_sg_cnt));
>  	if (IS_ERR(bip)) {
>  		pr_err("Unable to allocate bio_integrity_payload\n");
>  		return PTR_ERR(bip);
> @@ -225,7 +225,7 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
>  
>  static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  {
> -	int sg_cnt = req->sg_cnt;
> +	unsigned int sg_cnt = req->sg_cnt;
>  	struct bio *bio;
>  	struct scatterlist *sg;
>  	struct blk_plug plug;
> @@ -263,7 +263,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  		bio = &req->b.inline_bio;
>  		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>  	} else {
> -		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> +		bio = bio_alloc(GFP_KERNEL, bio_max_segs(sg_cnt));
>  	}
>  	bio_set_dev(bio, req->ns->bdev);
>  	bio->bi_iter.bi_sector = sector;
> @@ -290,7 +290,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  				}
>  			}
>  
> -			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> +			bio = bio_alloc(GFP_KERNEL, bio_max_segs(sg_cnt));
>  			bio_set_dev(bio, req->ns->bdev);
>  			bio->bi_iter.bi_sector = sector;
>  			bio->bi_opf = op;
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index cbc88acdd233..dc902555a35c 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -26,7 +26,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>  	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
>  	u16 status = NVME_SC_SUCCESS;
>  	struct nvme_id_ctrl *id;
> -	int max_hw_sectors;
> +	unsigned int max_hw_sectors;
>  	int page_shift;
>  
>  	id = kzalloc(sizeof(*id), GFP_KERNEL);
> @@ -198,7 +198,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>  		bio = &req->p.inline_bio;
>  		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>  	} else {
> -		bio = bio_alloc(GFP_KERNEL, min(req->sg_cnt, BIO_MAX_PAGES));
> +		bio = bio_alloc(GFP_KERNEL, bio_max_segs(req->sg_cnt));
>  		bio->bi_end_io = bio_put;
>  	}
>  	bio->bi_opf = req_op(rq);
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index 8ed93fd205c7..ee3d52061281 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -315,10 +315,8 @@ iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num, int op,
>  	 * Only allocate as many vector entries as the bio code allows us to,
>  	 * we'll loop later on until we have handled the whole request.
>  	 */
> -	if (sg_num > BIO_MAX_PAGES)
> -		sg_num = BIO_MAX_PAGES;
> -
> -	bio = bio_alloc_bioset(GFP_NOIO, sg_num, &ib_dev->ibd_bio_set);
> +	bio = bio_alloc_bioset(GFP_NOIO, bio_max_segs(sg_num),
> +				&ib_dev->ibd_bio_set);
>  	if (!bio) {
>  		pr_err("Unable to allocate memory for bio\n");
>  		return NULL;
> @@ -638,8 +636,7 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
>  		return -ENODEV;
>  	}
>  
> -	bip = bio_integrity_alloc(bio, GFP_NOIO,
> -			min_t(unsigned int, cmd->t_prot_nents, BIO_MAX_PAGES));
> +	bip = bio_integrity_alloc(bio, GFP_NOIO, bio_max_segs(cmd->t_prot_nents));
>  	if (IS_ERR(bip)) {
>  		pr_err("Unable to allocate bio_integrity_payload\n");
>  		return PTR_ERR(bip);
> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
> index 33770e5808ce..3cbc074992bc 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -881,7 +881,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
>  
>  			if (!bio) {
>  new_bio:
> -				nr_vecs = min_t(int, BIO_MAX_PAGES, nr_pages);
> +				nr_vecs = bio_max_segs(nr_pages);
>  				nr_pages -= nr_vecs;
>  				/*
>  				 * Calls bio_kmalloc() and sets bio->bi_end_io()
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index cf933048f139..9be7ad01110b 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -213,7 +213,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>  
>  static ssize_t
>  __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> -		int nr_pages)
> +		unsigned int nr_pages)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
> @@ -347,8 +347,8 @@ static void blkdev_bio_end_io(struct bio *bio)
>  	}
>  }
>  
> -static ssize_t
> -__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
> +static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
> +		unsigned int nr_pages)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = bdev_file_inode(file);
> @@ -478,7 +478,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  static ssize_t
>  blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
> -	int nr_pages;
> +	unsigned int nr_pages;
>  
>  	if (!iov_iter_count(iter))
>  		return 0;
> @@ -487,7 +487,7 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
>  		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>  
> -	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
> +	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>  }
>  
>  static __init int blkdev_init(void)
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 0957e1bb8eb2..b61491bf3166 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -695,7 +695,7 @@ static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
>  	if (ret)
>  		goto out;
>  	sector = start_sector << (sdio->blkbits - 9);
> -	nr_pages = min(sdio->pages_in_io, BIO_MAX_PAGES);
> +	nr_pages = bio_max_segs(sdio->pages_in_io);
>  	BUG_ON(nr_pages <= 0);
>  	dio_bio_alloc(dio, sdio, map_bh->b_bdev, sector, nr_pages);
>  	sdio->boundary = 0;
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index ea4f693bee22..f88851c5c250 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -215,10 +215,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  		/* max # of continuous pages */
>  		if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
>  			nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
> -		if (nblocks > BIO_MAX_PAGES)
> -			nblocks = BIO_MAX_PAGES;
>  
> -		bio = bio_alloc(GFP_NOIO, nblocks);
> +		bio = bio_alloc(GFP_NOIO, bio_max_segs(nblocks));
>  
>  		bio->bi_end_io = erofs_readendio;
>  		bio_set_dev(bio, sb->s_bdev);
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index f014c5e473a9..3db923403505 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -371,8 +371,7 @@ int ext4_mpage_readpages(struct inode *inode,
>  			 * bio_alloc will _always_ be able to allocate a bio if
>  			 * __GFP_DIRECT_RECLAIM is set, see bio_alloc_bioset().
>  			 */
> -			bio = bio_alloc(GFP_KERNEL,
> -				min_t(int, nr_pages, BIO_MAX_PAGES));
> +			bio = bio_alloc(GFP_KERNEL, bio_max_segs(nr_pages));
>  			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
>  						  GFP_KERNEL);
>  			ext4_set_bio_post_read_ctx(bio, inode, page->index);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 862df2477a5d..79008dcf7125 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -969,8 +969,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>  	unsigned int post_read_steps = 0;
>  
>  	bio = bio_alloc_bioset(for_write ? GFP_NOIO : GFP_KERNEL,
> -			       min_t(int, nr_pages, BIO_MAX_PAGES),
> -			       &f2fs_bioset);
> +			       bio_max_segs(nr_pages), &f2fs_bioset);
>  	if (!bio)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a8a0fb890e8d..4b0e2e3c2c88 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2747,7 +2747,7 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
>  	sum_entry = &sum->entries[0];
>  
>  	for (i = 0; i < last_offset; i += nrpages, addr += nrpages) {
> -		nrpages = min(last_offset - i, BIO_MAX_PAGES);
> +		nrpages = bio_max_segs(last_offset - i);
>  
>  		/* readahead node pages */
>  		f2fs_ra_meta_pages(sbi, addr, nrpages, META_POR, true);
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 16a1e82e3aeb..0d9d1a6a947e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -278,14 +278,14 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	if (!is_contig || bio_full(ctx->bio, plen)) {
>  		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
> -		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>  
>  		if (ctx->bio)
>  			submit_bio(ctx->bio);
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
> +		ctx->bio = bio_alloc(gfp, bio_max_segs(nr_vecs));
>  		/*
>  		 * If the bio_alloc fails, try it again for a single page to
>  		 * avoid having to deal with partial page reads.  This emulates
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 830e6cc2a9e7..961234d68779 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -304,9 +304,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  				goto out;
>  		}
>  		args->bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
> -					min_t(int, args->nr_pages,
> -					      BIO_MAX_PAGES),
> -					gfp);
> +					bio_max_segs(args->nr_pages), gfp);
>  		if (args->bio == NULL)
>  			goto confused;
>  	}
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> index 1a96ce28efb0..fe860c538747 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -115,13 +115,13 @@ bl_submit_bio(struct bio *bio)
>  	return NULL;
>  }
>  
> -static struct bio *
> -bl_alloc_init_bio(int npg, struct block_device *bdev, sector_t disk_sector,
> +static struct bio *bl_alloc_init_bio(unsigned int npg,
> +		struct block_device *bdev, sector_t disk_sector,
>  		bio_end_io_t end_io, struct parallel_io *par)
>  {
>  	struct bio *bio;
>  
> -	npg = min(npg, BIO_MAX_PAGES);
> +	npg = bio_max_segs(npg);
>  	bio = bio_alloc(GFP_NOIO, npg);
>  	if (bio) {
>  		bio->bi_iter.bi_sector = disk_sector;
> diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
> index e2148f2d5d6b..17f36db2f792 100644
> --- a/fs/xfs/xfs_bio_io.c
> +++ b/fs/xfs/xfs_bio_io.c
> @@ -6,7 +6,7 @@
>  
>  static inline unsigned int bio_max_vecs(unsigned int count)
>  {
> -	return min_t(unsigned, howmany(count, PAGE_SIZE), BIO_MAX_PAGES);
> +	return bio_max_segs(howmany(count, PAGE_SIZE));
>  }
>  
>  int
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index f6e5235df7c9..37a1d12762d8 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1480,7 +1480,7 @@ xfs_buf_ioapply_map(
>  	int		op)
>  {
>  	int		page_index;
> -	int		total_nr_pages = bp->b_page_count;
> +	unsigned int	total_nr_pages = bp->b_page_count;
>  	int		nr_pages;
>  	struct bio	*bio;
>  	sector_t	sector =  bp->b_maps[map].bm_bn;
> @@ -1505,7 +1505,7 @@ xfs_buf_ioapply_map(
>  
>  next_chunk:
>  	atomic_inc(&bp->b_io_remaining);
> -	nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
> +	nr_pages = bio_max_segs(total_nr_pages);
>  
>  	bio = bio_alloc(GFP_NOIO, nr_pages);
>  	bio_set_dev(bio, bp->b_target->bt_bdev);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c74857cf1252..354747bbb939 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -20,7 +20,12 @@
>  #define BIO_BUG_ON
>  #endif
>  
> -#define BIO_MAX_PAGES		256
> +#define BIO_MAX_PAGES		256U
> +
> +static inline unsigned int bio_max_segs(unsigned int nr_segs)
> +{
> +	return min(nr_segs, BIO_MAX_PAGES);
> +}
>  
>  #define bio_prio(bio)			(bio)->bi_ioprio
>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
> -- 
> 2.29.2
> 
