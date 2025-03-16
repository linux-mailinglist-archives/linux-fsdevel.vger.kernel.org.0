Return-Path: <linux-fsdevel+bounces-44133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F7A633D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D559189340A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E71632D7;
	Sun, 16 Mar 2025 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QL60k9+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB4157E99;
	Sun, 16 Mar 2025 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099402; cv=fail; b=icPLVWOrTABgQ7Q+gqCC8sZ6lRmMwF7rBCMoO9QTiAtUSTg1ddl+/k+XYRncZmqhC6aLG2FKGTRgo04KzVnhalrtF8XuqEioEwXYMfHwnjNXvTfJuGuDs33wwwPMUejQa9677IIVYErJvlRAuMtapOjnjh+Js96S1MVXet24tEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099402; c=relaxed/simple;
	bh=RyktOYllRQevqYzn3YSmJCjzDmyhkJbpRJjagF8zVyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+gc2qQmdXOGaDfMxPPf1g0GpF5TsoVE6aBRe7IHtgfZHp/ryd3c+bQ2p8uQdysIqfSNaCdcP8UGZ1JHAhLc1v4En0wlow6Zz39Xb9/Kq0/8VHQkJKTCWj/7nRxS1E+MZJ6IaHEICW4yyiGirzed9ZoPXN2c/P6sAKZtC3wcfk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QL60k9+r; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGh24G6RYQs98F4XBluPLZkuU/UsPv/DhEPlpQ/eSj3WgVqSEP8hbCkS/mL5/7AAa9y4ciirftBruTcUFbjwjmDJW70OrNNtawH0SZiBoGtadAwaCOmugskjVLeHiZEFisFNmM2Hgp8tPWuj51XnvcqGCw/lT23SI0tahU7pzPwQWUBeG/Fc2fPPA6d1X71AZEVYofE5pg5vPvPgSp5PCg+o+SHtkcDcQi1ACtPXGq2sptPvRB8YcMTSRZcZp8GhedezYTpH8hHhgKP/jcEV90G6baFya3HKFUBayVh631hIOFvr81tOB15C89NFhWNSUaM7bq51CLv0qeLKn9ZzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdENcUd4EUUfm/VFpPMJTnHakQTHxg72+suy6RP57ZM=;
 b=nRuNuaC1C1O1rvlbT2+TSSNTP6OnWefk3Itv5KbEQzMDYDzrRsMYlo44gDhaWW1HkSLbU8mESFP2+klmMbQ475RrB4vv7oXXB+3/GVX7TbwyKfm7zwDK9wA33ONNuVjPNT82NkRQwfZ8u5sxx50qVo2l7GRBUjpjWaZuOSs0321+KRAVQk2/JidLvGJvw8s7OtxvKtSCKXraRX2D/eOlWe6mZJg6jTbKWuouEMU+6tCJwXUO8rTDWTqFgnEGnc3T9mncNoG5ShknxJBZKIyrZvJ/mHg/Ox2AZsos5kppd/B77cDAq6wdhmj5PCmh2K2FZoEQPkVjoJBjiTQlZBmYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdENcUd4EUUfm/VFpPMJTnHakQTHxg72+suy6RP57ZM=;
 b=QL60k9+rXdwzTX58x0TqrMmKHMXcTPGt3ZeWkCDjhLQmilxQxVenXGGfcpnFlDExsGJiGV/rCtk0GlZw82LXMj2+Gu57GDw/nBs0SfRBeuDZrTlcth3Yiq8SneM38bL8oDUqaJBj7lWIAozSZOcuELHIC+o+xfMA1v8MXHLKUAQpJVv2PtjztRy+YkWwPTj4lMW+1gESTNAhy0y7e9RJ+CZW0B27dqpmDKNb4QCbgXIT6qvuTey1sy/UNgW/C59OoX7jvg7QOXdLd1GxBsw+TXN9JH4oY6LHoKIkhEPoX5GxwzfCmTCKFxFvaK0zw8KtstQie2iEoSWFAdMZqqBHTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 04:29:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 04:29:58 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC 2/6] mm/migrate: Support file-backed pages with migrate_vma
Date: Sun, 16 Mar 2025 15:29:25 +1100
Message-ID: <1371381f755a8f04a8228e52c36ddfde72949b57.1742099301.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0066.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: cc247eb4-1830-4a2e-451c-08dd64433574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6TZKyWZM2wzwaReLO1Da+cIoN+JaPmlehwmYggKo3hDRXALd7VCcmTqEO/oG?=
 =?us-ascii?Q?Ns22aodYK2tNBM7Ipy9znjbn1chtmRJy5uxmYqYxPTUSg9GzqHXkTpyACE6k?=
 =?us-ascii?Q?UhIxKzLHxBVQcogS5NIjUnclDN5PnnfNN6MEiv67BJ/CT6jQuhPDAB9XaaER?=
 =?us-ascii?Q?9aVjFbdmYVm4CgtBr6eUaKL3vYvlyL4wXA/361QJpAbnB31fq3xatMos1Ard?=
 =?us-ascii?Q?pIVB27SZFifA6E48/w5kBIE4QjAq1/OyvLswFOQ7r4vpsuVfug49/TGhF+kx?=
 =?us-ascii?Q?rmapao/zLjaCA0JhCpFC8i57MfSqFEaiOHjRZotuHoe/xx5TmBWx67T406Tj?=
 =?us-ascii?Q?arxvG2OSDezPo96OCkvytYXsQVRzFe5y1IBAc+HQ2M+TRHIJYqBdS88ZA4it?=
 =?us-ascii?Q?4tph4cFKYrLMPVcZvGqSGsiaBvfxLhqCHG5IekH8jIopCsj61PqBU1Q3x/hn?=
 =?us-ascii?Q?SaKf1dNq/xw10vAqgxNhdQmJHfvwir1jJrIVZB7WnDdKlqmMongwlhCYyusq?=
 =?us-ascii?Q?ON1AJ5ARxYoKeAD4X5BOS0W2pcj0fI9qV3Ie3QiDAbYIrhvR/llwlEbAV85I?=
 =?us-ascii?Q?jHePkYBqMN2oPWkLWkfZ6MdShZ89QiFH3uhUZ2F3bflIAbANajhNx00MjeuA?=
 =?us-ascii?Q?ReNYAbn2sFCYTSIZS5h6VrRYiCIernmKGX4tawzv8Bz4Tp+rp44U91MMuSS6?=
 =?us-ascii?Q?9xz8V8v+UnuVMXUEv14c00io6jyNv5yn2ru/MxRbQCxTSq7weVnV71lH1pfa?=
 =?us-ascii?Q?H9CU07b1Xu1wiD4P5zCXc5CaOThVBgKn7rZqWq6wiqU5As5U27GN66JwfpE/?=
 =?us-ascii?Q?9njt6c4W1bNQ1+g4vTLz0ywvyoUvdE9FW/cFJQL7Ybi5s2gInvbg1B0DyeDC?=
 =?us-ascii?Q?QTri3HrCO0ehOP3We+nowlq+PMnnQgPCfJUkeQ+kGUe0dCnrrQG1fYILHb4m?=
 =?us-ascii?Q?TMUbXwEmBvQAxpNnQP4Fgrda0AFwl8daA0+Cu4omfethSYvWLVhckj405Q3G?=
 =?us-ascii?Q?WdNjW27h5ZEfeiyiwmmiNGjUdwAAFhqTopP3V5e0YPZ2eg3PxmLt5CedSOiv?=
 =?us-ascii?Q?CkKWQDQGyg4Dpv40s5wzJtfTsK+aZYzvsvKtkKGrWxeLTkDAT/F8UjM79XEP?=
 =?us-ascii?Q?diyDm7CMFUCrIw4lpuzoF9qt/DaAtXKkrICJqYjQ9jfc9HdCut46bAiEdqW9?=
 =?us-ascii?Q?FZ/7JljQND029XwCrEw8vjeo9niOS6jJ4JM/y45xxO4oHt6KxTHADyCsysNS?=
 =?us-ascii?Q?74ybJBS2ZM2Xj88NtjfJHgyGHWWrAzFS+ZCClw2sGhKLETFQuh0N+pU4PmPL?=
 =?us-ascii?Q?r0cW3+IwT6Fy1F051nNTU/BWlc67gCHjdS+lIRGjmZHwaD0YDHBO6VwTNBTO?=
 =?us-ascii?Q?+fBR2By+3onCNzKiTyyCyzLwc6wK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lP9udXUJYc8WHB6jgoDTg1HNSzWfNpNeGsQ67SZSqVLqHcZlAlyQ1C2Gf/UM?=
 =?us-ascii?Q?7GMLZEjZOglcOEZHwDE9PPvIlPfguK4U0/QEdu90e8/5xZFwaYrzkxg1qEy1?=
 =?us-ascii?Q?jq3T6IFsNrCPTG15zvgGwlZKJw28aQ9UhZRy9n+eMiry1ba+esvjxenXAmYZ?=
 =?us-ascii?Q?TOl/l0fxxM2rbsPCAGEmT0+ttgCgThDWoe6L+TVj6Fc/sSLY7rzNUV/LVDEv?=
 =?us-ascii?Q?485pni59M9rpVTXK/K5waK1qy2eLN+gHEcFfpWvRVwKdBC5569o9oGUFNzYa?=
 =?us-ascii?Q?Yl0BPQFVt4MwyLOTftALZNOgmzeYJIuntDd9Maa753Wpoaupn+fPIU1H1Vta?=
 =?us-ascii?Q?WUVsj2n51SWsI9cYkson2kj3+wItJlhWEtTbMzZgcHNql+1ShPwPGpYbxyIW?=
 =?us-ascii?Q?baROz9vSJcOmDoJuo7hd2zBi7N78fr9eLX5jNxOPiFS/AaQIv6df6slMNMdU?=
 =?us-ascii?Q?+/jANIaRBRPDqWiJkRUekoPQLpgylYP+UxMvDsi61B31SbqdKNXypcFm9AX8?=
 =?us-ascii?Q?KF7vSpnywH9td/Z11/bf+CSDm9Cdc6LKpuiFFfLZz6cjnrvPw36KKumzYVJo?=
 =?us-ascii?Q?ZLoaLj0GkdXNt5bAkCd2UF6B7WtXfqOZyGs3IMUNrI6jM9rhQvAVE16/jJZc?=
 =?us-ascii?Q?TSshbtI5Srj4eiKzmMiZmiqjfzE+PHyrMyL53zAkiBV7XLW5x6eQ+cEHEXkQ?=
 =?us-ascii?Q?Pb/pUjA8JvXw2y//gsnwsUuZLAollwttSZpresRhmmVDLaW8f/p0u5Uuu4aQ?=
 =?us-ascii?Q?+M4PQXQMeBf2zhitOfTpTBSKGCwnaMC1GtzPFiU3m9VQ60zVfNLn/xnZet6Q?=
 =?us-ascii?Q?t2//DUiXpjWt+Hbz+NMPED7eKK/R4xNKYRsgpCfnl0o3eaFWqR+Kiyon3tCT?=
 =?us-ascii?Q?HWeGTqjipPndtEmpUUmfuB18FZ29+pYt35ilfTPDA8MxWZoeMw/v7CDM6ZHI?=
 =?us-ascii?Q?An4WWz9Mwf+TbNEdr2yuTXRl6+KOY8bg+QrzzFKyQihFNe1fo/6LR38AixOn?=
 =?us-ascii?Q?K9AYb1eAaXmX3HAnz74oKGDRxREE27QZJu4cT3DEF/I204Flrpim1ZGkuRU2?=
 =?us-ascii?Q?Qlt/nQ+5dRRievwekV2cYeO7P1PeZTtASpPhmG8qrHQ6jj6JD/2OM6YzxYjC?=
 =?us-ascii?Q?tqddmW5CpMc0McKo83FMOi34TqY67yllL205e34oLCWMMtk0jSPs3o/w0tJ1?=
 =?us-ascii?Q?u2o74lrmRTzt0sbYr8MnhuZasNvL2vTT1vj9KioEuli3PczAickMXEtHYyYF?=
 =?us-ascii?Q?WV02sgmlRmN7nU7GngiuTJRsaYVhg/az5AVUOd5uFc6IR4iojKiH+jlGmtCe?=
 =?us-ascii?Q?bbmKExmDFuSDO3V+0dQhjKHNKsSBx3+Pti0BpqNyCXQOBtVpfoQay9FCnq8h?=
 =?us-ascii?Q?tbyKwE34GcXa7Ve3gRIXaGRkKJlETlnZg45aORkAfls8//JHaqpDtF20Cynx?=
 =?us-ascii?Q?AFAzBldK5MgmK39ZoSB+om5w17h3LcODC0i4wVW631vuDuWKbe7DRhqcdpP8?=
 =?us-ascii?Q?mjRfiQeqjBMWefrCPqyvNwGa/X6pMYWJeJadRWI/SothIAHp0KCBiJzh8PnT?=
 =?us-ascii?Q?v4iJIMskHvhUqwigwZfwYEBbAOgH5y+9Cph23deg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc247eb4-1830-4a2e-451c-08dd64433574
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 04:29:58.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8eHt9mRyL037xuZemLULfTsA3ulReyRYa/9f1ylnj4ITYkiOUIkfjYDFbZAAxtANMiPSx1iXB1/zNtdKkBHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

This adds support for migrating file backed pages with the migrate_vma
calls. Note that this does not support migrating file backed pages
to device private pages, only CPU addressable memory. However add the
extra refcount argument to support faulting on device privatge pages
in future.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Known issues with the RFC:

 - Some filesystems (eg. xfs, nfs) can insert higher order compound
   pages in the pagecache. Migration will fail for such pages.
---
 include/linux/migrate.h |  4 ++++
 mm/migrate.c            | 19 +++++++++++--------
 mm/migrate_device.c     | 11 +++++++++--
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919fa..9023d0f 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -222,6 +222,10 @@ struct migrate_vma {
 	struct page		*fault_page;
 };
 
+int fallback_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode,
+		int extra_count);
+
 int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18..11fca43 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -749,9 +749,10 @@ EXPORT_SYMBOL(folio_migrate_flags);
 
 static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 			   struct folio *src, void *src_private,
-			   enum migrate_mode mode)
+			   enum migrate_mode mode, int extra_count)
 {
-	int rc, expected_count = folio_expected_refs(mapping, src);
+	int rc;
+	int expected_count = folio_expected_refs(mapping, src) + extra_count;
 
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
@@ -788,7 +789,7 @@ int migrate_folio(struct address_space *mapping, struct folio *dst,
 		  struct folio *src, enum migrate_mode mode)
 {
 	BUG_ON(folio_test_writeback(src));	/* Writeback must be complete */
-	return __migrate_folio(mapping, dst, src, NULL, mode);
+	return __migrate_folio(mapping, dst, src, NULL, mode, 0);
 }
 EXPORT_SYMBOL(migrate_folio);
 
@@ -942,7 +943,8 @@ EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
 int filemap_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	return __migrate_folio(mapping, dst, src, folio_get_private(src), mode);
+	return __migrate_folio(mapping, dst, src,
+			folio_get_private(src), mode, 0);
 }
 EXPORT_SYMBOL_GPL(filemap_migrate_folio);
 
@@ -990,8 +992,9 @@ static int writeout(struct address_space *mapping, struct folio *folio)
 /*
  * Default handling if a filesystem does not provide a migration function.
  */
-static int fallback_migrate_folio(struct address_space *mapping,
-		struct folio *dst, struct folio *src, enum migrate_mode mode)
+int fallback_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode,
+		int extra_count)
 {
 	if (folio_test_dirty(src)) {
 		/* Only writeback folios in full synchronous migration */
@@ -1011,7 +1014,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
 	if (!filemap_release_folio(src, GFP_KERNEL))
 		return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
 
-	return migrate_folio(mapping, dst, src, mode);
+	return __migrate_folio(mapping, dst, src, NULL, mode, extra_count);
 }
 
 /*
@@ -1052,7 +1055,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			rc = mapping->a_ops->migrate_folio(mapping, dst, src,
 								mode);
 		else
-			rc = fallback_migrate_folio(mapping, dst, src, mode);
+			rc = fallback_migrate_folio(mapping, dst, src, mode, 0);
 	} else {
 		const struct movable_operations *mops;
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index afc033b..7bcc177 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -763,11 +763,18 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 		if (migrate && migrate->fault_page == page)
 			extra_cnt = 1;
-		r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
+		if (mapping)
+			r = fallback_migrate_folio(mapping, newfolio, folio,
+						MIGRATE_SYNC, extra_cnt);
+		else
+			r = folio_migrate_mapping(mapping, newfolio, folio,
+						extra_cnt);
 		if (r != MIGRATEPAGE_SUCCESS)
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
-		else
+		else if (!mapping)
 			folio_migrate_flags(newfolio, folio);
+		else
+			folio->mapping = NULL;
 	}
 
 	if (notified)
-- 
git-series 0.9.1

