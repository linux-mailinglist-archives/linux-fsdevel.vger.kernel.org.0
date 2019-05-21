Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB325761
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 20:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfEUSRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 14:17:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfEUSRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 14:17:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LIEZlf080952;
        Tue, 21 May 2019 18:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TGhGKsitKM4P/BRVaoMj10TjoOmhQcDpYiDaysJWwdQ=;
 b=ZzhEMotfGHvFRzSjnDnb46J4qRblNVRfh4d14Qrqp03z+q5QhnBx1361O5KCB4TUsn93
 TRl1BQviS/h8xOLEXzLo/aho4YsCC1Yb8/HbtHYqqAz37tc9lGQdb1xk6BroNsdCJUsG
 bqBOldzGuZw5qv8wXDuLRyJaA4Q3JUlPQMkPJsZ8HdTr2+zt8u9E6oVNmmJWux3HS5JU
 UUB7ZAYlk/qoUETFJGR5FcudRvf2B1eB23YnVvKFkPI7dcnqOWxZA/ULyrnoAKnGlyyD
 sbrciA5nTsNx408mMVWc0YjrvfTPlIyUWWkJD8llDrO2cjkigKj/TR+KAN+cixK3/2AD cQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sjapqf50v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 18:17:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LIFe2B123650;
        Tue, 21 May 2019 18:17:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sks1jkpdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 18:17:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LIH4WW029347;
        Tue, 21 May 2019 18:17:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 18:17:03 +0000
Date:   Tue, 21 May 2019 11:17:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 13/18] fs: dedup file range to use a compare function
Message-ID: <20190521181702.GA5155@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-14-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-14-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210112
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:26:44PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> With dax we cannot deal with readpage() etc. So, we create a
> funciton callback to perform the file data comparison and pass
> it to generic_remap_file_range_prep() so it can use iomap-based
> functions.
> 
> This may not be the best way to solve this. Suggestions welcome.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h     |  9 ++++++++
>  fs/btrfs/dax.c       |  8 +++++++
>  fs/btrfs/ioctl.c     | 11 +++++++--
>  fs/dax.c             | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ocfs2/file.c      |  2 +-
>  fs/read_write.c      | 11 +++++----
>  fs/xfs/xfs_reflink.c |  2 +-
>  include/linux/dax.h  |  4 ++++
>  include/linux/fs.h   |  8 ++++++-
>  9 files changed, 110 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2b7bdabb44f8..d3d044125619 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3803,11 +3803,20 @@ int btree_readahead_hook(struct extent_buffer *eb, int err);
>  ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to);
>  ssize_t btrfs_file_dax_write(struct kiocb *iocb, struct iov_iter *from);
>  vm_fault_t btrfs_dax_fault(struct vm_fault *vmf);
> +int btrfs_dax_file_range_compare(struct inode *src, loff_t srcoff,
> +		struct inode *dest, loff_t destoff, loff_t len,
> +		bool *is_same);
>  #else
>  static inline ssize_t btrfs_file_dax_write(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	return 0;
>  }
> +static inline int btrfs_dax_file_range_compare(struct inode *src, loff_t srcoff,
> +		struct inode *dest, loff_t destoff, loff_t len,
> +		bool *is_same)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_FS_DAX */
>  
>  static inline int is_fstree(u64 rootid)
> diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
> index de957d681e16..af64696a5337 100644
> --- a/fs/btrfs/dax.c
> +++ b/fs/btrfs/dax.c
> @@ -227,4 +227,12 @@ vm_fault_t btrfs_dax_fault(struct vm_fault *vmf)
>  
>  	return ret;
>  }
> +
> +int btrfs_dax_file_range_compare(struct inode *src, loff_t srcoff,
> +		struct inode *dest, loff_t destoff, loff_t len,
> +		bool *is_same)
> +{
> +	return dax_file_range_compare(src, srcoff, dest, destoff, len,
> +				      is_same, &btrfs_iomap_ops);
> +}
>  #endif /* CONFIG_FS_DAX */
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0138119cd9a3..5ebb52848d5a 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3939,6 +3939,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	bool same_inode = inode_out == inode_in;
>  	u64 wb_len;
>  	int ret;
> +	compare_range_t cmp;
>  
>  	if (!(remap_flags & REMAP_FILE_DEDUP)) {
>  		struct btrfs_root *root_out = BTRFS_I(inode_out)->root;
> @@ -4000,8 +4001,14 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> -					    len, remap_flags);
> +	if (IS_DAX(file_inode(file_in)) && IS_DAX(file_inode(file_out)))

If we're moving towards a world where IS_DAX is a per-file condition, I
think this is going to need quite a bit more work to support doing
mixed-mode comparisons.

That, I think, could involve reworking vfs_dedupe_file_range_compare to
take a pair of (inode, iomap_ops) so that we can use the iomap
information to skip holes, avoid reading pages for uncached unwritten
ranges, etc.

TBH that sounds like a whole series on its own, so maybe we just want to
say no dedupe for now unless both files are in the page cache or both
files are DAX?

--D

> +		cmp = btrfs_dax_file_range_compare;
> +	else
> +		cmp = vfs_dedupe_file_range_compare;
> +
> +	ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
> +			pos_out, len, remap_flags, cmp);
> +
>  	if (ret < 0 || *len == 0)
>  		goto out_unlock;
>  
> diff --git a/fs/dax.c b/fs/dax.c
> index 07e8ff20161d..fa9ccbad7c03 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -39,6 +39,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/fs_dax.h>
>  
> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))
> +
>  static inline unsigned int pe_order(enum page_entry_size pe_size)
>  {
>  	if (pe_size == PE_SIZE_PTE)
> @@ -1795,3 +1797,66 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  	return dax_insert_pfn_mkwrite(vmf, pfn, order);
>  }
>  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> +
> +static inline void *iomap_address(struct iomap *iomap, loff_t off, loff_t len)
> +{
> +	loff_t start;
> +	void *addr;
> +	start = (get_start_sect(iomap->bdev) << 9) + iomap->addr +
> +		(off - iomap->offset);
> +	dax_direct_access(iomap->dax_dev, PHYS_PFN(start), PHYS_PFN(len),
> +			  &addr, NULL);
> +	return addr;
> +}
> +
> +int dax_file_range_compare(struct inode *src, loff_t srcoff, struct inode *dest,
> +		loff_t destoff, loff_t len, bool *is_same, const struct iomap_ops *ops)
> +{
> +	void *saddr, *daddr;
> +	struct iomap s_iomap = {0};
> +	struct iomap d_iomap = {0};
> +	bool same = true;
> +	loff_t cmp_len;
> +	int id, ret = 0;
> +
> +	id = dax_read_lock();
> +	while (len) {
> +		ret = ops->iomap_begin(src, srcoff, len, 0, &s_iomap);
> +		if (ret < 0) {
> +			if (ops->iomap_end)
> +				ops->iomap_end(src, srcoff, len, ret, 0, &s_iomap);
> +			return ret;
> +		}
> +		cmp_len = len;
> +		cmp_len = MIN(len, s_iomap.offset + s_iomap.length - srcoff);
> +
> +		ret = ops->iomap_begin(dest, destoff, cmp_len, 0, &d_iomap);
> +		if (ret < 0) {
> +			if (ops->iomap_end) {
> +				ops->iomap_end(src, srcoff, len, ret, 0, &s_iomap);
> +				ops->iomap_end(dest, destoff, len, ret, 0, &d_iomap);
> +			}
> +			return ret;
> +		}
> +		cmp_len = MIN(cmp_len, d_iomap.offset + d_iomap.length - destoff);
> +
> +		saddr = iomap_address(&s_iomap, srcoff, cmp_len);
> +		daddr = iomap_address(&d_iomap, destoff, cmp_len);
> +
> +		same = !memcmp(saddr, daddr, cmp_len);
> +		if (!same)
> +			break;
> +		len -= cmp_len;
> +		srcoff += cmp_len;
> +		destoff += cmp_len;
> +
> +		if (ops->iomap_end) {
> +			ret = ops->iomap_end(src, srcoff, len, 0, 0, &s_iomap);
> +			ret = ops->iomap_end(dest, destoff, len, 0, 0, &d_iomap);
> +		}
> +	}
> +	dax_read_unlock(id);
> +	*is_same = same;
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dax_file_range_compare);
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index d640c5f8a85d..9d470306cfc3 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2558,7 +2558,7 @@ static loff_t ocfs2_remap_file_range(struct file *file_in, loff_t pos_in,
>  		goto out_unlock;
>  
>  	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> -			&len, remap_flags);
> +			&len, remap_flags, vfs_dedupe_file_range_compare);
>  	if (ret < 0 || len == 0)
>  		goto out_unlock;
>  
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 61b43ad7608e..c6283802ef1c 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1778,7 +1778,7 @@ static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
>   * Compare extents of two files to see if they are the same.
>   * Caller must have locked both inodes to prevent write races.
>   */
> -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  					 struct inode *dest, loff_t destoff,
>  					 loff_t len, bool *is_same)
>  {
> @@ -1845,6 +1845,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  out_error:
>  	return error;
>  }
> +EXPORT_SYMBOL_GPL(vfs_dedupe_file_range_compare);
>  
>  /*
>   * Check that the two inodes are eligible for cloning, the ranges make
> @@ -1856,7 +1857,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>   */
>  int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
> -				  loff_t *len, unsigned int remap_flags)
> +				  loff_t *len, unsigned int remap_flags,
> +				  compare_range_t compare)
>  {
>  	struct inode *inode_in = file_inode(file_in);
>  	struct inode *inode_out = file_inode(file_out);
> @@ -1915,9 +1917,8 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	 */
>  	if (remap_flags & REMAP_FILE_DEDUP) {
>  		bool		is_same = false;
> -
> -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> -				inode_out, pos_out, *len, &is_same);
> +		ret = (*compare)(inode_in, pos_in,
> +			inode_out, pos_out, *len, &is_same);
>  		if (ret)
>  			return ret;
>  		if (!is_same)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 680ae7662a78..68e4257cebb0 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1350,7 +1350,7 @@ xfs_reflink_remap_prep(
>  		goto out_unlock;
>  
>  	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> -			len, remap_flags);
> +			len, remap_flags, vfs_dedupe_file_range_compare);
>  	if (ret < 0 || *len == 0)
>  		goto out_unlock;
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 0dd316a74a29..1370d39c91b6 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -157,6 +157,10 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
> +int dax_file_range_compare(struct inode *src, loff_t srcoff,
> +			   struct inode *dest, loff_t destoff,
> +			   loff_t len, bool *is_same,
> +			   const struct iomap_ops *ops);
>  
>  #ifdef CONFIG_FS_DAX
>  int __dax_zero_page_range(struct block_device *bdev,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dd28e7679089..0224503e42ce 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1883,10 +1883,16 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
>  		unsigned long, loff_t *, rwf_t);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  				   loff_t, size_t, unsigned int);
> +extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +					 struct inode *dest, loff_t destoff,
> +					 loff_t len, bool *is_same);
> +typedef int (*compare_range_t)(struct inode *src, loff_t srcpos,
> +			       struct inode *dest, loff_t destpos,
> +			       loff_t len, bool *is_same);
>  extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  					 struct file *file_out, loff_t pos_out,
>  					 loff_t *count,
> -					 unsigned int remap_flags);
> +					 unsigned int remap_flags, compare_range_t cmp);
>  extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
>  				  loff_t len, unsigned int remap_flags);
> -- 
> 2.16.4
> 
