Return-Path: <linux-fsdevel+bounces-75322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKv0In/8c2mf0gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:55:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D27B4C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCFB33006B72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EBE255F3F;
	Fri, 23 Jan 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfrXqWhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5C2D8375;
	Fri, 23 Jan 2026 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208954; cv=none; b=Ioh90rzE08KZ+uI4Yo7CN1RzTPHwljAPWNzOW3H5H0JpMr+y5ABQIDJajkrchhPVDEB/dNRtV3qfT+/yp5dN600lWcj9v67eyNVKWV8ZvIPrUMdDkDO9uaz0cL98qcZQXZux3r6TgvpqmlrCRayc1q9Vnq4rjf8prPlxSAqMghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208954; c=relaxed/simple;
	bh=qc5PJE1kXd2KE97QOmmdiO+WZTUjEX2gOoIhJxPb0Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmwdK2yZL/I5MCrEwtlUknuESxGRlcWY2stj+T90q7BfBRc6mMA0I0mMyTAhLLM/7ZQU2Mcg0Iyas2uXSWofGvGreBkcmL6SRDxzxObuxwaGdiXBa+ICc8Nom9wdrYeKe90ioMzd56UX02Ucu6oksrYNrGIqUW0A7eI/N++yKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfrXqWhN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769208953; x=1800744953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qc5PJE1kXd2KE97QOmmdiO+WZTUjEX2gOoIhJxPb0Aw=;
  b=dfrXqWhNq7KnYC/0epgSjJhMxRPh4tdGx5hrM0vS5QyrFlXPoD6xCNF1
   xvANeugYRr9qOKpP5etmiouin64aV9Gou6le0eNx7r7dddTQ/ROG9mQ7v
   8+Dmq3WgrRazrs1etm8pxQ4oNbo5/iTUdVv1U/qoHYXaqkE2hsbc5medh
   lQxIu3A/mIWhF52Tu4795mpIiJbKhIF/JzCwD2XzO49UHSMbMkwTW0JfL
   rIBubMPxMjBTb4HkDC3UhW7z/kHTbe8huFvTuWJ+6a2Kc49hxEJQR/DZX
   v8sUFM6pigw8TCRCkGlB/6pkPdEcqScPcexkBZ5WjUuqKJXJBaFmSBlww
   Q==;
X-CSE-ConnectionGUID: F1NyfEuJRSOyCI11HIOV+Q==
X-CSE-MsgGUID: KMLWaI3ZQ2Cu2lH3PQ2kbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="87882601"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="87882601"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:55:52 -0800
X-CSE-ConnectionGUID: lSX315IhQ8G6LcCIk6+vhQ==
X-CSE-MsgGUID: NzrG0BXpQI+vcYqn79xg/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="211261193"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.225]) ([10.125.108.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:55:50 -0800
Message-ID: <7ca8de5a-94d0-4b38-8ea4-68bac2dd09a1@intel.com>
Date: Fri, 23 Jan 2026 15:55:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75322-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,amd.com:email]
X-Rspamd-Queue-Id: E64D27B4C0
X-Rspamd-Action: no action



On 1/21/26 9:55 PM, Smita Koralahalli wrote:
> The current probe time ownership check for Soft Reserved memory based
> solely on CXL window intersection is insufficient. dax_hmem probing is not
> always guaranteed to run after CXL enumeration and region assembly, which
> can lead to incorrect ownership decisions before the CXL stack has
> finished publishing windows and assembling committed regions.
> 
> Introduce deferred ownership handling for Soft Reserved ranges that
> intersect CXL windows at probe time by scheduling deferred work from
> dax_hmem and waiting for the CXL stack to complete enumeration and region
> assembly before deciding ownership.
> 
> Evaluate ownership of Soft Reserved ranges based on CXL region
> containment.
> 
>    - If all Soft Reserved ranges are fully contained within committed CXL
>      regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>      dax_cxl to bind.
> 
>    - If any Soft Reserved range is not fully claimed by committed CXL
>      region, tear down all CXL regions and REGISTER the Soft Reserved
>      ranges with dax_hmem instead.
> 
> While ownership resolution is pending, gate dax_cxl probing to avoid
> binding prematurely.
> 
> This enforces a strict ownership. Either CXL fully claims the Soft
> Reserved ranges or it relinquishes it entirely.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 25 ++++++++++++
>  drivers/cxl/cxl.h         |  2 +
>  drivers/dax/cxl.c         |  9 +++++
>  drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9827a6dd3187..6c22a2d4abbb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_region_debugfs_poison_clear, "%llx\n");
>  
> +static int cxl_region_teardown_cb(struct device *dev, void *data)
> +{
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region *cxlr;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +
> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +
> +	return 0;
> +}
> +
> +void cxl_region_teardown_all(void)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
> +}
> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
> +
>  static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>  {
>  	struct resource *res = data;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b0ff6b65ea0b..1864d35d5f69 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>  bool cxl_region_contains_soft_reserve(const struct resource *res);
> +void cxl_region_teardown_all(void);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>  {
>  	return false;
>  }
> +static inline void cxl_region_teardown_all(void) { }
>  #endif
>  
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..b7e90d6dd888 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
>  
> +	switch (dax_cxl_mode) {
> +	case DAX_CXL_MODE_DEFER:
> +		return -EPROBE_DEFER;
> +	case DAX_CXL_MODE_REGISTER:
> +		return -ENODEV;
> +	case DAX_CXL_MODE_DROP:
> +		break;
> +	}
> +
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>  
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1e3424358490..bcb57d8678d7 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,7 @@
>  #include <linux/memregion.h>
>  #include <linux/module.h>
>  #include <linux/dax.h>
> +#include "../../cxl/cxl.h"

Would it make sense to move what common definitions you need to include/cxl/cxl.h?

DJ

>  #include "../bus.h"
>  
>  static bool region_idle;
> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> +struct dax_defer_work {
> +	struct platform_device *pdev;
> +	struct work_struct work;
> +};
> +
>  static int hmem_register_device(struct device *host, int target_nid,
>  				const struct resource *res)
>  {
> +	struct dax_defer_work *work = dev_get_drvdata(host);
>  	struct platform_device *pdev;
>  	struct memregion_info info;
>  	long id;
> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>  			      IORES_DESC_CXL) != REGION_DISJOINT) {
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			schedule_work(&work->work);
> +			return 0;
> +		case DAX_CXL_MODE_REGISTER:
> +			dev_dbg(host, "registering CXL range: %pr\n", res);
> +			break;
> +		case DAX_CXL_MODE_DROP:
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> +			return 0;
> +		}
>  	}
>  
>  	rc = region_intersects_soft_reserve(res->start, resource_size(res));
> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	return rc;
>  }
>  
> +static int cxl_contains_soft_reserve(struct device *host, int target_nid,
> +				     const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (!cxl_region_contains_soft_reserve(res))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void process_defer_work(struct work_struct *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +	struct platform_device *pdev = work->pdev;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
> +
> +	if (!rc) {
> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		rc = bus_rescan_devices(&cxl_bus_type);
> +		if (rc)
> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
> +	} else {
> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +		cxl_region_teardown_all();
> +	}
> +
> +	walk_hmem_resources(&pdev->dev, hmem_register_device);
> +}
> +
> +static void kill_defer_work(void *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +
> +	cancel_work_sync(&work->work);
> +	kfree(work);
> +}
> +
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> +	int rc;
> +
> +	if (!work)
> +		return -ENOMEM;
> +
> +	work->pdev = pdev;
> +	INIT_WORK(&work->work, process_defer_work);
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> +	if (rc)
> +		return rc;
> +
> +	platform_set_drvdata(pdev, work);
> +
>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>  }
>  
> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>  MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
> +MODULE_IMPORT_NS("CXL");


