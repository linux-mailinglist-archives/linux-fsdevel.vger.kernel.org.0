Return-Path: <linux-fsdevel+bounces-77602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME6MCW//lWlHYAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:05:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 753C915882B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C90B3029249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CF346A02;
	Wed, 18 Feb 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsgwiOgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474462638BA;
	Wed, 18 Feb 2026 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437921; cv=none; b=oPOnEGoNyOOmHEGXKKd1qPBTA1eOexAnXVAGXec711QQ/WVWBfraupGi8OT3XlW0tRCmPfa0E1BlwMwrzCDFp3Ne3M9ILuheu/v5R5XZyRHUdzTKRgupQCN1/cTDBCfvVgl4xyzef5/E1J34Hei9DQLkMPFwque/hsPq+03t32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437921; c=relaxed/simple;
	bh=KV/otW9VcwuBIhFD84QOZEGe81GPw4QAdk7QYnmFgcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbsMHXlCAEoyNHGPnbANHFnbeTv0u9dr6qHcyLc7qHDZ5THTPcd8truB54R07avQlbtFlkO/LCzkMZ2XRtV7sEYDC8ET4qHMGo0I/pjCHtKP1I3JX9PQPBfTt45pna1FRRn1I1EJzihy1grpo+QQP14BbfxDalKHPJCA3rRPnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsgwiOgR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771437920; x=1802973920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KV/otW9VcwuBIhFD84QOZEGe81GPw4QAdk7QYnmFgcc=;
  b=MsgwiOgR9czX4iElVO4a/Fx81HitonZQa/+EQWQDxKJj2B+xVQDsm5Ip
   Fv8kXFJPiKTVA3nUiFflb9I9lDu7icsydYduxO5bKPwXqS4EHD8SeNuea
   nAFDiuj2LRJPFQJFPUu9nVj9NE+eoSnN2Dac8jmaPU9o9Ha4Lo406auGq
   LajHuDjENueUtsqkx3naINQ9LhWF/P9+NCCsuw1gXiiTCrH6gtDau350b
   KZKf1IX6YDfaudPbONB7KZJca22HL12gJy/3Dqb178hxUcmMGHumVWB0T
   VuO5Z8gFRcUvoduRD5RHugk59l9sz8pUtZCI8Rq0T0DiQCRP+cTw91avI
   A==;
X-CSE-ConnectionGUID: 5zKYkV2LTmSLOpIbDXXCCw==
X-CSE-MsgGUID: nv4Sru0fQcyyqf6obxlBfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83970821"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83970821"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 10:05:19 -0800
X-CSE-ConnectionGUID: WI90ckUVQdGPqWxPjppRbg==
X-CSE-MsgGUID: RZK+wqc4TRq9kqmdsrSZ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="212590915"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.212]) ([10.125.109.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 10:05:16 -0800
Message-ID: <9c1994f1-7387-4d63-a678-8fd46a0310d1@intel.com>
Date: Wed, 18 Feb 2026 11:05:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] dax/hmem, cxl: Defer and resolve ownership of Soft
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
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77602-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,amd.com:email]
X-Rspamd-Queue-Id: 753C915882B
X-Rspamd-Action: no action



On 2/9/26 11:45 PM, Smita Koralahalli wrote:
> The current probe time ownership check for Soft Reserved memory based
> solely on CXL window intersection is insufficient. dax_hmem probing is not
> always guaranteed to run after CXL enumeration and region assembly, which
> can lead to incorrect ownership decisions before the CXL stack has
> finished publishing windows and assembling committed regions.
> 
> Introduce deferred ownership handling for Soft Reserved ranges that
> intersect CXL windows. When such a range is encountered during dax_hmem
> probe, schedule deferred work and wait for the CXL stack to complete
> enumeration and region assembly before deciding ownership.
> 
> Evaluate ownership of Soft Reserved ranges based on CXL region
> containment.
> 
>    - If all Soft Reserved ranges are fully contained within committed CXL
>      regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>      dax_cxl to bind.
> 
>    - If any Soft Reserved range is not fully claimed by committed CXL
>      region, REGISTER the Soft Reserved ranges with dax_hmem.
> 
> Use dax_cxl_mode to coordinate ownership decisions for Soft Reserved
> ranges. Once, ownership resolution is complete, flush the deferred work
> from dax_cxl before allowing dax_cxl to bind.
> 
> This enforces a strict ownership. Either CXL fully claims the Soft
> reserved ranges or it relinquishes it entirely.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/dax/bus.c       |  3 ++
>  drivers/dax/bus.h       | 19 ++++++++++
>  drivers/dax/cxl.c       |  1 +
>  drivers/dax/hmem/hmem.c | 78 +++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 92b88952ede1..81985bcc70f9 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -25,6 +25,9 @@ DECLARE_RWSEM(dax_region_rwsem);
>   */
>  DECLARE_RWSEM(dax_dev_rwsem);
>  
> +enum dax_cxl_mode dax_cxl_mode = DAX_CXL_MODE_DEFER;
> +EXPORT_SYMBOL_NS_GPL(dax_cxl_mode, "CXL");
> +
>  static DEFINE_MUTEX(dax_hmem_lock);
>  static dax_hmem_deferred_fn hmem_deferred_fn;
>  static void *dax_hmem_data;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index b58a88e8089c..82616ff52fd1 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -41,6 +41,25 @@ struct dax_device_driver {
>  	void (*remove)(struct dev_dax *dev);
>  };
>  
> +/*
> + * enum dax_cxl_mode - State machine to determine ownership for CXL
> + * tagged Soft Reserved memory ranges.
> + * @DAX_CXL_MODE_DEFER: Ownership resolution pending. Set while waiting
> + * for CXL enumeration and region assembly to complete.
> + * @DAX_CXL_MODE_REGISTER: CXL regions do not fully cover Soft Reserved
> + * ranges. Fall back to registering those ranges via dax_hmem.
> + * @DAX_CXL_MODE_DROP: All Soft Reserved ranges intersecting CXL windows
> + * are fully contained within committed CXL regions. Drop HMEM handling
> + * and allow dax_cxl to bind.
> + */
> +enum dax_cxl_mode {
> +	DAX_CXL_MODE_DEFER,
> +	DAX_CXL_MODE_REGISTER,
> +	DAX_CXL_MODE_DROP,
> +};
> +
> +extern enum dax_cxl_mode dax_cxl_mode;
> +
>  typedef void (*dax_hmem_deferred_fn)(void *data);
>  
>  int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index a2136adfa186..3ab39b77843d 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -44,6 +44,7 @@ static struct cxl_driver cxl_dax_region_driver = {
>  
>  static void cxl_dax_region_driver_register(struct work_struct *work)
>  {
> +	dax_hmem_flush_work();
>  	cxl_driver_register(&cxl_dax_region_driver);
>  }
>  
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1e3424358490..85854e25254b 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,7 @@
>  #include <linux/memregion.h>
>  #include <linux/module.h>
>  #include <linux/dax.h>
> +#include <cxl/cxl.h>
>  #include "../bus.h"
>  
>  static bool region_idle;
> @@ -69,8 +70,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>  			      IORES_DESC_CXL) != REGION_DISJOINT) {
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			dax_hmem_queue_work();
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
> @@ -123,8 +134,70 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	return rc;
>  }
>  
> +static int hmem_register_cxl_device(struct device *host, int target_nid,
> +				    const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT)
> +		return hmem_register_device(host, target_nid, res);
> +
> +	return 0;
> +}
> +
> +static int soft_reserve_has_cxl_match(struct device *host, int target_nid,
> +				      const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (!cxl_region_contains_soft_reserve((struct resource *)res))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void process_defer_work(void *data)
> +{
> +	struct platform_device *pdev = data;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	rc = walk_hmem_resources(&pdev->dev, soft_reserve_has_cxl_match);
> +
> +	if (!rc) {
> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		dev_dbg(&pdev->dev, "All Soft Reserved ranges claimed by CXL\n");
> +	} else {
> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +		dev_warn(&pdev->dev,
> +			 "Soft Reserved not fully contained in CXL; using HMEM\n");
> +	}
> +
> +	walk_hmem_resources(&pdev->dev, hmem_register_cxl_device);
> +}
> +
> +static void kill_defer_work(void *data)
> +{
> +	struct platform_device *pdev = data;
> +
> +	dax_hmem_flush_work();
> +	dax_hmem_unregister_work(process_defer_work, pdev);
> +}
> +
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> +	int rc;
> +
> +	rc = dax_hmem_register_work(process_defer_work, pdev);

Do we need to take a reference on pdev when we queue the work?

DJ

> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, pdev);
> +	if (rc)
> +		return rc;
> +
>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>  }
>  
> @@ -174,3 +247,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>  MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
> +MODULE_IMPORT_NS("CXL");


