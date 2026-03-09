Return-Path: <linux-fsdevel+bounces-79790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPKPBufbrmm/JQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:40:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E723AB1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE27A3019E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353BF3D331E;
	Mon,  9 Mar 2026 14:37:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463C3C3C00;
	Mon,  9 Mar 2026 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067072; cv=none; b=Y3DxzIAuAWbWYr+WVNuyskRWjmLua/xpHFJ3eVrf0tH2lWDbT8gG0sF9IFRoUgzDE1ZEwvOpttS8X8gN0u3laqKTcHCTmaqVUx2cHVL9Ox6FYdKWDfg6bWJ+0cZX7HkOMPvRAHRBQ6FC597JAXA1fBQwjVubJvSgnIa861Fwcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067072; c=relaxed/simple;
	bh=9zZLfNMC2c49UfYD8f5c65mEQnz14cRh4NmSK0J6fBA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biTe2sioUHui+6/nIPugUraY0/loLfaYYqLr9rYzN2fTj6D5bL/mSo9mjLUq1g8xkNW1RhmqiHFmi8wl3zfU4hWBL6aBlmwavjaWnGBQY9mrReAMF/+L9bprS6BMG7xP6B47UprCXy5Ll+WoaZxFx4Mt4d4lyGsK3Nkuw7I2mNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV02n5Nt0zJ46F6;
	Mon,  9 Mar 2026 22:37:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C860840086;
	Mon,  9 Mar 2026 22:37:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 14:37:47 +0000
Date: Mon, 9 Mar 2026 14:37:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Matthew
 Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, "Peter Zijlstra"
	<peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, Borislav
 Petkov <bp@alien8.de>, Tomasz Wolski <tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v6 5/9] dax: Track all dax_region allocations under a
 global resource tree
Message-ID: <20260309143746.000047ee@huawei.com>
In-Reply-To: <20260210064501.157591-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
	<20260210064501.157591-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: 161E723AB1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79790-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.891];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,intel.com:email,huawei.com:mid]
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 06:44:57 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

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

One question inline about the locking.

Is intent to serialize beyond this new resource tree?  If it's just
the resource tree the write_lock(&resource_lock); in the request
and release_resource() should be sufficient.  

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

Do we need the locking? resource stuff all runs under the global
resource_lock so if aim is just to serialize adds and removes that should
be enough. Maybe there is a justification in that being an internal
implementation detail.



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


