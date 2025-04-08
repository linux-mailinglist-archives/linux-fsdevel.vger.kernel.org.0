Return-Path: <linux-fsdevel+bounces-45968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10B9A800B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80579446F3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66A22690FA;
	Tue,  8 Apr 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5I1Qyx2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CA2690C8;
	Tue,  8 Apr 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111493; cv=fail; b=njbRVE5oYUq/Iv2UYlWTG6c0OhH1PbV+QtQlIx7sPvOxb5tg7NAJeUIibOl+oZFTioKwWXIF5boGn6UJy2g3N92gprauUn941Frva+OGxOoZfue0CBAWQJ+AWjC0QZR3dyzmMJ8Co/U3SywkJob6NmEPSNuYPPjInvNWHz0FVSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111493; c=relaxed/simple;
	bh=l5eKqlMTewsgv4rS07QQeBk9exGqHF2yhh5W4DRP23Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngCvhxGRZJg3dHB3pNmbBOH9FPpifiq+RKW8lkEdaHyNy3TtuamzbW6r9ITsFxK25A0rOD490K3MJgLvd0+6xe+evRqLqodu3qj4EdZam70dzryn5BRt1kmhTN4ZbV5MDNiJ7WJ4L3n3xm4rclh+ZuWgj7updUWOsGpQIgiob4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5I1Qyx2g; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma7VyaPSV91rzRbB+XnuhgDa2xD0rCM1iRsbdb5A73AxS87XceqkJ/LUGHbSa/9d7fkDDT93hrfqrk3iAAM3tqeQWY28/hfP+XzZwjuThcYeJSCOebV9MHxk3XoTQsUuMEnSae2sXnjTMzP9vfdBL+8UieNydR/ErC7iiu294b0xZrQZ13iFrzHNEXrKQOeMQXAAMpIBPfc29zQY9paxFfWNZUBzlBcOHUoO7VlX/VSUSdesdeE70huL+69WaMFEES1MIRKqUibscCJzCS33LnCyy+4OGRg1thc1uTDBV5ZEDHyOSun48SEJ7v2qOKpJvOIeh8Cw5qTw4dU25UKVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uqbzL6FNYPIGoO2HURWE8xG/C+IhaKcZleIt9i+uj0=;
 b=lIxVn+0NdyEc3wEWssHCg4B91LOK5aKx4ogDN2wmoq6nHolqkorxuDVS6UHqQAbTk9qAbdB04bmkKYccbIboTb1BImZ5uK3AJHZ2Vmh5tFtd6mj2feZ2muRdecRyGcKWJoQOKtb4PxuL7qdnZeKoIgd/b4Ff6rerWo54N/BEtnBOQH6TzQ/43rUl2hZbwnpFq3ODIslas56tf3X4NRdLJWjrafCd/py3YrHbRFkq/7t0fdbTVqWvYMUkZKaUoygA1mdi/5HON0McGoTjImE4Wn1YWV6ijBBW0qVaUQo2PWoyuJ03D8oCfadLIk4JewMZfqJzOze9pPRS4AZXoROsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uqbzL6FNYPIGoO2HURWE8xG/C+IhaKcZleIt9i+uj0=;
 b=5I1Qyx2gGZ6uU337zhKvyiXTra0NF3laN29ukOk6FuFUnZuzZJtYAP0sKyQDdNcoKhwcCB/TrUHqIND+eYlbUbMO1PUgy2RFT4AdVlqfUNp1xFIbm0wmw868x6XS2rx+ghs5bFmoMoeQzmjNM5Wt0Od+y7aMTXtcQirxB3OGOLE=
Received: from PH8PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:2d0::19)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Tue, 8 Apr
 2025 11:24:46 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::49) by PH8PR02CA0001.outlook.office365.com
 (2603:10b6:510:2d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Tue,
 8 Apr 2025 11:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:24:45 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:24:37 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <shivankg@amd.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH RFC v7 1/8] mm/filemap: Add mempolicy support to the filemap layer
Date: Tue, 8 Apr 2025 11:23:55 +0000
Message-ID: <20250408112402.181574-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408112402.181574-1-shivankg@amd.com>
References: <20250408112402.181574-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: c29eabd2-7db3-4997-df96-08dd768ff718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?32Iwbid+0ZejXpHMtNBHQ4k/qVG6Nt+x5G3Mn7hsEbuHlOjTmvAw/+oTx7Fg?=
 =?us-ascii?Q?tHXwq/tBH97WeQWp6esUrQOA3t7tXvgiFFPmohr4ouWsWZsX4XwNHNLzq/3p?=
 =?us-ascii?Q?1b6/88l5YiJW0XHvO0n8o6ffq8rtJkOYrkeXgrfIxc7cOX9yUkZhhyRyTOhb?=
 =?us-ascii?Q?Yhluq5t4smjR3TTPZlBzEfTDIQ93CzHKA/swcwHMpbOJ5BGt8c5ki3vcrjyW?=
 =?us-ascii?Q?kOVkq2ZTrjbvBvZ6dV/uQRUoRcc0OcWEGdE4iPR+1AkN09Ese9hxz2RTcDBe?=
 =?us-ascii?Q?WLuJ1Qgh7nrpUeOh11NQJkp5DTpZPaEkFixjd6HmfhIq+igetmvfjqa6ra1H?=
 =?us-ascii?Q?GfkFEJhvSZ/6Dl4BAzVOPEMY9WtDZr/CHqCsO07wwfoORoMinGpJYRBe83NM?=
 =?us-ascii?Q?fqVEEW9lBQQkJsriNMtnJNLHoP4+Pg70jHR1l2FVmidBo32yGRYD545AvnF6?=
 =?us-ascii?Q?wG5HUKvbBXRe0XnBAuMBn3SgRSs/tjwnCeCL8hSRClbEIuaFzHZt6XCKuQyQ?=
 =?us-ascii?Q?imyN6HqaXrKOKNa7UXzzkMj7ieVPpF0d0grCjACyfA7S2noH0k72PW3hmmyj?=
 =?us-ascii?Q?7JGpN3h7WkePuMB4JU8/fESj6wT9hUD6BLrMakihToeaPloIZDCWT2l2zYsf?=
 =?us-ascii?Q?r3gM/mKMtNWXVjQBbzY4pIgP6/TSEzQXSxkpZ2FfC8JwRdCsP+NzX0eqXHT8?=
 =?us-ascii?Q?5NMPK6OqFcHTbz8sPrhiXdSJcKiOyb2cV4jTr/Ab9bkMShV5Bg6+3q2kq4Zo?=
 =?us-ascii?Q?hcItCExKuSeng99tHcbpO7uqqlYvA7sgdZBXGeg5nQ5I5A1hRZKdKK3I05Yp?=
 =?us-ascii?Q?jtKJ4lXUN9IROJ1za3lcS3d3BmSxqg10jt3GnJlMNInVUKDMjFNnO9V1RC2K?=
 =?us-ascii?Q?5odjMN0xDpqVL8HVrVvQ+Y6k1/36z20XchM3DumQr/S8ICGO+oTVnwk/36MW?=
 =?us-ascii?Q?yIutIhoJX/VZGk62E35TJ6GG6hzo0gHB6Tk87nL0vUqHulcgoy5e2+GmWYys?=
 =?us-ascii?Q?VZPVKqX5TXo6qM6wx7iG1J0p5kuI/MypGTZ1Qa8egj+P52JjNzGgOjs2Oc/L?=
 =?us-ascii?Q?w/StanNJ0nJuind4EBRKFpQ4HnwOmdVnpEz7DltMtfV2+4Rt4pxjRR+QCrmD?=
 =?us-ascii?Q?dfEo+L5EeDqUfXtyIrbX0Xp4EskG9JoSvnAesX3NW0wHbi38Tg1/qEsuxnd7?=
 =?us-ascii?Q?DDhkJEjSR7lO904BEMFne7WonOEavkx2xXkz5+r9C9EIM0VI/eFqeVnxMCFz?=
 =?us-ascii?Q?BlgHNFCZqEP2vdl6MHsP4ZAyakCtqeOjfPnsnQEmZphgX3OoB/6b+qQYmG7D?=
 =?us-ascii?Q?F/F0+QgzQUCVQ14rGqDH+2vVyBmMVBE9YOSKKP3YEjM3IreFZYcm/SosTBFu?=
 =?us-ascii?Q?G4dxnT/uCWtYiACSth7HSbpNTinRM9G/kUSR/WjOlOaLY00xT20CGhbyuJID?=
 =?us-ascii?Q?w3i8mdyc5lGuTyBs0LOEjpK76ZkVphYCZODzU0DViIvmvcYNRKiomk2bGrDe?=
 =?us-ascii?Q?P6i99qRdPwq2vup7EczBfmjlz80+kHNIasSy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:24:45.4013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29eabd2-7db3-4997-df96-08dd768ff718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899

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
 include/linux/pagemap.h | 41 +++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c            | 27 +++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 26baa78f1ca7..bc5231626557 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -637,15 +637,24 @@ static inline void *detach_page_private(struct page *page)
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol, pgoff_t ilx);
 #else
 static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	return folio_alloc_noprof(gfp, order);
 }
+static inline struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp,
+		unsigned int order, struct mempolicy *mpol, pgoff_t ilx)
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
@@ -737,6 +746,8 @@ static inline fgf_t fgf_set_order(size_t size)
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol, pgoff_t ilx);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
@@ -795,6 +806,36 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+/**
+ * filemap_grab_folio_mpol - grab a folio from the page cache.
+ * @mapping: The address space to search.
+ * @index: The page index.
+ * @mpol: The mempolicy to apply when allocating a new folio.
+ * @ilx: The interleave index, for use only with MPOL_INTERLEAVE or
+ *       MPOL_WEIGHTED_INTERLEAVE.
+ *
+ * Same as filemap_grab_folio(), except that it allocates the folio using
+ * given memory policy.
+ *
+ * Return: A found or created folio. ERR_PTR(-ENOMEM) if no folio is found
+ * and failed to create a folio.
+ */
+#ifdef CONFIG_NUMA
+static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
+					pgoff_t index, struct mempolicy *mpol, pgoff_t ilx)
+{
+	return __filemap_get_folio_mpol(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping), mpol, ilx);
+}
+#else
+static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
+					pgoff_t index, struct mempolicy *mpol, pgoff_t ilx)
+{
+	return filemap_grab_folio(mapping, index);
+}
+#endif /* CONFIG_NUMA */
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
diff --git a/mm/filemap.c b/mm/filemap.c
index b5e784f34d98..7b06ee4b4d63 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1007,6 +1007,15 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 	return folio_alloc_noprof(gfp, order);
 }
 EXPORT_SYMBOL(filemap_alloc_folio_noprof);
+
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol, pgoff_t ilx)
+{
+	if (mpol)
+		return folio_alloc_mpol_noprof(gfp, order, mpol,
+					       ilx, numa_node_id());
+	return filemap_alloc_folio_noprof(gfp, order);
+}
 #endif
 
 /*
@@ -1880,11 +1889,14 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * __filemap_get_folio_mpol - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @mpol: The mempolicy to apply when allocating a new folio.
+ * @ilx: The interleave index, for use only with MPOL_INTERLEAVE or
+ *       MPOL_WEIGHTED_INTERLEAVE.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
@@ -1895,8 +1907,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct folio *folio;
 
@@ -1966,7 +1978,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol, ilx);
 			if (!folio)
 				continue;
 
@@ -2013,6 +2025,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_clear_dropbehind(folio);
 	return folio;
 }
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
+
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index, fgp_flags, gfp, NULL, 0);
+}
 EXPORT_SYMBOL(__filemap_get_folio);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
-- 
2.34.1


