Return-Path: <linux-fsdevel+bounces-45757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB49A7BD84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7B93B92FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5119A1F153C;
	Fri,  4 Apr 2025 13:16:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BA1EB9F3;
	Fri,  4 Apr 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772607; cv=none; b=fZTL8244HK6bngbJzv42Mjg/RXElcio+2vdw9qLH+k744HUcV6yxStXgzhiPYiuRSOyMWhD+KvA+EkMk+T/kP6C+9UGn7bTjI4lBv+ZDYskc8K7PMNu+oT1Qsu28kSWftmJl6AOeukAKgIl935s1iH8OGp4yESgT2h6XYk+1hMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772607; c=relaxed/simple;
	bh=Rgy2gfndJX3PsB92jWszKXmI5B60tkP+ysr7rxwu8+Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbaEJaX0dhyOvainMWSIB/4CsLqbzJyDFqoqQgH8ZrcdWKezY51+8C5Z1SiTd/rCHCo6Bwg1o/ARSAhLPB7TVU0jaWcXcXk+xblJC2oJ/TOs2xwrAO6ZusrzjyyT5iO5DN0bv4ycoSJcrqlCPaCykyk0lAX4sib5gr3rSyqTERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTfDD4glsz6M4MH;
	Fri,  4 Apr 2025 21:13:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7425514062A;
	Fri,  4 Apr 2025 21:16:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 15:16:41 +0200
Date: Fri, 4 Apr 2025 14:16:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
	<ming.li@zohomail.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <huang.ying.caritas@gmail.com>,
	<yaoxt.fnst@fujitsu.com>, <peterz@infradead.org>,
	<gregkh@linuxfoundation.org>, <quic_jjohnson@quicinc.com>,
	<ilpo.jarvinen@linux.intel.com>, <bhelgaas@google.com>,
	<andriy.shevchenko@linux.intel.com>, <mika.westerberg@linux.intel.com>,
	<akpm@linux-foundation.org>, <gourry@gourry.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rrichter@amd.com>, <benjamin.cheatham@amd.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 1/4] kernel/resource: Provide mem region release for
 SOFT RESERVES
Message-ID: <20250404141639.00000f59@huawei.com>
In-Reply-To: <20250403183315.286710-2-terry.bowman@amd.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
	<20250403183315.286710-2-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Apr 2025 13:33:12 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Nathan Fontenot <nathan.fontenot@amd.com>
> 
> Add a release_Sam_region_adjustable() interface to allow for

Who is Sam?  (typo)

> removing SOFT RESERVE memory resources. This extracts out the code
> to remove a mem region into a common __release_mem_region_adjustable()
> routine, this routine takes additional parameters of an IORES
> descriptor type to add checks for IORES_DESC_* and a flag to check
> for IORESOURCE_BUSY to control it's behavior.
> 
> The existing release_mem_region_adjustable() is a front end to the
> common code and a new release_srmem_region_adjustable() is added to
> release SOFT RESERVE resources.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 55 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5385349f0b8a..718360c9c724 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -357,6 +357,9 @@ extern void __release_region(struct resource *, resource_size_t,
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  extern void release_mem_region_adjustable(resource_size_t, resource_size_t);
>  #endif
> +#ifdef CONFIG_CXL_REGION
> +extern void release_srmem_region_adjustable(resource_size_t, resource_size_t);
I'm not sure the srmem is obvious enough.  Maybe it's worth the long
name to spell it out some more.. e.g. something like

extern void release_softresv_mem_region_adjustable() ?
> +#endif
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  extern void merge_system_ram_resource(struct resource *res);
>  #endif
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 12004452d999..0195b31064b0 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1387,7 +1387,7 @@ void __release_region(struct resource *parent, resource_size_t start,
>  }
>  EXPORT_SYMBOL(__release_region);
>  
> -#ifdef CONFIG_MEMORY_HOTREMOVE
> +#if defined(CONFIG_MEMORY_HOTREMOVE) || defined(CONFIG_CXL_REGION)
>  /**
>   * release_mem_region_adjustable - release a previously reserved memory region

Looks like you left the old docs which I'm guessing is not the intent.

>   * @start: resource start address
> @@ -1407,7 +1407,10 @@ EXPORT_SYMBOL(__release_region);
>   *   assumes that all children remain in the lower address entry for
>   *   simplicity.  Enhance this logic when necessary.
>   */
> -void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
> +static void __release_mem_region_adjustable(resource_size_t start,
> +					    resource_size_t size,
> +					    bool busy_check,
> +					    int res_desc)
>  {
>  	struct resource *parent = &iomem_resource;
>  	struct resource *new_res = NULL;
> @@ -1446,7 +1449,12 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>  		if (!(res->flags & IORESOURCE_MEM))
>  			break;
>  
> -		if (!(res->flags & IORESOURCE_BUSY)) {
> +		if (busy_check && !(res->flags & IORESOURCE_BUSY)) {
> +			p = &res->child;
> +			continue;
> +		}
> +
> +		if (res_desc != IORES_DESC_NONE && res->desc != res_desc) {
>  			p = &res->child;
>  			continue;
>  		}
> @@ -1496,7 +1504,46 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>  	write_unlock(&resource_lock);
>  	free_resource(new_res);
>  }
> -#endif	/* CONFIG_MEMORY_HOTREMOVE */
> +#endif
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/**
> + * release_mem_region_adjustable - release a previously reserved memory region
As above. I was surprised to see new docs in here for an existing function.
I think you forgot to delete the now wrongly placed ones above.

Jonathan


