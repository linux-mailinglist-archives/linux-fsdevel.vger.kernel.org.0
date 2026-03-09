Return-Path: <linux-fsdevel+bounces-79792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGKJK3nermm/JQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:51:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D8123AEAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9275A309A619
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929793D5674;
	Mon,  9 Mar 2026 14:49:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E33B8D7B;
	Mon,  9 Mar 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067795; cv=none; b=kGCFLkx5dl3TKo8JyvgumgUqcfgM7rHa0jsOFx94TuIiNFTALx8GFC5vqa2uObGMfyvxK4Ns0aK2b2G6NzGqLfIKZFEce7Zssj5mLGfgaJG7U1UHu8wPkUFh8sDuBE/BmQ/QG/MZ/6l/eKsWJ220rpDSPxvr2xt5MNdUlHnoisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067795; c=relaxed/simple;
	bh=aY/nndyQ2qNi5ZjInb2yW37UH6h8yddkng1a0uSlcrE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSREEgjdHmHUy9DfPxBxCs3qz+YW9YWaaZHrTTNbxSNAkxB4OXVncZkqQKVPIBhuDt843RtQNZymhWYLL9Ue2a3zxT8C0hklltpQuxPUg8P6xnWSIpxkXKW/OY6XEi/+9Nw+p0Z0vQYVRhck5/7Eyk8n6YQEeGBdNge8ZJYz6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV0KN4LXqzHnGfH;
	Mon,  9 Mar 2026 22:49:44 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C38140572;
	Mon,  9 Mar 2026 22:49:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 14:49:46 +0000
Date: Mon, 9 Mar 2026 14:49:45 +0000
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
Subject: Re: [PATCH v6 7/9] dax: Add deferred-work helpers for dax_hmem and
 dax_cxl coordination
Message-ID: <20260309144945.00006d98@huawei.com>
In-Reply-To: <20260210064501.157591-8-Smita.KoralahalliChannabasappa@amd.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
	<20260210064501.157591-8-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: 10D8123AEAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79792-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.894];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 06:44:59 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Add helpers to register, queue and flush the deferred work.
> 
> These helpers allow dax_hmem to execute ownership resolution outside the
> probe context before dax_cxl binds.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

The sanity checks on valid inputs to me seem excessive for something
that is intended to have a very narrow usecase. I'm also not sure it's
harmful to just not bother with the parameter checking.

Otherwise seems fine to me.

> ---
>  drivers/dax/bus.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/bus.h |  7 ++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 5f387feb95f0..92b88952ede1 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -25,6 +25,64 @@ DECLARE_RWSEM(dax_region_rwsem);
>   */
>  DECLARE_RWSEM(dax_dev_rwsem);
>  
> +static DEFINE_MUTEX(dax_hmem_lock);
> +static dax_hmem_deferred_fn hmem_deferred_fn;
> +static void *dax_hmem_data;
> +
> +static void hmem_deferred_work(struct work_struct *work)
> +{
> +	dax_hmem_deferred_fn fn;
> +	void *data;
> +
> +	scoped_guard(mutex, &dax_hmem_lock) {
> +		fn = hmem_deferred_fn;
> +		data = dax_hmem_data;
> +	}
> +
> +	if (fn)
> +		fn(data);
> +}
> +
> +static DECLARE_WORK(dax_hmem_work, hmem_deferred_work);
> +
> +int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data)
> +{
> +	guard(mutex)(&dax_hmem_lock);
> +
> +	if (hmem_deferred_fn)
> +		return -EINVAL;
What happens if we drop the check and therefore need to return int
from these + handle errors?

The worst that happens is hmem_deferred_fn == NULL and we set the
data (might also be NULL, we don't care).
To me that looks harmless.

> +
> +	hmem_deferred_fn = fn;
> +	dax_hmem_data = data;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dax_hmem_register_work);
> +
> +int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data)
> +{
> +	guard(mutex)(&dax_hmem_lock);
> +
> +	if (hmem_deferred_fn != fn || dax_hmem_data != data)
> +		return -EINVAL;

Do we need the sanity check?  I'd just unconditionally clear them
both.

> +
> +	hmem_deferred_fn = NULL;
> +	dax_hmem_data = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dax_hmem_unregister_work);
> +
> +void dax_hmem_queue_work(void)
> +{
> +	queue_work(system_long_wq, &dax_hmem_work);
> +}
> +EXPORT_SYMBOL_GPL(dax_hmem_queue_work);
> +
> +void dax_hmem_flush_work(void)
> +{
> +	flush_work(&dax_hmem_work);
> +}
> +EXPORT_SYMBOL_GPL(dax_hmem_flush_work);
> +
>  #define DAX_NAME_LEN 30
>  struct dax_id {
>  	struct list_head list;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index cbbf64443098..b58a88e8089c 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -41,6 +41,13 @@ struct dax_device_driver {
>  	void (*remove)(struct dev_dax *dev);
>  };
>  
> +typedef void (*dax_hmem_deferred_fn)(void *data);
> +
> +int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
> +int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data);
> +void dax_hmem_queue_work(void);
> +void dax_hmem_flush_work(void);
> +
>  int __dax_driver_register(struct dax_device_driver *dax_drv,
>  		struct module *module, const char *mod_name);
>  #define dax_driver_register(driver) \


