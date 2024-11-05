Return-Path: <linux-fsdevel+bounces-33688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F49BD2EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54715282820
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837D71E0487;
	Tue,  5 Nov 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IlYPTqU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF71DB940;
	Tue,  5 Nov 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825769; cv=fail; b=Ed7roIIgoy7FlOZPeHwggkk9/EUyeR7emejrEOwyMBl7ZL/TGadLi+LdwOgGJo8s5KxXOiug/TlB6Q5/GjWaH+qM1dozDe8zgUlaXHBszeDvRP8GkvaP/6HkIaJrMMgrTnlajIs98klfJlzMkC6ZcyQgyI7ZnRNrbdj5kmaIPFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825769; c=relaxed/simple;
	bh=3Y7dbqZMLNQkzXBjWT6ZxlqF62JC7mysMVWrG3On7CA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8ERlRHpAxvW/pYN76+tqdqKCWcG/ZZ40dCG2l4axbMU+VsW3ALUzC+BQ52cWoa5xJ90a9TSuFtSNrkjo+Nk/tnxR6ltOdCDZYNE1nvOgxO79oBBytaw1/FktLOt2QYiQ4xApqzLvscegPlXd6eXHvg1PLP4ZxEDcT1tln/9OVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IlYPTqU0; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQNqx5rfkrm0xspFXiRFCw3B3iZ4DSgHhAoD9r1uvmo/wmeW1OFahr0qh6TljCoY6JSD/apke9ye4EDV30RmAE/PDE3T7hsMtUd7IIMPh40CIBISgx9XAqsC4muoHyLxDGquqdW9aljdvTTzYFGpI0amj8wYlf/N3CWLhi5evJ7kWKHLg8BtZamJcRAWB74ChKFQr9OhMQ4B2IJFiSUSTqe39ZidnbV0tKaYqxdNfZAeGc2wU/h78OxlgBrH6kQFQHu11ELf761liu3wPQe7BsrRqXDLxX6e9qrimlyrSjsBrlmkMF3SLyhx01BVO3NseOsHMHGawtOh1+zEeWYqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYWSF/gUUp6fJckNhr9t7F7Ukp+JcQngNTbbZJ1S7CI=;
 b=qHJb8CGziQ2aeXFgkWYT38mnMrZTSaWRsqM9W74sRPAF/pXhxh30oPlsGt4w/ig84f9SUCDoAg0eZ2i9jdCcXol7m56DC1LLcDOEsCEsBwT2Jt3UIJERbGf7A6SyH9nKKiyoFFVqDdRkOmMNNfBxMYyjzELa/7bcZ8sEXppqh+GO2+W1VwFlyeWKpKNNk+Jt06lz1fehbbF71Ign10QJxj2nQtbffdxeAAnJ3KpagagxzKqErjI+2dD9pzfuvsh5HxrJxWU5E6ODcfiIo0S0mCzsLoivAswb9aE3oZJaRziGYeuRrruCFY21IPY2/PPgRDzFTd/K/xq+bTo1Wn8hAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYWSF/gUUp6fJckNhr9t7F7Ukp+JcQngNTbbZJ1S7CI=;
 b=IlYPTqU0xLrL11gzMjByw9GvzskWtKb1K82/OcB11/CSOEbMDjGGT/pmq6hp/PE7Hko5A59NLzUuM4nelSBPToUnP1oiGm85KcOGCewyaAoblO4E4VGmNz/hX645zBSHGITq1yAKCO5B82hP8tqCRH3U1FieftDrUwFSc+am6i0=
Received: from CY5PR18CA0023.namprd18.prod.outlook.com (2603:10b6:930:5::19)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 5 Nov
 2024 16:56:05 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::4) by CY5PR18CA0023.outlook.office365.com
 (2603:10b6:930:5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 16:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 16:56:05 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 10:55:56 -0600
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
	<michael.day@amd.com>, <Neeraj.Upadhyay@amd.com>
Subject: [RFC PATCH 3/4] KVM: guest_memfd: Pass file pointer instead of inode in guest_memfd APIs
Date: Tue, 5 Nov 2024 16:55:14 +0000
Message-ID: <20241105165515.154941-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105165515.154941-1-shivankg@amd.com>
References: <20241105164549.154700-1-shivankg@amd.com>
 <20241105165515.154941-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 03792042-eef5-4eec-8dbb-08dcfdbabcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yWtUKC3+lYrQaPGckXHSaZZGA/1P/8AG+rQDXmYCIQtPHypCTizIy68gOl+/?=
 =?us-ascii?Q?Sb9lO/JWITKK+pF+mTPdawJhvfjh4yubbxp7r8J9nV3YbVPICO/2YbcSw2Qa?=
 =?us-ascii?Q?7fQFMwfcm9X/beYsr5VKQ04l4v1OlL7IuGbYy5V8CadVpzRD/D8qsRbm7fy4?=
 =?us-ascii?Q?nn/TE+9yoGZh+9afGtgpS8gsAaZyM6uYH6A6vnc/r1VcVMdqKmFgAVqQ4VVw?=
 =?us-ascii?Q?JEYO78PkQ77YDhNAtZUVrFVqKMG/b5mD+7uA6a5c1njDMfuz7U2yyEpwqayo?=
 =?us-ascii?Q?ltGlIow7czaqQERMsm23jh/w6pz9DUu522IA3QmJgVn14b1z9OKwnABQcJwN?=
 =?us-ascii?Q?SfnVs/+SHaarTKUcMxCVqZx2EcizXZ7De1UwVcz07i9wgBSQDcyRR/3gQSEX?=
 =?us-ascii?Q?DZOmVZFo4fQCF/IIexbUEehJNnkG6MBOV/MhF492Ld0ZyiAtHtQWKjDHsthv?=
 =?us-ascii?Q?RHk8c3OihnOVu3TlBygX7SwtNwiVywG++Y4moLigQGBwDUtKYAZ4PrGutzyM?=
 =?us-ascii?Q?rZalPhGiFRvdb+2fjIdhfQz+RFI3QBx7BlSsKaWQLpboZRMco7n5jZ4uyp/O?=
 =?us-ascii?Q?vRIMvOVTqNW9NWOrAWKnRzdQscWHQq2T2D9+3oEAGrSfSi8b6Rl0OLg6wH2/?=
 =?us-ascii?Q?Ab5gB8JE+NCjTc0cXeKU8DLjAOXnqucV/1dQ5QcYQhb0npRHiC76a5TL3CZt?=
 =?us-ascii?Q?7st+4blSDOH0qHkzBucsaJVyd+4rQkzI4s9xbkpFsZxqLKuWlycY2LaP/wJ1?=
 =?us-ascii?Q?YuGnSXEnP0VNDs/2pTF+XQydLyQlsCvksuEe5d47EMp/hGazFV+UR/RC+aap?=
 =?us-ascii?Q?d4KXKowCmEfFieXXthnWvLSbH1EDwuh22xUDujSGAstc8iA6W50fDbUlB+5L?=
 =?us-ascii?Q?332/NIEJeTDW11T4I+w6UOTwgFRZ7TxaqUQJ1AF81Nug6ohYFNSglTAsPqsE?=
 =?us-ascii?Q?5pj4n1LphboDkpeqP6wH3idhOCjewLTiaMwcsatDvaGOKzW6p1BqTrM10iEZ?=
 =?us-ascii?Q?6qL1wzbaI4Y87W40LaAQeKJHDhniw/KaN8PU3VgPmXlYePowTSx1992ijpOx?=
 =?us-ascii?Q?g2VSyZYk02ikhC5j37pGjSF/itfHuBlNBqwM8VQTzD6YLZGFkMYx52kvML7I?=
 =?us-ascii?Q?9i0x8DDCdiASdo7++ErLA8x5CIjGxSa3TdfuENqmOecemwokkA2bENRT6A+L?=
 =?us-ascii?Q?gJuey9mBptoHXGCAi5QJX2p1Ttkh781/WwCmvQ180MNcemEk7bLwPtj19kM/?=
 =?us-ascii?Q?/S6LL8W5Y8dTHFfsdgwYxCDlGyp1CFRXRmmCm7dJcR6opKqtODHrtOinU6C7?=
 =?us-ascii?Q?/QKI0d/eQG1P7A4EQbhR/Hl/IjTFFMsmhKiVzc8IUtJm1ORe03w56XA11Od6?=
 =?us-ascii?Q?7Moj57VgDxYKkc/IIoU1FrLzLWddb+WoYNKCERHfPL+SEcpq1g+2aGF5WjwP?=
 =?us-ascii?Q?m6cl3CpAK1I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:56:05.2586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03792042-eef5-4eec-8dbb-08dcfdbabcdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

Change the KVM guest_memfd APIs to pass file pointers instead of
inodes in the folio allocation functions. This is preparatory patch
for adding NUMA support to guest memory allocations.
The functional behavior remains unchanged.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e930014b4bdc..2c6fcf7c3ec9 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -91,7 +91,7 @@ static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index,
 {
 	pgoff_t npages = 1UL << order;
 	pgoff_t huge_index = round_down(index, npages);
-	struct address_space *mapping  = inode->i_mapping;
+	struct address_space *mapping = inode->i_mapping;
 	gfp_t gfp = mapping_gfp_mask(mapping) | __GFP_NOWARN;
 	loff_t size = i_size_read(inode);
 	struct folio *folio;
@@ -125,16 +125,16 @@ static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index,
  * Ignore accessed, referenced, and dirty flags.  The memory is
  * unevictable and there is no storage to write back to.
  */
-static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index,
+static struct folio *__kvm_gmem_get_folio(struct file *file, pgoff_t index,
 					  bool allow_huge)
 {
 	struct folio *folio = NULL;
 
 	if (gmem_2m_enabled && allow_huge)
-		folio = kvm_gmem_get_huge_folio(inode, index, PMD_ORDER);
+		folio = kvm_gmem_get_huge_folio(file_inode(file), index, PMD_ORDER);
 
 	if (!folio)
-		folio = filemap_grab_folio(inode->i_mapping, index);
+		folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
 
 	pr_debug("%s: allocate folio with PFN %lx order %d\n",
 		 __func__, folio_pfn(folio), folio_order(folio));
@@ -150,9 +150,9 @@ static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index,
  * Ignore accessed, referenced, and dirty flags.  The memory is
  * unevictable and there is no storage to write back to.
  */
-static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
+static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
 {
-	return __kvm_gmem_get_folio(inode, index, true);
+	return __kvm_gmem_get_folio(file, index, true);
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -228,8 +228,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	return 0;
 }
 
-static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
+static long kvm_gmem_allocate(struct file *file, loff_t offset, loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t start, index, end;
 	int r;
@@ -252,7 +253,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 			break;
 		}
 
-		folio = kvm_gmem_get_folio(inode, index);
+		folio = kvm_gmem_get_folio(file, index);
 		if (IS_ERR(folio)) {
 			r = PTR_ERR(folio);
 			break;
@@ -292,7 +293,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
 	else
-		ret = kvm_gmem_allocate(file_inode(file), offset, len);
+		ret = kvm_gmem_allocate(file, offset, len);
 
 	if (!ret)
 		file_modified(file);
@@ -626,7 +627,7 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 		return ERR_PTR(-EIO);
 	}
 
-	folio = __kvm_gmem_get_folio(file_inode(file), index, allow_huge);
+	folio = __kvm_gmem_get_folio(file, index, allow_huge);
 	if (IS_ERR(folio))
 		return folio;
 
-- 
2.34.1


