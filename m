Return-Path: <linux-fsdevel+bounces-12797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D47867508
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D201284959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22877E589;
	Mon, 26 Feb 2024 12:32:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10630364A6;
	Mon, 26 Feb 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950773; cv=none; b=RUFbaJchShp1uceT3buqJgsc0fucUdYq10QWvezAqsiIC9oZlDfR9Ch+arjMk/KX49wpMoSx3TO5ciR58bVtaOGWIklok2WuAJG5d39s3mX/Eg4lsPQy696t8X0Gh1oVEzXi/AomicQz3am8Zhxwig1T2WlJvPwKttOB03IP+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950773; c=relaxed/simple;
	bh=+samE29DNF5Z/tfPUmXV4vESiIfB7rjrnsGi9M7ixAY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thHmHPKeAmkItYVDrfJ4c8gaqhvxG/PX06m021dhBxMV5F2p0f8QovRcnyLK2BFATqVavyI1n199E7B9ZHShCH8sfeSneAlidm6lqrYExKSKXfrlVALunSNeuGUA8mWp0+JWrhTpuMA1OdNn2Y+WHUkr8IOXV7/xRROGwsGhkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk0Jr5kkRz6K643;
	Mon, 26 Feb 2024 20:28:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DEFE141FF8;
	Mon, 26 Feb 2024 20:32:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 12:32:46 +0000
Date: Mon, 26 Feb 2024 12:32:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@Groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 05/20] dev_dax_iomap: Add dax_operations for use by
 fs-dax on devdax
Message-ID: <20240226123245.00000c01@Huawei.com>
In-Reply-To: <5727b1be956278e3a6c4cf7b728ee4f8f037ae51.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<5727b1be956278e3a6c4cf7b728ee4f8f037ae51.1708709155.git.john@groves.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:49 -0600
John Groves <John@Groves.net> wrote:

> Notes about this commit:
> 
> * These methods are based somewhat loosely on pmem_dax_ops from
>   drivers/nvdimm/pmem.c
> 
> * dev_dax_direct_access() is returns the hpa, pfn and kva. The kva was
>   newly stored as dev_dax->virt_addr by dev_dax_probe().
> 
> * The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
>   for read/write (dax_iomap_rw())
> 
> * dev_dax_recovery_write() and dev_dax_zero_page_range() have not been
>   tested yet. I'm looking for suggestions as to how to test those.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/dax/bus.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 664e8c1b9930..06fcda810674 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -10,6 +10,12 @@
>  #include "dax-private.h"
>  #include "bus.h"
>  
> +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> +#include <linux/backing-dev.h>
> +#include <linux/pfn_t.h>
> +#include <linux/range.h>
> +#endif
> +

Is it worth avoiding includes based on config? Probably not.

>  static DEFINE_MUTEX(dax_bus_lock);
>  
>  #define DAX_NAME_LEN 30
> @@ -1349,6 +1355,101 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
>  }
>  EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
>  
> +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> +

> +
> +static long __dev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> +			     long nr_pages, enum dax_access_mode mode, void **kaddr,
> +			     pfn_t *pfn)
> +{
> +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> +	size_t dax_size = dev_dax_size(dev_dax);
> +	size_t size = nr_pages << PAGE_SHIFT;
> +	size_t offset = pgoff << PAGE_SHIFT;
> +	phys_addr_t phys;
> +	u64 virt_addr = dev_dax->virt_addr + offset;
> +	pfn_t local_pfn;
> +	u64 flags = PFN_DEV|PFN_MAP;
> +
> +	WARN_ON(!dev_dax->virt_addr); /* virt_addr must be saved for direct_access */
Fair enough, but from local code point of view, does it make sense to check this
if !kaddr as we won't use this.
> +
> +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
> +
> +	if (kaddr)
> +		*kaddr = (void *)virt_addr;

Back to earlier comment on virt_addr as a void *. Definitely looking like
that would be more accurate and simpler!  Also not much point in computing
virt_addr unless kaddr is good.

> +
> +	local_pfn = phys_to_pfn_t(phys, flags); /* are flags correct? */
If you aren't going to do anything with it for !pfn, move it under the if (pfn).

> +	if (pfn)
> +		*pfn = local_pfn;
> +
> +	/* This the valid size at the specified address */
> +	return PHYS_PFN(min_t(size_t, size, dax_size - offset));
> +}
> +

> +
> +static const struct dax_operations dev_dax_ops = {
> +	.direct_access = dev_dax_direct_access,
> +	.zero_page_range = dev_dax_zero_page_range,
> +	.recovery_write = dev_dax_recovery_write,
> +};
> +
> +#endif /* IS_ENABLED(CONFIG_DEV_DAX_IOMAP) */
> +
>  struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  {
>  	struct dax_region *dax_region = data->dax_region;
> @@ -1404,11 +1505,17 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  		}
>  	}
>  

If we were to make this 

	if (IS_ENABLED(CONFIG_DEV_DAX_IOMAP))

etc can we avoid the ifdef stuff above and let dead code removal deal with it?
Might need a few stubs - I haven't tried.

> +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> +	/* holder_ops currently populated separately in a slightly hacky way */
> +	dax_dev = alloc_dax(dev_dax, &dev_dax_ops);
> +#else
>  	/*
>  	 * No dax_operations since there is no access to this device outside of
>  	 * mmap of the resulting character device.
>  	 */
>  	dax_dev = alloc_dax(dev_dax, NULL);
> +#endif
> +
>  	if (IS_ERR(dax_dev)) {
>  		rc = PTR_ERR(dax_dev);
>  		goto err_alloc_dax;


