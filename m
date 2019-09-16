Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76D0B407B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfIPSmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:42:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40726 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfIPSmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:42:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GIcskH084912;
        Mon, 16 Sep 2019 18:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=EaC0m6WzxnQvt6ytbxKbiI2s8Nv0/1ODgx3cTaOI7o8=;
 b=pyrXZn8YuAcxw6uB4n/MMCcnEB6+RoMB+p0XnS4wp7o35e0mCyXpvgkbcRE8jhnaFW+N
 VqbQIvr1tHMmn/a4b5p4ziOD9oQ+mALw36S0VqvPe98Mn4n6ShUUmjYkF6NhVsXtD9FN
 Rl8r13X6GwHr22wT4D3cP5rBVg/qLpGTyb9uMNrB9QCai7n5/niD4IYIP59yuNaqEeEP
 +qTs4CO4kGZJpgr3BW2bL+OnCM11b1JtjTFL+Wf1e8DiYiphsQHJaObK9I2pPbwuDGqI
 r+688aMu+4XTbw7tQPACg3QXtYO5Qdsu5ioSIk7VaPeCxxhZTYOiFLLJ0IfMRmapR1Ql YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v0ruqhc9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:42:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GIckBF112053;
        Mon, 16 Sep 2019 18:42:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2v0r1gvspc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:42:43 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GIggTU026333;
        Mon, 16 Sep 2019 18:42:42 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:42:41 -0700
Date:   Mon, 16 Sep 2019 11:42:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/19] iomap: use a srcmap for a read-modify-write I/O
Message-ID: <20190916184237.GL2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-8-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160181
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:10PM +0200, Christoph Hellwig wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> The srcmap is used to identify where the read is to be performed from.
> It is passed to ->iomap_begin, which can fill it in if we need to read
> data for partially written blocks from a different location than the
> write target.  The srcmap is only supported for buffered writes so far.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> [hch: merged two patches, removed the IOMAP_F_COW flag, use iomap as
>       srcmap if not set, adjust length down to srcmap end as well]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c               |  9 ++++--
>  fs/ext2/inode.c        |  2 +-
>  fs/ext4/inode.c        |  2 +-
>  fs/gfs2/bmap.c         |  3 +-
>  fs/iomap/apply.c       | 23 +++++++++++----
>  fs/iomap/buffered-io.c | 65 +++++++++++++++++++++++-------------------
>  fs/iomap/direct-io.c   |  2 +-
>  fs/iomap/fiemap.c      |  4 +--
>  fs/iomap/seek.c        |  4 +--
>  fs/iomap/swapfile.c    |  3 +-
>  fs/xfs/xfs_iomap.c     |  9 ++++--
>  include/linux/iomap.h  |  5 ++--
>  12 files changed, 79 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index a237141d8787..8016be24bbd9 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1090,7 +1090,7 @@ EXPORT_SYMBOL_GPL(__dax_zero_page_range);
>  
>  static loff_t
>  dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct block_device *bdev = iomap->bdev;
>  	struct dax_device *dax_dev = iomap->dax_dev;
> @@ -1248,6 +1248,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	unsigned long vaddr = vmf->address;
>  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };
>  	unsigned flags = IOMAP_FAULT;
>  	int error, major = 0;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> @@ -1292,7 +1293,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * the file system block size to be equal the page size, which means
>  	 * that we never have to deal with more than a single extent here.
>  	 */
> -	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap);
> +	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap, &srcmap);
>  	if (iomap_errp)
>  		*iomap_errp = error;
>  	if (error) {
> @@ -1472,6 +1473,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	struct inode *inode = mapping->host;
>  	vm_fault_t result = VM_FAULT_FALLBACK;
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };
>  	pgoff_t max_pgoff;
>  	void *entry;
>  	loff_t pos;
> @@ -1546,7 +1548,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * to look up our filesystem block.
>  	 */
>  	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> -	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap);
> +	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap,
> +			&srcmap);
>  	if (error)
>  		goto unlock_entry;
>  
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 7004ce581a32..467c13ff6b40 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -801,7 +801,7 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
>  
>  #ifdef CONFIG_FS_DAX
>  static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> -		unsigned flags, struct iomap *iomap)
> +		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	unsigned int blkbits = inode->i_blkbits;
>  	unsigned long first_block = offset >> blkbits;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 420fe3deed39..e2116e8228d2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3453,7 +3453,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  }
>  
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> -			    unsigned flags, struct iomap *iomap)
> +		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	unsigned int blkbits = inode->i_blkbits;
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 79581b9bdebb..0bf8e8fa82bd 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -1123,7 +1123,8 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
>  }
>  
>  static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
> -			    unsigned flags, struct iomap *iomap)
> +			    unsigned flags, struct iomap *iomap,
> +			    struct iomap *srcmap)
>  {
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct metapath mp = { .mp_aheight = 1, };
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 54c02aecf3cd..67efd86675e6 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -24,7 +24,9 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
>  {
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };
>  	loff_t written = 0, ret;
> +	u64 end;
>  
>  	/*
>  	 * Need to map a range from start position for length bytes. This can
> @@ -38,7 +40,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	 * expose transient stale data. If the reserve fails, we can safely
>  	 * back out at this point as there is nothing to undo.
>  	 */
> -	ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
> +	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
>  	if (ret)
>  		return ret;
>  	if (WARN_ON(iomap.offset > pos))
> @@ -50,15 +52,26 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	 * Cut down the length to the one actually provided by the filesystem,
>  	 * as it might not be able to give us the whole size that we requested.
>  	 */
> -	if (iomap.offset + iomap.length < pos + length)
> -		length = iomap.offset + iomap.length - pos;
> +	end = iomap.offset + iomap.length;
> +	if (srcmap.type)

Do we need a "#define IOMAP_NULL 0" type to make this more explicit?

Or at least a comment in iomap.h above the IOMAP_HOLE definition
pointing out that type == 0 is valid for srcmap and not valid for iomap?

Other than that the rest looks ok.

--D

(This reminds me that at some point I ought to work on iomap debugging
checks for the mappings returned by ->iomap_begin ...)

> +		end = min(end, srcmap.offset + srcmap.length);
> +	if (pos + length > end)
> +		length = end - pos;
>  
>  	/*
> -	 * Now that we have guaranteed that the space allocation will succeed.
> +	 * Now that we have guaranteed that the space allocation will succeed,
>  	 * we can do the copy-in page by page without having to worry about
>  	 * failures exposing transient data.
> +	 *
> +	 * To support COW operations, we read in data for partially blocks from
> +	 * the srcmap if the file system filled it in.  In that case we the
> +	 * length needs to be limited to the earlier of the ends of the iomaps.
> +	 * If the file system did not provide a srcmap we pass in the normal
> +	 * iomap into the actors so that they don't need to have special
> +	 * handling for the two cases.
>  	 */
> -	written = actor(inode, pos, length, data, &iomap);
> +	written = actor(inode, pos, length, data, &iomap,
> +			srcmap.type ? &srcmap : &iomap);
>  
>  	/*
>  	 * Now the data has been copied, commit the range we've copied.  This
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a421977a9496..58fb7a894ad4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -219,7 +219,7 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
>  
>  static loff_t
>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	struct page *page = ctx->cur_page;
> @@ -367,7 +367,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
>  
>  static loff_t
>  iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	loff_t done, ret;
> @@ -387,7 +387,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  			ctx->cur_page_in_bio = false;
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> -				ctx, iomap);
> +				ctx, iomap, srcmap);
>  	}
>  
>  	return done;
> @@ -567,7 +567,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
>  
>  static int
>  __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> -		struct page *page, struct iomap *iomap)
> +		struct page *page, struct iomap *srcmap)
>  {
>  	struct iomap_page *iop = iomap_page_create(inode, page);
>  	loff_t block_size = i_blocksize(inode);
> @@ -590,7 +590,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		    (to <= poff || to >= poff + plen))
>  			continue;
>  
> -		if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
> +		if (iomap_block_needs_zeroing(inode, srcmap, block_start)) {
>  			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
>  				return -EIO;
>  			zero_user_segments(page, poff, from, to, poff + plen);
> @@ -599,7 +599,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		}
>  
>  		status = iomap_read_page_sync(block_start, page, poff, plen,
> -				iomap);
> +				srcmap);
>  		if (status)
>  			return status;
>  	} while ((block_start += plen) < block_end);
> @@ -609,13 +609,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> -		struct page **pagep, struct iomap *iomap)
> +		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	struct page *page;
>  	int status = 0;
>  
>  	BUG_ON(pos + len > iomap->offset + iomap->length);
> +	if (srcmap != iomap)
> +		BUG_ON(pos + len > srcmap->offset + srcmap->length);
>  
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> @@ -633,13 +635,13 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		goto out_no_page;
>  	}
>  
> -	if (iomap->type == IOMAP_INLINE)
> -		iomap_read_inline_data(inode, page, iomap);
> +	if (srcmap->type == IOMAP_INLINE)
> +		iomap_read_inline_data(inode, page, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> -		status = __block_write_begin_int(page, pos, len, NULL, iomap);
> +		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
>  		status = __iomap_write_begin(inode, pos, len, flags, page,
> -				iomap);
> +				srcmap);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
> @@ -725,16 +727,16 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
>  }
>  
>  static int
> -iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> -		unsigned copied, struct page *page, struct iomap *iomap)
> +iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
> +		struct page *page, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	loff_t old_size = inode->i_size;
>  	int ret;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> +	if (srcmap->type == IOMAP_INLINE) {
>  		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
> -	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> +	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
>  		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>  				page, NULL);
>  	} else {
> @@ -765,7 +767,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  
>  static loff_t
>  iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iov_iter *i = data;
>  	long status = 0;
> @@ -799,7 +801,8 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
> +		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
> +				srcmap);
>  		if (unlikely(status))
>  			break;
>  
> @@ -810,8 +813,8 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  		flush_dcache_page(page);
>  
> -		status = iomap_write_end(inode, pos, bytes, copied, page,
> -				iomap);
> +		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
> +				srcmap);
>  		if (unlikely(status < 0))
>  			break;
>  		copied = status;
> @@ -864,7 +867,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
>  static loff_t
>  iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	long status = 0;
>  	ssize_t written = 0;
> @@ -873,7 +876,7 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	if (!(iomap->flags & IOMAP_F_SHARED))
>  		return length;
>  	/* don't bother with holes or unwritten extents */
> -	if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
> +	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
>  		return length;
>  
>  	do {
> @@ -882,11 +885,12 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct page *page;
>  
>  		status = iomap_write_begin(inode, pos, bytes,
> -				IOMAP_WRITE_F_UNSHARE, &page, iomap);
> +				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
>  		if (unlikely(status))
>  			return status;
>  
> -		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap);
> +		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
> +				srcmap);
>  		if (unlikely(status <= 0)) {
>  			if (WARN_ON_ONCE(status == 0))
>  				return -EIO;
> @@ -925,19 +929,19 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
>  static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
> -		unsigned bytes, struct iomap *iomap)
> +		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct page *page;
>  	int status;
>  
> -	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
> +	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
>  	if (status)
>  		return status;
>  
>  	zero_user(page, offset, bytes);
>  	mark_page_accessed(page);
>  
> -	return iomap_write_end(inode, pos, bytes, bytes, page, iomap);
> +	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
>  }
>  
>  static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
> @@ -949,14 +953,14 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
>  
>  static loff_t
>  iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	bool *did_zero = data;
>  	loff_t written = 0;
>  	int status;
>  
>  	/* already zeroed?  we're done. */
> -	if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
> +	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
>  		return count;
>  
>  	do {
> @@ -968,7 +972,8 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
>  		if (IS_DAX(inode))
>  			status = iomap_dax_zero(pos, offset, bytes, iomap);
>  		else
> -			status = iomap_zero(inode, pos, offset, bytes, iomap);
> +			status = iomap_zero(inode, pos, offset, bytes, iomap,
> +					srcmap);
>  		if (status < 0)
>  			return status;
>  
> @@ -1018,7 +1023,7 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  
>  static loff_t
>  iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct page *page = data;
>  	int ret;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2da279..e3ccbf7daaae 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -358,7 +358,7 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  static loff_t
>  iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_dio *dio = data;
>  
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index f26fdd36e383..690ef2d7c6c8 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -44,7 +44,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
>  
>  static loff_t
>  iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct fiemap_ctx *ctx = data;
>  	loff_t ret = length;
> @@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(iomap_fiemap);
>  
>  static loff_t
>  iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	sector_t *bno = data, addr;
>  
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index c04bad4b2b43..89f61d93c0bc 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -119,7 +119,7 @@ page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
>  
>  static loff_t
>  iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
> -		      void *data, struct iomap *iomap)
> +		      void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	switch (iomap->type) {
>  	case IOMAP_UNWRITTEN:
> @@ -165,7 +165,7 @@ EXPORT_SYMBOL_GPL(iomap_seek_hole);
>  
>  static loff_t
>  iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
> -		      void *data, struct iomap *iomap)
> +		      void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	switch (iomap->type) {
>  	case IOMAP_HOLE:
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 152a230f668d..a648dbf6991e 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -76,7 +76,8 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
>   * distinction between written and unwritten extents.
>   */
>  static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
> -		loff_t count, void *data, struct iomap *iomap)
> +		loff_t count, void *data, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	struct iomap_swapfile_info *isi = data;
>  	int error;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d340db666c06..f1c3ff27c666 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -928,7 +928,8 @@ xfs_file_iomap_begin(
>  	loff_t			offset,
>  	loff_t			length,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -1154,7 +1155,8 @@ xfs_seek_iomap_begin(
>  	loff_t			offset,
>  	loff_t			length,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -1240,7 +1242,8 @@ xfs_xattr_iomap_begin(
>  	loff_t			offset,
>  	loff_t			length,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 3a0f0975a57e..6d795924baa7 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -127,7 +127,8 @@ struct iomap_ops {
>  	 * The actual length is returned in iomap->length.
>  	 */
>  	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
> -			unsigned flags, struct iomap *iomap);
> +			unsigned flags, struct iomap *iomap,
> +			struct iomap *srcmap);
>  
>  	/*
>  	 * Commit and/or unreserve space previous allocated using iomap_begin.
> @@ -143,7 +144,7 @@ struct iomap_ops {
>   * Main iomap iterator function.
>   */
>  typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
> -		void *data, struct iomap *iomap);
> +		void *data, struct iomap *iomap, struct iomap *srcmap);
>  
>  loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  		unsigned flags, const struct iomap_ops *ops, void *data,
> -- 
> 2.20.1
> 
