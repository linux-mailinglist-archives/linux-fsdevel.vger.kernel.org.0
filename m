Return-Path: <linux-fsdevel+bounces-59418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB4B38907
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899DF7B5A58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3AB2D8767;
	Wed, 27 Aug 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nelJyJKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FD1D63E4;
	Wed, 27 Aug 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317378; cv=fail; b=rNbm65xO31m46F3X34DK1jnjBPi/yGZmdHsW8v26IkFe3TYGNGXxu734igS+2ooba9RrpDfADQCbqo2wvAxCucEyIRA4YbO1Y9IxKAd4uLYhOArY8fEx+nCo1pW/iHLtEZ+CSnZr+UkHZeV1cfJ5H/2WCZY7n1HbzvWUBpqBSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317378; c=relaxed/simple;
	bh=5KDT+AT9ysn7q5/mjjgGlGVEoTnPZJ154dZ+HOkLD9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj4FJW4QfHpX4IOPFMnzslzUDXIhYiuOcNqVdOXddPV+hle+si/nbwUuKD/E3m52Ka3oBwnoCU3N5kTsFli6yQYzl8imm4hKxOClrHnqveVudW6KhHPcN+YeHCq5gVCk1tArJzKo9B3oUIUOkeZ4y54Vbl5c6zLfKunOKrCVZyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nelJyJKs; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHPg9CeJCZFEGf2ux5NXtPcE1TGbWaKcz6z+jExTNQsaGUKF555a1J53T/ABH9ZHQ+gdBiNcj4dUbTe+JCn2iz0WLDnyMJfRxqRC6nZoIEaeJAOWIqdkuAYxDVR6ewbjQrLOsnJ1zxZrbN4vziei+IOq151EVXYmSjY++3Zd2il6jVO5dRb4xz36O+L24Mem7bykUeIMwLLB12TQcG1jrWD/IIP8JOI+R5CG349dP/Wz1Z1uvEc76Ch5b94dM6RL/50ROI54EQQ7cVTUn4msYuBwcUgfrbboDnDtp6xCbcZOlnfRgMbAzYYcAFET2VqDl5XauK1HgITcDdS5Dh0Y9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y75Q8MqndSRaK4P6oNN37wksFaVUcvm+cXegoSGHPWI=;
 b=oHpqjEb2bpx/Y6rB243laenKGpszTVUwsNpOW90W67gh+P8d3+ttPQAaZhiFYXENRu1ZcUPrZnLuR9hZtWkvTnKuTV2WBffSFJcTrrkzjrWIAJAwvsFFDUuOzCpbR8io9vIXLd4j/aZIhWm896X+1p/b/CbLZ7YPxMjNEsFACt2HbMRz3IHCVSYnE40Rk0Zclead6YZeERubBz7+9Gjyxq3+MhiFOH/0DbKVjs30vivw3BQrSONTNP+dVBfgxCSLuMWJbGjcxwY8LbPlEfVE2+hByjI6icSYRp+uFSACtsT5ReiParHHxmIiw9uzEbZi7yQDyVi0o19cPyNxrCVX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y75Q8MqndSRaK4P6oNN37wksFaVUcvm+cXegoSGHPWI=;
 b=nelJyJKsrjv3ul/2fYdQkjcfgyr7qNBSYgYaX9iqxiU0C1IlshpBHHuSxAxhEA1u4u5NR2azbryevOxU3UMP5SOMO//XPQNGqiTVUl34WAan5BOv1JfV8fVWT2VEgQ3DsPsjgOdAz6cbNmKN1Kf67AWSSTKwVj/quMHHFz5gEWs=
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 17:56:11 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::c6) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 17:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 17:56:10 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 12:55:46 -0500
From: Shivank Garg <shivankg@amd.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <seanjc@google.com>,
	<vbabka@suse.cz>
CC: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>, <dsterba@suse.com>,
	<xiang@kernel.org>, <chao@kernel.org>, <jaegeuk@kernel.org>, <clm@fb.com>,
	<josef@toxicpanda.com>, <kent.overstreet@linux.dev>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <lihongbo22@huawei.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<apopple@nvidia.com>, <tabba@google.com>, <ackerleytng@google.com>,
	<shivankg@amd.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<vannapurve@google.com>, <chao.gao@intel.com>, <bharata@amd.com>,
	<nikunj@amd.com>, <michael.day@amd.com>, <shdhiman@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <chao.p.peng@intel.com>,
	<amit@infradead.org>, <ddutile@redhat.com>, <dan.j.williams@intel.com>,
	<ashish.kalra@amd.com>, <gshan@redhat.com>, <jgowans@amazon.com>,
	<pankaj.gupta@amd.com>, <papaluri@amd.com>, <yuzhao@google.com>,
	<suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<linux-bcachefs@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH kvm-next V11 2/7] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
Date: Wed, 27 Aug 2025 17:52:44 +0000
Message-ID: <20250827175247.83322-5-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
References: <20250827175247.83322-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c32d32-2307-4fac-2572-08dde59301b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQtJ/yopJavsi95vnNsK9bwZFc0cgz1KmStctnU4s5B4wSiOvBfGyYGuU8Nz?=
 =?us-ascii?Q?wIsStnZgww4/QHnjNeV6T1+mWHppp21eZsCxaIIeDjQGtGMoCbuFzU+1cUVu?=
 =?us-ascii?Q?thxcurQsojNYnbWMqbvuP0Fix/9vQNtwC8UuCqOonR5alb9KrHz3dObVsqU3?=
 =?us-ascii?Q?eEwDX0VoYPhO6/tpq+R+mVs130C8gRCgrYNvGWNEaJO5y1d39ue0Qd+S1mls?=
 =?us-ascii?Q?Es0eUUihe4JqJaKWvsDyPYMWblvJk5EFePqzppdT7b5lBXDtOXDZagt/yRIG?=
 =?us-ascii?Q?GNIXJNB2NdwVEN90zIVwNHUe9IOeV0LXwfIjwv+Pok0Kq/bsE5AIkSwv0VbL?=
 =?us-ascii?Q?+L1MVx1rjhEvKOjpEiLtcVVMnDK6BJ0/wDny+zATsa0ZeRAGET5yQP8dlslq?=
 =?us-ascii?Q?GRLtUBbttvibenqKUiAciHtGfx7JnTlA/FWrfrMPhgK1kG59vIMON9k7mHLn?=
 =?us-ascii?Q?xQonvr20ZGY6xE/OEcMIBZQUzqimry0ZJnjGj+wqCRsyojZij2lHd2I1tTiD?=
 =?us-ascii?Q?AvhP4kAjOkuTC87wshuAFI+eBNwurNBvRD5F1P1N0F/4pokkmEewnp+flt2I?=
 =?us-ascii?Q?26DTg4Fqj7vB5Xw6ttn2YR/vlk25j0l8BoXxX539/UTtyRADRlMGbnCyBA5K?=
 =?us-ascii?Q?9+fF75RgITRpoSyLYzelVeo5chM20z2hSEo2CtBOowXRbhe7DVGx2jm2fYfU?=
 =?us-ascii?Q?HagwCes7br2TBI8kNQotN1Cu7zKaGCdfx0xIfqtvKYQd1WB88dHZnkbT1i6h?=
 =?us-ascii?Q?BFxzEn22S+gb7niOITOUWIXnktx2j8ACWYKBjg1ItRTJ/CchHjJ/6eS6z50D?=
 =?us-ascii?Q?p/tQC/bYJLEySKo5c/gFk0km10NUK6eWBf/uWrKAK32nla6stVvLAO1cFJsQ?=
 =?us-ascii?Q?571FSPrUH1wPEImn1XktfFh+D3ahG59HGiTjcKUIKS/XDRiFLW7gU3wG4hLZ?=
 =?us-ascii?Q?sWcSff2CZufTDL4W9vnue2+t22b2S+Fj3lBo6LMG8j7AAZhA/YrGspZbe5lo?=
 =?us-ascii?Q?g+5vJ0njm1oZN3uLmCKX8ZJPYssA+0ocdfhjdJiUIpWLpwFysDLIfBEX6tsC?=
 =?us-ascii?Q?3wOZaL2hTh8+7kadqGCui7b6an8JbaIDJ3zBwvEiGHjZO5TEi34J/+TmeJg9?=
 =?us-ascii?Q?Ndc75kXV3i6EeOF3abH7/ydw8eYCV00YvFcJC/Q9komqhUkShVfQxTwdbNcm?=
 =?us-ascii?Q?MWx3GhguR4oWPcOqolZmGeKhUh+7J2zzURpB2k4GO45QB1SoEl3glZNov4gV?=
 =?us-ascii?Q?QE2UlyOvfheV9H2NKWeTgi/V3lt44eI/Gg1Q+xzdRtJXnunh4J9W7f0uNXvq?=
 =?us-ascii?Q?9JS6NdYZfcg/OW32iXMFMZJve0XlgFSHQ1SLoSamzhi7DGDcM8bWb924KlhU?=
 =?us-ascii?Q?IK2TTqP/H/RgR0xWlfXITvhcgK5MTjcYARfforl3GwEHB1qiarPvWb4+k6YE?=
 =?us-ascii?Q?ECV0/Rer7HJS7/3PydTsJ93qqxJ+w5b3vMjF6XXVDqNuIAgcHsbmQnE7E+eG?=
 =?us-ascii?Q?xmehQTDNPD5SmBsksrhAmXfhppV/HekagabT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:56:10.6595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c32d32-2307-4fac-2572-08dde59301b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

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


