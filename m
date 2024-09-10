Return-Path: <linux-fsdevel+bounces-29000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AEB9729F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765E1B20EF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC117BB3E;
	Tue, 10 Sep 2024 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lv0MtpW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3017965E;
	Tue, 10 Sep 2024 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951627; cv=fail; b=qtr0M9FAxRLl43ioK4Gm8GDnAV7XtU2GE58eVfwJNjPK34MZLQWSc1cMyRKqVzlVWvXcj7rSI39qDnpF+CVKZuPwgFqHkQBFQqnxSeOx6C1ZLwzWgKq+tFGUYWR4Nnt4Jc7T+pRiasj1/mJjEkpNmQoyvnU7fIuMmHUQw3/XHX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951627; c=relaxed/simple;
	bh=gWaCYFTaYv+hLmWv98YDYJAWvIbMYWxNF+56kRCafQw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=WYPfC/CuTmglKpybw8Qs/FjPhJqmHPkmLao3o5a83UHob/0ZTUzb02L/bTdLn/OPb5JBGXqThmOBuUHDxnIqU0DvNvHPJhYr2wGGIoM9LowZ2OGFOk4bkh2LOaGcqqqAe52Id+E8JKTkccF9EjGgF5CMjNalOFb1mefDwbhw19c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lv0MtpW0; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjIv1atPgOuN9JYRsv4j76hlG6XDePUm/5ceMuc2CZ6cTm1iU/gPh9PlRZFRvGnP/V2+bo6tiIxeUlNox3d++ven6COehRRP6DE3hnduugPm1lJun63imkEX09n5GSuEpRr3uF0buUomTCTuTCyhR8IzRmPcnFp6jiTKtlq/JWUesl7XIBL+gT4gE/vsmAHP0GNO3RJAs4FI+DRMmYVJN3jXcPE/cOlLmPjUcIN98f9J2W598zoicq4kIp9iOf9mpRaXo1Od4h6sR8AonVEWyc5IpRhfrymwSeqKA5KDPZai/9Unr9aw1WMUcPCG6Iljxw9jldEofQmDsmM3pQDUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhlJWPR7PWN5B2QXCvghlpEJMYvBsVDyvQ2GEk5tto8=;
 b=TPwfWtTEkBw4G9rr0DtnA5aBo722xrycBcdGOFQrT0iYhAC3IhR+uUBWFAYQevRpIjh7h/2IeGeFcvq1vStYxDK5UzN05fw9KrPwKlJ3bryUIQwUwA/EiJPQrd9vM6j814QypraFgMkzmLytj/PPPIo7tN62rahiUNaPk6DxEjIhxGajGT43F4fBg0z9NgU972huiheUI1K34kFxU+RVOeB7kMrqx3ZA+X7inZoNGqL/af3n/fGPXNN00uu3mz4/jKalDdVHHb80RLIlTQ8N0U4EptnV6H2dj9uBIzpwQwkDBrS3fF8ti/6P1i7ATyVb9owfa4iF00CjmM0KSUr7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhlJWPR7PWN5B2QXCvghlpEJMYvBsVDyvQ2GEk5tto8=;
 b=lv0MtpW0ViICxzHddjyL6zIXgpvexMg12Haks8pLVjQ+RWGMzhDv4JGcDlDiBncnoqnpMHzM0fvi0V18WKjWhF141dYs4PaHSScANWZOEe0CSDpC5ScrqEFKw9kGtj/Bjr3naAe6qCc4fFJ0q12RhgyJcf5DKqGe4cW6odPvVe6hjZsJ7exS5gUXbtjG9MkXQ1LSKatulYFN6b+AUqE6U5/uyXRa2T2w/Nq+TJ013MsezjuhfDwqDHVFKmbUCl8RGIE0ZelhoecCtko8e+Dpf79h9f9pGWh0kl+KyfhBpDDc1AoztXXppYfU8g+clzwimGwCuNAHmHa+PFRPnyuGVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 07:00:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 07:00:21 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>
 <Zt_PbIADa4baLEBw@casper.infradead.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 04/12] mm: Allow compound zone device pages
Date: Tue, 10 Sep 2024 16:57:41 +1000
In-reply-to: <Zt_PbIADa4baLEBw@casper.infradead.org>
Message-ID: <87v7z4gfi7.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0041.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2866d1-f5bf-4764-5d3e-08dcd1663c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GK3S6c05WdXWcC6vpSt1gGdnJxX/SUz5pFuf36qtkMd9f9xhSSdkcEDn2nyF?=
 =?us-ascii?Q?vXUGCzARlNMCFortE+ZvrurravPQp4R+GNKpwXFfZsE/Mklvf5UTHZcwHoKZ?=
 =?us-ascii?Q?zRJf7NOxSFt25S5j+YlR+xG/+H4ablKz23YEt0+d0cRYiD1r8LLbLDkss6Gb?=
 =?us-ascii?Q?K7P3ujQ+4s8D3S1hY590dymRMCKJyQHIR+gcjaXVtBBfxsKJqLvUkEy9IfXs?=
 =?us-ascii?Q?kqA4VgcgICSgopEJ6y5e9iWdRCSCElQoPdRvV4a9IGgC3dWmXx5i2KcRMmBa?=
 =?us-ascii?Q?AQIY5ktfxV1MZmKpVU4+Dev7tf06MmPbrpZkKIm02CG5ayHlxmCVUaWvJTue?=
 =?us-ascii?Q?LD/V+1UVikeHv6Am3ZxaWxzxoXmXBXIS8Xj0XIUV5Xtbw8Kk2rxS1ylORDqF?=
 =?us-ascii?Q?igSR3GiWBagXfKoSDiMVYPtvo0ejFWVBL/js3n+vBjIFk0lwsAOKvhFwEo/Q?=
 =?us-ascii?Q?21qMFjJ1JyBE2mx/skYWkiczobgKR8IKC7SAiXclo4hvhAq5MCYTTDdl2DKj?=
 =?us-ascii?Q?T5MzXJ6rOD7/wGgLyuTbXMc5ZapBa2mVSygMYxU2OkjzDl3iqb/jDED+ZYdR?=
 =?us-ascii?Q?ldY8vfWs5zNL9FbvGAGZg5Mq3YLeDsnHto1Cf0MPHZuzKUFYJDB8EXVtmbfj?=
 =?us-ascii?Q?52NixDoOBBlVyqfxk4G5qusCrFDB6vn5oOy0dRCFFifewCuaB/+YQht20MIt?=
 =?us-ascii?Q?B1KSQvY74q6i1NvfrWGFHJeZRkARb5Sb14ZuU4uqXf/RsG73Pmx1eLPQ63c0?=
 =?us-ascii?Q?ucUzht4qzjbHPm4+HOU1c5rmqGBJbqJvG0FYKUBWYhbh6Qx76CFMOA6CNgvV?=
 =?us-ascii?Q?QTzRbPqQcjL2I2Ai+xiIm4QgYEmj6AY7Tqmz7V6oia9hZz9JZwfT8avDQU+i?=
 =?us-ascii?Q?iJuPN21G27wSWWOvj3e0PNRuwvXKczthd3dKpWFi1WGNHEG9Qo8iYvYhr5VL?=
 =?us-ascii?Q?vMCshLkGdEW1VgjWgPNmptiHnNmBXyJ95PG/N8pHovsuG30zfU+v1gAZAZsP?=
 =?us-ascii?Q?2aUWSgpUbFAYDr9SpAPRHyBkkwxizysfS1QGstbeugxt6UVHo34KMc71okC6?=
 =?us-ascii?Q?F5yQTrAX9e3VKfSO16j+RxrBc+hPRZ5nQh/JWdkEZw5bQEnHN9zzjibWoIp/?=
 =?us-ascii?Q?tuq5DWvao8MLK2awHqtot30W6WBgWkQvVlxEg2BpBI1r/Fbq1pITba8WSxPY?=
 =?us-ascii?Q?px6hGezYHLhn8m5vLFOedIMPo0+9cfA7prB+pRhiAm8rcOI/kREuEfOIaKKK?=
 =?us-ascii?Q?+kR9uhDsY17TOyYcHMox9arHzvSXyjWyT4KLs7Nf0nGubj6AUEWsBDPOOzoO?=
 =?us-ascii?Q?T09L4o8Mtem5Ekl4KDAy1glotXByBnBIFMfZNF4+xv6d4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbzMwQ4fgX9zbEUp5p3cIi8lDRuQVjGhIapR/PCHBl9oCEYkr4FSlRP1Cnno?=
 =?us-ascii?Q?u4JWu+qhYLs++t1kjYEjpL3zXQ3a6t5/nGjtm1LQ97qIIFi8QJA0ImiWeuQV?=
 =?us-ascii?Q?vL3ZTYENjNaYxpcZyUNnLB9MNVpEcKzT2R8f9cWkSCwAuSBcBpgRbJwu+2FW?=
 =?us-ascii?Q?33LzKp/qT3CoKxgal3Dh4RqRjDs8PlZgwrE6HC8Kd1ZIDbhAQbA+uLLZdUq0?=
 =?us-ascii?Q?Ct725HVGpzsj/zKMb2tto5kmZWqEEQPbEvP/BT7uQj07fu8E3oHE3Vl80HFw?=
 =?us-ascii?Q?uugt1kgAiAmedJ3pgVTByWXjXzVBZAajj+UVN7FjssdEM8cN0k9vc5YX0YM1?=
 =?us-ascii?Q?PyN8Fckokf8FIDQIh1gs378o7hg3L+9+QNbyv3PRMg+zrVvqfuMvafwspIGr?=
 =?us-ascii?Q?SQNCSPUI3D/trIHHjVIrItlG49f0jZF6SmwkMyRMvVFVXeqXqtwiOH9O3HAT?=
 =?us-ascii?Q?LWHelp0T/jXN9VnidiMgBgv/2Lp0ES8un6d3EBLg7HAnfySXD5IjIQCD72eg?=
 =?us-ascii?Q?IWil9+NM/STCRxyKcdupEGyiiw9AOFShYj9ufsYMFrJ5wWlmb5F+HjLXPFHU?=
 =?us-ascii?Q?9dF1uV6U52dx1mZJCQlFrNlxuTS0nkH/nuzPd7DBePHzxcCoQ9VOI+BVfcv3?=
 =?us-ascii?Q?RZHe2jliHE1FzVGZ+mO9BCf66e8tzbcKmGZToDfC6aHOn0141+nDkWb5Lo3z?=
 =?us-ascii?Q?ltsiHf52y3a+QB8yoG3PS9LRuO9nBnVpGCHv4CAz2nvDaADO/VIqwMYz1MFU?=
 =?us-ascii?Q?8na102TJ9UHyC/CQoabt8y6StmHCUt4iZvfogcWpRoI3+rO2DMINLQO6ZICd?=
 =?us-ascii?Q?qv3jiMp7aFb7P2hgaC8H6g9ITB5pKiWoBNZK01CT3JhgCMIgT5rH/1oC1N5q?=
 =?us-ascii?Q?0wkAm3A0NOZkD9WBORoJt27Mv9946A5tQVMIOwA3iEMJxnDzUKYSPZQogIDX?=
 =?us-ascii?Q?8VMCvzV/PTkPhvVVc7dB1EjJYqFWsuIrFx2S+ZFi5rQfs7oAV/SVO78VXoEv?=
 =?us-ascii?Q?3Rnclt7fd3+WibvH5igOqFW/EaycVcmUY2m/Arn+Ju7acXjczfv0m+INLtzW?=
 =?us-ascii?Q?stANuW0GFgCRNH0WAtSHqBaSsh1CIzygu58wjwIbf6B1gUeK61fBUD4beC59?=
 =?us-ascii?Q?50xydIEXG9oC66tbn37NrcsJTp8ObqxTbIdPsjFKcHBFkaNjqpiDXYRuYTF1?=
 =?us-ascii?Q?V4WEoFaj1qcOUdjt+jS1awi2Y3R39eBXv74vkREmw4sZTsc0oBszYxI1s9o7?=
 =?us-ascii?Q?Qt75HSRe4+MEeqYhnysYEZx5Ba9PBnb9M/hkfvGRThOraJOo6Fk14QgDDVtN?=
 =?us-ascii?Q?650ITHkS31Ue/P/pb7HWHcP1B17Xs/CGBH0kz46+JnDB22v0chYS8onHPVZk?=
 =?us-ascii?Q?kAaQlUk534xJYbTQZ/iy+yUJAOSj1PN+tBJ8FxKAktXf5gpoD8yBMhUW6EEa?=
 =?us-ascii?Q?s4Uv/3xsGbokpat7q8+mPTxP0BLjcqUTv2P715sadONJRschqz4mCd4CQXcu?=
 =?us-ascii?Q?BMBbJTulsLQgLUta0Ku1VjumkXd6ktF5325T+K3tVdm7yCwR8rSQYTkhQPk6?=
 =?us-ascii?Q?Q08D/3eZF7Vr3ogPPmMLQYC8/G4e8jplGVa7OJBu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2866d1-f5bf-4764-5d3e-08dcd1663c4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:00:20.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/V7JC0kXdhvLbnZ31MFqxANYOifBRrKxvNvYUPjq7brt1zDmkGe1XdXFrmKY733eZAVjWmvq8WQm5F/T2KROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723


Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Sep 10, 2024 at 02:14:29PM +1000, Alistair Popple wrote:
>> @@ -337,6 +341,7 @@ struct folio {
>>  	/* private: */
>>  				};
>>  	/* public: */
>> +			struct dev_pagemap *pgmap;
>
> Shouldn't that be indented by one more tab stop?
>
> And for ease of reading, perhaps it should be placed either immediately
> before or after 'struct list_head lru;'?
>
>> +++ b/include/linux/mmzone.h
>> @@ -1134,6 +1134,12 @@ static inline bool is_zone_device_page(const struct page *page)
>>  	return page_zonenum(page) == ZONE_DEVICE;
>>  }
>>  
>> +static inline struct dev_pagemap *page_dev_pagemap(const struct page *page)
>> +{
>> +	WARN_ON(!is_zone_device_page(page));
>> +	return page_folio(page)->pgmap;
>> +}
>
> I haven't read to the end yet, but presumably we'll eventually want:
>
> static inline struct dev_pagemap *folio_dev_pagemap(const struct folio *folio)
> {
> 	WARN_ON(!folio_is_zone_device(folio))
> 	return folio->pgmap;
> }
>
> and since we'll want it eventually, maybe now is the time to add it,
> and make page_dev_pagemap() simply call it?

Sounds reasonable. I had open-coded folio->pgmap where it's needed
because at those points it's "obviously" a ZONE_DEVICE folio. Will add
it.

