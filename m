Return-Path: <linux-fsdevel+bounces-42041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BFA3B0B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7D11890DBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0F1C5D45;
	Wed, 19 Feb 2025 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7wf6QWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EF1B85D7;
	Wed, 19 Feb 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941566; cv=fail; b=QOjDNT9u39a1XYtbx5YdZl5yiaBOZXgn75PoQ604AHBp0Q9pheoqXY0F3GIO7jdvsz0JLymtTqUkbPQ+zZUubTKD12w/izL2hJrFJXtyaIzpmWDK0sait5a0ebRLP+tW3esFKmiNJ6sspfI7qMNsk+r4loUER77uIn/hBxvESQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941566; c=relaxed/simple;
	bh=7NiUpfir3zotCIBT/cA4oej9GsPgt0J+dHLc8YSu4E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VoFBskqEb8bK9SwnjwqOECADFtAnCo24dbySGI86yphEr8m9aKeL+G9RjMnhrvJI/CzEpnqmsfXT0Ujm5QfJOQScpbMHG+Z1Q06ujWUlPRc3QhOi5p13vCTOBD3tXC1H53cs+XcU1R+Q5+8L1BeETp2gd7LHST2yptXv8Thj4qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7wf6QWb; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T173C74JzMSnLgPfxGd0Qm6AwJsgAMzC7JV9SlcuFYD32wl782My0CQeSCKUQTZvayiTjSuhkeR6usrgSV4bUZCkzTe3ny7KmY5K0LOA/J6mCwN4WnOicAij681b1pnGyh26UQFDB47U/TinDSEOqY4oHG+SDOECKSSxBk1tSfP8KYLIhEvR0fzk/qbWCwd/qvuTE9yM9MOFhq+/iwDuZOblYZqyZ47ii20GY0nUbkZmB4Lg0Smz373yijKNs2Efk53I/h2fgAJZCK/A81H0fSQEIXrYp5gso06dQrvlD3SZpwJDzDnuaEfsEKEqKQZ5lJjlWG4WJ8cys8VbyhmVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QgSQSwIHsLXFNKIPYPmsT4EsJTUoBJcCilF9cqnw9o=;
 b=uYqCtbpSZbIB8t0NFH1z7LemK2D/W7t5zZF0jj7bijN66euIjWomYPmb1y0FUQzQAwNgoc16B8vi42wSmIg0qwH5ImHGyXyuwRzXuRSzibSvy3fxPOyNHv00EHN0fRHdyfZM+RN183a6WCiA6OfOqahwTQf9dsVGEOzyvzMwyjGgpF4qjnm6PG9NF5Yz2TBtk4SOCNTirkQggP0SrxxoMTYiuGrHZT0cFZbQqtXlQHPLJt7e3Qnl1w4iRBGsX7G4Whfb1ixstgiDOWsnraM4PmCrhmlCs624QYjG8GQaT4mVKncR4G/V/Cw+xyLrjYsn4947CvkCclIaxDONT+B4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QgSQSwIHsLXFNKIPYPmsT4EsJTUoBJcCilF9cqnw9o=;
 b=l7wf6QWbbguOvpS/L4Ij/fAd8kk/RQkqsP9JZNBaoMqL7/OACTHTD8YHYdcDkNBe6Lf33pu0wRc8fkYTRCTjrVFkfzMaGRqbxfZc9J1P35lEn8ZPMEPbxtxZYEYg3bHmONSLfQsNv3Nh3tyUbGBQGEZPL1nQuSQqumJzfaEqgmFRadd66d0uj389oa7ybSk8dn9KlKLBMFEmO230sFRKkTtvbnanqN/uvckbx6qg2yoPVQSnIpKzsYn56E1S2hsnkqcT5yWIoZVD4YTAHR5sYzMxeQ9X6wJo3xgRUQKrqGpAczhInMmpxaGiEKmt+vapMYUkpHVD+JEUtCfBvO0a9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:06:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:06:00 +0000
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
Subject: [PATCH RFC v2 09/12] powerpc: Remove checks for devmap pages and PMDs/PUDs
Date: Wed, 19 Feb 2025 16:04:53 +1100
Message-ID: <62587f381d0e718e9f456f375885d93c80ef1110.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0012.ausprd01.prod.outlook.com
 (2603:10c6:1:14::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: fb64d1ec-aee1-4e70-84d6-08dd50a319ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TTyHn75Ts4fFRA9e7fJBtgbTSyZGWND5c7NSsX+WwZOXhU0t6fvHvvlZPC1/?=
 =?us-ascii?Q?wh0OSjBd8FY1a4BzXh/Rkbaa1QUybzXd7XtXurGeWJbBFU5pbqtlTQxz01yY?=
 =?us-ascii?Q?h2XfvXqtWwQohTCfCMvBMt4kTv6wkPvNax4UQhyE6p3i5D/1ynlPHnGzjE7I?=
 =?us-ascii?Q?YIczYjdRFXAYiOyskUf8imEwofNDTINdG2Cbo9uFcbRvZlsrBj/0TsKoQfrf?=
 =?us-ascii?Q?5En1UTCnTv9LDj+Ckwycg2MNo+tsOViFEYlMavuxe4F31gAqqNxoOOZGFmsl?=
 =?us-ascii?Q?tcyvz8kzfqo9Gpkezq1jcJY3x/ymKYyI3470EfWxK3MihvDjwhCfY8kwb5S7?=
 =?us-ascii?Q?AIs2RIIPgkiLW0/AxjV64+xuVJ36jFj44lMFI2bPQkKMIcNMG0b/C40jm55y?=
 =?us-ascii?Q?1C0mzcRol8Ku9SsajEgR0Kms+cOEUOscvTjUBbIeX45U3qpBwDDr4lRUXnnm?=
 =?us-ascii?Q?zZlAGP6GaPoD/mEtx+fHr/ePNcFrbHZjw1mJhj9hSb4J6IwSYMauEcPbVJyn?=
 =?us-ascii?Q?NRQLZSiEpZTZVpat6toLWDTf0Xbv1Na9v52Q+oBN1hakoFaWq/HRgi8uQPrX?=
 =?us-ascii?Q?l0j0XzTBub3yg/3bqAUK8JWVJhPWZ4EgDWTX2m3rL1tJrz7vdDzLGZgcEEiT?=
 =?us-ascii?Q?/FEKscLYEWxnSkZ6MhFWx9zjy0DeU196ogu4xmvbOquGP2bqhRf65F+uLoDV?=
 =?us-ascii?Q?W0Kk6KWowcRtPMzBoHZt/Oy0bltE5gxLqZLvymrqhxgqg5oCR8gV1MXXJ/2x?=
 =?us-ascii?Q?8CntBM4IPqUNxdMbbe/34B5kW2BdDnKqfo9Fqpmv/ndvLeMD0pJvtnji1mhu?=
 =?us-ascii?Q?0QKqdxeYeFVMJ72BHzqawQ4XXIhGHz+iHpGwuxsTXnxrVStbc6PnEiM3tu2h?=
 =?us-ascii?Q?kyKyUT0wSxevxHfnQszmm9PTFj3VpdHBRHou/wKTHTrO5YC6RdFZNARWICJs?=
 =?us-ascii?Q?MS9gI4UusuNUeWOaQGgHlNrAHvrJ4HkYBYeXAJBSG96J7Z9+0818z7zMN0x3?=
 =?us-ascii?Q?fOg/lYh+HLvPmPkIMtUBTxYDu1TCQ5/pthmFJgD22DZO3oeqvtz0M6qqKBU8?=
 =?us-ascii?Q?5cRNu6bLuKLs/tELyozZv21D3U2Jqdsh5DWTvTQZRuv8lUKqY8un9G6ljscs?=
 =?us-ascii?Q?jdA+nbPZ0dSpPa08WR2OjoTteT9g3MinhhDewtxGrm+YGiVgyYUgOLSkpzno?=
 =?us-ascii?Q?0nScjKa4I08m5lkIuDnNHhv6a9b6LD4zpaEQ8K9IPOLmzZcfzh8Zlp+0xa3F?=
 =?us-ascii?Q?g8G0uR7p/4cV8UEcsKWhg3ucTmfq/UorCpmRsWhJDOtgy6weHYJXxLQ23aIy?=
 =?us-ascii?Q?Ylp2qn4i01Qr6os0HvgCKG8y1qoLOThv1pkfYu8Dg3uId6RfYnsmtOQijEVC?=
 =?us-ascii?Q?ZacsuQKDgaUhXxtLNDQ/NLjbfVRO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGD2NJE67FdJjDn9DVZ6tPncK8rOYBAR2MI8iamaomVl9nuif8cR7+XeVRcP?=
 =?us-ascii?Q?rhXYmk3adjW/BVP/EqInYCK09uV3JflS8ckyEYsr8LbY5e4VK75VSw0U+uOk?=
 =?us-ascii?Q?l9AtTNbd93JMUi4t8K30ZhJ/KgzIwyMLVDyY2EOWQjAj/hIDBiu8LVITYIyW?=
 =?us-ascii?Q?i8Jt5e1QTf6UTpzFpXFiBl4EJxS0d38fkMNv4N5qqsA3UYiHfB5yzhzG19/O?=
 =?us-ascii?Q?/qYDd9j1ycddtRnkKIFplnuaAiMf4pn2thyGj12bDb/9Md5GeCuBH+F3c4Vn?=
 =?us-ascii?Q?pJDfI7r9Z/qHRPKWHkVQ6sS2K/kuCw7BdSayFHJn7skFssZdBSoGm1Q46fA0?=
 =?us-ascii?Q?GboIugnk/SM2kYBLYxYgUhu0wUefHtftnpdJ8t7XxlZOfNbMfxOLvC8xz5sp?=
 =?us-ascii?Q?vO79MtnUlmu+oQD61DuS48fd7Hp4q03VLrPCLiNqpr4s1pyv6Q/eJSnyDPj5?=
 =?us-ascii?Q?Cxwi+6sVK1pB/FkAfyGOtMjo2h2ZCuJRudQm7LJhPfksjSTs/Siw648desA4?=
 =?us-ascii?Q?X9H4K4JZ/TyoLcuvZP66q9BD3yJsDSwT9gdxkFO+KLlETRF4gsb+TtnbF24D?=
 =?us-ascii?Q?ji0pMTKqEdCthoRzM2jamBKamNrDrPP3D8fWyV9fwKZylb/coDw7qdPZpGqz?=
 =?us-ascii?Q?OYWK6uwn6gYjUtT3dd2o2My4rNs6g6eW01jTpTxbAGrgluAvIPmUkWOWG+GJ?=
 =?us-ascii?Q?DBgvr42C7MrKAY2D8CV723lv/2YJno1gKOOOhZVkljny63cLZPIj0ofmx3oo?=
 =?us-ascii?Q?/311t6uX4u0BabtxbvFR3Pw6BfGOJTGMZQMytS8VXxszf+KedWKJAATO24wn?=
 =?us-ascii?Q?VuLIvmKQ/itiKsUxB9A1ccIla+MpPiWo3OzVLbKCgIrvztxYvCJineFHf3Iu?=
 =?us-ascii?Q?hxyhGOZ1aCMYAaFp2GzknEin90M/rp/rD+x2Yvi4qu4bYS8rvQb9EKBWDk/f?=
 =?us-ascii?Q?Rh0t+ZPQg4SM8MR3owPhVDfSMJdsUKDplK5d6/waGLrPTiv2OxIMQSmABCj/?=
 =?us-ascii?Q?mn3t/OXtFrmyCkVh4Dkox2X6tt7/mkkzVtWFq2mFPEviZTZAD88fNyIqqfdX?=
 =?us-ascii?Q?1h0qOtHA0GxMNXQKLJ8bEcF+ih8CFoMvAHaAWvyqlv1S7qvpZ0rj/66S1b62?=
 =?us-ascii?Q?5sDxUn2O+wUXEHa1FwzUQbS3VWrZ504fCKJK3odPUo3fR0B/b3z2pQ0oU2/d?=
 =?us-ascii?Q?5K2QiSGj5KtNGM5+ppHGPXs7VZhzI0fmRI4/rwlX6gVVMCziBRPxTLAmKnj7?=
 =?us-ascii?Q?Kc37dsO7YbeisoT5EsKx7Lj4rCBwf2KXNhCXSl4IX2lT3lsg9UGOvQq4bI5w?=
 =?us-ascii?Q?8CBbuWsP+4pnHYpQJG0plGaA0zemSa8kepvC++uFYpaOBQfOBSrpeYcWS3v6?=
 =?us-ascii?Q?+1ltsP3WBL++mxXlZPjDii+G/d3TekjYPt0IpBDPYY8iwiUFSJEmFKXNTISF?=
 =?us-ascii?Q?1M8LXrZSdnvl2eYtHHBUfKnDrHD46x2DoRJLyvpDSD6pZ/eBjpyfsGnoiNky?=
 =?us-ascii?Q?MTgRjngNdqYUpEToeLoxWEXaq9V7SGrGEAeRtL5DqpWVx6s/Gz0iFr7uuSxD?=
 =?us-ascii?Q?k7GY4mTWd+a8F3wr1uS72xRKdnYyzmR3OHFTjw0x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb64d1ec-aee1-4e70-84d6-08dd50a319ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:59.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUWCgjeyZIbqZTSxSRuScTS/lpBY+L0XkkA/xJrRpt8iqaL1ip9f3U9yU2sJMIvJavm2ue+cCX5E0dLs6D2nIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

PFN_DEV no longer exists. This means no devmap PMDs or PUDs will be
created, so checking for them is redundant. Instead mappings of pages that
would have previously returned true for pXd_devmap() will return true for
pXd_trans_huge()

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 arch/powerpc/mm/book3s64/hash_hugepage.c |  2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c  |  3 +--
 arch/powerpc/mm/book3s64/hugetlbpage.c   |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c       | 10 ++++------
 arch/powerpc/mm/book3s64/radix_pgtable.c |  5 ++---
 arch/powerpc/mm/pgtable.c                |  2 +-
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_hugepage.c b/arch/powerpc/mm/book3s64/hash_hugepage.c
index 15d6f3e..cdfd4fe 100644
--- a/arch/powerpc/mm/book3s64/hash_hugepage.c
+++ b/arch/powerpc/mm/book3s64/hash_hugepage.c
@@ -54,7 +54,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	/*
 	 * Make sure this is thp or devmap entry
 	 */
-	if (!(old_pmd & (H_PAGE_THP_HUGE | _PAGE_DEVMAP)))
+	if (!(old_pmd & H_PAGE_THP_HUGE))
 		return 0;
 
 	rflags = htab_convert_pte_flags(new_pmd, flags);
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 988948d..82d3117 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -195,7 +195,7 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!hash__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!hash__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -227,7 +227,6 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 
 	pmd = *pmdp;
 	pmd_clear(pmdp);
diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
index 83c3361..2bcbbf9 100644
--- a/arch/powerpc/mm/book3s64/hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
@@ -74,7 +74,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
 	/* Make sure this is a hugetlb entry */
-	if (old_pte & (H_PAGE_THP_HUGE | _PAGE_DEVMAP))
+	if (old_pte & H_PAGE_THP_HUGE)
 		return 0;
 
 	rflags = htab_convert_pte_flags(new_pte, flags);
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index ce64abe..49293d0 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -63,7 +63,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(vma->vm_mm, pmdp));
 #endif
 	changed = !pmd_same(*(pmdp), entry);
@@ -83,7 +83,6 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
 	assert_spin_locked(pud_lockptr(vma->vm_mm, pudp));
 #endif
 	changed = !pud_same(*(pudp), entry);
@@ -205,8 +204,8 @@ pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
 {
 	pmd_t pmd;
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-		   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
+	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp)) ||
+		   !pmd_present(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
@@ -224,8 +223,7 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
 	pud_t pud;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pud_present(*pudp) && !pud_devmap(*pudp)) ||
-		  !pud_present(*pudp));
+	VM_BUG_ON(!pud_present(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, addr, pudp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 311e211..f0b606d 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1412,7 +1412,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!radix__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -1429,7 +1429,7 @@ unsigned long radix__pud_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
+	WARN_ON(!pud_trans_huge(*pudp));
 	assert_spin_locked(pud_lockptr(mm, pudp));
 #endif
 
@@ -1447,7 +1447,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 	/*
 	 * khugepaged calls this for normal pmd
 	 */
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 61df5ae..dfaa9fd 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -509,7 +509,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		return NULL;
 #endif
 
-	if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		if (is_thp)
 			*is_thp = true;
 		ret_pte = (pte_t *)pmdp;
-- 
git-series 0.9.1

