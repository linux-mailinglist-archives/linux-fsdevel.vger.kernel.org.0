Return-Path: <linux-fsdevel+bounces-71068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B4CB37F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1DF4301372A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E085F3112A5;
	Wed, 10 Dec 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rziNsxnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D60310768;
	Wed, 10 Dec 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384681; cv=fail; b=nCOP35y1XomCNo8Z0LDlh+dMv+tTvQgGLFCcS1S1pAG31n8FSej6yMnb04wluhTYoTS2dez5HyVebo77jDnXuG8lcC3/KSqqnzFSPvLMELD7QruLmZdDVOIoK9TU/upLlS+1AIoEN6HNgtAw2j6CBf7Bru5jWO3hvXJv6ZmJ868=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384681; c=relaxed/simple;
	bh=LG2WFBliG9duUskAmim1EWgZAJ5rKAZhj419zi27Xz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMCTlw1brTBDW6LI8/jJqzHcRxNcRsPCVGbXVY7Ctm9fyF2cVWpf+JCYfGGmjaJ8vxfaTbcRFhJA0BL4we5djxQbBEBza7+9XgzpdJDxb2a18Gu91RE5S8B0D3A7pen5cvq00cKDeB2Fk2BouXDiajNLfm5GY4FfnCm8sZbEr/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rziNsxnJ; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH2vrgchjmfkQiZCQF9FBHKvAKBVm0l2Hki5iXIjCTtr51PVpu//IJwrVpE1I8063jFL2pH9LqJgLKQ0ZH5Qg3cUI8r+9Bp8SPIqAROKgJ5PcyUrmqT6cr0wWojcTagwNaf1HugSs1qmSImU5X6qVJ4XjmHgqE4NeSx2b4Ggng5BJ43eMBF81VZ0lss7SlICBv5HlTIQXL180QAxx8ATxaAkpZln/O/SX0NHVKobJnAuerqlJEX11RzDu83tYhl1R13sagEGq7PuTiRNiV3KlShXORjnuZhBoMcvm8nuM4PdMKSiPcA+AGOHodA/GonfxRUSDlqytO/knPeUw5tO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58vVcA/zjtkNyGncrSDKI/ACEENeevsjztGDeGfMruU=;
 b=TL57XhNnuV8ZSltFeUKebxCceaV1UN+6BackvUIU7nzYGVen8jNA8zfOYMMWFvmnqtF14pn7cwk28fH8A6nb+nTebhhPCZLuw78ZwcCMaqWZ6h9e9UYhNf65HaL0l5m17/ScKisw7oEwKtW+Wm1fIRIhIKsHzQRSF4IR95xoQZlT2hfxkFId46VTt5w1CVB2Efy/WUwZqhI+XVFZTlxEDm9JY7jYXwGZUFxbDusejo2K+R0rrUQvZaMJdLYJwFpXYKfI3y36vfUeVrqJl3DyIH5q2ieL05VX3G//dg0ZRdsqYj28Q3mOEkLbMMZ76zF5wopuSiNwWDQsILcmGJsqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58vVcA/zjtkNyGncrSDKI/ACEENeevsjztGDeGfMruU=;
 b=rziNsxnJTcgxdkYB5fj6w25kSgTY5lOmV7FjvEjXLYqryNVzB7BxslNUQNUIviQ+j2Osv9a8yimXV4g1/ztqwdIJL9q7r4AD2SAZQkAl49EicMeD4ARUcWXMScicZGvm/AdA9QXuSiWqYzNG1F1EgVUo3XpTODa2J8gO1p94BKG5ZwEsVp6Fno2rdHcK5lp1Hbv4s7l4vr+K0jwUbHak+x18dBgEQGIp9gYtgLcp0x22xaOevB+NSgTpNtgW59xqWbVyoqlJBQlZzyRAzD0wTzR5+IhFrVEoB57Z8nF1R1UP83Ubh/KVI0Iicx0jdRwyIlMF8fGcis2I1nw/JCmLSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 16:37:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 16:37:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Michal Hocko <mhocko@suse.com>, Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, kernel@pankajraghav.com,
 tytso@mit.edu
Subject: Re: [RFC v2 0/3] Decoupling large folios dependency on THP
Date: Wed, 10 Dec 2025 11:37:51 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <D498FB7E-1C57-47A6-BAF4-EA1BAAE75526@nvidia.com>
In-Reply-To: <aTj2pZqwx5xJVavb@casper.infradead.org>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <64291696-C808-49D0-9F89-6B3B97F58717@nvidia.com>
 <aTj2pZqwx5xJVavb@casper.infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a03b19a-5972-4210-9017-08de380a7839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZgkxCnEo8iS97lIgdAi/ad9d3nuwlT6QJ6ghXOC0xJBLAUYzV/4mouvkQvnY?=
 =?us-ascii?Q?zFN5Km00heorORwKrO13eh9lSlNYUyI74czo2/Y1TE0Jxa3jI9sohiRj7yiC?=
 =?us-ascii?Q?nGJrUkYmbXxlzTEkBW2NlSuPEMt02v75zI8wAmcpAEDTT57MT1wP/EAyAnpF?=
 =?us-ascii?Q?cfm3t3qsdG3AdZ32ZY+vt57y0VlEf4Qa3YUwfAz0NnZrqT/HBhxn9XcAMlt5?=
 =?us-ascii?Q?L1D75jnGHt1/jcVjgvJsbbbfMa1GYwqg3Lag2IzamcBB1kbevpeyldCXISuY?=
 =?us-ascii?Q?wdEto/oy9bbxVCJaYQ/+BpJtm2d8H2HAbSiTH1lW8sDuylhNp+fRYA6OiizT?=
 =?us-ascii?Q?sqGDTqsGdVn6bH4ySDafQmZ6VTqMDTmcr2vqw+9TATiEphBJiN/eoyaNCY6/?=
 =?us-ascii?Q?aSjvzS5TXByw0eCax9UE+3JY1hhJjgbfn2wkcpwkgHauAnpN2W+uynqF+DcJ?=
 =?us-ascii?Q?cWSfaHP7TKrELuwUClUjUbd5FXcXAulD3S+EVMx+1JeGLc9nyGNpNms2YtE5?=
 =?us-ascii?Q?ArkJSEyJ6HScDQdjEyfBjLgjcGKL82AvtTYGQkBZU132/ufJGvG767sgDPwl?=
 =?us-ascii?Q?rdwL0oaen2UXz/IycqnPI6MCBCkrtKrS5FqJNylvaP2qJDMj3hFHCpIUYxHY?=
 =?us-ascii?Q?Ympsnb8XJIVDnwOCeVd+GU9W2sFG5EVR8A+3YB5OfQpJeS17qjfGnQcFXQIU?=
 =?us-ascii?Q?7QIx1PEEvQG909BSCam3Oq8lyBInOZ2ntBF92KZu7cFupyfMjo1GQCY4U+5P?=
 =?us-ascii?Q?oPzRiHPUZGglqr/ruj+WPpqMRctdLLwaKQL/NGnKsNXX9y25JZz3H5iXtqvk?=
 =?us-ascii?Q?ZYiDeea4WSbsHPtFw5ENmJ4xM4RCWEcIGVCzXjUygisiH/FFSk+0snBLM1nc?=
 =?us-ascii?Q?HN88G1v9kVllzyxAPW4pN7MyRVPsIA9Qm5GXyN51cofhKINR41EmuhPgiOwD?=
 =?us-ascii?Q?pogdYoSAdKgasLHNd/zjWT4X/baSshfZxjQ3ryJ7OZX6uE2NPwhMeGuMscu4?=
 =?us-ascii?Q?K84NgixUkGVT0ZRsQxDkvoEVkHy/65EdAOllRc/UAGpy0CW4WKjvLcWBGuEH?=
 =?us-ascii?Q?XJ/tO1HmQp6O4XRcHh0nPiw3LJVJYUoBLkhRNHZ4/OkAPKw/RSSJHHus9Sbj?=
 =?us-ascii?Q?HqqrrhvImt5wUH1kK8Ibl5bYULnYcQj4+o6+SwbZ2vVgSovO3/1BVijQPAro?=
 =?us-ascii?Q?5Mks8jHjwgJ1jtbi0KG9Rl5cNR7FZN5SLCiwofB97shI9uQls6ejmC1iOvFH?=
 =?us-ascii?Q?U3FbWT9oUgeHFiWfF3GrT9CXo7CYLb6fpCHWA9eISH5pUGH7Ik2bwvV8L7Kn?=
 =?us-ascii?Q?IzKO7VahHcDCIFWX+DTp/EpOd2R/S0jQKY6Rkn/J2WznG/bR92DtLzhKk98z?=
 =?us-ascii?Q?PtJUZSYNgMAb35T4UDsS9no3a1UEddf3WBC/dWrq5gerffC0lXQiswtfuHo/?=
 =?us-ascii?Q?s508iJ6E39V1kuoJPK5Kccr/7QzJ9++V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9oT/hz/Qyw6YWeU7QPJVJcoTqP+RijeEdrcK1B9DY1YIUw4X4kSGRDVPY+kx?=
 =?us-ascii?Q?CyKoiMvEpr3brMdsBabkErrZzswYPXkOi0Cv0stfvKHDhb2Ft+KRrmiOUGwo?=
 =?us-ascii?Q?TXG7/PnZ6nWVgzZ0C0XsDdJa/josL8q1hU0pRkqI9dDx6CLv2PwDghoss3+V?=
 =?us-ascii?Q?xq7NvhpAMzO8d/KCB9ssPIxUQ8W65fZAVKoUdGoZu7hROvUExEFGDBwdnHPo?=
 =?us-ascii?Q?/vGOTTpxVBO7h0A5/GegrQkyKJSollbWhpK162TrYjUhzq9HTdmTar6UA0GG?=
 =?us-ascii?Q?QueHQU9dzN3tQFjFxhdA1LXQQuu0OWnZ7zbrPSFgzD3TA+r2Lu9TMeGqAEYQ?=
 =?us-ascii?Q?PLd0CLXS/Ens7DTw805Ppyx+0hj2woqAiUUhqG+MBSp16YfQnsdbiNGCN5fb?=
 =?us-ascii?Q?KjSpsGVFw+JTEKOqTHPWs9ndJOUM/+YAyT+3tgCbZuhHpTHc1ENeYZyAIXtD?=
 =?us-ascii?Q?WYTTvB9j0ckKvjMgKqbYaOYbInijUEbj6Ph1F8e6rLqavM0CYBaeIvAuGz5b?=
 =?us-ascii?Q?vANIX/m/yMxkWsXLITQyKJie+xocoW3Xoh6iGKoPlnrjOupvfWRnLzjKFymF?=
 =?us-ascii?Q?IpwSoq1t6yRVB/EPW2B2p2A20MrbGMgyNPHhkCbAQ2v8luba3/087O7GUy9P?=
 =?us-ascii?Q?hDjn0Z/4h3Jxwa/SOKv4OHnm8YR4rgbiGGXcftoSH2HBmY3NuDtEa3OcouZ3?=
 =?us-ascii?Q?JFj+viJWuaKW/bYaX4TTDZgRj9RQTG3PzHgyv8bTTwzEq3Srfm4RqiE6733z?=
 =?us-ascii?Q?aUDKtY9TfaxZEzg7+jIeSqEh1+/JrSJvBReRWg/6lzkHD3/FQaH+1zXPAXmB?=
 =?us-ascii?Q?N/5jssN+i0PV4BY/3iWoDm/lv8xiJmdyPyRoJIQuRJMEAmkBseKyG8EZshDS?=
 =?us-ascii?Q?1TFxD4DdoX5iZcM2DH6qGmRUGrRCHNyWXnpOj4+Xz6odvJ9xtRJorxfkKjWf?=
 =?us-ascii?Q?mLLqYQgfXm89z/zittECAFAFBBMTY5Eu58tSec9JK0OhqhKuHJF1xsG7NDED?=
 =?us-ascii?Q?mJ/czWLpUAbcZl+hlA+35Xgp0e75hoTP7nhxOHb8kl9u7l8YPgF5FRN1srna?=
 =?us-ascii?Q?klirbZoalmhrH1HjRhJ79EnYezdnmS6pXmdvUxbylfWggN7Jg8GO45n4KuCQ?=
 =?us-ascii?Q?GxWjnhCgjtr0CequTKNJrf+7RAW20ZKNBAlKfoaovK/5WGnMtaHqDHsAo+DT?=
 =?us-ascii?Q?Vd1/dfZVh02XXMLJGKbfmr53TEEzJuvfN6ZGPqik+Ykoh4PWM1BKk+rNKKlr?=
 =?us-ascii?Q?siYB/eciMREsRQQ9rBoQTWmVkv+U42eO4F53STLlefeamWG6GqQD6cdI+OtI?=
 =?us-ascii?Q?ggKv3qECTOWVxHpyk4NDLVvzzh1I/Ted3mHncpyKk+jcGhJqe640cDxsriZY?=
 =?us-ascii?Q?UhOkz5pgyXjDiPIN6C1/u60gNHNhIhkd6oi0hlOsMn6egw7+PYseJehP4a1R?=
 =?us-ascii?Q?zV6MTYO7oP3vHtuI6PYk9AomfINA76To06k8P3YecE7nn8OHzMVuFMcSIAIX?=
 =?us-ascii?Q?jGo9W9k0wB9wPwGnhzOfG5zxr2kfdgcsyxBALSetQgGXG+1H6YZxvfu8N7N+?=
 =?us-ascii?Q?dLEZtRbHRs1B7S75MEbw09vrZgdptDvZtupZEnDm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a03b19a-5972-4210-9017-08de380a7839
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 16:37:55.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQnv7Y399rAcNbvZGTgVkPp30Fvg+sdCO6eMJW6KEuPKv123y9SvIFObpv6i51gl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

On 9 Dec 2025, at 23:27, Matthew Wilcox wrote:

> On Tue, Dec 09, 2025 at 11:03:23AM -0500, Zi Yan wrote:
>> I wonder if core-mm should move mTHP code out of CONFIG_TRANSPARENT_HUGEPAGE
>> and mTHP might just work. Hmm, folio split might need to be moved out of
>> mm/huge_memory.c in that case. khugepaged should work for mTHP without
>> CONFIG_TRANSPARENT_HUGEPAGE as well. OK, for anon folios, the changes might
>> be more involved.
>
> I think this is the key question to be discussed at LPC.  How much of

I am not going, so would like to get a summary afterwards. :)

> the current THP code should we say "OK, this is large folio support
> and everybody needs it" and how much is "This is PMD (or mTHP) support;
> this architecture doesn't have it, we don't need to compile it in".

I agree with most of it, except mTHP part. mTHP should be part of large
folio, since I see mTHP is anon equivalent to file backed large folio.
Both are a >0 order folio mapped by PTEs (ignoring to-be-implemented
multi-PMD mapped large folios for now).

Best Regards,
Yan, Zi

