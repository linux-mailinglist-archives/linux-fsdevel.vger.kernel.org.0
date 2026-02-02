Return-Path: <linux-fsdevel+bounces-76067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCVpD5DbgGnMBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:14:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DE6CF6FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67F8030354AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640882749CF;
	Mon,  2 Feb 2026 17:10:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331837F8AB;
	Mon,  2 Feb 2026 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052238; cv=none; b=Nc+3kAt0nKt/4w9lIQp3Ac7vm0fxysPMebh3VgxOaogUc1a8/CDi7moNzgFNVHa5R7yLB3KO+ZS9gU0ez3oly2h8IfdjtLOSTPH5x+G8A72RPCTlaKU8rAUKy4JgeZ30PKRwN23CuecZzFa9inzCd+PZZknQnD0AscEWa4AWgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052238; c=relaxed/simple;
	bh=BFT3dnWEA+7ssrBLWeG8GNPu5/m9uhKGFMIFPdtHTwE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5CYsDncTsY3+TXrFQM0bWW0aW82kdwJYtdaORxUzU5ekoXfs3dw8Xsu8pGMvwAn/iTihVrlHo0CP+nKeqkFfm8dZ7ZVffdCQmI93a8Otvbha94hnMW0TRUYLFyZaPSEU9NmTEOHARRaHw6QrYp8FnNpWhHWpRpjUqpNZTFfvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4Y4t15BnzHnGh6;
	Tue,  3 Feb 2026 01:09:34 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id DB47B40086;
	Tue,  3 Feb 2026 01:10:31 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 17:10:30 +0000
Date: Mon, 2 Feb 2026 17:10:29 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <willy@infradead.org>,
	<jack@suse.cz>, <terry.bowman@amd.com>, <john@jagalactic.com>, Oscar Salvador
	<osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH 1/9] mm/memory_hotplug: pass online_type to
 online_memory_block() via arg
Message-ID: <20260202171029.00005e80@huawei.com>
In-Reply-To: <20260129210442.3951412-2-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
	<20260129210442.3951412-2-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76067-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,huawei.com:mid,huawei.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: D0DE6CF6FA
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 16:04:34 -0500
Gregory Price <gourry@gourry.net> wrote:

> Modify online_memory_block() to accept the online type through its arg
> parameter rather than calling mhp_get_default_online_type() internally.
> This prepares for allowing callers to specify explicit online types.
> 
> Update the caller in add_memory_resource() to pass the default online
> type via a local variable.
> 
> No functional change.
> 
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Trivial comment inline. I don't really care either way.
Pushing the policy up to the caller and ensuring it's explicitly constant
for all the memory blocks (as opposed to relying on locks) seems sensible to me
even without anything else.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  mm/memory_hotplug.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bc805029da51..87796b617d9e 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1337,7 +1337,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
>  
>  static int online_memory_block(struct memory_block *mem, void *arg)
>  {
> -	mem->online_type = mhp_get_default_online_type();
> +	int *online_type = arg;
> +
> +	mem->online_type = *online_type;
>  	return device_online(&mem->dev);
>  }
>  
> @@ -1578,8 +1580,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		merge_system_ram_resource(res);
>  
>  	/* online pages if requested */
> -	if (mhp_get_default_online_type() != MMOP_OFFLINE)
> -		walk_memory_blocks(start, size, NULL, online_memory_block);
> +	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
> +		int online_type = mhp_get_default_online_type();

Maybe move the local variable outside the loop to avoid the double call.

> +
> +		walk_memory_blocks(start, size, &online_type,
> +				   online_memory_block);
> +	}
>  
>  	return ret;
>  error:


