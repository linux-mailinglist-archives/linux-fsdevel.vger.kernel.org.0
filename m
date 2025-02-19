Return-Path: <linux-fsdevel+bounces-42055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4458A3BB55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B14418971F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B71DE4D0;
	Wed, 19 Feb 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xF7Woykr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FA1DE2BF;
	Wed, 19 Feb 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960190; cv=fail; b=fvrLGL/q+GbOwWORDcm1+ep65nh1MdtsDgraLS9Td5EGVLAvyxEVBPKvU9o+gyQVuD6cN2CNIge86mbIgD79eScZ+nejRgsF1/JEeFTj8hPVhivyrDFlQJijIUbeIXw3kZL8Kotk/rmlB/SObsvBirdc8yoIl1OLk27w+oGqchM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960190; c=relaxed/simple;
	bh=FMoG256wlP9K/tchY/CCrQgB1dAhm6O5/UhOD2oDwyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGSEep74CQWBq3zVQkG2a93P8rWGO9wqCc0GFl+W8Ocl8f4notzcdaXPIyEd0n81xMp+q9bWrqCxm0vmuFo/1JlHKvmvJUwI+U+G0v8nRGmUuFk1INI63+aVG0qAtWy/wtWhWdupjvyDZHLDA6uQq263tH+0bdJb+iPGxz0c1ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xF7Woykr; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo6PUXBPJQFdfh6o6UJdDqPVpA2CFG2YhEnVKvQbEGBmR4BcYFDcOOU9+a7PkH62XL5dUTP+8ihRyGNZKMENBhpxZwfjdiCoN5sEKtcfYR/LKNquX8vO9y015SvPhcZlMxiYyLjOqUsSGXQjURytZihvBy69BtpsnT/2P6f/d0Z9dD8sLC6GxetDxigiFqF3QqeKhxgeIUi5kCawcN8jIRwbT8Qpd6E1Nj5dkgBl6jCyKpiZ1qKf8RTT5lgnVLePdS9IaByYeyH2HCRnBHRvRGjN2huu08qTcWbdsZdiDjy6UoY96Pz/j7gvSZyObGvqB6HTaVnSZ47uj93x/P2lLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vivwxVzhYXSXRbnUtlPS3+5iB8vM+0LkXpFumT7W7o=;
 b=SmJ6uiEMQnNgZ54GDW0e3JORcvh5uG5F9K3PotzX0o8pRlOxjUBjesfltjcyBSmjzsf6+86KGXt/6dE142Q33VsIou3vUP/Z9BrcAKSdwnRC/8WhRSua3Ag5rsrTkgKdnMRDKmVhRk4g9DvOdXnKMn+9OWKKlfZ+wG8M+lAbuHg26ngEriuyGP2IpJ8os7mi8WHVrUib09q2Z6PFbaH0uFqgaBBPs1YWP3VnFDmLFtw8aHZp77pUUlvZg6PPLKWpIZAm4UbRHbuwJ0cEgfyC3ovGTh7ZI4O1Poj9VWHWwvN3EPmbLlaQIGvL41S5RM1LNmHw39xLl6kNmV9VgJDMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vivwxVzhYXSXRbnUtlPS3+5iB8vM+0LkXpFumT7W7o=;
 b=xF7WoykrT5QzJbXj+l4p262d3UV2DG94VfbL0voKY91OabKTqXHFgbjpgIuun9USHcIycJ7/bI5ynifPygcfe9NNSnOnCmNjQqldYJppyLio/2/RVAHq1hXNi/TNc+5GLtw5Bxnb04oMZVC/WE4Vv+VlRi17YJg4BG6we7Ic0S0=
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 10:16:25 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::b1) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 10:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:16:25 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:16:19 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v5 1/4] mm/filemap: add mempolicy support to the filemap layer
Date: Wed, 19 Feb 2025 10:15:56 +0000
Message-ID: <20250219101559.414878-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219101559.414878-1-shivankg@amd.com>
References: <20250219101559.414878-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 32794388-6786-449d-117a-08dd50ce7748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c3ykNuiF2ds+phpf2vqF3WHpnZZlMYGM8d4c2f36yLSZ3RNYXA3BXD/uOCaH?=
 =?us-ascii?Q?RIBHfIFiAu28NSoBprTyn1cDfewY6cA1eOiNgYWuJwPO7erNWql0/lNO46YG?=
 =?us-ascii?Q?rzSZ/e09IM+PN+1ax9Sq0PPRS1HmgDRvsYEHkz3Sd8iweLmcQyZZ7GzpCoCJ?=
 =?us-ascii?Q?JISUkp6Q31dk8xyporGCnsjNwDlRC+Hus5uuI86bXQpUa1uzYt/HrxvLBWkZ?=
 =?us-ascii?Q?GsgQMqjTcjIx63ryf1W/bX5FnpvaRXetngTJWCZjIi9SfEf2aEFcDhL9PlKh?=
 =?us-ascii?Q?61Z3HoM6l60COxhMx3kpIawaPFruJgVinG/rEFAO2mnBFeyP6QEBzSoY252p?=
 =?us-ascii?Q?h/wBIXxp3UdyLo0wIBRwoxmRZmUQvubYi0UPqy+z3RgzPPexZBPwOsziu45m?=
 =?us-ascii?Q?hLuX/a7ZkJPYTf47uEwwNsi54GEfDO6zcT869sybxVq3GibqzbLmcdLIdo3a?=
 =?us-ascii?Q?ntMozra9+0/oVkI2Eu0fFDLlQAiJG7RWnS8u03f3FhSFmdLhssrLHxLKw4zx?=
 =?us-ascii?Q?38PQXEWYcoGkE9yVgoqLvTQaxEGBDnc3FSqCnAMnMYijUJ9xn+cGiE0AyXRT?=
 =?us-ascii?Q?OZRekTVRSpcqRMo3BniBflJJWgPHggMDh29+rHQIkpjE9iJ6CxNUlnjsgTNe?=
 =?us-ascii?Q?XiXeG4Zd2HA36LYUXNSdo2HfEy0q6pACqUWmj513HglLq5xW+dhkeM937C8n?=
 =?us-ascii?Q?c+o22e8PWM/qudxGupSyVzt0QdPqUssEzDty5SIvQG3KkRiFrCr1Acn3R7qi?=
 =?us-ascii?Q?fcRZDPJWZoloYaji4aBkShCPc1WUuKHZTpNmfUHqpl8XRf4D3SCf1e8y/iIk?=
 =?us-ascii?Q?sCVipLEtphQY9iTcxJN0hiLALFR4qN5aTsmWHxG8ppaUuJbjmqdqhezW9kwl?=
 =?us-ascii?Q?NBZc74Ja3D29iKzEiHdRmBh+81FhJUDsdiQqJ3g2xJ0ji20SkxqF3jV2JEQ6?=
 =?us-ascii?Q?h7fPVWypN5abLpHAya4SiEJaDh5UT3hCPC51lV2Zzza43Ga4uIx5bl499LB2?=
 =?us-ascii?Q?ty/vLrzE8MWaKf0wbUYa+5d4mpmJBF6QfpRVpZMiRh7IE3xdT5Od7RkjxxTy?=
 =?us-ascii?Q?OASj/d6Orh94FpQ4XJMLw8o6i+PnFq+rSZh4axb5pv5vNHhqcNCgYrYu/bPh?=
 =?us-ascii?Q?MI2u5bf6bfQVrSDAVs6xmYyGPK87KzSMnZjLh+qc8Wb4fJTlJR/7EQGwUMhy?=
 =?us-ascii?Q?FJuqJT599j/MTcTLwkSMujNElrWi5Zcl43g2Xm2YeKK01qqSypys0gXOrLTB?=
 =?us-ascii?Q?38lbZhjYGVIar+QwSWdG2Ppd+us9MGIpNF9mqnN9iKqhQ6Ass/XwZFfQFgPK?=
 =?us-ascii?Q?6ZVRiY2C+dGdDgC4YiUL1d+Jp4T9bn59NLqq3vja8nyodfIdUkihE9ClPWfW?=
 =?us-ascii?Q?fb6JHpHei+t0V55wFfL4LiZiPADfZ1Dfoq7LrnHiak4Ivm7yo1NwSSWdlDHx?=
 =?us-ascii?Q?vyUCaXUpw67V+YoZs/F/i/AK7JuEHhRUoW1U0I1P8N3VxckwIXt1MhPLFdLQ?=
 =?us-ascii?Q?dID/P9ymfLhdwyU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:16:25.0237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32794388-6786-449d-117a-08dd50ce7748
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

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
 include/linux/pagemap.h | 39 +++++++++++++++++++++++++++++++++++++++
 mm/filemap.c            | 30 +++++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 47bfc6b1b632..f480b3b29113 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -662,15 +662,24 @@ static inline void *detach_page_private(struct page *page)
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol);
 #else
 static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	return folio_alloc_noprof(gfp, order);
 }
+static inline struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp,
+		unsigned int order, struct mempolicy *mpol)
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
@@ -762,6 +771,8 @@ static inline fgf_t fgf_set_order(size_t size)
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
@@ -820,6 +831,34 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+/**
+ * filemap_grab_folio_mpol - grab a folio from the page cache.
+ * @mapping: The address space to search.
+ * @index: The page index.
+ * @mpol: The mempolicy to apply when allocating a new folio.
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
index 804d7365680c..9abb20c4d705 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1001,11 +1001,17 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol)
 {
 	int n;
 	struct folio *folio;
 
+	if (mpol)
+		return folio_alloc_mpol_noprof(gfp, order, mpol,
+					       NO_INTERLEAVE_INDEX,
+					       numa_node_id());
+
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
 		do {
@@ -1018,6 +1024,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
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
 
@@ -1881,11 +1893,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * __filemap_get_folio_mpol - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @mpol: The mempolicy to apply when allocating a new folio.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
@@ -1896,8 +1909,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
 {
 	struct folio *folio;
 
@@ -1967,7 +1980,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
 			if (!folio)
 				continue;
 
@@ -2003,6 +2016,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_clear_dropbehind(folio);
 	return folio;
 }
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
+
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index, fgp_flags, gfp, NULL);
+}
 EXPORT_SYMBOL(__filemap_get_folio);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
-- 
2.34.1


