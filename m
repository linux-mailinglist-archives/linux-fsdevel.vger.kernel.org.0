Return-Path: <linux-fsdevel+bounces-42643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36661A4581F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4C37A3492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D4226CE5;
	Wed, 26 Feb 2025 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgGaffP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD11E1E06;
	Wed, 26 Feb 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558486; cv=fail; b=XB34oMZRR5ZCXZ8fz2TWKHN12ar0ZyvDBiiuSnnigSxjVz8pc706SVyROTN1/LSPJoijZCYm4fxVNPqq9nRdiQLJytGmB+zLbaPbc8NVyK1hK/7w+m5xDpVuoBnK9gwb51UoRBHDgw7rTxZABLe0FDpgF0cFHRaSxTSzeLv1HPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558486; c=relaxed/simple;
	bh=6npcs4B35kyNQQjlQsV3Mp2h4UHBfNJb46PKtLiDmmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tm3AhWvAJrzTrvVGT5rxUOBcrI9VEUE6P6XwZb25hlH0eC4hPmOAw2WVBUd14fe44OFz84UOYHs17wD9Kuyi08V4I9zLuZLdWS8HBTXohjm74bAxOncKQ77u1aNffXjc/Se9FZfYZE1KCOw7G/9wCCeuclYkEZDIPDK6DxRr5ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cgGaffP1; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlnKg4aE+C99Q6rbMQ6CpREBlOxbxy2P1jKuIP3mMmK19n6t4mJaVghn55A831N8z60Kra3BsUAWfyAPwxSNv5cLN35Om9MtEEgQLofv6E0r5rS7xKkbkhidFL0BokDRySUxid9lVM3V6wP556Cw1M7TsbIw/9Oa1rUBtIslfxFa+cM8KtH4ioenOsyoTQjNXJsGpQpEJphSrGwWmyNHiW6hIksfXvWffUMGndeAD7xD/rqgAY4x+qdh0PgMu5I6/PyIDHdNbLUv8/ieTgp7lpJQbCGnmkf3hsjGjYD8LF6vxXfINI6phuiBLbFHUdDqpa5UMPyxQyE7DTmrpoIRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WyTv0vp4UZ22UKY0LFCu3N2m2jNLLIInwMWjCShJ00=;
 b=mBYD2V5s5JUMq+UfpQpRzVRBhbdGUM7+MB9u73AoyXZ/Jj6EkPeqgvISkErvWhHq82xMxLLabBQU5LEaEa5NA3Kj0sY2gNJVk1Oq055iuclPaCUSEGmSel1Rm8VfdAjN/YNhxfWfSuTByQ56Ta52Hg1r0xZIC+MNiq9c1AKTykSJgJiNi2I0y4vomdJamkd35dwbPpjWI2+g41WO6IlouDyvNtiw4mmvg4H5M2MXlrjYyPl5Orw4/2e50EODmcrQSIWkSFWZ9Uca5wasJ8bMAIgkHjWU3QckVuB2V2ou7QTNyg1ORPjPLvyy+FOFZIsbcJYBN8g/8MPPdNYd9ZP66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WyTv0vp4UZ22UKY0LFCu3N2m2jNLLIInwMWjCShJ00=;
 b=cgGaffP1T7yFmctWa6TRZzVlzZqCbBgK4Oc1JEzJTNmqSRHvZa+2VVky1HKSiSDltVbWPJNNzK9wPl5lTM30Pknb0Wmj9+BnhVyhBEOMt78NpUl30NhQh3PdiEqbcDX6BjWkw52AMnOURqM6lAavZcVl4fmSu5aK6Eg/YcAi4O0=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 08:28:00 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:8b:cafe::73) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 08:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:27:59 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:27:52 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>, <tabba@google.com>
Subject: [PATCH v6 3/5] KVM: guest_memfd: Pass file pointer instead of inode pointer
Date: Wed, 26 Feb 2025 08:25:47 +0000
Message-ID: <20250226082549.6034-4-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1fa95a-32fd-4440-18ba-08dd563f7a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OSGqGahFyD0sT0ar6t/pUaeyW9elVLCAGqI6U7Tk0IWjFb3PP1pjbX/DsR1N?=
 =?us-ascii?Q?sQUbSx6DpX5H/LQ76FL+3fW5MVjd6oOqqYY+8gKHYGp/YKYgdtq203GfDw2L?=
 =?us-ascii?Q?hZt7h6uYNJWLgFYzIz4gpe2ChCP1qT8WazA/C+EYmKIIjaq2AEoF68ZuK5Bd?=
 =?us-ascii?Q?aQNo6tDJyh//AnSDrcm49u5jsvv2LfnG66V/8IXGghGqHzKR8vR/hioo+pzN?=
 =?us-ascii?Q?DSrGgbEmyMCPcm1oBmwYB0I6ilP/bT+7XQKzE7cMrJTDFeMwbycQWlk/TsRV?=
 =?us-ascii?Q?f9diPeX0NaNQXypaVAms9JuNZSlWc2fRI+OWB/lM+6prLq5mWNTd5oxDYsR1?=
 =?us-ascii?Q?WeX1T1mUhXXhuNrWR0WT+cqsrrJwL+98xgAj25Zz6A9AitrItU4G8UMjyzqn?=
 =?us-ascii?Q?BcNSyGf2TdWyK6+0wiUsr1Ccmg1FcVOrvpcM2TgbM7s1GLT7wnLnjemDZ4mo?=
 =?us-ascii?Q?P/0QT6zaGiMqLpKuSUpfjabnZhs9N8QL/aZho1WhRVUK0yff8xlmpCu8WgQM?=
 =?us-ascii?Q?mEC9YqY57FrAG7vZ7YD38wxlGVvDdk63mZGnnC6NOtlwo+MaLrZBXG2d+mom?=
 =?us-ascii?Q?bHSqvssy+CVuFTx2GsZk+d6vW+75JNSujLoZmZwz4/bEU6pyfSzhX7EjD9AL?=
 =?us-ascii?Q?fKFRcxhSurqkfAbLJVRi9SuFpRyyCpIY3JTiD4vuMDBTOAf74882bTDMUcoq?=
 =?us-ascii?Q?yZ+3f/Iuan1fDRtDZfjSiZPPGVsOOOLnY0TdrTzcA7RZ8T7It5RL/gBdSfPP?=
 =?us-ascii?Q?OelejOQp9qQLIr+M0O7vFPpGTTV7fMBO3aCqyPNrT7Q6R5qoyKqaACq2GLif?=
 =?us-ascii?Q?EH9W0Lz80HC/bDLSHZae1eyMY1YNwPoolcU+3EbahXV+JyUArjNjBzLmkoVP?=
 =?us-ascii?Q?fw8FP3DtEZIgDiKT2uHrFg/7taDbtB0Wd6dZUT5R97bFb7rfjnK9748POCrE?=
 =?us-ascii?Q?X8LXcSn0S9vzsdG/haoc3lFqcXDSbCT53pf/uacf12akTqjQIa4RPwzOpHiQ?=
 =?us-ascii?Q?0tGGmKevCXpQOJ+Q9iKk+dxS4ubFHrsLaBdiHgKe11LaCnqva4mpPQ++pwlr?=
 =?us-ascii?Q?hifDmT8NkNtBPdwMFbSzSh2pPtjs8lopb+JJRzL5oZbrjC5p2AeufOtA8c41?=
 =?us-ascii?Q?pChjODlidrFkxYtFBOmb+OVcG08MfBuHoA1xBkdcg0n6aAgp3s4HjSeMXmr4?=
 =?us-ascii?Q?oLUxG+sxRgHk5pj+2HTMg2nRneswKahkhqif+BOfQagUP7Sq7y9aVIrpAh6u?=
 =?us-ascii?Q?66yu3smRcwCxf/fKR3n9IC30pOjCSfQm1iOvExCHf5DeOMhavRfm/eLH7Oa+?=
 =?us-ascii?Q?ZQJ4Nf24B0rlslQfeOjd3thy/b7nri3hYZsdCVON7/zKARKA+Iq1KAbzn69k?=
 =?us-ascii?Q?Mit1XlEBas16cJiySOLFmfB0yDXY5ic4y7LkODNCRqEGobmJfT5V7Tc9W2Lw?=
 =?us-ascii?Q?86D6ufsTqeLBGW1nAshDaZXu0rJevVa4lBI5+MCixfY7A5wamU/I1cs1KE86?=
 =?us-ascii?Q?QUj4Ee/K3x0Oyyw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:27:59.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1fa95a-32fd-4440-18ba-08dd563f7a5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

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


