Return-Path: <linux-fsdevel+bounces-77721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHToJHY1l2kCvwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:08:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E885E16082B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7A0301A381
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0834C140;
	Thu, 19 Feb 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0UhgStd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770602D3ECF;
	Thu, 19 Feb 2026 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517280; cv=none; b=lgGz85G+xG6l2SU/EBQjR255kEJRrFcY5qyE6bUq4S9cpQv4SAfquUAf/taF8WMIjRi7KaGQWI45K0rIIsnCG0Pp3WmQZxeJ3Il+k3v15yazv2/Cm/KXODxV0OKt4857PFkM+SjR6bP1Pg65YjZUP/Lh0aBFcQo5sB8g6nNB/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517280; c=relaxed/simple;
	bh=zlPqV4I0bErDRfP8a/M2jtQm4fY10/MZ0I7ZNyxtfzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo1GKCW+l9P8ur+GVxxCDLl2DAEdDgB7tVHsfmMx39p9PhAsmi0OBb3p6puQqMrkTfe64CuD0KVcJ2gaTumlf644wGobuuWColowpZ3qLhivLRyc7vjpK4odNpbfKCipaG+8FBppDknrGnU+jAjshyq6qXa1AhzSxnML+SK1CYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0UhgStd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771517278; x=1803053278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zlPqV4I0bErDRfP8a/M2jtQm4fY10/MZ0I7ZNyxtfzg=;
  b=b0UhgStdinbLr+68Fa9ktWEZNy33u9hrnFavFlelZBDP27Hm7qQlX4VQ
   VVWLjiEh5XsLh+hi92Kxm0RSiYkosSPCNyem2jL7e0D3a+YWrXj7UhRbW
   MhlQl8mVxblEGtLpmDpFnYEt0LBA+1jMri9g6VtacVWLFkK6p7G0Pzk5k
   vQyXk5UYRoSQfsq1Ea1wyGVAth390OD8MYkT3wqjxeCIj7fLpH2+plnn+
   9N60WIdrnxl8E3g1xc23uy1bYhj7o6NbTVC5EtJgGmPqgqap49/SCzxdc
   yumiCS55aSlZnrKp5AmG+Tvz/fs/eREGMWfh09+MUdHk3LNoktZlPf2bV
   w==;
X-CSE-ConnectionGUID: bRHb3rbpQ6qef80eHb/+eA==
X-CSE-MsgGUID: HVKLjGsfRa6k6aUnDHUBoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="98069411"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="98069411"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:07:57 -0800
X-CSE-ConnectionGUID: 6d2q8Js5Qcm5WNvx9MFPSg==
X-CSE-MsgGUID: oDWZHOUoQUONBagjlmy7rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219095070"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:07:55 -0800
Message-ID: <47780ff4-27ff-4e14-98cc-a10064d7fe13@intel.com>
Date: Thu, 19 Feb 2026 09:07:53 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 07/19] dax: Add fs_dax_get() func to prepare dax for
 fs-dax usage
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223206.92430-1-john@jagalactic.com>
 <0100019bd33cc18d-83012e03-8214-45a4-91cf-c8b598cd4535-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33cc18d-83012e03-8214-45a4-91cf-c8b598cd4535-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77721-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,groves.net:email]
X-Rspamd-Queue-Id: E885E16082B
X-Rspamd-Action: no action



On 1/18/26 3:32 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> The fs_dax_get() function should be called by fs-dax file systems after
> opening a fsdev dax device. This adds holder_operations, which provides
> a memory failure callback path and effects exclusivity between callers
> of fs_dax_get().
> 
> fs_dax_get() is specific to fsdev_dax, so it checks the driver type
> (which required touching bus.[ch]). fs_dax_get() fails if fsdev_dax is
> not bound to the memory.
> 
> This function serves the same role as fs_dax_get_by_bdev(), which dax
> file systems call after opening the pmem block device.
> 
> This can't be located in fsdev.c because struct dax_device is opaque
> there.
> 
> This will be called by fs/fuse/famfs.c in a subsequent commit.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/dax/bus.c   |  2 --
>  drivers/dax/bus.h   |  2 ++
>  drivers/dax/super.c | 58 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/dax.h | 20 ++++++++++------
>  4 files changed, 72 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index e79daf825b52..01402d5103ef 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -39,8 +39,6 @@ static int dax_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  	return add_uevent_var(env, "MODALIAS=" DAX_DEVICE_MODALIAS_FMT, 0);
>  }
>  
> -#define to_dax_drv(__drv)	container_of_const(__drv, struct dax_device_driver, drv)
> -
>  static struct dax_id *__dax_match_id(const struct dax_device_driver *dax_drv,
>  		const char *dev_name)
>  {
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 880bdf7e72d7..dc6f112ac4a4 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -42,6 +42,8 @@ struct dax_device_driver {
>  	void (*remove)(struct dev_dax *dev);
>  };
>  
> +#define to_dax_drv(__drv) container_of_const(__drv, struct dax_device_driver, drv)
> +
>  int __dax_driver_register(struct dax_device_driver *dax_drv,
>  		struct module *module, const char *mod_name);
>  #define dax_driver_register(driver) \
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index ba0b4cd18a77..00c330ef437c 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -14,6 +14,7 @@
>  #include <linux/fs.h>
>  #include <linux/cacheinfo.h>
>  #include "dax-private.h"
> +#include "bus.h"
>  
>  /**
>   * struct dax_device - anchor object for dax services
> @@ -111,6 +112,10 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off,
>  }
>  EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
>  
> +#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> +
> +#if IS_ENABLED(CONFIG_FS_DAX)
> +
>  void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  {
>  	if (dax_dev && holder &&
> @@ -119,7 +124,58 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  	put_dax(dax_dev);
>  }
>  EXPORT_SYMBOL_GPL(fs_put_dax);
> -#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> +
> +/**
> + * fs_dax_get() - get ownership of a devdax via holder/holder_ops
> + *
> + * fs-dax file systems call this function to prepare to use a devdax device for
> + * fsdax. This is like fs_dax_get_by_bdev(), but the caller already has struct
> + * dev_dax (and there is no bdev). The holder makes this exclusive.
> + *
> + * @dax_dev: dev to be prepared for fs-dax usage
> + * @holder: filesystem or mapped device inside the dax_device
> + * @hops: operations for the inner holder
> + *
> + * Returns: 0 on success, <0 on failure
> + */
> +int fs_dax_get(struct dax_device *dax_dev, void *holder,
> +	const struct dax_holder_operations *hops)
> +{
> +	struct dev_dax *dev_dax;
> +	struct dax_device_driver *dax_drv;
> +	int id;
> +
> +	id = dax_read_lock();
> +	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode)) {
> +		dax_read_unlock(id);
> +		return -ENODEV;
> +	}
> +	dax_read_unlock(id);
> +
> +	/* Verify the device is bound to fsdev_dax driver */
> +	dev_dax = dax_get_private(dax_dev);
> +	if (!dev_dax || !dev_dax->dev.driver) {

Don't you need to hold the dev_dax->dev device lock in order to check the driver?

DJ

> +		iput(&dax_dev->inode);
> +		return -ENODEV;
> +	}
> +
> +	dax_drv = to_dax_drv(dev_dax->dev.driver);
> +	if (dax_drv->type != DAXDRV_FSDEV_TYPE) {
> +		iput(&dax_dev->inode);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (cmpxchg(&dax_dev->holder_data, NULL, holder)) {
> +		iput(&dax_dev->inode);
> +		return -EBUSY;
> +	}
> +
> +	dax_dev->holder_ops = hops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_get);
> +#endif /* CONFIG_FS_DAX */
>  
>  enum dax_device_flags {
>  	/* !alive + rcu grace period == no new operations / mappings */
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 5aaaca135737..6897c5736543 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -52,9 +52,6 @@ struct dax_holder_operations {
>  #if IS_ENABLED(CONFIG_DAX)
>  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
>  
> -#if IS_ENABLED(CONFIG_DEV_DAX_FS)
> -struct dax_device *inode_dax(struct inode *inode);
> -#endif
>  void *dax_holder(struct dax_device *dax_dev);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
> @@ -134,7 +131,6 @@ int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
>  void dax_remove_host(struct gendisk *disk);
>  struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off,
>  		void *holder, const struct dax_holder_operations *ops);
> -void fs_put_dax(struct dax_device *dax_dev, void *holder);
>  #else
>  static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  {
> @@ -149,12 +145,13 @@ static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
>  {
>  	return NULL;
>  }
> -static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
> -{
> -}
>  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
>  
>  #if IS_ENABLED(CONFIG_FS_DAX)
> +void fs_put_dax(struct dax_device *dax_dev, void *holder);
> +int fs_dax_get(struct dax_device *dax_dev, void *holder,
> +	       const struct dax_holder_operations *hops);
> +struct dax_device *inode_dax(struct inode *inode);
>  int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct dax_device *dax_dev, struct writeback_control *wbc);
>  int dax_folio_reset_order(struct folio *folio);
> @@ -168,6 +165,15 @@ dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
>  void dax_unlock_mapping_entry(struct address_space *mapping,
>  		unsigned long index, dax_entry_t cookie);
>  #else
> +static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
> +{
> +}
> +
> +static inline int fs_dax_get(struct dax_device *dax_dev, void *holder,
> +			     const struct dax_holder_operations *hops)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline struct page *dax_layout_busy_page(struct address_space *mapping)
>  {
>  	return NULL;


