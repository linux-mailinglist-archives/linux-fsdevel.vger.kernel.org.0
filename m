Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57580389
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 02:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392776AbfHCAjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 20:39:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43020 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389781AbfHCAjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:39:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x730dAJE082119;
        Sat, 3 Aug 2019 00:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=5CYU+SneV0OnsggeI9NrWk158ChBF1DzC7GnwxTxzEE=;
 b=laxNZgqhCI9yqh0FiOZXsb/4LH2Zetf2W6CfKbnbBVj6P8gII43fG0nqEl3J5+GSOtmH
 sh3KYZTpSAE+0N1e5waFkRFx//uEkbEwpb7vao0Utp64b1xo1Zfn/Ndgqxdefo84w1Vr
 R8K/on7GtCaoQ7T3psPsHMYNuHAyxPZl6EejHctkERNUeQj7nOIJYJcF9andw/IY/hjK
 OhRy+pF07HUW3HlJP53zdIH4DzL/87DpQ3VdsX+2aHNW77Pt0194ejgg9gn5vyn9xhle
 it1W9JS+XV8SosvivwqE0mgntDpc6AWMjRQAcTzucmULcrKrpZrlm06HcZBnSruEkATm Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u0ejq4yxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 00:39:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x730bto1053739;
        Sat, 3 Aug 2019 00:39:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u49hur1xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 00:39:28 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x730dR4I001902;
        Sat, 3 Aug 2019 00:39:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 17:39:26 -0700
Date:   Fri, 2 Aug 2019 17:39:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/13] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190803003925.GC7129@magnolia>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908030002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908030002
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:36PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Introduces a new type IOMAP_COW, which means the data at offset
> must be read from a srcmap and copied before performing the
> write on the offset.
> 
> The srcmap is used to identify where the read is to be performed
> from. This is passed to iomap->begin() of the respective
> filesystem, which is supposed to put in the details for
> reading before performing the copy for CoW.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
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
>  include/linux/iomap.h  |  6 ++++--
>  12 files changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index a237141d8787..b21d9a9cde2b 100644
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

/me wonders aloud if he ought to add a helper function to standardize at
least some of validation of the iomap that gets returned from
->iomap_begin invocations...

>  	if (error)
>  		goto unlock_entry;
>  

<snip>

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

...because I wonder if we ought to have a debugging assert here just in
case an ->iomap_begin returns IOMAP_COW in response to an IOMAP_WRITE
request?  Basic sanity checks to catch accidental API misuse, etc.

Eh we probably ought to have a CONFIG_IOMAP_DEBUG so that non-developers
don't necessarily have to pay the assert costs or something like that.

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
> index 10517cea9682..5279029c7a3c 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -362,7 +362,7 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
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

The switch(iomap->type) probably ought to have a separate printk for the
IOMAP_COW case so that we don't go complaining about "unwritten" extents
in the swap file.

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

XFS part looks ok... I guess I'll get to Shiyuan's series next.

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index bc499ceae392..5b2055e8ca8a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -26,6 +26,7 @@ struct vm_fault;
>  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
>  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
>  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> +#define IOMAP_COW	0x06	/* copy data from srcmap before writing */

Hm, ok, at least the comment references that this is only for writes.
Looks good!

--D

>  
>  /*
>   * Flags for all iomap mappings:
> @@ -110,7 +111,8 @@ struct iomap_ops {
>  	 * The actual length is returned in iomap->length.
>  	 */
>  	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
> -			unsigned flags, struct iomap *iomap);
> +			unsigned flags, struct iomap *iomap,
> +			struct iomap *srcmap);
>  
>  	/*
>  	 * Commit and/or unreserve space previous allocated using iomap_begin.
> @@ -126,7 +128,7 @@ struct iomap_ops {
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
