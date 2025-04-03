Return-Path: <linux-fsdevel+bounces-45684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F221A7A9A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C697A6813
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27365253B51;
	Thu,  3 Apr 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZ1cxQEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2D253334;
	Thu,  3 Apr 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705648; cv=none; b=ny66BZRxZMSOszD2T9nh8nQbw6MZt2SAKsBW/iJYRPjRM8iNkEHVif1P0UFqvHLvt4ixSJk3txyZ6RS+3LaUxXpdnxy86eSUaP3fmj4Yw9eDVQqdaLKJ60DsHZkSdaaOO6PB3LuQ3B/sbC1v1AFaI6b2/diCI3Z/m9owawDhO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705648; c=relaxed/simple;
	bh=+67JXDQx5zChjcnw+v0CCW6m/RXyD81jjti8pA7/2Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVAK8P7jRUmAUW5ntzwug5q1qu0BTteM63iH7KPOG0+yJYOA4WbbfesmqZ+C6aSTvRiNDjsm2GAshwKedEQ7VYfyWtQ56yLU+VsQf6XGWuccq3WGkU+EtNkFIMlr1y2PavJhTTk31tzQlVbvErTipk11ScVSSlB19Z2jIhZaj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZ1cxQEE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743705647; x=1775241647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+67JXDQx5zChjcnw+v0CCW6m/RXyD81jjti8pA7/2Gs=;
  b=HZ1cxQEE9rs7++vCZFtAuNxaFSDCClfvBTuZKsQ/DKqKkQUL5X9zFkPv
   ZQcsv1D/VsZ0sR60dA2n6FoZhC2DX/TYZ7Bwtjp9aFnpWddz3ay9AekBh
   hs0WUIu2pm5Md1lfygKxu5cNg+MOPK8BX1V/Co5uwOO9PHxe9+Ztq9qWr
   HvCcRgyPRafo1K0OhyWjBgcR2iPVsIoDHpXWoQXXwPbQo6SHMEi2P4kpg
   C0W6yhiBJMQy93NqWQxVpEDtQiNHA1dte5Kzo+fLKhMxo8v5Be5rLl2n7
   m5IjNLpLipJACJzG84+TAfqFGY7FyesTrxPoot6HUAjIB8QEbBzxEa9Tt
   w==;
X-CSE-ConnectionGUID: xWp9VgJQSWyNiNQYHmxZPg==
X-CSE-MsgGUID: XsQtsyDSRNmLnDJ7IAFVeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="56499559"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="56499559"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 11:40:46 -0700
X-CSE-ConnectionGUID: TVhG7cbDTtWeBxtqRj9yjw==
X-CSE-MsgGUID: grr0MWSBT7SIPiKQr34ZDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="131215334"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 11:40:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0PUQ-00000008tz0-2eZc;
	Thu, 03 Apr 2025 21:40:34 +0300
Date: Thu, 3 Apr 2025 21:40:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, willy@infradead.org,
	jack@suse.cz, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
	ming.li@zohomail.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com,
	huang.ying.caritas@gmail.com, yaoxt.fnst@fujitsu.com,
	peterz@infradead.org, gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com, ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com, mika.westerberg@linux.intel.com,
	akpm@linux-foundation.org, gourry@gourry.net,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, rrichter@amd.com,
	benjamin.cheatham@amd.com, PradeepVineshReddy.Kodamati@amd.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH v3 1/4] kernel/resource: Provide mem region release for
 SOFT RESERVES
Message-ID: <Z-7WImoc5Dg3Xtyq@smile.fi.intel.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <20250403183315.286710-2-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403183315.286710-2-terry.bowman@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 01:33:12PM -0500, Terry Bowman wrote:
> From: Nathan Fontenot <nathan.fontenot@amd.com>
> 
> Add a release_Sam_region_adjustable() interface to allow for
> removing SOFT RESERVE memory resources. This extracts out the code
> to remove a mem region into a common __release_mem_region_adjustable()
> routine, this routine takes additional parameters of an IORES
> descriptor type to add checks for IORES_DESC_* and a flag to check
> for IORESOURCE_BUSY to control it's behavior.
> 
> The existing release_mem_region_adjustable() is a front end to the
> common code and a new release_srmem_region_adjustable() is added to
> release SOFT RESERVE resources.

...

> +void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
> +{
> +	return __release_mem_region_adjustable(start, size,

You have still room on the previous line for the parameters.

> +					       true, IORES_DESC_NONE);

Return on void?! Interesting... What do you want to do here?

> +}
> +EXPORT_SYMBOL(release_mem_region_adjustable);
> +#endif
> +
> +#ifdef CONFIG_CXL_REGION
> +void release_srmem_region_adjustable(resource_size_t start,
> +				     resource_size_t size)

This can be put on a single line.

> +{
> +	return __release_mem_region_adjustable(start, size,
> +					       false, IORES_DESC_SOFT_RESERVED);

Same comments as per above function.

> +}
> +EXPORT_SYMBOL(release_srmem_region_adjustable);
> +#endif

-- 
With Best Regards,
Andy Shevchenko



