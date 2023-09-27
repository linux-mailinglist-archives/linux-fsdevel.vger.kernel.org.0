Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0587B0643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjI0OK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjI0OK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:10:56 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440E0FC;
        Wed, 27 Sep 2023 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWTFVCXImGkRj7gtzqeNh9WIkpR+V+P8qcpBbFbZapE=;
 b=GOi0JcGiXJh7pkYozJav+sDjJKCVdUJEiCqCOOc+EGDlyDWK4nL2ecHt5Fn2CvH15kb96+RTthXRkI3YZS3LjBLzfNwrTFjk6vpbVXed1aOZkiMTbYswwMzjDoqeLZOc4DOX3xVqBzje3/zM/wWX+rzRIvMvmWxDSkw/+JcDfVI=
Received: from DUZPR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::27) by VE1PR08MB5712.eurprd08.prod.outlook.com
 (2603:10a6:800:1a8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:10:39 +0000
Received: from DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4bc:cafe::24) by DUZPR01CA0115.outlook.office365.com
 (2603:10a6:10:4bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 14:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT012.mail.protection.outlook.com (100.127.142.126) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:10:39 +0000
Received: ("Tessian outbound 6d14f3380669:v211"); Wed, 27 Sep 2023 14:10:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5e59d962b51d9ebb
X-CR-MTA-TID: 64aa7808
Received: from ae81cb80fa00.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AEAC1633-5CDF-4F8B-92E4-8512589A33E3.1;
        Wed, 27 Sep 2023 14:01:49 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ae81cb80fa00.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzdsMbQl+YHbGt7m+yuw7ZANQjpTJ29bLo+bTbe9y0MOIK+MQTOQAEoVP4sccbKjtxe6+j/umcJwRp687B8rRlaFbUiMpmEKZf7A/4yWBwEloQb7bAobyX91oBcz6bkzMXBDaPEFq0ne83iVPhOuvxGQS5h/+/fvyiQcNLebqt+JQbO/dVlUa6BeMMkSQOcWxKhAt8FJL67KhuKsAs6jBQIKPg5WMFh6/8RnYWs+6JczbfFZE8+yUGuW0qOekQlLbf6vQ5XAogRJZd0mu4w8+6KknNoLAhu3m7xftVCmbjTfWFZzcvarXPdwkNQsPMnXxrjVPqqe4LuTW2LN8y+6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWTFVCXImGkRj7gtzqeNh9WIkpR+V+P8qcpBbFbZapE=;
 b=nIXSMknyaumRsoxMo0Uj/wUaM9OqhBgtqpYkaO6fsx8BhqMc3KkSSJ8uPhqkjYiDJXeo/bpA5xA9BXsIKpYuELDgY/BiOa1OlfeNbrbaxBKFyk9HA5QkzwRXc1lOl5PKAIvaEPXBXzRy5jkX1bladQTTYmvw4bUuPyq+GSg5W0jdVd1daJ0Z5yXwUnsDhE6uTq3LnR4fMA4sJu/m6cGKH/KgpaS52AAXr5krWQTkPfhOqyV5Q0wkgplbKKLNRjo6U020ODEU1S7Q0Zt66857rKocni7kGAPheP8Yyye7H/6IYYWVCSfsV3yD+rlT8dVlwK/W42Auws+21tfj5wxqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWTFVCXImGkRj7gtzqeNh9WIkpR+V+P8qcpBbFbZapE=;
 b=GOi0JcGiXJh7pkYozJav+sDjJKCVdUJEiCqCOOc+EGDlyDWK4nL2ecHt5Fn2CvH15kb96+RTthXRkI3YZS3LjBLzfNwrTFjk6vpbVXed1aOZkiMTbYswwMzjDoqeLZOc4DOX3xVqBzje3/zM/wWX+rzRIvMvmWxDSkw/+JcDfVI=
Received: from AM7PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:20b:100::12)
 by GV2PR08MB8511.eurprd08.prod.outlook.com (2603:10a6:150:b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:45 +0000
Received: from AM7EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::19) by AM7PR02CA0002.outlook.office365.com
 (2603:10a6:20b:100::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT030.mail.protection.outlook.com (100.127.140.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Wed, 27 Sep 2023 14:01:44 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:34 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:34 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:34 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 01/20] arm64/sysreg: add system register POR_EL{0,1}
Date:   Wed, 27 Sep 2023 15:01:04 +0100
Message-ID: <20230927140123.5283-2-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT030:EE_|GV2PR08MB8511:EE_|DBAEUR03FT012:EE_|VE1PR08MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5845d4-e12d-43f9-468a-08dbbf63874b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9gI2NhjW5Hp7GcUzQxAjaOH9+Wx4tcl+ipq0APiqE01KBLZ7N81k79aca5pM3QP91TKno5LuVaJM808YlqOkdK81FCXn23Qm3RB0URDGquV/9PwraXBBAqMFQTfexpgtEoMFxHB5LhKvAK4agu4L1xthz41uiQ12OGLqz9BItZ7zAkYxNd8+ia/C/drSaapFxxipvB+ZsqAhFa3Ap5nT7zZq5BTTFhCrnPN+dzVn/w+RUNH3IlSeQadb5rXrmZlSVFXjmJ/UqGsoz/wtJp1GaaNucJX1G6nGVCb3WIb/RuhfC6tpc9LD9Cx4Ac64bgkmnRSU895pAaahMxOIXhbg0w7OuUsqjyFzoGKqGeiJLjOY71KN0GDlvvKub6ojKlZkxeX0Mcxhv81a09bLU62KwQbWgJbfw41s4sJcSVlGblk+e9VRWfhfbMIQad0jm1E/Wa5BGZk/Ek9jG1mIsKNXk+SGsV7A1kr4S0LkludlgfVhSVAWjKT2d9JzY/h6W8deZHPEc5Y8R222iyFp/BGxLn1L+t3aDPpGhA3Wu/oXaQocQaPVfM1Q5er6uga9bMJzn+OE1jrMuhIqH2B1GY7BfEpOh00FK8DDNEGheshAbj+DeFT0qQkyVxnHUq7yAWcXKnjeERWPVSBNSiGWXISm4Jhq3sGNx8U7iD/4Z791bpWRnLJYxPF2V42ZpF6Auqgu1irhpHDnqzJAXimvuvm9ykWWuo7PF1Mp6o9r95VLmdvA/NdwdD2qpXPMoe2ThbE1PV8MSIVTXgcpVpyRH33aRQ==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(54906003)(316002)(70206006)(70586007)(6916009)(7416002)(40480700001)(8676002)(4326008)(41300700001)(8936002)(2906002)(44832011)(478600001)(40460700003)(26005)(6666004)(36860700001)(47076005)(5660300002)(7696005)(81166007)(426003)(2616005)(336012)(36756003)(1076003)(86362001)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8511
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 58e3647b-53b0-48b0-d2db-08dbbf62484d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yty/AJajYwoE1yQxi/bOuHfEHIY9NnUHwbDtnEHcGclIgJ2hvd1g2GynNJS5k61hUNfuLHCAtNbl+mLDr2xrfyFptYSl/RE0EdG1qaj4CEMV/3p9hyg8hIsNayYiUdNC7cYxwmn9IwYFXaQtzwj6jf6NZsXC/8ta4tkhpnPSwETimuqe0E6N47wsAOd44iW9IQVHp9GcP9SB6RR/IiV0ouNO3SUq2bhTDA/3WAzxUIcmXff8g4/agzmhyDQ9zRPoa0/p9jlmYng5zLY2m6fpw9eSFfiF3bOOMs5cCtfgm282HCMe9RsiOzN6YHfsPCPOEzgichlYWhtHX1FbiDF7m1BrGIeTBbn7xhf2k5x9s3dRnkTmtu62X79PRAkZSnGTRRNJUG8v0T4tAwbBBrxHXy/z8osYtfGdEUpwmva6MCV9iXPsXIIy2TeCynpv2hlNMM6Q8CkLHtJqtmnkx8KcCAHqV4YLfMVuFsFRg6RoBFqZwZQgzmfWnAN0dFWRjwdkGWVnAL3xaeK24mubLqXwk8UwDtbRZ/UA5JZc3/b6vhBfAwNYK54/U5F1Xe8GrSf3BAByqOF8O3j3ioIUTcMn9VqujnpeuWIg5qhJ0gROwCzjgfoHKzn2Gf1ZvRVm8Nvd4F2qSiwyrXR7rJc1ZDbQ8zZffOAOT3U2488KsSaBfw227/xK+2z+o4YBBcmyWrGfJhhx+BWE/ermkPMlOJ/hT6Od/+6Xaad3V21YFFcL4Q=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(70586007)(6666004)(47076005)(336012)(1076003)(426003)(86362001)(70206006)(478600001)(7696005)(82740400003)(26005)(36860700001)(81166007)(316002)(2906002)(450100002)(5660300002)(6862004)(4326008)(41300700001)(44832011)(8676002)(40480700001)(8936002)(36756003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:10:39.5113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5845d4-e12d-43f9-468a-08dbbf63874b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5712
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add POR_EL{0,1} according to DDI0601 2023-03.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 13 +++++++++++++
 arch/arm64/tools/sysreg         |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 38296579a4fd..cc2d61fd45c3 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -994,6 +994,19 @@
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
+/*
+ * Permission Overlay Extension (POE) permission encodings.
+ */
+#define POE_NONE	UL(0x0)
+#define POE_R		UL(0x1)
+#define POE_X		UL(0x2)
+#define POE_RX		UL(0x3)
+#define POE_W		UL(0x4)
+#define POE_RW		UL(0x5)
+#define POE_XW		UL(0x6)
+#define POE_RXW		UL(0x7)
+#define POE_MASK	UL(0xf)
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 76ce150e7347..20f7dd25c221 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2504,6 +2504,14 @@ Sysreg	PIR_EL2		3	4	10	2	3
 Fields	PIRx_ELx
 EndSysreg
 
+Sysreg	POR_EL0		3	3	10	2	4
+Fields	PIRx_ELx
+EndSysreg
+
+Sysreg	POR_EL1		3	0	10	2	4
+Fields	PIRx_ELx
+EndSysreg
+
 Sysreg	LORSA_EL1	3	0	10	4	0
 Res0	63:52
 Field	51:16	SA
-- 
2.25.1

