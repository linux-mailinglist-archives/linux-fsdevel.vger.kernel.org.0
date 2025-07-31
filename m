Return-Path: <linux-fsdevel+bounces-56430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5AB173CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F32C1C24AF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59F1D7E54;
	Thu, 31 Jul 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TuTn6ohX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15D1ACED9;
	Thu, 31 Jul 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974812; cv=fail; b=QITKfkLLDBL8YFHu+sKeV3rpLZtCqHAKwXGANBTp/kHgzt074abfI+qWbqUhq2qzDwAizMK3vRGG9GQx7ud4OQzq5lmUTM1vtSiXwNq+CVMAZtKcbt9s/hdCdpDT31mDTxg52ouzaWgPk+p7sUyKVTdZnGxbpWOf9e/t6clucgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974812; c=relaxed/simple;
	bh=G5sdGOvbC52HoBecaViYloaXDaJlr9J1GX9ghIYzRic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+MzjFuvo32UGY6b4d9vVC8SU3hpvYWWhSZ2Vbe5hJeS94R40sd8LGlUCWUW2yEaY7WgFeo8ckDy1fsPVcZXG2OgSIccYO4k/dS/BFJFdr6ZM503TUawYVJluIig/v4y6DSmXqRvnYZtjDuk3sHkKOBJJyv2JMleQTA79yuuskU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TuTn6ohX; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF36mPxoa0Hjg1mJmY4CqDYvl+zG8qTS2eeQGlfp6NChWqeG4FTbsW94fOglMnwwGU3OFU37PbtykS3+CQS+bP1DpOBk7HXNtzKRchcCkKEs46vhcTE7t+SZz9MOb4cM4FTswq20ZRp5SkIGa9RsxE4CeBaq88MVVvNghIrs/DhsdLFkOsVKJ5jIFiva5pq8RSoCSn3Jb1KvuHcmONSjaRlWt6C4uGn5x4FUxLjBn2Jos1b3mHLNfvsxG36NhCX64xlxyceBo6WgqgD+km4ogqh3OtwtCHwtp12WxmkCmOZsLk44e9cO/rX2GgpzhJMDa01BcS/hUC0tq0xZQt+MUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcza+JNF+hy5WaiW+B7EB++1RZoUIVbmDY+FEuYBNIs=;
 b=wFOarpEEjg5E4VlWOPvbfJz4oOAVAk5FLmOtKzIm40cPcBA6BVjysIDskTpP2sO2rMebDo+ydYtL5A3QFAJC79ruYAxs5QbYja3lUjRIZAjwJBqLfgiNrTTkRXa1rdYHdEQS1zDGsg7TaSI1DV7rMOU8KBy4ypFO5l3bdTT+iOFXDg5/d0ml2+Cy1e6iDUIC5Wo/2CHJglNoG2LqJSCj8Y2t2z4OXgOuR01YN8ttVXELBvXIPMq6zrFN+R1pvoic1uXvnPiPwAOz3qa2lTfRTuQUSmks6GCIRINn74QytkFhAO4cak+m58WYYHkTutDjTYBI1CPp1KajG9EYNicpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcza+JNF+hy5WaiW+B7EB++1RZoUIVbmDY+FEuYBNIs=;
 b=TuTn6ohX4M9+J/HzOrHS7V4nNl62t2cQkwFSh10ERTH7paubfd5yWXnzMmPW0JiexDL9PriE0QdK2WuCAYQDm0/n+2wbILNR+CQILCEGuDEtsjRnymcgGbdvf9QjFA28/4LTPSYRbnivKe6uudPdKGkegxUb0VVk3vGVV2jYtKYduy/gwHYD1tnYqPoUPHqpdhvigjMav0ZFyVEemWdigX/3CyU1LySU9WTWnVqeA2xW7OSMok8GmEd80TtbAe8cAyheqNkJ7fq10CkAFd1/lyMZ9c0DuBBwTI5o0JjxvkpjxRzIyqmUnckxTy3Hyxdt069/2YnCW/SN7HmiJBUg7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.14; Thu, 31 Jul 2025 15:13:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 15:13:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Date: Thu, 31 Jul 2025 11:13:15 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0ADCB72F-9D63-4202-89C7-D55734804E41@nvidia.com>
In-Reply-To: <20250731122825.2102184-2-usamaarif642@gmail.com>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-2-usamaarif642@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: da5483bc-e9d2-4547-c5bf-08ddd044cb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kDsZaovEyR+RTs4ba2Uoh35DLt10JGKVUBFFvIEGAcoxxa0wzKn97fzVW7AX?=
 =?us-ascii?Q?9TQpZAxbB3mLKW5Rlg32moDDLt9sVaMHl4jgxaCWOC9TKwXYuhEo1wvFviW+?=
 =?us-ascii?Q?kEUMI7xqG8d83MEuonwHX7DqVEmHvSfE6nb73MhXJ6iMzEeUgyrEpg1IDuJh?=
 =?us-ascii?Q?X9ZWws6NX3MXPkE5kqb8blE9wNVHxGCyEApeuWSlDZwFIzW/mWiUqvFH3r/m?=
 =?us-ascii?Q?bMFEA7zuI8E9kUgAWqyRcxg6IUxMq9EAd44nAKlGrj/8/TAGwXg3XF2r2jmR?=
 =?us-ascii?Q?MhiGMgzB+LnzoMf1dUOLn5fHChySyOJsbD8gypSS17CSnYGXvf8PwyakTcgw?=
 =?us-ascii?Q?71NqeDNKL0cN/XVcF576XoJ1YUa2cwz76XR0vC7IFAQGO8g2bzW4ME308M0t?=
 =?us-ascii?Q?dyIQsBomM/ddDiDm7S0ngjR00Nt60JNq0/IE1bS4zOeFA8SYJhNlh6ggtTur?=
 =?us-ascii?Q?tiaGtedLv++FD0jo85LaaspjlT+05OMBUCV1Wby8l2EwZVx5bRu7x5WZAq5K?=
 =?us-ascii?Q?y395OhMECVcHm6nnoxWlXaAuPTnGDzL90FC4fwrpx+Chx1kUap3jqempD/qB?=
 =?us-ascii?Q?/QKHgHOq8Y02X12DxDAIWjYnuGMKDIgX788JMGyItBGiZEhP9aoaaydEUF3a?=
 =?us-ascii?Q?XiRrqhDGhRyCnmguhglUcTfbGpb41jWmEtfO3/7mhUf2mV8clH3Jgn8gByLn?=
 =?us-ascii?Q?Kpmnjo5E3EnQ8VoqGd8b466EdSADnzzcw3vsQhWmkavwQFHFA0IJE5/01zuX?=
 =?us-ascii?Q?4hahX8zfD+hrYdSAeipi01WpNK1QkrAtfylrFNGxBX3pvwDNecD3LdOcXdio?=
 =?us-ascii?Q?+WZ7zAOp4NQDLBIQFACwKTvOms4w1zhCpBK1BL6XIqLTp5iqri6VPrK9Vl9e?=
 =?us-ascii?Q?G/vInn57mPD7awrVrcgXJjRlEMtYCJdO4Yn1dcfswnhC0f3filAf1O0DdtPI?=
 =?us-ascii?Q?i+qHhwc0alhk2HBiri5jv+ZFadxX2KzfBKixdFtG4KPgR+2jxWGRzgR0hsJD?=
 =?us-ascii?Q?V7YKQx1ev41hMUeVwe6ouq5G8VGOUaN6O01EJGX4Ha92OGpBynY0aUEtzmz/?=
 =?us-ascii?Q?FoJMgOeJpeLaZAUTuv8UXgZWgYjezrR/tHWsgBvsyhqLNZ34gHIvvEK4LW+4?=
 =?us-ascii?Q?3bfdMydePQjNlFyIr4SUIjwfaD23GzbmbaYtZCiv/U+mxX4Ciy8nSbuD8grM?=
 =?us-ascii?Q?GA3OIrYZ7aOoTW3hBxhkAKA0VP4MNIN4WW9DcX8Xwcd+tnzRtj6Z8NQaZqnf?=
 =?us-ascii?Q?kxaCdBm0MXQPV/FE7RfA3n3SeR7DT/jZN3Zt4kY1iBMRkjxCK42FQ5sF+Rls?=
 =?us-ascii?Q?27W+4jogMBB2X1+jnZKSeDYSG8D1VjMNOxFDA+LFj92v9WexC09KmZP67CgA?=
 =?us-ascii?Q?6gnn7HfgO6KQpDl14eyzwHi6+IYwQqoIRDuydr07I4rGP9RgcdUUd8UvRiab?=
 =?us-ascii?Q?f0ig4Un8k58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPaXzW1SRzwiTLjC6jjJ3OCwbk4DeXa4wwD9I/mFq2uSkhqivDfw0fNaYG/w?=
 =?us-ascii?Q?nZovJAaK9a/BHDdOI7SL1uCC/DWPIH8qLvLjeekgf8beo3E1kDR4WJzo3M9O?=
 =?us-ascii?Q?rWjs+piPpYIdGAtCURvyWpIqx+xEMqqWokpYlhGlNLVPrUH0I+wE+Pq7phtI?=
 =?us-ascii?Q?nfQb3IZmYnf3F6Sk9MkQ5YXq8iHjqrKBy6+AU+3GcjVdetrRoghiLVLoKpDl?=
 =?us-ascii?Q?UrVLuS8owo3/90/WLpqPaW24ix7gQYZJAUOvy9pPpb/87O+NLBYbYo/BM+7s?=
 =?us-ascii?Q?ll0ofVIIAxrIv7ITRdPeYzxmz4bXYnXD0j51HJplxW+sEqlqCqaFpqEafvD0?=
 =?us-ascii?Q?bOhfXi1kJPiTDRTMXjAvWnIPAfB3R3tZ0HP4OnHW4tZQkxVcxtY+as4/EFcL?=
 =?us-ascii?Q?5LfF5rlSbEBH0y2knRGvextEDxK/4Qe43wBb5UP0Hhhii8Lt6bRxyjhyIEw9?=
 =?us-ascii?Q?waEAcKAVX22iYTVS6ePQP1Q1lfMcp1c8z0fGA7WSi1csAXxEVJIlGN+5bA4M?=
 =?us-ascii?Q?vPuJkRkelIXqlsF8ec8JG2N/cuNSQYu05301Mw9J5ZU6vqexfHqCv2Vthlqu?=
 =?us-ascii?Q?29Px03rUY0KZN+WHLDJC7NFj+N//ok68g9GT5eLkXUhDELTz+A+I3INPwGsw?=
 =?us-ascii?Q?X7Jm9TQ468WDyxAGL2Pt+7bez3JnlqIzP8O2FnsiPLV91EEMjwp3kySIqoZ/?=
 =?us-ascii?Q?Y3WC4k9hczg8AHNg0jh/Oo5AruZB2swi7yhfPyB0luNKEcVWnKfnhNAUVfyQ?=
 =?us-ascii?Q?OWQRw2mTbJeLyPtHifoOgG+MMFVLAfM6MUuLMthHqVS3enSWXNjSrPm1VT6A?=
 =?us-ascii?Q?ClxDMD4fCxXIkOThGvOaG/v2RYiFAUvSmO9tPwECs4JS/QJW1kVCnlpnoyik?=
 =?us-ascii?Q?URalPRZwnFWHMmSCQsXNMr2RKVeW/m8x5+3aH1soeyjWzqv/kDwb6mtzLlr2?=
 =?us-ascii?Q?GMcCAYpUD3gKw51mu9W0sBNyYkvFWX7FQwRc4kWPG176Cp2wEY0NZSX4qdTk?=
 =?us-ascii?Q?u5xZRAa0xZqNJs9XXWsOR18/q+WUa0xv0jyuAxG1puX/b1PmGVFKQKUizlX5?=
 =?us-ascii?Q?sJCT/vpK04EECaEsztQBQBzbgw/5PM/mxdyuhgaWVP5vSn2zb+s0ZIuAnQDC?=
 =?us-ascii?Q?rzHL9lwOm+dgKpHuaOzO/qrAkZOiKYU6QiVlzmfzD60kscoipbTDhRhBBCsd?=
 =?us-ascii?Q?wmerZVKg6HOWl30JRTMkVtRppjc4CdEnUy55+xtqB7yo8TZG43nF6ww6FL/c?=
 =?us-ascii?Q?a3NN46aEukVG23E+73HFxezYRaI7YbM3Nn8aF78nQPx9MUll8D8wduAiYCKh?=
 =?us-ascii?Q?oEBO7aXuN6qbVnQfV6tkQzVEEyTr7kFjOWwHmFbZKy6jLhXwWGy04/xssPm3?=
 =?us-ascii?Q?1V0K4yTsmeKEPXwMh57HK13cBbGHL1TzUDy+dVT85FaY2BesSqc9nFDpqfRm?=
 =?us-ascii?Q?zhinaDJ3at2yMCm3dCZ9Ci8rDq8DxeOXlOgU/loyL72V0Q4sQh00coUCTyoD?=
 =?us-ascii?Q?IEDRswepo0lS9PmGd96Y6LoPK08GgvJut2mYN8+x7XW7mGILRHCSisoV6Tm5?=
 =?us-ascii?Q?ayD6hXIcdZ4gDgDmdQI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5483bc-e9d2-4547-c5bf-08ddd044cb4a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 15:13:24.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75oTQWr6M1bDwW2GmlNQANzdjFEuRDjwED1DFGesCHrgaoJeShc5D//XOaPIicnK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

On 31 Jul 2025, at 8:27, Usama Arif wrote:

> From: David Hildenbrand <david@redhat.com>
>
> People want to make use of more THPs, for example, moving from
> the "never" system policy to "madvise", or from "madvise" to "always".
>
> While this is great news for every THP desperately waiting to get
> allocated out there, apparently there are some workloads that require a=

> bit of care during that transition: individual processes may need to
> opt-out from this behavior for various reasons, and this should be
> permitted without needing to make all other workloads on the system
> similarly opt-out.
>
> The following scenarios are imaginable:
>
> (1) Switch from "none" system policy to "madvise"/"always", but keep TH=
Ps
>     disabled for selected workloads.
>
> (2) Stay at "none" system policy, but enable THPs for selected
>     workloads, making only these workloads use the "madvise" or "always=
"
>     policy.
>
> (3) Switch from "madvise" system policy to "always", but keep the
>     "madvise" policy for selected workloads: allocate THPs only when
>     advised.
>
> (4) Stay at "madvise" system policy, but enable THPs even when not advi=
sed
>     for selected workloads -- "always" policy.
>
> Once can emulate (2) through (1), by setting the system policy to
> "madvise"/"always" while disabling THPs for all processes that don't wa=
nt
> THPs. It requires configuring all workloads, but that is a user-space
> problem to sort out.
>
> (4) can be emulated through (3) in a similar way.
>
> Back when (1) was relevant in the past, as people started enabling THPs=
,
> we added PR_SET_THP_DISABLE, so relevant workloads that were not ready
> yet (i.e., used by Redis) were able to just disable THPs completely. Re=
dis
> still implements the option to use this interface to disable THPs
> completely.
>
> With PR_SET_THP_DISABLE, we added a way to force-disable THPs for a
> workload -- a process, including fork+exec'ed process hierarchy.
> That essentially made us support (1): simply disable THPs for all workl=
oads
> that are not ready for THPs yet, while still enabling THPs system-wide.=

>
> The quest for handling (3) and (4) started, but current approaches
> (completely new prctl, options to set other policies per process,
> alternatives to prctl -- mctrl, cgroup handling) don't look particularl=
y
> promising. Likely, the future will use bpf or something similar to
> implement better policies, in particular to also make better decisions
> about THP sizes to use, but this will certainly take a while as that wo=
rk
> just started.
>
> Long story short: a simple enable/disable is not really suitable for th=
e
> future, so we're not willing to add completely new toggles.
>
> While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs=

> completely for these processes, this is a step backwards, because these=

> processes can no longer allocate THPs in regions where THPs were
> explicitly advised: regions flagged as VM_HUGEPAGE. Apparently, that
> imposes a problem for relevant workloads, because "not THPs" is certain=
ly
> worse than "THPs only when advised".
>
> Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
> explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this
> would change the documented semantics quite a bit, and the versatility
> to use it for debugging purposes, so I am not 100% sure that is what we=

> want -- although it would certainly be much easier.
>
> So instead, as an easy way forward for (3) and (4), add an option to
> make PR_SET_THP_DISABLE disable *less* THPs for a process.
>
> In essence, this patch:
>
> (A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
>     of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 !=3D 0).
>
>     prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED).
>
> (B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
>     PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.
>
>     Previously, it would return 1 if THPs were disabled completely. Now=

>     it returns the set flags as well: 3 if PR_THP_DISABLE_EXCEPT_ADVISE=
D
>     was set.
>
> (C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
>     the semantics clearly.
>
>     Fortunately, there are only two instances outside of prctl() code.
>
> (D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for V=
MAs
>     with VM_HUGEPAGE" -- essentially "thp=3Dmadvise" behavior
>
>     Fortunately, we only have to extend vma_thp_disabled().
>
> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are
>     disabled completely
>
>     Only indicating that THPs are disabled when they are really disable=
d
>     completely, not only partially.
>
>     For now, we don't add another interface to obtained whether THPs
>     are disabled partially (PR_THP_DISABLE_EXCEPT_ADVISED was set). If
>     ever required, we could add a new entry.
>
> The documented semantics in the man page for PR_SET_THP_DISABLE
> "is inherited by a child created via fork(2) and is preserved across
> execve(2)" is maintained. This behavior, for example, allows for
> disabling THPs for a workload through the launching process (e.g.,
> systemd where we fork() a helper process to then exec()).
>
> For now, MADV_COLLAPSE will *fail* in regions without VM_HUGEPAGE and
> VM_NOHUGEPAGE. As MADV_COLLAPSE is a clear advise that user space
> thinks a THP is a good idea, we'll enable that separately next
> (requiring a bit of cleanup first).
>
> There is currently not way to prevent that a process will not issue
> PR_SET_THP_DISABLE itself to re-enable THP. There are not really known
> users for re-enabling it, and it's against the purpose of the original
> interface. So if ever required, we could investigate just forbidding to=

> re-enable them, or make this somehow configurable.
>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Tested-by: Usama Arif <usamaarif642@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> ---
>
> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I=

> think there might be real use cases where we want to disable any THPs -=
-
> in particular also around debugging THP-related problems, and
> "never" not meaning ... "never" anymore ever since we add MADV_COLLAPSE=
=2E
> PR_SET_THP_DISABLE will also block MADV_COLLAPSE, which can be very
> helpful for debugging purposes. Of course, I thought of having a
> system-wide config option to modify PR_SET_THP_DISABLE behavior, but
> I just don't like the semantics.
>
> "prctl: allow overriding system THP policy to always"[1] proposed
> "overriding policies to always", which is just the wrong way around: we=

> should not add mechanisms to "enable more" when we already have an
> interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets=

> weird otherwise.
>
> "[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
> setting the default of the VM_HUGEPAGE, which is similarly the wrong wa=
y
> around I think now.
>
> The ideas explored by Lorenzo to extend process_madvise()[3] and mctrl(=
)[4]
> similarly were around the "default for VM_HUGEPAGE" idea, but after the=

> discussion, I think we should better leave VM_HUGEPAGE untouched.
>
> Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" wh=
ere
> we essentially want to say "leave advised regions alone" -- "keep THP
> enabled for advised regions",
>
> The only thing I really dislike about this is using another MMF_* flag,=

> but well, no way around it -- and seems like we could easily support
> more than 32 if we want to (most users already treat it like a proper
> bitmap).
>
> I think this here (modifying an existing toggle) is the only prctl()
> extension that we might be willing to accept. In general, I agree like
> most others, that prctl() is a very bad interface for that -- but
> PR_SET_THP_DISABLE is already there and is getting used.
>
> Long-term, I think the answer will be something based on bpf[5]. Maybe
> in that context, I there could still be value in easily disabling THPs =
for
> selected workloads (esp. debugging purposes).
>
> Jann raised valid concerns[6] about new flags that are persistent acros=
s
> exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
> consider it having a similar security risk as our existing
> PR_SET_THP_DISABLE, but devil is in the detail.
>
> [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gma=
il.com
> [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gma=
il.com
> [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@orac=
le.com
> [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@luci=
fer.local
> [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.c=
om
> [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-=
1p8DdXRnjg@mail.gmail.com
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/filesystems/proc.rst |  5 ++-
>  fs/proc/array.c                    |  2 +-
>  include/linux/huge_mm.h            | 20 +++++++---
>  include/linux/mm_types.h           | 13 +++----
>  include/uapi/linux/prctl.h         | 10 +++++
>  kernel/sys.c                       | 59 ++++++++++++++++++++++++------=

>  mm/khugepaged.c                    |  2 +-
>  7 files changed, 82 insertions(+), 29 deletions(-)
>

The changes look good to me. Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

