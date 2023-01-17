Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1466D757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 08:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjAQH5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 02:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjAQH5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:57:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC609252BB;
        Mon, 16 Jan 2023 23:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wPZGCRm9fLP2qxpP9iZPZc4YEk7ulXanFqcVkLA61+I=; b=zgLvzjzI0fCQR/Yc7XdQCqWEPH
        N2Zm3V/HvsOjXlyeJjRnczeOVeGn/2p0Pn4ME62ExA/v2exrzoylgOHfM4P9sy9fuFdqJPWPk4WNP
        zdKzNG4usVajyjOYF4Hzch23F7QJJzS5alevw36Rx8WBm44DQ6GSYIbGDv4zZrWclCCu5ipYOOqj7
        FhdK+i5hB6gwjgcOHQAgClYORMmihpA8ZdiK4FZlT8HXNdlpURyRFQVOKxECS+notQCrzfmAw0IFU
        mkiDHA4whfJApqCXRt5q/8WFyJl2qibFC9Dy9yS2D7eUcQA0CJwUwRLbki9hVKz08MroQsDBaLQM+
        x1ov5pxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHgqC-00DG4M-SE; Tue, 17 Jan 2023 07:57:08 +0000
Date:   Mon, 16 Jan 2023 23:57:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
Message-ID: <Y8ZU1Jjx5VSetvOn@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:08:24PM +0000, David Howells wrote:
> Define FOLL_SOURCE_BUF and FOLL_DEST_BUF to indicate to get_user_pages*()
> and iov_iter_get_pages*() how the buffer is intended to be used in an I/O
> operation.  Don't use READ and WRITE as a read I/O writes to memory and
> vice versa - which causes confusion.
> 
> The direction is checked against the iterator's data_source.

Why can't we use the existing FOLL_WRITE?

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  block/bio.c             |    6 ++++++
>  block/blk-map.c         |    2 ++
>  crypto/af_alg.c         |    9 ++++++---
>  crypto/algif_hash.c     |    3 ++-
>  drivers/vhost/scsi.c    |    9 ++++++---
>  fs/ceph/addr.c          |    2 +-
>  fs/ceph/file.c          |   14 ++++++++------
>  fs/cifs/file.c          |    8 ++++----
>  fs/cifs/misc.c          |    3 ++-
>  fs/direct-io.c          |    6 ++++--
>  fs/fuse/dev.c           |    3 ++-
>  fs/fuse/file.c          |    8 ++++----
>  fs/nfs/direct.c         |   10 ++++++----
>  fs/splice.c             |    3 ++-
>  include/crypto/if_alg.h |    3 ++-
>  include/linux/bio.h     |   18 ++++++++++++++++--
>  include/linux/mm.h      |   10 ++++++++++
>  lib/iov_iter.c          |   14 +++++++-------
>  net/9p/trans_virtio.c   |   12 ++++++++----
>  net/core/datagram.c     |    5 +++--
>  net/core/skmsg.c        |    4 ++--
>  net/rds/message.c       |    4 ++--
>  net/tls/tls_sw.c        |    5 ++---
>  23 files changed, 107 insertions(+), 54 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 5f96fcae3f75..867cf4db87ea 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1242,6 +1242,8 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
>   * pages will have to be released using put_page() when done.
>   * For multi-segment *iter, this function only adds pages from the
>   * next non-empty segment of the iov iterator.
> + *
> + * The I/O direction is determined from the bio operation type.
>   */
>  static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
> @@ -1263,6 +1265,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
> +	gup_flags |= bio_is_write(bio) ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
> +
>  	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
>  		gup_flags |= FOLL_PCI_P2PDMA;
>  
> @@ -1332,6 +1336,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   * fit into the bio, or are requested in @iter, whatever is smaller. If
>   * MM encounters an error pinning the requested pages, it stops. Error
>   * is returned only if 0 pages could be pinned.
> + *
> + * The bio operation indicates the data direction.
>   */
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 08cbb7ff3b19..c30be529fb55 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -279,6 +279,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  	if (bio == NULL)
>  		return -ENOMEM;
>  
> +	gup_flags |= bio_is_write(bio) ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
> +
>  	if (blk_queue_pci_p2pdma(rq->q))
>  		gup_flags |= FOLL_PCI_P2PDMA;
>  
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index 0a4fa2a429e2..7a68db157fae 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -531,13 +531,15 @@ static const struct net_proto_family alg_family = {
>  	.owner	=	THIS_MODULE,
>  };
>  
> -int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len)
> +int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len,
> +		   unsigned int gup_flags)
>  {
>  	size_t off;
>  	ssize_t n;
>  	int npages, i;
>  
> -	n = iov_iter_get_pages2(iter, sgl->pages, len, ALG_MAX_PAGES, &off);
> +	n = iov_iter_get_pages(iter, sgl->pages, len, ALG_MAX_PAGES, &off,
> +			       gup_flags);
>  	if (n < 0)
>  		return n;
>  
> @@ -1310,7 +1312,8 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
>  		list_add_tail(&rsgl->list, &areq->rsgl_list);
>  
>  		/* make one iovec available as scatterlist */
> -		err = af_alg_make_sg(&rsgl->sgl, &msg->msg_iter, seglen);
> +		err = af_alg_make_sg(&rsgl->sgl, &msg->msg_iter, seglen,
> +				     FOLL_DEST_BUF);
>  		if (err < 0) {
>  			rsgl->sg_num_bytes = 0;
>  			return err;
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index 1d017ec5c63c..fe3d2258145f 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -91,7 +91,8 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
>  		if (len > limit)
>  			len = limit;
>  
> -		len = af_alg_make_sg(&ctx->sgl, &msg->msg_iter, len);
> +		len = af_alg_make_sg(&ctx->sgl, &msg->msg_iter, len,
> +				     FOLL_SOURCE_BUF);
>  		if (len < 0) {
>  			err = copied ? 0 : len;
>  			goto unlock;
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index dca6346d75b3..5d10837d19ec 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -646,10 +646,13 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
>  	struct scatterlist *sg = sgl;
>  	ssize_t bytes;
>  	size_t offset;
> -	unsigned int npages = 0;
> +	unsigned int npages = 0, gup_flags = 0;
>  
> -	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
> -				VHOST_SCSI_PREALLOC_UPAGES, &offset);
> +	gup_flags |= write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
> +
> +	bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
> +				   VHOST_SCSI_PREALLOC_UPAGES, &offset,
> +				   gup_flags);
>  	/* No pages were pinned */
>  	if (bytes <= 0)
>  		return bytes < 0 ? bytes : -EFAULT;
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 8c74871e37c9..cfc3353e5604 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -328,7 +328,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  
>  	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
>  	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
> -	err = iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
> +	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off, FOLL_DEST_BUF);
>  	if (err < 0) {
>  		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
>  		goto out;
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 27c72a2f6af5..ffd36eeea186 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -81,7 +81,7 @@ static __le32 ceph_flags_sys2wire(u32 flags)
>  #define ITER_GET_BVECS_PAGES	64
>  
>  static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
> -				struct bio_vec *bvecs)
> +				struct bio_vec *bvecs, bool write)
>  {
>  	size_t size = 0;
>  	int bvec_idx = 0;
> @@ -95,8 +95,9 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
>  		size_t start;
>  		int idx = 0;
>  
> -		bytes = iov_iter_get_pages2(iter, pages, maxsize - size,
> -					   ITER_GET_BVECS_PAGES, &start);
> +		bytes = iov_iter_get_pages(iter, pages, maxsize - size,
> +					   ITER_GET_BVECS_PAGES, &start,
> +					   write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF);
>  		if (bytes < 0)
>  			return size ?: bytes;
>  
> @@ -127,7 +128,8 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
>   * Return the number of bytes in the created bio_vec array, or an error.
>   */
>  static ssize_t iter_get_bvecs_alloc(struct iov_iter *iter, size_t maxsize,
> -				    struct bio_vec **bvecs, int *num_bvecs)
> +				    struct bio_vec **bvecs, int *num_bvecs,
> +				    bool write)
>  {
>  	struct bio_vec *bv;
>  	size_t orig_count = iov_iter_count(iter);
> @@ -146,7 +148,7 @@ static ssize_t iter_get_bvecs_alloc(struct iov_iter *iter, size_t maxsize,
>  	if (!bv)
>  		return -ENOMEM;
>  
> -	bytes = __iter_get_bvecs(iter, maxsize, bv);
> +	bytes = __iter_get_bvecs(iter, maxsize, bv, write);
>  	if (bytes < 0) {
>  		/*
>  		 * No pages were pinned -- just free the array.
> @@ -1334,7 +1336,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>  			break;
>  		}
>  
> -		len = iter_get_bvecs_alloc(iter, size, &bvecs, &num_pages);
> +		len = iter_get_bvecs_alloc(iter, size, &bvecs, &num_pages, write);
>  		if (len < 0) {
>  			ceph_osdc_put_request(req);
>  			ret = len;
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 22dfc1f8b4f1..d100b9cb8682 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3290,8 +3290,8 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
>  		if (ctx->direct_io) {
>  			ssize_t result;
>  
> -			result = iov_iter_get_pages_alloc2(
> -				from, &pagevec, cur_len, &start);
> +			result = iov_iter_get_pages_alloc(
> +				from, &pagevec, cur_len, &start, FOLL_SOURCE_BUF);
>  			if (result < 0) {
>  				cifs_dbg(VFS,
>  					 "direct_writev couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
> @@ -4031,9 +4031,9 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
>  		if (ctx->direct_io) {
>  			ssize_t result;
>  
> -			result = iov_iter_get_pages_alloc2(
> +			result = iov_iter_get_pages_alloc(
>  					&direct_iov, &pagevec,
> -					cur_len, &start);
> +					cur_len, &start, FOLL_DEST_BUF);
>  			if (result < 0) {
>  				cifs_dbg(VFS,
>  					 "Couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index 4d3c586785a5..9655cf359ab9 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -1030,7 +1030,8 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
>  	saved_len = count;
>  
>  	while (count && npages < max_pages) {
> -		rc = iov_iter_get_pages2(iter, pages, count, max_pages, &start);
> +		rc = iov_iter_get_pages(iter, pages, count, max_pages, &start,
> +					rw == WRITE ? FOLL_SOURCE_BUF : FOLL_DEST_BUF);
>  		if (rc < 0) {
>  			cifs_dbg(VFS, "Couldn't get user pages (rc=%zd)\n", rc);
>  			break;
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index cf196f2a211e..b1e26a706e31 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -169,8 +169,10 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
>  	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
>  	ssize_t ret;
>  
> -	ret = iov_iter_get_pages2(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
> -				&sdio->from);
> +	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
> +				 &sdio->from,
> +				 op_is_write(dio_op) ?
> +				 FOLL_SOURCE_BUF : FOLL_DEST_BUF);
>  
>  	if (ret < 0 && sdio->blocks_available && dio_op == REQ_OP_WRITE) {
>  		struct page *page = ZERO_PAGE(0);
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e8b60ce72c9a..e3d8443e24a6 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -730,7 +730,8 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>  		}
>  	} else {
>  		size_t off;
> -		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
> +		err = iov_iter_get_pages(cs->iter, &page, PAGE_SIZE, 1, &off,
> +					 cs->write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF);
>  		if (err < 0)
>  			return err;
>  		BUG_ON(!err);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index d68b45f8b3ae..68c196437306 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1414,10 +1414,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
>  		unsigned npages;
>  		size_t start;
> -		ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
> -					*nbytesp - nbytes,
> -					max_pages - ap->num_pages,
> -					&start);
> +		ret = iov_iter_get_pages(ii, &ap->pages[ap->num_pages],
> +					 *nbytesp - nbytes,
> +					 max_pages - ap->num_pages,
> +					 &start, write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF);
>  		if (ret < 0)
>  			break;
>  
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index d865945f2a63..42af84685f20 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -332,8 +332,9 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
>  		size_t pgbase;
>  		unsigned npages, i;
>  
> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
> -						  rsize, &pgbase);
> +		result = iov_iter_get_pages_alloc(iter, &pagevec,
> +						  rsize, &pgbase,
> +						  FOLL_DEST_BUF);
>  		if (result < 0)
>  			break;
>  	
> @@ -791,8 +792,9 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
>  		size_t pgbase;
>  		unsigned npages, i;
>  
> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
> -						  wsize, &pgbase);
> +		result = iov_iter_get_pages_alloc(iter, &pagevec,
> +						  wsize, &pgbase,
> +						  FOLL_SOURCE_BUF);
>  		if (result < 0)
>  			break;
>  
> diff --git a/fs/splice.c b/fs/splice.c
> index 5969b7a1d353..19c5b5adc548 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1165,7 +1165,8 @@ static int iter_to_pipe(struct iov_iter *from,
>  		size_t start;
>  		int i, n;
>  
> -		left = iov_iter_get_pages2(from, pages, ~0UL, 16, &start);
> +		left = iov_iter_get_pages(from, pages, ~0UL, 16, &start,
> +					  FOLL_SOURCE_BUF);
>  		if (left <= 0) {
>  			ret = left;
>  			break;
> diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
> index a5db86670bdf..12058ab6cad9 100644
> --- a/include/crypto/if_alg.h
> +++ b/include/crypto/if_alg.h
> @@ -165,7 +165,8 @@ int af_alg_release(struct socket *sock);
>  void af_alg_release_parent(struct sock *sk);
>  int af_alg_accept(struct sock *sk, struct socket *newsock, bool kern);
>  
> -int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len);
> +int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len,
> +		   unsigned int gup_flags);
>  void af_alg_free_sg(struct af_alg_sgl *sgl);
>  
>  static inline struct alg_sock *alg_sk(struct sock *sk)
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 22078a28d7cb..3f7ba7fe48ac 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -40,11 +40,25 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
>  #define bio_sectors(bio)	bvec_iter_sectors((bio)->bi_iter)
>  #define bio_end_sector(bio)	bvec_iter_end_sector((bio)->bi_iter)
>  
> +/**
> + * bio_is_write - Query if the I/O direction is towards the disk
> + * @bio: The bio to query
> + *
> + * Return true if this is some sort of write operation - ie. the data is going
> + * towards the disk.
> + */
> +static inline bool bio_is_write(const struct bio *bio)
> +{
> +	return op_is_write(bio_op(bio));
> +}
> +
>  /*
>   * Return the data direction, READ or WRITE.
>   */
> -#define bio_data_dir(bio) \
> -	(op_is_write(bio_op(bio)) ? WRITE : READ)
> +static inline int bio_data_dir(const struct bio *bio)
> +{
> +	return bio_is_write(bio) ? WRITE : READ;
> +}
>  
>  /*
>   * Check whether this bio carries any data or not. A NULL bio is allowed.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f3f196e4d66d..3af4ca8b1fe7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3090,6 +3090,10 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>  #define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
>  #define FOLL_INTERRUPTIBLE  0x200000 /* allow interrupts from generic signals */
>  
> +#define FOLL_SOURCE_BUF	0		/* Memory will be read from by I/O */
> +#define FOLL_DEST_BUF	FOLL_WRITE	/* Memory will be written to by I/O */
> +#define FOLL_BUF_MASK	FOLL_WRITE
> +
>  /*
>   * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
>   * other. Here is what they mean, and how to use them:
> @@ -3143,6 +3147,12 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>   * releasing pages: get_user_pages*() pages must be released via put_page(),
>   * while pin_user_pages*() pages must be released via unpin_user_page().
>   *
> + * FOLL_SOURCE_BUF and FOLL_DEST_BUF are indicators to get_user_pages*() and
> + * iov_iter_*_pages*() as to how the pages obtained are going to be used.
> + * FOLL_SOURCE_BUF indicates that I/O op is going to transfer from memory to
> + * device; FOLL_DEST_BUF that the op is going to transfer from device to
> + * memory.
> + *
>   * Please see Documentation/core-api/pin_user_pages.rst for more information.
>   */
>  
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 68497d9c1452..f53583836009 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1429,11 +1429,6 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>  	return page;
>  }
>  
> -static unsigned char iov_iter_rw(const struct iov_iter *i)
> -{
> -	return i->data_source ? WRITE : READ;
> -}
> -
>  static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
>  		   unsigned int maxpages, size_t *start,
> @@ -1448,12 +1443,17 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  	if (maxsize > MAX_RW_COUNT)
>  		maxsize = MAX_RW_COUNT;
>  
> +	if (WARN_ON_ONCE((gup_flags & FOLL_BUF_MASK) == FOLL_SOURCE_BUF &&
> +			 i->data_source == ITER_DEST))
> +		return -EIO;
> +	if (WARN_ON_ONCE((gup_flags & FOLL_BUF_MASK) == FOLL_DEST_BUF &&
> +			 i->data_source == ITER_SOURCE))
> +		return -EIO;
> +
>  	if (likely(user_backed_iter(i))) {
>  		unsigned long addr;
>  		int res;
>  
> -		if (iov_iter_rw(i) != WRITE)
> -			gup_flags |= FOLL_WRITE;
>  		if (i->nofault)
>  			gup_flags |= FOLL_NOFAULT;
>  
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 3c27ffb781e3..eb28b54fe5f6 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -310,7 +310,8 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  			       struct iov_iter *data,
>  			       int count,
>  			       size_t *offs,
> -			       int *need_drop)
> +			       int *need_drop,
> +			       unsigned int gup_flags)
>  {
>  	int nr_pages;
>  	int err;
> @@ -330,7 +331,8 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  			if (err == -ERESTARTSYS)
>  				return err;
>  		}
> -		n = iov_iter_get_pages_alloc2(data, pages, count, offs);
> +		n = iov_iter_get_pages_alloc(data, pages, count, offs,
> +					     gup_flags);
>  		if (n < 0)
>  			return n;
>  		*need_drop = 1;
> @@ -437,7 +439,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	if (uodata) {
>  		__le32 sz;
>  		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
> -					    outlen, &offs, &need_drop);
> +					    outlen, &offs, &need_drop,
> +					    FOLL_DEST_BUF);
>  		if (n < 0) {
>  			err = n;
>  			goto err_out;
> @@ -456,7 +459,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  		memcpy(&req->tc.sdata[0], &sz, sizeof(sz));
>  	} else if (uidata) {
>  		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
> -					    inlen, &offs, &need_drop);
> +					    inlen, &offs, &need_drop,
> +					    FOLL_SOURCE_BUF);
>  		if (n < 0) {
>  			err = n;
>  			goto err_out;
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index e4ff2db40c98..9f0914b781ad 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -632,8 +632,9 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  		if (frag == MAX_SKB_FRAGS)
>  			return -EMSGSIZE;
>  
> -		copied = iov_iter_get_pages2(from, pages, length,
> -					    MAX_SKB_FRAGS - frag, &start);
> +		copied = iov_iter_get_pages(from, pages, length,
> +					    MAX_SKB_FRAGS - frag, &start,
> +					    FOLL_SOURCE_BUF);
>  		if (copied < 0)
>  			return -EFAULT;
>  
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 53d0251788aa..f63a13690712 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -324,8 +324,8 @@ int sk_msg_zerocopy_from_iter(struct sock *sk, struct iov_iter *from,
>  			goto out;
>  		}
>  
> -		copied = iov_iter_get_pages2(from, pages, bytes, maxpages,
> -					    &offset);
> +		copied = iov_iter_get_pages(from, pages, bytes, maxpages,
> +					    &offset, FOLL_SOURCE_BUF);
>  		if (copied <= 0) {
>  			ret = -EFAULT;
>  			goto out;
> diff --git a/net/rds/message.c b/net/rds/message.c
> index b47e4f0a1639..fcfd406b97af 100644
> --- a/net/rds/message.c
> +++ b/net/rds/message.c
> @@ -390,8 +390,8 @@ static int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *
>  		size_t start;
>  		ssize_t copied;
>  
> -		copied = iov_iter_get_pages2(from, &pages, PAGE_SIZE,
> -					    1, &start);
> +		copied = iov_iter_get_pages(from, &pages, PAGE_SIZE,
> +					    1, &start, FOLL_SOURCE_BUF);
>  		if (copied < 0) {
>  			struct mmpin *mmp;
>  			int i;
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 9ed978634125..59acaeb24f54 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1354,9 +1354,8 @@ static int tls_setup_from_iter(struct iov_iter *from,
>  			rc = -EFAULT;
>  			goto out;
>  		}
> -		copied = iov_iter_get_pages2(from, pages,
> -					    length,
> -					    maxpages, &offset);
> +		copied = iov_iter_get_pages(from, pages, length,
> +					    maxpages, &offset, FOLL_DEST_BUF);
>  		if (copied <= 0) {
>  			rc = -EFAULT;
>  			goto out;
> 
> 
---end quoted text---
