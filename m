Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0B12F90F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 15:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgACOMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 09:12:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727539AbgACOMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578060766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGMg0pHtt4SVc4uhGk+7pIjVLdzZuIJr8uS5jcpc3MY=;
        b=NwyTpLUaQhy4aQcSi0ZCPkgtNMs80Ye0HTR1rp9p9oDeBngMFPadajBLTPZgz2un4KS4ha
        x6/9ywk5L6ymgZ4epnsqc9K5wbDc4kaso+TSHWrv4QQVGymFz8MvFHZYPaTFFg9zIil/vy
        EIfsM2YkyzyxLcEMn+m0q059Z1E0Heo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385--FlagLmkMOm7LZJqTa9NNQ-1; Fri, 03 Jan 2020 09:12:43 -0500
X-MC-Unique: -FlagLmkMOm7LZJqTa9NNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29D92801A0D;
        Fri,  3 Jan 2020 14:12:42 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11FFE386;
        Fri,  3 Jan 2020 14:12:36 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9A02E2202E9; Fri,  3 Jan 2020 09:12:35 -0500 (EST)
Date:   Fri, 3 Jan 2020 09:12:35 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20200103141235.GA13350@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org>
 <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826205829.GC13860@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:58:29PM -0400, Vivek Goyal wrote:
> On Mon, Aug 26, 2019 at 04:33:26PM -0400, Vivek Goyal wrote:
> > On Mon, Aug 26, 2019 at 04:53:16AM -0700, Christoph Hellwig wrote:
> > > On Wed, Aug 21, 2019 at 01:57:03PM -0400, Vivek Goyal wrote:
> > > > Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
> > > > is searched from that bdev name.
> > > > 
> > > > virtio-fs does not have a bdev. So pass in dax_dev also to
> > > > dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
> > > > used otherwise dax_dev is searched using bdev.
> > > 
> > > Please just pass in only the dax_device and get rid of the block device.
> > > The callers should have one at hand easily, e.g. for XFS just call
> > > xfs_find_daxdev_for_inode instead of xfs_find_bdev_for_inode.
> > 
> > Sure. Here is the updated patch.
> > 
> > This patch can probably go upstream independently. If you are fine with
> > the patch, I can post it separately for inclusion.
> 
> Forgot to update function declaration in case of !CONFIG_FS_DAX. Here is
> the updated patch.
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

Hi Dan,

Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
sure how to get ack from ext4 developers.

Thanks
Vivek

> ---
>  fs/dax.c            |    8 +-------
>  fs/ext2/inode.c     |    5 +++--
>  fs/ext4/inode.c     |    2 +-
>  fs/xfs/xfs_aops.c   |    2 +-
>  include/linux/dax.h |    4 ++--
>  5 files changed, 8 insertions(+), 13 deletions(-)
> 
> Index: rhvgoyal-linux-fuse/fs/dax.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/dax.c	2019-08-26 16:45:26.093710196 -0400
> +++ rhvgoyal-linux-fuse/fs/dax.c	2019-08-26 16:45:29.462710196 -0400
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
> --- rhvgoyal-linux-fuse.orig/include/linux/dax.h	2019-08-26 16:45:26.094710196 -0400
> +++ rhvgoyal-linux-fuse/include/linux/dax.h	2019-08-26 16:46:08.101710196 -0400
> @@ -141,7 +141,7 @@ static inline void fs_put_dax(struct dax
>  
>  struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
>  int dax_writeback_mapping_range(struct address_space *mapping,
> -		struct block_device *bdev, struct writeback_control *wbc);
> +		struct dax_device *dax_dev, struct writeback_control *wbc);
>  
>  struct page *dax_layout_busy_page(struct address_space *mapping);
>  dax_entry_t dax_lock_page(struct page *page);
> @@ -180,7 +180,7 @@ static inline struct page *dax_layout_bu
>  }
>  
>  static inline int dax_writeback_mapping_range(struct address_space *mapping,
> -		struct block_device *bdev, struct writeback_control *wbc)
> +		struct dax_device *dax_dev, struct writeback_control *wbc)
>  {
>  	return -EOPNOTSUPP;
>  }
> Index: rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c
> ===================================================================
> --- rhvgoyal-linux-fuse.orig/fs/xfs/xfs_aops.c	2019-08-26 16:45:26.094710196 -0400
> +++ rhvgoyal-linux-fuse/fs/xfs/xfs_aops.c	2019-08-26 16:45:29.471710196 -0400
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
> --- rhvgoyal-linux-fuse.orig/fs/ext4/inode.c	2019-08-26 16:45:26.093710196 -0400
> +++ rhvgoyal-linux-fuse/fs/ext4/inode.c	2019-08-26 16:45:29.475710196 -0400
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
> --- rhvgoyal-linux-fuse.orig/fs/ext2/inode.c	2019-08-26 16:45:26.093710196 -0400
> +++ rhvgoyal-linux-fuse/fs/ext2/inode.c	2019-08-26 16:45:29.477710196 -0400
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

