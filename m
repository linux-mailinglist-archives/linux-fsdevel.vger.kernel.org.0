Return-Path: <linux-fsdevel+bounces-42039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566EAA3B0A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9A91898549
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC261C3029;
	Wed, 19 Feb 2025 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHH5OG5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22201B6547;
	Wed, 19 Feb 2025 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941553; cv=fail; b=Q3yGOFehos+gHsB6pApcYDztkhkj1XTUm9FbQHZleNEi4R350HxGYYaBGdhSAlN2HC8VXFdrf9hqSESKB+g2zXA4bLLBtGIc0mqem8aBsSHWsqCoKDvHPgh+SV9SyRuBqT13a+XTEgJZ3akdgF+SCx7EOy3H1TNhI907qFNUt5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941553; c=relaxed/simple;
	bh=jBMOpRBgZbiwmnQ7uYsnmLZ2dIhNSAcex9L6vbC72Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FkcfD+yeMaKQapXhJeKXrj2Y2oE58kgttgMPs+QSN44MQ21L4Gho+KdS5Su7Pre10yKHr5SuwRoChRL/qL5UQvo20y/QNdRRj7+noWVSJuTex+RDaqeRa/ufkSxJThfno8Q9lHSXGt0ScPV77xFeDkFpm+PkK/LIriRqHFtbhHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHH5OG5Y; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzWkJ6kik3u4orH/x41YtYWAiGtaMr6heYQFjQnbS/e27bvEOSHYzZwKWip+IDSY3ZGXEynxxIyyIhdWK6xbVoNKUtjAZx3ZgUMakcf4uyyZbV0syvhC3hBrfJs53fiM6LcszT6ReJGFrDa+rFZXIuzuuuswTCYuPtSfX3N3YcVAH6o/OQyZQD0IFkiYe/nL5Ag6Kcir840gmF7Hxt2z3Lo1uaFRJIsyIrlwBr2CrN1WMXyCsk0HAG25U86W+nWnJjdotTmujK4hhtHf89RD56t8iJABCoNLxcDCYCZH5wk8J1pJNwtQNSQEKEwqPqEtQy3r916E/B0wAEz5kgf3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dAx8pnEU1f77OPUGYADbd/A0GQHIafKOSbQPdUpWFQ=;
 b=R3rwFUAhnuAnDtS/ZApE+Lm2b/U937et8/CXV+HETezx0tEQFVYPTviL5TimYRVZLpgm8jJYkV5cYCnBySjCNOm6jQ4t+M3OGheR00qH2oD0P6Z4/L96iTXAKaSywyE0Sg+EYg2pbM/LC0yoAZGEa05fQhR9EeOd7DiuE+czxF6vipoBqA6Z9Zf2hreVyfBhRoFDXQXdYxTRvEO7DTNE1e2sWGFukRR82/YMH0jUa3J4QttFljddItZMlEEzY5IgoXM18/3VUh0dD6yYcFzOCczl2Oni4D16SvA7aPqs01Vqce15Ry0Xm6pkkCn4ZOVOGryTmKk7isDVTu6fSwBXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dAx8pnEU1f77OPUGYADbd/A0GQHIafKOSbQPdUpWFQ=;
 b=BHH5OG5Y34ZVsll40EIGZo/UHhGubwytKrlHrU1NIq+jMUHlVKZqLNuf1xzeQiiH21SAB2SORHso2mutsPxyx/0vwk1Tqphwps9b5p1MFSl1nX7K4Q0zaQuEt1rOgwd+8PikWj4dW2LP32oLR7nYLFK2Pz5MrFd/x3X/Dg7iZwNLhImjfeE3n3NX43gCL4ed5bLws+/sq/gBv8SWKddmx8K5XS+ciVwdLMYysBJWTkSYcxxfBIq5snwQof5Qcx3gyQykVSsxC1Azbj87LRCe7JFLuI5l5cQ+261S1fTiLwhhEXdk3wRiT1YUOfOehJT1eK3ZdqyDRiRFXbSH1f/53w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:49 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:49 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com
Subject: [PATCH RFC v2 07/12] mm: Remove redundant pXd_devmap calls
Date: Wed, 19 Feb 2025 16:04:51 +1100
Message-ID: <5d4a957ae0357641eb03b2a1b45b3d8af94030c7.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:10:111::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: d7490c23-dafe-4a40-ce24-08dd50a3134f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVJCSqZVfTEWMqoZgQnK4sXKvaAn3yU3IWMMq/ryRzhC6QbeTezfpdbsZoQV?=
 =?us-ascii?Q?H7qRmhVUSHtXqgu0O1V0i2ASNXfpaNgbuwol5cigQqaWR8uAlQAUz458Or0x?=
 =?us-ascii?Q?sn8OGg8Cc8OdKBC3qUsXomc+zDD8Ui5jEo+tu5FSqq2Dc/7JwzIdlCkVWIrE?=
 =?us-ascii?Q?fxV2KT5oqD9B+RIRyE9kEl6FA7fWeNCrjFpF/xsWq/w8Fjis89nx3yJHYQ/0?=
 =?us-ascii?Q?Ed4TmsH+qEysakpszRxQ7/H0uUPZvaRlCOdUYoRTrJ/ZPvhqdP0xizGoyYyb?=
 =?us-ascii?Q?J8ZcfeoIzZR4pelRziQUifvEB8hD4zVETmJmrxzFdg391V3h82DYxQ6W3rzO?=
 =?us-ascii?Q?gJlImIyMTZrrKcvxJ/9M/r8ua0JkFtLGI5RdRgIIrijDUGgucJeZhWvYSgQm?=
 =?us-ascii?Q?ZRCumOSHo4fz4exCDJ+qRjO+ZArwsyqE8H7VqeH21VuP7htCXlxNGsQFA5vC?=
 =?us-ascii?Q?zL8goHjUcLz1vUKhenRzIDRMFxsIX5GASMUsb76rBjseCtoH4UwRYwy0Nmq7?=
 =?us-ascii?Q?MfNAmT+uglTdFhL+3YlCaAkGHp8FdJ5IDv34JFJr5BQ6yN58ZWGAC2J7XY3v?=
 =?us-ascii?Q?urYTlqfFSipWDNilDHgKwkokxIRMybQ1O6nwhG8/ltnC2utWGxDn03o1gqHm?=
 =?us-ascii?Q?p0huANMmcRXvAbnhYuuGXkjtrn/alYckIZNVKySkQ6HBTo+1Pip+G/wbG8Ye?=
 =?us-ascii?Q?SZmgtZlprnpphlJ/N2iwPMZw+g/r6sHu+0iok+DQ6iKtzusinnqZkTaXGMkw?=
 =?us-ascii?Q?FJ5MNGbys4lrHCXvJkCEug1ckPUxQBRxWcBCAFLsDlNqAvmsIGqQlHBK1+gL?=
 =?us-ascii?Q?fiSqmPNExiXJ5Lu0jUysrYjqN+FMjICSi7/QqSbKkfXsENOlreLiKmJ7vRU4?=
 =?us-ascii?Q?yNGsewLxvjFdCwzBmbyrECECsW2NyUYvhT0C/ak5lbtk7HUfl/dwuOuSktUA?=
 =?us-ascii?Q?LT80ScFUExmQP3ZAOheL2bluX1MO3RCKLJLukMVqeS+lPpK7V+AHPg0nQMf0?=
 =?us-ascii?Q?ZYrnrJgKxhjt+qhyrKvUJ8VvTG5IIWWeyOCxHjbzii+3UfOcO30CJLyYQXSI?=
 =?us-ascii?Q?zN11hoMs0EHC7z9gwPX3pSzYtHQlYsylup//oD2L8ktp6BuCayVjs0cLWlPB?=
 =?us-ascii?Q?neexaIG4X55fwlzqyFNqLw1IQBBaOSI6kJfJbkW6sLQy6QHbeuEUmo/7YkQY?=
 =?us-ascii?Q?BVeL885IG4rWIPveA4Zpet5d3gxXGdBy0SPSbdkOIZgxgWirhwyw2kb+jRMm?=
 =?us-ascii?Q?SoBN8UkLhwD3HuipOSu1CdZ7B1z5dNQU0lnTMFdrE0AsnQHYNwaqmZbO4lGY?=
 =?us-ascii?Q?3bGw6EK02QsWYBXbGCjcFMkvXKp3S1wES1jJuhIrEAaLYpU9noD1cwTyr3I5?=
 =?us-ascii?Q?H3jJauKX3f4z+7c3bwmohbO14GYQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEbqJRrzCpAGCPhqVQHCga27cfej6gPmAgBm/xb6f1u1hcaRVrqnYkWynXFx?=
 =?us-ascii?Q?Re/FRWGUlBSfskGHhxMFNlVLEqTmEDvp3zcTjRDg9xP2fqrQ5cyO7R38MACB?=
 =?us-ascii?Q?ZiiJ1Tq5wSVgqvo9EQKy3WzD51FP0sJaDvbJAU8GpGa6owwpv9ctn9XlSgfc?=
 =?us-ascii?Q?Qy/ixz9ziyXi2UHLpbZ5siU6bmeuhHi3TaDSQRa4sO2B37YCOwtS4BXCfqeI?=
 =?us-ascii?Q?lUoYXgi8+wcOB3EANiXefdX5J274kl7W3wtkV02MjFA5ZI7oSXGCvNetdC5J?=
 =?us-ascii?Q?8c+mn14Ec3x6D5Vo6vGEyjnMz2oUFjnq3lMq2mQAp2U202/DaQv4Fwh238aE?=
 =?us-ascii?Q?8Cbhz6JCy8FdE2ys/CJQtobOfeV8my95nK7JTfp3236w/RPuFBbm0ImTSk6T?=
 =?us-ascii?Q?ZaXiQN5pqW5ZWJ+Og4E2W9jLyBkHVXpRbAu2lEO7XrLKkm1x96rCIE7uMhkC?=
 =?us-ascii?Q?poikbv/6PxN/3GFFvfByQl2n5dZivBUrOS63f62TXUiZatS8LaAas72Q7MI9?=
 =?us-ascii?Q?9mBhXGT/65+vUNF0IHvHzMFcZuoD0N6GSNubRniLTDwvGozuKAgN19vuvwPf?=
 =?us-ascii?Q?KXVAlzOkiAr+DtILfVOHzgeKXpCckEDOf7IoIU3SBPEkmj2r7hpQWxdbRx1b?=
 =?us-ascii?Q?umpkLfOXcJQSrnhmki6N68wqfgCx1j8AkpdsjA5fnGwCDuBpN/Wujn6O4uXu?=
 =?us-ascii?Q?MaCBYC0whsA0rhDXsv2JwNzR+Zb6VzV2qjBbIZyzsZOsHkiN5eiTKCNMkzG3?=
 =?us-ascii?Q?MJSbg1kVtzpwCW/EhpkT+e7DdmCmHTKoj9KBPYlwt/dkNzK/DIWLCBC7x/L0?=
 =?us-ascii?Q?HyRmSIhWJ0a7u9PLdTEzN8GhWsDkykhMxBJEa0EUjKrJ/099IlJlTHNPJ1Z/?=
 =?us-ascii?Q?j82etvIh+CQ2AfbJQ92HnZ/6BGGILCKMLQrws0EHMnrfXVmCBg8wlYns6HDM?=
 =?us-ascii?Q?KPLQB9h+fZw4EHaqOlQE/6lhF69nX6v09vR29cJzmRBAIoisunkfOEbdq/TK?=
 =?us-ascii?Q?vWOLdA2HO+Ck30AHQK1PxwJbUSQU6IpyX2tFXdDWHGrwj0qkQ0ijB6xE/yvr?=
 =?us-ascii?Q?IiKTILwQsJdlzwEbM0YijRCwPiNxfGO6mnsop4/YX58pmNblRYOKxEuKlyFv?=
 =?us-ascii?Q?IW/2f6SdTsCHZbp+x3om3EpBLIegt28lb/ovegTq4ytmrI7NuTsxj0cKcHIo?=
 =?us-ascii?Q?CyVZkXuUFESxxNtpvfVkqU3o4uZGy8HQRp7gRE6oFTG9MQyHHh/5lBhTBuhP?=
 =?us-ascii?Q?gXRubpyDvzd3ZgmPBcsGHREv9Jiel1g6XLTv+vkTIfT1hKAnCQxB5f7Gg/3j?=
 =?us-ascii?Q?TnoClb8QhJpriznK8NniZYJlsFQU5so1grjg+AKrE4HshaR/ndmOlT7StUuz?=
 =?us-ascii?Q?voQAhFGlYbla8sm0Jsb96xCJwctNYSPO4S7TktFkY1xg8U+pnvrfG0MzTg75?=
 =?us-ascii?Q?CkR/ayeVpv+UEpVK3kN4wihfln/HzIB6xWLyTuRAzgWzwkHpbMavDkemvbne?=
 =?us-ascii?Q?WGZ37vEFPJ1083SLUnn37G68VFqAwzT46jGqvU4Tqe+lFUJqPwDpb80AxEmY?=
 =?us-ascii?Q?Sjf7YVjsythPUjlVM3GoocSA+esTk2KQMjsEuDtT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7490c23-dafe-4a40-ce24-08dd50a3134f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:49.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs4MQ7FL+VQEYEUmSWsfP0s62w7oItTbYQL1ZPSNXCVbbna4YjuMYNPSlztGZ57l3YLVhwClgJh0CzkJRiVTAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

DAX was the only thing that created pmd_devmap and pud_devmap entries
however it no longer does as DAX pages are now refcounted normally and
pXd_trans_huge() returns true for those. Therefore checking both pXd_devmap
and pXd_trans_huge() is redundant and the former can be removed without
changing behaviour as it will always be false.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c                   |  5 ++---
 include/linux/huge_mm.h    | 10 ++++------
 include/linux/pgtable.h    |  2 +-
 mm/hmm.c                   |  4 ++--
 mm/huge_memory.c           | 31 +++++++++----------------------
 mm/mapping_dirty_helpers.c |  4 ++--
 mm/memory.c                | 15 ++++++---------
 mm/migrate_device.c        |  2 +-
 mm/mprotect.c              |  2 +-
 mm/mremap.c                |  5 ++---
 mm/page_vma_mapped.c       |  5 ++---
 mm/pagewalk.c              |  8 +++-----
 mm/pgtable-generic.c       |  7 +++----
 mm/userfaultfd.c           |  4 ++--
 mm/vmscan.c                |  3 ---
 15 files changed, 40 insertions(+), 67 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index cf96f3d..e26fb6b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1932,7 +1932,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PTE we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		ret = VM_FAULT_NOPAGE;
 		goto unlock_entry;
 	}
@@ -2053,8 +2053,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PMD we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
-			!pmd_devmap(*vmf->pmd)) {
+	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd)) {
 		ret = 0;
 		goto unlock_entry;
 	}
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 22bc207..f427053 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -370,8 +370,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 						false, NULL);		\
 	}  while (0)
@@ -397,8 +396,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
-		if (pud_trans_huge(*____pud)				\
-					|| pud_devmap(*____pud))	\
+		if (pud_trans_huge(*____pud))				\
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
@@ -421,7 +419,7 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
@@ -429,7 +427,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 94d267d..00e4a06 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1635,7 +1635,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_none(pudval) || pud_trans_huge(pudval))
 		return 1;
 	if (unlikely(pud_bad(pudval))) {
 		pud_clear_bad(pud);
diff --git a/mm/hmm.c b/mm/hmm.c
index 9e43008..5037f98 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -348,7 +348,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
@@ -359,7 +359,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
+		if (!pmd_trans_huge(pmd))
 			goto again;
 
 		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a87f7a2..1962b8e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1400,10 +1400,7 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pmd_mkdevmap(entry);
-	else
-		entry = pmd_mkspecial(entry);
+	entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1443,8 +1440,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1537,10 +1532,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pud_mkdevmap(entry);
-	else
-		entry = pud_mkspecial(entry);
+	entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -1571,8 +1563,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1799,7 +1789,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
 	/*
@@ -2653,8 +2643,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2671,7 +2660,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2723,7 +2712,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2756,7 +2745,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	if (unlikely(!pud_trans_huge(*pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
@@ -2829,8 +2818,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
-	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
-				&& !pmd_devmap(*pmd));
+	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3047,8 +3035,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
+	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)) {
 		if (folio && folio != pmd_folio(*pmd))
 			return;
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b..208b428 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -129,7 +129,7 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* Do not split a huge pmd, present or migrated */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
+	if (pmd_trans_huge(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 		walk->action = ACTION_CONTINUE;
 	}
@@ -152,7 +152,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 	pud_t pudval = READ_ONCE(*pud);
 
 	/* Do not split a huge pud */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
+	if (pud_trans_huge(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 		walk->action = ACTION_CONTINUE;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index a527c70..296ef2c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -682,8 +682,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (pmd_devmap(pmd))
-		return NULL;
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
@@ -1226,8 +1224,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1263,7 +1260,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1788,7 +1785,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
@@ -1830,7 +1827,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -6000,7 +5997,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		pud_t orig_pud = *vmf.pud;
 
 		barrier();
-		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
+		if (pud_trans_huge(orig_pud)) {
 
 			/*
 			 * TODO once we support anonymous PUDs: NUMA case and
@@ -6041,7 +6038,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_trans_huge(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6771893..49c3984 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -599,7 +599,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+	if (pmd_trans_huge(*pmdp))
 		goto abort;
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1444878..4aec7b2 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -376,7 +376,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
diff --git a/mm/mremap.c b/mm/mremap.c
index cff7f55..e9cfb0b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -633,7 +633,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
 		if (!new_pud)
 			break;
-		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
+		if (pud_trans_huge(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
 					       old_pud, new_pud, need_rmap_locks);
@@ -655,8 +655,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
-		    pmd_devmap(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
 					   old_pmd, new_pmd, need_rmap_locks))
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 32679be..614150d 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -241,8 +241,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
-		    (pmd_present(pmde) && pmd_devmap(pmde))) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
@@ -257,7 +256,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 0dfb9c2..cca170f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -143,8 +143,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pmd_present(*pmd) &&
-			    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
+			if (pmd_present(*pmd) && pmd_trans_huge(*pmd))
 				continue;
 		}
 
@@ -210,8 +209,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pud_present(*pud) &&
-			    (pud_trans_huge(*pud) || pud_devmap(*pud)))
+			if (pud_present(*pud) && pud_trans_huge(*pud))
 				continue;
 		}
 
@@ -872,7 +870,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * TODO: FW_MIGRATION support for PUD migration entries
 		 * once there are relevant users.
 		 */
-		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
+		if (!pud_present(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pud_leaf(pud)) {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 5a882f2..567e2d0 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -139,8 +139,7 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-			   !pmd_devmap(*pmdp));
+	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
@@ -153,7 +152,7 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pud_t pud;
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	VM_BUG_ON(!pud_trans_huge(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return pud;
@@ -293,7 +292,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
 		goto nomap;
-	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+	if (unlikely(pmd_trans_huge(pmdval)))
 		goto nomap;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cc6dc18..38e88b1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -794,8 +794,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		 * (This includes the case where the PMD used to be THP and
 		 * changed back to none after __pte_alloc().)
 		 */
-		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
-			     pmd_devmap(dst_pmdval))) {
+		if (unlikely(!pmd_present(dst_pmdval) ||
+				pmd_trans_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b7b4b7f..463d045 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3402,9 +3402,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
 		return -1;
 
-	if (WARN_ON_ONCE(pmd_devmap(pmd)))
-		return -1;
-
 	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
 		return -1;
 
-- 
git-series 0.9.1

