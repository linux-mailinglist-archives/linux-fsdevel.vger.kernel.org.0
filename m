Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6191C4857FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 19:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbiAESMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 13:12:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38654 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiAESMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:12:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319E76186E;
        Wed,  5 Jan 2022 18:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A1BC36AE0;
        Wed,  5 Jan 2022 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641406350;
        bh=1171XJwm1v/PulkFnAieJP983+An49f4YwMoJU08ZfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWn/JuTGixcFXT48t84+1b4oKeUMJWE+/eNez7UjXuQo48HXoQ836yzTuko5QN9LI
         62G1DC6hUtta2Q7rpOxWImksLXPwkzrBrYS6WhO+HC0/f6I7QdmBx+qtM6LFtiNzlW
         sSfSv6OXfGJc3oGSPqHK6OMk5SWhEVIeGygz/VBBYcYktH2mDxxDANWAk5xEeYKZIp
         EP7osuMcpT+TKgUFzBXOCzCpXzQI9sjKz2HZxpmOLjBcMsn3C+GS9T58AfNhPoB5NG
         Vs6BnLTxzjvQ4W323hvKdhY11ZU8caQCNDIrtDUiQsoMeqbs6olGT5AIeGiK7aMuIk
         HbVoI0B/j5shA==
Date:   Wed, 5 Jan 2022 10:12:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
Message-ID: <20220105181230.GC398655@magnolia>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226143439.3985960-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:34:31PM +0800, Shiyang Ruan wrote:
> To easily track filesystem from a pmem device, we introduce a holder for
> dax_device structure, and also its operation.  This holder is used to
> remember who is using this dax_device:
>  - When it is the backend of a filesystem, the holder will be the
>    instance of this filesystem.
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
>  drivers/dax/super.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dax.h | 29 +++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c46f56e33d40..94c51f2ee133 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -20,15 +20,20 @@
>   * @inode: core vfs
>   * @cdev: optional character interface for "device dax"
>   * @private: dax driver private data
> + * @holder_data: holder of a dax_device: could be filesystem or mapped device
>   * @flags: state and boolean properties
> + * @ops: operations for dax_device
> + * @holder_ops: operations for the inner holder
>   */
>  struct dax_device {
>  	struct inode inode;
>  	struct cdev cdev;
>  	void *private;
>  	struct percpu_rw_semaphore rwsem;
> +	void *holder_data;
>  	unsigned long flags;
>  	const struct dax_operations *ops;
> +	const struct dax_holder_operations *holder_ops;
>  };
>  
>  static dev_t dax_devt;
> @@ -192,6 +197,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  }
>  EXPORT_SYMBOL_GPL(dax_zero_page_range);
>  
> +int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
> +			      u64 len, int mf_flags)
> +{
> +	int rc;
> +
> +	dax_read_lock(dax_dev);
> +	if (!dax_alive(dax_dev)) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	if (!dax_dev->holder_ops) {
> +		rc = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
> +out:
> +	dax_read_unlock(dax_dev);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
> +
>  #ifdef CONFIG_ARCH_HAS_PMEM_API
>  void arch_wb_cache_pmem(void *addr, size_t size);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> @@ -254,6 +282,10 @@ void kill_dax(struct dax_device *dax_dev)
>  		return;
>  	dax_write_lock(dax_dev);
>  	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> +
> +	/* clear holder data */
> +	dax_dev->holder_ops = NULL;
> +	dax_dev->holder_data = NULL;
>  	dax_write_unlock(dax_dev);
>  }
>  EXPORT_SYMBOL_GPL(kill_dax);
> @@ -401,6 +433,36 @@ void put_dax(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(put_dax);
>  
> +void dax_register_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops)
> +{
> +	if (!dax_alive(dax_dev))
> +		return;
> +
> +	dax_dev->holder_data = holder;
> +	dax_dev->holder_ops = ops;

Shouldn't this return an error code if the dax device is dead or if
someone already registered a holder?  I'm pretty sure XFS should not
bind to a dax device if someone else already registered for it...

...unless you want to use a notifier chain for failure events so that
there can be multiple consumers of dax failure events?

--D

> +}
> +EXPORT_SYMBOL_GPL(dax_register_holder);
> +
> +void dax_unregister_holder(struct dax_device *dax_dev)
> +{
> +	if (!dax_alive(dax_dev))
> +		return;
> +
> +	dax_dev->holder_data = NULL;
> +	dax_dev->holder_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(dax_unregister_holder);
> +
> +void *dax_get_holder(struct dax_device *dax_dev)
> +{
> +	if (!dax_alive(dax_dev))
> +		return NULL;
> +
> +	return dax_dev->holder_data;
> +}
> +EXPORT_SYMBOL_GPL(dax_get_holder);
> +
>  /**
>   * inode_dax: convert a public inode into its dax_dev
>   * @inode: An inode with i_cdev pointing to a dax_dev
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index a146bfb80804..e16a9e0ee857 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -44,6 +44,22 @@ struct dax_operations {
>  #if IS_ENABLED(CONFIG_DAX)
>  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops,
>  		unsigned long flags);
> +struct dax_holder_operations {
> +	/*
> +	 * notify_failure - notify memory failure into inner holder device
> +	 * @dax_dev: the dax device which contains the holder
> +	 * @offset: offset on this dax device where memory failure occurs
> +	 * @len: length of this memory failure event
> +	 * @flags: action flags for memory failure handler
> +	 */
> +	int (*notify_failure)(struct dax_device *dax_dev, u64 offset,
> +			u64 len, int mf_flags);
> +};
> +
> +void dax_register_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops);
> +void dax_unregister_holder(struct dax_device *dax_dev);
> +void *dax_get_holder(struct dax_device *dax_dev);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
> @@ -71,6 +87,17 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  	return dax_synchronous(dax_dev);
>  }
>  #else
> +static inline void dax_register_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops)
> +{
> +}
> +static inline void dax_unregister_holder(struct dax_device *dax_dev)
> +{
> +}
> +static inline void *dax_get_holder(struct dax_device *dax_dev)
> +{
> +	return NULL;
> +}
>  static inline struct dax_device *alloc_dax(void *private,
>  		const struct dax_operations *ops, unsigned long flags)
>  {
> @@ -209,6 +236,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  		size_t bytes, struct iov_iter *i);
>  int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  			size_t nr_pages);
> +int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
> +		int mf_flags);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
>  
>  ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> -- 
> 2.34.1
> 
> 
> 
