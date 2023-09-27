Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3162A7B0607
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjI0ODG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjI0ODE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:03:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04D5139;
        Wed, 27 Sep 2023 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0yT6aUiEgqGdFDJIzxPy3xP5u2DH8hDhZ8T2A+NsCo=;
 b=ejgNHPDdMOxcV0sn2YhSvZeF6scd5vWcwHMgPVPim5DJYK3ia1Z/DBDVEwNGImIdGPzdoevaDeHztUTfyvCIyhlAeec6EElSVOluJCT1izxQrm0BcAYpS2aD1EmZSVna47d+GCLO07aWPVX0ylW3+55geKiEvnP9P204apSVBV8=
Received: from DU2PR04CA0198.eurprd04.prod.outlook.com (2603:10a6:10:28d::23)
 by AM9PR08MB6305.eurprd08.prod.outlook.com (2603:10a6:20b:284::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:02:59 +0000
Received: from DBAEUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::44) by DU2PR04CA0198.outlook.office365.com
 (2603:10a6:10:28d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT041.mail.protection.outlook.com (100.127.142.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:02:59 +0000
Received: ("Tessian outbound 0ae75d4034ba:v211"); Wed, 27 Sep 2023 14:02:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0ddc445098f639a5
X-CR-MTA-TID: 64aa7808
Received: from 071200549df4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C8FCD12E-D95A-4B9E-893C-1E0CD9681332.1;
        Wed, 27 Sep 2023 14:01:51 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 071200549df4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBBQQLegQn5s6/3e0zRmdlUC9Srmc+hjhNusW2bVJKaPXuhlXV5kRHwdl+xotixHMctBGETyq78oadjPh5ahd4jGbkkdv35bFlC9k0J5j02XS4OQ6+6bs6HMWl1KmpEjuPkBx9Y8GoSJp7FEnaoyCAfOqXAikJMan7Iw1vZgDd2PxtdwcVkNV25RKvGmsNghVdWsmlUwjBganj+gmH1xtpSOvPtGcbTskl9JVpdIK32XxRsijbkZLodHo85/zo6huPWDjRtG2jrue7qSOzCVLAvPWbFl4XPKDUh5japidHw5/kpe+r0vCU/A2TvEMtrKclm39xsHKyO84yspOzX9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0yT6aUiEgqGdFDJIzxPy3xP5u2DH8hDhZ8T2A+NsCo=;
 b=LiFQyQKhwYGOgvwDA1p/kxP4OFlRugzVrdN/18rjYIigyGLW/Z8q1tSMCinR0bXpEQnajK77f/L9bIVf9bXloSMwzEjXbpZ//B2jlLBx1XFuQCWAtH98tMKn7+VnI+X2Maycl2+rU1hbYiY4kKeo8iifuyoQWOljtcudMXcP4IsmpRbbg1rljyHlLDlO9owWK8Dyz20/NJjBMLtmVMaTJlu2NFKxxZjKSrbIImqSSpyqOtn+Ez/dl3UEINZyBKhtwcAtwUMQ10H8YmgGmm/kUxYHdEg5lYddcNiVWceZf3HeF5rPsSgeAeOUYME/lo/K86t84njEmkcy0lUZxYgJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0yT6aUiEgqGdFDJIzxPy3xP5u2DH8hDhZ8T2A+NsCo=;
 b=ejgNHPDdMOxcV0sn2YhSvZeF6scd5vWcwHMgPVPim5DJYK3ia1Z/DBDVEwNGImIdGPzdoevaDeHztUTfyvCIyhlAeec6EElSVOluJCT1izxQrm0BcAYpS2aD1EmZSVna47d+GCLO07aWPVX0ylW3+55geKiEvnP9P204apSVBV8=
Received: from DUZPR01CA0183.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::21) by AS8PR08MB8085.eurprd08.prod.outlook.com
 (2603:10a6:20b:54a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:46 +0000
Received: from DBAEUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4b3:cafe::6f) by DUZPR01CA0183.outlook.office365.com
 (2603:10a6:10:4b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT047.mail.protection.outlook.com (100.127.143.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:01:46 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:37 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:37 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:36 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 06/20] KVM: arm64: Save/restore POE registers
Date:   Wed, 27 Sep 2023 15:01:09 +0100
Message-ID: <20230927140123.5283-7-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT047:EE_|AS8PR08MB8085:EE_|DBAEUR03FT041:EE_|AM9PR08MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 499229a0-759a-4776-9987-08dbbf6274de
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3dGPBsS+COWkvTcnukDiSEDwQrSEn1OLsk4fQ91fVbT+BNBVnu07rzjXVyYdCEfQq65mvUJrQih9emSd418aQPRlJQefsj/c7yqNcaaHtF+D2m+w452pvztZ0VlbonDWBxlh7BuF2kI9BJkpT7BSMYIcydCjtKFW+z8bI+3PsHkvyibS+SgPgHoE6RUY8YcVcSk2EaPex09QcT1ft6hLU8d3uBxaB37J87FvUYv+AcA8xlCSc1tFeWx4vh23tzWQigClJqWOjndMRqsrOyNk1E9fja9VmI6whW6/rH04qW98XOBgoPqRMPTDAu95MtzzXjDGMKBK3Khrw3wnevyNjJB7EE5joOXpn+6DPTVIWu8DHnDCzHvcKRC2bUe8RrodQUei/mPffNTNwtlDr0avGJU8RCfxIQp3XnJdsJBDdP6etEL690P3q/H1tF/yygZyrTfbLPGovDDR3s/J99bNLntSS6MwEdIslMjZGS1kRZI+Eu+65peuK5sAWVPQpRcfbEyAN5T8QES+cr4LS+cyCWu8DMQ2LngnxDVnsb/QPT/R2rp9JTzfqd7p8b6co/RkQRONpoWsejAscVy06wstXFd57oUdVxW+pFlDrlPwUCCza79TpWf+1LZgdC6xNp6TtyC6f0R92zaI6AgWd7tvh7Wgc6PUVl6ztx0x6HOizA5eAHjykbNVjPMvhbPM5zu0EZZEf2HPtuAR4TewUC+2fqjgB4eV36cb70PyeIgfuQHXvipUrxWmZkH0m4u+I5xYiroNr9NrgvLVsYOg8Vvn0Q==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(40480700001)(5660300002)(70586007)(70206006)(41300700001)(316002)(6916009)(44832011)(8936002)(8676002)(4326008)(47076005)(2906002)(7416002)(40460700003)(356005)(82740400003)(478600001)(336012)(426003)(26005)(2616005)(1076003)(81166007)(86362001)(36860700001)(6666004)(83380400001)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8085
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 08b69d6f-54b4-4124-a6a6-08dbbf624949
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mkE9vRrgnR9xca4/kyJud9CbP6VyCXDvODftJ+9kSwItKY2s1N7oNJZfuk4ygDsxXw5g0aE7olZI8II9fucpjspmBdlV4nkuvj2KPtrQsiob4w4QrZLbZXS5Jm5IjrHgE6+zkPbGn2FP1gpyqdReG2BKRjflyDXckDY40NdIScGNmVr/5U+mZFAWlNS1ltuSoRr67nEwsTznpHWDAKiLomMo4mpEjtGaGjNQqG2lPuwu/dlD8WpPDxiGHrh1FKE9xFb3ZckNeeuIPMP6kMrppK/l8Er7m7VekpTX6IQUK2KxmZzZFKyomlW1L8yX7DtUPS0WL4SVvM1eS4RvCp/0pYouoNxVnC1gpM5vREDN4N5Yr8zZiEWwE95LdFwCampQUmvohuEad7a8rTgEZ9J8Zz+pes8wktIcEytzZo4KegGFuNaDF4OCr4F1pvX2OTc03XCdmyiCWNEH0xB1dBgmSUZGJY/B23dnwGOJ8Mu4Q15gZLHTjHs0AiLaItBsv/00Q44zB6pg8EK7X9oHOHyCvnHFEkbfvAL3KnJu/F9Hhr2jkCafmbZpLYqap2jC6nN7mE2EfcN+VmH2l0IPcypgks+zSvsB/5Qfg+Ck4dpTT/CZwDD4n8nGToNjXgI0JiTDv8upqCA7LolHutfwWBmWdkveosEEhOC1cJtq+z/4OOJjT11wNFEQirHp4ZyNEtUxxBHGyXDYKRVQ7Qyi2twuZypy+BwR3AloG5fM5eHhCM7neaERKujN9fFvoW6oLlY
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(2906002)(316002)(8936002)(44832011)(41300700001)(6862004)(5660300002)(4326008)(54906003)(8676002)(70206006)(70586007)(450100002)(478600001)(6666004)(7696005)(2616005)(1076003)(26005)(426003)(336012)(40460700003)(83380400001)(47076005)(40480700001)(36860700001)(82740400003)(81166007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:02:59.0252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499229a0-759a-4776-9987-08dbbf6274de
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6305
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define the new system registers that POE introduces and context switch them.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 4 ++++
 arch/arm64/kvm/sys_regs.c         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index af06ccb7ee34..205653bc5c2c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -365,6 +365,10 @@ enum vcpu_sysreg {
 	PIR_EL1,       /* Permission Indirection Register 1 (EL1) */
 	PIRE0_EL1,     /*  Permission Indirection Register 0 (EL1) */
 
+	/* Permission Overlay Extension registers */
+	POR_EL1,	/* Permission Overlay Register 1 (EL1) */
+	POR_EL0,	/* Permission Overlay Register 0 (EL0) */
+
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
 	IFSR32_EL2,	/* Instruction Fault Status Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e92ec810d449..dbaddadd2a1c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2124,6 +2124,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
 	{ SYS_DESC(SYS_PIRE0_EL1), access_vm_reg, reset_unknown, PIRE0_EL1 },
 	{ SYS_DESC(SYS_PIR_EL1), access_vm_reg, reset_unknown, PIR_EL1 },
+	{ SYS_DESC(SYS_POR_EL1), access_vm_reg, reset_unknown, POR_EL1 },
 	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
 
 	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
@@ -2203,6 +2204,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ PMU_SYS_REG(PMOVSSET_EL0),
 	  .access = access_pmovs, .reg = PMOVSSET_EL0 },
 
+	{ SYS_DESC(SYS_POR_EL0), access_vm_reg, reset_unknown, POR_EL0 },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
 	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
-- 
2.25.1

