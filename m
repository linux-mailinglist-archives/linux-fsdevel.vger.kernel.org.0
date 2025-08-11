Return-Path: <linux-fsdevel+bounces-57274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C36B202A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140F316BFBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB515ADB4;
	Mon, 11 Aug 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ep14UeA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB619D8A7;
	Mon, 11 Aug 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903287; cv=fail; b=fZqxpk0lYNWeEVvDJixkrwu2YwBHI9tmPMeaSpnGGyYQKa5yWSNlq7rIGwFhoCatbKrDv7c9pf7j5DpIPNsQ6RPFusTAUPzr3tugw6X0mjQcqyEJifLjeIpQBppgb9Gapj6tIPY13LOxY/hDZ08YvPabfot6NzMnJSMVbP/tWDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903287; c=relaxed/simple;
	bh=5KDT+AT9ysn7q5/mjjgGlGVEoTnPZJ154dZ+HOkLD9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nf1Rq5Pd26v4Gn3y/lLmOEZWAaoGHghZn51duQESPq4GM8gTeD2TDfLI9C3fqBEfiTijbLmKV2rIvnr2dk6To7pGjUCwsO/wEhnic5phqhUFgE30FrSVvdwxtVLL96TSnWLO6Snk+L+p/MTK4cxOrPxCmpseZ9TJmlZMIzlhtXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ep14UeA6; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZSY9yNDl3cDBG1jkspxY8EBYXSi+s6veVHXVFIGKvTYAcGUnyIqPG0pxUKOA8XaUpT/F63tSVasBkHdqQ4Xws1buNToq/J1LP/MpXWqk92EOknFpiVieEZubtMHP5m6QQiWKXGyFG7c566+H9sktiH804HJ2U7jFQT5LQWB59d2/5zllCCbJlZRO4ePfpMYUcCSjZjEcP1OVyoEB4sm2KOACc7YKsUOUyVCkedd9pX6K9ay2V6L5kXiZp2lFEUZ1BqT9AIcBO9ZGTVX2HQSvGGX9nhR8MrfFACPACUcB6D7Sls3U3yyN9LZa+ceJd5c+E0tSUn+RNoElGljeCpntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y75Q8MqndSRaK4P6oNN37wksFaVUcvm+cXegoSGHPWI=;
 b=vaVJFe5b15cEDHRXm86p/o6QIOi0avDHUG4Xa+yiYX0qcPpICcsuSOF9ZwI4h4rGaL3RRYJ11heOFgs8l/dY9bCNtf23CEaBpRsK6DhQ9YItG/BnZQ/K0vUZhOUOGLwhgLHCakijI4gIFllIqbvA0IhiEMao6H6rAVvolt0ssK/aNesd8BRuIdrC8wCvbmYaXS+O/dvAlGGrCsqBdJXLrg7mepwQIqq0RhQQAlet8kDe/qPnIFFQXkg49U+0267pmL5UWFtze6s4uumP9VUCqf/gpi6wMu2Wt97xC8aTKuJlPkwYa/U+iRYQN4MTeeNoefh4rImSR4hAQjPwCFHlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y75Q8MqndSRaK4P6oNN37wksFaVUcvm+cXegoSGHPWI=;
 b=ep14UeA6q/0BeNEQPP4VCSN35q4wjjhLkoKYPa3EU7N4dmDHSuHep+5/ZiohVEtVNw7PO0UgB7ymYEZNis5mbECnxKVIPnrowHx9NYphPwuS4J3Z19exkVpDdjCXL65Lk7lg2MWw3rteXsof+tKvmTj8VvS7XggnCchHUifauq4=
Received: from BN9PR03CA0390.namprd03.prod.outlook.com (2603:10b6:408:f7::35)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:08:00 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com (2603:10b6:408:f7::4)
 by BN9PR03CA0390.outlook.office365.com (2603:10b6:408:f7::35) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21
 via Frontend Transport; Mon, 11 Aug 2025 09:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:08:00 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:07:43 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<shdhiman@amd.com>, <yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <kalyazin@amazon.com>, <peterx@redhat.com>,
	<shivankg@amd.com>, <jack@suse.cz>, <rppt@kernel.org>, <hch@infradead.org>,
	<cgzones@googlemail.com>, <ira.weiny@intel.com>, <rientjes@google.com>,
	<roypat@amazon.co.uk>, <ziy@nvidia.com>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <kent.overstreet@linux.dev>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<chao.p.peng@intel.com>, <amit@infradead.org>, <ddutile@redhat.com>,
	<dan.j.williams@intel.com>, <ashish.kalra@amd.com>, <gshan@redhat.com>,
	<jgowans@amazon.com>, <pankaj.gupta@amd.com>, <papaluri@amd.com>,
	<yuzhao@google.com>, <suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<aneeshkumar.kizhakeveetil@arm.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH RFC V10 2/7] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
Date: Mon, 11 Aug 2025 09:06:02 +0000
Message-ID: <20250811090605.16057-6-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
References: <20250811090605.16057-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: fbadbf0d-9b32-4bd8-c9d3-08ddd8b69242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wa8ZCiB1+mgDXCM8/jnEVtGCKOahyeKBnWNCiaJlUgtQlNwl9qeviZdv1qm+?=
 =?us-ascii?Q?nAgknU1/LHziYZBL6W4P3If53PZ3gqgNa3QR2d9GTfpf2gk4IErE5xWZlfST?=
 =?us-ascii?Q?JtySlf8O63G1miXgWT+JDwhmn+JMiJm5NN2b+TloZQr3yEzcp2ZPoYNiDQ1k?=
 =?us-ascii?Q?qC/P7+87twemV5q9dsaxaozCvgBiuJI9NHOJk+riqLdWbvjwXWtp8rL/2ATa?=
 =?us-ascii?Q?3YOM3Pf0XTJliFaIPnbjQhvCos8SrqOttoKCZbexUxPI90ocSmCNnZNBFA53?=
 =?us-ascii?Q?3TPXbxjSl3LrD4G4J/TRqwIzSTFp51ZamlTjHNTpMseHmTF7t5FnEQ/caisL?=
 =?us-ascii?Q?HrZYbnWvyEgvwXjzXbBLDHx93JOki03InFBk9FgzhK/yzD5GgeQJ1zM6o396?=
 =?us-ascii?Q?HKJQSgB1zTbyuOJPn8GH9LoCWhbUUIeitDgqeMEOZRMnA9/7gGXKcJEp4aat?=
 =?us-ascii?Q?LaSaVGZXl0GKvEenSSEdtGAehCLNfRarnwxkS9ln4sqO7dbt7RYGC+5bPJG2?=
 =?us-ascii?Q?pHc5mgS7beuiBVZZ+LH2Py/Q1bGBFj4/XPyc6gdsNMW4VH1wMbM3NZQl8Gms?=
 =?us-ascii?Q?bwgKOugr6LN0Npc2x8mCfop6+EjFs/To9h6Aj6hcaYOvLJeK/NbO6O72b98t?=
 =?us-ascii?Q?ITEyWl4kSiQYQmDvrF3mTeDu6KFgwtlGBHkgx4HCp2+hMJuZ/9V2Vynit106?=
 =?us-ascii?Q?HTi9UPyGywFh+Zp18t5BoTNDO2qoZ0RR84KgXnX9TnVqfkGTuIS48R3zXVor?=
 =?us-ascii?Q?pjlTrmhtr+8Qc1WuUOl0xkb1fXOLU7bnSsWG2D87NK98RJ2MthnD0FZQKjld?=
 =?us-ascii?Q?LQ7BWExKfUBBHzlwEWWzrNzllh4alEUX6KhHE8MrC5k3jD5YoDpldc1+ie2l?=
 =?us-ascii?Q?iH1ziwdLJ7wffS811hn/nE1rU771zI2wYjQgbre+v6M/31j0AKtgvpt8epoT?=
 =?us-ascii?Q?jxuSyfcolQuYpP3Pdh4V26uf8L50Tv5iCqBJPOENKSYO+jIxt6dHUskM9ZaG?=
 =?us-ascii?Q?SEMb8WI/mDRCKvL4s1ncyibRoni85snlFIea27y59mh6XNlbLvnQcnTIt6Xl?=
 =?us-ascii?Q?B0LLDEH38z7sCgkoFBgaVc+47kYiCTo0GI/KvM1XF46024Kel9OxoMPxHAjy?=
 =?us-ascii?Q?HeGbtqXH3ctsErWB5lIIYS1yUdBz8ZUBq4nBtthJMxd2lFdjvC2X75VZlBTX?=
 =?us-ascii?Q?Qc3owO0LYnUz3RwsasY06Os0XQBgS0NLj+1C0KfN99lEBwqwAfkEkbzhJHTW?=
 =?us-ascii?Q?mA+/B6UMUTVmZbw/pluqwXXBrV7RkSHM2m+q+fLknTkCje55WdcH1gl1+L7V?=
 =?us-ascii?Q?/upfw0IeuDwlCYNAOPunAEDMIfbmVYItAUjil9Cl19KS/+11ZKUeSQLZZa0q?=
 =?us-ascii?Q?xv778BZJBJPpo8Yo990gtLuUi4DSNc36O+F8ju4ONtahrT0KcUYQ+xY1BM54?=
 =?us-ascii?Q?grFwq8CWfzPeyKFY7iFdT9R3d5Gz3lQ1zwSbuzqDdrPSeyhYEh9gk204M4CV?=
 =?us-ascii?Q?a816SP0ta/p7GtoA0rwu1opVHBeCn+G7LTME?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:08:00.5553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbadbf0d-9b32-4bd8-c9d3-08ddd8b69242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Extend __filemap_get_folio() to support NUMA memory policies by
renaming the implementation to __filemap_get_folio_mpol() and adding
a mempolicy parameter. The original function becomes a static inline
wrapper that passes NULL for the mempolicy.

This infrastructure will enable future support for NUMA-aware page cache
allocations in guest_memfd memory backend KVM guests.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/pagemap.h | 10 ++++++++--
 mm/filemap.c            | 11 ++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ce617a35dc35..94d65ced0a1d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -747,11 +747,17 @@ static inline fgf_t fgf_set_order(size_t size)
 }
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgf_flags, gfp_t gfp, struct mempolicy *policy);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
+static inline struct folio *__filemap_get_folio(struct address_space *mapping,
+		pgoff_t index, fgf_t fgf_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index, fgf_flags, gfp, NULL);
+}
+
 /**
  * write_begin_get_folio - Get folio for write_begin with flags.
  * @iocb: The kiocb passed from write_begin (may be NULL).
diff --git a/mm/filemap.c b/mm/filemap.c
index 495f7f5c3d2e..03f223be575c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1897,11 +1897,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * __filemap_get_folio_mpol - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @policy: NUMA memory allocation policy to follow.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
@@ -1912,8 +1913,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *policy)
 {
 	struct folio *folio;
 
@@ -1983,7 +1984,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
+			folio = filemap_alloc_folio(alloc_gfp, order, policy);
 			if (!folio)
 				continue;
 
@@ -2030,7 +2031,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_clear_dropbehind(folio);
 	return folio;
 }
-EXPORT_SYMBOL(__filemap_get_folio);
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
-- 
2.43.0


