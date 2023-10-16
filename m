Return-Path: <linux-fsdevel+bounces-394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1317CA71D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C79D1C20A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC2266B5;
	Mon, 16 Oct 2023 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0eQBvdbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3742374B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:53:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD9B118;
	Mon, 16 Oct 2023 04:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5CN1ZxpI+MrfKf75ATvqxNc3pBVZKPqEV0k47JRlguNoeL0f4HhR9Qk/Dr1xvC9EitCSfdv7psb4h0OXgLPLFGvL5pBA6mgn/YGbKs1okPDor2CoxVw0IV6YWrgWiaZ+T8lzeouH6pyvpBOo5XMjALLp7aNAh3HkU9xUkLwTBNMK7FjAz/kH09F8zUyGXWPCoDu3zgJYP/tJw3M7AES+eGrOYVgwogV8xCkFhuYn6JQlHLizpvQYldF+n/KWxMIwFJ3eyasd2NiGYVM/6L4yJQ4QCCMwbTh3nrxK9hADJCQCmYxT6NrCnVSefuIhZLlUW/fW4XjBKWE2NHadP4L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OHgKUYFAZCONnATUVnBIwfZqzs8EaYMPwtwwWj6zPA=;
 b=Nv9XKqQrEI8C0pYLOaLvJMDsJA2dJulq/iZ9a8stITQykhTtWkJATUvA28UXno1EAwdhuGQ7z8LSUwJ2eU46SuBIguU1yglfRYQE2reh7dVj/dmzMfaukzM6QWDPoKT8gN9A9cf01teLd2i5ZxaYPNK+xTuLNqty5KftxktsG4LyUtMpEVpHm6bMp03bk5UfQoo4oHi6D+sGaTcta8pHSfmCy8/D/wHaGLHL1pTLt5UWEcby+maA4IKP8t9/6/R9z0GxZ2MCYznjzbqpXPWRhbBt1sCi4lttCRcbdiUaeTXTKsH2QMjAiOdrprETByHBk3kpIQQfHgeEuTh5i6bVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OHgKUYFAZCONnATUVnBIwfZqzs8EaYMPwtwwWj6zPA=;
 b=0eQBvdbEtgJNh4G0P1QDKsH9akDx+vqB2rT0NUSb0Tw71a0yNWIPJdHkK8xUlwCMJLtIzLseJKvxelamt1MTc+YMVYcOmcLQFKjz8tswpHHRSOBqJ5S6hDHsuYFtbQLK/cVibkGzmLz5cE/bPbGSZdexjn4PeBu89Uh3Ufm3Hg4=
Received: from SN6PR04CA0095.namprd04.prod.outlook.com (2603:10b6:805:f2::36)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 11:53:48 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::da) by SN6PR04CA0095.outlook.office365.com
 (2603:10b6:805:f2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:53:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:53:47 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: [PATCH RFC gmem v1 6/8] KVM: x86: Add KVM_X86_SNP_VM vm_type
Date: Mon, 16 Oct 2023 06:50:26 -0500
Message-ID: <20231016115028.996656-7-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db7f415-47f2-4d5c-f397-08dbce3e8eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j+OqCqSbLp/+f5t5QRtCPHeQtMatZSancDPNeZu1R3eqdDR5vxNvR3hEGhgmLTU2hJviSfx7RiLAm/klSI3W2aoEZCrI3dSgjV/koKuepCwa6YLRRjYsU2T16+Qgu+3WzLLP9wVxlZZBQDc6pLxCO4dQ+Hu+YH1j+ofKnrdokizvx3Y40OnRqXmXh6/6/UW36GRWYXY9M0LMoKCDZZE8gEzunw+LBQa2dCWZWGlaIeY6YRwhF+7IMIHaZiMzJVciDB6Hz+kZYZhiDjFJJiUjZi0YYMvFiWtS+py/8MdtSt3spGHcpUHm8EBUc8gzbf1SrIt6cYpMwrEPrrcvuuJTTTmj2a9lMSa/4XtAsrXpmOaJH44i3Deps4E092OTOwc7wrf8i8H8eo78my3/nmSYqYi3BwimCysaVsBzOMya4B9ulogS5I+xrSKDW4DUhXk2SvUNq6ykbq3UOjoPztFyHG0gcmcs+JiXDYGxuPSPCMXpIZmd2g0QYfxb7aoG8qOikVQuRMo5gex2rbqSUis5uTkfgnmvrBoofubOclWE3VdnezIrGmFig0O65edHe7Gvs9vRkwpD1H5P5UFzQSPH/p3ob03CxkakC+OAWmU0LzmTchsXKijIJOrF99iejpHIaOjhjZiS8x3+pYQGWJrtu0I8r6c8agLYi6yNAoA//j6fcMDoCJtTVwy4WNPibvHCF5a8/bFIC5KBMzn7eUcW3QkbDJjEugmTT2T/g6+eYHYsui+Z7ZFklB8ihVFe96gpFuXW1gSx/u4d1P+Ilcw3Fw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(6666004)(478600001)(36860700001)(47076005)(86362001)(36756003)(81166007)(356005)(82740400003)(2906002)(7416002)(83380400001)(16526019)(426003)(336012)(26005)(2616005)(1076003)(70586007)(5660300002)(41300700001)(6916009)(54906003)(8936002)(4326008)(8676002)(316002)(44832011)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:53:48.0055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db7f415-47f2-4d5c-f397-08dbce3e8eb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In some cases, such as detecting whether a page fault should be handled
as a private fault or not, KVM will need to handle things differently
versus the existing KVM_X86_PROTECTED_VM type.

Add a new KVM_X86_SNP_VM to allow for this, along with a helper to query
the vm_type.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/include/uapi/asm/kvm.h | 1 +
 arch/x86/kvm/x86.c              | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dbec74783f48..cdc235277a6f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2089,6 +2089,8 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 #define kvm_arch_has_private_mem(kvm) false
 #endif
 
+bool kvm_is_vm_type(struct kvm *kvm, unsigned long type);
+
 static inline u16 kvm_read_ldt(void)
 {
 	u16 ldt;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index a448d0964fc0..57e4ba484aa2 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -564,5 +564,6 @@ struct kvm_pmu_event_filter {
 
 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_SW_PROTECTED_VM	1
+#define KVM_X86_SNP_VM		3
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0e95c3a95e59..12f9e99c7ad0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4444,10 +4444,16 @@ static int kvm_ioctl_get_supported_hv_cpuid(struct kvm_vcpu *vcpu,
 static bool kvm_is_vm_type_supported(unsigned long type)
 {
 	return type == KVM_X86_DEFAULT_VM ||
-	       (type == KVM_X86_SW_PROTECTED_VM &&
+	       ((type == KVM_X86_SW_PROTECTED_VM ||
+		 type == KVM_X86_SNP_VM) &&
 		IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_enabled);
 }
 
+bool kvm_is_vm_type(struct kvm *kvm, unsigned long type)
+{
+	return kvm->arch.vm_type == type;
+}
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int r = 0;
-- 
2.25.1


