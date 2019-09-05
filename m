Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B387AAF19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 01:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbfIEXZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 19:25:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52726 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbfIEXZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:25:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85NPWa1097626;
        Thu, 5 Sep 2019 23:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=8jPKjaRqMeHQcCliH8xFD1y5nGXM0xqVYEtJwlF7K2U=;
 b=P+etzJAdzXRD8xg0JtF/bcS7/T3fy9zDQElipBjjshMksTNtqgLrr3/sD6ShfQbYCBol
 GpzVzZ01a81dD0x03abAPZtUdGPbb906lIU87oGJY9I3qRUPexPEE2ZnOo9snDZgz9QA
 1TpbzIyq2nrh31B10mfp2Ht6NU1K8lWdqYxhw5+LLb8UV/f7hxgexA9H6pyWQkhW8Evu
 JRIHOcfE9fUL0TUicFZAoY+jwJE0POq3iWVafhgybW9PLb/qYROku8k4tQTCZ+VODIoP
 in+hrosFNY/W9azDvahHLYm+VZ/ExY3Nb4bkLwl5n0cAIStkLO8GEMfiLaEBq7LjUZjB 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2uuby800g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 23:25:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85NNnli019721;
        Thu, 5 Sep 2019 23:25:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2utvr4c5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 23:23:50 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x85NNjIM007423;
        Thu, 5 Sep 2019 23:23:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 16:23:44 -0700
Date:   Thu, 5 Sep 2019 16:23:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/15] iomap: Use a srcmap for a read-modify-write I/O
Message-ID: <20190905232342.GJ2229799@magnolia>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
 <20190905150650.21089-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150650.21089-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050217
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050217
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:06:36AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> A preparation patch for copy-on-write (CoW).
> The srcmap is used to identify where the read is to be performed
> from. This is passed to iomap->begin() of the respective
> filesystem, which is supposed to put in the details for
> reading before performing the copy for CoW.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/dax.c               |  8 +++++---
>  fs/ext2/inode.c        |  2 +-
>  fs/ext4/inode.c        |  2 +-
>  fs/gfs2/bmap.c         |  3 ++-
>  fs/iomap/apply.c       |  5 +++--
>  fs/iomap/buffered-io.c | 14 +++++++-------
>  fs/iomap/direct-io.c   |  2 +-
>  fs/iomap/fiemap.c      |  4 ++--
>  fs/iomap/seek.c        |  4 ++--
>  fs/iomap/swapfile.c    |  3 ++-
>  fs/xfs/xfs_iomap.c     |  9 ++++++---
>  include/linux/iomap.h  |  5 +++--
>  12 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 6bf81f931de3..e961d8dc23ef 100644
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
> @@ -1546,7 +1548,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * to look up our filesystem block.
>  	 */
>  	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> -	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap);
> +	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap, &srcmap);
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
> index 420fe3deed39..918f94eff799 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3453,7 +3453,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  }
>  
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> -			    unsigned flags, struct iomap *iomap)
> +			    unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	unsigned int blkbits = inode->i_blkbits;
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 4f8b5fd6c81f..0189262989f2 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -1164,7 +1164,8 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
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
> index 54c02aecf3cd..6cdb362fff36 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -24,6 +24,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
>  {
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };
>  	loff_t written = 0, ret;
>  
>  	/*
> @@ -38,7 +39,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	 * expose transient stale data. If the reserve fails, we can safely
>  	 * back out at this point as there is nothing to undo.
>  	 */
> -	ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
> +	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
>  	if (ret)
>  		return ret;
>  	if (WARN_ON(iomap.offset > pos))
> @@ -58,7 +59,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	 * we can do the copy-in page by page without having to worry about
>  	 * failures exposing transient data.
>  	 */
> -	written = actor(inode, pos, length, data, &iomap);
> +	written = actor(inode, pos, length, data, &iomap, &srcmap);
>  
>  	/*
>  	 * Now the data has been copied, commit the range we've copied.  This
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..f27756c0b31c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,7 +205,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>  
>  static loff_t
>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	struct page *page = ctx->cur_page;
> @@ -351,7 +351,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
>  
>  static loff_t
>  iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	loff_t done, ret;
> @@ -371,7 +371,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  			ctx->cur_page_in_bio = false;
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> -				ctx, iomap);
> +				ctx, iomap, srcmap);
>  	}
>  
>  	return done;
> @@ -736,7 +736,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  
>  static loff_t
>  iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iov_iter *i = data;
>  	long status = 0;
> @@ -853,7 +853,7 @@ __iomap_read_page(struct inode *inode, loff_t offset)
>  
>  static loff_t
>  iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	long status = 0;
>  	ssize_t written = 0;
> @@ -942,7 +942,7 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
>  
>  static loff_t
>  iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> -		void *data, struct iomap *iomap)
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	bool *did_zero = data;
>  	loff_t written = 0;
> @@ -1011,7 +1011,7 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
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
> index 3a4310d7cb59..8321733c16c3 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -922,7 +922,8 @@ xfs_file_iomap_begin(
>  	loff_t			offset,
>  	loff_t			length,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -1145,7 +1146,8 @@ xfs_seek_iomap_begin(
>  	loff_t			offset,
>  	loff_t			length,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -1231,7 +1233,8 @@ xfs_xattr_iomap_begin(
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
> index 7aa5d6117936..9782a79dde59 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -110,7 +110,8 @@ struct iomap_ops {
>  	 * The actual length is returned in iomap->length.
>  	 */
>  	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
> -			unsigned flags, struct iomap *iomap);
> +			unsigned flags, struct iomap *iomap,
> +			struct iomap *srcmap);
>  
>  	/*
>  	 * Commit and/or unreserve space previous allocated using iomap_begin.
> @@ -126,7 +127,7 @@ struct iomap_ops {
>   * Main iomap iterator function.
>   */
>  typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
> -		void *data, struct iomap *iomap);
> +		void *data, struct iomap *iomap, struct iomap *srcmap);
>  
>  loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  		unsigned flags, const struct iomap_ops *ops, void *data,
> -- 
> 2.16.4
> 
