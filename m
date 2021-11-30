Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C319463CC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 18:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244858AbhK3RbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 12:31:02 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52326 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244804AbhK3RaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:30:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4DEC6CE1A96;
        Tue, 30 Nov 2021 17:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698F9C53FC1;
        Tue, 30 Nov 2021 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638293197;
        bh=BMG4z10Kn+4IsBnm0eMRsV0qjHiN0yQ30zDqbBy45SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNtLoYDY2zHtXbW7e9UQt9r80pIhCvB+EQzY2o7of+YWnfcOK4MYRcb2KtOQ+hjzc
         QWqWVxm6s+B1XWsdG1z4li4cve6WfhsS9kQdh0j8NjeMZIJIAJtyMbWFuqyjsfTMwU
         gEvC/UJ38a2NUjmDdRsprA6KFnpNAeyJzkiwRjrEFGVJbVTgarZrAk1ShyIUfwhV3I
         Jr2TX4J1lNr8G4q9yrjKraUEMRFgu3+8VrrzWCeJrMkjv2MQ06tfR0EP9WMOWB6izB
         j7ZObSOK4eSJ5ewSukvjrEuh2qW7bMGBnjpcwDz/Q7OYh+t+ILVcujeRwHG4b6jRxL
         jKmLZL0ruYLqQ==
Date:   Tue, 30 Nov 2021 09:26:36 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 04/29] dax: simplify the dax_device <-> gendisk
 association
Message-ID: <20211130172636.GC8467@magnolia>
References: <20211129102203.2243509-1-hch@lst.de>
 <20211129102203.2243509-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129102203.2243509-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:21:38AM +0100, Christoph Hellwig wrote:
> Replace the dax_host_hash with an xarray indexed by the pointer value
> of the gendisk, and require explicitly calls from the block drivers that
> want to associate their gendisk with a dax_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Nice cleanup from the fs side!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  drivers/dax/bus.c            |   6 +-
>  drivers/dax/super.c          | 109 +++++++++--------------------------
>  drivers/md/dm.c              |   6 +-
>  drivers/nvdimm/pmem.c        |  10 +++-
>  drivers/s390/block/dcssblk.c |  11 +++-
>  fs/fuse/virtio_fs.c          |   2 +-
>  include/linux/dax.h          |  19 ++++--
>  7 files changed, 66 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 6cc4da4c713d9..bd7af2f7c5b0a 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1323,10 +1323,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  	}
>  
>  	/*
> -	 * No 'host' or dax_operations since there is no access to this
> -	 * device outside of mmap of the resulting character device.
> +	 * No dax_operations since there is no access to this device outside of
> +	 * mmap of the resulting character device.
>  	 */
> -	dax_dev = alloc_dax(dev_dax, NULL, NULL, DAXDEV_F_SYNC);
> +	dax_dev = alloc_dax(dev_dax, NULL, DAXDEV_F_SYNC);
>  	if (IS_ERR(dax_dev)) {
>  		rc = PTR_ERR(dax_dev);
>  		goto err_alloc_dax;
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e20d0cef10a18..bf77c3da5d56d 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -7,10 +7,8 @@
>  #include <linux/mount.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/magic.h>
> -#include <linux/genhd.h>
>  #include <linux/pfn_t.h>
>  #include <linux/cdev.h>
> -#include <linux/hash.h>
>  #include <linux/slab.h>
>  #include <linux/uio.h>
>  #include <linux/dax.h>
> @@ -21,15 +19,12 @@
>   * struct dax_device - anchor object for dax services
>   * @inode: core vfs
>   * @cdev: optional character interface for "device dax"
> - * @host: optional name for lookups where the device path is not available
>   * @private: dax driver private data
>   * @flags: state and boolean properties
>   */
>  struct dax_device {
> -	struct hlist_node list;
>  	struct inode inode;
>  	struct cdev cdev;
> -	const char *host;
>  	void *private;
>  	unsigned long flags;
>  	const struct dax_operations *ops;
> @@ -42,10 +37,6 @@ static DEFINE_IDA(dax_minor_ida);
>  static struct kmem_cache *dax_cache __read_mostly;
>  static struct super_block *dax_superblock __read_mostly;
>  
> -#define DAX_HASH_SIZE (PAGE_SIZE / sizeof(struct hlist_head))
> -static struct hlist_head dax_host_list[DAX_HASH_SIZE];
> -static DEFINE_SPINLOCK(dax_host_lock);
> -
>  int dax_read_lock(void)
>  {
>  	return srcu_read_lock(&dax_srcu);
> @@ -58,13 +49,22 @@ void dax_read_unlock(int id)
>  }
>  EXPORT_SYMBOL_GPL(dax_read_unlock);
>  
> -static int dax_host_hash(const char *host)
> +#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
> +#include <linux/blkdev.h>
> +
> +static DEFINE_XARRAY(dax_hosts);
> +
> +int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  {
> -	return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
> +	return xa_insert(&dax_hosts, (unsigned long)disk, dax_dev, GFP_KERNEL);
>  }
> +EXPORT_SYMBOL_GPL(dax_add_host);
>  
> -#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
> -#include <linux/blkdev.h>
> +void dax_remove_host(struct gendisk *disk)
> +{
> +	xa_erase(&dax_hosts, (unsigned long)disk);
> +}
> +EXPORT_SYMBOL_GPL(dax_remove_host);
>  
>  int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  		pgoff_t *pgoff)
> @@ -81,41 +81,24 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  EXPORT_SYMBOL(bdev_dax_pgoff);
>  
>  /**
> - * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
> - * @host: alternate name for the device registered by a dax driver
> + * fs_dax_get_by_bdev() - temporary lookup mechanism for filesystem-dax
> + * @bdev: block device to find a dax_device for
>   */
> -static struct dax_device *dax_get_by_host(const char *host)
> +struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>  {
> -	struct dax_device *dax_dev, *found = NULL;
> -	int hash, id;
> +	struct dax_device *dax_dev;
> +	int id;
>  
> -	if (!host)
> +	if (!blk_queue_dax(bdev->bd_disk->queue))
>  		return NULL;
>  
> -	hash = dax_host_hash(host);
> -
>  	id = dax_read_lock();
> -	spin_lock(&dax_host_lock);
> -	hlist_for_each_entry(dax_dev, &dax_host_list[hash], list) {
> -		if (!dax_alive(dax_dev)
> -				|| strcmp(host, dax_dev->host) != 0)
> -			continue;
> -
> -		if (igrab(&dax_dev->inode))
> -			found = dax_dev;
> -		break;
> -	}
> -	spin_unlock(&dax_host_lock);
> +	dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
> +	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
> +		dax_dev = NULL;
>  	dax_read_unlock(id);
>  
> -	return found;
> -}
> -
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> -{
> -	if (!blk_queue_dax(bdev->bd_disk->queue))
> -		return NULL;
> -	return dax_get_by_host(bdev->bd_disk->disk_name);
> +	return dax_dev;
>  }
>  EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
>  
> @@ -361,12 +344,7 @@ void kill_dax(struct dax_device *dax_dev)
>  		return;
>  
>  	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> -
>  	synchronize_srcu(&dax_srcu);
> -
> -	spin_lock(&dax_host_lock);
> -	hlist_del_init(&dax_dev->list);
> -	spin_unlock(&dax_host_lock);
>  }
>  EXPORT_SYMBOL_GPL(kill_dax);
>  
> @@ -398,8 +376,6 @@ static struct dax_device *to_dax_dev(struct inode *inode)
>  static void dax_free_inode(struct inode *inode)
>  {
>  	struct dax_device *dax_dev = to_dax_dev(inode);
> -	kfree(dax_dev->host);
> -	dax_dev->host = NULL;
>  	if (inode->i_rdev)
>  		ida_simple_remove(&dax_minor_ida, iminor(inode));
>  	kmem_cache_free(dax_cache, dax_dev);
> @@ -474,54 +450,25 @@ static struct dax_device *dax_dev_get(dev_t devt)
>  	return dax_dev;
>  }
>  
> -static void dax_add_host(struct dax_device *dax_dev, const char *host)
> -{
> -	int hash;
> -
> -	/*
> -	 * Unconditionally init dax_dev since it's coming from a
> -	 * non-zeroed slab cache
> -	 */
> -	INIT_HLIST_NODE(&dax_dev->list);
> -	dax_dev->host = host;
> -	if (!host)
> -		return;
> -
> -	hash = dax_host_hash(host);
> -	spin_lock(&dax_host_lock);
> -	hlist_add_head(&dax_dev->list, &dax_host_list[hash]);
> -	spin_unlock(&dax_host_lock);
> -}
> -
> -struct dax_device *alloc_dax(void *private, const char *__host,
> -		const struct dax_operations *ops, unsigned long flags)
> +struct dax_device *alloc_dax(void *private, const struct dax_operations *ops,
> +		unsigned long flags)
>  {
>  	struct dax_device *dax_dev;
> -	const char *host;
>  	dev_t devt;
>  	int minor;
>  
> -	if (ops && !ops->zero_page_range) {
> -		pr_debug("%s: error: device does not provide dax"
> -			 " operation zero_page_range()\n",
> -			 __host ? __host : "Unknown");
> +	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
>  		return ERR_PTR(-EINVAL);
> -	}
> -
> -	host = kstrdup(__host, GFP_KERNEL);
> -	if (__host && !host)
> -		return ERR_PTR(-ENOMEM);
>  
>  	minor = ida_simple_get(&dax_minor_ida, 0, MINORMASK+1, GFP_KERNEL);
>  	if (minor < 0)
> -		goto err_minor;
> +		return ERR_PTR(-ENOMEM);
>  
>  	devt = MKDEV(MAJOR(dax_devt), minor);
>  	dax_dev = dax_dev_get(devt);
>  	if (!dax_dev)
>  		goto err_dev;
>  
> -	dax_add_host(dax_dev, host);
>  	dax_dev->ops = ops;
>  	dax_dev->private = private;
>  	if (flags & DAXDEV_F_SYNC)
> @@ -531,8 +478,6 @@ struct dax_device *alloc_dax(void *private, const char *__host,
>  
>   err_dev:
>  	ida_simple_remove(&dax_minor_ida, minor);
> - err_minor:
> -	kfree(host);
>  	return ERR_PTR(-ENOMEM);
>  }
>  EXPORT_SYMBOL_GPL(alloc_dax);
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index b93fcc91176e5..a8c650276b321 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1683,6 +1683,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  	bioset_exit(&md->io_bs);
>  
>  	if (md->dax_dev) {
> +		dax_remove_host(md->disk);
>  		kill_dax(md->dax_dev);
>  		put_dax(md->dax_dev);
>  		md->dax_dev = NULL;
> @@ -1784,12 +1785,13 @@ static struct mapped_device *alloc_dev(int minor)
>  	sprintf(md->disk->disk_name, "dm-%d", minor);
>  
>  	if (IS_ENABLED(CONFIG_FS_DAX)) {
> -		md->dax_dev = alloc_dax(md, md->disk->disk_name,
> -					&dm_dax_ops, 0);
> +		md->dax_dev = alloc_dax(md, &dm_dax_ops, 0);
>  		if (IS_ERR(md->dax_dev)) {
>  			md->dax_dev = NULL;
>  			goto bad;
>  		}
> +		if (dax_add_host(md->dax_dev, md->disk))
> +			goto bad;
>  	}
>  
>  	format_dev_t(md->name, MKDEV(_major, minor));
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index fe7ece1534e1e..1018f0d44acb8 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -379,6 +379,7 @@ static void pmem_release_disk(void *__pmem)
>  {
>  	struct pmem_device *pmem = __pmem;
>  
> +	dax_remove_host(pmem->disk);
>  	kill_dax(pmem->dax_dev);
>  	put_dax(pmem->dax_dev);
>  	del_gendisk(pmem->disk);
> @@ -497,17 +498,20 @@ static int pmem_attach_disk(struct device *dev,
>  
>  	if (is_nvdimm_sync(nd_region))
>  		flags = DAXDEV_F_SYNC;
> -	dax_dev = alloc_dax(pmem, disk->disk_name, &pmem_dax_ops, flags);
> +	dax_dev = alloc_dax(pmem, &pmem_dax_ops, flags);
>  	if (IS_ERR(dax_dev)) {
>  		rc = PTR_ERR(dax_dev);
>  		goto out;
>  	}
> +	rc = dax_add_host(dax_dev, disk);
> +	if (rc)
> +		goto out_cleanup_dax;
>  	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
>  	pmem->dax_dev = dax_dev;
>  
>  	rc = device_add_disk(dev, disk, pmem_attribute_groups);
>  	if (rc)
> -		goto out_cleanup_dax;
> +		goto out_remove_host;
>  	if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
>  		return -ENOMEM;
>  
> @@ -519,6 +523,8 @@ static int pmem_attach_disk(struct device *dev,
>  		dev_warn(dev, "'badblocks' notification disabled\n");
>  	return 0;
>  
> +out_remove_host:
> +	dax_remove_host(pmem->disk);
>  out_cleanup_dax:
>  	kill_dax(pmem->dax_dev);
>  	put_dax(pmem->dax_dev);
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 27ab888b44d0a..657e492f2bc26 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -687,18 +687,21 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>  	if (rc)
>  		goto put_dev;
>  
> -	dev_info->dax_dev = alloc_dax(dev_info, dev_info->gd->disk_name,
> -			&dcssblk_dax_ops, DAXDEV_F_SYNC);
> +	dev_info->dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops,
> +			DAXDEV_F_SYNC);
>  	if (IS_ERR(dev_info->dax_dev)) {
>  		rc = PTR_ERR(dev_info->dax_dev);
>  		dev_info->dax_dev = NULL;
>  		goto put_dev;
>  	}
> +	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
> +	if (rc)
> +		goto out_dax;
>  
>  	get_device(&dev_info->dev);
>  	rc = device_add_disk(&dev_info->dev, dev_info->gd, NULL);
>  	if (rc)
> -		goto out_dax;
> +		goto out_dax_host;
>  
>  	switch (dev_info->segment_type) {
>  		case SEG_TYPE_SR:
> @@ -714,6 +717,8 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>  	rc = count;
>  	goto out;
>  
> +out_dax_host:
> +	dax_remove_host(dev_info->gd);
>  out_dax:
>  	put_device(&dev_info->dev);
>  	kill_dax(dev_info->dax_dev);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4cfa4bc1f5794..242cc1c0d7ed7 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -850,7 +850,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
>  		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
>  
> -	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops, 0);
> +	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops, 0);
>  	if (IS_ERR(fs->dax_dev))
>  		return PTR_ERR(fs->dax_dev);
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 8623caa673889..e2e9a67004cbd 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -11,9 +11,11 @@
>  
>  typedef unsigned long dax_entry_t;
>  
> +struct dax_device;
> +struct gendisk;
>  struct iomap_ops;
>  struct iomap;
> -struct dax_device;
> +
>  struct dax_operations {
>  	/*
>  	 * direct_access: translate a device-relative
> @@ -39,8 +41,8 @@ struct dax_operations {
>  };
>  
>  #if IS_ENABLED(CONFIG_DAX)
> -struct dax_device *alloc_dax(void *private, const char *host,
> -		const struct dax_operations *ops, unsigned long flags);
> +struct dax_device *alloc_dax(void *private, const struct dax_operations *ops,
> +		unsigned long flags);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
> @@ -68,7 +70,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  	return dax_synchronous(dax_dev);
>  }
>  #else
> -static inline struct dax_device *alloc_dax(void *private, const char *host,
> +static inline struct dax_device *alloc_dax(void *private,
>  		const struct dax_operations *ops, unsigned long flags)
>  {
>  	/*
> @@ -107,6 +109,8 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  struct writeback_control;
>  int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
>  #if IS_ENABLED(CONFIG_FS_DAX)
> +int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
> +void dax_remove_host(struct gendisk *disk);
>  bool generic_fsdax_supported(struct dax_device *dax_dev,
>  		struct block_device *bdev, int blocksize, sector_t start,
>  		sector_t sectors);
> @@ -128,6 +132,13 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t st
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
>  #else
> +static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
> +{
> +	return 0;
> +}
> +static inline void dax_remove_host(struct gendisk *disk)
> +{
> +}
>  #define generic_fsdax_supported		NULL
>  
>  static inline bool dax_supported(struct dax_device *dax_dev,
> -- 
> 2.30.2
> 
