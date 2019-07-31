Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFF7D1E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfGaX3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 19:29:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaX3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:29:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNOvFo183172;
        Wed, 31 Jul 2019 23:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=HFLRdLZJOKJXrdtuHNor+O7+quysVDWHS2/8wwmvUlo=;
 b=uIetgIR9zt5G+X488m6NDictODmfI18RRDRIhA2ESUu6rvOiVZGJd6P6FG6RvGtA9BQ2
 83jfXoX/I9v8AqKjzv8ezBjULIDgCChwjpR5JwyAsaHRjNFEuEQOMB+HIhpxLf+g65A6
 lSPbkC8rbRLbEObsD1zuwlNzL3w6DKQ8VQj0oxt0Ys+R/jeu1yAyV+xcLZSaj5aMZtoN
 lFo3X436Tnp97yFIrIaXy3VQalI8K8OOvaU1/mEeaiIz6jugSGzkRDEYNbTsVZgPe3l6
 unR6Pc/RnKPMdzlveU4yZWnOkMvAb0Kc10QoE6u/JlZRg3auejL8MZzfjkyZhqnKzyGY bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u0f8r85fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:28:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNS04i087487;
        Wed, 31 Jul 2019 23:28:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u38fbcts6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:28:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6VNSeog031145;
        Wed, 31 Jul 2019 23:28:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 16:28:39 -0700
Date:   Wed, 31 Jul 2019 16:28:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] fs: Move start and length fiemap fields into
 fiemap_extent_info
Message-ID: <20190731232837.GZ1561054@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-6-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141245.7230-6-cmaiolino@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310231
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310230
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:12:41PM +0200, Carlos Maiolino wrote:
> As the overall goal to deprecate fibmap, Christoph suggested a rework of
> the ->fiemap API, in a way we could pass to it a callback to fill the
> fiemap structure (one of these callbacks being fiemap_fill_next_extent).
> 
> To avoid the need to add several fields into the ->fiemap method, aggregate
> everything into a single data structure, and pass it along.
> 
> This patch isn't suppose to add any functional change, only to update
> filesystems providing ->fiemap() method.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  fs/bad_inode.c        |  3 +--
>  fs/btrfs/inode.c      |  5 +++--
>  fs/ext2/ext2.h        |  3 +--
>  fs/ext2/inode.c       |  6 ++----
>  fs/ext4/ext4.h        |  3 +--
>  fs/ext4/extents.c     |  8 ++++----
>  fs/f2fs/data.c        |  5 +++--
>  fs/f2fs/f2fs.h        |  3 +--
>  fs/gfs2/inode.c       |  5 +++--
>  fs/hpfs/file.c        |  4 ++--
>  fs/ioctl.c            | 16 ++++++++++------
>  fs/nilfs2/inode.c     |  5 +++--
>  fs/nilfs2/nilfs.h     |  3 +--
>  fs/ocfs2/extent_map.c |  5 +++--
>  fs/ocfs2/extent_map.h |  3 +--
>  fs/overlayfs/inode.c  |  5 ++---
>  fs/xfs/xfs_iops.c     | 10 +++++-----
>  include/linux/fs.h    | 21 +++++++++++----------
>  18 files changed, 57 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 8035d2a44561..21dfaf876814 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -120,8 +120,7 @@ static struct posix_acl *bad_inode_get_acl(struct inode *inode, int type)
>  }
>  
>  static int bad_inode_fiemap(struct inode *inode,
> -			    struct fiemap_extent_info *fieinfo, u64 start,
> -			    u64 len)
> +			    struct fiemap_extent_info *fieinfo)
>  {
>  	return -EIO;
>  }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 82fdda8ff5ab..caa06a8ac767 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8600,9 +8600,10 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  
>  #define BTRFS_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
>  
> -static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		__u64 start, __u64 len)
> +static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> +	u64	start = fieinfo->fi_start;
> +	u64	len = fieinfo->fi_len;
>  	int	ret;
>  
>  	ret = fiemap_check_flags(fieinfo, BTRFS_FIEMAP_FLAGS);
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 10ab238de9a6..284df1af9474 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -760,8 +760,7 @@ extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
>  extern int ext2_setattr (struct dentry *, struct iattr *);
>  extern int ext2_getattr (const struct path *, struct kstat *, u32, unsigned int);
>  extern void ext2_set_inode_flags(struct inode *inode);
> -extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		       u64 start, u64 len);
> +extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo);
>  
>  /* ioctl.c */
>  extern long ext2_ioctl(struct file *, unsigned int, unsigned long);
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index c27c27300d95..267392335f38 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -855,11 +855,9 @@ const struct iomap_ops ext2_iomap_ops = {
>  const struct iomap_ops ext2_iomap_ops;
>  #endif /* CONFIG_FS_DAX */
>  
> -int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		u64 start, u64 len)
> +int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> -	return generic_block_fiemap(inode, fieinfo, start, len,
> -				    ext2_get_block);
> +	return generic_block_fiemap(inode, fieinfo, ext2_get_block);
>  }
>  
>  static int ext2_writepage(struct page *page, struct writeback_control *wbc)
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 82ffdacdc7fa..e4cb40b5893b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3154,8 +3154,7 @@ extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
>  extern void ext4_ext_drop_refs(struct ext4_ext_path *);
>  extern int ext4_ext_check_inode(struct inode *inode);
>  extern ext4_lblk_t ext4_ext_next_allocated_block(struct ext4_ext_path *path);
> -extern int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -			__u64 start, __u64 len);
> +extern int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo);
>  extern int ext4_ext_precache(struct inode *inode);
>  extern int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
>  extern int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0f89f5190cd7..436e564ebdd6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5038,9 +5038,10 @@ static int ext4_xattr_fiemap(struct inode *inode,
>  	return (error < 0 ? error : 0);
>  }
>  
> -int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		__u64 start, __u64 len)
> +int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> +	u64 start = fieinfo->fi_start;
> +	u64 len = fieinfo->fi_len;
>  	ext4_lblk_t start_blk;
>  	int error = 0;
>  
> @@ -5062,8 +5063,7 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  
>  	/* fallback to generic here if not in extents fmt */
>  	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
> -		return generic_block_fiemap(inode, fieinfo, start, len,
> -			ext4_get_block);
> +		return generic_block_fiemap(inode, fieinfo, ext4_get_block);
>  
>  	if (fiemap_check_flags(fieinfo, EXT4_FIEMAP_FLAGS))
>  		return -EBADR;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9727944139f2..2979ca40d192 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1409,9 +1409,10 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>  	return (err < 0 ? err : 0);
>  }
>  
> -int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		u64 start, u64 len)
> +int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> +	u64 start = fieinfo->fi_start;
> +	u64 len = fieinfo->fi_len;
>  	struct buffer_head map_bh;
>  	sector_t start_blk, last_blk;
>  	pgoff_t next_pgofs;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 87f75ebd2fd6..fb33809c2552 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3155,8 +3155,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio);
>  void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock);
>  int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  			int create, int flag);
> -int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -			u64 start, u64 len);
> +int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo);
>  bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
>  bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
>  void f2fs_invalidate_page(struct page *page, unsigned int offset,
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 998051c4aea7..5e84d5963506 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2004,9 +2004,10 @@ static int gfs2_getattr(const struct path *path, struct kstat *stat,
>  	return 0;
>  }
>  
> -static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		       u64 start, u64 len)
> +static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> +	u64 start = fieinfo->fi_start;
> +	u64 len = fieinfo->fi_len;
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct gfs2_holder gh;
>  	int ret;
> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index 1ecec124e76f..0eece4ae1f11 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -190,9 +190,9 @@ static sector_t _hpfs_bmap(struct address_space *mapping, sector_t block)
>  	return generic_block_bmap(mapping, block, hpfs_get_block);
>  }
>  
> -static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo, u64 start, u64 len)
> +static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> -	return generic_block_fiemap(inode, fieinfo, start, len, hpfs_get_block);
> +	return generic_block_fiemap(inode, fieinfo, hpfs_get_block);
>  }
>  
>  const struct address_space_operations hpfs_aops = {
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 6b589c873bc2..ad8edcb10dc9 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -210,6 +210,8 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
>  	fieinfo.fi_flags = fiemap.fm_flags;
>  	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>  	fieinfo.fi_extents_start = ufiemap->fm_extents;
> +	fieinfo.fi_start = fiemap.fm_start;
> +	fieinfo.fi_len = len;
>  
>  	if (fiemap.fm_extent_count != 0 &&
>  	    !access_ok(fieinfo.fi_extents_start,
> @@ -219,7 +221,7 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
>  	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
>  		filemap_write_and_wait(inode->i_mapping);
>  
> -	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start, len);
> +	error = inode->i_op->fiemap(inode, &fieinfo);
>  	fiemap.fm_flags = fieinfo.fi_flags;
>  	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
>  	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
> @@ -296,9 +298,11 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
>   */
>  
>  int __generic_block_fiemap(struct inode *inode,
> -			   struct fiemap_extent_info *fieinfo, loff_t start,
> -			   loff_t len, get_block_t *get_block)
> +			   struct fiemap_extent_info *fieinfo,
> +			   get_block_t *get_block)
>  {
> +	loff_t start = fieinfo->fi_start;
> +	loff_t len = fieinfo->fi_len;
>  	struct buffer_head map_bh;
>  	sector_t start_blk, last_blk;
>  	loff_t isize = i_size_read(inode);
> @@ -455,12 +459,12 @@ EXPORT_SYMBOL(__generic_block_fiemap);
>   */
>  
>  int generic_block_fiemap(struct inode *inode,
> -			 struct fiemap_extent_info *fieinfo, u64 start,
> -			 u64 len, get_block_t *get_block)
> +			 struct fiemap_extent_info *fieinfo,
> +			 get_block_t *get_block)
>  {
>  	int ret;
>  	inode_lock(inode);
> -	ret = __generic_block_fiemap(inode, fieinfo, start, len, get_block);
> +	ret = __generic_block_fiemap(inode, fieinfo, get_block);
>  	inode_unlock(inode);
>  	return ret;
>  }
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 671085512e0f..1f37d086371c 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -992,9 +992,10 @@ void nilfs_dirty_inode(struct inode *inode, int flags)
>  	nilfs_transaction_commit(inode->i_sb); /* never fails */
>  }
>  
> -int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		 __u64 start, __u64 len)
> +int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> +	u64 start = fieinfo->fi_start;
> +	u64 len = fieinfo->fi_len;
>  	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
>  	__u64 logical = 0, phys = 0, size = 0;
>  	__u32 flags = 0;
> diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
> index a2f247b6a209..55d1307ed710 100644
> --- a/fs/nilfs2/nilfs.h
> +++ b/fs/nilfs2/nilfs.h
> @@ -276,8 +276,7 @@ extern int nilfs_inode_dirty(struct inode *);
>  int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty);
>  extern int __nilfs_mark_inode_dirty(struct inode *, int);
>  extern void nilfs_dirty_inode(struct inode *, int flags);
> -int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		 __u64 start, __u64 len);
> +int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo);
>  static inline int nilfs_mark_inode_dirty(struct inode *inode)
>  {
>  	return __nilfs_mark_inode_dirty(inode, I_DIRTY);
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 06cb96462bf9..e01fd38ea935 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -749,8 +749,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
>  
>  #define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
>  
> -int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		 u64 map_start, u64 map_len)
> +int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
>  	int ret, is_last;
>  	u32 mapping_end, cpos;
> @@ -759,6 +758,8 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	u64 len_bytes, phys_bytes, virt_bytes;
>  	struct buffer_head *di_bh = NULL;
>  	struct ocfs2_extent_rec rec;
> +	u64 map_start = fieinfo->fi_start;
> +	u64 map_len = fieinfo->fi_len;
>  
>  	ret = fiemap_check_flags(fieinfo, OCFS2_FIEMAP_FLAGS);
>  	if (ret)
> diff --git a/fs/ocfs2/extent_map.h b/fs/ocfs2/extent_map.h
> index 1057586ec19f..793be96099c0 100644
> --- a/fs/ocfs2/extent_map.h
> +++ b/fs/ocfs2/extent_map.h
> @@ -50,8 +50,7 @@ int ocfs2_get_clusters(struct inode *inode, u32 v_cluster, u32 *p_cluster,
>  int ocfs2_extent_map_get_blocks(struct inode *inode, u64 v_blkno, u64 *p_blkno,
>  				u64 *ret_count, unsigned int *extent_flags);
>  
> -int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		 u64 map_start, u64 map_len);
> +int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo);
>  
>  int ocfs2_overwrite_io(struct inode *inode, struct buffer_head *di_bh,
>  		       u64 map_start, u64 map_len);
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 3b7ed5d2279c..6f00b0ef6b43 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -456,8 +456,7 @@ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
>  	return 0;
>  }
>  
> -static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		      u64 start, u64 len)
> +static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
>  	int err;
>  	struct inode *realinode = ovl_inode_real(inode);
> @@ -471,7 +470,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
>  		filemap_write_and_wait(realinode->i_mapping);
>  
> -	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
> +	err = realinode->i_op->fiemap(realinode, fieinfo);
>  	revert_creds(old_cred);
>  
>  	return err;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 74047bd0c1ae..1f4354fa989b 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1109,12 +1109,12 @@ xfs_vn_update_time(
>  
>  STATIC int
>  xfs_vn_fiemap(
> -	struct inode		*inode,
> -	struct fiemap_extent_info *fieinfo,
> -	u64			start,
> -	u64			length)
> +	struct inode		  *inode,
> +	struct fiemap_extent_info *fieinfo)
>  {
> -	int			error;
> +	u64	start = fieinfo->fi_start;
> +	u64	length = fieinfo->fi_len;
> +	int	error;

Would be nice if the variable name indentation was consistent here, but
otherwise the xfs part looks ok.

>  
>  	xfs_ilock(XFS_I(inode), XFS_IOLOCK_SHARED);
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d5e7c744aea6..7b744b7de24e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1705,11 +1705,14 @@ extern bool may_open_dev(const struct path *path);
>   * VFS FS_IOC_FIEMAP helper definitions.
>   */
>  struct fiemap_extent_info {
> -	unsigned int fi_flags;		/* Flags as passed from user */
> -	unsigned int fi_extents_mapped;	/* Number of mapped extents */
> -	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
> -	struct fiemap_extent __user *fi_extents_start; /* Start of
> -							fiemap_extent array */
> +	unsigned int	fi_flags;		/* Flags as passed from user */
> +	u64		fi_start;
> +	u64		fi_len;

Comments for these two new fields?

--D

> +	unsigned int	fi_extents_mapped;	/* Number of mapped extents */
> +	unsigned int	fi_extents_max;		/* Size of fiemap_extent array */
> +	struct		fiemap_extent __user *fi_extents_start;	/* Start of
> +								   fiemap_extent
> +								   array */
>  };
>  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
>  			    u64 phys, u64 len, u32 flags);
> @@ -1841,8 +1844,7 @@ struct inode_operations {
>  	int (*setattr) (struct dentry *, struct iattr *);
>  	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
>  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
> -	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
> -		      u64 len);
> +	int (*fiemap)(struct inode *, struct fiemap_extent_info *);
>  	int (*update_time)(struct inode *, struct timespec64 *, int);
>  	int (*atomic_open)(struct inode *, struct dentry *,
>  			   struct file *, unsigned open_flag,
> @@ -3199,11 +3201,10 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
>  
>  extern int __generic_block_fiemap(struct inode *inode,
>  				  struct fiemap_extent_info *fieinfo,
> -				  loff_t start, loff_t len,
>  				  get_block_t *get_block);
>  extern int generic_block_fiemap(struct inode *inode,
> -				struct fiemap_extent_info *fieinfo, u64 start,
> -				u64 len, get_block_t *get_block);
> +				struct fiemap_extent_info *fieinfo,
> +				get_block_t *get_block);
>  
>  extern struct file_system_type *get_filesystem(struct file_system_type *fs);
>  extern void put_filesystem(struct file_system_type *fs);
> -- 
> 2.20.1
> 
