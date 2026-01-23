Return-Path: <linux-fsdevel+bounces-75321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFC3C6v2c2nG0QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:31:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2877B2E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 084173014435
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3D928B3E7;
	Fri, 23 Jan 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iigpma0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78515746E;
	Fri, 23 Jan 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769207455; cv=none; b=JbbxZxh9/827lXzbrGC5Mgc2UKEmMVA1Z29RocYcl+mlDHdoJJBsQen+uJo6Ng83K/NkKdoSVMf40a8ujXa72hyU6pzn1fRKImNkS/CvDKnh/3/DGBEV3/Lz/2nE4ioHLA6lWrGi2NdIaE7Amu5X7BH/d5ZII8UvCNJYRTeyYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769207455; c=relaxed/simple;
	bh=0OK0DwI7U7xnEVHoZbV2XqHtqg79ZgkY/oNTcjI66S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qv8RhVQjO55UlRRRbhMDyuYNT3zR4J6tIORqe7z3Fv9P0iUF7z42bAAaWAKVmRvW603yPO5c1aOWJPxfO5g1vykuGdiGeKxExGH31sYVLA/r+JOg5aVwp9jw6kElzpeh757MzYMXZOhwrxWdX1r/DNOz8tW0iQ0LHlWjyCpTXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iigpma0R; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769207454; x=1800743454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0OK0DwI7U7xnEVHoZbV2XqHtqg79ZgkY/oNTcjI66S4=;
  b=iigpma0R8X/RO9qLE8E4lhkvPK9W5GKIhkfty6f2/vcIf7vh6z1yr0Mf
   JTwy7eyD5CX+BG1ircOqowu2v+V4wx1xzYgFG6Vxu5rlUq09cCCuX3vK5
   fNClGjuNT8///g36jtunAk0e6dO7aXqsOj5kgz5gXkdJWE6jyjMXcz3f2
   M/1lQM9Vs4I7Cv3/xrUIA++32W7SbZdWdfTsEsZhAU4+95GQvTcKcmrL9
   JIZok93kcWVu7xlhDUzyGvRFgYtrZOin/S+6PAV/1rsgQOyN+DHruashv
   digNZcUuwK5winwVm3lnzdADTQ7uXipqZl4NjL0iAX+ochQ/5QloJ2UDd
   g==;
X-CSE-ConnectionGUID: hayVobF2T+a5MAPcDmv9qQ==
X-CSE-MsgGUID: Ncbo0KPNQVS+RXvONopb0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81904674"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="81904674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:30:53 -0800
X-CSE-ConnectionGUID: Rl8dD6QCRfKMDTziJfL61g==
X-CSE-MsgGUID: bSILEEdUQCm4h6uF6+LRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="207478302"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.225]) ([10.125.108.225])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:30:50 -0800
Message-ID: <f9504858-55ca-497f-90f7-ecb20c3027e1@intel.com>
Date: Fri, 23 Jan 2026 15:30:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] dax: Introduce dax_cxl_mode for CXL coordination
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
 <20260122045543.218194-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260122045543.218194-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75321-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A2877B2E2
X-Rspamd-Action: no action



On 1/21/26 9:55 PM, Smita Koralahalli wrote:
> Introduce dax_cxl_mode to coordinate between dax_cxl and dax_hmem when
> handling CXL tagged memory ranges.
> 
> This patch defines the dax_cxl_mode enum and establishes a default policy.
> Subsequent patches will wire this into dax_cxl and dax_hmem to decide
> whether CXL tagged memory ranges should be deferred, registered or
> dropped.

Maybe give some more descriptions of what each enum means?

Maybe just fold this into the patch that first utilizes this enum?

> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/dax/bus.c | 3 +++
>  drivers/dax/bus.h | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..72bc5b76f061 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -24,6 +24,9 @@ DECLARE_RWSEM(dax_region_rwsem);
>   */
>  DECLARE_RWSEM(dax_dev_rwsem);
>  
> +enum dax_cxl_mode dax_cxl_mode = DAX_CXL_MODE_DEFER;
> +EXPORT_SYMBOL_GPL(dax_cxl_mode);

Should this symbol only be exported to CXL?

> +
>  #define DAX_NAME_LEN 30
>  struct dax_id {
>  	struct list_head list;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index cbbf64443098..a40cbbf1e26b 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -41,6 +41,14 @@ struct dax_device_driver {
>  	void (*remove)(struct dev_dax *dev);
>  };
>  
> +enum dax_cxl_mode {
> +	DAX_CXL_MODE_DEFER,
> +	DAX_CXL_MODE_REGISTER,
> +	DAX_CXL_MODE_DROP,
> +};
> +
> +extern enum dax_cxl_mode dax_cxl_mode;
> +
>  int __dax_driver_register(struct dax_device_driver *dax_drv,
>  		struct module *module, const char *mod_name);
>  #define dax_driver_register(driver) \


