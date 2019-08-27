Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4A9E9D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 15:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfH0Nps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 09:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfH0Nps (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:45:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02745AC45;
        Tue, 27 Aug 2019 13:45:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DC2361E4362; Tue, 27 Aug 2019 15:45:43 +0200 (CEST)
Date:   Tue, 27 Aug 2019 15:45:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20190827134543.GA10306@quack2.suse.cz>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org>
 <20190826203326.GB13860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826203326.GB13860@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-08-19 16:33:26, Vivek Goyal wrote:
> On Mon, Aug 26, 2019 at 04:53:16AM -0700, Christoph Hellwig wrote:
> > On Wed, Aug 21, 2019 at 01:57:03PM -0400, Vivek Goyal wrote:
> > > Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
> > > is searched from that bdev name.
> > > 
> > > virtio-fs does not have a bdev. So pass in dax_dev also to
> > > dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
> > > used otherwise dax_dev is searched using bdev.
> > 
> > Please just pass in only the dax_device and get rid of the block device.
> > The callers should have one at hand easily, e.g. for XFS just call
> > xfs_find_daxdev_for_inode instead of xfs_find_bdev_for_inode.
> 
> Sure. Here is the updated patch.
> 
> This patch can probably go upstream independently. If you are fine with
> the patch, I can post it separately for inclusion.
> 
> 
> Subject: dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()
> 
> As of now dax_writeback_mapping_range() takes "struct block_device" as a
> parameter and dax_dev is searched from bdev name. This also involves taking
> a fresh reference on dax_dev and putting that reference at the end of
> function.
> 
> We are developing a new filesystem virtio-fs and using dax to access host
> page cache directly. But there is no block device. IOW, we want to make
> use of dax but want to get rid of this assumption that there is always
> a block device associated with dax_dev.
> 
> So pass in "struct dax_device" as parameter instead of bdev.
> 
> ext2/ext4/xfs are current users and they already have a reference on
> dax_device. So there is no need to take reference and drop reference to
> dax_device on each call of this function.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/dax.c            |    8 +-------
>  fs/ext2/inode.c     |    5 +++--
>  fs/ext4/inode.c     |    2 +-
>  fs/xfs/xfs_aops.c   |    2 +-
>  include/linux/dax.h |    2 +-
>  5 files changed, 7 insertions(+), 12 deletions(-)
> 
> Index: rhvgoyal-linux-fuse/fs/dax.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/dax.c	2019-08-26 11:20:36.545009968 -0400
> +++ rhvgoyal-linux-fuse/fs/dax.c	2019-08-26 11:24:43.973009968 -0400
> @@ -936,12 +936,11 @@ static int dax_writeback_one(struct xa_s
>   * on persistent storage prior to completion of the operation.
>   */
>  int dax_writeback_mapping_range(struct address_space *mapping,
> -		struct block_device *bdev, struct writeback_control *wbc)
> +		struct dax_device *dax_dev, struct writeback_control *wbc)
>  {
>  	XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
>  	struct inode *inode = mapping->host;
>  	pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
> -	struct dax_device *dax_dev;
>  	void *entry;
>  	int ret = 0;
>  	unsigned int scanned = 0;
> @@ -952,10 +951,6 @@ int dax_writeback_mapping_range(struct a
>  	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
>  		return 0;
>  
> -	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
> -	if (!dax_dev)
> -		return -EIO;
> -
>  	trace_dax_writeback_range(inode, xas.xa_index, end_index);
>  
>  	tag_pages_for_writeback(mapping, xas.xa_index, end_index);
> @@ -976,7 +971,6 @@ int dax_writeback_mapping_range(struct a
>  		xas_lock_irq(&xas);
>  	}
>  	xas_unlock_irq(&xas);
> -	put_dax(dax_dev);
>  	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
>  	return ret;
>  }
> Index: rhvgoyal-linux-fuse/include/linux/dax.h
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/include/linux/dax.h	2019-08-26 11:20:36.545009968 -0400
> +++ rhvgoyal-linux-fuse/include/linux/dax.h	2019-08-26 11:26:08.384009968 -0400
> @@ -141,7 +141,7 @@ static inline void fs_put_dax(struct dax
>  
>  struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
>  int dax_writeback_mapping_range(struct address_space *mapping,
> -		struct block_device *bdev, struct writeback_control *wbc);
> +		struct dax_device *dax_dev, struct writeback_control *wbc);
>  
>  struct page *dax_layout_busy_page(struct address_space *mapping);
>  dax_entry_t dax_lock_page(struct page *page);
> Index: rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/xfs/xfs_aops.c	2019-08-26 11:20:36.545009968 -0400
> +++ rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c	2019-08-26 11:34:51.085009968 -0400
> @@ -1120,7 +1120,7 @@ xfs_dax_writepages(
>  {
>  	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
>  	return dax_writeback_mapping_range(mapping,
> -			xfs_find_bdev_for_inode(mapping->host), wbc);
> +			xfs_find_daxdev_for_inode(mapping->host), wbc);
>  }
>  
>  STATIC int
> Index: rhvgoyal-linux-fuse/fs/ext4/inode.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/ext4/inode.c	2019-08-26 11:20:36.545009968 -0400
> +++ rhvgoyal-linux-fuse/fs/ext4/inode.c	2019-08-26 11:39:56.828009968 -0400
> @@ -2992,7 +2992,7 @@ static int ext4_dax_writepages(struct ad
>  	percpu_down_read(&sbi->s_journal_flag_rwsem);
>  	trace_ext4_writepages(inode, wbc);
>  
> -	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
> +	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
>  	trace_ext4_writepages_result(inode, wbc, ret,
>  				     nr_to_write - wbc->nr_to_write);
>  	percpu_up_read(&sbi->s_journal_flag_rwsem);
> Index: rhvgoyal-linux-fuse/fs/ext2/inode.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/ext2/inode.c	2019-08-26 11:20:36.545009968 -0400
> +++ rhvgoyal-linux-fuse/fs/ext2/inode.c	2019-08-26 11:43:04.842009968 -0400
> @@ -957,8 +957,9 @@ ext2_writepages(struct address_space *ma
>  static int
>  ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
> -	return dax_writeback_mapping_range(mapping,
> -			mapping->host->i_sb->s_bdev, wbc);
> +	struct ext2_sb_info *sbi = EXT2_SB(mapping->host->i_sb);
> +
> +	return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
>  }
>  
>  const struct address_space_operations ext2_aops = {
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
