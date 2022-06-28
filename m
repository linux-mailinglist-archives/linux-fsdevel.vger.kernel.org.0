Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E255DFB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbiF1MjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiF1MjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344C2ED49
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED2A61464
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E4C3411D;
        Tue, 28 Jun 2022 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419945;
        bh=NhRcyotbgLHMYxBKa83o06ooChXyZA9Ii8z4BvVDLlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Auh8X6adcFplWIwpWO3HliZUxrXSG7EFUl+oTZqKXvIjSt4tmNEF3BcDyH8N5Wrb1
         Cd0g57qIFcauu8p21hflz5iYwiKJTNEp+2ZHVbTZBExlc5tbjXMo8cxsaVMIgpDCKE
         ZCKWPlebR/uBEG+BbTmIEdfKuwqUCC0e/w6c2SvtLeVFoD/MEN+16SktufHZsfwYSE
         Bc+cJ4/hPDV6QqvE6wo8tuur9nqgm/0Y8Li9mBL+z22HXNYl34q7IY4Ge4zmIB4cAl
         lnZmFCxaWYVPePsDu0f3X0jUsfMki78dKLyismXhpUbYLkn3myXqhzYUs1rNmLULBD
         9Tjpn2b4USnwQ==
Date:   Tue, 28 Jun 2022 14:38:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 09/44] new iov_iter flavour - ITER_UBUF
Message-ID: <20220628123855.75jdjh4b267odyz2@wittgenstein>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-9-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-9-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:17AM +0100, Al Viro wrote:
> Equivalent of single-segment iovec.  Initialized by iov_iter_ubuf(),
> checked for by iter_is_ubuf(), otherwise behaves like ITER_IOVEC
> ones.
> 
> We are going to expose the things like ->write_iter() et.al. to those
> in subsequent commits.
> 
> New predicate (user_backed_iter()) that is true for ITER_IOVEC and
> ITER_UBUF; places like direct-IO handling should use that for
> checking that pages we modify after getting them from iov_iter_get_pages()
> would need to be dirtied.
> 
> DO NOT assume that replacing iter_is_iovec() with user_backed_iter()
> will solve all problems - there's code that uses iter_is_iovec() to
> decide how to poke around in iov_iter guts and for that the predicate
> replacement obviously won't suffice.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  block/fops.c         |  6 +--
>  fs/ceph/file.c       |  2 +-
>  fs/cifs/file.c       |  2 +-
>  fs/direct-io.c       |  2 +-
>  fs/fuse/dev.c        |  4 +-
>  fs/fuse/file.c       |  2 +-
>  fs/gfs2/file.c       |  2 +-
>  fs/iomap/direct-io.c |  2 +-
>  fs/nfs/direct.c      |  2 +-
>  include/linux/uio.h  | 26 ++++++++++++
>  lib/iov_iter.c       | 94 ++++++++++++++++++++++++++++++++++----------
>  mm/shmem.c           |  2 +-
>  12 files changed, 113 insertions(+), 33 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 6e86931ab847..3e68d69e0ee3 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -69,7 +69,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>  
>  	if (iov_iter_rw(iter) == READ) {
>  		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
> -		if (iter_is_iovec(iter))
> +		if (user_backed_iter(iter))
>  			should_dirty = true;
>  	} else {
>  		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
> @@ -199,7 +199,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	}
>  
>  	dio->size = 0;
> -	if (is_read && iter_is_iovec(iter))
> +	if (is_read && user_backed_iter(iter))
>  		dio->flags |= DIO_SHOULD_DIRTY;
>  
>  	blk_start_plug(&plug);
> @@ -331,7 +331,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  	dio->size = bio->bi_iter.bi_size;
>  
>  	if (is_read) {
> -		if (iter_is_iovec(iter)) {
> +		if (user_backed_iter(iter)) {
>  			dio->flags |= DIO_SHOULD_DIRTY;
>  			bio_set_pages_dirty(bio);
>  		}
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8c8226c0feac..e132adeeaf16 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1262,7 +1262,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>  	size_t count = iov_iter_count(iter);
>  	loff_t pos = iocb->ki_pos;
>  	bool write = iov_iter_rw(iter) == WRITE;
> -	bool should_dirty = !write && iter_is_iovec(iter);
> +	bool should_dirty = !write && user_backed_iter(iter);
>  
>  	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
>  		return -EROFS;
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 1618e0537d58..4b4129d9a90c 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -4004,7 +4004,7 @@ static ssize_t __cifs_readv(
>  	if (!is_sync_kiocb(iocb))
>  		ctx->iocb = iocb;
>  
> -	if (iter_is_iovec(to))
> +	if (user_backed_iter(to))
>  		ctx->should_dirty = true;
>  
>  	if (direct) {
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 39647eb56904..72237f49ad94 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1245,7 +1245,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	spin_lock_init(&dio->bio_lock);
>  	dio->refcount = 1;
>  
> -	dio->should_dirty = iter_is_iovec(iter) && iov_iter_rw(iter) == READ;
> +	dio->should_dirty = user_backed_iter(iter) && iov_iter_rw(iter) == READ;
>  	sdio.iter = iter;
>  	sdio.final_block_in_request = end >> blkbits;
>  
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0e537e580dc1..8d657c2cd6f7 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1356,7 +1356,7 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
>  	if (!fud)
>  		return -EPERM;
>  
> -	if (!iter_is_iovec(to))
> +	if (!user_backed_iter(to))
>  		return -EINVAL;
>  
>  	fuse_copy_init(&cs, 1, to);
> @@ -1949,7 +1949,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
>  	if (!fud)
>  		return -EPERM;
>  
> -	if (!iter_is_iovec(from))
> +	if (!user_backed_iter(from))
>  		return -EINVAL;
>  
>  	fuse_copy_init(&cs, 0, from);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 00fa861aeead..c982e3afe3b4 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1465,7 +1465,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  			inode_unlock(inode);
>  	}
>  
> -	io->should_dirty = !write && iter_is_iovec(iter);
> +	io->should_dirty = !write && user_backed_iter(iter);
>  	while (count) {
>  		ssize_t nres;
>  		fl_owner_t owner = current->files;
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 2cceb193dcd8..48e6cc74fdc1 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -780,7 +780,7 @@ static inline bool should_fault_in_pages(struct iov_iter *i,
>  
>  	if (!count)
>  		return false;
> -	if (!iter_is_iovec(i))
> +	if (!user_backed_iter(i))
>  		return false;
>  
>  	size = PAGE_SIZE;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 31c7f1035b20..d5c7d019653b 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -533,7 +533,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iomi.flags |= IOMAP_NOWAIT;
>  		}
>  
> -		if (iter_is_iovec(iter))
> +		if (user_backed_iter(iter))
>  			dio->flags |= IOMAP_DIO_DIRTY;
>  	} else {
>  		iomi.flags |= IOMAP_WRITE;
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 4eb2a8380a28..022e1ce63e62 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -478,7 +478,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
>  	if (!is_sync_kiocb(iocb))
>  		dreq->iocb = iocb;
>  
> -	if (iter_is_iovec(iter))
> +	if (user_backed_iter(iter))
>  		dreq->flags = NFS_ODIRECT_SHOULD_DIRTY;
>  
>  	if (!swap)
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 76d305f3d4c2..6ab4260c3d6c 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -26,6 +26,7 @@ enum iter_type {
>  	ITER_PIPE,
>  	ITER_XARRAY,
>  	ITER_DISCARD,
> +	ITER_UBUF,
>  };
>  
>  struct iov_iter_state {
> @@ -38,6 +39,7 @@ struct iov_iter {
>  	u8 iter_type;
>  	bool nofault;
>  	bool data_source;
> +	bool user_backed;
>  	size_t iov_offset;
>  	size_t count;
>  	union {
> @@ -46,6 +48,7 @@ struct iov_iter {
>  		const struct bio_vec *bvec;
>  		struct xarray *xarray;
>  		struct pipe_inode_info *pipe;
> +		void __user *ubuf;
>  	};
>  	union {
>  		unsigned long nr_segs;
> @@ -70,6 +73,11 @@ static inline void iov_iter_save_state(struct iov_iter *iter,
>  	state->nr_segs = iter->nr_segs;
>  }
>  
> +static inline bool iter_is_ubuf(const struct iov_iter *i)
> +{
> +	return iov_iter_type(i) == ITER_UBUF;
> +}
> +
>  static inline bool iter_is_iovec(const struct iov_iter *i)
>  {
>  	return iov_iter_type(i) == ITER_IOVEC;
> @@ -105,6 +113,11 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
>  	return i->data_source ? WRITE : READ;
>  }
>  
> +static inline bool user_backed_iter(const struct iov_iter *i)
> +{
> +	return i->user_backed;
> +}
> +
>  /*
>   * Total number of bytes covered by an iovec.
>   *
> @@ -320,4 +333,17 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
>  int import_single_range(int type, void __user *buf, size_t len,
>  		 struct iovec *iov, struct iov_iter *i);
>  
> +static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
> +			void __user *buf, size_t count)
> +{
> +	WARN_ON(direction & ~(READ | WRITE));
> +	*i = (struct iov_iter) {
> +		.iter_type = ITER_UBUF,
> +		.user_backed = true,
> +		.data_source = direction,
> +		.ubuf = buf,
> +		.count = count
> +	};
> +}
> +
>  #endif
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 4c658a25e29c..8275b28e886b 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -16,6 +16,16 @@
>  
>  #define PIPE_PARANOIA /* for now */
>  
> +/* covers ubuf and kbuf alike */
> +#define iterate_buf(i, n, base, len, off, __p, STEP) {		\
> +	size_t __maybe_unused off = 0;				\
> +	len = n;						\
> +	base = __p + i->iov_offset;				\
> +	len -= (STEP);						\
> +	i->iov_offset += len;					\
> +	n = len;						\
> +}
> +
>  /* covers iovec and kvec alike */
>  #define iterate_iovec(i, n, base, len, off, __p, STEP) {	\
>  	size_t off = 0;						\
> @@ -110,7 +120,12 @@ __out:								\
>  	if (unlikely(i->count < n))				\
>  		n = i->count;					\
>  	if (likely(n)) {					\
> -		if (likely(iter_is_iovec(i))) {			\
> +		if (likely(iter_is_ubuf(i))) {			\
> +			void __user *base;			\
> +			size_t len;				\
> +			iterate_buf(i, n, base, len, off,	\
> +						i->ubuf, (I)) 	\
> +		} else if (likely(iter_is_iovec(i))) {		\
>  			const struct iovec *iov = i->iov;	\
>  			void __user *base;			\
>  			size_t len;				\
> @@ -275,7 +290,11 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
>   */
>  size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
>  {
> -	if (iter_is_iovec(i)) {
> +	if (iter_is_ubuf(i)) {
> +		size_t n = min(size, iov_iter_count(i));
> +		n -= fault_in_readable(i->ubuf + i->iov_offset, n);
> +		return size - n;
> +	} else if (iter_is_iovec(i)) {
>  		size_t count = min(size, iov_iter_count(i));
>  		const struct iovec *p;
>  		size_t skip;
> @@ -314,7 +333,11 @@ EXPORT_SYMBOL(fault_in_iov_iter_readable);
>   */
>  size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
>  {
> -	if (iter_is_iovec(i)) {
> +	if (iter_is_ubuf(i)) {
> +		size_t n = min(size, iov_iter_count(i));
> +		n -= fault_in_safe_writeable(i->ubuf + i->iov_offset, n);
> +		return size - n;
> +	} else if (iter_is_iovec(i)) {
>  		size_t count = min(size, iov_iter_count(i));
>  		const struct iovec *p;
>  		size_t skip;
> @@ -345,6 +368,7 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
>  	*i = (struct iov_iter) {
>  		.iter_type = ITER_IOVEC,
>  		.nofault = false,
> +		.user_backed = true,
>  		.data_source = direction,
>  		.iov = iov,
>  		.nr_segs = nr_segs,
> @@ -494,7 +518,7 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  {
>  	if (unlikely(iov_iter_is_pipe(i)))
>  		return copy_pipe_to_iter(addr, bytes, i);
> -	if (iter_is_iovec(i))
> +	if (user_backed_iter(i))
>  		might_fault();
>  	iterate_and_advance(i, bytes, base, len, off,
>  		copyout(base, addr + off, len),
> @@ -576,7 +600,7 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  {
>  	if (unlikely(iov_iter_is_pipe(i)))
>  		return copy_mc_pipe_to_iter(addr, bytes, i);
> -	if (iter_is_iovec(i))
> +	if (user_backed_iter(i))
>  		might_fault();
>  	__iterate_and_advance(i, bytes, base, len, off,
>  		copyout_mc(base, addr + off, len),
> @@ -594,7 +618,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
>  		WARN_ON(1);
>  		return 0;
>  	}
> -	if (iter_is_iovec(i))
> +	if (user_backed_iter(i))
>  		might_fault();
>  	iterate_and_advance(i, bytes, base, len, off,
>  		copyin(addr + off, base, len),
> @@ -882,16 +906,16 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>  {
>  	if (unlikely(i->count < size))
>  		size = i->count;
> -	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> +		i->iov_offset += size;
> +		i->count -= size;
> +	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
>  		/* iovec and kvec have identical layouts */
>  		iov_iter_iovec_advance(i, size);
>  	} else if (iov_iter_is_bvec(i)) {
>  		iov_iter_bvec_advance(i, size);
>  	} else if (iov_iter_is_pipe(i)) {
>  		pipe_advance(i, size);
> -	} else if (unlikely(iov_iter_is_xarray(i))) {
> -		i->iov_offset += size;
> -		i->count -= size;
>  	} else if (iov_iter_is_discard(i)) {
>  		i->count -= size;
>  	}
> @@ -938,7 +962,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
>  		return;
>  	}
>  	unroll -= i->iov_offset;
> -	if (iov_iter_is_xarray(i)) {
> +	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
>  		BUG(); /* We should never go beyond the start of the specified
>  			* range since we might then be straying into pages that
>  			* aren't pinned.
> @@ -1129,6 +1153,13 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
>  
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> +	if (likely(iter_is_ubuf(i))) {
> +		size_t size = i->count;
> +		if (size)
> +			return ((unsigned long)i->ubuf + i->iov_offset) | size;
> +		return 0;
> +	}
> +
>  	/* iovec and kvec have identical layouts */
>  	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
>  		return iov_iter_alignment_iovec(i);
> @@ -1159,6 +1190,9 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
>  	size_t size = i->count;
>  	unsigned k;
>  
> +	if (iter_is_ubuf(i))
> +		return 0;
> +
>  	if (WARN_ON(!iter_is_iovec(i)))
>  		return ~0U;
>  
> @@ -1287,7 +1321,19 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	return actual;
>  }
>  
> -/* must be done on non-empty ITER_IOVEC one */
> +static unsigned long found_ubuf_segment(unsigned long addr,
> +					size_t len,
> +					size_t *size, size_t *start,
> +					unsigned maxpages)
> +{
> +	len += (*start = addr % PAGE_SIZE);

Ugh, I know you just copy-pasted this but can we rewrite this to:

	*start = addr % PAGE_SIZE;
	len += *start;

I think that's easier to read.
