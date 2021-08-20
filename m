Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4A3F329F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhHTR7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 13:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhHTR7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:59:22 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2BC061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:58:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so9919691pgp.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cAJ2mKOoecgp7Lfavwh/H9j2C5W+lsWZlmT+5QJSgc4=;
        b=wGH+nKINSf1EeERKzTPDHOLIdX+SeRYSbI+KKeCS1TH55VM//Vmq+wza+yeZEDXFnn
         84NbgVZRG7BOdY4e3IwveNHQsiRL5pE/b0aoiJzNps+BB++XbuJy/Fp0Jc6IA5Vxarx0
         ASEFDy3uL5/QU+BRgTaJpkg7hTDjaP8lGfffzD/L5VpctOo0ofLqk1/bLwVzB14//U8n
         YHMNopWyUaLm663AenoEFxH8TDtv2t5GOKyt3yGVs03pbU1cUSCJdzf5SYBEIWDx4M7B
         ILY6/7QLDHZiu8TfTkH7DwXYN493l7jxun+HmN28ES/VlIitNRGL9Nv8LAr5VWhju5jf
         i1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cAJ2mKOoecgp7Lfavwh/H9j2C5W+lsWZlmT+5QJSgc4=;
        b=dVib1gVf3HPyJTQhhC93D5lmaTSt9A+QtYIgGvMzYkfbApq4SV/+QnvkkJ1ydY75Om
         y5768eY+ZAFOQnL5kRIRdYid3+PiwdtNDMkuVBYSzYe3NgFa+qcKYMFTkeoe7/m+SOvg
         wGdTDd6XOtkkH8BNo+cDtEHtSD1SACvgcAfrctBH6Fiy/59OomhJ2G2/dOzK3yqvEnXq
         lk5N9nk8cUzWCRsRLisDpL9/WFgg9m8+H1kr2Jugqq9VM5Z66DbXOemPVY9WhKlQE5Nw
         rscuIjPk6jcoArbeJYPpbxSaVp/UsA0402jyHPdloP3PkIjN2GglnZPxet4JJw2XLLFj
         EyYg==
X-Gm-Message-State: AOAM533HcVN68jGAtPsTPjjNMMiuc7eAnMK3cmMjFCB0wpagBBda7Dw9
        fIPBy0cikKAIVD4tPI+u75IQIA==
X-Google-Smtp-Source: ABdhPJwuJCUOjQ9nPaWkoUpInL4x+tOgmOUIeSUkF+BqrJz1B+kfJWMqpBNA/wvIxVpksM1z3pznOg==
X-Received: by 2002:a63:db4a:: with SMTP id x10mr5954417pgi.30.1629482323643;
        Fri, 20 Aug 2021 10:58:43 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id j5sm12320126pjv.56.2021.08.20.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:58:43 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:58:41 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 08/14] btrfs: add BTRFS_IOC_ENCODED_READ
Message-ID: <YR/tURmdikqMOS1n@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <6716dfd581687f8662d3c828ca2f9911ba58c721.1629234193.git.osandov@fb.com>
 <b2661262-2beb-6a91-005d-261fad0564ac@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2661262-2beb-6a91-005d-261fad0564ac@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:30:02PM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > There are 4 main cases:
> > 
> > 1. Inline extents: we copy the data straight out of the extent buffer.
> > 2. Hole/preallocated extents: we fill in zeroes.
> > 3. Regular, uncompressed extents: we read the sectors we need directly
> >    from disk.
> > 4. Regular, compressed extents: we read the entire compressed extent
> >    from disk and indicate what subset of the decompressed extent is in
> >    the file.
> > 
> > This initial implementation simplifies a few things that can be improved
> > in the future:
> > 
> > - We hold the inode lock during the operation.
> > - Cases 1, 3, and 4 allocate temporary memory to read into before
> >   copying out to userspace.
> > - We don't do read repair, because it turns out that read repair is
> >   currently broken for compressed data.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/ctree.h |   4 +
> >  fs/btrfs/inode.c | 489 +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/ioctl.c | 111 +++++++++++
> >  3 files changed, 604 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 973616d80080..b68d8ea42f6e 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3219,6 +3219,10 @@ int btrfs_writepage_cow_fixup(struct page *page);
> >  void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
> >  					  struct page *page, u64 start,
> >  					  u64 end, bool uptodate);
> > +struct btrfs_ioctl_encoded_io_args;
> > +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
> > +			   struct btrfs_ioctl_encoded_io_args *encoded);
> > +
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >  extern const struct iomap_ops btrfs_dio_iomap_ops;
> >  extern const struct iomap_dio_ops btrfs_dio_ops;
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 0b5ff14aa7fd..6d7fae859fb5 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -10496,6 +10496,495 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
> >  	}
> >  }
> >  
> > +static int btrfs_encoded_io_compression_from_extent(int compress_type)
> > +{
> > +	switch (compress_type) {
> > +	case BTRFS_COMPRESS_NONE:
> > +		return BTRFS_ENCODED_IO_COMPRESSION_NONE;
> > +	case BTRFS_COMPRESS_ZLIB:
> > +		return BTRFS_ENCODED_IO_COMPRESSION_ZLIB;
> > +	case BTRFS_COMPRESS_LZO:
> > +		/*
> > +		 * The LZO format depends on the page size. 64k is the maximum
> > +		 * sectorsize (and thus page size) that we support.
> > +		 */
> > +		if (PAGE_SIZE < SZ_4K || PAGE_SIZE > SZ_64K)
> > +			return -EINVAL;
> > +		return BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + (PAGE_SHIFT - 12);
> > +	case BTRFS_COMPRESS_ZSTD:
> > +		return BTRFS_ENCODED_IO_COMPRESSION_ZSTD;
> > +	default:
> > +		return -EUCLEAN;
> > +	}
> > +}
> > +
> > +static ssize_t btrfs_encoded_read_inline(
> > +				struct kiocb *iocb,
> > +				struct iov_iter *iter, u64 start,
> > +				u64 lockend,
> > +				struct extent_state **cached_state,
> > +				u64 extent_start, size_t count,
> > +				struct btrfs_ioctl_encoded_io_args *encoded,
> > +				bool *unlocked)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +	struct btrfs_path *path;
> > +	struct extent_buffer *leaf;
> > +	struct btrfs_file_extent_item *item;
> > +	u64 ram_bytes;
> > +	unsigned long ptr;
> > +	void *tmp;
> > +	ssize_t ret;
> > +
> > +	path = btrfs_alloc_path();
> > +	if (!path) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	ret = btrfs_lookup_file_extent(NULL, BTRFS_I(inode)->root, path,
> > +				       btrfs_ino(BTRFS_I(inode)), extent_start,
> > +				       0);
> > +	if (ret) {
> > +		if (ret > 0) {
> > +			/* The extent item disappeared? */
> > +			ret = -EIO;
> > +		}
> > +		goto out;
> > +	}
> > +	leaf = path->nodes[0];
> > +	item = btrfs_item_ptr(leaf, path->slots[0],
> > +			      struct btrfs_file_extent_item);
> > +
> > +	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
> > +	ptr = btrfs_file_extent_inline_start(item);
> > +
> > +	encoded->len = (min_t(u64, extent_start + ram_bytes, inode->i_size) -
> > +			iocb->ki_pos);
> > +	ret = btrfs_encoded_io_compression_from_extent(
> > +				 btrfs_file_extent_compression(leaf, item));
> > +	if (ret < 0)
> > +		goto out;
> > +	encoded->compression = ret;
> > +	if (encoded->compression) {
> > +		size_t inline_size;
> > +
> > +		inline_size = btrfs_file_extent_inline_item_len(leaf,
> > +						btrfs_item_nr(path->slots[0]));
> > +		if (inline_size > count) {
> > +			ret = -ENOBUFS;
> > +			goto out;
> > +		}
> > +		count = inline_size;
> > +		encoded->unencoded_len = ram_bytes;
> > +		encoded->unencoded_offset = iocb->ki_pos - extent_start;
> > +	} else {
> > +		encoded->len = encoded->unencoded_len = count =
> > +			min_t(u64, count, encoded->len);
> > +		ptr += iocb->ki_pos - extent_start;
> > +	}
> > +
> > +	tmp = kmalloc(count, GFP_NOFS);
> > +	if (!tmp) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	read_extent_buffer(leaf, tmp, ptr, count);
> > +	btrfs_release_path(path);
> > +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> > +	inode_unlock_shared(inode);
> > +	*unlocked = true;
> > +
> > +	ret = copy_to_iter(tmp, count, iter);
> > +	if (ret != count)
> > +		ret = -EFAULT;
> > +	kfree(tmp);
> > +out:
> > +	btrfs_free_path(path);
> > +	return ret;
> > +}
> > +
> > +struct btrfs_encoded_read_private {
> > +	struct inode *inode;
> > +	wait_queue_head_t wait;
> > +	atomic_t pending;
> > +	blk_status_t status;
> > +	bool skip_csum;
> > +};
> > +
> > +static blk_status_t submit_encoded_read_bio(struct inode *inode,
> > +					    struct bio *bio, int mirror_num,
> > +					    unsigned long bio_flags)
> > +{
> > +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> > +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	blk_status_t ret;
> > +
> > +	if (!priv->skip_csum) {
> > +		ret = btrfs_lookup_bio_sums(inode, bio, NULL);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> > +	if (ret) {
> > +		btrfs_io_bio_free_csum(io_bio);
> > +		return ret;
> > +	}
> > +
> > +	atomic_inc(&priv->pending);
> > +	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> > +	if (ret) {
> > +		atomic_dec(&priv->pending);
> > +		btrfs_io_bio_free_csum(io_bio);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static blk_status_t btrfs_encoded_read_check_bio(struct btrfs_io_bio *io_bio)
> > +{
> > +	const bool uptodate = io_bio->bio.bi_status == BLK_STS_OK;
> > +	struct btrfs_encoded_read_private *priv = io_bio->bio.bi_private;
> > +	struct inode *inode = priv->inode;
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	u32 sectorsize = fs_info->sectorsize;
> > +	struct bio_vec *bvec;
> > +	struct bvec_iter_all iter_all;
> > +	u64 start = io_bio->logical;
> > +	u32 bio_offset = 0;
> > +
> > +	if (priv->skip_csum || !uptodate)
> > +		return io_bio->bio.bi_status;
> > +
> > +	bio_for_each_segment_all(bvec, &io_bio->bio, iter_all) {
> > +		unsigned int i, nr_sectors, pgoff;
> > +
> > +		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
> > +		pgoff = bvec->bv_offset;
> > +		for (i = 0; i < nr_sectors; i++) {
> > +			ASSERT(pgoff < PAGE_SIZE);
> > +			if (check_data_csum(inode, io_bio, bio_offset,
> > +					    bvec->bv_page, pgoff, start))
> > +				return BLK_STS_IOERR;
> > +			start += sectorsize;
> > +			bio_offset += sectorsize;
> > +			pgoff += sectorsize;
> > +		}
> > +	}
> > +	return BLK_STS_OK;
> > +}
> > +
> > +static void btrfs_encoded_read_endio(struct bio *bio)
> > +{
> > +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> > +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
> > +	blk_status_t status;
> > +
> > +	status = btrfs_encoded_read_check_bio(io_bio);
> > +	if (status) {
> > +		/*
> > +		 * The memory barrier implied by the atomic_dec_return() here
> > +		 * pairs with the memory barrier implied by the
> > +		 * atomic_dec_return() or io_wait_event() in
> > +		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
> > +		 * write is observed before the load of status in
> > +		 * btrfs_encoded_read_regular_fill_pages().
> > +		 */
> > +		WRITE_ONCE(priv->status, status);
> > +	}
> > +	if (!atomic_dec_return(&priv->pending))
> > +		wake_up(&priv->wait);
> > +	btrfs_io_bio_free_csum(io_bio);
> > +	bio_put(bio);
> > +}
> > +
> > +static int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
> > +						 u64 disk_io_size, struct page **pages)
> > +{
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	struct btrfs_encoded_read_private priv = {
> > +		.inode = inode,
> > +		.pending = ATOMIC_INIT(1),
> > +		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
> > +	};
> > +	unsigned long i = 0;
> > +	u64 cur = 0;
> > +	int ret;
> > +
> > +	init_waitqueue_head(&priv.wait);
> > +	/*
> > +	 * Submit bios for the extent, splitting due to bio or stripe limits as
> > +	 * necessary.
> > +	 */
> > +	while (cur < disk_io_size) {
> > +		struct extent_map *em;
> > +		struct btrfs_io_geometry geom;
> > +		struct bio *bio = NULL;
> > +		u64 remaining;
> > +
> > +		em = btrfs_get_chunk_map(fs_info, offset + cur,
> > +					 disk_io_size - cur);
> > +		if (IS_ERR(em)) {
> > +			ret = PTR_ERR(em);
> > +		} else {
> > +			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
> > +						    offset + cur, &geom);
> > +			free_extent_map(em);
> > +		}
> > +		if (ret) {
> > +			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
> > +			break;
> > +		}
> > +		remaining = min(geom.len, disk_io_size - cur);
> > +		while (bio || remaining) {
> > +			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
> > +
> > +			if (!bio) {
> > +				bio = btrfs_bio_alloc(offset + cur);
> > +				bio->bi_end_io = btrfs_encoded_read_endio;
> > +				bio->bi_private = &priv;
> > +				bio->bi_opf = REQ_OP_READ;
> > +			}
> > +
> > +			if (!bytes ||
> > +			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
> > +				blk_status_t status;
> > +
> > +				status = submit_encoded_read_bio(inode, bio, 0,
> > +								 0);
> > +				if (status) {
> > +					WRITE_ONCE(priv.status, status);
> > +					bio_put(bio);
> > +					goto out;
> > +				}
> > +				bio = NULL;
> > +				continue;
> > +			}
> > +
> > +			i++;
> > +			cur += bytes;
> > +			remaining -= bytes;
> > +		}
> > +	}
> > +
> > +out:
> > +	if (atomic_dec_return(&priv.pending))
> > +		io_wait_event(priv.wait, !atomic_read(&priv.pending));
> > +	/* See btrfs_encoded_read_endio() for ordering. */
> > +	return blk_status_to_errno(READ_ONCE(priv.status));
> > +}
> > +
> > +static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
> > +					  struct iov_iter *iter,
> > +					  u64 start, u64 lockend,
> > +					  struct extent_state **cached_state,
> > +					  u64 offset, u64 disk_io_size,
> > +					  size_t count, bool compressed,
> > +					  bool *unlocked)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +	struct page **pages;
> > +	unsigned long nr_pages, i;
> > +	u64 cur;
> > +	size_t page_offset;
> > +	ssize_t ret;
> > +
> > +	nr_pages = DIV_ROUND_UP(disk_io_size, PAGE_SIZE);
> > +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> > +	if (!pages)
> > +		return -ENOMEM;
> > +	for (i = 0; i < nr_pages; i++) {
> > +		pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> > +		if (!pages[i]) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	ret = btrfs_encoded_read_regular_fill_pages(inode, offset, disk_io_size,
> > +						    pages);
> > +	if (ret)
> > +		goto out;
> > +
> > +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> > +	inode_unlock_shared(inode);
> > +	*unlocked = true;
> > +
> > +	if (compressed) {
> > +		i = 0;
> > +		page_offset = 0;
> > +	} else {
> > +		i = (iocb->ki_pos - start) >> PAGE_SHIFT;
> > +		page_offset = (iocb->ki_pos - start) & (PAGE_SIZE - 1);
> > +	}
> > +	cur = 0;
> > +	while (cur < count) {
> > +		size_t bytes = min_t(size_t, count - cur,
> > +				     PAGE_SIZE - page_offset);
> > +
> > +		if (copy_page_to_iter(pages[i], page_offset, bytes,
> > +				      iter) != bytes) {
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> > +		i++;
> > +		cur += bytes;
> > +		page_offset = 0;
> > +	}
> > +	ret = count;
> > +out:
> > +	for (i = 0; i < nr_pages; i++) {
> > +		if (pages[i])
> > +			__free_page(pages[i]);
> > +	}
> > +	kfree(pages);
> > +	return ret;
> > +}
> > +
> > +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
> > +			   struct btrfs_ioctl_encoded_io_args *encoded)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +	ssize_t ret;
> > +	size_t count = iov_iter_count(iter);
> > +	u64 start, lockend, offset, disk_io_size;
> > +	struct extent_state *cached_state = NULL;
> > +	struct extent_map *em;
> > +	bool unlocked = false;
> > +
> > +	file_accessed(iocb->ki_filp);
> > +
> > +	inode_lock_shared(inode);
> > +
> > +	if (iocb->ki_pos >= inode->i_size) {
> > +		inode_unlock_shared(inode);
> > +		return 0;
> 
> Don't we need to signal beyond EOF reads somehow. As it stands returning
> 0 means returning zeroed portion of btrfs_ioctl_encoded_io_args to user
> space?

If you do a normal read/pread beyond EOF, the syscall returns 0,
indicating that there are no bytes to read at that offset. We're doing
the same thing here: returning 0 means 0 compressed bytes were read, and
setting btrfs_ioctl_encoded_io_args::len to 0 means 0 bytes in the file
were read.

> > +	}
> > +	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
> > +	/*
> > +	 * We don't know how long the extent containing iocb->ki_pos is, but if
> > +	 * it's compressed we know that it won't be longer than this.
> > +	 */
> > +	lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
> > +
> > +	for (;;) {
> > +		struct btrfs_ordered_extent *ordered;
> > +
> > +		ret = btrfs_wait_ordered_range(inode, start,
> > +					       lockend - start + 1);
> > +		if (ret)
> > +			goto out_unlock_inode;
> > +		lock_extent_bits(io_tree, start, lockend, &cached_state);
> > +		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
> > +						     lockend - start + 1);
> > +		if (!ordered)
> > +			break;
> > +		btrfs_put_ordered_extent(ordered);
> > +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> > +		cond_resched();
> > +	}
> Can't you simply use btrfs_lock_and_flush_ordered_range, the major
> difference is btrfs_wait_ordered_range basically instantiates any
> pending delalloc, whilst btrfs_lock_and_flush_ordered_range returns with
> any, already-instantiated OE run to completion and the range locked ?

Josef asked this before here:
https://lore.kernel.org/linux-btrfs/1286c8c7-521f-d60c-97d5-c42dc57ce6a9@toxicpanda.com/.
It's not sufficient to run instantiated ordered extents. We actually
need to flush pending buffered writes.

> > +
> > +	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
> > +			      lockend - start + 1);
> > +	if (IS_ERR(em)) {
> > +		ret = PTR_ERR(em);
> > +		goto out_unlock_extent;
> > +	}
> > +
> > +	if (em->block_start == EXTENT_MAP_INLINE) {
> > +		u64 extent_start = em->start;
> > +
> > +		/*
> > +		 * For inline extents we get everything we need out of the
> > +		 * extent item.
> > +		 */
> > +		free_extent_map(em);
> > +		em = NULL;
> > +		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
> > +						&cached_state, extent_start,
> > +						count, encoded, &unlocked);
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * We only want to return up to EOF even if the extent extends beyond
> > +	 * that.
> > +	 */
> > +	encoded->len = (min_t(u64, extent_map_end(em), inode->i_size) -
> > +			iocb->ki_pos);
> > +	if (em->block_start == EXTENT_MAP_HOLE ||
> > +	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
> > +		offset = EXTENT_MAP_HOLE;
> > +		encoded->len = encoded->unencoded_len = count =
> > +			min_t(u64, count, encoded->len);
> > +	} else if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
> > +		offset = em->block_start;
> > +		/*
> > +		 * Bail if the buffer isn't large enough to return the whole
> > +		 * compressed extent.
> > +		 */
> > +		if (em->block_len > count) {
> > +			ret = -ENOBUFS;
> > +			goto out_em;
> > +		}
> > +		disk_io_size = count = em->block_len;
> > +		encoded->unencoded_len = em->ram_bytes;
> > +		encoded->unencoded_offset = iocb->ki_pos - em->orig_start;
> > +		ret = btrfs_encoded_io_compression_from_extent(
> > +							     em->compress_type);
> > +		if (ret < 0)
> > +			goto out_em;
> > +		encoded->compression = ret;
> > +	} else {
> > +		offset = em->block_start + (start - em->start);
> > +		if (encoded->len > count)
> > +			encoded->len = count;
> > +		/*
> > +		 * Don't read beyond what we locked. This also limits the page
> > +		 * allocations that we'll do.
> > +		 */
> > +		disk_io_size = min(lockend + 1,
> > +				   iocb->ki_pos + encoded->len) - start;
> > +		encoded->len = encoded->unencoded_len = count =
> > +			start + disk_io_size - iocb->ki_pos;
> > +		disk_io_size = ALIGN(disk_io_size, fs_info->sectorsize);
> > +	}
> > +	free_extent_map(em);
> > +	em = NULL;
> > +
> > +	if (offset == EXTENT_MAP_HOLE) {
> > +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> > +		inode_unlock_shared(inode);
> > +		unlocked = true;
> > +		ret = iov_iter_zero(count, iter);
> > +		if (ret != count)
> > +			ret = -EFAULT;
> > +	} else {
> > +		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
> > +						 &cached_state, offset,
> > +						 disk_io_size, count,
> > +						 encoded->compression,
> > +						 &unlocked);
> > +	}
> > +
> > +out:
> > +	if (ret >= 0)
> > +		iocb->ki_pos += encoded->len;
> > +out_em:
> > +	free_extent_map(em);
> > +out_unlock_extent:
> > +	if (!unlocked)
> > +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> > +out_unlock_inode:
> > +	if (!unlocked)
> > +		inode_unlock_shared(inode);
> > +	return ret;
> > +}
> > +
> >  #ifdef CONFIG_SWAP
> >  /*
> >   * Add an entry indicating a block group or device which is pinned by a
> 
> <snip>
> 
> >  /* Mask out flags that are inappropriate for the given type of inode. */
> > @@ -4887,6 +4904,94 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
> >  	return ret;
> >  }
> >  
> > +static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
> > +				    bool compat)
> > +{
> > +	struct btrfs_ioctl_encoded_io_args args;
> 
> nit: If you make this args = {}; you guarantee it's zeroed out then you
> can get rid of the ugly memset further down.

Sure, I'll do that.
