Return-Path: <linux-fsdevel+bounces-52035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C85ADEA1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198DA3BE7FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAD2E265F;
	Wed, 18 Jun 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i9Rt8TBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E028FFE5;
	Wed, 18 Jun 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246263; cv=fail; b=a8y0z/awBNmSohOeLC/Vvbrcb1RcO1QsUEY9mh/OwdWh/97mm94+++dAoy/E3kEl40Io2KM1fIrAddFbaisZFilfclSq9FslViX8yKGlZvf1zffNms+eBVNPmfzaTxIGrelnqwtUcWfGUmLslUVGqMoASQE0LP8Helmi+w7ACKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246263; c=relaxed/simple;
	bh=kgPTlE3nhh9ATtzXkSJ0F0w17EvjJIbiQ5bfpixyxV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+HHkWUogkREmZSyZkA39PiHb4tdz8czulVhjGsGrjNpMqwO7/V0fJGbSu/xGULI7r89ELIydQ5SMuIHoRdlhNnP7zlF4b0nsVL5r/PnvVA8by2i5mpu+D3cyXwPkr/r7/JUxnV2TmfGO7i1kDiVxuZpZ/UjGIhGJnOAv+SgEhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i9Rt8TBX; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPcZJkr8j7OZJh95iwQDB4LiWxAEBMV10FFxRR+lmGb6LGDOKiGbrQEtCAqO/mR/oMiRtlNr7gijlX7CUaI/qxfg1MKVtRZNyRZipZxZCPdy0OllxSSlmhSR5r5fB277cKMJ6SN68HvKBowEIvV9OKuk6g31SDMR5OWD3WC702FG9OP7fiq7u149jLPxZsp+BDXqzIQs8b+mWU8p8EoOxaMlOeH3QFBqPI7XHoTPn76JLpvYze7GfrjxLgdGFyCw2+MrUOsfsFfYVKbivJPd+AlyxeYyCh5Se79RCiDWWSg4fGLYNqvjkJ4qe4hDetvaHRMktg9zk/WR70lVyDN/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMYd2Bb5HtIZZ9cwX69+56dJevzV2VycSCr/0q1Kb5E=;
 b=Q/fe+1vTif5vBlaVrcDZbaX9TJjuPnVgEm1vr7rV99ydIPWNaLdFKQ63w3EBx4QS1EWZRICiPBg3otJmdzl/6CdxwRbbhgok3NZvYkNsEIMwx9+R0gtatAl5rmEdEJrM8h1l8vLeHdfjyRkIyJ3Jcu7Vk4KE+pkOnuCCerET+ekDJbaS66qtwpSKtMMvnWsD6dYeGZYpMsg/7C3R48TkLqCHOACYrUyyTyBDJvRAz+O/BO4I7GfW45ekpXLAsZkJEWl2hGWlU5+K1mU+XlxhfEQDxdvRUUZtOXTP2jdyzCSN5oHORFd+LQbKWiMl2tipqZYLo3PsGEEAT39ALYafdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMYd2Bb5HtIZZ9cwX69+56dJevzV2VycSCr/0q1Kb5E=;
 b=i9Rt8TBXdniE3e6xw2In6g4IRmLcS/FwVAXC2psrfC9/wi+nQhA4KihzyRLCyY9M0cTyeO7kzuX4369bc5XV37Sgf+4c4t0vEf+REYGcXTYBGwu/N7b+sJL4YyNe7OUpvpgcdZFbIke1cqslL2gbMUqoEYqhAwpQrTr0OWHe+Ag=
Received: from SN1PR12CA0110.namprd12.prod.outlook.com (2603:10b6:802:21::45)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.35; Wed, 18 Jun 2025 11:30:58 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::2d) by SN1PR12CA0110.outlook.office365.com
 (2603:10b6:802:21::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 11:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 11:30:57 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 06:30:39 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <shivankg@amd.com>,
	<jack@suse.cz>, <rppt@kernel.org>, <hch@infradead.org>,
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
Subject: [RFC PATCH v8 3/7] mm/filemap: Add mempolicy support to the filemap layer
Date: Wed, 18 Jun 2025 11:29:31 +0000
Message-ID: <20250618112935.7629-4-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112935.7629-1-shivankg@amd.com>
References: <20250618112935.7629-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e067d15-8f9f-4c12-a61e-08ddae5b97ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?acoQMXMHGxLdEmekm0WHZ1+pPHd1hKU7bVgiBHKW0nalcTbIl9WwiNMw0E6V?=
 =?us-ascii?Q?vzFNk/+gMhHX8aoghW2U43zqIjZ4BaX2wFYLgsDNCF8aiRC2TXAYTei8seEL?=
 =?us-ascii?Q?5pxGhN5T1iNkowGwAxFTNZJg87r759VPkwuoWVXozpvWHXJchKQZbcA4wgWm?=
 =?us-ascii?Q?VYGyyTaiBXuDVgiQ0ijOTE4cthKHqWuNxIozkuN6DdsshzSmiF3HggDCNR+3?=
 =?us-ascii?Q?D2y5X0hi38rIq9jraxc1KsJuGFC5IIX6akmEG3B9YUJJqhMWTcePxYCK33UJ?=
 =?us-ascii?Q?o+Fp5B9xB0eTnE1gAn+IgDQStQcBdLyGCoNx2QNEX6v+N+d3d3tVDepmcx1I?=
 =?us-ascii?Q?wim8PIA9Fk4YBpoGw7s9c1r5y5GuvnQVCOi+rt63DwO3TQbFirhQ9FlGt6cy?=
 =?us-ascii?Q?eSQiRTrWCI/CVVpjukNNwH8ioUkOajC1Qks68aO7Ns+1W5SgpqbUjwV31aZo?=
 =?us-ascii?Q?4LkIdlOYlZ5iTSYQhyD7ur2TQLzuoVZvXUJvrlJKE8Ak+Cxai/xP9LGJmZbk?=
 =?us-ascii?Q?y6uMdlXq6PiEJ0zp3ieI2AlIm7W8Cnvmfw+opzoJ9opnQwGYsywi/JpB4Syo?=
 =?us-ascii?Q?1ey7+u6V2l/tlfU4vwCN9igeghNt8zutnWMf8aB7ixnTcE57gorhNxo36ub5?=
 =?us-ascii?Q?mtypcOM8SMfrLr7DfeQoUPH4Qyc9UO/VagSbtaf/UWQALqz1up10P3A4wTTL?=
 =?us-ascii?Q?aGAJSZaBAyKfrpCpmGSvaB5Ao6tYQVFRFwzHb/QsiMOOFqp+J++2nTBjMm3/?=
 =?us-ascii?Q?9V6ElBVw3U9ZFh8QW8w/2rvJkt4Zswgr822i6k5pVWXsnMGe0VcHfP6cJfLF?=
 =?us-ascii?Q?c98WumxDT6zaBPepZQ7phBF/B50vwGv+IdauK3oC35HQ/WQl/jMefxelW/tp?=
 =?us-ascii?Q?6uUnP1ZFmoErqgZgAY/v2/KWurpBtrRps5QAbm7Z3FYkRw67su/hU492/y6P?=
 =?us-ascii?Q?NiPjnclD1eqed1LAufRjQ8E+YAFdpIs4ssPYwpoc5kBeq2v9ZGTjZky4P7e8?=
 =?us-ascii?Q?XDZ6o1uSwaO4o0YU1dwXukfTsXdc9bbUPhTLHOGSPI2w4Bn58nScs+XiORBs?=
 =?us-ascii?Q?/+E6wVIYPTHYqsgOzCxMMAP4fDd4FeVZ+MJvsIQLw86yJ5bN+CEo+16cRK+5?=
 =?us-ascii?Q?3RO6ZPkrWsLyyNt3T9+MIFVJW+49I/xTDoA/mJlGrKV3SGf2uc802IW9/IxO?=
 =?us-ascii?Q?qVDN+r5meFA/Pj9gNjZOYZGY7hsCJSTzkX9nVglsXIHHR/CF2Een95P0YWXG?=
 =?us-ascii?Q?uc2wZAPyn065SeyFrLZ5OcygWI7uf6xHE93d9A8VVhTMAKa3NaCRirh5D0QL?=
 =?us-ascii?Q?KbFZ8OI0BHPlw1lnrp8BKEGvBafggg6NieCTKqhwpFT4osKfH6AYGsZi0Sf2?=
 =?us-ascii?Q?LdtnFVL6fH3f+CnYM+TcB1gbmesqkrVSMjtq+q4W+/NC7c7ddTPoapJmqvTh?=
 =?us-ascii?Q?BTZtTP55ZPACabY9ZHkRb/XbHI+2Yj18ENRoLGCh781/FdwT4XXkxLh40FLJ?=
 =?us-ascii?Q?OlxSBw4GKqEwS6sWyoukplgegUNH9vg6HcYH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:30:57.0012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e067d15-8f9f-4c12-a61e-08ddae5b97ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232

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
Co-developed-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/pagemap.h | 41 +++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c            | 27 +++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..6558c672740d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -647,15 +647,24 @@ static inline void *detach_page_private(struct page *page)
 
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
@@ -747,6 +756,8 @@ static inline fgf_t fgf_set_order(size_t size)
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol, pgoff_t ilx);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
@@ -805,6 +816,36 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
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
index bada249b9fb7..c7e913b91636 100644
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
@@ -1891,11 +1900,14 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
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
@@ -1906,8 +1918,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct folio *folio;
 
@@ -1977,7 +1989,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol, ilx);
 			if (!folio)
 				continue;
 
@@ -2024,6 +2036,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_clear_dropbehind(folio);
 	return folio;
 }
+EXPORT_SYMBOL_GPL(__filemap_get_folio_mpol);
+
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index, fgp_flags, gfp, NULL, 0);
+}
 EXPORT_SYMBOL(__filemap_get_folio);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
-- 
2.43.0


