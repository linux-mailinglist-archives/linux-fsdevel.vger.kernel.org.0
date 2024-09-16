Return-Path: <linux-fsdevel+bounces-29517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A197A664
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575AB1F22D41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701F16A95B;
	Mon, 16 Sep 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QoxQZ1hH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7115B964;
	Mon, 16 Sep 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505928; cv=fail; b=SiQCfcbBO+Kvj70hrIMmYgoB86BkAKkJngouHjwFk4xB8+5f3qcvroNFNHoH4j7YTkiwFT5i2goaId+Q33FM1Mr1jhgVIgXBgMe5P22+MCqY+6wsVofLRDsmx6xmpwi+5YRhjJ1F2Tixhym1qlS9IEhdwRMDXzuGUt6Sq93dX3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505928; c=relaxed/simple;
	bh=Ch/3BXRIDwXuwvGggJHTLNf/PCWdMgQZ54sRU6QlWZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxdMGjX9YfDdn9kFycKMRyjFNUM+XSTd8V6E8pndbTHL8VqFxBP1RmELT+W8ZyKM/sXQmTLaVshN00qtJvH9RcTniPQ86/eBBD1xOlol+PUrAsVH79eq84qmN9g16V98o0JOAJf8vLx72o0PiMldS4LwOp8wNPtVOz1d8i6uDTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QoxQZ1hH; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5jIR95Kx2fG4Svhmo/jZ57vDaiWopGt1NRUJkPLZ1sr5b6OpvCqNr/b8CLLouCg6/Ngb0hKhGRQkiSXWwe0UFzWbpqitC4nHQwxmvvbeByxzrRP+FS4Ot6p4XD6P9+lfvlJefnGeGnquJ78iCNW4o95u3Xlgje7u+YDEjLEq0USwpyelgfggPN9PPY771lbLnTEcKz33L5GFinI1mlp+CkjODf4u6H+n8kmiDEjVa3VRk7ms1ev/BjBgwigcC65HD1lkXHz9gxg+/a8lk9pMMGlwBM/zGO+NkbsJ5PGbzZNVMsv4ZUs05RQNNqx718ilLeD+tX9ptC5z/XtcOlc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3TqfD3ymF6eqT4nlqJNmccBGoGKxBelhDPWPHnJ0q8=;
 b=zVJUD3LRylBHVZOH55tgjhN85vVulCoRXyuavhDntkWsEc8fo6yvE561c0aCcbjMkhXDawJAbeptmeXSzbOdIu+EW9hYrEUynwNWGFreUKqHm6JhUF53uW7xG5WEbR5K60exlvXW+K7aaf7p/+RZjDeftDKgfqUG5dQ94DUtOWBTyqitEGSRNEdodY8iWCS574kNKZsGVFNrIzL2aO54JtEFJalLLRGEKtbsL+BY4ybbAULwoN3PP1w2awqE//ygoEgHZu6t+i4pWIgTU/xHd5h2GCLo0GRKcJoJ4r28e2yWZGBnJ1jV677KZVZnm2RkB2uNuX9/owVQmf1QFXkCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3TqfD3ymF6eqT4nlqJNmccBGoGKxBelhDPWPHnJ0q8=;
 b=QoxQZ1hHyr14fQxR3BKCC715xWenv4az8sx9Mrzu2+etVof4p+8WXwI4VqWHS0/l4tvjQGubQJvwBJW5UTJjJH81sABWMYbXEgUIpnzXgNOYr0PqZCveenYyXsmahFspj1rAidfg0cunaKZl31ujzyrUgAKS+bJT2pBgwScFflg=
Received: from SA0PR11CA0114.namprd11.prod.outlook.com (2603:10b6:806:d1::29)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:58:40 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::40) by SA0PR11CA0114.outlook.office365.com
 (2603:10b6:806:d1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 16:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:58:39 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:58:32 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<shivansh.dhiman@amd.com>, <bharata@amd.com>, <nikunj@amd.com>
Subject: [PATCH RFC 3/3] KVM: guest_memfd: Enforce NUMA mempolicy if available
Date: Mon, 16 Sep 2024 16:57:43 +0000
Message-ID: <20240916165743.201087-4-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916165743.201087-1-shivankg@amd.com>
References: <20240916165743.201087-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f75e68-0ee6-488e-5b0f-08dcd670d051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+bwEEvAnMVEBX6U9xmGh4Fmg6LC4oZNUd5RW1KE4MImQuwJvVVQSmJStxXfb?=
 =?us-ascii?Q?MohnRy3/t1VO8Xcpk3Yaxrqyk3/FIKBISMYPjLVxVotgX73pFAReY+qKp/lR?=
 =?us-ascii?Q?PMbX8+g1t69fhT1ENYvWZXJrFuAJZFial2bSuH1GFWfmvdT6reG3l1r/8C86?=
 =?us-ascii?Q?beh4BpqRERejjZCAzmy76eh6jVf5JJY5OP5serfVMGlWDwskLYzPbb2pijQC?=
 =?us-ascii?Q?zyZjUfvqrZ/n4IUiVVvGLLCEZ3i5MgiwUf85ekM4mm9rSfLW0hBdstWQXTbU?=
 =?us-ascii?Q?Xv0UjIZw98ORE4sn+WWkhZGvgSYZMtvVQMAQIIrUvyfiZZWFub+q4ufUTtcy?=
 =?us-ascii?Q?N32ah2Aq3AUmt4OvhO9yrMvPLZ46IAoMdOECuKgLNlyjGm7xOMfjiA7yu9v8?=
 =?us-ascii?Q?XxDVzPPr1QtTyJQrDbLShEw3opunnNunwkKJPLOO0nsdJD4nPFOKyhnfSS1b?=
 =?us-ascii?Q?GUtHnoah7bteYw5Lf4VEUvo8GY9lXNwSSuEgUywBeR3SJF951SeAspf99ZwZ?=
 =?us-ascii?Q?Xs2xAh0jJg4Z8/B19pRtbFnemq338Swl1J4t/NMYsVOzvVZ0vYdOZG1oXikA?=
 =?us-ascii?Q?3pmAI85+FYwXiL5uqDbtOVsZpOEKNrepGr7n0kjnJMlZ9R/ugm/OGkfKJPr0?=
 =?us-ascii?Q?NzXDP4X5mIe81zSZxha+sAIhcMAuObmx17m/G3ofWcZr3+lKomLOT4XHDvqP?=
 =?us-ascii?Q?vE8SugY3F9CbUQld1T50ascSTyKCNUIjhfs4CTO/IhSRDgaCHqWyC0zozg7I?=
 =?us-ascii?Q?nmpp16cCuhLGJRi8obLqPt1GmR/DJ0J4AeJl2zui2xcAkf1OFdu2u2wZ6pZI?=
 =?us-ascii?Q?2IC/O3yyuAW1LVm91LSn8KQCsSDzVgpdREu/uWXQJ2sbuqMWEBttO/j3TWJX?=
 =?us-ascii?Q?uCtQ4/Yl9Gnqnl+WjQQC4duXcQpuQnftWPHqt7pZ1tfmrdAuRtrBG5r5Q+uQ?=
 =?us-ascii?Q?6yNzfTYLF0xTemHHzf2XvcwyOzi/UvOGKEUyu+WfyVCx5iV+Hbpl/B5zUaYG?=
 =?us-ascii?Q?Dz8sqQgN+25UB3krLmimbG1R8vvDskhXJfNBjx3epTwmG8DpayqXuGccKl0e?=
 =?us-ascii?Q?JDDYAvFxL7YPnD3d5v2+qr+6XL01qmAAqiofjIuByusr/h0fvTIOdhZj9Ekd?=
 =?us-ascii?Q?YEVEF95WlgeVsmruzVR05ZYmpRY+ryuAqaSzWGCCmnNe/ICdWHDK9vLUQXXV?=
 =?us-ascii?Q?/Rn+MHYGtpzWgLgp95OPAiVeS7cQ59UOHNzQ9m3URx+7psav6nX9bBm4k0WI?=
 =?us-ascii?Q?xNVfTXKtl1tadZpvMRkvS9+P778cE4NF4yzuQKdH4MScvoH+zHwlJ7tgA1az?=
 =?us-ascii?Q?2Jl1InxY6VnXjkITcGlcRpxSEC1L6ZtpX+4Gp5e0of2ipbDh6RWwTQyebuSz?=
 =?us-ascii?Q?6wYGPlM4NnhsFaffVjUEDbFYie95EVhCtKmjfpO4U0r8qXWsiMEViJAbZEqb?=
 =?us-ascii?Q?hzJCG1kDYfgUKguGmoa7RR/2DKZEydZb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:58:39.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f75e68-0ee6-488e-5b0f-08dcd670d051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Enforce memory policy on guest-memfd to provide proper NUMA support.
Previously, guest-memfd allocations were following local NUMA node id in
absence of process mempolicy, resulting in random memory allocation.
Moreover, it cannot use mbind() since memory isn't mapped to userspace.

To support NUMA policies, retrieve the mempolicy struct from
i_private_data part of memfd's inode. Use filemap_grab_folio_mpol() to
ensure that allocations follow the specified memory policy.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8f1877be4976..8553d7069ba8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -130,12 +130,15 @@ static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index,
 					  bool allow_huge)
 {
 	struct folio *folio = NULL;
+	struct mempolicy *mpol;
 
 	if (gmem_2m_enabled && allow_huge)
 		folio = kvm_gmem_get_huge_folio(inode, index, PMD_ORDER);
 
-	if (!folio)
-		folio = filemap_grab_folio(inode->i_mapping, index);
+	if (!folio) {
+		mpol = (struct mempolicy *)(inode->i_mapping->i_private_data);
+		folio = filemap_grab_folio_mpol(inode->i_mapping, index, mpol);
+	}
 
 	pr_debug("%s: allocate folio with PFN %lx order %d\n",
 		 __func__, folio_pfn(folio), folio_order(folio));
-- 
2.34.1


