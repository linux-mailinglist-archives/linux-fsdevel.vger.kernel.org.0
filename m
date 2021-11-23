Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123B645AFDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhKWXQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233989AbhKWXQO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:16:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89AA960F9F;
        Tue, 23 Nov 2021 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637709185;
        bh=qI8k8SWcfOTf0dPmRhxg9uqxHXWp63uAbeW4/0Ozc7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzacBFBFhYh1FXrg7vX6C+KOP1OJxBbbaxlskfiRzRHZEcu+QVgT6TLPVe1C3qHil
         8w6H7EupDtAbvwL+YhPe1535bL7h0UBuS4dO0iEFrkQouRhqGT1M5iu0zTIt84UP35
         UJ8kQ0pSgv51CTWUeTa9oG2ShGEe8lGowjb1HLniNGys8CsRX+qESFdCphOZxlg8Nh
         SDWcaD/73OkeMq4lrTWsV3ChlvtjYmqSu0CE2EZvGeLbKpkBTx+DjBLn7sVm+YvSXb
         F0vt8O+an8SwKPzp9UrOyY70tBZndLxDC6VVIAk3CrRX19qSMcWPlKcStgHi/ulFjZ
         gJy9vInPH0O9g==
Date:   Tue, 23 Nov 2021 15:13:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 27/29] dax: fix up some of the block device related ifdefs
Message-ID: <20211123231305.GU266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-28-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:33:07AM +0100, Christoph Hellwig wrote:
> The DAX device <-> block device association is only enabled if
> CONFIG_BLOCK is enabled.  Update dax.h to account for that and use
> the right conditions for the fs_put_dax stub as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/dax.h | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 90f95deff504d..5568d3dca941b 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -108,28 +108,15 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  #endif
>  
>  struct writeback_control;
> -#if IS_ENABLED(CONFIG_FS_DAX)
> +#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
>  int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
>  void dax_remove_host(struct gendisk *disk);
> -
> +struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
> +		u64 *start_off);
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
>  	put_dax(dax_dev);
>  }
> -
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
> -		u64 *start_off);
> -int dax_writeback_mapping_range(struct address_space *mapping,
> -		struct dax_device *dax_dev, struct writeback_control *wbc);
> -
> -struct page *dax_layout_busy_page(struct address_space *mapping);
> -struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> -dax_entry_t dax_lock_page(struct page *page);
> -void dax_unlock_page(struct page *page, dax_entry_t cookie);
> -int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> -		const struct iomap_ops *ops);
> -int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops);
>  #else
>  static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  {
> @@ -138,17 +125,29 @@ static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  static inline void dax_remove_host(struct gendisk *disk)
>  {
>  }
> -
> -static inline void fs_put_dax(struct dax_device *dax_dev)
> -{
> -}
> -
>  static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
>  		u64 *start_off)
>  {
>  	return NULL;
>  }
> +static inline void fs_put_dax(struct dax_device *dax_dev)
> +{
> +}
> +#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> +
> +#if IS_ENABLED(CONFIG_FS_DAX)
> +int dax_writeback_mapping_range(struct address_space *mapping,
> +		struct dax_device *dax_dev, struct writeback_control *wbc);
>  
> +struct page *dax_layout_busy_page(struct address_space *mapping);
> +struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> +dax_entry_t dax_lock_page(struct page *page);
> +void dax_unlock_page(struct page *page, dax_entry_t cookie);
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +		const struct iomap_ops *ops);
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +		const struct iomap_ops *ops);
> +#else
>  static inline struct page *dax_layout_busy_page(struct address_space *mapping)
>  {
>  	return NULL;
> -- 
> 2.30.2
> 
