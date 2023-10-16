Return-Path: <linux-fsdevel+bounces-396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7AF7CA729
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BDF1F220B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC9266C0;
	Mon, 16 Oct 2023 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r5PwcGX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D82374B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:54:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA4134;
	Mon, 16 Oct 2023 04:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FP9Chzl/yRdI9zuUQJ//a4dB0zYcOGRvvERAf2wcUuBLp8ZVsro7+hL5ZXsKcKcjFUf4aaLl7IM6zyby9XcotMysMz+R64n20rP6s//O2IG1B8inSR5T4VaEInP0TIVlfDN1WS1IN5Uxw3KF/YAUWqyRZ985T6gRFKhR2BkAGrgpv60OJMkzgca8Cv6ctFf2xP+/TWWKzXPBk/EeYGmr5cdavTW95LofTilcccbMPKN0FpaiKuu3a6mGvSM/4K1Jd6N2rBqJiXHFc+3LALtxc5HiyejVIOe1Rj8PK9ghxK8B9iBEDNB2XaItvP3ldANPDgyQdGObC1oVW+uiga3XjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOIYpK8d1FFoOQs5uPVJt/jFrFTrz07zgHXT4XBNINI=;
 b=XkLV4zfwUBF7UEh64mUHR/QMUeX4GQnXLoq8EVR7+ouYDdOOjz52gk7EoL8YV/iWO3xmu24jHQUTAP0AUkxq4BpP2MXs4keme+L771y/fqWeKaeA9HEfXZp2N492rNVXuYRVvxCpQLLKzjJ8S1TEV36E31KIQP/14B3AGr1sZ/maRbgVIXTci1KOmrmzHMvVftBInKrg6uBkRqo1khvaYf0GjvIaBg/RuJAKPNBmXtoxYVzah5haicJ3EbYzGRiCbIHOUSpURg+V8UEAzq0EraMXwXZ/E+KKGgfMbiWdd3Hiz9hBz/3RP1c1u5bjAFP6KsQtf+M6qzRUmnaqphMoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOIYpK8d1FFoOQs5uPVJt/jFrFTrz07zgHXT4XBNINI=;
 b=r5PwcGX1EVKZpGIyXCHQMWiXYzser3qVm12min/RKOZD9FkcVKUi+25gZYidt5AnEShsD0m//7pzOnc0BrFrHK6UgeryV4P/hyKwOlcTu8ELXy/Woi9jufMRzIPC9pK0bQRlhtRx3IrHMX11yZyhI53wPaltCYSHtd+mueYcX+k=
Received: from SN6PR16CA0071.namprd16.prod.outlook.com (2603:10b6:805:ca::48)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 11:54:30 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::f5) by SN6PR16CA0071.outlook.office365.com
 (2603:10b6:805:ca::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:54:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:54:29 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: [PATCH RFC gmem v1 8/8] KVM: x86: Determine shared/private faults based on vm_type
Date: Mon, 16 Oct 2023 06:50:28 -0500
Message-ID: <20231016115028.996656-9-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbb7028-0f7f-4744-3ab0-08dbce3ea789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2iUKxxYLuJaF5gNLwGPK/WMGRJpQo0FX/u6b+T+jXyhqU5vvsoQcKipvx8Jux41n2ZQN1fkOZ9ipdKraOTh+29UsoePk/mPlzeJxg6Do0UY11pOghNnVyBQhl/T/W8HFS5zhkjxwLYuUZdhVEUkos8i44+YWnzihvm0pkakrZeF7iclZS5N/Xwydw2rEUvlY7h4F5XzNArRTQeTBcRifFl7SiG4jm6GI3kxrIbjUrVde9ZrTx3UPU8Sgj2PeJQcIOpIsyfFI5sZ4JPHEMZbPNGIR+Zsn0aDtImqK2IGxiHi3TUdp92MR2z9Kiu8rAX0CS7kwBhhSHgwY2mmisLHnfhu5EYyvueHhA2Nt0Hde2oWw0AOPIgdClA2eNe7jzi3EaSsfhcIGu1I/h9gMMZ6zVozMMVbI/iT/b3C0vXne8wzp2+eqfTQktFRSnIfKaNaBNDyh1AKpxqNCu6N+PEakWyrM7B9KY0KX3ybMYJZ7HzVc/kslhppH1+ebeHbw254UUuV2efO9TaVJpof2c5IEB+36bdmsgDhrrdFYNEStjy/BHn80jWpzu0eVu5Gm/oabJ9XvKA92ws74E4Y8nF6tJd70EhlLY33PELgxWQKSWhWHPBcD0B69zNIre2hRpc9J72O8xysUwkB/FbpHKk9GxWoxbsa6dzSP4mk+uwrnLdBNLE6NWQim0cBqp8MMFF3j3nbLnHT43vSOBqLZ9IjQv8UBdAqMospUta/Ui6llkZnmZ2m/YcS1nW/xpSJwOWk+Ao7JtVX8A9S9LvnNkTbRkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(478600001)(70586007)(70206006)(54906003)(6916009)(1076003)(26005)(16526019)(336012)(426003)(2616005)(316002)(4326008)(8936002)(8676002)(7416002)(2906002)(5660300002)(36756003)(44832011)(41300700001)(81166007)(86362001)(47076005)(36860700001)(83380400001)(356005)(82740400003)(66899024)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:54:29.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbb7028-0f7f-4744-3ab0-08dbce3ea789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For KVM_X86_SNP_VM, only the PFERR_GUEST_ENC_MASK flag is needed to
determine with an #NPF is due to a private/shared access by the guest.
Implement that handling here. Also add handling needed to deal with
SNP guests which in some cases will make MMIO accesses with the
encryption bit.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/kvm/mmu/mmu.c          | 12 ++++++++++--
 arch/x86/kvm/mmu/mmu_internal.h | 20 +++++++++++++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 686f88c263a9..10c323e2faa4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4327,6 +4327,7 @@ static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
 static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
+	bool private_fault = fault->is_private;
 	bool async;
 
 	/*
@@ -4356,12 +4357,19 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			return RET_PF_EMULATE;
 	}
 
-	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
+	/*
+	 * In some cases SNP guests will make MMIO accesses with the encryption
+	 * bit set. Handle these via the normal MMIO fault path.
+	 */
+	if (!slot && private_fault && kvm_is_vm_type(vcpu->kvm, KVM_X86_SNP_VM))
+		private_fault = false;
+
+	if (private_fault != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return -EFAULT;
 	}
 
-	if (fault->is_private)
+	if (private_fault)
 		return kvm_faultin_pfn_private(vcpu, fault);
 
 	async = false;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 759c8b718201..e5b973051ad9 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -251,6 +251,24 @@ struct kvm_page_fault {
 
 int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 
+static bool kvm_mmu_fault_is_private(struct kvm *kvm, gpa_t gpa, u64 err)
+{
+	bool private_fault = false;
+
+	if (kvm_is_vm_type(kvm, KVM_X86_SNP_VM)) {
+		private_fault = !!(err & PFERR_GUEST_ENC_MASK);
+	} else if (kvm_is_vm_type(kvm, KVM_X86_SW_PROTECTED_VM)) {
+		/*
+		 * This handling is for gmem self-tests and guests that treat
+		 * userspace as the authority on whether a fault should be
+		 * private or not.
+		 */
+		private_fault = kvm_mem_is_private(kvm, gpa >> PAGE_SHIFT);
+	}
+
+	return private_fault;
+}
+
 /*
  * Return values of handle_mmio_page_fault(), mmu.page_fault(), fast_page_fault(),
  * and of course kvm_mmu_do_page_fault().
@@ -298,7 +316,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
 		.req_level = PG_LEVEL_4K,
 		.goal_level = PG_LEVEL_4K,
-		.is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
+		.is_private = kvm_mmu_fault_is_private(vcpu->kvm, cr2_or_gpa, err),
 	};
 	int r;
 
-- 
2.25.1


