Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFFD6E2037
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDNKEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDNKD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:03:57 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4765A9018;
        Fri, 14 Apr 2023 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr804s7bVZfIa+qC30gqcZLNaKUWavbsiBabftnI6F0=;
 b=qixR3QS7CAPO1Mvxbh5ot4cVL1+XDPOehs08RJXb+GsSQQ3Z5jc4icKfW/WjqG8CAA+j0zjPdcPWl6DyT07gSCRPgv7ZgJwuPZN4tTr1JhexY/qmoHmYvA/NlnZA1DRLuCYg9bNOjsatzFDHCk8hm+vpf5pTyIYcsXH1GQy5bg0=
Received: from DB9PR02CA0001.eurprd02.prod.outlook.com (2603:10a6:10:1d9::6)
 by DU0PR08MB9273.eurprd08.prod.outlook.com (2603:10a6:10:419::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 14 Apr
 2023 10:02:42 +0000
Received: from DBAEUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::b1) by DB9PR02CA0001.outlook.office365.com
 (2603:10a6:10:1d9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT048.mail.protection.outlook.com (100.127.142.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 10:02:42 +0000
Received: ("Tessian outbound 5154e9d36775:v136"); Fri, 14 Apr 2023 10:02:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 79bbcc36450c85c4
X-CR-MTA-TID: 64aa7808
Received: from 9c797f34d37d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0FB32275-3A48-4924-9B24-719EE9CDBF69.1;
        Fri, 14 Apr 2023 10:02:35 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9c797f34d37d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 14 Apr 2023 10:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxprS/EQO5snmOcL5+GUqkc6wZlxd43WXCo+x4Im0Y0L31Oi3t9dUkFkMggZukRAFVFX9VDo8YXGw05zXhXpPJRlWVqAwJ/zXWdkURH0biNyr67DRFVbwl49fROpl9rqB6H7ZC+SyVJ437iJeIds6Uk4M5QDsm5YGQa9DXRf0rLqRopgxgTtm7CQuixhOBHAb6bxePlI0KS8ZnDAzRN7KGqhC6idkkFZd7xnVbyIpX7kkY8r6j05fG0vcmYgA+p6DiK8WWUJfNNIqQt3xbL0m5p0rJs1LbtoyZKDUjaKSdtyXiZoWiIl6Z3rdD57i31YwUOehJWA4RPEwb4Z3i8q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr804s7bVZfIa+qC30gqcZLNaKUWavbsiBabftnI6F0=;
 b=aNntHFAppziSqZsdYpL/VKIFrru9TAYyQ2yhggMHL00Cf/Dx/xNO+FhHJ+in9Vi3HIcLC0VKlVekr4kSjQPEOWRX7jeK5hbN3ne2GrEpEheAtgjk+pivzhJIhlVK2xV5y0T1+eCNP/7mEDyHDL7LVfGapwuL7RMVCSRVL2umtFDUEIdO9JfGUigJBxxDqFWxqwEmX5MiI855uMiLyXaYpIkqQ9xMvbppWPBY1IJnMagT1vZATqO/q4QLWpzCMk2ajJnRhsYGwFiI9wrcPz3mTSbkrIB07wxZ7fSrBeCyT8kdk6N1gBy8BK1n4YX585D3qipH9STqpdGZhOjc23otaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr804s7bVZfIa+qC30gqcZLNaKUWavbsiBabftnI6F0=;
 b=qixR3QS7CAPO1Mvxbh5ot4cVL1+XDPOehs08RJXb+GsSQQ3Z5jc4icKfW/WjqG8CAA+j0zjPdcPWl6DyT07gSCRPgv7ZgJwuPZN4tTr1JhexY/qmoHmYvA/NlnZA1DRLuCYg9bNOjsatzFDHCk8hm+vpf5pTyIYcsXH1GQy5bg0=
Received: from DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) by GV2PR08MB8584.eurprd08.prod.outlook.com
 (2603:10a6:150:b1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 10:02:33 +0000
Received: from DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::e3) by DUZPR01CA0022.outlook.office365.com
 (2603:10a6:10:46b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.31 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT037.mail.protection.outlook.com (100.127.142.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 10:02:33 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 14 Apr
 2023 10:02:30 +0000
Received: from localhost.localdomain (10.57.20.128) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:30 +0000
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH 4/5] memfd: Pass argument of memfd_fcntl as int
Date:   Fri, 14 Apr 2023 11:02:11 +0100
Message-ID: <20230414100212.766118-5-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT037:EE_|GV2PR08MB8584:EE_|DBAEUR03FT048:EE_|DU0PR08MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c7ee73-c262-45bd-a43b-08db3ccf6349
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NfstKygHOFO6Qbt7ULPkPAhyzyB8ozKjpamoecJqixtbwzcCaTAyHXp6wAdo69MQtFRMMuOMwjQnUgUd7xa4cjudQAJVHvRVQcWfuSca/R1y9VNgVx/GTSyoc9Cf3H9xbshxbcEN4OINcN4i7k4KldVxIwyiVhU4WjGza505OnHvSQ1W85Y8qSRbkgCuPDzL+m7Dpqh7byDbpb3z9S5bhyKcNVjwdLSe7t6rhETdHHLafLyyPKJKLvs34NytmL3hkEsMMTP4U7cW8ndArKIXyqIbfIRM78JPxC0j7zMwmhM4E0RBM+iAVUwUsYby7tVfDEGJnK7u6f7P7J/K5Mx9IaQnfw2qQe8hmShXjX+dYt3H044bi4JxF7GIGm4ktQCvOvm8eD4eTORbDYWs2rvFJ2eAcW4r3agQJsaqjR/rw7Z+fHxkbiLkK9QIk6OOQGjLoGa72GOf6IXeT2P39GB+BLXt59p+gqXCku0bXHNgxGDGuSta6XqgGR7AYbgFLHnN6SxHm6EkR4OGIRVgwVp/1pcJGPnB3oiTZOsJZrCoe0AIabkuqrXrDVdLxYuLXse6ye6KSaqVmTs/KgftPb6US9o4uPBiSq3HcNXJz3Tboh9k3puR3fGZ4REn60LWvEyRNQ0I9R3KowXbRknG8LbQXJbu3OcnL4uT/8/imKHoFbUZjho/nSL4IEMZNA2QdQYNxYydsnwkGQpBuVbks5cSqQ==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(36840700001)(46966006)(2906002)(7416002)(70586007)(8676002)(70206006)(8936002)(5660300002)(478600001)(41300700001)(316002)(40480700001)(82740400003)(83380400001)(426003)(336012)(36756003)(54906003)(4326008)(6916009)(186003)(86362001)(6666004)(26005)(81166007)(1076003)(2616005)(82310400005)(36860700001)(356005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8584
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a77acf33-23a4-4461-d76d-08db3ccf5dda
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDUBdm5welz0M0Cv0zmjhMn2jtR7CzyN+KFYGB+I+L2Tcu3xbReycNC159LQ9mMbIbwRgDzf6hQUF9a6Wv6Zp1KxrzjbvT9eblVXmguSHD8++XzocT8SfGzKjGyoicBxCGvaLzkfL+UgbE1/qMuKB36FvP9+5ejCoOG2tg4x/6YwHguKa0pd3Gbwnc/yM3WP0iU0cUtSVTZE7tBfyKBDRQruZzCz2lHqCrrXsH+3YL0Q4WfUL3S2iczzACLcTfW1IWxpy4EClOK/8zduRRi/GyZMq7KCPjqNtPxzLsD9Yt5GNAyj6IIQ/8Dyksym4l7lnM27QAHGzR9Xv2C5Z+8X9JhsUUkhSLNZHd+s7xlHvGquoYR4cftSrU6cmWLdaO0z3fkh/oviNH2x0vNpwcd6G4h0TRty5IOboDSX4IP2lJdiGzmaJVGy+IxLEROrVUdSHUdCpZ0PYyBGyE5bj5f5n1k5o0h4liUAQPixLchlJsyYarqCPE5LhfehbzcifkFRZy0iBPU36RHyv/c6rPR2ZY7Yb5fpEOvApUIl6tePmYk0/E7UGdROQRQY8g5itpknII1n5N1LvQep86DnJ26v2R4CoL3dnMWHxkbEPw2Q+ugU1NQBSo8DxiC9UMym8JKT7jPrXpOPmzzsp2kAmRWmKU1igX9T/tO+Jj7lm6aLxxpMpVff8dWeGofubBEtt/B0GTRjuYobaOE6aQLmfLuqAg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(1076003)(36756003)(83380400001)(47076005)(81166007)(86362001)(82740400003)(40480700001)(36860700001)(2616005)(2906002)(336012)(450100002)(5660300002)(316002)(26005)(186003)(54906003)(4326008)(107886003)(8676002)(40460700003)(8936002)(41300700001)(6916009)(82310400005)(70586007)(70206006)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:02:42.3630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c7ee73-c262-45bd-a43b-08db3ccf6349
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9273
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The interface for fcntl expects the argument passed for the command
F_ADD_SEALS to be of type int. The current code wrongly treats it as
a long. In order to avoid access to undefined bits, we should explicitly
cast the argument to int.

This commit changes the signature of all the related and helper
functions so that they treat the argument as int instead of long.

Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Laight <David.Laight@ACULAB.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 include/linux/memfd.h | 4 ++--
 mm/memfd.c            | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 4f1600413f91..e7abf6fa4c52 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -5,9 +5,9 @@
 #include <linux/file.h>

 #ifdef CONFIG_MEMFD_CREATE
-extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long=
 arg);
+extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int =
arg);
 #else
-static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned lo=
ng a)
+static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned in=
t a)
 {
        return -EINVAL;
 }
diff --git a/mm/memfd.c b/mm/memfd.c
index a0a7a37e8177..69b90c31d38c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -243,16 +243,12 @@ static int memfd_get_seals(struct file *file)
        return seals ? *seals : -EINVAL;
 }

-long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
+long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
        long error;

        switch (cmd) {
        case F_ADD_SEALS:
-               /* disallow upper 32bit */
-               if (arg > UINT_MAX)
-                       return -EINVAL;
-
                error =3D memfd_add_seals(file, arg);
                break;
        case F_GET_SEALS:
--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
