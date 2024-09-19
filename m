Return-Path: <linux-fsdevel+bounces-29701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C4297C784
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA41B1F21052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DE1A0731;
	Thu, 19 Sep 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lANo6acv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8519E7E8;
	Thu, 19 Sep 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739123; cv=fail; b=sU7XYZZ9aHxQJRQR4rr2MhknoVDaZwWdq1QzEUzsctYqTQNBDjeHvdhuDtSO143M2eHnjdIANT0aW9LY7zI3WZfOmF8p638oBYknx7AYK8KyeP9u5U1sXCpU+9iM1RGJ93kULMBvRO58b8O2WVHbJ1GATol1wgycS/fPt5SI3OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739123; c=relaxed/simple;
	bh=+UfxFrGXVTVyE8HLUd/UN+Bn0M6fPmxlIpYY0+yPiHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLPb1QX/0Csfl+pFL6jcz8igmW3fRQn+6P4ahAPzlwhlI+s9R0IqPpxA7bPt/qj1ugdWgDnFwxcnbD1Lr4uEKOOeXM+DfPEptegcWZeLHzMsYOPtB9gP/KLRm5P3B8+l1SC9qhjFkyalciZuwmnKvOz1t7fCH2jd7ThMD/el6k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lANo6acv; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRqUZ6BrEe7UY/a1P8pmGcdvkoxt1WvbAyl3/t974e2bQtwVgS3ZuslsjPsb3Wh9BVBciwqzEcfsCViRjRUzQCE1HHumiqmpU6zg/GhduRKV5gsaNn2pcNXlhTKSPI2D4nzHjvRsywQ9oYMmGlOOAieeWZGz+Teu1/tDdH1gCk9do/zgg8n5JRcFdw8CrBlXWqrl/yCyICSCzo4/17RSMrrgdC5skcLhQVs/xrU2ZFCRPUQaVl5o1aU+H0R24ng0hQo5qdpJ6eKDMTQbDJUsp06ehDakb3DYMFtgP/gn+IVVoL5HRYPnjwMGOQZxGe+qUGTz+rHgbUrCQWEDEKJ7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SNmEP9ffiNaTSzFYP+hIwyVz5gMf9kYO9erAqnd/kk=;
 b=dmitq/5JsDFYxtcyAbtQNBUxLBWC/t6zGV3CQieTAMg4sk4n4w1p6DyTk/nlx/bXQhcf/SIMnOAhkPsP8X5okvk0T/Yn0vLo4zeAQDOnetmH5D1PWt9bNEXMbpPxA0ZI9G/YZkuTVFNVjM1SnnA8omZkSrRHk4dNCxbIOROK1ePNHlIvAI6tz6yFbqqZfavci09A/Q8dk6j/P4EJOPODkWyrswYZbyq3CS6GHN6NZLMmvstq4mFKAVlWrQpcYaGs52SxZ/IZD8oOXssAIaqPNmrLsKa1zCbpZwamo0v4Pj9PpN68WQjhkAng5tYxQ9J+aat6CElKlnBqzDbzyeG06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SNmEP9ffiNaTSzFYP+hIwyVz5gMf9kYO9erAqnd/kk=;
 b=lANo6acvFf3wQAq+d1mNdnxs/jVhMSKkQceJknALt8OpdBodY9kxGUOGk5Ix0srL+t2L09RhF59IzkzN+XHgLqkvnZDM+7VMs+pse78kqeNKGbTdlpsIVhDsV2shxd6DRxMEka1sWjSRiksIzuXnBqjMshxzYiT85EIV+60wl0U=
Received: from BL1PR13CA0400.namprd13.prod.outlook.com (2603:10b6:208:2c2::15)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 09:45:16 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::af) by BL1PR13CA0400.outlook.office365.com
 (2603:10b6:208:2c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7 via Frontend
 Transport; Thu, 19 Sep 2024 09:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 09:45:15 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:45:07 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<bharata@amd.com>, <nikunj@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
Subject: [RFC PATCH V2 2/3] mm: Add mempolicy support to the filemap layer
Date: Thu, 19 Sep 2024 09:44:37 +0000
Message-ID: <20240919094438.10987-3-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919094438.10987-1-shivankg@amd.com>
References: <20240919094438.10987-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a31009-748e-4b5b-42ee-08dcd88fc3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HfzqPEcjGx5qNfopDq3cPnfkIhBoSu0aHEKP1GZL0xL9i3LqSE0Opc9+J80K?=
 =?us-ascii?Q?JjffM+BbuhebIjKR/UrghO7aiY8i7vfTORKWW+rrW/Q4hiBEr9cpxLzUTVM2?=
 =?us-ascii?Q?/h6mZks7zTGnWDxftTnlP1/eBhnkinOXAOWABRfzx8Iv7oJdbDDDJpbVG0Rh?=
 =?us-ascii?Q?NMRFPGCRRkb5UY1sAJyBW8dXA4AhcZ65iuuCCcbFCBb90qucx5jlGTN3x5AT?=
 =?us-ascii?Q?SuthEx0Gt2nO2a4K6wYwh0Ze4yN+icatQGBtOrO2Z58oroqEwgHDBtRBRjq/?=
 =?us-ascii?Q?6GaW1/cfCK48kRAhnEovofbv4j1baO/7sQynazojpzWVm3XKf6JcDxb11K4r?=
 =?us-ascii?Q?kLzvF/H9nNehvz2pwesPiZvaJ4RCBVxt0933TI88XMbZrLgeI/Ag2LnwmH9q?=
 =?us-ascii?Q?N+mIctWCBrrQfwYsptO6BV2cP4Rv8waJhsS9/FtSQYanbyAehy1CleMGsniT?=
 =?us-ascii?Q?VCretlYb3zn+ME02mEVnfoBP2U5/8mhIxYbjtqArKhKiMIDiRcplE/xWo7Fk?=
 =?us-ascii?Q?Muh1ip8pHFdR4VnyjSmflQg1eiDotiqAZxI8D4Jro1/R+JTBxr4bhInE7lSp?=
 =?us-ascii?Q?2fKrcBN0ipw6gNewvUO0rO5cAM5F6iRuqQ1lNHzp319gwyu7n2oyqrCKGdpB?=
 =?us-ascii?Q?HZlsdrifOxD33Q4NH0NqFEQ0hL4MDeihfY/mGQ+IsQvu9Gd6A0bF1MdHnzJ5?=
 =?us-ascii?Q?iHE11ZBJe7EIZcK20DywZqdDsc7VNHW3BDtg0ZTtAh4oV/VrqLhQCZVpeMuD?=
 =?us-ascii?Q?IVz5xEqrx4fUAR4Q68HSUtb+SzES94EPgJP1zftKLM5zhzGbf/h5MflQZe3C?=
 =?us-ascii?Q?9Zw0FiikpC4dOkbuxd8ylpH1Wxl/hCxLcEn2Tm7Dtyrv1vetQZB0XKKAWdBm?=
 =?us-ascii?Q?4Y19+GDbCgGhigWWm84jebVckwZKs+gyHdlTk3E0GOq/GzcxLbqibKm2o+zw?=
 =?us-ascii?Q?NlKv6a7AYyUq+FhyGOfpp112/dhY6eeYaLxPRK4tlinc48l01UGrwJnaURcu?=
 =?us-ascii?Q?kae45PFp200CWiADR7XoYzNH6GXUKFIOEr06/jbl4rluf5zvnoom+WfUBmtH?=
 =?us-ascii?Q?sAIJZnL6mCrBzhcRt8bOHtYXYj+aloucy4VzmOtWP2T6/yNGmqr/T/CXggfP?=
 =?us-ascii?Q?ujYFbmUdATzrwFfJyuOY9alTDiIPhQrB5htM5Kst83RP+Enp11cgWpkUE35O?=
 =?us-ascii?Q?fVmXgY/HLryMNFaUUO+cw/j0jOCjMPMQ3I6DX7jb5HjEzzl9DoOpdRNfxT3T?=
 =?us-ascii?Q?/ML1DSvoaq+rhdHFaqRO29CvL30nw/DTG/GEZT47eRnqWKVPpziq7yPU+edn?=
 =?us-ascii?Q?wnRHiBsPV+Ocy7HVZPDRQag25pi2mz9fQ+CQEPlnmrOCdhx+0H6C1+QNmEk0?=
 =?us-ascii?Q?eQIe8vqgjCjHnPvwkzPSO17x+hYaTfaGlwBNX2q0jCyJtO+fWPUpxjDNskMe?=
 =?us-ascii?Q?mA0dBKrFVTayo2Yj8Kz/NW0zeWv7xfrh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:45:15.8736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a31009-748e-4b5b-42ee-08dcd88fc3f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Introduce mempolicy support to the filemap. Add filemap_grab_folio_mpol,
filemap_alloc_folio_mpol_noprof() and __filemap_get_folio_mpol() APIs that
take mempolicy struct as an argument.

The API is required by VMs using KVM guest-memfd memory backends for NUMA
mempolicy aware allocations.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/pagemap.h | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c            | 30 +++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d9c7edb6422b..b05b696f310b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -564,15 +564,25 @@ static inline void *detach_page_private(struct page *page)
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+						struct mempolicy *mpol);
 #else
 static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	return folio_alloc_noprof(gfp, order);
 }
+static inline struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp,
+						unsigned int order,
+						struct mempolicy *mpol)
+{
+	return filemap_alloc_folio_noprof(gfp, order);
+}
 #endif
 
 #define filemap_alloc_folio(...)				\
 	alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
+#define filemap_alloc_folio_mpol(...)				\
+	alloc_hooks(filemap_alloc_folio_mpol_noprof(__VA_ARGS__))
 
 static inline struct page *__page_cache_alloc(gfp_t gfp)
 {
@@ -652,6 +662,8 @@ static inline fgf_t fgf_set_order(size_t size)
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
@@ -710,6 +722,34 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+/**
+ * filemap_grab_folio_mpol - grab a folio from the page cache
+ * @mapping: The address space to search
+ * @index: The page index
+ * @mpol: The mempolicy to apply
+ *
+ * Same as filemap_grab_folio(), except that it allocates the folio using
+ * given memory policy.
+ *
+ * Return: A found or created folio. ERR_PTR(-ENOMEM) if no folio is found
+ * and failed to create a folio.
+ */
+#ifdef CONFIG_NUMA
+static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
+					pgoff_t index, struct mempolicy *mpol)
+{
+	return __filemap_get_folio_mpol(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping), mpol);
+}
+#else
+static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
+					pgoff_t index, struct mempolicy *mpol)
+{
+	return filemap_grab_folio(mapping, index);
+}
+#endif /* CONFIG_NUMA */
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..a870a05296c8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -990,8 +990,13 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+			struct mempolicy *mpol)
 {
+	if (mpol)
+		return folio_alloc_mpol_noprof(gfp, order, mpol,
+				NO_INTERLEAVE_INDEX, numa_node_id());
+
 	int n;
 	struct folio *folio;
 
@@ -1007,6 +1012,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 	}
 	return folio_alloc_noprof(gfp, order);
 }
+EXPORT_SYMBOL(filemap_alloc_folio_mpol_noprof);
+
+struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+{
+	return filemap_alloc_folio_mpol_noprof(gfp, order, NULL);
+}
 EXPORT_SYMBOL(filemap_alloc_folio_noprof);
 #endif
 
@@ -1861,11 +1872,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * __filemap_get_folio_mpol - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @mpol: The mempolicy to apply.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
@@ -1876,8 +1888,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
 {
 	struct folio *folio;
 
@@ -1947,7 +1959,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
 			if (!folio)
 				continue;
 
@@ -1978,6 +1990,14 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		return ERR_PTR(-ENOENT);
 	return folio;
 }
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
+
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index,
+			fgp_flags, gfp, NULL);
+}
 EXPORT_SYMBOL(__filemap_get_folio);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
-- 
2.34.1


