Return-Path: <linux-fsdevel+bounces-42057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756CA3BB5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6568E16C57D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45981DEFD6;
	Wed, 19 Feb 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tRaCNERl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4D1DED64;
	Wed, 19 Feb 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960201; cv=fail; b=txXpf5NMU0EfYR5MqSzRqpietLoJvhMCqjjyPioOVg/+ijRwEnW2SR90nb6wbUYEFPry5WwwF1NyX1UHoRbEZDPFMkVULeELyPSURRPc9MgAFDZwcFGsJfdH9kUHlSdm8L1XG2QrrFLKIpAwUOVpWm6hqUyvuqInbyeoZArhGAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960201; c=relaxed/simple;
	bh=6npcs4B35kyNQQjlQsV3Mp2h4UHBfNJb46PKtLiDmmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD/eg/EiPLItcCFPKATMySvNPXWDsYof4kCvNRUKr0Nq/Knhb33agmxJpdyRzrSywuZoARUYmUOTwLFCBWAFM+ogI8p7Gj22YuZKN7WGMb1SF6lAZSY2Tw+dAgWRLQcXCSlveihlDMdKcxdvkBka6o4lNvFXlHUekgz/OXWAPrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tRaCNERl; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZu4RMNBuUD6NwXXR9tLNji8/5/tdcPRiv9wd+Tt3G8o7O00OmsvKRnLYMoSF+QTZcUE+nxV2fT5spXs7CZOUVHp1GvbogGKqUrAIOLJZSddIxZnwMOJKdncokeCHPM15O7uHCyaAMmV2A8KXHs01fxAV6Aj+vOu/Wk4lsC1ap/yxTnOqiwCKgs7C0i48SBcJOxKGdyr3M0KV2d6p0cvUxUjRta4l2hVC22Q2cTNJ7Fft07XNSY8JbcXXoHC5vFVJxEz3Jjzvb38HYHbtinr+/Y7qkPYhRy5jroUfYNayN/+BHseTQLxB0IQpuOmSd52ZGSEVyrqTPABC2ZaR6Tcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WyTv0vp4UZ22UKY0LFCu3N2m2jNLLIInwMWjCShJ00=;
 b=lbbxSgO6LER6RbrQUY6sCI9gInJfA4IUGnqbVQSmqxyo3/DZC73uc7MM92Fy0DbdVIWAos12MJbEHPsRBlCch01r6lz8Ntfm+DvIRaNSLLbfcAmIZgpXUTGY9USk0x6NPYCYXqhs1tWuIpBf7E5HfaSYtTI3oGWlsqUYGTK1YuwlaCYCRRJAWXFEgRs1EnNvxkiFxVDdJUqE8A3lgmLVVWephMKu6Sqx8Ou8huGiYqhFTVrDAMYDqKEokuJNAUbwM5P8fR0QEDL6rAPkXpSuEakIt1yR9QE6o2YK3dZIdnKt58uoHp17E4pcR2XlFofk1K5VSmAo1YSAVL6dplI9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WyTv0vp4UZ22UKY0LFCu3N2m2jNLLIInwMWjCShJ00=;
 b=tRaCNERl6PJGFoz+AvDT2BG/FqlEYMlAQWGWGpw/pAnVmylMYZNNoPOjznpW59+ZfO8AYhoVGkokYhBZ54nz3InWS28mp/jNuyie3rLUxQiIGCRRVhbRzsbzmde+NriGo9Rj2wJKK/5bChwlE4jaVTM/h+XMmxw/qVxtAOveKb4=
Received: from DS0PR17CA0008.namprd17.prod.outlook.com (2603:10b6:8:191::15)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 10:16:36 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::6f) by DS0PR17CA0008.outlook.office365.com
 (2603:10b6:8:191::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Wed,
 19 Feb 2025 10:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:16:36 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:16:30 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v5 3/4] KVM: guest_memfd: Pass file pointer instead of inode pointer
Date: Wed, 19 Feb 2025 10:15:58 +0000
Message-ID: <20250219101559.414878-4-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d5f815-cbe4-45f7-9b35-08dd50ce7e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ls0u47DTMM5IsiIQhpqIAzQDRdsu5ndFmQNJnkyhjHXUDJrzASRi5WLkf/4p?=
 =?us-ascii?Q?SA7n5RAh4x6hiUxRL0J4PhB1rmCnocv8v3RfVQOf+sBHLClGS8bJErQvgz9M?=
 =?us-ascii?Q?4wz9OsOmuoHpodjY897XcuqBMLuBMXaCV92W3SHAo/SMb2bjIndq5hmRmmjR?=
 =?us-ascii?Q?DGAziFzwtPzhXtZEz2259Ykg825orpK++i1bhuGNtzOa5xy90bBEF3pjBAdm?=
 =?us-ascii?Q?RKhJRmAc7vMsFvxX6cS6e34VwrHP49NcqB9lURmj4b0zGaJ5tHbdDcwZqNQP?=
 =?us-ascii?Q?ouWuzqAnw6uMRyhJZtecZZg8A5FRgm1r8T8F13d/l2DxxYTt+mdNyRPa8YtK?=
 =?us-ascii?Q?mG61Xw9K2TWXstIDsUF9kxpj3nOiPpLm/2oM31pE/UlU2qaPPGIxP9OqplM7?=
 =?us-ascii?Q?EXPbyVxASV4gvrVRBPkFMmeCDC6//Bax04lcXUXR2dAQzUIPjqU8zO7kuBZt?=
 =?us-ascii?Q?jFBddxqMr4BfK+LHZZwVbNRK5Iw1lHHvaBALLt1g0z6p5/19hh4dnLRT3b+X?=
 =?us-ascii?Q?wOhNKcYTUs+pl6u5OP2Lqjmy8gxp3ktUe5c/Z2HrrRBZ1/P6/VqTOdlncgx/?=
 =?us-ascii?Q?Nl9sxScxKS+ZuHwpaXJrKbLgIrFvDubvRbnVkXDB1QN7HxpEc3OaR4obnyQC?=
 =?us-ascii?Q?dJp8L3xxa07vynS1UyU0XPLz0ZjW3ZFxzPA2MLxXNU0Rs4rFH6vZmpLDB9tp?=
 =?us-ascii?Q?PUSfPzN7iJcYxVYDdThVGZpilYDLGQt8FreT1yKu4fKAz1LCu1jmExyd8hQj?=
 =?us-ascii?Q?je5UYkZjqGIvXQIR7GnMCBaMzGyXbFMJYnUC+JiY+zB/yct0Bn+gvc95RM7U?=
 =?us-ascii?Q?Cl46kS9VJYRv+/gCwymXstZinD+g6rNRpUwO9z4EjFleoFVtiXt0jxx9ekDr?=
 =?us-ascii?Q?+W3ORzYG5RQ7SUdQrtTka/XEG1gnUiVdfzlW6zhMEvpSIClr9tILe/d5juQ+?=
 =?us-ascii?Q?Aa6CzHmxQmqHyM156lvMg22i1zVxNW/kyQMy7zkmYgYrrcoQB+miNRXGcQ5f?=
 =?us-ascii?Q?Zb6ZsuU6WgskU6j49Oq/Hzgz99m7HiwQ2vx1BIKw8uuhZ/OCDxu/rItczewp?=
 =?us-ascii?Q?JkvHZ6qZqmhCIsRvbxzlarJ5oBgNY7HnIdl0fzHZbACEo+Hi1dEALXv9GGtw?=
 =?us-ascii?Q?UsuAz49gD03vgNqZDX3bkdkpIkVQZLdDfebPQjoTnFT7KCcPvGEFRZ+u/189?=
 =?us-ascii?Q?U1ucDOIoIWV4pyvLOxRjttl7VLyl5UUlezeUOZz4m4MizIvO8HMskdhtrfmq?=
 =?us-ascii?Q?iVnU/S2dnlqGMNRM1MdVVWWsS9JgiKkJ4RzUaR+PVl7aA0luVXt5aBxvry0b?=
 =?us-ascii?Q?vH9Y3dNACmvuFKR84K5e5IHQfXMFx93j1eXKIS7YOndxEoqYj4iTQc3i5I88?=
 =?us-ascii?Q?YOifHklcql4Dvz3rIiz1D6FvxuRqi2EW4bzwmcqmNATdhu6SHEmlLHysEx6/?=
 =?us-ascii?Q?zDLebEX32ii2y8fhAgjyCbTx5dXHiEnfK061Y4MOqRkLVFSIMKIN175n8oaJ?=
 =?us-ascii?Q?h5PjjSBcHl331Mo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:16:36.3519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d5f815-cbe4-45f7-9b35-08dd50ce7e08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

Pass file pointer instead of inode pointer to access struct kvm_gmem stored
in file->private_data. This change is needed to access NUMA policy when
allocating memory for guest_memfd, which will be added in a following
patch.

The following functions are modified to use file pointers:
- kvm_gmem_get_folio()
- kvm_gmem_allocate()

Preparatory patch and no functional changes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b2aa6bf24d3a..f18176976ae3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -96,10 +96,10 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
  * Ignore accessed, referenced, and dirty flags.  The memory is
  * unevictable and there is no storage to write back to.
  */
-static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
+static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
 {
 	/* TODO: Support huge pages. */
-	return filemap_grab_folio(inode->i_mapping, index);
+	return filemap_grab_folio(file_inode(file)->i_mapping, index);
 }
 
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -177,8 +177,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	return 0;
 }
 
-static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
+static long kvm_gmem_allocate(struct file *file, loff_t offset, loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t start, index, end;
 	int r;
@@ -201,7 +202,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 			break;
 		}
 
-		folio = kvm_gmem_get_folio(inode, index);
+		folio = kvm_gmem_get_folio(file, index);
 		if (IS_ERR(folio)) {
 			r = PTR_ERR(folio);
 			break;
@@ -241,7 +242,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
 	else
-		ret = kvm_gmem_allocate(file_inode(file), offset, len);
+		ret = kvm_gmem_allocate(file, offset, len);
 
 	if (!ret)
 		file_modified(file);
@@ -585,7 +586,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 		return ERR_PTR(-EIO);
 	}
 
-	folio = kvm_gmem_get_folio(file_inode(file), index);
+	folio = kvm_gmem_get_folio(file, index);
 	if (IS_ERR(folio))
 		return folio;
 
-- 
2.34.1


