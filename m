Return-Path: <linux-fsdevel+bounces-72822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5477D03E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9A0730CF876
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B358450910;
	Thu,  8 Jan 2026 11:50:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7B494192;
	Thu,  8 Jan 2026 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873053; cv=none; b=QKXHhs+Fgqmc8BI/pJIhvUTUZhYlMGgYbujzGzH3jtGpFKx7j2/KQfhmAu5cJIsbka+zlGG6QGqx5V+zZrqni9+8erCBrbKD0ALNSwmokOLVXTlBkLjqzFgj/kU5dHQyk2PjsFZhI3J1qRnt4sZg4ljvC1/R3dxIpxmRurfaKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873053; c=relaxed/simple;
	bh=0cFCnToHoidp8mGU98/xEyvQ+R6MvfLk65pxm6CZxFs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nctYTvWn2of3Zn1Z/Dj02sg0+pWdaBhiFUzEVchzH0nYrzsnfBwbd1IVKSoBNIn6JyEx75DExcllW/hWvspjAB9wr5k/U0AaaH/OqLbU5Jhlc3CN16FF1D4cP0Eh9ZVdSpvFLRC0GPQgIR5cOHWREnNeh6ArrZOzVg4uGjByWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn3BK2kyWzHnH8J;
	Thu,  8 Jan 2026 19:50:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 66E4240572;
	Thu,  8 Jan 2026 19:50:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 11:50:39 +0000
Date: Thu, 8 Jan 2026 11:50:37 +0000
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
Subject: Re: [PATCH V3 04/21] dax: Add dax_operations for use by fs-dax on
 fsdev dax
Message-ID: <20260108115037.00003295@huawei.com>
In-Reply-To: <20260107153332.64727-5-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-5-john@groves.net>
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

On Wed,  7 Jan 2026 09:33:13 -0600
John Groves <John@Groves.net> wrote:

> From: John Groves <John@Groves.net>
> 
Hi John

The description should generally make sense without the title.
Sometimes that means more or less repeating the title.

A few other things inline.

> * These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
> * fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
>   newly stored as dev_dax->virt_addr by dev_dax_probe().
> * The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
>   for read/write (dax_iomap_rw())
> * fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
>   tested yet. I'm looking for suggestions as to how to test those.
> * dax-private.h: add dev_dax->cached_size, which fsdev needs to
>   remember. The dev_dax size cannot change while a driver is bound
>   (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
>   at probe time allows fsdev's direct_access path can use it without
>   acquiring dax_dev_rwsem (which isn't exported anyway).
> 
> Signed-off-by: John Groves <john@groves.net>

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index c5c660b193e5..9e2f83aa2584 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -27,6 +27,81 @@
>   * - No mmap support - all access is through fs-dax/iomap
>   */
>  
> +static void fsdev_write_dax(void *pmem_addr, struct page *page,
> +		unsigned int off, unsigned int len)
> +{
> +	while (len) {
> +		void *mem = kmap_local_page(page);

I guess it's pretty simple, but do we care about HIGHMEM for this
new feature?  Maybe it's just easier to support it than argue about it however ;)

> +		unsigned int chunk = min_t(unsigned int, len, PAGE_SIZE - off);
> +
> +		memcpy_flushcache(pmem_addr, mem + off, chunk);
> +		kunmap_local(mem);
> +		len -= chunk;
> +		off = 0;
> +		page++;
> +		pmem_addr += chunk;
> +	}
> +}
> +
> +static long __fsdev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> +			long nr_pages, enum dax_access_mode mode, void **kaddr,
> +			unsigned long *pfn)
> +{
> +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> +	size_t size = nr_pages << PAGE_SHIFT;
> +	size_t offset = pgoff << PAGE_SHIFT;
> +	void *virt_addr = dev_dax->virt_addr + offset;
> +	phys_addr_t phys;
> +	unsigned long local_pfn;
> +
> +	WARN_ON(!dev_dax->virt_addr);
> +
> +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);

Use size given you already computed it.

> +
> +	if (kaddr)
> +		*kaddr = virt_addr;
> +
> +	local_pfn = PHYS_PFN(phys);
> +	if (pfn)
> +		*pfn = local_pfn;
> +
> +	/*
> +	 * Use cached_size which was computed at probe time. The size cannot
> +	 * change while the driver is bound (resize returns -EBUSY).
> +	 */
> +	return PHYS_PFN(min_t(size_t, size, dev_dax->cached_size - offset));

Is the min_t() needed?  min() is pretty good at picking right types these days.

> +}
> +
> +static int fsdev_dax_zero_page_range(struct dax_device *dax_dev,
> +			pgoff_t pgoff, size_t nr_pages)
> +{
> +	void *kaddr;
> +
> +	WARN_ONCE(nr_pages > 1, "%s: nr_pages > 1\n", __func__);
> +	__fsdev_dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);
> +	fsdev_write_dax(kaddr, ZERO_PAGE(0), 0, PAGE_SIZE);
> +	return 0;
> +}
> +
> +static long fsdev_dax_direct_access(struct dax_device *dax_dev,
> +		  pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
> +		  void **kaddr, unsigned long *pfn)
> +{
> +	return __fsdev_dax_direct_access(dax_dev, pgoff, nr_pages, mode,
> +				       kaddr, pfn);

Alignment in this file is a bit random, but I'd at least align this one
after the (

> +}



