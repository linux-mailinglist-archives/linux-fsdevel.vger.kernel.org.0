Return-Path: <linux-fsdevel+bounces-54778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E45B03274
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F0D1892C08
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBF286D5C;
	Sun, 13 Jul 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X5zs9+Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED6278E6A;
	Sun, 13 Jul 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428925; cv=fail; b=lCPHyg3gSyqPE3UeA/MfDjBC0b9OTmQdnWbij6B4S6tWjyM8Th3LJzl3k4WdEVKWGFSJ/RsTJv38FbWC9lF9PCN4nD39owyou9VlzKvqsp/bzXEihPFrBQTglfZfgmM/RXMOtqzOrL8ls7rwARhuoAoU/PqAJLs0F6M/cIvA+FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428925; c=relaxed/simple;
	bh=gfNYMfnLukmF73ZJ2Z7VWI+hQCHRZHri0RiDELXFSRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0wywGx9rf0rMePU7lSbsrarAIeueLj7djqMEsCSCJZEtN09EbshXzHT0D/vVKSGXfcLNXf1POLJFe0G0BIpDGejcB+qqxXVzzsQAOdhtGMzwdo3IpTgQjwbs1+pZZyhz2x5wheJ0MZDxGMmb9Sc7495/tA9E62S9EfRQHhfsWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X5zs9+Pc; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tH6Q/6qALBqv9vEv2INjcc/Q4tpMVJbHgYemGz/x4QTH+EcUa9+UOiezSuE6AeyBQTT1ZrCtNw6vTssRYR6khqGPxZ/27rvi9/2Gjmj0zAar9DgNx1OIPf/1RIZCcwKpyZMxSX/n9n/Y9ev/VUDcCPtPz+fvhJFqXIM/eUbP85+9wuUzFyBRCUrp0L2++kdJIy25F4xSfU0pBXxBXvs/kwUTbFe7Go1INkelE+W8Vha17a9K5kVuNYVpECY/fr8X6pfejqFBHShIvjSN3qK/MvMCFBwCccEGYcdQfZGJ3J8gudVHMfSSPCeLq4dqjteWErxCsKDXyj3YItjMn+/OFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/oQjyIjfSR+3rbrkG9B6F+18QPCmeaIjmYcygmhV4w=;
 b=qkhHBicW11JayPHGp7c/gr3sTaxI8PFxSOLskFm63hPNNS48nsHhOEorCBx8lLBvSkOj7yoAQKRqwtjYofAW4ZR7jqUtV8hF6QKFceM+ERDn1oLzBJTVkrnb2GjRof64Gcmww0OFMPgUc0Pk8e2hxHQ2DIH5UDosqDZDKwlYG9p23z+jK+R49lKTRQf7ym9b5H5hfwgF5h31Aaw2xqU16YkrIodDNmpxZ/uYo58Zw/Fmfi5lpkOqiQ95cFf5FgVxSwT9Jje/5k8x7UkuBI+EK9TI+aEb5pkBwWEixzv8BJ1lpynFSblAivJwyTL2SO2tUHT7jcAekI0bm9lTtwrYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/oQjyIjfSR+3rbrkG9B6F+18QPCmeaIjmYcygmhV4w=;
 b=X5zs9+PcdMsleoSlkmFmWuBq4zwYAQsEnR0Bnx7Hr+tIXjca56eYsraTTvovuGymIG6P4Xd3Qg+HoaPiuit+w+R8xILUg9Pfxa7eu/1iwrsUnIQm2Fcg0mVuhSME3J5b78j6bYDPyhp2nJzm2wTdEMAHvrLzTZMsjCkjQa4x4DU=
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Sun, 13 Jul
 2025 17:48:36 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::94) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Sun,
 13 Jul 2025 17:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:48:36 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:48:20 -0500
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
Subject: [PATCH V9 3/7] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
Date: Sun, 13 Jul 2025 17:43:37 +0000
Message-ID: <20250713174339.13981-6-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250713174339.13981-2-shivankg@amd.com>
References: <20250713174339.13981-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 66623946-be79-4824-efa5-08ddc2357e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QPEWqFe1CjLvoMKck3A5FdJ4sFwwSdGlz2wtIW5R6jk2q8hK0KF8Nnj22Xts?=
 =?us-ascii?Q?F7pcypr/1VcwCx+yR2c+0UvN4jBFJUKbSqmQ5Z40YrqkCDhkdU2Mt6kzbTpu?=
 =?us-ascii?Q?TKWYkzgGgKLqRtxeT72e4M/T5o8ag+4/bGr3W1ESR+9hjEYLGP/YEfxIxLra?=
 =?us-ascii?Q?Y9rwktGisdiLyZDNLyYit0aBeS0sxgg6XmnjyBvSSe1SNHNxFbRBqIdLxDsx?=
 =?us-ascii?Q?A+z9nvjkxt1rieCBgX/7BrMFg9iTN9kMGz6QHFe5till3C/vUc5UWKKZrAeT?=
 =?us-ascii?Q?82WEx6gNfZaMlpzBuHBnFjmRXE6ATwaLCufMHIcrjuNdEPydtDKlOUYG9maq?=
 =?us-ascii?Q?GoFcUXLNh9IsRPIMbXZau49GDuSDt5MSOKEik7vII+qx234WBb+48vwiOgXH?=
 =?us-ascii?Q?aI7FTYUnXhjl/tTRVGmBsGNaUv0cJobQZGQ7TzU50eW/0Tdx3Bz0G/ZiH/N1?=
 =?us-ascii?Q?aiqly2LESIDysouYcZp08PUhro7MkKEnCx0/pRint1jsfpzTsui/rI1v++VO?=
 =?us-ascii?Q?uk0b1mWByRs7Qgvd+9nRZnNXDLjTC9w0cCkksk41JNSYo9/s5FOYPmvI7/L8?=
 =?us-ascii?Q?g+9CGpRnpm7NP0vZSEjormN4LlSyrO/Q/BbcW6XSifXXs0COwhqx953S8Cx3?=
 =?us-ascii?Q?kabTh3zySL3yRRdmWQMeh6tXIHyCF3wnnqD87TkOuJ/ixVGHhKQRP34cgeZY?=
 =?us-ascii?Q?Q9+P0uIOCHILKzbUAR5iGLbLL9rWB5uPxSbm1ZVmH31oGD8NNRIl8kYhh39m?=
 =?us-ascii?Q?WwbyMrIgizPyS1RhwfTShLvIsn/jXhesnCPDjt9Wt7O398xOC7sTi5hvdJ+x?=
 =?us-ascii?Q?/oAo5l9uy1EJQrswXONV6DuOcHMFvQCVAWELyzH9gJyLHr8sWIO17T9gpkZI?=
 =?us-ascii?Q?CD9pipM9KQj3NNZfTUXhbbs7o7iQIhfFZYYdBSfhZrzt+UBM24TdTSga27D3?=
 =?us-ascii?Q?w4SDgkeTqi4Ua5X5c02j5W0Ofm565cNrTvqZ8MWnVTncLdEYoF+eCS0q9dSa?=
 =?us-ascii?Q?2txw6l5pm2nPqJ1zF31xkdgL37HL2pS7kx/wdP+tB4WadxTofILwWo6+Tbry?=
 =?us-ascii?Q?BMIv6dzae8iIkAaIxTZfjeih+5K4RPZV+F5VMZxjWuNShprSI//depoSVFZz?=
 =?us-ascii?Q?Nwi1Y6xrt7mmsl7hPUK2Ny2zp1UlszrWofgzF93YUVOhLDjFxCoZHUnTiowZ?=
 =?us-ascii?Q?9QZfSDtIZe5VbLFY7iqfHQrnR4XFzEZ7Aycna3r05Mf5iOeFtEp7ndMdkVnG?=
 =?us-ascii?Q?CN4QgGBrNpavEmlURONLpd/Ija9j1BzVZrAgQ1ygq2W4RzxC1ZfJbyAHMdGn?=
 =?us-ascii?Q?mAEMNqbbSayn8hYg4h4M6tPZD2dBe/ZmvPdVrpRDp2YRiqdN2HvmniJyIMnk?=
 =?us-ascii?Q?F9qVfNl+FK20hd/aCMzeNqwbgNeirYHqFXHwWv//FM/eVugt8taT1Na3QucO?=
 =?us-ascii?Q?j3+QqYumqFCLn8QuL5ttyWxKQSrpD3NeaBBonPkIW51KPetOYutaIWFhAqf6?=
 =?us-ascii?Q?Ln3cRSyl/CDC+aPHUBfSMtN48Jp8Rv2XBvCf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:48:36.2965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66623946-be79-4824-efa5-08ddc2357e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

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
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/pagemap.h | 10 ++++++++--
 mm/filemap.c            | 11 ++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 78ea357d2077..981ff97b4445 100644
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
  * filemap_get_folio - Find and get a folio.
  * @mapping: The address_space to search.
diff --git a/mm/filemap.c b/mm/filemap.c
index a30cd4dd085a..ec7de38c17c1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1896,11 +1896,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
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
@@ -1911,8 +1912,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *policy)
 {
 	struct folio *folio;
 
@@ -1982,7 +1983,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
+			folio = filemap_alloc_folio(alloc_gfp, order, policy);
 			if (!folio)
 				continue;
 
@@ -2029,7 +2030,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_clear_dropbehind(folio);
 	return folio;
 }
-EXPORT_SYMBOL(__filemap_get_folio);
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
-- 
2.43.0


