Return-Path: <linux-fsdevel+bounces-72819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B4DD04745
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B523116810
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8EA3AE715;
	Thu,  8 Jan 2026 11:31:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2146921E;
	Thu,  8 Jan 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871908; cv=none; b=hIVPVSy9WACC15lKbEVywJvx8TIfdTIx8VZhvEOci7h4H+PB0Z3YuUs0l2IyTzs2LgP4W/fN3mHYvFM3eW+kHPP6ByCYLNFSRH/D28Ew7hEwYdC/OU15q1r3T1qo7X44JDb3uDRC+giPJ9TaaAtKMrqG5cp3GeLfWpCTBawIBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871908; c=relaxed/simple;
	bh=y796rDrJ21yJQD79iVcl1umsiFJxvcPE2iQNz4VjQRk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRjKYNVKZNxnKvNKlS83Qo9Vxn6yqlKMwAqpqP7z4zsbHzRxPz141qNXVA6u+qfruhRUBkq+jed+K/aGrG+36ljsRVIbNR7lrr4cKnLWgMHl/93hWrs2l9FCtyJKwDerun4WXe01UftV9jVtygeYJsxXNh4Hq8J3L8TsO8T5diA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn2mK2r3yzHnHJ2;
	Thu,  8 Jan 2026 19:31:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 666D840565;
	Thu,  8 Jan 2026 19:31:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 11:31:35 +0000
Date: Thu, 8 Jan 2026 11:31:34 +0000
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
Subject: Re: [PATCH V3 02/21] dax: add fsdev.c driver for fs-dax on
 character dax
Message-ID: <20260108113134.000040fd@huawei.com>
In-Reply-To: <20260107153332.64727-3-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-3-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:11 -0600
John Groves <John@Groves.net> wrote:

> The new fsdev driver provides pages/folios initialized compatibly with
> fsdax - normal rather than devdax-style refcounting, and starting out
> with order-0 folios.
> 
> When fsdev binds to a daxdev, it is usually (always?) switching from the
> devdax mode (device.c), which pre-initializes compound folios according
> to its alignment. Fsdev uses fsdev_clear_folio_state() to switch the
> folios into a fsdax-compatible state.
> 
> A side effect of this is that raw mmap doesn't (can't?) work on an fsdev
> dax instance. Accordingly, The fsdev driver does not provide raw mmap -
> devices must be put in 'devdax' mode (drivers/dax/device.c) to get raw
> mmap capability.
> 
> In this commit is just the framework, which remaps pages/folios compatibly
> with fsdax.
> 
> Enabling dax changes:
> 
> * bus.h: add DAXDRV_FSDEV_TYPE driver type
> * bus.c: allow DAXDRV_FSDEV_TYPE drivers to bind to daxdevs
> * dax.h: prototype inode_dax(), which fsdev needs
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: John Groves <john@groves.net>

> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index d656e4c0eb84..491325d914a8 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -78,4 +78,21 @@ config DEV_DAX_KMEM
>  
>  	  Say N if unsure.
>  
> +config DEV_DAX_FS
> +	tristate "FSDEV DAX: fs-dax compatible device driver"
> +	depends on DEV_DAX
> +	default DEV_DAX

What's the logic for the default? Generally I'd not expect a
default for something new like this (so default of default == no)

> +	help
> +	  Support a device-dax driver mode that is compatible with fs-dax

...



>  struct dax_device_driver {
> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> new file mode 100644
> index 000000000000..2a3249d1529c
> --- /dev/null
> +++ b/drivers/dax/fsdev.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2026 Micron Technology, Inc. */
> +#include <linux/memremap.h>
> +#include <linux/pagemap.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/cdev.h>
> +#include <linux/slab.h>
> +#include <linux/dax.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include "dax-private.h"
> +#include "bus.h"

...

> +static void fsdev_cdev_del(void *cdev)
> +{
> +	cdev_del(cdev);
> +}
> +
> +static void fsdev_kill(void *dev_dax)
> +{
> +	kill_dev_dax(dev_dax);
> +}

...

> +/*
> + * Clear any stale folio state from pages in the given range.
> + * This is necessary because device_dax pre-initializes compound folios
> + * based on vmemmap_shift, and that state may persist after driver unbind.

What's the argument for not cleaning these out in the unbind path for device_dax?
I can see that it might be an optimization if some other code path blindly
overwrites all this state.

> + * Since fsdev_dax uses MEMORY_DEVICE_FS_DAX without vmemmap_shift, fs-dax
> + * expects to find clean order-0 folios that it can build into compound
> + * folios on demand.
> + *
> + * At probe time, no filesystem should be mounted yet, so all mappings
> + * are stale and must be cleared along with compound state.
> + */
> +static void fsdev_clear_folio_state(struct dev_dax *dev_dax)
> +{
> +	int i;

It's becoming increasingly common to declare loop variables as
for (int i = 0; i <...

and given that saves us a few lines here it seems worth doing.

> +
> +	for (i = 0; i < dev_dax->nr_range; i++) {
> +		struct range *range = &dev_dax->ranges[i].range;
> +		unsigned long pfn, end_pfn;
> +
> +		pfn = PHYS_PFN(range->start);
> +		end_pfn = PHYS_PFN(range->end) + 1;

Might as well do
		unsigned long pfn = PHY_PFN(range->start);
		unsigned long end_pfn = PHYS_PFN(range->end) + 1;
> +
> +		while (pfn < end_pfn) {
> +			struct page *page = pfn_to_page(pfn);
> +			struct folio *folio = (struct folio *)page;
> +			struct dev_pagemap *pgmap = page_pgmap(page);
> +			int order = folio_order(folio);
> +
> +			/*
> +			 * Clear any stale mapping pointer. At probe time,
> +			 * no filesystem is mounted, so any mapping is stale.
> +			 */
> +			folio->mapping = NULL;
> +			folio->share = 0;
> +
> +			if (order > 0) {
> +				int j;
> +
> +				folio_reset_order(folio);
> +				for (j = 0; j < (1UL << order); j++) {
> +					struct page *p = page + j;
> +
> +					ClearPageHead(p);
> +					clear_compound_head(p);
> +					((struct folio *)p)->mapping = NULL;

This code block is very similar to a chunk in dax_folio_put() in fs/dax.c

Can we create a helper for both to use?

I note that uses a local struct folio *new_folio to avoid multiple casts.
I'd do similar here even if it's a long line.
 
If not possible to use a common helper, it is probably still worth
having a helper here for the stuff in the while loop just to reduce indent
and improve readability a little.

> +					((struct folio *)p)->share = 0;
> +					((struct folio *)p)->pgmap = pgmap;
> +				}
> +				pfn += (1UL << order);
> +			} else {
> +				folio->pgmap = pgmap;
> +				pfn++;
> +			}
> +		}
> +	}
> +}
> +
> +static int fsdev_open(struct inode *inode, struct file *filp)
> +{
> +	struct dax_device *dax_dev = inode_dax(inode);
> +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> +
> +	dev_dbg(&dev_dax->dev, "trace\n");

Hmm. This is a somewhat odd, but I see dax/device.c does
the same thing and I guess that's because you are using
dynamic debug with function names turned on to provide the
'real' information.



> +	filp->private_data = dev_dax;
> +
> +	return 0;
> +}

> +static int fsdev_dax_probe(struct dev_dax *dev_dax)
> +{
> +	struct dax_device *dax_dev = dev_dax->dax_dev;
> +	struct device *dev = &dev_dax->dev;
> +	struct dev_pagemap *pgmap;
> +	u64 data_offset = 0;
> +	struct inode *inode;
> +	struct cdev *cdev;
> +	void *addr;
> +	int rc, i;
> +

A bunch of this is cut and paste from dax/device.c
If it carries on looking like this, can we have a helper module that
both drivers use with the common code in it? That would make the
difference more obvious as well.

> +	if (static_dev_dax(dev_dax))  {
> +		if (dev_dax->nr_range > 1) {
> +			dev_warn(dev,
> +				"static pgmap / multi-range device conflict\n");
> +			return -EINVAL;
> +		}
> +
> +		pgmap = dev_dax->pgmap;
> +	} else {
> +		if (dev_dax->pgmap) {
> +			dev_warn(dev,
> +				 "dynamic-dax with pre-populated page map\n");
Unless dax maintainers are very fussy about 80 chars, I'd go long on these as it's
only just over 80 chars on one line.

Given you are failing probe, not sure why dev_warn() is considered sufficient.
To me dev_err() seems more sensible. What you have matches dax/device.c though
so maybe there is a sound reason.

> +			return -EINVAL;
> +		}
> +
> +		pgmap = devm_kzalloc(dev,
> +			struct_size(pgmap, ranges, dev_dax->nr_range - 1),
> +				     GFP_KERNEL);
Pick an alignment style and stick to it.  Either.
		pgmap = devm_kzalloc(dev,
			struct_size(pgmap, ranges, dev_dax->nr_range - 1),
			GFP_KERNEL);

or go long for readability and do
		pgmap = devm_kzalloc(dev,
				     struct_size(pgmap, ranges, dev_dax->nr_range - 1),
				     GFP_KERNEL);



> +		if (!pgmap)
> +			return -ENOMEM;
> +
> +		pgmap->nr_range = dev_dax->nr_range;
> +		dev_dax->pgmap = pgmap;
> +
> +		for (i = 0; i < dev_dax->nr_range; i++) {
> +			struct range *range = &dev_dax->ranges[i].range;
> +
> +			pgmap->ranges[i] = *range;
> +		}
> +	}
> +
> +	for (i = 0; i < dev_dax->nr_range; i++) {
> +		struct range *range = &dev_dax->ranges[i].range;
> +
> +		if (!devm_request_mem_region(dev, range->start,
> +					range_len(range), dev_name(dev))) {
> +			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve range\n",
> +					i, range->start, range->end);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	/*
> +	 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type and
> +	 * do NOT set vmemmap_shift. This leaves folios at order-0,
> +	 * allowing fs-dax to dynamically create compound folios as needed
> +	 * (similar to pmem behavior).
> +	 */
> +	pgmap->type = MEMORY_DEVICE_FS_DAX;
> +	pgmap->ops = &fsdev_pagemap_ops;
> +	pgmap->owner = dev_dax;
> +
> +	/*
> +	 * CRITICAL DIFFERENCE from device.c:
> +	 * We do NOT set vmemmap_shift here, even if align > PAGE_SIZE.
> +	 * This ensures folios remain order-0 and are compatible with
> +	 * fs-dax's folio management.
> +	 */
> +
> +	addr = devm_memremap_pages(dev, pgmap);
> +	if (IS_ERR(addr))
> +		return PTR_ERR(addr);
> +
> +	/*
> +	 * Clear any stale compound folio state left over from a previous
> +	 * driver (e.g., device_dax with vmemmap_shift).
> +	 */
> +	fsdev_clear_folio_state(dev_dax);
> +
> +	/* Detect whether the data is at a non-zero offset into the memory */
> +	if (pgmap->range.start != dev_dax->ranges[0].range.start) {
> +		u64 phys = dev_dax->ranges[0].range.start;
> +		u64 pgmap_phys = dev_dax->pgmap[0].range.start;
> +
> +		if (!WARN_ON(pgmap_phys > phys))
> +			data_offset = phys - pgmap_phys;
> +
> +		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx\n",
> +		       __func__, phys, pgmap_phys, data_offset);
> +	}
> +
> +	inode = dax_inode(dax_dev);
> +	cdev = inode->i_cdev;
> +	cdev_init(cdev, &fsdev_fops);
> +	cdev->owner = dev->driver->owner;
> +	cdev_set_parent(cdev, &dev->kobj);
> +	rc = cdev_add(cdev, dev->devt, 1);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(dev, fsdev_cdev_del, cdev);
> +	if (rc)
> +		return rc;
> +
> +	run_dax(dax_dev);
> +	return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);
> +}
> +
> +static struct dax_device_driver fsdev_dax_driver = {
> +	.probe = fsdev_dax_probe,
> +	.type = DAXDRV_FSDEV_TYPE,
> +};
> +
> +static int __init dax_init(void)
> +{
> +	return dax_driver_register(&fsdev_dax_driver);
> +}
> +
> +static void __exit dax_exit(void)
> +{
> +	dax_driver_unregister(&fsdev_dax_driver);
> +}
If these don't get more complex, maybe it's time for a dax specific define
using module_driver()

> +
> +MODULE_AUTHOR("John Groves");
> +MODULE_DESCRIPTION("FS-DAX Device: fs-dax compatible devdax driver");
> +MODULE_LICENSE("GPL");
> +module_init(dax_init);
> +module_exit(dax_exit);
> +MODULE_ALIAS_DAX_DEVICE(0);

Curious macro. Always has same parameter...  Maybe ripe for just dropping the parameter?



