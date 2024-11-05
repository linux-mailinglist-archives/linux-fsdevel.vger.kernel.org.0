Return-Path: <linux-fsdevel+bounces-33685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A69BD2C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6645F28355B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2861DBB3A;
	Tue,  5 Nov 2024 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5xll6PA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87631D47B4;
	Tue,  5 Nov 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825290; cv=fail; b=cxzuQVny5naBRYV+nC3GPDx4E4TtjfO0abfASAZddlMOIvBxeZIN3r4EUcOtD3NHGe4w3Tj8+ajDn3GwmGKg22w3Zzadif0DkkmqzNFlQbdphcSPtlCXNFh45YQFeelfnfNTJigrBYFTNXCQOz7wp4BbTb7rbOxwEWtQC7fPE2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825290; c=relaxed/simple;
	bh=+UfxFrGXVTVyE8HLUd/UN+Bn0M6fPmxlIpYY0+yPiHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMq1ZXYYkFAOYqtbcsGTCKMAqICLNmq3+4k8nW7L4+/D45dCavQP7iiD26e/Fn8EVGQ5l3DsOZqfozfrullbOxA+P291afm9kl3bfj3qV0reAscV3YVHWFkZUawD9+DyEk9FR+czJu4dQk27GJXzv+JAGnoVHguifjomIf6/f6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5xll6PA; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUQgAChdj0ph1Rg6tt286Ueoi+YWXb/k4ZQdwVdY0+ZGyIfbUH+KUwGe8CbXfOOWzJQQXf39knC4deaVPwURnkQzs+8L+x2iKi/rC3TmZeCjYHYT9bT8JnqFKpPnPyVzEH1E6p7ScN1LdVSCofRX63yFLpJGy1eKMhR24mYqacBcL1nwZoaxwTTnOCngq6BANQTrbmV07DMZvDgl8a8HQPW3jegRGFojSf+ihXkFrtRmPQ1cTr40PYEwA30Ky7U8WfJqrjZczZsCEpEOwSzv40l92bHvEBG6xNFpdiVdkjj+mS/JX8bc9YiKWfCrEgdm8q6gOKpgk4Qcix/tMUlhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SNmEP9ffiNaTSzFYP+hIwyVz5gMf9kYO9erAqnd/kk=;
 b=d1aIOp/falsOP5bYoVTJfyNb+knNOc96sBkgsZuPyE2TGQdcieACj+6ZII0mM/mPJzDDMmtszDqie40wxCwFP75+SaBemToucLmTxg9peVD4LsJkIM87jecf1ChgrdX4uIym8dWF4+3SSjKJglxMCvz1TnOLuVxG9YELg8AZ4TIDieR/1a4RPMBNGOKxzbeqEd0KQWq9bydU5xJn+eSlx5tNBhqIrtULrHmDl28fbjtmI+ew4ZB43rQvGu1cgy1oDXTm8gkWM8NWgsfiPwwk7lTRGrt7EDXkPStMAQe9PSs8LDhCGL/buvvIemGyPbdoj15GRHEd4Mx0zSwIFr5k4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SNmEP9ffiNaTSzFYP+hIwyVz5gMf9kYO9erAqnd/kk=;
 b=R5xll6PA9pyJZJMMjcPryFmYbNQ2v7Vwwe6HlGdxNn3AblAGXDdMj2PtC6+D4x02pbQddvJQdA+Jep+lyz7rH0O62cjHLTqAxGzGyjcl92RGFxVOUHKTI+h5a7ap1+ZRlvXmCBjS0dFHyeRCv7xeoXFpP9xIIaZ8dASngDzHu30=
Received: from CH2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:610:54::17)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 16:48:03 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::23) by CH2PR11CA0007.outlook.office365.com
 (2603:10b6:610:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Tue, 5 Nov 2024 16:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 16:48:03 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 10:47:54 -0600
From: Shivank Garg <shivankg@amd.com>
To: <x86@kernel.org>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <chao.gao@intel.com>, <pgonda@google.com>, <thomas.lendacky@amd.com>,
	<seanjc@google.com>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<willy@infradead.org>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<kees@kernel.org>, <shivankg@amd.com>, <bharata@amd.com>, <nikunj@amd.com>,
	<michael.day@amd.com>, <Neeraj.Upadhyay@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
Subject: [RFC PATCH 1/4] mm: Add mempolicy support to the filemap layer
Date: Tue, 5 Nov 2024 16:45:47 +0000
Message-ID: <20241105164549.154700-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105164549.154700-1-shivankg@amd.com>
References: <20241105164549.154700-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c16f1cd-ec3f-4683-3814-08dcfdb99d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXLT1+MmoGgnJidDw3N+BCOGj6D9ulCKNMq2wsmGmpgJXwOtfsXWSFTdsrWz?=
 =?us-ascii?Q?xb97Wk1i46hf8l4q9SMzUcBLct7cqYIqcZ6pPmsLrHUDCEiaXhWO/6vTGN5c?=
 =?us-ascii?Q?NohVS914x6yJLGqdKVzF973CZGoyrNSWtveF2UdVLj0w9uVdRBFTNeKD573v?=
 =?us-ascii?Q?9rVvkk5yfIxUuURJMtiYOKhILwXXYjKTWzMMR6xS+71OVBW7+X6KVZeVersR?=
 =?us-ascii?Q?awwa40b5BGBv4mMFBKuX7RwnGBkxyRFYFVdCZh/KOjYexJa2kXCfJCmuinhE?=
 =?us-ascii?Q?W5l6Z/UMqeFxPfz37ZcgUJhWbOBfwIP2IFSPlhlzy+M1tpbTm3LN99sNBXm1?=
 =?us-ascii?Q?XtcfQ1yBC0U6aaMvT6I6vI4yUrXAXhZG4mS9c3lWQxbXcrDf+R46k1mdR6d7?=
 =?us-ascii?Q?PfKbwBfwNAW1oWhg52Th10782/nZfk5xcW1fd/Le3LSDvoWYA918CCnNH17b?=
 =?us-ascii?Q?Qm8SLI0h96bMoeqft7RBdFl7GNbdkdBg6KkF7z8zs0dMPrzCSpNLINE7M//a?=
 =?us-ascii?Q?Kru8yftl8SqnHONCglvP/qDgqrzXyPLNYZocNrWJsvAe2VbsLrsJoIyJ64WL?=
 =?us-ascii?Q?43nKRH4zksdXgjQ2vvak+8XkK1Jc5fKoVyFwclWT3x0eZH1/u48vzOywviRs?=
 =?us-ascii?Q?t9FL2SR5VoqqvBtCJK+fiHB+6sXjj1szqFd+mwiaGRL/X7bF4iPLox6tL+nK?=
 =?us-ascii?Q?FFeveswX1WwTDB/OjJAxiccPnvWrL0Gj+/GpXb6JjejOW1bV+mrFulqV7FT7?=
 =?us-ascii?Q?a70HW1UModw9+hnfaD8kQv3JxNQxHMYDsGKLpsZhylfcRVfsoxx1bTtcqagX?=
 =?us-ascii?Q?MJ7IBbaFrXyiTB8F3GHo8Xk9PXZgxAjDccBFcI25Lyw+DAOmB5ECL//x2fGA?=
 =?us-ascii?Q?vtoHtJwqBfnaVFx4F6ub4QySq0zeSPl9pHGMrRqMJ8zfWwe7qyzYoFjkdafG?=
 =?us-ascii?Q?sRKUbs6BkTVCXIOS/CelJddT36d/HuDWxrjXt8dvoBZYUTH/ZfsSFkU5XzUl?=
 =?us-ascii?Q?88GKwJay/cXNuOlOXQ3kXCZohZq1oQORJqDp2IiGjt2+136GymjNUvgCMT4u?=
 =?us-ascii?Q?HZMMflFns7hksaMRjoyizegI0dXDXTNguBihUKtolFhY+d5FFt6mNJSIjmJS?=
 =?us-ascii?Q?sDEI02TUd8ig/1oDEuuWfSa+kGF8wRTg5MgoZZpHn/OuiKDQbmHVJ9Ji724j?=
 =?us-ascii?Q?daunl6M+sx45R+bjUqv4lTic2fn+iwKrYjZPgUWtMU3KjTk+LlLdwLo6vlHk?=
 =?us-ascii?Q?c8IUPpavguUpgn+fMaQAgccGmkqWjby0VqcZ5Fu2P/IbdwWg/iz3qYcfnYXC?=
 =?us-ascii?Q?Cl2fdt0+bsD6utnHnzJxNiuFYphMv2H6K4s1hkNgNciveKjud9dSgbBYQ1RR?=
 =?us-ascii?Q?QM55PTlHhM8H+MYZMJKe+iLAnkq2D2oaWYvuMsFKv9Xua2NAtseODcf15cby?=
 =?us-ascii?Q?iLFH95W8LsU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:48:03.3041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c16f1cd-ec3f-4683-3814-08dcfdb99d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169

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


