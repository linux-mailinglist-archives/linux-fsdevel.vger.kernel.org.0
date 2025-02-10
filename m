Return-Path: <linux-fsdevel+bounces-41366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD692A2E436
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 07:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908953A4AAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD71A3159;
	Mon, 10 Feb 2025 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dWxAXkQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210418BB8E;
	Mon, 10 Feb 2025 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169530; cv=fail; b=qkE4C2Y15MK285ME1c9SeHy4mFLBzIIeydQFKXiaaIwcI0hVEnS09XQtJPoSBzZD56NypSIwJVFlhgVfuCe8MiP06YyyX3eBl5PW8n71ll1CkTPRhkPT6uM0G3F2X9nMnfjYN0hKHz8zG1G6ZNhGdyOFIKLsnZwzu0MWSuXZ6FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169530; c=relaxed/simple;
	bh=YDDOgxWrsIMWyL7Ci9UpGotIt8HVoZ6Mn+m6F73vwMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HITnUBycAbgSKaF7PfPakJw2rWsd3WiLThdrb9Gb2E7xsTb/ovYJu5No0JlDTRp4egwCE2odSjOSANYW8bstPY23oAKdfcs1GGE9O5GmBZ8BbUvp82OI5+q9AAZdVv3CLnxuI2ta+L8kBvyMrFbIq/KdUB/SvgT1df63JbWPAN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dWxAXkQ5; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMoYrJtv6nfRzgRx7q6EJKCFC1jOb4DwIHkQcyazC/BDWf3Ril5PbtyYMuqePpxFNjellIkC0xc2ZrogTVYMFbS1lEiddyyCFCvsJpt11s+dEnKGpCdV/qf0AT1VCl8iie5FeA/e5T6UMUKublqHns0uCB6gTQ8Z5UwQrUUmG2l+S73q9r3qlJc92YEDrilW8kr/qdkxBvceNTLa2/PJ5S4pbZ03VWEKpSIbcdIxRK5x/DsHqrYq1YSGc9zxxmZVe2fKyhKV+ZO1KD7ngsy4o3jofMSFjDuBZyXyPfB9WtbXQvdJlqIVQY4fb1dsPG1VDK6j/v8j5B1SdDoFHbxh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnAbgB0IEVH8MUXmuFIr2W1E91pBiD0xMCFv9PnvN5E=;
 b=H4eIOATbCGiLpahqlRri5Xx/0rib9/aV/I7XsQwBnTLZ5FMcUsKyDbq+1PRDT/ipFAFU4iPxRENC0WuZNuN5Fc3aa2oEqmvMDTHAbytJPyyaL1jgfYh3YHjpEAllLmfgu87hhyWzKlxkLpPRU2uuyZuDNQdgGi+Xe+UP+sq35bOjmMCisLeL0k/uwZJYAG/OUqcJWESy1l88LcenXBSHI0AEu9TOWP5wJc3kwygp0s/4Rlbe7t1kQWI8p9V0yjsqJZRcjxFToznXuKlROLl5y5weizynmj3tBcg+JTAMEm/p6RxCsIzax8qYwOiaFJ9XD2G/TwQA3+LJmOKlkmjV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnAbgB0IEVH8MUXmuFIr2W1E91pBiD0xMCFv9PnvN5E=;
 b=dWxAXkQ5WdPlqLgfU+NeFLTpV1I8zWjtmJHJzTjHHZItmdORkcvQsb/ZXgVVAg9uYMZBjPT9CclKEqta6LrlttCG8v0RcSZ22Y+VLMAR2bvZ9x08247FBiCOCtRzXkBp3e4pbWiZO02ec/KDmaGv8gtKTqLHIfPWQHgezcicBew=
Received: from BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 06:38:44 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::55) by BL1PR13CA0083.outlook.office365.com
 (2603:10b6:208:2b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 10 Feb 2025 06:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 06:38:44 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 00:38:38 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>
Subject: [RFC PATCH v4 1/3] mm/filemap: add mempolicy support to the filemap layer
Date: Mon, 10 Feb 2025 06:32:27 +0000
Message-ID: <20250210063227.41125-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210063227.41125-1-shivankg@amd.com>
References: <20250210063227.41125-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c89bb6c-633a-4c78-5284-08dd499d90ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLg/U3qx5IIZr7xwrAu102zL0AUUd5GnediAl4azfPHYdswYqkXTVCjA0A/d?=
 =?us-ascii?Q?233ituL0c/tL/XTlrwqon4W6gbVHEcxxsFYnSsu64/zC/SoQAAxMubrd/JKi?=
 =?us-ascii?Q?Bd0cWJVq8MPYOuh5ckJ/RjKjaC87sXZDjIYC39MxfjEWB7C0Dxk7KwZXL7je?=
 =?us-ascii?Q?sRxAdJfAvpWB62sdcs5q9JHucrN7lRMprCRsacyahaBroZ8k1RmrU1iQsalo?=
 =?us-ascii?Q?EOEhfQgBHashhjEfwv9PwAzIDhnglkfmCfKSAaDQmeAtYr0ndhJTm4gb4ohe?=
 =?us-ascii?Q?6+dXTjo1gq6WGvsgyRlUq7MTLDcFFs3v/syPVCDjPRjCzry2Jw/zLb8hIvyV?=
 =?us-ascii?Q?PRjMyA9pkSAZqcLVhKh2zGtP9TiCcnFDaUlwfkYH8QMOT7+sv7eUN80KSgWf?=
 =?us-ascii?Q?teZRsSXL3aEEEHPEuFKvcDE0dVBSHSIkWbw4xmmTVzHPzsVCLxzbUhOsagWZ?=
 =?us-ascii?Q?kiQLzZ82nbyoZxAEMtPkrQgH23kMszuKapRt53lykCrmwpzZAE9M8p8TnKtJ?=
 =?us-ascii?Q?wpMfwldNxEEHAa8aJAyFoOE2iAA4UhmeWdGipeSTSxseejZjlcukqNbSbU1L?=
 =?us-ascii?Q?BU0Ul2LEX6uyDGkejwKK4dFKaGXhz92gINEeDmPMXvuceqPa66VCCRDVWd5O?=
 =?us-ascii?Q?AfX4U95hlDBRTzCULl3EUb+8Yh3yx+Wj7wKiNOYZcdSGpZV94R/Not1ifc1q?=
 =?us-ascii?Q?+i/YfAJcy2FKlHFFCLetTqeRcl+sh+aT9F0SXe6T3ZfoKjrCGe/rMjd2Vvvk?=
 =?us-ascii?Q?6vJ1prrLQ5+oadO2SPibj14dPjm8ShYDNcQHME8p3P4gp+bziCLJXlSjd2eo?=
 =?us-ascii?Q?C9kaJwc8hEs3+EMuRk/O4+dVlOqB7GUh+gVTiWFWIEN3CZRFsX6nJaNOtLQs?=
 =?us-ascii?Q?K/MI9UugfOJVc7NMHfM2h1O1IEsICL8TBxRGBlBG8r7C5aGO0TQxSiZYUcqK?=
 =?us-ascii?Q?4sQxwu187/B4SRKItzCBxzyOBVA+iNz9cHxinko+y2mJbheqLxULq80xMB5J?=
 =?us-ascii?Q?gDi4BXwrB9jhO8TfTGSYHYX21MjBdue5YlDCcMnxAwXfyFXUOFV2PnFT6ynN?=
 =?us-ascii?Q?o1d/wgrzf/0wixQD1KiHzZ/N435D/1qxM0IbFrSRtGdfaeCgubZuiLwLi/Kr?=
 =?us-ascii?Q?MeJxNnbP2heybEsTH4Xg7U//XBOxrfjvcf54vb82Zck34GsPUJBn9lIjcLbg?=
 =?us-ascii?Q?5KO8dCLgR4rwAI04Or1oihpKKwbDYnvD8WOO+DkgUe+MQemwBiQh4ylJiDZO?=
 =?us-ascii?Q?62gznUFF2NXWrjF2ZcuzVgC77nR4vfaNragoTRyiKm0QH51QtoUhXCamd3oz?=
 =?us-ascii?Q?HrWjh2BNgDKtg1fkR4lUaGpNVfn4uHg42Neh1gQ+1fn17vL16zcTZjWRqItA?=
 =?us-ascii?Q?vqKK0UGz8plPaaYmeNP9KGHdNzlaCRLKj8ShqD9LAxxp5R7u2X3/S3S5lPaj?=
 =?us-ascii?Q?J3+VHh+sBIiU//RQ33YpbyRWOs0cLVUaPDcz2ROZvlxUxIMqiANGFYpveOaz?=
 =?us-ascii?Q?It+DcmGxaDCBsKE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 06:38:44.1693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c89bb6c-633a-4c78-5284-08dd499d90ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Add NUMA mempolicy support to the filemap allocation path by introducing
new APIs that take a mempolicy argument:
- filemap_grab_folio_mpol()
- filemap_alloc_folio_mpol()
- __filemap_get_folio_mpol()

These APIs allow callers to specify a NUMA policy during page cache
allocations, enabling fine-grained control over memory placement. This is
particularly needed by KVM when using guest-memfd memory backends, where
the guest memory needs to be allocated according to the NUMA policy
specified by VMM.

The existing non-mempolicy APIs remain unchanged and continue to use the
default allocation behavior.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/pagemap.h | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c            | 30 +++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 47bfc6b1b632..4ae7fa63cb26 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -662,15 +662,25 @@ static inline void *detach_page_private(struct page *page)
 
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
@@ -762,6 +772,8 @@ static inline fgf_t fgf_set_order(size_t size)
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
@@ -820,6 +832,34 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
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
index 804d7365680c..c5ea32702774 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1001,8 +1001,13 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
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
 
@@ -1018,6 +1023,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
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
 
@@ -1881,11 +1892,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
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
@@ -1896,8 +1908,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
 {
 	struct folio *folio;
 
@@ -1967,7 +1979,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
 			if (!folio)
 				continue;
 
@@ -2003,6 +2015,14 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_clear_dropbehind(folio);
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


