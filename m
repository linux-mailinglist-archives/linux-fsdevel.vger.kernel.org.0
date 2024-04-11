Return-Path: <linux-fsdevel+bounces-16641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058858A0521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B09E1C21C5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58170134B0;
	Thu, 11 Apr 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f3NGy0Yf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2121.outbound.protection.outlook.com [40.107.94.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B34134A6;
	Thu, 11 Apr 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797115; cv=fail; b=AMD6y1NLLYkhB6jBQMYM+Tm+L3KiR6P4kEIOhYPHEasW5sIVcIdCtr08pHCxoFyXJxN3ql5h2WpCKa8K2w5MdL535qio22/ce5IjpfpFC43HwgDvQ1xrhToiAihKW6s0evOe1RROuH0FPoxZ6xD2n3rL5ntM55KTdV/FO/F0o84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797115; c=relaxed/simple;
	bh=Uxsvr2CkxHewdHblwPMiZxVHjQuWjXEZUv732zhn03c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzlvqvIUpFLR/05hFw3kmDFjZQ6lc20+IlkehOrjildLjuvTmZ7YZOiTAepm8h+8EMogSF3JX9iG3FIS6vkHfAg7CMwsk6I0gvk+bMn7bPa9xHtDWoeaoRo9D4gpYR+M6FiXRXclnXSD4QUImW78zqhuwasdckersTReigTIzFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f3NGy0Yf; arc=fail smtp.client-ip=40.107.94.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrR4K7/lDaM1OjBJsA5/ScdiVrAIMxYtpy+VFE18RgU/WuCdNT0WBZUanNgqrQ/sNSvrbqA4IMpEHfDeMCyeLxiahJkBSI0nwLLswkSe+3prn88emTjGovMjxUjM7O3zGTEFNqgWdiNDxOlAwEAjq032QahgiPDWpf/VvlNAlRufe1/jDXDGU6dssVrIJ4HUyInufl2uocqLAmCN8j0vSXHuC3zOGFnMFLK5oJ2g/0Ac/oGdyKndAyRBPpbLX7tsVTrGisxmHElOBcgRKrdt48miy6eYvarz3QaQQSwz/nHAjsan2Au6uOHhshL3d6gh+4QVGkpUXS9Bg08HmgVMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFaYEXsPy8hY8SStqkcxHFdUdZZYvHAgQi+Now5q/kU=;
 b=bzl/jOJyaxSRThIkfsblMqVTutiFkpAmT9D2Q+rfq5xAaWTkm9uCLg1S14yVLE9GwVduL0WD41A8YFtFEhfaMupAAuUUgGJ+6Hvw+JCzYzzf7DABJ3288lDx0F6swLWFs5mIef8RdbWEREKF1wneYG/60qSMJY3PcrZD2sbEavQL/2WsISA3jTV3YLFo5wF+oL/nFzNZ8dtLPH/5B64B+gDWL9MfwYAmHofGbWMJxKvNtYS0sUZ0nyFVhoa80Y72MoMXRbRa5n+5BuTs3AosUYvClHvpP3P+SvPhXPLrwdzBJgy9ubcbniS/42jjOqRtoeF+YdVkodrZ3eN9AD+cUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFaYEXsPy8hY8SStqkcxHFdUdZZYvHAgQi+Now5q/kU=;
 b=f3NGy0YfT/j9YJ9XmPjNznDXiPlhnuc4bqco3m4G7p3ysYJtEP+YNeINk582P/4mSBKqljTr0yTFmkHRUwmZjRCP2qURhaDeflKfr2eWGxoOiKnSguyqIhllaYOuRATGu/XefxwiLMFsEhV8WEcjhAtWnbWZyx/E/i7ZqXmvbIWwqJ8nki/2OaPaJdA9BUk9GpqpiSotZCK6xEg7Uf/KZEzRhmh3uwq8UWQU5UtlM4wk4LXpn6HokyB6UvgmOfRjhSmqngHfBPe41j+J2Qf5No21tAfzAczCb+2DxKwWAwJqhYZ7FblF3fmaRNZ0HIUgAKRapCgjDF33QPNrwTRWKw==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 11 Apr 2024 00:58:29 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:58:29 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: david@fromorbit.com,
	dan.j.williams@intel.com,
	jhubbard@nvidia.com,
	rcampbell@nvidia.com,
	willy@infradead.org,
	jgg@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	hch@lst.de,
	david@redhat.com,
	ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jglisse@redhat.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [RFC 10/10] mm: Remove pXX_devmap
Date: Thu, 11 Apr 2024 10:57:31 +1000
Message-ID: <93e3772f172918a3c489d803f7580309c3a42fff.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0047.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB6182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHDBov3G6cP0m54wWMYCrBqnKdTm9HSo+eT6Gdqh/GX//B+RSpTIb85p05cBq9a7AActLj6CP8Ha09dcqY0CKEHJBW7ma7i8++y1KN8bMsii9QUJ6Kcl0GDyu4+1rUoNhJhUjp7ryNCG2sCEzwJvKFBQ3uBEfTOWB+kaW7Ph8fMkjGHDFSBZpa2v2k5zNYN5VkLSKQqhtB36vrKXJVddcFm94tI24HFy88elettc7QRtE6QTJxYR4YlQAcOzoRgfQwJ0u99RYeh42U1KDQTnMNZ/UKFxkbA8gYslEgJ5lWUTQdDNh22hrMNm3IX7pF2jWvIw+izWLHT+Ay2MCnR5mlGrQ0qo/wKn5OhjMti53p5fySQqfshsDsTd0oAsbKx+FMkhC8O6nfu70OybKDiwC9YO39s7FyrUwmbzYNltHGGGsfgGj07cpuxfCpnzfr+/YUsf8y/j7CH1jUu5l+g0dDBXvIniepLkZewwllzNV3KDUd70JQenD1m18/Gpw6h3e30IYu3C3nWc2WsVodYsnZio+Wxqw92zkksrGaN4blfua/MJiGbCZdg5yBE7Wg5WvjjYSUY8cxNd3MbLyBaqqYtapREtQXZ65OAW61CCt+YqzLmpdbeY1K7o88D9JEAaO3EVP6WsE20HC2IHnxZ4S+DiehowwVRHs/LzO1CkAl0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGvqJg1Tk2B9W5lSBGXpdGyOJH1RzcDcc5Gcie4KQ9ybEksG4+WEqlfdq5Ct?=
 =?us-ascii?Q?f1QZHFWomW1Ruy+HlUGVyXw+bAFsmA8hFcznL5APl/wyA7CyRClDuhfd/yaC?=
 =?us-ascii?Q?RzJAsVnZOtRrNSuM7TGjpVEv9H3ef9FB15jNaHaV6+sPoG8XIqrrOlDfmU92?=
 =?us-ascii?Q?ZNw+loZMfQWwm/q2NDWwFY9EhBlX73KVEGHtBASF3xIFyJ33IJrdUHjFYgFl?=
 =?us-ascii?Q?N0CNzXTIR8RRjbfBhpRLQnN+M1rvfGTWbg4BgTAZsfzqofAJjJazhtcwlxR1?=
 =?us-ascii?Q?wqGOGmWwzBQ2A+SI3VVlCahVrWhIRXD9WPpQPTBAuvUpAjbTQYynrOhSlgwS?=
 =?us-ascii?Q?A2Ymk7yCrmpKaowSodMkq+3IHLS1bXUmArT13PllA1iJd/Ble2BA/t16f9mz?=
 =?us-ascii?Q?/OtChzp9Zsye7AW1mNdSCcbAmvBVrrlz1RI+jxvbCTnJvnLzHweogbIPJNKd?=
 =?us-ascii?Q?+LLXehzknF9tF8dH3Rop12Lv5R50DAYbdOymAcOiopVWg+CGKvW0pLjox64D?=
 =?us-ascii?Q?QlfSJnNERwpPhrSriZQW895UB7AJyKkf/M9Ti+IoctxqnOLkiJwAnKIYzHxt?=
 =?us-ascii?Q?66oTph2ZE8rnU9zqKJ4oeKQo4o5eB3BsBu0LApW3XsJntc6T0KzsO0WayGK5?=
 =?us-ascii?Q?z8rNQ2EIWxRZkiQC9isVG1kvgpOOaMh/oXcvPBaJqhIneSt/FQIzj8HKcGHz?=
 =?us-ascii?Q?gRVKFTnS3PdU7C/3Avo0F3mhae4jf7px6T3e0UfntvYBuhGjr3IceCqYuijk?=
 =?us-ascii?Q?7IoO2RkQ86VPtaJxWZc2VpYkPhveqoQxKr/Cs4XLKRKek+hp1LHGAhHsjkuI?=
 =?us-ascii?Q?8CKQpBDIHXnZPy/Xxh+EoNzSbrF8swT9J5EbAgwc5qd8En6k1FJ56H1D71to?=
 =?us-ascii?Q?QYjK/iEDPwXoabtx6WqJpDjzNQr8I/M6GmR7Ntw5/utbXu7YPwlgJdDyAmH6?=
 =?us-ascii?Q?TmPNGGyHdlrFYtrLK/TCwZEfmRHDW5qomGo3JQ1eELjA+J3fj+fVQ5MgsTZr?=
 =?us-ascii?Q?b5TzyuiLJ1Uz81e2vY81E1QB22uo0whTzTSllIRBdvc6DakYAQMRnHL2s70C?=
 =?us-ascii?Q?5olmVRJ+xFBplPDd2jjbVRs87ZxkPjpfEz7PgDw/m6tZb/5A3wZ0Q3fCyxX6?=
 =?us-ascii?Q?Lrlzx5oCJylw/DfXBfllGjqs6JbpbBlZKZo06EB6AwZczjfQZrD/Pcr9EVBG?=
 =?us-ascii?Q?4N0UTx/iRwhR4qQ3pIXJER0QazQ7y4vpSHRB9yUWtljRlOpWZ7dujOKfjsB5?=
 =?us-ascii?Q?hUM3FXtPbsNB73WgkHqO5BKcUi2eCZisfMeKnN1wpjp5F3hCFZTWdstRDCyN?=
 =?us-ascii?Q?OUow4rgO5mqOIbtf2qm6ch+lmaVUXi/dDTk46D0JGrSn35K24HgCSJoa/DhP?=
 =?us-ascii?Q?8oKe/rvaaL6aWw7n7lev/oFLiFkom1ocllJcBdqs+tA7RcyV5/5f32i5iaFV?=
 =?us-ascii?Q?e6K5LLp6RGQ2o27sGS4q/mvV3WYPZE5S7z6OJVI9Q+vdC/T74G3XSa+eWYCQ?=
 =?us-ascii?Q?42PaULI4ycvRLNGDilByuJbaa7bTd8tpWUOQfih61yOOqanxoTczf7jpYYLm?=
 =?us-ascii?Q?qjl01TYovRXN4/+WFUVYrIP9fqYWP1RYQtTsfFjG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11727e0-175d-48ad-7d00-08dc59c28026
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:58:29.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pSWWgjkxyQcTWkyydlktZUF73fnRj+gb6wASRILeiLOfOL4tnCVXS5y5YDy2JbbBx3fdtGnos29r/f5IXrifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

The devmap PTE special bit was used to detect mappings of FS DAX
pages. This tracking was required to ensure the generic mm did not
manipulate the page reference counts as FS DAX implemented it's own
reference counting scheme.

Now that FS DAX pages have their references counted the same way as
normal pages this tracking is no longer needed and can be
removed.

Almost all existing uses of pmd_devmap() are paired with a check of
pmd_trans_huge(). As pmd_trans_huge() now returns true for FS DAX pages
dropping the check in these cases doesn't change anything.

However care needs to be taken because pmd_trans_huge() also checks that
a page is not an FS DAX page. This is dealt with either by checking
!vma_is_dax() or relying on the fact that the page pointer was obtained
from a page list. This is possible because zone device pages cannot
appear in any page list due to sharing page->lru with page->pgmap.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 Documentation/mm/arch_pgtable_helpers.rst    |   6 +-
 arch/arm64/include/asm/pgtable.h             |  24 +---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  42 +------
 arch/powerpc/mm/book3s64/hash_pgtable.c      |   3 +-
 arch/powerpc/mm/book3s64/pgtable.c           |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c     |   5 +-
 arch/powerpc/mm/pgtable.c                    |   2 +-
 arch/x86/include/asm/pgtable.h               |  31 +----
 fs/dax.c                                     |   5 +-
 fs/userfaultfd.c                             |   2 +-
 include/linux/huge_mm.h                      |  10 +-
 include/linux/mm.h                           |   7 +-
 include/linux/pgtable.h                      |  17 +--
 mm/debug_vm_pgtable.c                        |  51 +-------
 mm/gup.c                                     | 151 +--------------------
 mm/hmm.c                                     |   5 +-
 mm/huge_memory.c                             | 100 +-------------
 mm/khugepaged.c                              |   2 +-
 mm/mapping_dirty_helpers.c                   |   4 +-
 mm/memory.c                                  |  25 +---
 mm/migrate_device.c                          |   2 +-
 mm/mprotect.c                                |   2 +-
 mm/mremap.c                                  |   5 +-
 mm/page_vma_mapped.c                         |   5 +-
 mm/pgtable-generic.c                         |   7 +-
 mm/vmscan.c                                  |   5 +-
 26 files changed, 48 insertions(+), 478 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index c82e3ee..ab3238c 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -32,8 +32,6 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_protnone              | Tests a PROT_NONE PTE                            |
 +---------------------------+--------------------------------------------------+
-| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
-+---------------------------+--------------------------------------------------+
 | pte_soft_dirty            | Tests a soft dirty PTE                           |
 +---------------------------+--------------------------------------------------+
 | pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
@@ -108,8 +106,6 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_protnone              | Tests a PROT_NONE PMD                            |
 +---------------------------+--------------------------------------------------+
-| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
-+---------------------------+--------------------------------------------------+
 | pmd_soft_dirty            | Tests a soft dirty PMD                           |
 +---------------------------+--------------------------------------------------+
 | pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
@@ -182,8 +178,6 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_write                 | Tests a writable PUD                             |
 +---------------------------+--------------------------------------------------+
-| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
-+---------------------------+--------------------------------------------------+
 | pud_mkyoung               | Creates a young PUD                              |
 +---------------------------+--------------------------------------------------+
 | pud_mkold                 | Creates an old PUD                               |
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7f7d9b1..506f78f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -107,7 +107,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
-#define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
 #define pte_tagged(pte)		((pte_val(pte) & PTE_ATTRINDX_MASK) == \
 				 PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
@@ -256,11 +255,6 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
-}
-
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
@@ -506,14 +500,6 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
-#endif
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
-}
-
 #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
 #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
 #define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
@@ -847,16 +833,6 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 {
 	return ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
 }
-
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 5c497c8..51351a0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -639,19 +639,6 @@ static inline pte_t pte_mkuser(pte_t pte)
 	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_PRIVILEGED));
 }
 
-/*
- * This is potentially called with a pmd as the argument, in which case it's not
- * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
- * That's because the bit we use for _PAGE_DEVMAP is not reserved for software
- * use in page directory entries (ie. non-ptes).
- */
-static inline int pte_devmap(pte_t pte)
-{
-	u64 mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
-
-	return (pte_raw(pte) & mask) == mask;
-}
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	/* FIXME!! check whether this need to be a conditional */
@@ -1428,35 +1415,6 @@ static inline bool arch_needs_pgtable_deposit(void)
 }
 extern void serialize_against_pte_lookup(struct mm_struct *mm);
 
-
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	if (radix_enabled())
-		return radix__pmd_mkdevmap(pmd);
-	return hash__pmd_mkdevmap(pmd);
-}
-
-static inline pud_t pud_mkdevmap(pud_t pud)
-{
-	if (radix_enabled())
-		return radix__pud_mkdevmap(pud);
-	BUG();
-	return pud;
-}
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return pte_devmap(pud_pte(pud));
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
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
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 8f8a62d..8341957 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -50,7 +50,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(vma->vm_mm, pmdp));
 #endif
 	changed = !pmd_same(*(pmdp), entry);
@@ -70,7 +70,6 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
 	assert_spin_locked(pud_lockptr(vma->vm_mm, pudp));
 #endif
 	changed = !pud_same(*(pudp), entry);
@@ -181,7 +180,7 @@ pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
 	pmd_t pmd;
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-		   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
+		   || !pmd_present(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
@@ -199,8 +198,7 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
 	pud_t pud;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pud_present(*pudp) && !pud_devmap(*pudp)) ||
-		  !pud_present(*pudp));
+	VM_BUG_ON(!pud_present(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, addr, pudp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index c6a4ac7..b50f999 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1362,7 +1362,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!radix__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -1379,7 +1379,7 @@ unsigned long radix__pud_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
+	WARN_ON(!pud_trans_huge(*pudp));
 	assert_spin_locked(pud_lockptr(mm, pudp));
 #endif
 
@@ -1397,7 +1397,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 	/*
 	 * khugepaged calls this for normal pmd
 	 */
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 4d69bfb..d1f98e0 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -467,7 +467,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		return NULL;
 #endif
 
-	if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		if (is_thp)
 			*is_thp = true;
 		ret_pte = (pte_t *)pmdp;
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e02b179..9257da3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -267,7 +267,6 @@ static inline int pmd_large(pmd_t pte)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
@@ -286,29 +285,6 @@ static inline int has_transparent_hugepage(void)
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline int pud_devmap(pud_t pud)
-{
-	return !!(pud_val(pud) & _PAGE_DEVMAP);
-}
-#else
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-#endif
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline pte_t pte_set_flags(pte_t pte, pteval_t set)
@@ -968,13 +944,6 @@ static inline int pte_present(pte_t a)
 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t a)
-{
-	return (pte_flags(a) & _PAGE_DEVMAP) == _PAGE_DEVMAP;
-}
-#endif
-
 #define pte_accessible pte_accessible
 static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
 {
diff --git a/fs/dax.c b/fs/dax.c
index a45793f..b83c668 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1694,7 +1694,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PTE we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		ret = VM_FAULT_NOPAGE;
 		goto unlock_entry;
 	}
@@ -1815,8 +1815,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PMD we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
-			!pmd_devmap(*vmf->pmd)) {
+	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd)) {
 		ret = 0;
 		goto unlock_entry;
 	}
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 56eaae9..33f9448 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -353,7 +353,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
+	if (!pmd_present(_pmd) || vma_is_dax(vmf->vma))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bf49efa..81b5b49 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -156,8 +156,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 						false, NULL);		\
 	}  while (0)
@@ -172,8 +171,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
-		if (pud_trans_huge(*____pud)				\
-					|| pud_devmap(*____pud))	\
+		if (pud_trans_huge(*____pud))				\
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
@@ -196,7 +194,7 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
@@ -204,7 +202,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f10aa62..d299b42 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2620,13 +2620,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 }
 #endif
 
-#ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return 0;
-}
-#endif
-
 extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 			       spinlock_t **ptl);
 static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c..ff7ca9d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1363,21 +1363,6 @@ static inline int pud_write(pud_t pud)
 }
 #endif /* pud_write */
 
-#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return 0;
-}
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
 	!defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 static inline int pud_trans_huge(pud_t pud)
@@ -1392,7 +1377,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_none(pudval) || pud_trans_huge(pudval))
 		return 1;
 	if (unlikely(pud_bad(pudval))) {
 		pud_clear_bad(pud);
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 48e329e..edb9fcb 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -705,53 +705,6 @@ static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
 static void __init pmd_protnone_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static void __init pte_devmap_tests(struct pgtable_debug_args *args)
-{
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
-
-	pr_debug("Validating PTE devmap\n");
-	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
-}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args)
-{
-	pmd_t pmd;
-
-	if (!has_transparent_hugepage())
-		return;
-
-	pr_debug("Validating PMD devmap\n");
-	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
-	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_devmap_tests(struct pgtable_debug_args *args)
-{
-	pud_t pud;
-
-	if (!has_transparent_pud_hugepage())
-		return;
-
-	pr_debug("Validating PUD devmap\n");
-	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
-	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
-}
-#else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-#else  /* CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-#else
-static void __init pte_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
 static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
@@ -1352,10 +1305,6 @@ static int __init debug_vm_pgtable(void)
 	pte_protnone_tests(&args);
 	pmd_protnone_tests(&args);
 
-	pte_devmap_tests(&args);
-	pmd_devmap_tests(&args);
-	pud_devmap_tests(&args);
-
 	pte_soft_dirty_tests(&args);
 	pmd_soft_dirty_tests(&args);
 	pte_swap_soft_dirty_tests(&args);
diff --git a/mm/gup.c b/mm/gup.c
index 6a3141d..8c3c7d3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -600,8 +600,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	page = vm_normal_page(vma, address, pte);
 
 	/*
-	 * We only care about anon pages in can_follow_write_pte() and don't
-	 * have to worry about pte_devmap() because they are never anon.
+	 * We only care about anon pages in can_follow_write_pte().
 	 */
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pte(pte, page, vma, flags)) {
@@ -609,18 +608,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
-		/*
-		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
-		 * case since they are only valid while holding the pgmap
-		 * reference.
-		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
-			page = pte_page(pte);
-		else
-			goto no_page;
-	} else if (unlikely(!page)) {
+	if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
 			page = ERR_PTR(-EFAULT);
@@ -701,13 +689,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags);
-	if (pmd_devmap(pmdval)) {
-		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-	}
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
@@ -742,20 +723,10 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 				    struct follow_page_context *ctx)
 {
 	pud_t *pud;
-	spinlock_t *ptl;
-	struct page *page;
-	struct mm_struct *mm = vma->vm_mm;
 
 	pud = pud_offset(p4dp, address);
 	if (pud_none(*pud))
 		return no_page_table(vma, flags);
-	if (pud_devmap(*pud)) {
-		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-	}
 	if (unlikely(pud_bad(*pud)))
 		return no_page_table(vma, flags);
 
@@ -2554,7 +2525,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			 struct page **pages, int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
+	int ret = 0;
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
@@ -2578,16 +2549,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
@@ -2663,90 +2625,6 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int __gup_device_huge(unsigned long pfn, unsigned long addr,
-			     unsigned long end, unsigned int flags,
-			     struct page **pages, int *nr)
-{
-	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
-
-	do {
-		struct page *page = pfn_to_page(pfn);
-
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
-		SetPageReferenced(page);
-		pages[*nr] = page;
-		if (unlikely(try_grab_page(page, flags))) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-		(*nr)++;
-		pfn++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	put_dev_pagemap(pgmap);
-	return addr == end;
-}
-
-static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-
-static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-#else
-static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif
-
 static int record_subpages(struct page *page, unsigned long addr,
 			   unsigned long end, struct page **pages)
 {
@@ -2852,13 +2730,6 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
-					     pages, nr);
-	}
-
 	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
@@ -2896,13 +2767,6 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
-					     pages, nr);
-	}
-
 	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
@@ -2941,8 +2805,6 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	BUILD_BUG_ON(pgd_devmap(orig));
-
 	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
@@ -2984,8 +2846,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd))) {
 			/* See gup_pte_range() */
 			if (pmd_protnone(pmd))
 				return 0;
@@ -3022,7 +2883,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
-		if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
+		if (unlikely(pud_huge(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
 					  pages, nr))
 				return 0;
diff --git a/mm/hmm.c b/mm/hmm.c
index a665a3c..5ad89f9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -298,7 +298,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	 * fall through and treat it like a normal page.
 	 */
 	if (!vm_normal_page(walk->vma, addr, pte) &&
-	    !pte_devmap(pte) &&
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			pte_unmap(ptep);
@@ -351,7 +350,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
@@ -362,7 +361,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
+		if (!pmd_trans_huge(pmd))
 			goto again;
 
 		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c657886..265506a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1090,46 +1090,6 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	if (flags & FOLL_WRITE && !pmd_write(*pmd))
-		return NULL;
-
-	if (pmd_present(*pmd) && pmd_devmap(*pmd))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
@@ -1245,49 +1205,6 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pud(vma, addr, pud);
 }
 
-struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pud_pfn(*pud);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pud_lockptr(mm, pud));
-
-	if (flags & FOLL_WRITE && !pud_write(*pud))
-		return NULL;
-
-	if (pud_present(*pud) && pud_devmap(*pud))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pud(vma, addr, pud, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 *
-	 * At least one of FOLL_GET | FOLL_PIN must be set, so assert that here:
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-
-	ret = try_grab_page(page, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma)
@@ -1302,7 +1219,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
 	/*
@@ -2013,8 +1930,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2031,7 +1947,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2065,7 +1981,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2083,7 +1999,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	if (unlikely(!pud_trans_huge(*pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
@@ -2150,8 +2066,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
-	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
-				&& !pmd_devmap(*pmd));
+	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -2354,8 +2269,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(freeze && !folio);
 	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
 
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
+	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)) {
 		/*
 		 * It's safe to call pmd_page when folio is set because it's
 		 * guaranteed that pmd is present.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b10db15..7254ad4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -955,8 +955,6 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 		return SCAN_PMD_NULL;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
-	if (WARN_ON_ONCE(pmd_devmap(pmde)))
-		return SCAN_PMD_NULL;
 	if (pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
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
index 418b630..6b0a2d1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -592,16 +592,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			return NULL;
 		if (is_zero_pfn(pfn))
 			return NULL;
-		if (pte_devmap(pte))
-		/*
-		 * NOTE: New users of ZONE_DEVICE will not set pte_devmap()
-		 * and will have refcounts incremented on their struct pages
-		 * when they are inserted into PTEs, thus they are safe to
-		 * return here. Legacy ZONE_DEVICE pages that set pte_devmap()
-		 * do not have refcounts. Example of legacy ZONE_DEVICE is
-		 * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
-		 */
-			return NULL;
 
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
@@ -677,8 +667,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (pmd_devmap(pmd))
-		return NULL;
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
@@ -1150,8 +1138,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1187,7 +1174,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1547,7 +1534,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
@@ -1589,7 +1576,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -5129,7 +5116,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		pud_t orig_pud = *vmf.pud;
 
 		barrier();
-		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
+		if (pud_trans_huge(orig_pud)) {
 
 			/*
 			 * TODO once we support anonymous PUDs: NUMA case and
@@ -5169,7 +5156,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_trans_huge(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 1e1c82f..a3659c0 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -590,7 +590,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+	if (pmd_trans_huge(*pmdp))
 		goto abort;
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb4..a83e9f4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -387,7 +387,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 		}
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
diff --git a/mm/mremap.c b/mm/mremap.c
index 382e81c..78ed214 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -527,7 +527,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
 		if (!new_pud)
 			break;
-		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
+		if (pud_trans_huge(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
 					       old_pud, new_pud, need_rmap_locks);
@@ -549,8 +549,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
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
index e0b368e..c519dbf 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -235,8 +235,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
-		    (pmd_present(pmde) && pmd_devmap(pmde))) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
@@ -251,7 +250,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4fcd959..ab24a0c 100644
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
@@ -291,7 +290,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
 		goto nomap;
-	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+	if (unlikely(pmd_trans_huge(pmdval)))
 		goto nomap;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394..09064c2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3940,7 +3940,7 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (!pte_present(pte) || is_zero_pfn(pfn))
 		return -1;
 
-	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+	if (WARN_ON_ONCE(pte_special(pte)))
 		return -1;
 
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
@@ -3959,9 +3959,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
 		return -1;
 
-	if (WARN_ON_ONCE(pmd_devmap(pmd)))
-		return -1;
-
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
 		return -1;
 
-- 
git-series 0.9.1

