Return-Path: <linux-fsdevel+bounces-16770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1819B8A25E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 07:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946501F2249F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07C1C280;
	Fri, 12 Apr 2024 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cC5DPiXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B0CA6F;
	Fri, 12 Apr 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900951; cv=fail; b=aY4wvrI5nu3DsE3UTKS4eZaTTQO9/AGx3hV+QALVbKApPYNga1Ec4A/5I/FKgjwnqNbn8M/ZcByXXQJvwux9vj0sQpBtFEFDCwykoTnRi19umgMSFCefT+3PY+a2D4aX25u5KUZpKii0AXwMd4CZIlZFTGBp5Dd5WuwHtduxyn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900951; c=relaxed/simple;
	bh=qdISfQ8Nlhehc/t5tqBCzirXo0XEIZ8iTu7NIMCZSbY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=XqKrH/kua1/gYp0kXs5VGFmj7AYZzdlWdKsQHlnTVJeV9uSSf73y1KaSIXW6Y2wdLTLWLiCdvrN1pge7pm826eoEKIeJtbYPARDejwuBY0cjAmjpfV56vEXfI3PHSuf7evjX37sfbCG16xesiVXn+rdC/zZik4JScj7Y9Os+Mh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cC5DPiXl; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ2M1W+yGofFZa4doyT09tSwryUpoKveNNUGYC5VA7r9efdu29G1S5h3J3FWsUuccQCUzxwzpzyOI3h1BcZfhqMXWHCeS8JepGcAIfOHDPM8X4nZJ4zJSBO9lRU2T9BdTsvRzIdwD/b9FNXPBoewCVa/Vi3xQz1S6eakQ6UT8RJ23NZpXWevyKEJtvly9j2ACJIZJWWTeEFhV51Du1siOzP2KEFzsiulchCt+6CeauKd3LaVnzY1HW2hC8TccP+Cr8+RzxRvy/YjPFBsHzC+ONVjwMJJ1YaZpDtBFZAZqzgj28AT/tiktFiyV3xLgu+k9v5JypjPQAeiV4cJJOsxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHh4VVzMtsd2hq+3vtBUjf46FFZ4+f8z9QhxW9xFF1E=;
 b=OCZ0fJSw2GEEN/AYVMlRvJt4yKTNxYfwoBI2iCcixHEq0zd9lNI1G5MhqFK28s2GjWY6kW8Ox3YXGSPNBR0CKc7WchjyWUvIhgUGTsy9cIv4npI69dBUc2hciUP/wM5el4PlRHg104vGk/fyYpU/Ae15W/GXLJrpvuyY/UeyAmT6SDFNWrgH0SLZsynooEypupg1MM/HiP82XhKDNCWAXLKXGoRDzLP44wO4Ler1POMh7X+2HC/tyUQIZjFr85amBACsYitq70y2JC0uQLfvXs1EYd/T0NNEyDPm5VYMQ+O0yGAv1E19xK3+JMvemAMWuOht8UYAhOgMkA+vzwishg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHh4VVzMtsd2hq+3vtBUjf46FFZ4+f8z9QhxW9xFF1E=;
 b=cC5DPiXlcl3MGMtkQSm6iWfFbWrMSNJzxVagrD+NRtF2bTaYZY8TXeE+Xwl/WJXwHd7+vYFXFMzdoqeO5Rt830Lt3JmwkVoFHnri4H6R+AxUlCBZDyEJh92u/2tIpadoVQCKQCgbEtu73MzCoT2xfhsJszNuaxXO+tBKHpVgyYZ1CLP+fbzntHVmvr0m4j3NfNUtmYCxojurevLFLPQdhkeQ1nu/MUU4jYjNtWuVRu0lDjzeXpmKv3hSaf9x8/WA/xZbMYfNvz+2WI4ynpAsHhDDXBW/BajzsJaGdn4TN5g42E2NnkcTQAnHoSSy//140fC9ybzGdFim8HSJfzsk3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 05:49:06 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 05:49:06 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
 <20240411122927.GR5383@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
 jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 03/10] pci/p2pdma: Don't initialise page refcount to one
Date: Fri, 12 Apr 2024 15:40:47 +1000
In-reply-to: <20240411122927.GR5383@nvidia.com>
Message-ID: <87bk6f5dwz.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0111.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::22) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8d20f4-0595-4c62-9774-08dc5ab443ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6qTn4rXSgdRgrCDnY//4m1GsuC0cyHBrvIQrR7I82Z65MKVh6G8E/caLBweuSZYIVvo61e2YqhkNI5uGqc9bLo6jBQ5trP/Slztl/qBSsL6lupUG5q6GVfeE6gSHpFXtcRAaG9Bw8REeSOGsvAvA/r6Eh0UpWq8nKlVshv/d0OApGPWGYs51OkkLWSmnXx77hgMl1dFnSHXimXSGE8PxI+nPh2RyGsQmyCGUkKFXjJwz0h5T9EOwEb3nDHcndWpAUOAmsX4eYGoZI6lQcLrqy/2PETDmQ91QfrxEreQeyDd7Usp5R0OfSix/qr/r2xJ7sCnIESLwNBKydUndcJg1k+iQFik0J2BTGcata/FoJ648bZqJRRf3VK7ESBkShmKE9IBhSGwKimitJ2HCOdQCudXbiQqz4lAS+faYPMrZonxHCotSc/qNVWbNRAoinlXzrtGb994xPilSs7+7ucYnWNfv1un0aUE2PtOwkx/viR7pdskuQvqS/tqU8wGmjWHHFswxq/QUNSAdQGG8aKVbQXLzrjQDF4MM7jDTkENExk3liE0au1pR0BeP/ZQHZnZyCPUsLQmSHUFi/clGMGEcEW2VN/7liORKxchcndrex8rowrOPbtnxyjlr2XN5DZzvk6L0WxVIdKSBOPi2PyjbAOXeRUoUmAm3FFr4/YiqFNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mFWiZ24zrOKbBifa3PzVXdiDQX1j+1flEcLKityiyBFJQbq5yzj1Ln4b00uK?=
 =?us-ascii?Q?dkXykBK5yyqnYDQBt563tRB/PdlFnqkcOmIthGmTI7z8cWfZ0LIkrA6uoFUW?=
 =?us-ascii?Q?N1ONhd0713vJhAPYXe4WS4Qj4vGnbx0ruYs+4VXHTRcXt6+bG85diQ4cUhxI?=
 =?us-ascii?Q?fwBkJHnkJoG76Iy8+dwOieiFiXnDFUvKm0FW/OpSBhNTAO6OM1XIHmyL0BPb?=
 =?us-ascii?Q?WoS1dNw+sCGWeIqT3Ap7LspXdcBfvTOmhPukzN0caU9ZDZys0RdSJ2g+7QsY?=
 =?us-ascii?Q?NdIU/tCt6OVs7ZLlNDurBujfLxaklQF6tPzibZOGLvTVF4Awmin2Nl6gKz4v?=
 =?us-ascii?Q?KH4jBsrGMK3Aktqq+OCP7H7N7n8Tn1Z40czBqZhhgZE+6Bbjy6zCQuXf2GmL?=
 =?us-ascii?Q?lLm8gahAY5ZlarSiMQ8O076HX3RjoqYaVCLp+QQe021bG77T3ZpJF1XrLuiE?=
 =?us-ascii?Q?ApWfFROAcYcKxhonrGRgXtorz7BQpAM7AZu/ucpkEy1ZNupd093pLPwDFMb1?=
 =?us-ascii?Q?pmjENx9DpNuAD6asFyozlnDvwdTIczYnSB6/eJGaGyRqkjNpvGVlXmSjuKF9?=
 =?us-ascii?Q?mWtNNXF79t8JtUVIqQ9gVmIVpU39fE5ojCSekau1bQU59Oi71Fj4nR+4MLRP?=
 =?us-ascii?Q?djdyKDqtH7sdX5WfoIw6RGt6pW7J107GdoG9h7aH1br6JrCgDmS11ovn+vtK?=
 =?us-ascii?Q?lRYzoNeGmTpHyImCdj8Oflcs6+mb0IgBhcL5stpayHNt1mtUmlxLjYXKOgJu?=
 =?us-ascii?Q?rojPuAaDSWU2VqaD4WX979eh/KuU7kxhqCrtSSvoQ7mHZqmf8lQJwwe4E1FP?=
 =?us-ascii?Q?jW+gUaBvlKFJBZlbdd1ozrZdvqCzCjrIO3k9VI5liNIEgtkd38uMCWbR3IrY?=
 =?us-ascii?Q?4WUpp2OMj1EZvmOLowcsgtcG7VsPe6pL/EqLNL/AgeELBJ8cKuJknl+moRCc?=
 =?us-ascii?Q?5/MOgtXFC1QeXohObXXqNtGcU9TnZKhIi0ybR4X+9eHcT7osKGEmdpMuneq5?=
 =?us-ascii?Q?l7mY3WL2z6ZIH9P2uLKmBLyxwzDHsTay7XicyCuTf8TMy8gCNDGFSP1E5zqj?=
 =?us-ascii?Q?Imls32dKH2kwnYo7DFw0oaprFdzhiBtQa08yLbSA7rm7Wg4kVxmB8vWWen3f?=
 =?us-ascii?Q?hgRoNWOq2gvjn8Wf0Rg8WcRFengXqPACvmaw7tY26KDEsczztHwL0b65FIvs?=
 =?us-ascii?Q?HbPeuSG1qBRmi9jO0RLHxfRcB7cVGlv7WgH3miAwHvPSYoVf5LyrJzDbISha?=
 =?us-ascii?Q?GwkS+aKyKVQ6JuwrQXTFoxTlGKzo8zYXYruZ9PAw581yG1pHaLwrWb9BFx9p?=
 =?us-ascii?Q?1elQPoscWsTrV8/HUS3ERUqq41XUcVm48ZKuV6UzzqFe76e7ApMLN2CRLtD0?=
 =?us-ascii?Q?YUdLV/1YM+NANCSEdyWuj/UCSYYIPVvEUjoNRopMrJQGHG+WKKteNqjtNBB4?=
 =?us-ascii?Q?anVJ2DCVaUcXXY8fzIMeFNRu1A+QyOnpdY02Jhlw5q9q1d+CPhhiv9/BM68s?=
 =?us-ascii?Q?pOcFae3PlqX3UIccWYFLMcttJDE/5V8/4Z5d+eK3skEKVCR2a81HPfqFGxy4?=
 =?us-ascii?Q?k9uDfdosk7Ei5JfIEcfu9NzS2KzcUX/L5HKCpOgO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d20f4-0595-4c62-9774-08dc5ab443ce
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 05:49:05.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r90Wb9JB7+6ntVHpm/lXW0SYn6KbDGLr70g4YPWw58R/RIzo/ONtBrJr6PKicLiaUPpZDk80n5eTifdlEh/mwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Apr 11, 2024 at 10:57:24AM +1000, Alistair Popple wrote:
>> The reference counts for ZONE_DEVICE private pages should be
>> initialised by the driver when the page is actually allocated by the
>> driver allocator, not when they are first created. This is currently
>> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
>> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.
>> 
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>  drivers/pci/p2pdma.c | 2 ++
>>  mm/memremap.c        | 8 ++++----
>>  mm/mm_init.c         | 4 +++-
>>  3 files changed, 9 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index fa7370f..ab7ef18 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -128,6 +128,8 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>>  		goto out;
>>  	}
>>  
>> +	get_page(virt_to_page(kaddr));
>> +
>
> Should this be 
>
>  set_page_count(page, 1)
>
> If the refcount is already known to be 0 ?

Yeah, that would avoid the obvious warning that calling get_page there
will generate. My test setup for p2pdma is pretty clunky, so haven't run
it a while. Not sure if there are any good qemu based tests for this.

>> @@ -508,15 +508,15 @@ void free_zone_device_page(struct page *page)
>>  	page->mapping = NULL;
>>  	page->pgmap->ops->page_free(page);
>>  
>> -	if (page->pgmap->type != MEMORY_DEVICE_PRIVATE &&
>> -	    page->pgmap->type != MEMORY_DEVICE_COHERENT)
>> +	if (page->pgmap->type == MEMORY_DEVICE_PRIVATE ||
>> +	    page->pgmap->type == MEMORY_DEVICE_COHERENT)
>> +		put_dev_pagemap(page->pgmap);
>
> Not related, but we should really be getting rid of this devmap
> refcount traffic too, IMHO..

Absolutely. I think there's a bunch of clean ups for this in mm/gup.c
that could be done as well. I plan on doing that as a follow up to this
series. We pretty much don't use that for device private/coherent pages
anyway.

> If an implementation wants this then it should hook the page
> free/alloc callbacks and do this, not put it in the core code.
>
> Jason


