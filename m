Return-Path: <linux-fsdevel+bounces-392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8117CA70D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C1C28162C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C3266AA;
	Mon, 16 Oct 2023 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="33/tX8f5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47A26298
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:53:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C2110;
	Mon, 16 Oct 2023 04:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWzLXIgqbWTF1RnfxItauirZXCkYwCGCUq/Xhyn3UTITNYrKZyfDPpnLz5OkG9mlQdF03lucmrUJKMDnbuKBiiLjN8IgQ5Tc0GLpZetjFeW+x4wnQrpWpCzIbp/2/V8op/DFi2qiyvNdooJC+vZO1+jThk6pSzucn6NtKqouJCQ9C+35Z5lBPxHUk2q2P6dZSFQ0XZr2nARdCSEhBgU/aNhsUXeaFl16Vs2zk6cMGTmHneXnYFiWBWf+Y1gsAe16iumr881CXVBu15P0A+zAgBL7vsIqdqQPhp5+71WQEpUUEltcgrvMjt6xkODpXwyQcyMZ2Q5o40iQ5U4g9btPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHeU96y7Mcw+wZiGNEIwGSVFMnPqa/uZ2RPQzjKaLYY=;
 b=ZhUQU4LVy7DH5PmP+pMASLUzE20Piq02KcmxmoUdfNtklc7Ku6GBh4B/1WieOf352gU8LrRtB08MfjL8180q0lClzjlpOsPejqjvNRO1qT/BFFPM8KZ4BRFovJb7OSo/8t6fq93n5JBoZJuISh+iHMEj6CcoIowT7/oLQUC27ZmEWeN7aIoAc2Ud6lEUf5/kAt0AemwlPcGJkmQx6TuqsPx9MypY0Qy8wpgnvWA9Mz5y59sA+jzPcfxS6a852pq/jsV0wKn1y5nrQJcmyzZhNERXnLcZJmsbZ8eIDb5tm1FWE2AVVBEVzN9zpjsWGg9RKqllvogU1QuC0fEAJ1mdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHeU96y7Mcw+wZiGNEIwGSVFMnPqa/uZ2RPQzjKaLYY=;
 b=33/tX8f5087Ab3OA7QNTH0Z4m46LYNH3TlyJ9QMx9NDGCSICTakSeHCG5UB/91OFYFKB4Te8b3Rt1DzNLuP5FRCUg/kuwgAZPVR6pfoReMbDXVhe22TkBVv5hU7yXmw9vOJcg/Ty+PbIPtlYSnONgOHEmdBQuJ64vdGGyaxkTk4=
Received: from SN6PR04CA0075.namprd04.prod.outlook.com (2603:10b6:805:f2::16)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:53:06 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::da) by SN6PR04CA0075.outlook.office365.com
 (2603:10b6:805:f2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:53:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:53:05 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating memory
Date: Mon, 16 Oct 2023 06:50:24 -0500
Message-ID: <20231016115028.996656-5-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 9170734a-5cf0-4296-24f4-08dbce3e75db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7PtZ3Hu+5EP0OsApGAx3qKT/gSk/u5UTyE7maHyZdGjE7TAd/vlCUWXmsj2WbSDpCosDlCC/qwYw6k/OIWUr5ZAcO8XeNrduZ0jI/S6L2uZgooTd+JHeDwQh7PTiDOqwiouIk/soP67Xuj9Gk1uCX8OC+aNi+niP1Ms5G0ImU3j4tNvYS1GEovHpRtGOFKgDPTJxMX1Vxh8qjRWK16EFnJxYzyhNFa1F9IXKDEINrCr0LSHV9IS9ETdfBT5vyRxerNI/s4Q34Rq+tGsb4vD/vY7z2gbHzeqr/zfizwJRSS2W1/hhRTqXaqHfQPTw5pFLSDNL2oyjmqJeIGVkqidY65xKEJbX9pFOYOL7F9DDeK8pb/oIn2KGbhU7aKOjgK5laahoM8GsH50hEbqwDnJhzZM8qHj98Y1CQd96yMh9DzPuaomiJIUTy+2uJ9uz6YSZ8v3/0WhErxhykDPHv+NHmpxjrfxdREsntg8ccWI+JxFzIVEmCGRbmrJ1uYxSw+4Q/u2/q4ezoc81UtAf8ZF60DNfQ4xphqcqjgIyBfAiKtmwmc+kqpAIWkTm2HrOaMxwTCoYXyeW+MvyFKBVpcB18pCxqL0h2m0LqmsRELWJJCFzZq7AwliNejjLerWbz0GwkCbgO+RiW85J4YEp0TuHwF4MDLdtOVlDzHIzlcUXre1mNndlzu+tZtidUHyoYk7xwC7520DvxbooENPGd4Whuo4s21sKP2z0WCm8aZXIgmQiLVbWTmJpwNXTujWafsJSOmXvscjE++q+WKDwWtigAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(70206006)(478600001)(70586007)(54906003)(6666004)(6916009)(1076003)(26005)(16526019)(336012)(426003)(316002)(2616005)(8936002)(7416002)(4326008)(8676002)(2906002)(5660300002)(36756003)(44832011)(81166007)(86362001)(47076005)(36860700001)(83380400001)(82740400003)(356005)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:53:06.3022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9170734a-5cf0-4296-24f4-08dbce3e75db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In some cases, like with SEV-SNP, guest memory needs to be updated in a
platform-specific manner before it can be safely freed back to the host.
Wire up arch-defined hooks to the .free_folio kvm_gmem_aops callback to
allow for special handling of this sort when freeing memory in response
to FALLOC_FL_PUNCH_HOLE operations and when releasing the inode, and go
ahead and define an arch-specific hook for x86 since it will be needed
for handling memory used for SEV-SNP guests.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/x86.c                 |  7 +++++++
 include/linux/kvm_host.h           |  4 ++++
 virt/kvm/Kconfig                   |  4 ++++
 virt/kvm/guest_memfd.c             | 14 ++++++++++++++
 6 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 0c113f42d5c7..f1505a5fa781 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -135,6 +135,7 @@ KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
+KVM_X86_OP_OPTIONAL(gmem_invalidate)
 
 #undef KVM_X86_OP
 #undef KVM_X86_OP_OPTIONAL
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 66fc89d1858f..dbec74783f48 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1754,6 +1754,7 @@ struct kvm_x86_ops {
 	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
 
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 33a4cc33d86d..0e95c3a95e59 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13308,6 +13308,13 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 }
 #endif
 
+#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+{
+	static_call_cond(kvm_x86_gmem_invalidate)(start, end);
+}
+#endif
+
 int kvm_spec_ctrl_test_value(u64 value)
 {
 	/*
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c7f82c2f1bcf..840a5be5962a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2429,4 +2429,8 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
 #endif
 
+#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+#endif
+
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 992cf6ed86ef..7fd1362a7ebe 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -113,3 +113,7 @@ config KVM_GENERIC_PRIVATE_MEM
 config HAVE_KVM_GMEM_PREPARE
        bool
        depends on KVM_PRIVATE_MEM
+
+config HAVE_KVM_GMEM_INVALIDATE
+       bool
+       depends on KVM_PRIVATE_MEM
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 72ff8b7b31d5..b4c4df259fb8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -369,12 +369,26 @@ static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
 	return MF_DELAYED;
 }
 
+#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+static void kvm_gmem_free_folio(struct folio *folio)
+{
+	struct page *page = folio_page(folio, 0);
+	kvm_pfn_t pfn = page_to_pfn(page);
+	int order = folio_order(folio);
+
+	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
+}
+#endif
+
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= kvm_gmem_migrate_folio,
 #endif
 	.error_remove_page = kvm_gmem_error_page,
+#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+	.free_folio = kvm_gmem_free_folio,
+#endif
 };
 
 static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
-- 
2.25.1


