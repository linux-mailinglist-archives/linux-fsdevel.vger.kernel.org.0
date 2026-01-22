Return-Path: <linux-fsdevel+bounces-75111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHLxEOdacmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:14:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A396AF57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FC11301BEC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E5385520;
	Thu, 22 Jan 2026 16:33:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1243587D9;
	Thu, 22 Jan 2026 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099605; cv=none; b=KaO6V5b4gZxVldpEIIwMvYEvZFf2ucsB2S7pzcksBvsodlI4EJsXQpmi9xPm1cfAsHKO3sJEg3hLfJdQe/yEh4IEqeceuIuFcVap4XKRvfdv3iUJeaxG4nAUIwvx3omwQNPo0MlvIRRjiHtYk2LRSc4GJVhWvEPaRD3mPZ4oMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099605; c=relaxed/simple;
	bh=wn1urjTtvfUYYMyYs8VAtdp6iF2y3WhCtxkayhL+ioU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3Vgvm3AvRGr5Jhd0efFuoPqloejYlv0epc5yNLbJ4fME8aJJCtYtu7oqWozo7eDVOhiOxbqYnoxXDSpaCwHeeayvXU3wDFfiKGqmbN3hPlZcJXI1kGkOpZ8mQqw/L81dX1eZD1a4wwYe+YbkLl1UzPmKnsG5pNLJl1HHY9KghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxmnM5ltlzHnGf4;
	Fri, 23 Jan 2026 00:32:39 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C56264056A;
	Fri, 23 Jan 2026 00:33:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:33:14 +0000
Date: Thu, 22 Jan 2026 16:33:13 +0000
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
Subject: Re: [PATCH v5 5/7] dax: Introduce dax_cxl_mode for CXL coordination
Message-ID: <20260122163313.00003e22@huawei.com>
In-Reply-To: <20260122045543.218194-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
	<20260122045543.218194-6-Smita.KoralahalliChannabasappa@amd.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75111-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,huawei.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09A396AF57
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 04:55:41 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Introduce dax_cxl_mode to coordinate between dax_cxl and dax_hmem when
> handling CXL tagged memory ranges.
> 
> This patch defines the dax_cxl_mode enum and establishes a default policy.
> Subsequent patches will wire this into dax_cxl and dax_hmem to decide
> whether CXL tagged memory ranges should be deferred, registered or
> dropped.
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
I'd suggest kernel-doc for these. Their meaning isn't entirely obvious
from the names.

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


