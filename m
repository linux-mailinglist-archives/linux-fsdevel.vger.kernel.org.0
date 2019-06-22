Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6A4F2E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 02:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFVAqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 20:46:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52094 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfFVAqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:46:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0jYhf082647;
        Sat, 22 Jun 2019 00:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=c2c1vi8H9Q4Zb2ZW1Ej+DklQDn48J9ticrhevp4p6oM=;
 b=Tdz6cg6+B52HLTi9UENOeN4K5WS52PjdT2Hg+8B+jJ8JWaX/d5Pnfs8c6UQ0Y7OOfPrA
 FdzbkY58Mrh8t2lLzrroHaEbqwp2TKgkJmHbPNVpDlDBpl2CpErljc4MC0OF7kTjS5so
 g6W5Tv35aBbjzMU5hS0i0n6tglvoV225Zwqsgu/3SXSjP1BCSAvYDfUi8ESQjSDFW6nT
 S6YvXYzFUQI7N545fisvHUqAAZ4XIX/td7imLny5ilonWqw/apmUzTaof/avqF3VVycY
 JZ8/QyxwkRQ0MQ3RZZc0W5vVrHhUntNWh60hUHLS8TBRZLWB+e4sDcpiCLWtP1q+u2Ac Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t7809rv2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 00:46:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0iZ2p117863;
        Sat, 22 Jun 2019 00:46:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t77yq78de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 00:46:26 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5M0kPwC006643;
        Sat, 22 Jun 2019 00:46:25 GMT
Received: from localhost (/10.159.131.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 17:46:25 -0700
Date:   Fri, 21 Jun 2019 17:46:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, david@fromorbit.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190622004624.GC1611011@magnolia>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621192828.28900-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220005
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 21, 2019 at 02:28:23PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Introduces a new type IOMAP_COW, which means the data at offset
> must be read from a srcmap and copied before performing the
> write on the offset.
> 
> The srcmap is used to identify where the read is to be performed
> from. This is passed to iomap->begin(), which is supposed to
> put in the details for reading, typically set with type IOMAP_READ.

What is IOMAP_READ ?

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/dax.c              |  8 +++++---
>  fs/ext2/inode.c       |  2 +-
>  fs/ext4/inode.c       |  2 +-
>  fs/gfs2/bmap.c        |  3 ++-
>  fs/internal.h         |  2 +-
>  fs/iomap.c            | 31 ++++++++++++++++---------------
>  fs/xfs/xfs_iomap.c    |  9 ++++++---
>  include/linux/iomap.h |  4 +++-
>  8 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 2e48c7ebb973..80b9e2599223 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1078,7 +1078,7 @@ EXPORT_SYMBOL_GPL(__dax_zero_page_range);
>  
>  static loff_t
>  dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct block_device *bdev = iomap->bdev;
>  	struct dax_device *dax_dev = iomap->dax_dev;
> @@ -1236,6 +1236,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	unsigned long vaddr = vmf->address;
>  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };
>  	unsigned flags = IOMAP_FAULT;
>  	int error, major = 0;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> @@ -1280,7 +1281,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * the file system block size to be equal the page size, which means
>  	 * that we never have to deal with more than a single extent here.
>  	 */
> -	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap);
> +	error = ops->iomap_begin(inode, pos, PAGE_SIZE, flags, &iomap, &srcmap);
>  	if (iomap_errp)
>  		*iomap_errp = error;
>  	if (error) {
> @@ -1460,6 +1461,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	struct inode *inode = mapping->host;
>  	vm_fault_t result = VM_FAULT_FALLBACK;
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };
>  	pgoff_t max_pgoff;
>  	void *entry;
>  	loff_t pos;
> @@ -1534,7 +1536,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * to look up our filesystem block.
>  	 */
>  	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> -	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap);
> +	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap, &srcmap);

Line too long?

Also, I guess the DAX and directio write paths will just WARN_ON_ONCE if
someone feeds them an IOMAP_COW type iomap?

Ah, right, I guess the only filesystems that use iomap directio and
iomap dax don't support COW. :)

--D

>  	if (error)
>  		goto unlock_entry;
>  
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index e474127dd255..f081f11980ad 100644
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
> index c7f77c643008..a8017e0c302b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3437,7 +3437,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  }
>  
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> -			    unsigned flags, struct iomap *iomap)
> +			    unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	unsigned int blkbits = inode->i_blkbits;
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 93ea1d529aa3..affa0c4305b7 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -1124,7 +1124,8 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
>  }
>  
>  static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
> -			    unsigned flags, struct iomap *iomap)
> +			    unsigned flags, struct iomap *iomap,
> +			    struct iomap *srcmap)
>  {
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct metapath mp = { .mp_aheight = 1, };
> diff --git a/fs/internal.h b/fs/internal.h
> index a48ef81be37d..79e495d86165 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -188,7 +188,7 @@ extern int do_vfs_ioctl(struct file *file, unsigned int fd, unsigned int cmd,
>   * iomap support:
>   */
>  typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
> -		void *data, struct iomap *iomap);
> +		void *data, struct iomap *iomap, struct iomap *srcmap);
>  
>  loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  		unsigned flags, const struct iomap_ops *ops, void *data,
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 23ef63fd1669..6648957af268 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -41,6 +41,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
>  {
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };
>  	loff_t written = 0, ret;
>  
>  	/*
> @@ -55,7 +56,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	 * expose transient stale data. If the reserve fails, we can safely
>  	 * back out at this point as there is nothing to undo.
>  	 */
> -	ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
> +	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
>  	if (ret)
>  		return ret;
>  	if (WARN_ON(iomap.offset > pos))
> @@ -75,7 +76,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	 * we can do the copy-in page by page without having to worry about
>  	 * failures exposing transient data.
>  	 */
> -	written = actor(inode, pos, length, data, &iomap);
> +	written = actor(inode, pos, length, data, &iomap, &srcmap);
>  
>  	/*
>  	 * Now the data has been copied, commit the range we've copied.  This
> @@ -282,7 +283,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>  
>  static loff_t
>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	struct page *page = ctx->cur_page;
> @@ -424,7 +425,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
>  
>  static loff_t
>  iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	loff_t done, ret;
> @@ -444,7 +445,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  			ctx->cur_page_in_bio = false;
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> -				ctx, iomap);
> +				ctx, iomap, srcmap);
>  	}
>  
>  	return done;
> @@ -796,7 +797,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  
>  static loff_t
>  iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iov_iter *i = data;
>  	long status = 0;
> @@ -913,7 +914,7 @@ __iomap_read_page(struct inode *inode, loff_t offset)
>  
>  static loff_t
>  iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	long status = 0;
>  	ssize_t written = 0;
> @@ -1002,7 +1003,7 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
>  
>  static loff_t
>  iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	bool *did_zero = data;
>  	loff_t written = 0;
> @@ -1071,7 +1072,7 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  
>  static loff_t
>  iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct page *page = data;
>  	int ret;
> @@ -1169,7 +1170,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
>  
>  static loff_t
>  iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct fiemap_ctx *ctx = data;
>  	loff_t ret = length;
> @@ -1343,7 +1344,7 @@ page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
>  
>  static loff_t
>  iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
> -		      void *data, struct iomap *iomap)
> +		      void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	switch (iomap->type) {
>  	case IOMAP_UNWRITTEN:
> @@ -1389,7 +1390,7 @@ EXPORT_SYMBOL_GPL(iomap_seek_hole);
>  
>  static loff_t
>  iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
> -		      void *data, struct iomap *iomap)
> +		      void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	switch (iomap->type) {
>  	case IOMAP_HOLE:
> @@ -1790,7 +1791,7 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  static loff_t
>  iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_dio *dio = data;
>  
> @@ -2057,7 +2058,7 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
>   * distinction between written and unwritten extents.
>   */
>  static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
> -		loff_t count, void *data, struct iomap *iomap)
> +		loff_t count, void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_swapfile_info *isi = data;
>  	int error;
> @@ -2161,7 +2162,7 @@ EXPORT_SYMBOL_GPL(iomap_swapfile_activate);
>  
>  static loff_t
>  iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	sector_t *bno = data, addr;
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 63d323916bba..6116a75f03da 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -925,7 +925,8 @@ xfs_file_iomap_begin(
>  	loff_t			offset,
>  	loff_t			length,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -1148,7 +1149,8 @@ xfs_seek_iomap_begin(
>  	loff_t			offset,
>  	loff_t			length,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -1234,7 +1236,8 @@ xfs_xattr_iomap_begin(
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
> index 2103b94cb1bf..f49767c7fd83 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -25,6 +25,7 @@ struct vm_fault;
>  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
>  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
>  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> +#define IOMAP_COW	0x06	/* copy data from srcmap before writing */
>  
>  /*
>   * Flags for all iomap mappings:
> @@ -102,7 +103,8 @@ struct iomap_ops {
>  	 * The actual length is returned in iomap->length.
>  	 */
>  	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
> -			unsigned flags, struct iomap *iomap);
> +			unsigned flags, struct iomap *iomap,
> +			struct iomap *srcmap);
>  
>  	/*
>  	 * Commit and/or unreserve space previous allocated using iomap_begin.
> -- 
> 2.16.4
> 
