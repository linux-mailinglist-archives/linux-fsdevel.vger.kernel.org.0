Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9842E0AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhJNSCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 14:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233764AbhJNSCb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 218CB61056;
        Thu, 14 Oct 2021 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634234426;
        bh=kNjkeDBzuQfKoxHXcqV0S2llnADIp119vN6i/9sLhI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+2O+xStpmBdi2GvmMWeubjNCIO1twn71R2X9fWluUEAyGo3Si35GkyuwT73m2Cj2
         djRXu/apHaUwV+JT5JfphXPS0aquut7uuFllJdLigvBAOVyJdZohTpOK7tIT44xFgi
         HnWZYT1YZHjyH1cVLcEs0yQw31IexSnUHC+tvGy9GusWytkK9TiJMaSGYnH2em7IsD
         7mybQ9s2WZ+TOb/8eX6OubU8D1O+0hnsmjrg3E4fP8UpIInWtMMnoh1iZIxAnSUs8/
         2xLgsR/+OBsMaJCsyvCOkYeihH9cghkssYwvRv0n67UwWs/GSck8bIDV5m2A1ukzXl
         kReRVmUiaL9VQ==
Date:   Thu, 14 Oct 2021 11:00:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v7 2/8] dax: Introduce holder for dax_device
Message-ID: <20211014180025.GC24333@magnolia>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:53PM +0800, Shiyang Ruan wrote:
> To easily track filesystem from a pmem device, we introduce a holder for
> dax_device structure, and also its operation.  This holder is used to
> remember who is using this dax_device:
>  - When it is the backend of a filesystem, the holder will be the
>    superblock of this filesystem.
>  - When this pmem device is one of the targets in a mapped device, the
>    holder will be this mapped device.  In this case, the mapped device
>    has its own dax_device and it will follow the first rule.  So that we
>    can finally track to the filesystem we needed.
> 
> The holder and holder_ops will be set when filesystem is being mounted,
> or an target device is being activated.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dax.h | 29 ++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 48ce86501d93..7d4a11dcba90 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -23,7 +23,10 @@
>   * @cdev: optional character interface for "device dax"
>   * @host: optional name for lookups where the device path is not available
>   * @private: dax driver private data
> + * @holder_data: holder of a dax_device: could be filesystem or mapped device
>   * @flags: state and boolean properties
> + * @ops: operations for dax_device
> + * @holder_ops: operations for the inner holder
>   */
>  struct dax_device {
>  	struct hlist_node list;
> @@ -31,8 +34,10 @@ struct dax_device {
>  	struct cdev cdev;
>  	const char *host;
>  	void *private;
> +	void *holder_data;
>  	unsigned long flags;
>  	const struct dax_operations *ops;
> +	const struct dax_holder_operations *holder_ops;
>  };
>  
>  static dev_t dax_devt;
> @@ -374,6 +379,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  }
>  EXPORT_SYMBOL_GPL(dax_zero_page_range);
>  
> +int dax_holder_notify_failure(struct dax_device *dax_dev, loff_t offset,
> +			      size_t size, int flags)
> +{
> +	int rc;
> +
> +	dax_read_lock();
> +	if (!dax_alive(dax_dev)) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	if (!dax_dev->holder_data) {
> +		rc = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	rc = dax_dev->holder_ops->notify_failure(dax_dev, offset, size, flags);

Shouldn't this check if dax_dev->holder_ops != NULL before dereferencing
it for the function call?  Imagine an implementation that wants to
attach a ->notify_failure function to a dax_device, maintains its own
lookup table, and decides that it doesn't need to set holder_data.

(Or, imagine someone who writes a garbage into holder_data and *boom*)

How does the locking work here?  If there's a media failure, we'll take
dax_rwsem and call ->notify_failure.  If the ->notify_failure function
wants to access the pmem to handle the error by calling back into the
dax code, will that cause nested locking on dax_rwsem?

Jumping ahead a bit, I think the rmap btree accesses that the xfs
implementation performs can cause xfs_buf(fer) cache IO, which would
trigger that if the buffers aren't already in memory, if I'm reading
this correctly?

> +out:
> +	dax_read_unlock();
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
> +
>  #ifdef CONFIG_ARCH_HAS_PMEM_API
>  void arch_wb_cache_pmem(void *addr, size_t size);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> @@ -618,6 +646,37 @@ void put_dax(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(put_dax);
>  
> +void dax_set_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops)
> +{
> +	dax_write_lock();
> +	if (!dax_alive(dax_dev)) {
> +		dax_write_unlock();
> +		return;
> +	}
> +
> +	dax_dev->holder_data = holder;
> +	dax_dev->holder_ops = ops;
> +	dax_write_unlock();

I guess this means that the holder has to detach itself before anyone
calls kill_dax, or else a dead dax device ends up with a dangling
reference to the holder?

> +}
> +EXPORT_SYMBOL_GPL(dax_set_holder);
> +
> +void *dax_get_holder(struct dax_device *dax_dev)
> +{
> +	void *holder;
> +
> +	dax_read_lock();
> +	if (!dax_alive(dax_dev)) {
> +		dax_read_unlock();
> +		return NULL;
> +	}
> +
> +	holder = dax_dev->holder_data;
> +	dax_read_unlock();
> +	return holder;
> +}
> +EXPORT_SYMBOL_GPL(dax_get_holder);
> +
>  /**
>   * inode_dax: convert a public inode into its dax_dev
>   * @inode: An inode with i_cdev pointing to a dax_dev
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 097b3304f9b9..d273d59723cd 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -38,9 +38,24 @@ struct dax_operations {
>  	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>  };
>  
> +struct dax_holder_operations {
> +	/*
> +	 * notify_failure - notify memory failure into inner holder device
> +	 * @dax_dev: the dax device which contains the holder
> +	 * @offset: offset on this dax device where memory failure occurs
> +	 * @size: length of this memory failure event
> +	 * @flags: action flags for memory failure handler
> +	 */
> +	int (*notify_failure)(struct dax_device *dax_dev, loff_t offset,
> +			size_t size, int flags);

Shouldn't size be u64 or something?  Let's say that 8GB of your pmem go
bad, wouldn't you want a single call?  Though I guess the current
implementation only goes a single page at a time, doesn't it?

> +};
> +
>  extern struct attribute_group dax_attribute_group;
>  
>  #if IS_ENABLED(CONFIG_DAX)
> +void dax_set_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops);
> +void *dax_get_holder(struct dax_device *dax_dev);
>  struct dax_device *alloc_dax(void *private, const char *host,
>  		const struct dax_operations *ops, unsigned long flags);
>  void put_dax(struct dax_device *dax_dev);
> @@ -70,6 +85,18 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  	return dax_synchronous(dax_dev);
>  }
>  #else
> +static inline struct dax_device *dax_get_by_host(const char *host)

Not sure why this is being added here?  AFAICT none of the patches call
this function...?

--D

> +{
> +	return NULL;
> +}
> +static inline void dax_set_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops)
> +{
> +}
> +static inline void *dax_get_holder(struct dax_device *dax_dev)
> +{
> +	return NULL;
> +}
>  static inline struct dax_device *alloc_dax(void *private, const char *host,
>  		const struct dax_operations *ops, unsigned long flags)
>  {
> @@ -198,6 +225,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  		size_t bytes, struct iov_iter *i);
>  int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  			size_t nr_pages);
> +int dax_holder_notify_failure(struct dax_device *dax_dev, loff_t offset,
> +		size_t size, int flags);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
>  
>  ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> -- 
> 2.33.0
> 
> 
> 
