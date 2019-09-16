Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F7B3FB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfIPRnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 13:43:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57466 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfIPRnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:43:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHdK3e032548;
        Mon, 16 Sep 2019 17:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=be5lHUY3oMjgPjNyxpXBb5ZBb0pqJIvx8b9KYRbecBw=;
 b=h2pKkXrJjq9NlBDtXkZlazi1nfrlKYXQnR1lk8lVRV9/dI1RiH2SZIznRpMvPIy6hGag
 VRysFTlexuOhW1rC8MWJZ2HDgnwRc2LYcHNka/2JWNjOr8pRkd7ARPFPnpI9MvCmoeyR
 +qYWIs4SXGOCXuPV+9iytAB4NdbXe0zsuiJ1OHgU0W1zBBhUgxg8vyyDEE344+kRh/j0
 yQkWe7zIEqipFA/PN9wgsW3MIwI9E0mKIEPPAs/tlmzvrnMmPAMOiIxuYjxCtq8iVZtQ
 a3Vt1O9YxpxCPWC4PMCkQFzLnBVvcydxr/hTz1oVqEFFhftBGfmTDKkJ9TH/l8xbAVWO 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v0ruqh1wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:42:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GHd1ek195331;
        Mon, 16 Sep 2019 17:42:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2v0nb53and-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 17:42:41 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8GHgecS003348;
        Mon, 16 Sep 2019 17:42:40 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 10:42:40 -0700
Date:   Mon, 16 Sep 2019 10:42:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] fs: Move start and length fiemap fields into
 fiemap_extent_info
Message-ID: <20190916174239.GB2229799@magnolia>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
 <20190911134315.27380-6-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911134315.27380-6-cmaiolino@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160175
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:43:11PM +0200, Carlos Maiolino wrote:
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
> Changelog:
> 
> 	V6:
> 		- Update cifs_fiemap to comply to the new ->fiemap()
> 		  interface
> 			Reported-by: kbuild test robot <lkp@intel.com>
> 		- Fix ext4 conflict with the new EXT4_IOC_GET_ES_CACHE
> 		  ioctl
> 	V5:
> 		- Add comments to fi_start and fi_len fields of
> 		  fiemap_extent_info
> 		- Fix xfs_vn_fiemap indentation
> 
>  fs/bad_inode.c        |  3 +--
>  fs/btrfs/inode.c      |  5 +++--
>  fs/cifs/cifsfs.h      |  3 +--
>  fs/cifs/inode.c       |  5 +++--
>  fs/ext2/ext2.h        |  3 +--
>  fs/ext2/inode.c       |  6 ++----
>  fs/ext4/ext4.h        |  6 ++----
>  fs/ext4/extents.c     | 18 +++++++-----------
>  fs/ext4/ioctl.c       |  4 +++-
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
>  include/linux/fs.h    | 23 +++++++++++++----------
>  21 files changed, 70 insertions(+), 70 deletions(-)
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
> index ef9310553a73..3d42f07c31b0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8762,9 +8762,10 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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
> diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
> index 99caf77df4a2..ca4c9443cd4e 100644
> --- a/fs/cifs/cifsfs.h
> +++ b/fs/cifs/cifsfs.h
> @@ -84,8 +84,7 @@ extern int cifs_revalidate_mapping(struct inode *inode);
>  extern int cifs_zap_mapping(struct inode *inode);
>  extern int cifs_getattr(const struct path *, struct kstat *, u32, unsigned int);
>  extern int cifs_setattr(struct dentry *, struct iattr *);
> -extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, u64 start,
> -		       u64 len);
> +extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *);
>  
>  extern const struct inode_operations cifs_file_inode_ops;
>  extern const struct inode_operations cifs_symlink_inode_ops;
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 26cdfbf1e164..ad5731c5a7d3 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -2123,14 +2123,15 @@ int cifs_getattr(const struct path *path, struct kstat *stat,
>  	return rc;
>  }
>  
> -int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
> -		u64 len)
> +int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei)
>  {
>  	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
>  	struct cifs_sb_info *cifs_sb = CIFS_SB(cifs_i->vfs_inode.i_sb);
>  	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
>  	struct TCP_Server_Info *server = tcon->ses->server;
>  	struct cifsFileInfo *cfile;
> +	u64 start = fei->fi_start;
> +	u64 len = fei->fi_len;
>  	int rc;
>  
>  	/*
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
> index 7004ce581a32..6956df98dd53 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -857,11 +857,9 @@ const struct iomap_ops ext2_iomap_ops = {
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
> index 99a10f3ec440..be0aa671d701 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3285,11 +3285,9 @@ extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
>  extern void ext4_ext_drop_refs(struct ext4_ext_path *);
>  extern int ext4_ext_check_inode(struct inode *inode);
>  extern ext4_lblk_t ext4_ext_next_allocated_block(struct ext4_ext_path *path);
> -extern int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -			__u64 start, __u64 len);
>  extern int ext4_get_es_cache(struct inode *inode,
> -			     struct fiemap_extent_info *fieinfo,
> -			     __u64 start, __u64 len);
> +			     struct fiemap_extent_info *fieinfo);
> +extern int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo);
>  extern int ext4_ext_precache(struct inode *inode);
>  extern int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
>  extern int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index fb0f99dc8c22..7e399fcb90e3 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5101,11 +5101,12 @@ static int ext4_xattr_fiemap(struct inode *inode,
>  
>  static int _ext4_fiemap(struct inode *inode,
>  			struct fiemap_extent_info *fieinfo,
> -			__u64 start, __u64 len,
>  			int (*fill)(struct inode *, ext4_lblk_t,
>  				    ext4_lblk_t,
>  				    struct fiemap_extent_info *))
>  {
> +	u64 start = fieinfo->fi_start;
> +	u64 len = fieinfo->fi_len;
>  	ext4_lblk_t start_blk;
>  	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR;
>  
> @@ -5131,8 +5132,7 @@ static int _ext4_fiemap(struct inode *inode,
>  	/* fallback to generic here if not in extents fmt */
>  	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) &&
>  	    fill == ext4_fill_fiemap_extents)
> -		return generic_block_fiemap(inode, fieinfo, start, len,
> -			ext4_get_block);
> +		return generic_block_fiemap(inode, fieinfo, ext4_get_block);
>  
>  	if (fill == ext4_fill_es_cache_info)
>  		ext4_fiemap_flags &= FIEMAP_FLAG_XATTR;
> @@ -5160,15 +5160,12 @@ static int _ext4_fiemap(struct inode *inode,
>  	return error;
>  }
>  
> -int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		__u64 start, __u64 len)
> +int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> -	return _ext4_fiemap(inode, fieinfo, start, len,
> -			    ext4_fill_fiemap_extents);
> +	return _ext4_fiemap(inode, fieinfo, ext4_fill_fiemap_extents);
>  }
>  
> -int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		      __u64 start, __u64 len)
> +int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
>  	if (ext4_has_inline_data(inode)) {
>  		int has_inline;
> @@ -5180,8 +5177,7 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			return 0;
>  	}
>  
> -	return _ext4_fiemap(inode, fieinfo, start, len,
> -			    ext4_fill_es_cache_info);
> +	return _ext4_fiemap(inode, fieinfo, ext4_fill_es_cache_info);
>  }
>  
>  
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index e0a5d8d7c1b4..546a26a2c800 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -795,6 +795,8 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	fieinfo.fi_flags = fiemap.fm_flags;
>  	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>  	fieinfo.fi_extents_start = ufiemap->fm_extents;
> +	fieinfo.fi_start = fiemap.fm_start;
> +	fieinfo.fi_len = len;
>  
>  	if (fiemap.fm_extent_count != 0 &&
>  	    !access_ok(fieinfo.fi_extents_start,
> @@ -804,7 +806,7 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
>  		filemap_write_and_wait(inode->i_mapping);
>  
> -	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start, len);
> +	error = ext4_get_es_cache(inode, &fieinfo);
>  	fiemap.fm_flags = fieinfo.fi_flags;
>  	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
>  	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 49ff6d2239c3..af2312858069 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1543,9 +1543,10 @@ static int f2fs_xattr_fiemap(struct inode *inode,
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
> index 7af36369dd94..42c27e1b5730 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3217,8 +3217,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio);
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
> index e1e18fb587eb..a02a52cbbec4 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2026,9 +2026,10 @@ static int gfs2_getattr(const struct path *path, struct kstat *stat,
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
> index 42395ba52da6..f74b64a76c52 100644
> --- a/fs/nilfs2/nilfs.h
> +++ b/fs/nilfs2/nilfs.h
> @@ -275,8 +275,7 @@ extern int nilfs_inode_dirty(struct inode *);
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
> index e66a249fe07c..1a5b6af62ee0 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -736,8 +736,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
>  
>  #define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
>  
> -int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		 u64 map_start, u64 map_len)
> +int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
>  	int ret, is_last;
>  	u32 mapping_end, cpos;
> @@ -746,6 +745,8 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	u64 len_bytes, phys_bytes, virt_bytes;
>  	struct buffer_head *di_bh = NULL;
>  	struct ocfs2_extent_rec rec;
> +	u64 map_start = fieinfo->fi_start;
> +	u64 map_len = fieinfo->fi_len;
>  
>  	ret = fiemap_check_flags(fieinfo, OCFS2_FIEMAP_FLAGS);
>  	if (ret)
> diff --git a/fs/ocfs2/extent_map.h b/fs/ocfs2/extent_map.h
> index e5464f6cee8a..be3724b67d7e 100644
> --- a/fs/ocfs2/extent_map.h
> +++ b/fs/ocfs2/extent_map.h
> @@ -37,8 +37,7 @@ int ocfs2_get_clusters(struct inode *inode, u32 v_cluster, u32 *p_cluster,
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
> index 7663aeb85fa3..6fd54fb23275 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -453,8 +453,7 @@ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
>  	return 0;
>  }
>  
> -static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -		      u64 start, u64 len)
> +static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
>  	int err;
>  	struct inode *realinode = ovl_inode_real(inode);
> @@ -468,7 +467,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
>  		filemap_write_and_wait(realinode->i_mapping);
>  
> -	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
> +	err = realinode->i_op->fiemap(realinode, fieinfo);
>  	revert_creds(old_cred);
>  
>  	return err;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index fe285d123d69..8d14d733a0e6 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1100,12 +1100,12 @@ xfs_vn_update_time(
>  
>  STATIC int
>  xfs_vn_fiemap(
> -	struct inode		*inode,
> -	struct fiemap_extent_info *fieinfo,
> -	u64			start,
> -	u64			length)
> +	struct inode			*inode,
> +	struct fiemap_extent_info	*fieinfo)
>  {
> -	int			error;
> +	u64				start = fieinfo->fi_start;
> +	u64				length = fieinfo->fi_len;
> +	int				error;
>  
>  	xfs_ilock(XFS_I(inode), XFS_IOLOCK_SHARED);
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f1fbd8298ca4..2c0438de4982 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1737,11 +1737,16 @@ extern bool may_open_dev(const struct path *path);
>   * VFS FS_IOC_FIEMAP helper definitions.
>   */
>  struct fiemap_extent_info {
> -	unsigned int fi_flags;		/* Flags as passed from user */
> -	unsigned int fi_extents_mapped;	/* Number of mapped extents */
> -	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
> -	struct fiemap_extent __user *fi_extents_start; /* Start of
> -							fiemap_extent array */
> +	unsigned int	fi_flags;		/* Flags as passed from user */
> +	u64		fi_start;		/* Logical offset at which
> +						   start mapping */
> +	u64		fi_len;			/* Logical length of mapping the
> +						   caller cares about */
> +	unsigned int	fi_extents_mapped;	/* Number of mapped extents */
> +	unsigned int	fi_extents_max;		/* Size of fiemap_extent array */
> +	struct		fiemap_extent __user *fi_extents_start;	/* Start of
> +								   fiemap_extent
> +								   array */

I might've just put the comments above rather than squash them into the
right side of the tty, but eh.  If you end up resending this series then
I'd want that fixed up, but for now:

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

:)

--D

>  };
>  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
>  			    u64 phys, u64 len, u32 flags);
> @@ -1873,8 +1878,7 @@ struct inode_operations {
>  	int (*setattr) (struct dentry *, struct iattr *);
>  	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
>  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
> -	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
> -		      u64 len);
> +	int (*fiemap)(struct inode *, struct fiemap_extent_info *);
>  	int (*update_time)(struct inode *, struct timespec64 *, int);
>  	int (*atomic_open)(struct inode *, struct dentry *,
>  			   struct file *, unsigned open_flag,
> @@ -3268,11 +3272,10 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
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
