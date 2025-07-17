Return-Path: <linux-fsdevel+bounces-55196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF688B0815D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 02:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DCA4A7084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25F64A8F;
	Thu, 17 Jul 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe3DokBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0231A288;
	Thu, 17 Jul 2025 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752711889; cv=none; b=WG4u2eiGHTLCyWMGjGrs6PcBM1b7IvVQbIeWdoGBeIeQjPm8xp5AdoCzRiVd3I7HX5c2kXAIBYzOzzdSqljTcrIEuR6lCxEDtEiE4off4r575Bkav+UdbnOf3dfYT7Jl2C7q38E1dfFNovnVAwgkTMYNM+/AAI1bgavkgCphN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752711889; c=relaxed/simple;
	bh=5gJmgbTRrQMfVWOy1sX72w6ivNAjJeQUJjNgPHr1Dck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR1iOC7tkftsAe9KnCgCd06qHFPZY7Sy2Vz9uwjfaf7PcfaPIAFpg6ct+S0o7SKsfwwJsmKvyxNjoiblkcJzdF2uiSQQRWuHl2H9wxpAmuaQTb0OPJ0yJ4xf4Bhk5oFdaBeVUMOyCdiycuioQG+FttiAwMYqpNiFY/fFoysu398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe3DokBH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752711887; x=1784247887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5gJmgbTRrQMfVWOy1sX72w6ivNAjJeQUJjNgPHr1Dck=;
  b=fe3DokBHYcocJ9s14QzsMHKIU6c/0FV1pX20ZnnoYV8+nE8SWJY2MexL
   WGBA32C/sQcrklEJfJ7tlQ3F+u3eyRi/iAiPPPKWK7BH1bWnEB1x+Rp0n
   hvovFKc3kgEFcekcMa0wlai/vBA+PF9l/TFsTUmKqR4gb2dqUMYw/3Dk7
   DgZz1eltlMfXkVsikvwUvOm6ECBm597jgxc8QrVWHI1i5YrbiQOY8huIA
   yJxpk+CukM2NuXPv3JnKSdvxRQzYBGZJJfOI2q/XktSAlucOqWpcEYMHn
   9L7Cs02nbs50lmqjjg0NfQlPT1uJmsWgYkD9PnOGfstRJ5G1KJl9/S9Cm
   Q==;
X-CSE-ConnectionGUID: W/2UIa+yQK6fh1LGEud3ww==
X-CSE-MsgGUID: 0f/tOMzkSgOOU2dU63MIuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54911304"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="54911304"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:24:46 -0700
X-CSE-ConnectionGUID: EZpvW2tBQRSPAf8btuT1fw==
X-CSE-MsgGUID: oz9icJBnQB+Fr7++Lp2gSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="188593018"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:24:44 -0700
Message-ID: <f4ec25ff-9f7e-464e-ae39-924e810b74c8@intel.com>
Date: Wed, 16 Jul 2025 17:24:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
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
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/25 11:04 AM, Smita Koralahalli wrote:
> Introduce a background worker in cxl_acpi to delay SOFT RESERVE handling
> until the cxl_mem driver has probed at least one device. This coordination
> ensures that DAX registration or fallback handling for soft-reserved
> regions is not triggered prematurely.
> 
> The worker waits on cxl_wait_queue, which is signaled via
> cxl_mem_active_inc() during cxl_mem_probe(). Once at least one memory
> device probe is confirmed, the worker invokes wait_for_device_probe()
> to allow the rest of the CXL device hierarchy to complete initialization.
> 
> Additionally, it also handles initialization order issues where
> cxl_acpi_probe() may complete before other drivers such as cxl_port or
> cxl_mem have loaded, especially when cxl_acpi and cxl_port are built-in
> and cxl_mem is a loadable module. In such cases, using only
> wait_for_device_probe() is insufficient, as it may return before all
> relevant probes are registered.
> 
> While region creation happens in cxl_port_probe(), waiting on
> cxl_mem_active() would be sufficient as cxl_mem_probe() can only succeed
> after the port hierarchy is in place. Furthermore, since cxl_mem depends
> on cxl_pci, this also guarantees that cxl_pci has loaded by the time the
> wait completes.
> 
> As cxl_mem_active() infrastructure already exists for tracking probe
> activity, cxl_acpi can use it without introducing new coordination
> mechanisms.
> 
> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/acpi.c             | 18 ++++++++++++++++++
>  drivers/cxl/core/probe_state.c |  5 +++++
>  drivers/cxl/cxl.h              |  2 ++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index ca06d5acdf8f..3a27289e669b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -823,6 +823,20 @@ static int pair_cxl_resource(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static void cxl_softreserv_mem_work_fn(struct work_struct *work)
> +{
> +	if (!wait_event_timeout(cxl_wait_queue, cxl_mem_active(), 30 * HZ))
> +		pr_debug("Timeout waiting for cxl_mem probing");
> +
> +	wait_for_device_probe();
> +}
> +static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
> +
> +static void cxl_softreserv_mem_update(void)
> +{
> +	schedule_work(&cxl_sr_work);
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc = 0;
> @@ -903,6 +917,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	cxl_bus_rescan();
>  
>  out:
> +	/* Update SOFT RESERVE resources that intersect with CXL regions */
> +	cxl_softreserv_mem_update();

Can you please squash 1/7 with this patch since both are fairly small? Otherwise it leaves the reviewer wonder what the changes in 1/7 would result in.

DJ

> +
>  	return rc;
>  }
>  
> @@ -934,6 +951,7 @@ static int __init cxl_acpi_init(void)
>  
>  static void __exit cxl_acpi_exit(void)
>  {
> +	cancel_work_sync(&cxl_sr_work);
>  	platform_driver_unregister(&cxl_acpi_driver);
>  	cxl_bus_drain();
>  }
> diff --git a/drivers/cxl/core/probe_state.c b/drivers/cxl/core/probe_state.c
> index 5ba4b4de0e33..3089b2698b32 100644
> --- a/drivers/cxl/core/probe_state.c
> +++ b/drivers/cxl/core/probe_state.c
> @@ -2,9 +2,12 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  #include <linux/atomic.h>
>  #include <linux/export.h>
> +#include <linux/wait.h>
>  #include "cxlmem.h"
>  
>  static atomic_t mem_active;
> +DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
> +EXPORT_SYMBOL_NS_GPL(cxl_wait_queue, "CXL");
>  
>  bool cxl_mem_active(void)
>  {
> @@ -13,10 +16,12 @@ bool cxl_mem_active(void)
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_active, "CXL");
>  
>  void cxl_mem_active_inc(void)
>  {
>  	atomic_inc(&mem_active);
> +	wake_up(&cxl_wait_queue);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, "CXL");
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..3117136f0208 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -903,6 +903,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +extern wait_queue_head_t cxl_wait_queue;
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.


