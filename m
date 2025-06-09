Return-Path: <linux-fsdevel+bounces-51021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9620CAD1E2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F0F3A954F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD7257449;
	Mon,  9 Jun 2025 12:54:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13B60DCF;
	Mon,  9 Jun 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473693; cv=none; b=WyBPIdJBid/b8ctsgQd45IfQ38n+0Us35dKuubT5p7NI6yyxGgTnjhCH3GvEI6Y6Hoj1adiwyoyRgm0DvcmTdjopl84IjoM9ugRMJAzdflk4FccIoET5hQn07znJWqam6OudQKi5ZzGONmPlfw3e2D/q2wolkrqL7yrBL466cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473693; c=relaxed/simple;
	bh=oWXz3lIwzuU8+p8l5Hj/DkcEeQgbyu9sSB7Bw2e/FgE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrgAXC5tpZKv4/CDvcPTPdxdLWLHc3+GM67lUN5ASGmx1zPqwTO8gHnQp0e1QIkY8pNmhaNi7KFiqyBxRB5KWbDbaRnCtbG6v+IqT0T9IJPyIeIs86UyfT/M4+XXPJnOrAiVoRqoXBgrqAC1dW/FNrVrZRQjZ2SDXs3/twPZRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGBfh74zzz6L5H8;
	Mon,  9 Jun 2025 20:53:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D7D701404C5;
	Mon,  9 Jun 2025 20:54:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 14:54:46 +0200
Date: Mon, 9 Jun 2025 13:54:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	"Benjamin Cheatham" <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
Message-ID: <20250609135444.0000703f@huawei.com>
In-Reply-To: <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
	<20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 22:19:47 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

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
>  drivers/cxl/core/region.c | 151 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   5 ++
>  3 files changed, 158 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 978f63b32b41..1b1388feb36d 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -823,6 +823,8 @@ static void cxl_softreserv_mem_work_fn(struct work_struct *work)
>  	 * and cxl_mem drivers are loaded.
>  	 */
>  	wait_for_device_probe();
> +
> +	cxl_region_softreserv_update();
>  }
>  static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 109b8a98c4c7..3a5ca44d65f3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3443,6 +3443,157 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>  
> +static int add_soft_reserved(resource_size_t start, resource_size_t len,
> +			     unsigned long flags)
> +{
> +	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
> +	int rc;
> +
> +	if (!res)
> +		return -ENOMEM;
> +
> +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
> +
> +	res->desc = IORES_DESC_SOFT_RESERVED;
> +	res->flags = flags;

I'm a bit doubtful about using a define that restricts a bunch of the
elements, then overriding 2 of them immediate after.

DEFINE_RES_NAMED_DESC(start, len, "Soft Reserved", flags | IORESOURCE_MEM,
		      IORES_DESC_SOFT_RESERVED);

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
> +	/* Prevent new usage while removing or adjusting the resource */
> +	guard(mutex)(&cxlrd->range_lock);
> +
> +	/* Aligns at both resource start and end */
> +	if (soft->start == start && soft->end == end)
> +		goto remove;
> +

Might be a clearer flow with else if rather than
a goto.  

> +	/* Aligns at either resource start or end */
> +	if (soft->start == start || soft->end == end) {
> +		if (soft->start == start) {
> +			new_start = end + 1;
> +			new_end = soft->end;
> +		} else {
> +			new_start = soft->start;
> +			new_end = start - 1;
> +		}
> +
> +		rc = add_soft_reserved(new_start, new_end - new_start + 1,
> +				       soft->flags);

This is the remnant of what was there before, but the flags are from
the bit we are dropping?  That feels odd.  They might well be the same
but maybe we need to make that explicit?

> +		if (rc)
> +			dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
> +				 &new_start);
> +
> +		/* Remove the original Soft Reserved resource */
> +		goto remove;
> +	}
> +
> +	/*
> +	 * No alignment. Attempt a 3-way split that removes the part of
> +	 * the resource the region occupied, and then creates new soft
> +	 * reserved resources for the leading and trailing addr space.
> +	 */
> +	new_start = soft->start;
> +	new_end = soft->end;
> +
> +	rc = add_soft_reserved(new_start, start - new_start, soft->flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
> +			 &new_start);
> +
> +	rc = add_soft_reserved(end + 1, new_end - end, soft->flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa + 1\n",
> +			 &end);
> +
> +remove:
> +	rc = remove_resource(soft);
> +	if (rc)
> +		dev_warn(&cxlr->dev, "cannot remove soft reserved resource %pr\n",
> +			 soft);
> +}
> +
> +/*
> + * normalize_resource
> + *
> + * The walk_iomem_res_desc() returns a copy of a resource, not a reference
> + * to the actual resource in the iomem_resource tree. As a result,
> + * __release_resource() which relies on pointer equality will fail.

Probably want some statement on why nothing can race with this give
the resource_lock is not being held.

> + *
> + * This helper walks the children of the resource's parent to find and
> + * return the original resource pointer that matches the given resource's
> + * start and end addresses.
> + *
> + * Return: Pointer to the matching original resource in iomem_resource, or
> + *         NULL if not found or invalid input.
> + */
> +static struct resource *normalize_resource(struct resource *res)
> +{
> +	if (!res || !res->parent)
> +		return NULL;
> +
> +	for (struct resource *res_iter = res->parent->child;
> +	     res_iter != NULL; res_iter = res_iter->sibling) {

I'd move the res_iter != NULL to previous line as it is still under 80 chars.


> +		if ((res_iter->start == res->start) &&
> +		    (res_iter->end == res->end))
> +			return res_iter;
> +	}
> +
> +	return NULL;
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
> +int cxl_region_softreserv_update(void)
> +{
> +	struct device *dev = NULL;
> +
> +	while ((dev = bus_find_next_device(&cxl_bus_type, dev))) {
> +		struct device *put_dev __free(put_device) = dev;
This free is a little bit outside of the constructor and destructor
together rules.

I wonder if bus_for_each_dev() is cleaner here or is there a reason
we have to have released the subsystem lock + grabbed the device
one before calling __cxl_region_softreserv_update?

> +		struct cxl_region *cxlr;
> +
> +		if (!is_cxl_region(dev))
> +			continue;
If you stick to bus_find_X   I wonder if we should define helpers for

the match function and use bus_find_device()

> +
> +		cxlr = to_cxl_region(dev);
> +
> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> +				    IORESOURCE_MEM, 0, -1, cxlr,
> +				    __cxl_region_softreserv_update);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");



