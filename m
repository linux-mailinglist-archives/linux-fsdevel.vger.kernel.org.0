Return-Path: <linux-fsdevel+bounces-16869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16648A3E4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 22:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7943B281E37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 20:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA353E0D;
	Sat, 13 Apr 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YtkWpABM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAB4F20A;
	Sat, 13 Apr 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713038886; cv=fail; b=sacb96EtupCf/Q56CGVErXPPfYva3MLIoyHm7MPKXe5o0orF9hthdGvD4RXd1s6kTFqt2m9cb6znFE25uox3vxIwC5rJlVV7dNYmZVjs9CUBkkK0IDYerx4hiBU/X+RWjfdxdMC7P9f0bdsvPaBRQF4RLePnrW2Nn5fL6d3HkjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713038886; c=relaxed/simple;
	bh=HNNzN3334tX/pU3zEVAjlWFi1Ge7jvyKR0KtNp1OsAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ofzWirSLUuxR+mkot1sGQVvBTSTX2Cubp+c+wrUhT54kKuEI/0B9yBkMuFFr9blZWbV0nftHLjJbHXT1fRW5IysXZ3gokd50fdzrLq/cixNwRO1xyzN5nwOzl2B7N7V08IEBDqAJHiLiG3Sy4Ct5ojRUcDgm1PlRYFDZaTM0lRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YtkWpABM; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8WuDCbX66hoJbEa46MaN65oRrqhNUby6oAamMBXdNECD+Q59zYhCCgzP7H/xdqWH8vFzx3p8o3a2epxFU9W8NCns7TSgBX5D6qiXtTd9/r1oDSlC/2m7t3IKdjS8t19JODXcrXx1wkKom43uDadTgv25CQfMUETOQz1dcAcf4c9aBrV7N4EhGhOJxbYP1w8bw4iJ+ilfLuo1MX9aILv0xYaZ0vYLqchY2O9Rij8+PQXGCccoudHsVKiUEU9GmvEeMv4j5vOFY5doXT85TfJaAgxHT808ReTWjmZC1jK3yvRJVLKNEQ+7tiRu1CxU2kplSHgwVe9P/LlsffYf3sK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ldy4aGEadHWsLGVGxixwC5Xmy2B/Sn2gi1wsIlA9SU=;
 b=Da6YMRIVZO465D4FtfVtCRK95c/jRORMYs0cGjimzDW9Jp1f2xdr8crlah0f2FzjtMnp3we4/zJwrnhKrsIWXVznKnhHar3SSxdAJuTIGgd9FrtGgAa2z/DrHtWPqnsui7B9pBwj1fMLhhj4JurwtgWfyrdeL9P0v/K3m7McHuqz0nVCf8bgzQCjGbw/19obdEaFdofE7f7Zcu9Lp5uoyskCfbtIldaHzhNE82h+zblNNGF8dQ/SsA+cBME4GjOfHuWoIzWIYrnyp9rIFhrf+LIJr0H5jfe5djvO5il8F1+J8ATvLYVbDNxK8N2VdO8WalKi8qOIpYDULf1ZuoH4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ldy4aGEadHWsLGVGxixwC5Xmy2B/Sn2gi1wsIlA9SU=;
 b=YtkWpABMS/AR9OW1eZo36RHZPgUsbLCreM+F1KcnV8GQ2QFG7cNXMlb5Pec01dEuhKHKejfelddquUVOLRuqYV5Yy0kME3I+C/BMZQD8H2BtNKpY2U3gHntE6qPE8I0QksztK6QgFIdpQK5kUAgBxEO2E5YBJD0ERHTEyEDMKR1QghBcjRlhRjydIhzCmip4818DjiC3JyaznjIZgsonFToRThxKhmyRE/FXNC5/sSujeiANmYKyYPyk5aBh4Xhh2p8vNzf+vBTfzrg3Zv86MM056pbpJIkLY+OEYDwpn/cRKgyP69gVUruGnxKDAq5mCAGGA4iNShI47zZeddNzaw==
Received: from SA0PR11CA0034.namprd11.prod.outlook.com (2603:10b6:806:d0::9)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 13 Apr
 2024 20:07:59 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::60) by SA0PR11CA0034.outlook.office365.com
 (2603:10b6:806:d0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 20:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 20:07:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 13 Apr
 2024 13:07:53 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sat, 13 Apr
 2024 13:07:52 -0700
Message-ID: <24b88e53-a1fe-4fba-a7b5-ffcbeba88a73@nvidia.com>
Date: Sat, 13 Apr 2024 13:07:52 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm/gup: consistently name GUP-fast functions
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Mike
 Rapoport" <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Peter Xu
	<peterx@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-2-david@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240402125516.223131-2-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dcf203-1e71-41f9-509f-08dc5bf56ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Yh8kiGrxSEYZAQRKZ4+LFpmEH/MXvcK7Bd6ZaKz5mXR7hSl3pBC9OcSHtRPRLv68jtBcL9wDJRMrFW3BwZegnfwQ8Da65eoEJppmnIDnCcY/xfsHHyNWwtEoA/p6HNwQZtQ13xxNzzKQuMFn/ESRAS4fp6g/6oIsgOknsu+EISPCQA21IiTdonAk9nJbN2ndwv/l7DlutS3tZ4MZjoVssLon/GRUlB5D8Wwl5/q+4CocXjkIQa1QLF4eYj9RuIe0lycJrwFKsUEEnVz5u/8VEoaaOYoqxAp4ytevAFWDvKqt4PneEbKWQWBTzyJrlqv9bquDur6v4/jbEH1ujo71HwxFXRIshg8A7jL2mWRitO1fM9v5pZVAdaRN6XwtLwaqxOBVuxCbxC5eer25cFzLWYbB7TNGTHZC+AdBUgwyD6ltsH4a0hy3d2pyWsL3nybbuNzwslnhaMNRlkSqKDeb3Sorm6mmBS3fc7Hnm0gUdI85AiqR9fFvHkmxZKcXZoq1jAtZM3Jp+7dq5sUFwB3xzIweBzh0hb0QiQVjhE+34A5rLvlExI3Oiil5qCoVDIyPtsnfpUgQY3/hyHFGagnlS5FEuvRulIh0PW6Nl31NgPJLTjQDiPTLoW0aBBDldsm3am/hrsyS1p9aXn4WO1vH/EnPrbFTvfADdXyakOf49ffZWIOy8i49rBsuSBMQduj21y0LEmmCdyNXwOuB2Brs+E7O5p5EGgNGV3Nclobg/Z/3GPHxZXIW6eyRlWTzKvj
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 20:07:59.6800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dcf203-1e71-41f9-509f-08dc5bf56ae6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

On 4/2/24 5:55 AM, David Hildenbrand wrote:
> Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
> all relevant internal functions to start with "gup_fast", to make it
> clearer that this is not ordinary GUP. The current mixture of
> "lockless", "gup" and "gup_fast" is confusing.
> 
> Further, avoid the term "huge" when talking about a "leaf" -- for
> example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
> "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
> stays.
> 
> What remains is the "external" interface:
> * get_user_pages_fast_only()
> * get_user_pages_fast()
> * pin_user_pages_fast()
> 
> The high-level internal functions for GUP-fast (+slow fallback) are now:
> * internal_get_user_pages_fast() -> gup_fast_fallback()
> * lockless_pages_from_mm() -> gup_fast()
> 
> The basic GUP-fast walker functions:
> * gup_pgd_range() -> gup_fast_pgd_range()
> * gup_p4d_range() -> gup_fast_p4d_range()
> * gup_pud_range() -> gup_fast_pud_range()
> * gup_pmd_range() -> gup_fast_pmd_range()
> * gup_pte_range() -> gup_fast_pte_range()
> * gup_huge_pgd()  -> gup_fast_pgd_leaf()
> * gup_huge_pud()  -> gup_fast_pud_leaf()
> * gup_huge_pmd()  -> gup_fast_pmd_leaf()

This is my favorite cleanup of 2024 so far. The above mix was confusing
even if one worked on this file all day long--you constantly have to
translate from function name, to "is this fast or slow?". whew.


> 
> The weird hugepd stuff:
> * gup_huge_pd() -> gup_fast_hugepd()
> * gup_hugepte() -> gup_fast_hugepte()
> 
> The weird devmap stuff:
> * __gup_device_huge_pud() -> gup_fast_devmap_pud_leaf()
> * __gup_device_huge_pmd   -> gup_fast_devmap_pmd_leaf()
> * __gup_device_huge()     -> gup_fast_devmap_leaf()
> * undo_dev_pagemap()      -> gup_fast_undo_dev_pagemap()
> 
> Helper functions:
> * unpin_user_pages_lockless() -> gup_fast_unpin_user_pages()
> * gup_fast_folio_allowed() is already properly named
> * gup_fast_permitted() is already properly named
> 
> With "gup_fast()", we now even have a function that is referred to in
> comment in mm/mmu_gather.c.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/gup.c | 205 ++++++++++++++++++++++++++++---------------------------
>   1 file changed, 103 insertions(+), 102 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


