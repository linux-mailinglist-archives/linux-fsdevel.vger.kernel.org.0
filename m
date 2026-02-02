Return-Path: <linux-fsdevel+bounces-76068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBa8IwbfgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:29:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D6CF9BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57487300B9C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0584387360;
	Mon,  2 Feb 2026 17:25:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AE387346;
	Mon,  2 Feb 2026 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053132; cv=none; b=MXQfziNGZlhLPTw8nQ8k5KIUZRUiWhgetDjhSJH9lJ9XWuEa4GYCXzZCvn+JOwLIJ3fnMVmjQPFaFYRrQ7BqO8Xht+syaTGq3i1bQ52nw5fHcrc7ZbDb8CX4vGa6+ANIhErSCA2AWWPlXdCO+OrSvMtv1X+RILQxuyQiHNRBYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053132; c=relaxed/simple;
	bh=hoF5jKgZ38/6WcedCmJApOnqzUjZc+tV/0qLCEH+x9w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvfcwFsIotvrisMmBp4NxucgxZIJLA3POEb/iyqGq+vZY4/vWNbK/qVrFPlOWvH+aywG4A24tyX6IG0sk3mD2k7RP1/FQws0+8qPKJh23PUaUTDvxDD3zLnsRnd6hgC9SnL4Irz/u98Du3okcz90OBqa2s8UCvPtOPf9I+hEbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4YQ50dSKzHnGhY;
	Tue,  3 Feb 2026 01:24:29 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D095B40539;
	Tue,  3 Feb 2026 01:25:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 17:25:25 +0000
Date: Mon, 2 Feb 2026 17:25:24 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <willy@infradead.org>,
	<jack@suse.cz>, <terry.bowman@amd.com>, <john@jagalactic.com>, David
 Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/9] mm/memory_hotplug: add
 __add_memory_driver_managed() with online_type arg
Message-ID: <20260202172524.00000c6d@huawei.com>
In-Reply-To: <20260129210442.3951412-3-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
	<20260129210442.3951412-3-gourry@gourry.net>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76068-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email,huawei.com:mid,gourry.net:email]
X-Rspamd-Queue-Id: 853D6CF9BD
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 16:04:35 -0500
Gregory Price <gourry@gourry.net> wrote:

> Enable dax kmem driver to select how to online the memory rather than
> implicitly depending on the system default.  This will allow users of
> dax to plumb through a preferred auto-online policy for their region.
> 
> Refactor and new interface:
> Add __add_memory_driver_managed() which accepts an explicit online_type
> and export mhp_get_default_online_type() so callers can pass it when
> they want the default behavior.

Hi Gregory,

I think maybe I'd have left the export for the first user outside of
memory_hotplug.c. Not particularly important however.

Maybe talk about why a caller of __add_memory_driver_managed() might want
the default?  Feels like that's for the people who don't...

Or is this all a dance to avoid an

if (special mode)
	__add_memory_driver_managed();
else
	add_memory_driver_managed();
?

Other comments are mostly about using a named enum. I'm not sure
if there is some existing reason why that doesn't work?  -Errno pushed through
this variable or anything like that?

> 
> Refactor:
> Extract __add_memory_resource() to take an explicit online_type parameter,
> and update add_memory_resource() to pass the system default.
> 
> No functional change for existing users.
> 
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  include/linux/memory_hotplug.h |  3 ++
>  mm/memory_hotplug.c            | 91 ++++++++++++++++++++++++----------
>  2 files changed, 67 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f2f16cdd73ee..1eb63d1a247d 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -293,6 +293,9 @@ extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory_resource(int nid, struct resource *resource,
>  			       mhp_t mhp_flags);
> +int __add_memory_driver_managed(int nid, u64 start, u64 size,
> +				const char *resource_name, mhp_t mhp_flags,
> +				int online_type);

Given online_type values are from an enum anyway, maybe we can name that enum and use
it explicitly?

>  extern int add_memory_driver_managed(int nid, u64 start, u64 size,
>  				     const char *resource_name,
>  				     mhp_t mhp_flags);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 87796b617d9e..d3ca95b872bd 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -239,6 +239,7 @@ int mhp_get_default_online_type(void)
>  
>  	return mhp_default_online_type;
>  }
> +EXPORT_SYMBOL_GPL(mhp_get_default_online_type);
>  
>  void mhp_set_default_online_type(int online_type)
>  {
> @@ -1490,7 +1491,8 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>   *
>   * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
>   */
> -int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
> +static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
> +				 int online_type)
>  {
>  	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
>  	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
> @@ -1580,12 +1582,9 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		merge_system_ram_resource(res);
>  
>  	/* online pages if requested */
> -	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
> -		int online_type = mhp_get_default_online_type();
> -
> +	if (online_type != MMOP_OFFLINE)

Ah. Fair enough, ignore comment in previous patch.  I should have read on...

>  		walk_memory_blocks(start, size, &online_type,
>  				   online_memory_block);
> -	}
>  
>  	return ret;
>  error:
> @@ -1601,7 +1600,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	return ret;
>  }
>  
> -/* requires device_hotplug_lock, see add_memory_resource() */
> +int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
> +{
> +	return __add_memory_resource(nid, res, mhp_flags,
> +				     mhp_get_default_online_type());
> +}
> +
> +/* requires device_hotplug_lock, see __add_memory_resource() */
>  int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>  {
>  	struct resource *res;
> @@ -1629,29 +1634,24 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>  }
>  EXPORT_SYMBOL_GPL(add_memory);
>  
> -/*
> - * Add special, driver-managed memory to the system as system RAM. Such
> - * memory is not exposed via the raw firmware-provided memmap as system
> - * RAM, instead, it is detected and added by a driver - during cold boot,
> - * after a reboot, and after kexec.
> - *
> - * Reasons why this memory should not be used for the initial memmap of a
> - * kexec kernel or for placing kexec images:
> - * - The booting kernel is in charge of determining how this memory will be
> - *   used (e.g., use persistent memory as system RAM)
> - * - Coordination with a hypervisor is required before this memory
> - *   can be used (e.g., inaccessible parts).
> +/**
> + * __add_memory_driver_managed - add driver-managed memory with explicit online_type

It's a little odd to add nice kernel-doc formatted documentation
when the non __ variant has free form docs.  Maybe tidy that up first
if we want to go kernel-doc in this file?  (I'm in favor, but no idea
on general feelings...)


> + * @nid: NUMA node ID where the memory will be added
> + * @start: Start physical address of the memory range
> + * @size: Size of the memory range in bytes
> + * @resource_name: Resource name in format "System RAM ($DRIVER)"
> + * @mhp_flags: Memory hotplug flags
> + * @online_type: Online behavior (MMOP_ONLINE, MMOP_ONLINE_KERNEL,
> + *               MMOP_ONLINE_MOVABLE, or MMOP_OFFLINE)

Given that's currently the full set, seems like enum wins out here over
an int.

>   *
> - * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
> - * memory map") are created. Also, the created memory resource is flagged
> - * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
> - * this memory as well (esp., not place kexec images onto it).
> + * Add driver-managed memory with explicit online_type specification.
> + * The resource_name must have the format "System RAM ($DRIVER)".
>   *
> - * The resource_name (visible via /proc/iomem) has to have the format
> - * "System RAM ($DRIVER)".
> + * Return: 0 on success, negative error code on failure.
>   */
> -int add_memory_driver_managed(int nid, u64 start, u64 size,
> -			      const char *resource_name, mhp_t mhp_flags)
> +int __add_memory_driver_managed(int nid, u64 start, u64 size,
> +				const char *resource_name, mhp_t mhp_flags,
> +				int online_type)
>  {
>  	struct resource *res;
>  	int rc;
> @@ -1661,6 +1661,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>  	    resource_name[strlen(resource_name) - 1] != ')')
>  		return -EINVAL;
>  
> +	if (online_type < 0 || online_type > MMOP_ONLINE_MOVABLE)

This is where using an enum would help compiler know what is going on
and maybe warn if anyone writes something that isn't defined.


> +		return -EINVAL;
> +
>  	lock_device_hotplug();
>  
>  	res = register_memory_resource(start, size, resource_name);
> @@ -1669,7 +1672,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>  		goto out_unlock;
>  	}
>  
> -	rc = add_memory_resource(nid, res, mhp_flags);
> +	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
>  	if (rc < 0)
>  		release_memory_resource(res);
>  
> @@ -1677,6 +1680,40 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>  	unlock_device_hotplug();
>  	return rc;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(__add_memory_driver_managed, "kmem");
> +
> +/*
> + * Add special, driver-managed memory to the system as system RAM. Such
> + * memory is not exposed via the raw firmware-provided memmap as system
> + * RAM, instead, it is detected and added by a driver - during cold boot,
> + * after a reboot, and after kexec.
> + *
> + * Reasons why this memory should not be used for the initial memmap of a
> + * kexec kernel or for placing kexec images:
> + * - The booting kernel is in charge of determining how this memory will be
> + *   used (e.g., use persistent memory as system RAM)
> + * - Coordination with a hypervisor is required before this memory
> + *   can be used (e.g., inaccessible parts).
> + *
> + * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
> + * memory map") are created. Also, the created memory resource is flagged
> + * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
> + * this memory as well (esp., not place kexec images onto it).
> + *
> + * The resource_name (visible via /proc/iomem) has to have the format
> + * "System RAM ($DRIVER)".
> + *
> + * Memory will be onlined using the system default online type.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int add_memory_driver_managed(int nid, u64 start, u64 size,
> +			      const char *resource_name, mhp_t mhp_flags)
> +{
> +	return __add_memory_driver_managed(nid, start, size, resource_name,
> +					   mhp_flags,
> +					   mhp_get_default_online_type());
> +}
>  EXPORT_SYMBOL_GPL(add_memory_driver_managed);
>  
>  /*


