Return-Path: <linux-fsdevel+bounces-60288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7512B44484
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C93016F190
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5843164AB;
	Thu,  4 Sep 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XI4K3Fcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A930E0DB;
	Thu,  4 Sep 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007360; cv=none; b=e6PLVVW6iK6LWdPRAMQ6tlV/vViSodS5zsL+FjO80uUa1vcIJrcoyUEdZ0fSMCNCI4+970gBLL5V2l6QuxueeSEI8b7s1NKSbLKW0STdtX+9BCvulFMNcxtopHIiyi4RjWiWZnZ0cBI3tUO/1aWBbSJbHK5rD/YBRv+TxGlI8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007360; c=relaxed/simple;
	bh=CRYMSgrsarXvYi1//yRrN7dpQZoWaaGRrmsLjMroS9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDQ2PaixBTROqM8IMD9YU7HtJ9wpauTx7Xn5MCzwLGqCE64nhUU6ou4NRkaj+42DLqZGDLbwCOzQWkN/5udqoXP345JYtxCMchImS1w71n5SKtclHQFTJob5zy7CWUgDRdVqw2zyuJGQASvoq1Mq06k3EsHSgt89Mwhlh563XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XI4K3Fcb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757007359; x=1788543359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CRYMSgrsarXvYi1//yRrN7dpQZoWaaGRrmsLjMroS9s=;
  b=XI4K3Fcb5F9w9/rZd+sovXpUBBejuCqBqJIoco2iGw4CNwYWklddMJ0P
   BupBVJnb6xK02nUukJ36x1w2wr/J+H6IlmVopbEzVVkGTpZ0Lv8p869vc
   E6ZdtuBwYXGGujYCy1CYK6ariAv+KB3MCCs3KuI7XdJv9gx74Y380CVDl
   0S6V76uBKzBsoGv2F21Ck3GBhdv9e3l+ElB2xL6KvASHbhPX+aGhrv7fQ
   CzKSSEam9RnHYNb7yTS1jQRzTVVdkKEbx2Idke1UjYf6K9DZ7oXf3/qbe
   s2Sj+IAW40b2yG5sVFI8DHQUuWvlact75xVvy3ZBJ8cJ2ckWjYA+/wBhh
   g==;
X-CSE-ConnectionGUID: 2mCh0UJwTrWFECSrLJoZFA==
X-CSE-MsgGUID: cnIIHEYVRGGVW5WPPSe+zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58569649"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="58569649"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 10:35:58 -0700
X-CSE-ConnectionGUID: M1fSyPrMSqKYRsjrqVUZaQ==
X-CSE-MsgGUID: 5tFWot6LQXCV9U/ClRxpgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="176289057"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.24]) ([10.125.110.24])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 10:35:56 -0700
Message-ID: <7c8ff1d6-1c74-4f46-a96d-74336451d81a@intel.com>
Date: Thu, 4 Sep 2025 10:35:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dax/hmem: Request cxl_acpi and cxl_pci before walking
 Soft Reserved ranges
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
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250822034202.26896-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 8:41 PM, Smita Koralahalli wrote:
> Ensure that cxl_acpi has published CXL Window resources before dax_hmem
> walks Soft Reserved ranges.
> 
> Replace MODULE_SOFTDEP("pre: cxl_acpi") with an explicit, synchronous
> request_module("cxl_acpi"). MODULE_SOFTDEP() only guarantees eventual
> loading, it does not enforce that the dependency has finished init
> before the current module runs. This can cause dax_hmem to start before
> cxl_acpi has populated the resource tree, breaking detection of overlaps
> between Soft Reserved and CXL Windows.
> 
> Also, request cxl_pci before dax_hmem walks Soft Reserved ranges. Unlike
> cxl_acpi, cxl_pci attach is asynchronous and creates dependent devices
> that trigger further module loads. Asynchronous probe flushing
> (wait_for_device_probe()) is added later in the series in a deferred
> context before dax_hmem makes ownership decisions for Soft Reserved
> ranges.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dax/hmem/hmem.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index d5b8f06d531e..9277e5ea0019 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -146,6 +146,16 @@ static __init int dax_hmem_init(void)
>  {
>  	int rc;
>  
> +	/*
> +	 * Ensure that cxl_acpi and cxl_pci have a chance to kick off
> +	 * CXL topology discovery at least once before scanning the
> +	 * iomem resource tree for IORES_DESC_CXL resources.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEV_DAX_CXL)) {
> +		request_module("cxl_acpi");
> +		request_module("cxl_pci");
> +	}
> +
>  	rc = platform_driver_register(&dax_hmem_platform_driver);
>  	if (rc)
>  		return rc;
> @@ -166,13 +176,6 @@ static __exit void dax_hmem_exit(void)
>  module_init(dax_hmem_init);
>  module_exit(dax_hmem_exit);
>  
> -/* Allow for CXL to define its own dax regions */
> -#if IS_ENABLED(CONFIG_CXL_REGION)
> -#if IS_MODULE(CONFIG_CXL_ACPI)
> -MODULE_SOFTDEP("pre: cxl_acpi");
> -#endif
> -#endif
> -
>  MODULE_ALIAS("platform:hmem*");
>  MODULE_ALIAS("platform:hmem_platform*");
>  MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");


