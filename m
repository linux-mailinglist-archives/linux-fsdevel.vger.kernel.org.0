Return-Path: <linux-fsdevel+bounces-71560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C4ECC77D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 13:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5CB9301830F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3F833BBB6;
	Wed, 17 Dec 2025 12:06:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A68233D9E;
	Wed, 17 Dec 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973167; cv=none; b=F5Pc6r0G5MHvKxNa2rBvDdY8ngUl8RyQwo6UonYPBoIlavmUMXQ1dScOrEhKqTsDBGmD+IppbRmfmTbyv1KPbq4Yf46fhmxNJ1Hjx4PvhxPdC9+0cuj2/vu9ykogJb3sMAS8vlOK0zGajSs6iuH6lzkrkaETl3nGl34ldXBSXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973167; c=relaxed/simple;
	bh=Bb4B7AEZU6H4eIlHZ2WPtxRlG0h+ASXbqJgK8cj8dpk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVMwldSCrlEnAk2wFumsuLKabcow9XeKmiOfNzWxXMPxcMa/DMXBykHtwmr9zte58uSmgbqhalXPNJeRe2l7jR1mt2yjEi/+d5Os8cBZSxDslDFA7q4H6RME8MQrWIG1o2T446UDmA5twcc4kik6ran2jbShvT3PvVRCrWD1z50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWXYm63bgzJ46Dm;
	Wed, 17 Dec 2025 20:05:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 26E3C4056B;
	Wed, 17 Dec 2025 20:06:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 12:05:52 +0000
Date: Wed, 17 Dec 2025 12:05:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 1/9] dax/hmem, e820, resource: Defer Soft Reserved
 insertion until hmem is ready
Message-ID: <20251217120550.00003325@huawei.com>
In-Reply-To: <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
	<20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 20 Nov 2025 03:19:17 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
> instead of the iomem_resource tree at boot. Delay publishing these ranges
> into the iomem hierarchy until ownership is resolved and the HMEM path
> is ready to consume them.
> 
> Publishing Soft Reserved ranges into iomem too early conflicts with CXL
> hotplug and prevents region assembly when those ranges overlap CXL
> windows.
> 
> Follow up patches will reinsert Soft Reserved ranges into iomem after CXL
> window publication is complete and HMEM is ready to claim the memory. This
> provides a cleaner handoff between EFI-defined memory ranges and CXL
> resource management without trimming or deleting resources later.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

A couple of general comments below.  I don't feel particularly strongly
about any of them however if you disagree! (other than the ever important
number of blank lines!) :)

Jonathan


> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index f9e1a76a04a9..22732b729017 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -83,8 +83,8 @@ static __init int hmem_register_one(struct resource *res, void *data)
>  
>  static __init int hmem_init(void)
>  {
> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> +	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,

Similar to below. If we are only putting MEM of type SOFT_RESERVED in here
can we drop those two as parameters?

> +				   -1, NULL, hmem_register_one);
>  	return 0;
>  }
>  
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index c18451a37e4f..48f4642f4bb8 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -73,11 +73,14 @@ static int hmem_register_device(struct device *host, int target_nid,
>  		return 0;
>  	}
>  
> -	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> -			       IORES_DESC_SOFT_RESERVED);
> +	rc = region_intersects_soft_reserve(res->start, resource_size(res),
> +					    IORESOURCE_MEM,
> +					    IORES_DESC_SOFT_RESERVED);

The flags seem perhaps redundant.  Trade off between matching the more complex
existing functions and simplfying this.  Maybe push them down into the
call and just have
	rc = region_intersects_soft_reserved(res->start, resource_size(res));
here?

>  	if (rc != REGION_INTERSECTS)
>  		return 0;
>  
> +	/* TODO: Add Soft-Reserved memory back to iomem */
> +
>  	id = memregion_alloc(GFP_KERNEL);
>  	if (id < 0) {
>  		dev_err(host, "memregion allocation failure for %pr\n", res);

> diff --git a/kernel/resource.c b/kernel/resource.c
> index b9fa2a4ce089..208eaafcc681 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c

> @@ -402,6 +410,15 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>  	return ret;
>  }
>  
> +static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
> +				 unsigned long flags, unsigned long desc,
> +				 void *arg,
> +				 int (*func)(struct resource *, void *))
> +{
> +	return walk_res_desc(&iomem_resource, start, end, flags, desc, arg, func);
> +}
> +

Local style seems to be single line breaks - stick to that unless I'm missing
some reason this one is special.

> +
>  /**

>  /*
>   * This function calls the @func callback against all memory ranges of type
>   * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
> @@ -648,6 +685,22 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>  }
>  EXPORT_SYMBOL_GPL(region_intersects);
>  
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +int region_intersects_soft_reserve(resource_size_t start, size_t size,
> +				   unsigned long flags, unsigned long desc)
> +{
> +	int ret;
> +
> +	read_lock(&resource_lock);
> +	ret = __region_intersects(&soft_reserve_resource, start, size, flags,
> +				  desc);
> +	read_unlock(&resource_lock);
> +
> +	return ret;
Perhaps the shortening of code makes it worth implementing this as:

	guard(read_lock)(&resource_lock);
	return __region_intersects();

Or ignore that until someone feels like a more general use of that
infrastructure in this file.  Looks like there are a bunch of places
where I'd argue it is worth doing.

Jonathan


> +}
> +EXPORT_SYMBOL_GPL(region_intersects_soft_reserve);
> +#endif


