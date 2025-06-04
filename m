Return-Path: <linux-fsdevel+bounces-50619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9459ACE062
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE403A7D03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8092291140;
	Wed,  4 Jun 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrAO6fDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090928F950;
	Wed,  4 Jun 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047738; cv=none; b=FvRvU+YxR1OXskNbHqf+w5QP3LDBN2TXp9DmWbcHGMZuDUUFceQP9QTby1RYW3HteUNvlizbsTXn4A4Xdkg0lzf3S5dbDb9wJoTeYP9C6IZTp0nRQ3467FOe2TrFvNj00G1Jz+ht25yrkb6CrGW8rY8sz88ty8z6GkYRQFFaV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047738; c=relaxed/simple;
	bh=x/HDN8ZE77fRy93+e9zpmrKLhx3xowe0WlDM+Fs+tB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/XBE+EOqNhHF1ezhuKwOt4dn7n4MxH+xM0/tw4mjeMSR3ZWzdRTczbGiTDjPVDF7YCHOdbp24bMFKyRW7bfbCGNuUCM7BGwBloitHT1JGVn0AhezzLeuFVZ7M2s3h8/SOeVP7n1wkjbzhnAAr3mZSWBATQWNaenswGfoNr4aVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrAO6fDh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749047736; x=1780583736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x/HDN8ZE77fRy93+e9zpmrKLhx3xowe0WlDM+Fs+tB8=;
  b=SrAO6fDhDfNVbmjW5MH9sy28n05d3PgxBYTN1LOJItDJDFyBsNy+JNsD
   aRSn0zkxc+CLv0zLGm5d33jcHw1cwEpiDzCcd2gPH6OL70ISH/p7e8IZ1
   pnOYeaj79J2OCWPNZ3FJ4XpnW1dDJZUmJaJX5XD/2uA6RHkkVoANghjrZ
   t6k4tQG19J4wydVYmfKzP2dm4RrRm3YPPbuQCNaIAOZGa4yHUDt0LvqV0
   DZ4osbASI2lcLgJiTIC3ketnbzssEr2xxb7fR5GTlmu2gf9sNY7pwW5GJ
   3cg1uh4nzLwl/E1hmyE5+og7INDWhD8OOYZlXViKg7VHGz1KON97nuBV6
   g==;
X-CSE-ConnectionGUID: 86NMfliHT5mMZMY04cO9tg==
X-CSE-MsgGUID: O/gp1rXESiOu9NhHKoc2/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54924141"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="54924141"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:35:35 -0700
X-CSE-ConnectionGUID: m/5wgwI3TjG4pYN4XeiUAQ==
X-CSE-MsgGUID: BnW7+6TUSMOdwad30rho3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145104296"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:35:34 -0700
Message-ID: <acb0f359-cd4a-4221-a7ba-9c473ad7ecd2@intel.com>
Date: Wed, 4 Jun 2025 07:35:33 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for
 cxl_pci and cxl_mem probe
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
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
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
 <860121d7-4f40-4da5-b49a-cfeea5bc14c5@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <860121d7-4f40-4da5-b49a-cfeea5bc14c5@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/25 2:40 AM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 04/06/2025 06:19, Smita Koralahalli wrote:
>>   drivers/cxl/acpi.c         | 23 +++++++++++++++++++++++
>>   drivers/cxl/core/suspend.c | 21 +++++++++++++++++++++
>>   drivers/cxl/cxl.h          |  2 ++
>>   3 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index cb14829bb9be..978f63b32b41 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -813,6 +813,24 @@ static int pair_cxl_resource(struct device *dev, void *data)
>>   	return 0;
>>   }
>>   
>> +static void cxl_softreserv_mem_work_fn(struct work_struct *work)
>> +{
>> +	/* Wait for cxl_pci and cxl_mem drivers to load */
>> +	cxl_wait_for_pci_mem();
>> +
>> +	/*
>> +	 * Wait for the driver probe routines to complete after cxl_pci
>> +	 * and cxl_mem drivers are loaded.
>> +	 */
>> +	wait_for_device_probe();
>> +}
>> +static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
>> +
>> +static void cxl_softreserv_mem_update(void)
>> +{
>> +	schedule_work(&cxl_sr_work);
>> +}
>> +
>>   static int cxl_acpi_probe(struct platform_device *pdev)
>>   {
>>   	int rc;
>> @@ -887,6 +905,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>>   
>>   	/* In case PCI is scanned before ACPI re-trigger memdev attach */
>>   	cxl_bus_rescan();
>> +
>> +	/* Update SOFT RESERVE resources that intersect with CXL regions */
>> +	cxl_softreserv_mem_update();
>> +
>>   	return 0;
>>   }
>>   
>> @@ -918,6 +940,7 @@ static int __init cxl_acpi_init(void)
>>   
>>   static void __exit cxl_acpi_exit(void)
>>   {
>> +	cancel_work_sync(&cxl_sr_work);
>>   	platform_driver_unregister(&cxl_acpi_driver);
>>   	cxl_bus_drain();
>>   }
>> diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
>> index 72818a2c8ec8..c0d8f70aed56 100644
>> --- a/drivers/cxl/core/suspend.c
>> +++ b/drivers/cxl/core/suspend.c
>> @@ -2,12 +2,15 @@
>>   /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>>   #include <linux/atomic.h>
>>   #include <linux/export.h>
>> +#include <linux/wait.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   
>>   static atomic_t mem_active;
>>   static atomic_t pci_loaded;
>>   
>> +static DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
> 
> Given that this file (suspend.c) focuses on power management functions,
> it might be more appropriate to move the wait queue declaration and its
> related changes to acpi.c in where the its caller is.

You mean drivers/cxl/acpi.c and not drivers/cxl/core/acpi.c right? The core one is my mistake and I'm going to create a patch to remove that.

DJ

> 
> 
> Thanks
> Zhijian
> 
>> +
>>   bool cxl_mem_active(void)
>>   {
>>   	if (IS_ENABLED(CONFIG_CXL_MEM))
>> @@ -19,6 +22,7 @@ bool cxl_mem_active(void)
>>   void cxl_mem_active_inc(void)
>>   {
>>   	atomic_inc(&mem_active);
>> +	wake_up(&cxl_wait_queue);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, "CXL");
>>   
>> @@ -28,8 +32,25 @@ void cxl_mem_active_dec(void)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, "CXL");
>>   
>> +static bool cxl_pci_loaded(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_CXL_PCI))
>> +		return atomic_read(&pci_loaded) != 0;
>> +
>> +	return false;
>> +}
>> +
>>   void mark_cxl_pci_loaded(void)
>>   {
>>   	atomic_inc(&pci_loaded);
>> +	wake_up(&cxl_wait_queue);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(mark_cxl_pci_loaded, "CXL");
>> +
>> +void cxl_wait_for_pci_mem(void)
>> +{
>> +	if (!wait_event_timeout(cxl_wait_queue, cxl_pci_loaded() &&
>> +				cxl_mem_active(), 30 * HZ))
>> +		pr_debug("Timeout waiting for cxl_pci or cxl_mem probing\n");
>> +}


