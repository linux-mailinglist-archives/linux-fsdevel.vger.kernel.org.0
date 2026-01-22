Return-Path: <linux-fsdevel+bounces-75116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAd4O9hbcmn5iwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:18:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EE6B06A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4DFA300F86F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88C3DC960;
	Thu, 22 Jan 2026 16:40:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAF3DC5AD;
	Thu, 22 Jan 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100007; cv=none; b=b0ok8vBAUE5iWVA+BGDi1lTeGoSNS/LYQCzcPOntEQ68+Mgk8AKa5s29djssxFCnkMt0jTafw0WXMezCLA2mPXmkE3vP28EjtBrFgeueOAXLsKQ6MK4kVasS8xo/I29lJ624tG3JXMghzBcXSr0f1IKW2DIVqSTLAsjz7ahr/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100007; c=relaxed/simple;
	bh=Y/GejnuGHd0FcnD1vOPIOyknHojP1QImfAW2WsEPUx8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2SIiIdxYasSaNSeENmSTpDVw8wgXTnG6QfRtH7A/caXKza/hddUp85v/ScJBwompuVvfRh73/C45TpC5t3V4LRF13k8oUI9o5G/IYSfbySwz4zngo7+lDta5BIdqQn7VREKwfeLapxU4DEDZT+y2DhjMz+1fMxbo+xvs+B+fE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxmwz4d18zHnGdq;
	Fri, 23 Jan 2026 00:39:15 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A1D8940584;
	Fri, 23 Jan 2026 00:39:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:39:50 +0000
Date: Thu, 22 Jan 2026 16:39:48 +0000
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
Subject: Re: [PATCH v5 7/7] dax/hmem: Reintroduce Soft Reserved ranges back
 into the iomem tree
Message-ID: <20260122163948.00007ff6@huawei.com>
In-Reply-To: <20260122045543.218194-8-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
	<20260122045543.218194-8-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75116-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,huawei.com:mid,huawei.com:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fujitsu.com:email]
X-Rspamd-Queue-Id: C26EE6B06A
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 04:55:43 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
> 
> Reintroduce Soft Reserved range into the iomem_resource tree for HMEM
> to consume.
> 
> This restores visibility in /proc/iomem for ranges actively in use, while
> avoiding the early-boot conflicts that occurred when Soft Reserved was
> published into iomem before CXL window and region discovery.
> 
> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
> Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
A few minor things from a fresh read.
> ---
>  drivers/dax/hmem/hmem.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index bcb57d8678d7..f3ef4faf158f 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -64,6 +64,34 @@ struct dax_defer_work {
>  	struct work_struct work;
>  };
>  
> +static void remove_soft_reserved(void *r)
> +{
> +	remove_resource(r);
> +	kfree(r);
> +}
> +
> +static int add_soft_reserve_into_iomem(struct device *host,
> +				       const struct resource *res)
> +{
> +	struct resource *soft __free(kfree) =
> +		kzalloc(sizeof(*soft), GFP_KERNEL);

On one line. I think it's exactly 80 chars.

> +	int rc;
> +
The declaration and check should be together. For __free stuff inline declarations
are preferred.

You fully assign it so kmalloc is all that's needed.
	
	
	struct resource *soft __free(kfree) = kzalloc(sizeof(*soft), GFP_KERNEL);
	if (!soft)

If not, just switch the two declarations.

> +	if (!soft)
> +		return -ENOMEM;
> +
> +	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
> +				      "Soft Reserved", IORESOURCE_MEM,
> +				      IORES_DESC_SOFT_RESERVED);
> +
> +	rc = insert_resource(&iomem_resource, soft);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(host, remove_soft_reserved,
> +					no_free_ptr(soft));
> +}
> +
>  static int hmem_register_device(struct device *host, int target_nid,
>  				const struct resource *res)
>  {
> @@ -94,7 +122,9 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	if (rc != REGION_INTERSECTS)
>  		return 0;
>  
> -	/* TODO: Add Soft-Reserved memory back to iomem */
> +	rc = add_soft_reserve_into_iomem(host, res);
> +	if (rc)
> +		return rc;
>  
>  	id = memregion_alloc(GFP_KERNEL);
>  	if (id < 0) {


