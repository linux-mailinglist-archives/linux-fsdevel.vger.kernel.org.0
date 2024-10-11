Return-Path: <linux-fsdevel+bounces-31646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E59997D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 02:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022E11C23D41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 00:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9E18787F;
	Fri, 11 Oct 2024 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J71GMo7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF172107;
	Fri, 11 Oct 2024 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606004; cv=fail; b=mY+NxKidT3m8L+ktDzkyCEWrdqij4dA3bOZ5ddbkU55rDlX2vqbv83MjlNRmwP9MIwEJ2bfn5UelQ2eNjWkStprERi3wLwW0Y3AJxj3Hpvd3uXnuyqrw+iTz4OBprhoU/R5DD8U2iXxbUdrtpJNqPHDigsOcGvbedJiCThc9/qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606004; c=relaxed/simple;
	bh=QROi5C7c+iUQLmkJDrl8OFF4b8bYVoX9c8LtcF1abI4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=FFpAyDcPukLinczVF5mYwgdxrIShv8rW1VBXgqmKaRqvtlE5iKB6w/3ht8A16dETF3KRJUtAJVD5fbDwXshHqPaJTEb2gzTjYLHKjF2NyCWTSbK1bye6/LjL71C6ib6PDHB5k3odRy5F5zQxd9yiVePbp1/hn5DAEbnSat9xmjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J71GMo7o; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwBqXTSyZBkx5+kXv1LXj2edMfqG4bLPW6eIOdeAn/8y5EV9Cn3BngFwwP34vb1D2zkCd98cMdajQ8LUr2qfsJRSxe6fi/5K6bk1y/lBTdsNOS71z5Zwc5jzI5KLodYo6M/aB7Bi13fERmj8rFWB48wl6ejN2lx7y0TKC2klTqAx3eARwHJUnAy7oyB2czLYl+O9as2l/VPJNJYmGtAHzfHBNdesXICsVR5EjsS4tuFxZ0uFZF6LTUWVlvfKFQYjKW3sx4uYH6I7y4ueWydze4DLiedb4uiagohkJiAYUbAoyU/XHHkfVnfgsIotzSvgAN5qW18WlIIgISWTix+zOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6Tzpq3BX8iqwYIQyHk+sqXAQoU6Nczpy+Lk/2ZDWB0=;
 b=fNjIBlbEYtlK/HFhzNBKygdKQQ/JnV4ApIxQZVd6b2opd0swQicpxizFBlELOcCn9ilwPDQyDF8YrsOw/m2wemP/pigJk3e2JJ9fjtbRdso89u6esljkat5LJ0oWQvgs/ldBpQy2dr4gB5RlSzXooFgXo1fD4+pbkxR+/c7Kvmt84uxoC98NFBTPtEvuuFbZvpH8WMNJ6/VqdqNxPWKxfxLuc+S9IwYlDgAety0kaWTV34jGBfjoOHiHvzU5yxAzpVjFLcgF6BsELRSqqnYMhzgG0J32aCf1Mq6iGB0L93I+rAfMFhDvEL0aQEw5secRU4yaxxwvqf3v8za1x5xhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6Tzpq3BX8iqwYIQyHk+sqXAQoU6Nczpy+Lk/2ZDWB0=;
 b=J71GMo7oGe7Dm2viOQebnCWMFTJkglMJBoM6sy47LiYCujf+dLkJTv0Jh6yBmtkBENcL1ggQC3Lnq4rwG8W6Mn+23LbYm88gk+8qq4SDTKAOmVMtzznZpV77S8HSedQcVeRwsxufdY55SGNBEd4zeMXlZaWAY3Jvdjd3CJR0piRADOoJ3B/RYQXOIo8xeoPkdjWYPqtmp+YLxt3Xo1WyoIc88K0BfTw9jSppoeXCdNs5LvYa2hNlEAfCsr9k1NTxrPyMZxMWwcnWgtPi8q4QqgRqvs6cjT4ilIeMwoziz0zW8i7k+a5Hrv/YKGS0wTZqCa+cpALzWh6DMEPYzMB4Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Fri, 11 Oct 2024 00:19:59 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 00:19:59 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <4f8326d9d9e81f1cb893c2bd6f17878b138cf93d.1725941415.git-series.apopple@nvidia.com>
 <66ef6c41eeb4f_10422294fb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
 logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH 02/12] pci/p2pdma: Don't initialise page refcount to one
Date: Fri, 11 Oct 2024 11:17:20 +1100
In-reply-to: <66ef6c41eeb4f_10422294fb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <87y12vxzh1.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b6c5b2-29a2-4966-f1f8-08dce98a7168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R4U4MBrkCQxSQYFRs+zA7ENWUBtRcRPjFwFeyqCQ9WgnOy4Uou7SR2jhooKV?=
 =?us-ascii?Q?lSnrhV+F+aFM4qP7ZbTo3FpvI3Cucyg8TdNvBRGvKIX4QtfHUXPg36EE0ytd?=
 =?us-ascii?Q?er5WZaSjVwXmH2ltLPkX907++ZSWd2b1PpZHmKpl0AlrtukcKxSmMpHwT00V?=
 =?us-ascii?Q?UvR1kLo7PLOPwPwyySmYw/VAGB2GA8zR7LzEWuHWzc7JlLpBS9IpJEnsYf04?=
 =?us-ascii?Q?2UBpPf/VEGZHFTqLOv+ewWy6LsiuPyo8mYnVtQ6IeZWQ2V4gXpXCfDJO6w/V?=
 =?us-ascii?Q?YS10bgEH30W3TFucfh95xyjw/B0/zNgiBAB7vn8d0/9EyV0lk+1VFgWPMxWz?=
 =?us-ascii?Q?juvoAZmUgHVtJu9DjF4xx6Q2FFE6otQ7Icz/ryKPVk0igICMuhxAq6ikHtLf?=
 =?us-ascii?Q?fvfBTwWhhfpDcl1z5XKmLhUkjlsaOp5CSo5BDss7oPADnvnapFNuJqrO84Nu?=
 =?us-ascii?Q?4PGPeQ9/TZ6gp/+rzKPDwiRYWiUATd9sQmxT1yFkP4Jz2q5XubhiOsQaPoKm?=
 =?us-ascii?Q?LYMtcSND1Rdn7p34VGs0Yrr09++4H3kJNLnI0enTtE6oOkuYLvlzwGI+YgXH?=
 =?us-ascii?Q?+/EyKezrhsrbxESHNaW/OGZ4azXcTAUWzG4lxQ2hl2MQQ86m++93ucam6A9D?=
 =?us-ascii?Q?QODlG2YnX7hoTrTeYZ0d1jpto1nKg4IAGLIBI0du/zMnkRVwjtzpQ5l0J/gv?=
 =?us-ascii?Q?WFfwUBggCz4zennAXbTxmHf5CSJoTQAGGDKrTdz0uldfl+e5a95vg/PjieYi?=
 =?us-ascii?Q?66BGLyOUjkgrnIqOsfkanl1Mxr2P7ekOl9E4poFNwyB7uUPFL6vBqdTiku/W?=
 =?us-ascii?Q?GlO22ZST7DbbMqESc4nnaS7uH4nauOWgHhJILhJr3WIdHmdHTv2NjfNtc5fw?=
 =?us-ascii?Q?UUN3352N88roWioi7C6PAsnv2yiIGscD88gn+Z4R1XHgPpSx3dAuQE+RH8Pe?=
 =?us-ascii?Q?L7LD0ePHDyVSN5RUNz+DOB1zVRnAdPie+/M5sp3xAJd6X/gbG0AZC79WTXH7?=
 =?us-ascii?Q?nk6jAqXMbeCJyUiXKfQPDEv6BZalns/EvB/ZExaxVcxlBnBo5Ax+88gJQQ3+?=
 =?us-ascii?Q?VLo79umyzLCWkniRDpcM8vx2c6quAII6jCQRsjx0NTeoTdmlB62WgC+8tjMC?=
 =?us-ascii?Q?YhGs5DYGnyF/qOoRhqbhtQ9rsTdITOK7Puiv2pcb/y6v09iTmZOXrCy3PERz?=
 =?us-ascii?Q?B0/OydtcmzEyLqZgTqkeofCW6NXyNMd0Nmz8qKwOeJteStaJ5BR0geuNYxma?=
 =?us-ascii?Q?+tiYLzkikvoA1pBwFfMF5WaQKka9BvPUL7sG3NyOTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q2wy3b4iKOGtpFKs4kDyK0wIVUPs6JFNyevaXc2phxnt4+VQRYImpfOoEpnA?=
 =?us-ascii?Q?BKm7X9YNCxUJ61Ajs/vtdnmyGspKNEXIa7Rd8EmD1epMKLDh4pVAzmZI9+5K?=
 =?us-ascii?Q?p6iMl1k39m1t9LLCmZnN4+g+GQcMlC9Ty94IJFGjYZJHaRfOEdnxlRcA26q3?=
 =?us-ascii?Q?6dnDptElHXdR3EaVFKjgvQcftJ3l65I8jLbvSvfa8X4kx789c5VdazWLAFki?=
 =?us-ascii?Q?TfkbEGMmyQIu2kprN9ghFvHx0E7wiKcFT+qfVrX2M2ryOlOR2F7wYpFQ3Vs3?=
 =?us-ascii?Q?43tY9w4932L4KwCrBU4iKXFauhsi88UZCJbEy/7phyIrE61hGWi40FyaNNjS?=
 =?us-ascii?Q?bNo3VbQJ2dtD4tEIBviGvZWIgYV2J5F33t6EUPxTxCWmLFiTx/nrBTsmMEE4?=
 =?us-ascii?Q?AfOsFLFonk4p91+DsAKYR1qqRDTOAOFfOscWKb7b+S7DECXI9l3Cce6/iiLS?=
 =?us-ascii?Q?dTVfHWSA7qbpGs7boiEuQGj3ILzU+gJ4PHzzOQaP0Qagzdu3j6ZpJgXK8ZdZ?=
 =?us-ascii?Q?FKjA7423vrmvcLynkz4Y5NaqtmiJ4O61SVAqQ7Q9hkmYZ/1aBahL9N8/Fsf2?=
 =?us-ascii?Q?JTbZT+k7P98blP2J9ZwGxW6ahjhHgG8DvoOgiu0nrT50DIdTZlO/xdKR9dLK?=
 =?us-ascii?Q?rLl2+54mZOcIfH56B5C6JvG2JXLI0YSaXpEiinzFAOCCEv4uCFul2RgHJ2Cg?=
 =?us-ascii?Q?A/99vxuWXmi54UO8+BMGobEcBq9ShTrqG+IvH72x7UJKtz475xF+chmEpcgQ?=
 =?us-ascii?Q?or0dH3A2/McYfFvmlEX8c2zR2n+eNZQLji7XLp+lYa+1JDjJlRkA4BK8J/ux?=
 =?us-ascii?Q?Mk0IYmGPD797MlLzIMVXXGPwQyLokkXMFik3BOxL/Gto9FsRJqgRsHCvX7aU?=
 =?us-ascii?Q?ceQWA94XnjgJRxtQnfDEMWopmyAK/44nX2NR7xJxhdbYlU/Ul8DZTEMW+rcp?=
 =?us-ascii?Q?NSTjF+z8qzJ3pNEy0Is5OGfuEgNHx41D7mAbQGWMzqXNXOGorRjDZnXKwkn5?=
 =?us-ascii?Q?kFsLh8sdKWOXCZDgIvCe457cq8g6IzHpAMJQyJO3XJ7WrVpikm3xg1isI3ok?=
 =?us-ascii?Q?/af9d05vhcU8hh/BHyux7sgI317rBG1255NrSWyP2TXme3O1yXm+wb4V/v+N?=
 =?us-ascii?Q?TRj8mrAF0tiIl4xQIfyCWcz5SCrVK1clbw42pPnRq44Adw2xqd2yy8HqC5rs?=
 =?us-ascii?Q?qFKIR//agEixIhISTKxjbhDhvXNtPFUKqB+ZW2FMi9yYjyJIJTtVg7uVfm9U?=
 =?us-ascii?Q?NKoWAXlRcMBW8ReAheqkKkngZiULOV3QpOsfpIyCnxDc84qRj+8kFiaM61ot?=
 =?us-ascii?Q?s07QPC2hqAn310ZkmlQNnWvt/GTmMf5s3H9GSi32rUezh2WUYieL5G+7Zpx+?=
 =?us-ascii?Q?WhwuJbvidKXGc9Rui/leyxP3HR0vcB/sAQQ8ZuFopdzwFjSTlWXYQYUVJJyB?=
 =?us-ascii?Q?Ln67t0Llw4lMQKAytjPddrRWxs8jWjl2rjRYi7o7yGfnMuxqoVqzSbxbsZqK?=
 =?us-ascii?Q?tcaKOVfIIPv2QFw1N/8r6yBlQDh/q1vSbzOHjGF7B/96DwwHBEA+BnlbanAE?=
 =?us-ascii?Q?/tNAq7VVyDMMngswhPxChH80q8SUOCB5H/bY87Tg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b6c5b2-29a2-4966-f1f8-08dce98a7168
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 00:19:59.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WhrJtz9uOMMwwnCviEbWkg5twU03Qq8sSW2288U7I6pyXZL6r7q9mMszfnZhYsEJbLLaBtIvzUPi1QQ7OHyaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:

[...]

>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index 40d4547..07bbe0e 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -488,15 +488,24 @@ void free_zone_device_folio(struct folio *folio)
>>  	folio->mapping = NULL;
>>  	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
>>  
>> -	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
>> -	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
>> +	switch (folio->page.pgmap->type) {
>> +	case MEMORY_DEVICE_PRIVATE:
>> +	case MEMORY_DEVICE_COHERENT:
>> +		put_dev_pagemap(folio->page.pgmap);
>> +		break;
>> +
>> +	case MEMORY_DEVICE_FS_DAX:
>> +	case MEMORY_DEVICE_GENERIC:
>>  		/*
>>  		 * Reset the refcount to 1 to prepare for handing out the page
>>  		 * again.
>>  		 */
>>  		folio_set_count(folio, 1);
>> -	else
>> -		put_dev_pagemap(folio->page.pgmap);
>> +		break;
>> +
>> +	case MEMORY_DEVICE_PCI_P2PDMA:
>> +		break;
>
> A follow on cleanup is that either all implementations should be
> put_dev_pagemap(), or none of them. Put the onus on the implementation
> to track how many pages it has handed out in the implementation
> allocator.

Agreed. I've ignored the get/put_dev_pagemap() calls for this clean up
but am planning to do a follow up to clean those up too, probably by
removing them entirely as you suggest.

[...]

> For this one:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks.

