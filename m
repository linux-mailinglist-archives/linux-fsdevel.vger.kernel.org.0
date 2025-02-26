Return-Path: <linux-fsdevel+bounces-42641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5766A45819
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44C67A215E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32A20DD4D;
	Wed, 26 Feb 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p/jmIbP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF931E1E19;
	Wed, 26 Feb 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558473; cv=fail; b=r59Dv9IIIutbJ6oEScOzTK8kmuVzYqNZlD2XODJQqwHpY2Dwbt76YASlwjkk+UvzGkLt7z4pt8GWT9T8suIoVGidHeLZ3kLXvFXo20viDNZMhrOGe/ANkyM7IKYilOXTs9pir8lC7LTNjwb9SAcRTC8I0iNmzlv9tTVJxpxeRFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558473; c=relaxed/simple;
	bh=FMoG256wlP9K/tchY/CCrQgB1dAhm6O5/UhOD2oDwyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUMoJkJCpxLesW95tzKu9QpGk2zX5vaujRLgSq0FDLr5qUyKIpGDcBel+H5pvA0MrvsTPws5vXxJz2QRTOPM23n3eH/ofl46mnRRVp3F9FREdObPU2q8mSwcEgZoedPuak7eFsOPMMHt9Z9SvGx0oaBc0zHY0D1zu+FJViZBsw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p/jmIbP5; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2v5zHqb079Ix0KiABkynRoWvIVBh1bnAHAkibQNbWkqzyay1lqWsSk9jwXXe8FhQRKQAEm0K7mLDNMYmwI1BEvuwyYLNHrsT6pVp5osebFRC3kU3Frg+f5hWJNuIYvvZfBkgEI9yUyb4VoGm/g+TKSdFjkpCOoc2G+iOf1aBOKzrX1JGHXQayyv1RTCZgsHI2PwjDOU2Z6vpfb3SmiHJ8vQUwJpoNeFVyuw6BhW8xxefng03tuv78CFqpKJv3qN2dNf188QczxYOeb6j1BOhqj8sAJAkPGd6tvUR+pBUeVuPg7PuL90CUEgxxAJqm+nuoRJ+ueMuNKFirbiSsWKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vivwxVzhYXSXRbnUtlPS3+5iB8vM+0LkXpFumT7W7o=;
 b=pGZfyCnrIkEEn3XFApPhU1Nu8v1ZbH30DLmY2eU8tWwemXbADgjPAaLJHfkPPdarFgJue85O7WbERIOY7OKDsgFioUCHuUdPgpFvOh7CqquML+VrV0rpTMk+TSz5rIE4Aaf4LHX/fbQOrHJodNoWXr1nzky9nfLSacNNyx5OXF6yXci7NP+juZE3vvIdH9XTMoQUyj4H+arzEfyWGRzuINvavhkR2eLkNlJqJAzH6IWA8G9zB/Ji7XyvRUTwmyTaw5NhbFjkML3BMBL2e+dy063SEGzzgZN/RlYl/bOQs5jwrihtJuWC/UOxFaVEIMc7L4znYl/9FiHGLWI8Rdf4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vivwxVzhYXSXRbnUtlPS3+5iB8vM+0LkXpFumT7W7o=;
 b=p/jmIbP5yWs7d4BnYQtxShIHVyFhmMUBSAbCC4M6ThkeIfBlVduJD4pZTFHynPTbgRRrOiob8XU6wZba5lITOb+i43F+Dkiev3U5tfvUjzeKS459UDwxpOvuRgGFlYyOocBTS0aSC3rtLfhQFpapjvNEVW3tSg+RIAG21t3sC1g=
Received: from PH7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::34)
 by CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 08:27:48 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::2d) by PH7P220CA0078.outlook.office365.com
 (2603:10b6:510:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 08:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 08:27:47 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:27:41 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>, <tabba@google.com>
Subject: [PATCH v6 1/5] mm/filemap: add mempolicy support to the filemap layer
Date: Wed, 26 Feb 2025 08:25:45 +0000
Message-ID: <20250226082549.6034-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226082549.6034-1-shivankg@amd.com>
References: <20250226082549.6034-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH2PR12MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f32f042-c63d-4278-4a76-08dd563f739a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9WnNcDWIDLhtB8Ya1QrIVrqIAXyroWG023ehpP1pzUWL9NFldgFANRttGmd7?=
 =?us-ascii?Q?N4mwn0czXOyLsR3lxnKwAgnDoLnc9/bagqgtCXGbaeEy2tTGqRwADLFuUiBw?=
 =?us-ascii?Q?qH2DSDXeWVTGEUXLlJDWv1RVWQnAIdXojsB7t+9/anT4LvmvTM2XgOlUylEY?=
 =?us-ascii?Q?jEywhsh/Tx0v+juXy85havCPLz3k55MGozCtrxBFf9PEQ+kFuyXY3xgBeSIQ?=
 =?us-ascii?Q?GyRCP3SxykUrccCKF5KV+7fsrbhzkhTzia4AT6lVz5wBjb8yxpslTxkjrLSx?=
 =?us-ascii?Q?5fOjMKyZr3Z8dpT6Xijszct1mao/Yb7p4YXzKJ22h+K3BKRLUGAVZnb/GFNy?=
 =?us-ascii?Q?gxED9FqWMZ8+IXVzknvAXLWiO7BZ+kghtWRP2hslPdrdQ9n9ly6COJuTUnvv?=
 =?us-ascii?Q?XA/JBbMEiJ6XxeEpg8yTmKmxqXYk5ZJRZPrau2v6Mlpkp6BrEi9QJ0XMober?=
 =?us-ascii?Q?oJ9oKGirif5JAJ0XDWFvboWq06FNrjIgNwqn/ekm1YdZ5xDyUB6WGoJUW5g7?=
 =?us-ascii?Q?xwA2mt+0GEnl2fzv/yBoqtefQRR/cKLJwYSScftyx6Wx5Vt+cLgLbqTK6y2C?=
 =?us-ascii?Q?cIXExuuughEsVpy3If5hYe8xbCrGzKex9ueiV7tmtOAPj+isNYMfaRW2r2oV?=
 =?us-ascii?Q?v9iDc8Dgn+W1OWiHZithwTDZqBfJSBmP+Hzgw0OBtVEerVppeKDnrwVxumh7?=
 =?us-ascii?Q?VoBGZ3MGleZpo2WETHzYVD9idsMNeABJ3IZdfoHdiU9um8lED2oHv15j7DXa?=
 =?us-ascii?Q?+sumgeyt7emkVOOtp9y1uPHzQTo1GjzgSW3lF2s7IrekS1aUELpco4yUOGhd?=
 =?us-ascii?Q?igRqUYrOaGoekGZYtnhruU6+w1+ljk58hAZo7D1k0M7jeTUZNKl8w8Yd1GIF?=
 =?us-ascii?Q?kSpoD2qfkM5PK8VAJk/mlNnWj4hI/RJ3Xgiacb69FtJbAt11Rxlx3b59n82g?=
 =?us-ascii?Q?lzf6S4Coxa/ha6Vk3AIzqeMSgzCqwT+A2rjuYuqJY3mcJ0uAtyZzH2sDYavv?=
 =?us-ascii?Q?3l4OpQKZXPJ1Xt60HZhBh5cCIQITi/93v48f+oKCJfE2w+TG+Xys4wy7UT1S?=
 =?us-ascii?Q?iy1CO83W71Cn5sLb6seD1L+P/HBgdu69qUGqj8kcfp9CdsKS4DZ1p5m7XZWB?=
 =?us-ascii?Q?5m1g9DNJPopRWFirRovY/4zE6ySGmB2vD33lYAhlK7iujqjUiXB8svljXr+o?=
 =?us-ascii?Q?582yQE7BeXOOYaymQj2qi+9yNsAOOgLwa39T6GLd5DY0hqgI3W8y1hsZEV9P?=
 =?us-ascii?Q?hjP6V3DMgkz01fGeTEi+nlTOYS2yxCIzs1NW35INSBA7Uzu69qU4MdJ4Ird1?=
 =?us-ascii?Q?8d9KtVTPF/mQaNnT0PB8V5ip7uYjR92/SU1VGQJfPEpPHZuQg34pEfWDQSAI?=
 =?us-ascii?Q?QtNk7OQ1Xw+7EDgmiGgGapYVga4IDpR7PknojvkM2ogDSsShhpYriXJb9pk+?=
 =?us-ascii?Q?gxFNZSrJeB2mVLV7cWr3mT/WdsAtBS2gWf8l9lzRgb0i2gsmWopmfB+dxjzf?=
 =?us-ascii?Q?M8VrU+1I6oTonp8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:27:47.7335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f32f042-c63d-4278-4a76-08dd563f739a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518

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


