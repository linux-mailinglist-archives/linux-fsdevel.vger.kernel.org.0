Return-Path: <linux-fsdevel+bounces-77592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE9ZNzzjlWmrVwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:05:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B469157982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1810530209F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CC344040;
	Wed, 18 Feb 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZng8OTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C527FD40;
	Wed, 18 Feb 2026 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430701; cv=none; b=sE/HHAAoEq7CoWbnXgyEbJLW4ak2olu5cZJ1CRSlvGjnC9ArTOiZZKUKdCnaCf7C9CkhETSUN/TVpNXdWh2k3otPSTXqeVs51WTAewiFujOZOE9kAvtIOdtLgKPvkkl3I9gr+7iXuPe7dyY/aWL2lwBeUR1lOYuSBd2WaE0X/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430701; c=relaxed/simple;
	bh=jfnbMnFqB31FkL8fUDzsdjgyqkLz50CEZHl1Q8y2fck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VffEWwkXHLuS2ggezRaDJzvOewI5RZSCX2Q7FcWMVs47LVMB8vCUPGWZQjmFa0cfsDG2+DgZx/RcSx90l7tG0LJtTXGMaS+ceQNvVgzRx+Eybaa9zpjJUXSCViMjo1MltcNHexHQth1YDvyLFOwKIuSw4MuJBGYHkAMnSrTvG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZng8OTW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771430700; x=1802966700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jfnbMnFqB31FkL8fUDzsdjgyqkLz50CEZHl1Q8y2fck=;
  b=fZng8OTWyfZYLDdHpLVbaZ8Q3cW1uEZ+xx5OuIpEzhYaIIVkJV1uF0of
   zbZOJpEVXZEPu9Z7nABFNZp4z/MkTpdmsdt/Rp4EXoAYo0Di+IXssmYMW
   3HpFr1oIGKCrifxPJg4YckXwPiXvHyniuQhIMkyrBF4H9EWD2iG5Yr2Sk
   tx/6KWvS56Q69lZk9FU+8dGqzqNXlrrdE2YaFVyt3La0fJd0Op9VJ22wh
   DY92hCZRlYMI+sMPuFrE6g5XhSarzBi4/7amCpy3Zw5JvKk08bGIwSiwd
   1AqzRTQbPqTkhctkVlO81u5DOcwkMhIeRQlmvp4daOghjmU3zH4IloxkR
   Q==;
X-CSE-ConnectionGUID: tuTv7uSGSW+5JGOT9T/6hw==
X-CSE-MsgGUID: lt//4F1STpaZqYeHfPBzwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83132752"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83132752"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:04:59 -0800
X-CSE-ConnectionGUID: /fb4gbLnS6e0K8xWnPiYcw==
X-CSE-MsgGUID: yThti8vYRei3egf6s2kSNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="212313339"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.212]) ([10.125.109.212])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:04:56 -0800
Message-ID: <7c551ba8-2d0e-4df4-a698-19cad4b78977@intel.com>
Date: Wed, 18 Feb 2026 09:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] dax: Track all dax_region allocations under a
 global resource tree
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
 <20260210064501.157591-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260210064501.157591-6-Smita.KoralahalliChannabasappa@amd.com>
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
	TAGGED_FROM(0.00)[bounces-77592-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,amd.com:email]
X-Rspamd-Queue-Id: 3B469157982
X-Rspamd-Action: no action



On 2/9/26 11:44 PM, Smita Koralahalli wrote:
> Introduce a global "DAX Regions" resource root and register each
> dax_region->res under it via request_resource(). Release the resource on
> dax_region teardown.
> 
> By enforcing a single global namespace for dax_region allocations, this
> ensures only one of dax_hmem or dax_cxl can successfully register a
> dax_region for a given range.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dax/bus.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..5f387feb95f0 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -10,6 +10,7 @@
>  #include "dax-private.h"
>  #include "bus.h"
>  
> +static struct resource dax_regions = DEFINE_RES_MEM_NAMED(0, -1, "DAX Regions");
>  static DEFINE_MUTEX(dax_bus_lock);
>  
>  /*
> @@ -625,6 +626,8 @@ static void dax_region_unregister(void *region)
>  {
>  	struct dax_region *dax_region = region;
>  
> +	scoped_guard(rwsem_write, &dax_region_rwsem)
> +		release_resource(&dax_region->res);
>  	sysfs_remove_groups(&dax_region->dev->kobj,
>  			dax_region_attribute_groups);
>  	dax_region_put(dax_region);
> @@ -635,6 +638,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  		unsigned long flags)
>  {
>  	struct dax_region *dax_region;
> +	int rc;
>  
>  	/*
>  	 * The DAX core assumes that it can store its private data in
> @@ -667,14 +671,27 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  		.flags = IORESOURCE_MEM | flags,
>  	};
>  
> -	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
> -		kfree(dax_region);
> -		return NULL;
> +	scoped_guard(rwsem_write, &dax_region_rwsem)
> +		rc = request_resource(&dax_regions, &dax_region->res);
> +	if (rc) {
> +		dev_dbg(parent, "dax_region resource conflict for %pR\n",
> +			&dax_region->res);
> +		goto err_res;
>  	}
>  
> +	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups))
> +		goto err_sysfs;
> +
>  	if (devm_add_action_or_reset(parent, dax_region_unregister, dax_region))
>  		return NULL;
>  	return dax_region;
> +
> +err_sysfs:
> +	scoped_guard(rwsem_write, &dax_region_rwsem)
> +		release_resource(&dax_region->res);
> +err_res:
> +	kfree(dax_region);
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(alloc_dax_region);
>  


