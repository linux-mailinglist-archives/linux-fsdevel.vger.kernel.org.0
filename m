Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389CF6C2082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 19:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCTS4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 14:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCTSzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:55:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF01497FB;
        Mon, 20 Mar 2023 11:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJyBzpAjPO8smDQqmQnFsqbuDEMADjOP/bWFouWF8ijDBtHLk8tCzpUa1vE6hhRHH3e1N1bxABflyFm2CfIMVcF0dL5IyyWHMd1j7spsO9uFVENdiH7iT5hcYHVK5at+7UQzjAKuVAkspWcxSOoOtHsJQLv/uS42gcCnM5WfrjsJp0gAXfPLJ6kYpiQATi0eAq+Awm0qLRwOoo259xL926FfAnLsYqAidYWzVzsfnu9KyQGNqQspzqBmj3y6KEgZ96lSzhFvfCpnYQFLYloF+nmIovM/IYxoN/O4twMoijc02PrAU8JdW1rLbFUvljJEeyKuwJVZyTjhhBfuAV1v+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ecBOFBL5r+bnKKNsVchdUNnMVHFYGZmRu2mS3y21Ns=;
 b=Hik1h9NVx+wXcJwiaR+TJ4/y+LqaK4f2fICMLMZonr5Af/7Splz9y4Doeb/ntOapBAc75fEKYA6v1vzfSh55PSpxEde52wO/pe6eAteDw3QFCoaKK0+ZoaDpzUMDZmkoqG8qKnkm6yH/GvRSlVs19Ye38NJkgat7Ge4EUYHd53wzM6hWxn4uIWWL216qGB18HxFbgJCgRZ0gaOrenyWpkPMnT5x+JpsLELqxa7IMxS5zx0ukt7TiB2Z37LkBsvMW+hQXsWfQrXXJfgVQH50M/Oa6OCbdVDGpK+NXLLovixmtFWAqXVzI4lPzwJrdrLaHpDb/83Cw/rzxNZWtV4mzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ecBOFBL5r+bnKKNsVchdUNnMVHFYGZmRu2mS3y21Ns=;
 b=Vj/fLFJxQO0zOHsaFV8gRCunLi68HW2s/4/ZdKTnLOIpt5zAFXr8NyanE9fMqHv+jlr+wx/kvBk2dyERVG5bsguItI57deVE3AP1w/RHtKcinEia4pB6htyTznJWprneqnKxO/m/ohdh/n5T6meu/oAlzpQkNlFW7WNdJgN1gjaGub+T61gngNE3ypsM2js6Wp1hPGWb8kfpejKH5BymZQJ4yId83JIvdpltFayfwnoGgg4ky9QJ87x4b/AWzBHWUoQ6jUVFse4EHviuSwYYOwXunXR9g2B5uIoSXqKAcDT/LnpmGrTvbpf3DSAiKfv+1AwPjJ8F/1posD2+NjjQRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:47:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:47:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 04/10] zonefs: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:23 +0800
Message-Id: <20230320184730.56475-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb8c531-5cab-47cf-0a73-08db29739b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VftqllsnXCbrYT64d2k44dYr15JCHjExTvhZhcYIcXTjlQvJ2kChE0RFAkz9EacOclkTPIi908XFnEsgqR0CPEkpsl5AEuzKj+6gSiM5XNwnzzQ/wqHg4VvcmX6E2h4nb27IRr2Bd1dHNmeCLUAlcpEn/LSTcMzy0ztHbDq1V7KioThnO1cMMxEJb0bufks9d2mEivF7Fw+ZZZ11fWJ7g2TAmInog92kslGPrhAVYf4P/xdMJjqdQby+ymyCkeVGx6ojbB0FbutJxrQ+NHpmUJU+vp+ZmnQNx+DOugXtrCYs97xe5PtzHlsbevJXWIa5C+gVodQXdTuXtYA5UTqYTqCuBfyAKe+8SMA9ne3LrQbkhDbGXS6xdJYpfM3tja80kkZlNbG+2IE44/Ito4pf6j2AlxHd726zrkKADqd2nIO2ILdYsLJPCO+FFAa3UXmEQL2T6718JS6hHJ12Hk5v+7VwucEWrh9+2o3YnIVCcSRq4lWTjM7Xq74z9cCKA0iRDFBCE6izfJbKPKMjajYBjRjprezKtz8xq8PTMu2dQEKG/75iIpMGz4HClXDp/1xlUGiW17uoIGdbphFGZR1bHpYu7462Nrwf2GND/C2O74LFqltIBASOI01VUbIEKgNjrZnvf7c/9Ftld7PzcJ24ARAHPyyKUoAqqsNZzemTtT6alCxcSNtQH5N3jtn+x1PHNab8WAobWwsac6tOWtmSEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(66946007)(478600001)(66556008)(110136005)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NEVbuQKjwPQR6g4cPBpwa010gyR9Hj9jdu4RrdSfPlMj1O8Co+kTOMB+aHIt?=
 =?us-ascii?Q?3d+XcBBMDYSoHT+e5DoNf5eAFHC/gjFOdbEYyLfKer3baIZhu9hO32yR97r8?=
 =?us-ascii?Q?D/VDZXQIabj5Q3WoGbFrPTSv1/PGWCxHEm6vyTNHMHDlfqzpdJMXVee9+h/F?=
 =?us-ascii?Q?A4kFWkOErKCpZ6tfF7mcUDFmihfNMTDs0zNtB+ZwI3HnRvN8C0L1cKtIhL1r?=
 =?us-ascii?Q?qTG4ClYpd9hZ398S3otAHyBlWXQdr+ygBxqh9G4kpJstdZ6IcX2lGYvfKAJh?=
 =?us-ascii?Q?YpEugwdzJfuS8V+yJjzMl0aqUx3CkD62+S8JfAi7JkZnwvCBxQlWc0nBaP3d?=
 =?us-ascii?Q?Nb14s5/DpIkzm9VMlNNdLBNysb3ZhB63XbyaVg7XYk0vRyxlEJzNFxajmKfG?=
 =?us-ascii?Q?amu1NHbo6ONVlxQzMz4rXka99M3dhiPofSPV17AnVAa/otfo1Abx7/kU1YUE?=
 =?us-ascii?Q?Pqqv7d19BNLcKonvPRCMoMLH3HRgtiJlvhe4BxoJsZjwaelRmHxNumHFnP5Q?=
 =?us-ascii?Q?CTlyRsq6XWVdaEg+mIz24/j+lNWSbqhwmXZTyvVtfD2+iFpK5bEEP0q6JC25?=
 =?us-ascii?Q?YHLzLdYOATfDpD4xyLzCjQRsDsFw1g67klwGBK3Vwd58wXeEPrQ18ESgUpkf?=
 =?us-ascii?Q?V8nqXWXenfXBWcW2wyc8gxcTxpGQ3NFznt7WJ0KC2AiZDWlJUyl+oX06plcB?=
 =?us-ascii?Q?emwpjkqA3EAmAI3GRGpQm1b84W+D2VMTdca9Q+9NwUtIn9l8UIHjjGoYIOty?=
 =?us-ascii?Q?wsC+l09D173PAGoQIQOmaeKl2qi1Cw49XFd382xp8sxJ6DjLmx2Vz90VV79o?=
 =?us-ascii?Q?9GUzFw45+f2w5xdK3mCrI6JWcEJ8uktrDIglzOnxrE1yj8COcxMYwqG4RJZN?=
 =?us-ascii?Q?7Vb6MV5udSckie6n+QsSMCWCcYlIrlOCsL3k5S+KXvAgestqR3WTLfs+TD57?=
 =?us-ascii?Q?gyavHXTcKU+Ga0mJImr75YAyq8E+e33DQaS04RH+dVsU9fLv2tYq/e8WfUV7?=
 =?us-ascii?Q?OIPmGKEzU3W9lrGOA/pmV3mak9u148cdbEF+j3JPHJaGCiZWY4s+YAcHDBDT?=
 =?us-ascii?Q?OTNvv+s6sjSLxlwd/Jtt4u6EpSqTn3QwvJFOyzzQUw0nrPwZVsYcfv6qr/F9?=
 =?us-ascii?Q?Z+rlRtrSGUy705IzU34iT6QNvWkSQljwzTU/Bf43fMmx9mNaSvp9wDGuSMG6?=
 =?us-ascii?Q?Iti/5jbS2Njon38AzRW1bBfjXFdD/Vc8TDjyuxbhkiBWqCdSPnM1CRys0zir?=
 =?us-ascii?Q?PyrXBQInJA2I7N3w9/7SIXRkDtySAmCJuIcufoiIxW9sC3TmfklAbZagt32D?=
 =?us-ascii?Q?mXmRbefKn14XjqZvGj2TC32RWKWoT8Fm7+h+YxJPpDYo49/mx63TmHFQu5AZ?=
 =?us-ascii?Q?ZZ5bAgzJcqFb90Rxatjo2dr3GpwOEffc38An9xQ74WWkF3BN8dTzScfxbItP?=
 =?us-ascii?Q?GkLBkRLHy8oLudQLsQiCGUx6DRyNKsblIm4VlYnKUt58YlIpqZfXjlSMoL7Y?=
 =?us-ascii?Q?qNSQCdKCc9S5IBtPT12etfvZYRloHweRj/iohaudMUvcIdQ3EjcV6geYRGrx?=
 =?us-ascii?Q?Vkt0xlnZflLBc8onYUDzyil+OTFoRqr9fWFHnVRF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb8c531-5cab-47cf-0a73-08db29739b77
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:47:51.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0aKkxEbWqIaJtMdOhlU601MK5JqyAGC2/KEa36hu82gAirMnMKmAefRdJdnBKko7AbXM+IQxJNXSszeQ0NVOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/zonefs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 8ccb65c2b419..5e117188fbb5 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -113,8 +113,7 @@ void zonefs_sysfs_unregister(struct super_block *sb)
 	if (!sbi || !sbi->s_sysfs_registered)
 		return;
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
+	kobject_del_and_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
 
-- 
2.35.1

