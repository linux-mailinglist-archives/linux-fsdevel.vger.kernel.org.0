Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D77B0609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjI0ODY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjI0ODX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:03:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B211D;
        Wed, 27 Sep 2023 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbrnELc79cTTyl8mSzRLYhNT8sC3fwyI3hxFhzA9Hnk=;
 b=6aQKWRsScIzuVfSjKGLTQmcWu2faaUoQTjPYQnoXbjADikL3RRfMuCtb+7+bEueP7Ju1ZQtGr5SRzkccgiOSR9+Bf2u1lx6JgSiN/uTZRIFqaXr4PunhZVt2DkzaPS4Oul+p270vI7sifIr3KEq2zWvjKegATFFw03WmEkHmmyU=
Received: from AS9PR06CA0391.eurprd06.prod.outlook.com (2603:10a6:20b:461::13)
 by AM9PR08MB6673.eurprd08.prod.outlook.com (2603:10a6:20b:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 14:03:19 +0000
Received: from AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:461:cafe::5c) by AS9PR06CA0391.outlook.office365.com
 (2603:10a6:20b:461::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 14:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT037.mail.protection.outlook.com (100.127.140.225) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:03:19 +0000
Received: ("Tessian outbound 0ae75d4034ba:v211"); Wed, 27 Sep 2023 14:03:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2a9f62c7b57c88f0
X-CR-MTA-TID: 64aa7808
Received: from 6692e6f04f1b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DB31AE2E-8849-486B-AC68-2C7CE4026BC5.1;
        Wed, 27 Sep 2023 14:01:50 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6692e6f04f1b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjOUkYPs8AOGRxlPXGIkojfy6ug5wwNgWZ7T/YqxFk495Y6ggR9K7kHGCTZmGbIYW1HhGag/zVqoZq0g3CjSUq1kdjgxxuUXRtHwl8tK5F13WlwDSOowikbZxvj7qd9Wzf3XOZTTRIXxy8KfJ0MAat0yl7I6TOsDikW8CzoeW1GAmYLKd+wz200VToV3B2X1/eDZOIZl4LIzugX6Kc/1XfQmBP+faz3odddFz+kmLYuJolD3f/FFJVE8f4fu0PaHrdkRhPpMiY6+HYqR4K/kWMSWxzwZklBN4zDroYNPI2z6jXcU1tOz4WUeMgsFg8/AWpWKmIeyIEIe5deAWjEJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbrnELc79cTTyl8mSzRLYhNT8sC3fwyI3hxFhzA9Hnk=;
 b=E9UO6GBxo/Q2pCRIolUhyA5uFDcO/sp9tb6gOD4AT9kLw8ULTWIH/CL8zKOLa4eSA2jpZ8yuHy/LrvBjuer6tsCkedtjF+hsHvkKKk1JPzulzhJ/N8aHeXR4zF6ay/mv9FnkMaQegRB9VuK2T2XRM7qUdyZwP/sP5gvHDbamJRdMA/OtjupZ1bSo3lvHU3CJrC7vFObzadwn7GqKZMAGMVZaaLQYz/Lhas2Xv/qUchyPFNX0g2xZTCjBlkfFgRz+wZ54LA+gCqyyzRD9Ic4oD/DZC2G1u9WqOQy/r5XMwSqh563oWY4/9fOOCGHctAs8iU0gnzZG4Sn5ux7A5o7XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbrnELc79cTTyl8mSzRLYhNT8sC3fwyI3hxFhzA9Hnk=;
 b=6aQKWRsScIzuVfSjKGLTQmcWu2faaUoQTjPYQnoXbjADikL3RRfMuCtb+7+bEueP7Ju1ZQtGr5SRzkccgiOSR9+Bf2u1lx6JgSiN/uTZRIFqaXr4PunhZVt2DkzaPS4Oul+p270vI7sifIr3KEq2zWvjKegATFFw03WmEkHmmyU=
Received: from AM0PR07CA0006.eurprd07.prod.outlook.com (2603:10a6:208:ac::19)
 by DB4PR08MB8053.eurprd08.prod.outlook.com (2603:10a6:10:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:45 +0000
Received: from AM7EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:ac:cafe::6) by AM0PR07CA0006.outlook.office365.com
 (2603:10a6:208:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT048.mail.protection.outlook.com (100.127.140.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:01:45 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:36 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:35 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 04/20] arm64: disable trapping of POR_EL0 to EL2
Date:   Wed, 27 Sep 2023 15:01:07 +0100
Message-ID: <20230927140123.5283-5-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT048:EE_|DB4PR08MB8053:EE_|AM7EUR03FT037:EE_|AM9PR08MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bd9057-4442-49b4-6928-08dbbf62810c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 114EbaRsOdDyRGPQNFCG/BIeVUDVOS+O42HUP9oLsTBUuJDfcdQTBiLyYE1fJ3wgMZgX7bsroDT1G7hEmf9SMxRWpD7yEEqGNzn+Ewa/69Vzd2/konOZdPO9ACP8oOhHfnz7YeNdkiS1XysRzCzdke2Tz33qy3cJyGMoZ0Guh7hOH03xseSFGb50yGHouyKJeZC2ibeG7UsFQrsiD8HE8m/Dkz+ymwG4R2cpLo3pXR4nregWDR0mk+Wmy42w3QUQAczyyHeFOs5y6CMowJLX6259JBIIBZMEWQBRCgaSYfbSree1z5gx4DsnQUuO0euNMupU0l0Fgf5O/QA8TyBd0sw5nhY8T6YJrygldatlziDb4rej0/tPMJo6L5nMOEAhBf48iue30OOu85kb9Ro1DnSODjxoJj4Etqsex6S6mEJguyChZ/at39mJfO7Tfj0ZS364USnhotImCHmsEKbuI2h+K4a3JuEsjs+AiedeJyI4r68HeJlIyveoQ5KrjZFyLwwkrDpUNZwDbuydWp0M6xUpW+9VFq+Tyw1wcG7nu/Ng1tTbeMzo9/vopxnjiU9L53fMZDq1Czc7cB4bKCoALsGZT89p6b9rMczn0IUCP+TLtiqZMsnx1RWzHOz6jStoEH5UA+uQxrs18F6bfam8QxM5tKTlLzMaRV8bJ2wccJwSXZ/V6JGsNoysCgZn9+wldRTMBasPdmrU6EaMDX5zuZb54DpNlUThMtPgkzvwU8wXFsoo2XOhgsP579bVcCJQ
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(70206006)(40480700001)(54906003)(6916009)(70586007)(2906002)(316002)(7416002)(4326008)(41300700001)(19627235002)(44832011)(8676002)(8936002)(478600001)(1076003)(6666004)(36860700001)(5660300002)(47076005)(7696005)(83380400001)(426003)(356005)(86362001)(336012)(36756003)(2616005)(26005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8053
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c359938e-8340-4828-5fa0-08dbbf6248f0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+Cr2Sw2xE4xr/KHswccNs5bVX7ZmYKZ6RY5w5GotIlYCtQigF+ykA/MWf30IEMnJbszDA712w37Huaq8es9r3Tu04IOey03S3DBaTOTKy73knPhJBAsEuKRb3gFwUL9D+urlQziJwYv9/WcOF5NgKEBoJ0OllxP2H3yhWxAppTMubEMlNPTN9BOyL/f5vJ+6IDNp4U27GyzW5mtp98qcS3XyBDICVio2AEpSGMoXcbSfFftKp/wzms0tLAh1ACtPMtmJv+to2x/wUgVgVKpehn5naTw3hY2K+a7hN88CKr0SRyoVbZcKDfqPbC+93sUmQ7JpKE/VHuxHv6yNSXpiiD/49aEjmNThM7tHKc0drdD2X5QXpokOTa3GZ0U9fykjGiu1zmQwCfWbLQDcO77vGfP3Ur0FsDgdawMwJPpJ3tyqsDf6KhzHZX3JsLpkB/Sds2VChMNerVgyb93Duw5PquAYA++j6aGXfDg9wM1eRG5PJ5macH5LD/3neMgQ7R5CHvA7QIs7j+penKPKLkHgUT7ffRBveazVhnkLYLrecdpEe2V4UvrEUSTgEthMPs1Ghy185SBWgcbz6fHC0zO9zAqXMBD5rle9VvjaCNIzZvaeTdd4oE2mAwe2k06QOzhmV2uGfpm3Atl5ZxG1zaEHQ6YQf5uWSGqFV7ib1M0pTX4ITfIX3ae07Dr9MjSTkBsgRz8UxhNTQsNrruM7i7mmP1vUgUckq5BkGd+bCZrVxrFSU0OtwIT++ToIvl4xm1H
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(2616005)(336012)(426003)(1076003)(26005)(36860700001)(316002)(47076005)(70206006)(54906003)(8676002)(8936002)(450100002)(6862004)(4326008)(6666004)(19627235002)(7696005)(478600001)(2906002)(70586007)(41300700001)(44832011)(40480700001)(86362001)(36756003)(81166007)(82740400003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:03:19.5050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bd9057-4442-49b4-6928-08dbbf62810c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6673
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow EL0 or EL1 to access POR_EL0 without being trapped to EL2.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b7afaa026842..df5614be4b70 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -184,12 +184,20 @@
 .Lset_pie_fgt_\@:
 	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
 	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1PIE_SHIFT, #4
-	cbz	x1, .Lset_fgt_\@
+	cbz	x1, .Lset_poe_fgt_\@
 
 	/* Disable trapping of PIR_EL1 / PIRE0_EL1 */
 	orr	x0, x0, #HFGxTR_EL2_nPIR_EL1
 	orr	x0, x0, #HFGxTR_EL2_nPIRE0_EL1
 
+.Lset_poe_fgt_\@:
+	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
+	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1POE_SHIFT, #4
+	cbz	x1, .Lset_fgt_\@
+
+	/* Disable trapping of POR_EL0 */
+	orr	x0, x0, #HFGxTR_EL2_nPOR_EL0
+
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
-- 
2.25.1

