Return-Path: <linux-fsdevel+bounces-389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C447CA701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A653D1C20AC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF4262A8;
	Mon, 16 Oct 2023 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QyYLeFe5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73626298
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:52:31 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF8FF3;
	Mon, 16 Oct 2023 04:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqMl//xKByAMUfcftWj5ijZuA8tG81tcR0aYqJzySZPs24fk0mw+2kIZiOswgnjSnj8eFvxqn+jpp0OC4JXxSbfa/rkVdRn98WE/wIXJzkS5X5i2gB8ByZ/gfcoKtTJK5ZsF0Jero8936U0lY7GnJRMc3FkBHM3+v523PuHTQItYkSdQzB3x6HXWz5C595pM9nDopC3ifykFYLp2mR8JghTt4xvy4YCIuPBjZqVgxhBWbo5EY9OcvDV0+IF9QY/8zCSgqkVSXIRNK5BBJXKKY4eN4FVqkcsWOEf8KcWqbsarAcORq/+YMzjIyGw4u+JyrnhNU+Ds9UlnGu6Pxga3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9F4dMH6wTBPjd0LQYAclw+pyXgphEr5kdLSN2lHbR4=;
 b=CR9vgVtOlY/IuaF3ws2/RHrBPxh7/UU2WPcKbgqb2ZVz3/hk5oJFlRmOLlnzC97tolV4jMXl6DBxEGS934C8GZFKdVNrKvQp0Jx4zAJfhxj1nV3I6tkimH4xJmfDgyXtIRQBnX6iloC+3LDNEQeY1JHf1vRDe000OBpIIT4mDp9vNXEDYDkfPMFCqDefIbPDON8T9lVCeX5S+G0wKcXnk3PEvRKnxft7dlnWGrLruNRAlfmyUD/Za6WFwFkgCh0qNTjVbqV+2/FOnjn4J15+pv0X3ANdNWGP25F/7LBgolQ6OWrxxMUyXZSRtS3OPkgSqi5yJQ+T8RQIQtzUMpfXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9F4dMH6wTBPjd0LQYAclw+pyXgphEr5kdLSN2lHbR4=;
 b=QyYLeFe5cToOPhzUBURBpyqocN3BXbLUa2iqtGiepPsd5PLVesWJFivq9X0AsHK7YXLzZ7aD3NUFzAvqmPjur/C5YRWqf61f4mUSPaVSFNy/tHC24mkIoVEH53pWeeguSbuMvvX3Dm0letQwaioWIrHzf7gunaO9IsZz5KhHcmc=
Received: from SN6PR04CA0100.namprd04.prod.outlook.com (2603:10b6:805:f2::41)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:52:25 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::86) by SN6PR04CA0100.outlook.office365.com
 (2603:10b6:805:f2::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:52:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:52:24 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: [PATCH RFC gmem v1 2/8] KVM: Use AS_INACCESSIBLE when creating guest_memfd inode
Date: Mon, 16 Oct 2023 06:50:22 -0500
Message-ID: <20231016115028.996656-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016115028.996656-1-michael.roth@amd.com>
References: <20231016115028.996656-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6f675d-ba53-4dbe-7d4b-08dbce3e5d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uoav+3Enfcy5yEECewIFnLCUzdeDnNqgY21IFHnAaXjtD9TQoipvpYi1F4Mk3NdLivfOqHUZ5m6ETCKVSd61VMsDPkocOK1oj28wIqs2vqC/XHzxyKYbB/aRrEhI2gjcp198swPDqhoKK5h0hjONdG1BRiV4+rrE+O6UDGNoQ9tvXxnEOlBzOGkezlBRgoKX8GiMTsGV4iTEX6/jS8nmPCZnXPfQiSAydRV26VeJ2j5pqtInGfFuQqHySH8jzjuAflzgr3sKTL6FyIwAGW65sQls2UJRAuTUBaVcq1OcxfW3h9p8dFLqyvxW1K/vnkK6GyOdW4oXuyPQU4ZE9OYc4H7Tn7LnzKOJTni2ZhSWaCtSrPvT4n64wxB0jGORQKZ2Mx1/9H9NI+BONb96F40YsXUvqo/eXjLiEkvYbAyRSJPKe+QnGQvMwOGAQa8bV6gDNSdQyGQDcjhep8ymrz0AFdLxSV8XX89TSoIAiuS7T8ylO91GhTu8shAYSrhzzmiDDWTPuj+q2ThjbVdtIoCNQv0yvNjT9XfYS/tF+044Mln2gaQWvD+Ves2UinLVFMgrkU3hwB9bp8AbCvkLKzNuI0Af4SPwuYNZlyWmfm4wY0IfdypASU22FRFPGHU56aKDwqodP4fIiD6l7htNFtgJaK0ZPEnmoCf3UPrEBHvpZnglMC4dwvtgAsfz4ZOPqS/K6GCCV3jsG7ZilysUJpXGIYwWmAqv4NP/jwMd9dG6UR8pgSzrkQUYfeA0WTBWMeIawx5qWlTj70IZUwfNEBliZw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(5660300002)(44832011)(40460700003)(2906002)(1076003)(26005)(36756003)(2616005)(426003)(336012)(83380400001)(16526019)(82740400003)(356005)(81166007)(86362001)(36860700001)(47076005)(7416002)(966005)(41300700001)(316002)(6916009)(54906003)(70586007)(70206006)(8676002)(4326008)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:52:24.6301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6f675d-ba53-4dbe-7d4b-08dbce3e5d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

truncate_inode_pages_range() may attempt to zero pages before truncating
them, and this will occur before arch-specific invalidations can be
triggered via .invalidate_folio/.free_folio hooks via kvm_gmem_aops. For
AMD SEV-SNP this would result in an RMP #PF being generated by the
hardware, which is currently treated as fatal (and even if specifically
allowed for, would not result in anything other than garbage being
written to guest pages due to encryption). On Intel TDX this would also
result in undesirable behavior.

Set the AS_INACCESSIBLE flag to prevent the MM from attempting
unexpected accesses of this sort during operations like truncation.

This may also in some cases yield a decent performance improvement for
guest_memfd userspace implementations that hole-punch ranges immediately
after private->shared conversions via KVM_SET_MEMORY_ATTRIBUTES, since
the current implementation of truncate_inode_pages_range() always ends
up zero'ing an entire 4K range if it is backing by a 2M folio.

Link: https://lore.kernel.org/lkml/ZR9LYhpxTaTk6PJX@google.com/
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 virt/kvm/guest_memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 9ffce54555ae..f6f1b17a319c 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -398,6 +398,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	inode->i_private = (void *)(unsigned long)flags;
 	inode->i_op = &kvm_gmem_iops;
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mapping->flags |= AS_INACCESSIBLE;
 	inode->i_mode |= S_IFREG;
 	inode->i_size = size;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-- 
2.25.1


