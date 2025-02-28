Return-Path: <linux-fsdevel+bounces-42824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98718A48FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BC91888EA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F719F43A;
	Fri, 28 Feb 2025 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CtkRdXQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73F18FC86;
	Fri, 28 Feb 2025 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714174; cv=fail; b=j0dxmDqVs9GSMYoJkrinqvV/5Gyu9QJp+CZdepNIfG53eg/CEwDUW1ijpvjQM8jJIWF3dXOBSt2hwMNkgJ1/+Nbh2Z5kDPTNwPIKA78dv+GfuPw9uNP+UBM0NQPdsk22ejSaITiq7/ln8J2OZ+s5pY5rntWFsf9PRiV47r/XRng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714174; c=relaxed/simple;
	bh=X7Wbt4xjnhbKkYJi8o6ttVnND+hZsR7lyQQEHgyznCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IcnVHM/ifvyuaRMi3PUC14ZVIXh4he0K98qDkreb9g96Yb3RNkMCHs7AMc9j2124v2naXH7Nxduo1rmE4tHh5CYugkXEoNobamZKXhk2cs4QYyHhFai1jil8aUxbZNC88CgZLYsQSvk6l80r8wW4oW205QLcZDVD8wjWPVJKra4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CtkRdXQB; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdQdoWqZEV0+gNu80HTfwGDPcGvgDbTHd9E0nmbzc5de4qqW8jeI6HKJu/KWKfp2mvoIQxH+s7diAhk4KJACyqIIBgXR3Vm8zJ5EuqB9OfH52YRzkuUj9UM7uwTPJp5U2SoW81bi+pk2qHsSXKNHp6PrK0cK6fQDRphl/0O+Jz7tdtJqZT0f0MsX8/dRTXpIkSBvymaSKQw8pKGQGGxgSO/c/VVY1jo+YY6agRucsr9UsfcXjkt9sj+lfhwDi3bntHAYYGYIXsx+UYbbotP/raiWEbRPLy7XWBRuOT+gwrMHikid6Q5oKwqnXDv5fKOrchNx3EVroeIxTBJ2/ePzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y48O98Ov2snDDPwroCGTud+Y+BPssMMrAvAVLkAwn0I=;
 b=uraQkK5XTrNA4eORtqbvZlE9vcf2h2h/VkAwhBVw2afRMFPMxHDFS3Rqtusa/a3bcv19NczbidRackePOxkbipNskie67IZ8pzQ5io4IgAJgo6SyBHaojoQa1FfB0LqqsqlO+zF0VmZZpweDStcs9Fikcri7FdwHzsd7gF0e8rOpymdcNBmuW10BzeBp2rSysNRzVxGRA7vzT6g9jR5H1/puHi7Y/Yc43hSG8OnBlZs0SRFpBs/GZznAn/YcqMP7beaI/5/AYiQdKzCN0GwbVxd2v7//YAVRlpIG5qoNGAiEZVIOIVUu7h6a1dSrq56ACsSqln92Kc5dUfK2Ft7APQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y48O98Ov2snDDPwroCGTud+Y+BPssMMrAvAVLkAwn0I=;
 b=CtkRdXQB3KwaYM+pGHARO9wGFx5NaEb28HDQ5Y7W24PHaGu1ILRrWKgEnf2TrkTC5bZc0++ptfHm7AxQNm7jvA1eUDXIHjF1aWrUARKqAFvGM4kFKQPisC8Xk4Mc5YAAiFFoHlyP/WVSaQO6+f/RSowTRJwSEktZ7YjsB0Y0IdjEIrxrHO2JKy3TWjU1qCoTGramochBR5OMObf7ivP9CA6XIhnQdezCR5woi5Pr2WPfjKszVpPsLICv1d91TPPYUKT//aWowMQ5r3ZcaH0zE4xMkJgptrEJEPiczTwIfNuSM5l7yK7HBag5V/Z9l0jVjD454d03SaUvCRjOKQgqqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:42:46 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:42:45 +0000
Date: Fri, 28 Feb 2025 14:42:40 +1100
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, 
	kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v9 00/20] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <xhbru4aekyfl25552le5tvifwonyuwoyioxrqxy6zkm2xlyhc5@oqxnudb4bope>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
X-ClientProxiedBy: SY5P300CA0067.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fea5d98-d90b-40f9-7fa9-08dd57a9f68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xiVFkY1sTJin/iUJg+FN7Woh7KvZiwHGWxqXC7YIuo/9ia/w1DoieBdj3NzJ?=
 =?us-ascii?Q?pbz9JRZz8ekSf7Yal1Sq9K1QstQgnMFLcLL57WM2wrCqVxr9YsW9iugIq9g9?=
 =?us-ascii?Q?CCFRu9139DVLzZ0HipRnQ6RZzdx6Kg2fDep7aX0laOrCD7vCyeoaZMRBveR4?=
 =?us-ascii?Q?Ku4BOfN+V98ecnEwRGv2iqoc+pzi/VHD4YhEYeY7uFQrfxX6dYlWWoPIhZfS?=
 =?us-ascii?Q?6BpRjMeVUOrzGZGAaxolxJHCgLD2LRQmz0X+OD8WwDfdUIS8S3HruhFl4CP1?=
 =?us-ascii?Q?Iy9wXvVWRZ3pvP1VqMCXhhY/IhwPe1bQP4G2QNrkS+2raP81ID5tnaNpoLwW?=
 =?us-ascii?Q?ZcCXIOg7DDOB0C5jL2N1RYj06IdatqFuLzEwA4aZo2YYHB8TSMN5w+0Psmry?=
 =?us-ascii?Q?K+hXG5DP02Cw/NcAZz2jOwPl2bCoLugY8t5BdnrZB/Sb5W/ILERgTbsSy2su?=
 =?us-ascii?Q?fBWm2hkg1mB8GF2PWHxD6oBVzX1FxkmczuPS16ZTvhOFd8J6bQD0Jsfevd65?=
 =?us-ascii?Q?K3i9aATfk9KNAIiPegRYGywCAtUEJgT7TGT/gKC//9n3H81rMiz/45uX0VpU?=
 =?us-ascii?Q?goRnIeizRXRtFfQZ3JAk6tGXgw6oayOFGjScmUlQPuIfTgghhx/TNVnVk/fa?=
 =?us-ascii?Q?O0A1AsISBC4OIg+KxLbpQEUkVTqUlr3IS3D0G4ewIjiZqPp/b279s6D33TaD?=
 =?us-ascii?Q?Y4bsAaRnH2aG85CGFaW53yFoMVRjXxIE2iXRCBUJIwxyHpi1UZQIslKrz3gB?=
 =?us-ascii?Q?vj7rn03O1uZvbqAmHhlw4u7GxPIt32CqBg06b3qKi6QqoOixExNWjlMji45Z?=
 =?us-ascii?Q?K0/DR80G9db6x+6Y9n40tEPEL4mKRzeP+AhZyiaOUQFCifA6ZxKEWYhDNf5a?=
 =?us-ascii?Q?GcDDsZgHXuLczONiuzcMAIVwWNmiOefTlnHD+A6Px9L4/Aktxn1Thvgb0u73?=
 =?us-ascii?Q?3bjhKLo480DdnoLCuoEvFUFC8kmDbii6KnAcSlVqY+oao9ADO62qYcLPpmKy?=
 =?us-ascii?Q?qvYhgkqRUEBVfmFsLozmO9Q08oRf/DCDjTk8pxXL+myw754aVtaZ9B8owe6D?=
 =?us-ascii?Q?+aX7SqbAB5cmURw1f8axXrcZnFdI1L+uR1+Zs/22MtL6r+n8tBezw756TqEU?=
 =?us-ascii?Q?hE9c4ZJgbBDtqYk+HaIt4h6zQCGo86M4Ek2WQCd5PcskcGYagYxXIrTtHRt+?=
 =?us-ascii?Q?V6ypGuNOlnmAn3czxwAzRsnI+WghSpF5I7Bxig/XIrJLM4dHYQ1dqWyuNJZY?=
 =?us-ascii?Q?cmiS8yBoI069IIBAwmlYdUeIn+vZq9IEHPXR6aua8oJW+RJy4sFPo8G1IVnv?=
 =?us-ascii?Q?0B2zsdYBTuKvVZTOTNvfG57HoQqSZz0I9g+ImfgSL0SqdjL4O/ls3ZCRNbQ8?=
 =?us-ascii?Q?bQP21e1cPu5Is548Okgn/XPGixIz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lB9v+VJd6AKvsjl/MAegkEJQtb3SahpLG3k5FyCwnOsnQjjNHLAL4f2X/vo?=
 =?us-ascii?Q?0IMpTJEvVNYPYKVF0SoUDOLGyePkYK47Rj1FUYdO0v8SdYgp/q69LUoH8vuu?=
 =?us-ascii?Q?oVvknYJ3QHPPLuQ15y0V61SBu3DpAdjOWhyuSIMpfQld90lBf/PuOw3FSFVW?=
 =?us-ascii?Q?pgYdB88ixqOgOoYGnCwL+JxXc9cKZNLXxQSZ1u2ijSdYiMLJ4bgEesan/tWk?=
 =?us-ascii?Q?aUAVQGty1qP+ZnncY70QJ3+/8Y1hAQ8kPHABaEAu0aVJbq0uaSvoBHTLMnVY?=
 =?us-ascii?Q?TRyq9PopR8WoW5JE/SCaB0BEDb7FOUuIg5c2mY7YZoIJDJuzp8jQrX8YgkF1?=
 =?us-ascii?Q?qDXpPbh+0TTUvCa2wQqBI7UjpWgZdPvLgykYIcOTsZZURHu8a0e6LLz+y5NM?=
 =?us-ascii?Q?p3VLfVd7TDqSSDBa9iedgN6cCy/BMp5T6yZdsAwkVaRsckAXPk4660Uen2lA?=
 =?us-ascii?Q?rhteCLT/6dfxgfeDxQsXqWzvjIoFUXKsptaqBDx8Mj1/KEtKUhlH2hYKsu10?=
 =?us-ascii?Q?YX+QNq3CZUqu0hs1/tLXKpG7gdZJHrPXox5hK8/Q9x+aE9ugwB27jwvLCpMf?=
 =?us-ascii?Q?Hw5w99WEEqUTb0++WqH3o03dQGFZDLF/B1o7LwMf5J6oEZYmungOYSmWEwTi?=
 =?us-ascii?Q?w1F2oGWy7gPWNLeGiZeA1VDoO30PMFLwdhjsxGQw2qZyml4k7iPyI9IQlaq3?=
 =?us-ascii?Q?YDtt9ndy7/s6IapidjyMNIeyNeOKYbZL2WNkcZgeg6ewgaLtXfU7uKOcgQ7P?=
 =?us-ascii?Q?XT8bkPASGd8I9aP7KBYBAGVgif4YvaUFWiL/cta+ndy0mpIkxZ2NDigaPhpJ?=
 =?us-ascii?Q?0tBexL4hWQGygg5P59aTZhgjpiEbdfpF2TRYGT298Y3j/AMmDI6HN7kZpdzs?=
 =?us-ascii?Q?4KzVg8svoElNAbHiBKU5vBNUATFmSAoIkxH0Y3rTdzfGI9WoGeJ/pYor1bTJ?=
 =?us-ascii?Q?OeSnJUX5OEjm9gM5L3Ad0MgeLnDG1+YHmt7onEfJcTqM2J18INFiXvM8u/N4?=
 =?us-ascii?Q?jjB6LjoGJb0I2jWD8PMhfVG2B1Fwo/vAw4BD4VVIZ5pyFvVkVVJJaVbB00oN?=
 =?us-ascii?Q?7Yc7kWFns9J+JoAxF+cmsdZsI4wBLHXJgfNe+TZpYU98nKyCce047heFcra5?=
 =?us-ascii?Q?UgNK+57HFbMOD7qF0oEEj6zHncTu5QxxdXdM7UBfG9ti1SgT2LmIrgzEE2+L?=
 =?us-ascii?Q?GrX89BnzbBvHhH4mNAfk6pBw0ILUtqUYlHfpBrQ9gKw+QZXzAVDr+dWQ4LMY?=
 =?us-ascii?Q?N+yPM1q/GyORUwCeaGz07n1io8gCOmmabkjSf2bT0qUb0d0o5zQKIzNDGaPr?=
 =?us-ascii?Q?pG8gUVABFi9e+PY0ZRiEmg5K4ii3e6bPexlc5DBBdbUmvV/ZmhJdkufmj5cB?=
 =?us-ascii?Q?58CY2+7HvZ/PabG1/OF9X2oER868cVjpWa3dmz5p53ej5k+JsoZakDYArmT0?=
 =?us-ascii?Q?PpcHksR9WVNvqyc9sd9udP5fJEHAXBbhjWAuOXHlCbL6B8dja0dbGuz2HGBa?=
 =?us-ascii?Q?oymMUBLQG9YB9wAVSYd96b4iVOT4FHMy4tFK3Z6H7CD8Ur+0ODHg0IUk8/pa?=
 =?us-ascii?Q?4tKOti9KVH+DgxBgPQbDjrJcorD1LdEyNs1TFmvZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fea5d98-d90b-40f9-7fa9-08dd57a9f68f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:42:45.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXCSEm7NqJ0hKtbDQ9ErOSMep7VD88eYcYBMSzCXB9JoJpQSCu0uSwjOnSy0B8IoPNSzpc/Bza3ZJ6AwzRA+Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

Andrew,

This is essentially the same as what's currently in mm-unstable aside from
the two updates listed below. The main thing to note is it incorporates
Balbir's fixup which is currently in mm-unstable as c98612955016
("mm-allow-compound-zone-device-pages-fix-fix")

 - Alistair

On Fri, Feb 28, 2025 at 02:30:55PM +1100, Alistair Popple wrote:
> Main updates since v8:
> 
>  - Fixed reading of bad pgmap in migrate_vma_collect_pmd() as reported/fixed
>    by Balbir.
> 
>  - Fixed bad warnings generated in free_zone_device_folio() when pgmap->ops
>    isn't defined, even if it's not required to be. As reported by Gerald.
> 
> Main updates since v7:
> 
>  - Rebased on current akpm/mm-unstable in order to fix conflicts with
>    https://lore.kernel.org/linux-mm/20241216155408.8102-1-willy@infradead.org/
>    as requested by Andrew.
> 
>  - Collected Ack'ed/Reviewed by
> 
>  - Cleaned up a unnecessary and confusing assignment to pgtable.
> 
>  - Other minor reworks suggested by David Hildenbrand
> 
> Main updates since v6:
> 
>  - Clean ups and fixes based on feedback from David and Dan.
> 
>  - Rebased from next-20241216 to v6.14-rc1. No conflicts.
> 
>  - Dropped the PTE bit removals and clean-ups - will post this as a
>    separate series to be merged after this one as Dan wanted it split
>    up more and this series is already too big.
> 
> Main updates since v5:
> 
>  - Reworked patch 1 based on Dan's feedback.
> 
>  - Fixed build issues on PPC and when CONFIG_PGTABLE_HAS_HUGE_LEAVES
>    is no defined.
> 
>  - Minor comment formatting and documentation fixes.
> 
>  - Remove PTE_DEVMAP definitions from Loongarch which were added since
>    this series was initially written.
> 
> Main updates since v4:
> 
>  - Removed most of the devdax/fsdax checks in fs/proc/task_mmu.c. This
>    means smaps/pagemap may contain DAX pages.
> 
>  - Fixed rmap accounting of PUD mapped pages.
> 
>  - Minor code clean-ups.
> 
> Main updates since v3:
> 
>  - Rebased onto next-20241216. The rebase wasn't too difficult, but in
>    the interests of getting this out sooner for Andrew to look at as
>    requested by him I have yet to extensively build/run test this
>    version of the series.
> 
>  - Fixed a bunch of build breakages reported by John Hubbard and the
>    kernel test robot due to various combinations of CONFIG options.
> 
>  - Split the rmap changes into a separate patch as suggested by David H.
> 
>  - Reworded the description for the P2PDMA change.
> 
> Main updates since v2:
> 
>  - Rename the DAX specific dax_insert_XXX functions to vmf_insert_XXX
>    and have them pass the vmf struct.
> 
>  - Separate out the device DAX changes.
> 
>  - Restore the page share mapping counting and associated warnings.
> 
>  - Rework truncate to require file-systems to have previously called
>    dax_break_layout() to remove the address space mapping for a
>    page. This found several bugs which are fixed by the first half of
>    the series. The motivation for this was initially to allow the FS
>    DAX page-cache mappings to hold a reference on the page.
> 
>    However that turned out to be a dead-end (see the comments on patch
>    21), but it found several bugs and I think overall it is an
>    improvement so I have left it here.
> 
> Device and FS DAX pages have always maintained their own page
> reference counts without following the normal rules for page reference
> counting. In particular pages are considered free when the refcount
> hits one rather than zero and refcounts are not added when mapping the
> page.
> 
> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> mechanism for allowing GUP to hold references on the page (see
> get_dev_pagemap). However there doesn't seem to be any reason why FS
> DAX pages need their own reference counting scheme.
> 
> By treating the refcounts on these pages the same way as normal pages
> we can remove a lot of special checks. In particular pXd_trans_huge()
> becomes the same as pXd_leaf(), although I haven't made that change
> here. It also frees up a valuable SW define PTE bit on architectures
> that have devmap PTE bits defined.
> 
> It also almost certainly allows further clean-up of the devmap managed
> functions, but I have left that as a future improvment. It also
> enables support for compound ZONE_DEVICE pages which is one of my
> primary motivators for doing this work.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> 
> ---
> 
> Cc: lina@asahilina.net
> Cc: zhang.lyra@gmail.com
> Cc: gerald.schaefer@linux.ibm.com
> Cc: dan.j.williams@intel.com
> Cc: vishal.l.verma@intel.com
> Cc: dave.jiang@intel.com
> Cc: logang@deltatee.com
> Cc: bhelgaas@google.com
> Cc: jack@suse.cz
> Cc: jgg@ziepe.ca
> Cc: catalin.marinas@arm.com
> Cc: will@kernel.org
> Cc: mpe@ellerman.id.au
> Cc: npiggin@gmail.com
> Cc: dave.hansen@linux.intel.com
> Cc: ira.weiny@intel.com
> Cc: willy@infradead.org
> Cc: djwong@kernel.org
> Cc: tytso@mit.edu
> Cc: linmiaohe@huawei.com
> Cc: david@redhat.com
> Cc: peterx@redhat.com
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: nvdimm@lists.linux.dev
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-xfs@vger.kernel.org
> Cc: jhubbard@nvidia.com
> Cc: hch@lst.de
> Cc: david@fromorbit.com
> Cc: chenhuacai@kernel.org
> Cc: kernel@xen0n.name
> Cc: loongarch@lists.linux.dev
> 
> Alistair Popple (19):
>   fuse: Fix dax truncate/punch_hole fault path
>   fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
>   fs/dax: Don't skip locked entries when scanning entries
>   fs/dax: Refactor wait for dax idle page
>   fs/dax: Create a common implementation to break DAX layouts
>   fs/dax: Always remove DAX page-cache entries when breaking layouts
>   fs/dax: Ensure all pages are idle prior to filesystem unmount
>   fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
>   mm/gup: Remove redundant check for PCI P2PDMA page
>   mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
>   mm: Allow compound zone device pages
>   mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
>   mm/memory: Add vmf_insert_page_mkwrite()
>   mm/rmap: Add support for PUD sized mappings to rmap
>   mm/huge_memory: Add vmf_insert_folio_pud()
>   mm/huge_memory: Add vmf_insert_folio_pmd()
>   mm/gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
>   fs/dax: Properly refcount fs dax pages
>   device/dax: Properly refcount device dax pages when mapping
> 
> Dan Williams (1):
>   dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support
> 
>  Documentation/filesystems/dax.rst      |   1 +-
>  drivers/dax/device.c                   |  15 +-
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |   3 +-
>  drivers/nvdimm/pmem.c                  |   4 +-
>  drivers/pci/p2pdma.c                   |  19 +-
>  drivers/s390/block/Kconfig             |  12 +-
>  drivers/s390/block/dcssblk.c           |  27 +-
>  fs/dax.c                               | 365 +++++++++++++++++++-------
>  fs/ext4/inode.c                        |  18 +-
>  fs/fuse/dax.c                          |  30 +--
>  fs/fuse/dir.c                          |   2 +-
>  fs/fuse/file.c                         |   4 +-
>  fs/fuse/virtio_fs.c                    |   3 +-
>  fs/xfs/xfs_inode.c                     |  31 +--
>  fs/xfs/xfs_inode.h                     |   2 +-
>  fs/xfs/xfs_super.c                     |  12 +-
>  include/linux/dax.h                    |  28 ++-
>  include/linux/huge_mm.h                |   4 +-
>  include/linux/memremap.h               |  17 +-
>  include/linux/migrate.h                |   4 +-
>  include/linux/mm.h                     |  36 +---
>  include/linux/mm_types.h               |  16 +-
>  include/linux/mmzone.h                 |  12 +-
>  include/linux/page-flags.h             |   6 +-
>  include/linux/rmap.h                   |  15 +-
>  lib/test_hmm.c                         |   3 +-
>  mm/gup.c                               |  14 +-
>  mm/hmm.c                               |   2 +-
>  mm/huge_memory.c                       | 170 ++++++++++--
>  mm/internal.h                          |   2 +-
>  mm/memory-failure.c                    |   6 +-
>  mm/memory.c                            |  69 ++++-
>  mm/memremap.c                          |  60 ++--
>  mm/migrate_device.c                    |  18 +-
>  mm/mlock.c                             |   2 +-
>  mm/mm_init.c                           |  23 +-
>  mm/rmap.c                              |  67 ++++-
>  mm/swap.c                              |   2 +-
>  mm/truncate.c                          |  16 +-
>  39 files changed, 810 insertions(+), 330 deletions(-)
> 
> base-commit: b2a64caeafad6e37df1c68f878bfdd06ff14f4ec
> -- 
> git-series 0.9.1

