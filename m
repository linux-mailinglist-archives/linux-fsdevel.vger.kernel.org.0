Return-Path: <linux-fsdevel+bounces-53961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59558AF9311
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 14:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD8516A3EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0F92D8DC8;
	Fri,  4 Jul 2025 12:47:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF92D94A5;
	Fri,  4 Jul 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633272; cv=none; b=ph5cDje5gAPZvwpNatRaJ6bgWKRlfpdI9rOUuvIIBzbkdk4XqpOeaYcDG7M8slnzcZaYGthknw4/N2/dxcoEsQOJf09kO2oxw2sYOuO98LldpLG+BjrrbuK6gTnT5mPmig9pBYXTCUYpobLbHmZf2jyhA+iMm9meUfyrWPjQmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633272; c=relaxed/simple;
	bh=q3W6qKOAkT7lw4zg9GWf0eKhGBj+FEgS0+PDTTbEsHg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBbruVr604YLc14DsZ/E7cd6KWKFnNZ+GmmhN8CvgSI+tzeAZJnLpAPuHo8uboB6vfO6E1div/1q7qy1sNfFeHVOzVRGn2VPfHI7z3uTMUySjrnte+tpa5QMRAGwHj/oGvXG2J4qNTniA6H5PASCTcx4AP7RiHzNCkG1fP5BV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYYLV23QGz6L5Q0;
	Fri,  4 Jul 2025 20:47:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 83D0B1402E9;
	Fri,  4 Jul 2025 20:47:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 14:47:45 +0200
Date: Fri, 4 Jul 2025 13:47:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi
	<miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, John Groves
	<jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Matthew
 Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Darrick J
 . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Jeff
 Layton" <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, "Stefan
 Hajnoczi" <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 04/18] dev_dax_iomap: Add dax_operations for use by
 fs-dax on devdax
Message-ID: <20250704134744.00006bcd@huawei.com>
In-Reply-To: <20250703185032.46568-5-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
	<20250703185032.46568-5-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  3 Jul 2025 13:50:18 -0500
John Groves <John@Groves.net> wrote:

> Notes about this commit:
> 
> * These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
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
A few trivial things noticed whilst reading through.

> ---
>  drivers/dax/bus.c | 120 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 9d9a4ae7bbc0..61a8d1b3c07a 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -7,6 +7,10 @@
>  #include <linux/slab.h>
>  #include <linux/dax.h>
>  #include <linux/io.h>
> +#include <linux/backing-dev.h>
> +#include <linux/pfn_t.h>
> +#include <linux/range.h>
> +#include <linux/uio.h>
>  #include "dax-private.h"
>  #include "bus.h"
>  
> @@ -1441,6 +1445,105 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
>  }
>  EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
>  
> +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> +
> +static void write_dax(void *pmem_addr, struct page *page,
> +		unsigned int off, unsigned int len)
> +{
> +	unsigned int chunk;
> +	void *mem;

I'd move these two into the loop - similar to what you have
in other cases with more local scope.

> +
> +	while (len) {
> +		mem = kmap_local_page(page);
> +		chunk = min_t(unsigned int, len, PAGE_SIZE - off);
> +		memcpy_flushcache(pmem_addr, mem + off, chunk);
> +		kunmap_local(mem);
> +		len -= chunk;
> +		off = 0;
> +		page++;
> +		pmem_addr += chunk;
> +	}
> +}
> +
> +static long __dev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> +			long nr_pages, enum dax_access_mode mode, void **kaddr,
> +			pfn_t *pfn)
> +{
> +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> +	size_t size = nr_pages << PAGE_SHIFT;
> +	size_t offset = pgoff << PAGE_SHIFT;
> +	void *virt_addr = dev_dax->virt_addr + offset;
> +	u64 flags = PFN_DEV|PFN_MAP;

spaces around the |

Though given it's in just one place, just put these inline next
to the question...


> +	phys_addr_t phys;
> +	pfn_t local_pfn;
> +	size_t dax_size;
> +
> +	WARN_ON(!dev_dax->virt_addr);
> +
> +	if (down_read_interruptible(&dax_dev_rwsem))
> +		return 0; /* no valid data since we were killed */
> +	dax_size = dev_dax_size(dev_dax);
> +	up_read(&dax_dev_rwsem);
> +
> +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
> +
> +	if (kaddr)
> +		*kaddr = virt_addr;
> +
> +	local_pfn = phys_to_pfn_t(phys, flags); /* are flags correct? */
> +	if (pfn)
> +		*pfn = local_pfn;
> +
> +	/* This the valid size at the specified address */
> +	return PHYS_PFN(min_t(size_t, size, dax_size - offset));
> +}

> +static size_t dev_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
> +		void *addr, size_t bytes, struct iov_iter *i)
> +{
> +	size_t off;
> +
> +	off = offset_in_page(addr);

Unused.
> +
> +	return _copy_from_iter_flushcache(addr, bytes, i);
> +}



