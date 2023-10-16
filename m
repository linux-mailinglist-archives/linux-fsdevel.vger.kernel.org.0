Return-Path: <linux-fsdevel+bounces-393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C97CA714
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA3A28175B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B56266AA;
	Mon, 16 Oct 2023 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XKZggh8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0C2511C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:53:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C0E5;
	Mon, 16 Oct 2023 04:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKcT4tFDRQScsBCCSu3M9htvRGFOR1ZoGUSICWu7qRH8XHG8w4iGt9ZqIj2XIBzzb9KVL8LyArWTKjNn3FaS0C2DItLBhzJ5L217N/1LQvWt6UVu3A5yNdGiP3TjWNbdMaEHZE75eREM8xNFNEodW3u7ZyvxRyZ5hNitwZ4KTOtk1xyv0FgToyzcP5ylEIMXgS1GSQhJiUatocFiUSQbM++OQN3jBTCg/7/6CLqg4zPoUJ3vHd90eJnVCiaYpt6lClZa2/QPuWQwOFkqF393+h88pFK2jQJBa+Wm/UFkaSNZu48JjE5g85Bff9jEyjMiK54H9tXvA6IJMn4gkpnniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzhdxTCjEnyDbbG4eHyU9AZ0euSgP8vBuvxuU2bmxv0=;
 b=eu6tn2cYgTpf0wDzVPOletOKcPq1+aCpVKTU9HonRLC2Ce7UnFSZRqJu/PwTxvMXzrazCNOKx4NfzBSlQM9X7be5Vm9l7qG/bA5e2xguYD/ud+8qvWHGkvfb4rPATqG1gPoA+5k8xh25Yl0Suy89opcEN/vvqNLpoK2pG3S0COaw+t3zqUNlJc/SPELP+4xFT0myIcyDcHwEKrKzRRQG6m7nOwIzy0otTN1yC9/Fr0QfWLl3rPcyMHP1whDyJhqR1TyNearSYTFFF3V6skXRC3LIa9xOyWZ6JNSrPA37KJzFaXBrSk+gDCKoL7wdPZAA1d4CABt5vEtzBPoTu75gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzhdxTCjEnyDbbG4eHyU9AZ0euSgP8vBuvxuU2bmxv0=;
 b=XKZggh8iOk8JCtS+r6p2GGTNPrBXuWE9eNVhDrBT8sEBek77z+CzQG0Pl497uwc2vPMD3x07/CUxjBJYUKkynC0bYoKDBD2OopUxZgeN4YfCC40HAZY+6wwTALZYy1PYf17hjtIaG0Or7saoy95e9h97RheSMuYmA+GxGp3XUHM=
Received: from SN6PR04CA0087.namprd04.prod.outlook.com (2603:10b6:805:f2::28)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 16 Oct
 2023 11:53:27 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::39) by SN6PR04CA0087.outlook.office365.com
 (2603:10b6:805:f2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:53:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:53:26 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: [PATCH RFC gmem v1 5/8] KVM: x86/mmu: Pass around full 64-bit error code for KVM page faults
Date: Mon, 16 Oct 2023 06:50:25 -0500
Message-ID: <20231016115028.996656-6-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: f70f5930-8080-4575-a9bd-08dbce3e8247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LzzfvIWKwKJzqW7s1FdBhzKnjnlKLWYlMlFiLM/+dzgvxcAHTPPFhEH776oyfqdjBUi3NFdNF95vZ+Yifaf6kJmQa9Ihtg9mXNPyuOkE2wZsYiFVm3l3J6OyMyHs7fwz0UiT6UQ43JwNc08AI5nnjCEfKqkmhGFIOgj616R8Cp377NYo4Gr6gEqAPAvdAlgOEKLSl37XT20EWsq7P1nhK/+0ijir5L1aIUfvwKoXbfl2vwH/GffSLlCgIr/b6LJ6D93rpfdDWwRrx1Aiqiy08GVXjV/3nthw5kaNYri9M1hN24ccOaPU/5HfROISQgzlCSDImFeeJSxBx0fOQ/Kb4FxA0oRj822ZoMdakktUeQcORpH+gDwpLkx1PW+ZL41UXzu/71CvzLCa2CshsotCXEDEBSS1BtrWkawrKlj3Y3fJ/2na0JQqKRoeeSDmACOfzyq6qTZ32W1RHmWpYeEXOUdfzHWfAAHbgSBY2Q31b4nzWBFoVKckfBShmS07wDffBMhE1lmzlStbw49PtKUr4fACpSvPq/HnY3lnbZxgg1X+rHTJTjplgQOMmpMaYQu8IYmO+8S5Zy/q7MxhI+wT09CuEv4Txw3ayQ2ncZHYIUFcphEADkhjLPzYlM3kxptIbXPoMuBAYaPdpH9kZiSFVLjIglD4GuaGRTTiI2D4whrTWPPGLUbeL66c7RT9m2gw9swzJlXDmuS2ij/mfO1xaaz6mtf9CsQDbHgxNDJ4pmhkgaVz3ZcI3igKWd7Wdb9M
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(36756003)(86362001)(2906002)(1076003)(40480700001)(44832011)(41300700001)(478600001)(5660300002)(2616005)(40460700003)(70586007)(7416002)(6916009)(70206006)(8676002)(966005)(316002)(336012)(356005)(426003)(4326008)(16526019)(26005)(54906003)(8936002)(81166007)(82740400003)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:53:27.1460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70f5930-8080-4575-a9bd-08dbce3e8247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In some cases the full 64-bit error code for the KVM page fault will be
needed to determine things like whether or not a fault was for a private
or shared guest page, so update related code to accept the full 64-bit
value so it can be plumbed all the way through to where it is needed.

The accessors of fault->error_code are changed as follows:

- FNAME(page_fault): change to explicitly use lower_32_bits() since that
                     is no longer done in kvm_mmu_page_fault()
- kvm_mmu_page_fault(): explicit mask with PFERR_RSVD_MASK,
                        PFERR_NESTED_GUEST_PAGE
- mmutrace: changed u32 -> u64

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Link: https://lore.kernel.org/kvm/20230612042559.375660-1-michael.roth@amd.com/T/#mbd0b20c9a2cf50319d5d2a27b63f73c772112076
[mdr: drop references/changes to code not in current gmem tree, update
      commit message]
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/kvm/mmu/mmu.c          | 3 +--
 arch/x86/kvm/mmu/mmu_internal.h | 4 ++--
 arch/x86/kvm/mmu/mmutrace.h     | 2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index bcb812a7f563..686f88c263a9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5802,8 +5802,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	}
 
 	if (r == RET_PF_INVALID) {
-		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa,
-					  lower_32_bits(error_code), false,
+		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
 					  &emulation_type);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
 			return -EIO;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 71ba4f833dc1..759c8b718201 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -190,7 +190,7 @@ static inline bool is_nx_huge_page_enabled(struct kvm *kvm)
 struct kvm_page_fault {
 	/* arguments to kvm_mmu_do_page_fault.  */
 	const gpa_t addr;
-	const u32 error_code;
+	const u64 error_code;
 	const bool prefetch;
 
 	/* Derived from error_code.  */
@@ -280,7 +280,7 @@ enum {
 };
 
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-					u32 err, bool prefetch, int *emulation_type)
+					u64 err, bool prefetch, int *emulation_type)
 {
 	struct kvm_page_fault fault = {
 		.addr = cr2_or_gpa,
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index ae86820cef69..195d98bc8de8 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -260,7 +260,7 @@ TRACE_EVENT(
 	TP_STRUCT__entry(
 		__field(int, vcpu_id)
 		__field(gpa_t, cr2_or_gpa)
-		__field(u32, error_code)
+		__field(u64, error_code)
 		__field(u64 *, sptep)
 		__field(u64, old_spte)
 		__field(u64, new_spte)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c85255073f67..2f60f68f5f2d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -787,7 +787,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * The bit needs to be cleared before walking guest page tables.
 	 */
 	r = FNAME(walk_addr)(&walker, vcpu, fault->addr,
-			     fault->error_code & ~PFERR_RSVD_MASK);
+			     lower_32_bits(fault->error_code) & ~PFERR_RSVD_MASK);
 
 	/*
 	 * The page is not mapped by the guest.  Let the guest handle it.
-- 
2.25.1


