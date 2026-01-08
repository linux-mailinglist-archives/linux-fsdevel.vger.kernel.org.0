Return-Path: <linux-fsdevel+bounces-72827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BCED040ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54F9D3141146
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59DD43F49D;
	Thu,  8 Jan 2026 12:27:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B343636D;
	Thu,  8 Jan 2026 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875242; cv=none; b=RFt6uZpQo379ZcKAQB/GfDLVnmMkd0ZasK8qUqbtuDA2IqvNXVVQjBBklzSTFUrGFjU0TNk5iGsaJw2xnkohDG2nBGY5Hxfl9piS7Yq/ItSIxiuYJgs8YHUZCAoDACGEX6jNEIMxuFj8vdz9nOci+Plrao1AvH9tMUbPNT40qCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875242; c=relaxed/simple;
	bh=41316vyJ8zu+32cFRFgmU0a/by8Q0n1PdBcpVfQlya8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orsg8AnDm9EW8anlmkAxs2OhFAUTxQIwvz+NsQyqteJEYnnH63PTBEhhGNhP/iZU8kl0TD1TXbP0O3Hat6auXjf8R5TUQGRtDpnCnSVjOlPZK6IpozPqBlRYkrw4w3O42t2oMcanD92WOg811xNrRav+3OLMgliLU+PdSkGkHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn40c088NzJ46BR;
	Thu,  8 Jan 2026 20:27:12 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CDB3B40569;
	Thu,  8 Jan 2026 20:27:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 12:27:15 +0000
Date: Thu, 8 Jan 2026 12:27:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 06/21] dax: Add fs_dax_get() func to prepare dax for
 fs-dax usage
Message-ID: <20260108122713.00007e54@huawei.com>
In-Reply-To: <20260107153332.64727-7-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-7-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:15 -0600
John Groves <John@Groves.net> wrote:

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
Hi John,

A few passing comments on this one.

Jonathan

> ---

>  #define dax_driver_register(driver) \
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index ba0b4cd18a77..68c45b918cff 100644
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
> @@ -121,6 +122,59 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
>  EXPORT_SYMBOL_GPL(fs_put_dax);
>  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
>  
> +#if IS_ENABLED(CONFIG_DEV_DAX_FS)
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

Given this is an srcu_read_lock under the hood you could do similar
to the DEFINE_LOCK_GUARD_1 for the srcu (srcu.h) (though here it's a
DEFINE_LOCK_GUARD_0 given the lock itself isn't a parameter and then
use scoped_guard() here.  Might not be worth the hassle and would need
a wrapper macro to poke &dax_srcu in which means exposing that at least
a little in a header.

DEFINE_LOCK_GUARD_0(_T->idx = dax_read_lock, dax_read_lock(_T->idx), idx);
Based loosely on the irqflags.h irqsave one. 

> +	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode)) {
> +		dax_read_unlock(id);
> +		return -ENODEV;
> +	}
> +	dax_read_unlock(id);
> +
> +	/* Verify the device is bound to fsdev_dax driver */
> +	dev_dax = dax_get_private(dax_dev);
> +	if (!dev_dax || !dev_dax->dev.driver) {
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
> +#endif /* DEV_DAX_FS */
> +
>  enum dax_device_flags {
>  	/* !alive + rcu grace period == no new operations / mappings */
>  	DAXDEV_ALIVE,
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 3fcd8562b72b..76f2a75f3144 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -53,6 +53,7 @@ struct dax_holder_operations {
>  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
>  
>  #if IS_ENABLED(CONFIG_DEV_DAX_FS)
> +int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
I'd wrap this.  It's rather long and there isn't a huge readability benefit in keeping
it on one line.
>  struct dax_device *inode_dax(struct inode *inode);
>  #endif
>  void *dax_holder(struct dax_device *dax_dev);


