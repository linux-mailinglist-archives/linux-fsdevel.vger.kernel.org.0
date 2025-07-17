Return-Path: <linux-fsdevel+bounces-55197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD7B08192
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 02:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B31C28729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7F143C61;
	Thu, 17 Jul 2025 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR14Cmbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D8273FE;
	Thu, 17 Jul 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712976; cv=none; b=lwdayvY1Et6GiFJy5vdRyh0V0v+C8gwschBUr/iN0FKg0/XgrUJ7jQStm32LLJOieQC5wFTtEUa610JN3UwGnuKYL5rgDc/Z5msjk67sof5Rc77g9H806rxG7CNbwV6n1zeaCqOKXyII6sNbfgZnc22qDN+kbdQg2BSgtC3yF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712976; c=relaxed/simple;
	bh=a1a2m+qTgsqOTVd7tUMA7nLBD9q1KSnyxnULxLgpT04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/sLzXFIBRoBF+y7J8sxxyTt9nSnS4nHwl9ItK8nSO7AXqjZTzpntMFqNP95bH4eU/aYLqIrKfxpv8cogXDu08/pD4tvmt4FRPQ2CZAf05qS5Y5BfDyTIwHcCouE4Hq6kswKxhQrv0UdSWtZi/U5G2k9Wc/gIze5oM1BsFxJ+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR14Cmbo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752712974; x=1784248974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a1a2m+qTgsqOTVd7tUMA7nLBD9q1KSnyxnULxLgpT04=;
  b=OR14Cmboo/StSDO6u7XNa10GxKG/p1BgVbHgbxnS3hjDRvtwyTum0O9W
   F84dWHP4bIACKyVeOE+KVJ7sIEFDQggmTHVMDbST59YFbwn/4+GBfKLZK
   75eRuwY1qMnvObdkkQLS5b5UZACfEyagc/PeJXwVTpU7Rb5iR/7AA557d
   DqHYFZPUitnVptTHazw84+KriJGOFYw+K4q9TNCUqMUp6Pg3UIIqJ++G2
   L6bEnIn+0n2k+w9mYb3N+i2d1ixxlc9GHwbM0j23Gwy/qtLuigKTxLI7j
   S4G+NdDjW/TH0LgupKqVlCm+/t2veccT9DtPY1iYMuQDrABMI/YPOpSic
   g==;
X-CSE-ConnectionGUID: aJFgo7nYQtmaQ4gKCnw6Sw==
X-CSE-MsgGUID: 4QUXR7PiTH+Xs//HxNRzxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55123475"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="55123475"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:42:54 -0700
X-CSE-ConnectionGUID: rQa7ZAQtRDqTc7/WqMZ6rw==
X-CSE-MsgGUID: D3FN+HCrT4uUEFuqsRHt9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="188597232"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:42:52 -0700
Message-ID: <622fa915-4e3e-43fd-a6f5-9a2d8bad7925@intel.com>
Date: Wed, 16 Jul 2025 17:42:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250715180407.47426-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/25 11:04 AM, Smita Koralahalli wrote:
> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
> 
> Previously, when CXL regions were created through autodiscovery and their
> resources overlapped with SOFT RESERVED ranges, the soft reserved resource
> remained in place after region teardown. This left the HPA range
> unavailable for reuse even after the region was destroyed.
> 
> Enhance the logic to reliably remove SOFT RESERVED resources associated
> with a region, regardless of alignment or hierarchy in the iomem tree.
> 
> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/acpi.c        |   2 +
>  drivers/cxl/core/region.c | 124 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   2 +
>  include/linux/ioport.h    |   1 +
>  kernel/resource.c         |  34 +++++++++++
>  5 files changed, 163 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3a27289e669b..9eb8a9587dee 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -829,6 +829,8 @@ static void cxl_softreserv_mem_work_fn(struct work_struct *work)
>  		pr_debug("Timeout waiting for cxl_mem probing");
>  
>  	wait_for_device_probe();
> +
> +	cxl_region_softreserv_update();
>  }
>  static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..95951a1f1cab 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3486,6 +3486,130 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>  
> +static int add_soft_reserved(resource_size_t start, resource_size_t len,
> +			     unsigned long flags)
> +{
> +	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	int rc;
> +
> +	if (!res)
> +		return -ENOMEM;
> +
> +	*res = DEFINE_RES_NAMED_DESC(start, len, "Soft Reserved",
> +				     flags | IORESOURCE_MEM,
> +				     IORES_DESC_SOFT_RESERVED);
> +
> +	rc = insert_resource(&iomem_resource, res);
> +	if (rc) {
> +		kfree(res);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
> +				 resource_size_t start, resource_size_t end)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	resource_size_t new_start, new_end;
> +	int rc;
> +
> +	guard(mutex)(&cxlrd->range_lock);
> +
> +	if (soft->start == start && soft->end == end) {
> +		/*
> +		 * Exact alignment at both start and end. The entire region is
> +		 * removed below.
> +		 */
> +
> +	} else if (soft->start == start || soft->end == end) {
> +		/* Aligns at either resource start or end */
> +		if (soft->start == start) {
> +			new_start = end + 1;
> +			new_end = soft->end;
> +		} else {
> +			new_start = soft->start;
> +			new_end = start - 1;
> +		}
> +
> +		/*
> +		 * Reuse original flags as the trimmed portion retains the same
> +		 * memory type and access characteristics.
> +		 */
> +		rc = add_soft_reserved(new_start, new_end - new_start + 1,
> +				       soft->flags);
> +		if (rc)
> +			dev_warn(&cxlr->dev,
> +				 "cannot add new soft reserved resource at %pa\n",
> +				 &new_start);
> +
> +	} else {
> +		/* No alignment - Split into two new soft reserved regions */
> +		new_start = soft->start;
> +		new_end = soft->end;
> +
> +		rc = add_soft_reserved(new_start, start - new_start,
> +				       soft->flags);
> +		if (rc)
> +			dev_warn(&cxlr->dev,
> +				 "cannot add new soft reserved resource at %pa\n",
> +				 &new_start);
> +
> +		rc = add_soft_reserved(end + 1, new_end - end, soft->flags);
> +		if (rc)
> +			dev_warn(&cxlr->dev,
> +				 "cannot add new soft reserved resource at %pa + 1\n",
> +				 &end);
> +	}
> +
> +	rc = remove_resource(soft);
> +	if (rc)
> +		dev_warn(&cxlr->dev, "cannot remove soft reserved resource %pr\n",
> +			 soft);
> +}
> +
> +static int __cxl_region_softreserv_update(struct resource *soft,
> +					  void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct resource *res = cxlr->params.res;
> +
> +	/* Skip non-intersecting soft-reserved regions */
> +	if (soft->end < res->start || soft->start > res->end)
> +		return 0;
> +
> +	soft = normalize_resource(soft);
> +	if (!soft)
> +		return -EINVAL;
> +
> +	remove_soft_reserved(cxlr, soft, res->start, res->end);
> +
> +	return 0;
> +}
> +
> +static int cxl_region_softreserv_update_cb(struct device *dev, void *data)
> +{
> +	struct cxl_region *cxlr;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +
> +	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0, -1,
> +			    cxlr, __cxl_region_softreserv_update);

No checking return value of walk_iomem_res_desc()?

> +
> +	return 0;
> +}
> +
> +void cxl_region_softreserv_update(void)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL,
> +			 cxl_region_softreserv_update_cb);

No checking return value of bus_for_each_dev()? Is it ok to ignore all errors?

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
> +
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  {
>  	struct cxl_region_ref *iter;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3117136f0208..9f173467e497 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -862,6 +862,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
> +void cxl_region_softreserv_update(void);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -884,6 +885,7 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
>  {
>  	return 0;
>  }
> +static inline void cxl_region_softreserv_update(void) { }
>  #endif
>  
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e8b2d6aa4013..8693e095d32b 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -233,6 +233,7 @@ struct resource_constraint {
>  extern struct resource ioport_resource;
>  extern struct resource iomem_resource;
>  
> +extern struct resource *normalize_resource(struct resource *res);
>  extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
>  extern int request_resource(struct resource *root, struct resource *new);
>  extern int release_resource(struct resource *new);
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 8d3e6ed0bdc1..3d8dc2a59cb2 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -50,6 +50,40 @@ EXPORT_SYMBOL(iomem_resource);
>  
>  static DEFINE_RWLOCK(resource_lock);
>  
> +/*
> + * normalize_resource
> + *
> + * The walk_iomem_res_desc() returns a copy of a resource, not a reference
> + * to the actual resource in the iomem_resource tree. As a result,
> + * __release_resource() which relies on pointer equality will fail.
> + *
> + * This helper walks the children of the resource's parent to find and
> + * return the original resource pointer that matches the given resource's
> + * start and end addresses.
> + *
> + * Return: Pointer to the matching original resource in iomem_resource, or
> + *         NULL if not found or invalid input.
> + */
> +struct resource *normalize_resource(struct resource *res)
> +{
> +	if (!res || !res->parent)
> +		return NULL;
> +
> +	read_lock(&resource_lock);

May as well go with below for consistency:
guard(read_lock)(&resource_lock);

DJ

> +	for (struct resource *res_iter = res->parent->child; res_iter != NULL;
> +	     res_iter = res_iter->sibling) {
> +		if ((res_iter->start == res->start) &&
> +		    (res_iter->end == res->end)) {
> +			read_unlock(&resource_lock);
> +			return res_iter;
> +		}
> +	}
> +
> +	read_unlock(&resource_lock);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(normalize_resource, "CXL");
> +
>  /*
>   * Return the next node of @p in pre-order tree traversal.  If
>   * @skip_children is true, skip the descendant nodes of @p in


