Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC23D6C0054
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 10:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCSJ1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCSJ1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:27:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C298E1A64F;
        Sun, 19 Mar 2023 02:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSzAVY5DoVd9KrEbuxF1SE8YSagEZ4o47V2bNM5KoNDGUJD1OD6VmFbESijAcjIYwJG48yeHeV+p4wUIEmnpO2ZCLViV8gBo3AXjHqZ4o6uQAj/JdTARLpJhF89lI0StvVXS7ir/aYanDihjvJK2xuq5oIFZ75LNSc+YxN78QIgBiEZZqEBmTcDvlPS6XPdBoqqCxVU1ux8Vsf/ux5PRkuGrfq4r7pvXsQnpCuA4dv4GTckly5wVGVQo4jGxxCrG27kpmtURJnpu6Y7k+QJkGOYEg5RLiMe6ILL55vLqCPbreWnFD3rwXLEW/iQwN+E51L++W4vWBl1ECgRsRXXpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJUPw73zxfQpSGOnXiazsT/DPiflp8oO5ktoRrHDsKQ=;
 b=O6ywMYjq1NBVB1KgrtKcHd1vTz380m2LU3/V2wNv5/gFqImtps+bxxXfYinXqKvTifWk4QzOO10yrnTPIwt8jcACQ5SuKEnglh4h/R5D3bDZao+yWXxEG1rk1+VQ8gULb14FYugmSffyuiQ5wH8FwwGAr1LBF7LKueQwazx550skXPdbi0KwRgW2JljHZaq/83i3G/99FcyhNnk5afm12XrJvvjBmRIJTf469m6upGi63k9alte7s1DatvnAnoNTT3D4FTjcbjJveBz9pVhlZ+tm2xOvk5WJDlkXx8qZNXUuNxUARY0F4sHkIB1iyE7IwDwaVj76IEjIuILTr8yEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJUPw73zxfQpSGOnXiazsT/DPiflp8oO5ktoRrHDsKQ=;
 b=jRVWHduVh+MT63g9jeWLtuzPcVHPn1vn+vza38wzHt53u2myJ7tCc9/zChlYriHdYOyiBvA5U8EqVbw6KLkAB6mTh6wsOX/nEBZWP8sGBRfJZSVH6MzAAruzxnC9JniBH0yo7evFCbHSFeTuhli/vzJtpek8xrkeTA3m1TkpuMRod5cqShrpLhaqAo8c1EqmKSzDkWnSHtMjkUvnoKuJok0g04McMfOWam9Ix1Wi9JXz1TvOzLFPS3f8ihOxpq9wyBcsr2Vb4R65tVbAaXLsF7g2+CYguvmVMlBkAuVO7KdHT39/N89F/qIgPU5027ihiqKsdxkw/ypNM5hMfSoKdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 04/10] zonefs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:35 +0800
Message-Id: <20230319092641.41917-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 9134e7b3-b2ec-407c-0b95-08db285c2032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/KY+Vc4dcJ4/kjdgjCnbb8yXsvg7VkzR3VP/DI8Cg/CczEUTBG98ZL4p/oEzk9y05h6COL4Pl2qYGe0HC6rwko7R/LZH32B8owaZ1NcKpEmk4HWsQEhzd22yOoc4d8oc7Bp182Ybw/tbUoDdOQPU0DnJA1VQwTFIi0byDyyoHZ7836inhlWw2W93lXY6Ra8EQynlT88CgYmdlF8OtSNwpx+THlD3WT6GSJdEtRfeSSXFxK3ECgNFDPguEvZLMh9q6i8ffGjy84xiGLfUlhFO6RdynZqxHyz9xsJOqPVMjr0ZsvSN9RHfp9c8XLT3KauB8TpdOAXeTQDEipy9orlNQhoLHPxROKpCwiXKlzhtWpbUGR38y9zgTrkmDuOWzd6c6/sUAfaPBm1Wu/7JqiJRhuR4wVq9toPiRbVKBq0lowI7S6gFo28SPGovm+tRTtyn3f7zhy0DdB9yANTp1ndrA32ppRhN58Kuyxpkdq6HFUIfp8DW3kueGjqJkHXeEGHYK7OMZpBHAkF65+xzefo2HXPXCk81NR6FwkmUJAwlqj3ArOLrFxh8xgUKRS20LQZJd4vNtiDFfyQpQJ6Ot8TVaqQ4KwxVroFoUIzNmgz/up6FqI+Vjhv0v6eMZpnPi+QSrvdOFSIhryYxVSGLYCpMG0mO31FhGouUQw2HRt/fx/9Z+SGyFbyggWKNstwZDIvrtwjKZ8c4ZQqxpu4IAFRbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(110136005)(1076003)(4326008)(5660300002)(41300700001)(4744005)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZhD2LjgrMUf2eAJE1YEU3tO4Ar855XHcM2rc7PLZbV49KewkbOVrwFoBKWJ?=
 =?us-ascii?Q?rkOQR4zSg3Y5w9YbIQ6B77w5w3QmR7b6aNwEkC6yYWZq0R/X/ptwNK9z7p9h?=
 =?us-ascii?Q?REnuixTiwMmyTgN2u9oNyjPbsBX/VuE8kwk8ZCUqS7L+pMBToZx7cQxls4jD?=
 =?us-ascii?Q?JDofrvooO6pDH4V8R08nkGphxogs6bVgfWZbjnm53vy3Z/IGUCzxgOPi7k19?=
 =?us-ascii?Q?WAoisBYxKCunDOQ/9TZDlVj+QnRtbjTJkxmFr896h4W/Iw0DEYx9jl81kMLJ?=
 =?us-ascii?Q?UFyrp8jIIoIukpZ9qLbim6fCFnHmP8vUkxQ5L8pE3FkMFjltnGnpAUz1WUKH?=
 =?us-ascii?Q?gmwHDSFzB5TKao7GCXmjDfRdcO8wc52vKX92FFlpw0wkgqOuKLZBgaq+r3mS?=
 =?us-ascii?Q?XiZ7owXhO5LZIAHg2nisl/mBtB9SyN08/a3QaGlKM2mb/4sQKt6C3w/TtviP?=
 =?us-ascii?Q?pVtuDuz2tJ7C6qO/ug/it5i+cbf6WdSBK9G+umiSM1xX2aqU2TZ0eSXZPogL?=
 =?us-ascii?Q?u6eLFBs9FR2CZOnF7NP/a0sw+7yiU2cTnWR3c4u2LWGODU4uDsxUdmCGb77Z?=
 =?us-ascii?Q?M8Mt4jHuqEfyj1gThZWVDjsTY8/rPnGkyJbLEeKEbif7dUwbvo7bg46LpRHv?=
 =?us-ascii?Q?ZJWHP5sC/0jkG5tJNEYl2FMoKWhuQ5fT75/NQi9/xhIFlaPNvwqJQwJjsCVc?=
 =?us-ascii?Q?kOO7Hqjukw+A34FGtvEBDFROx/1bOZr6L2bQk7TIs8J7R0TjouZmeI1Osg44?=
 =?us-ascii?Q?li9uzQi8o4SMSb74MR2tiE7SzkuP9gXxXPEPsfffPK4/sPAso5NfIikpAyAl?=
 =?us-ascii?Q?cDjSCeDCbVdVRANrFUZyrFlM309ds9Fcs4svf+rQlrB0FgI41jlGSd4Ocif/?=
 =?us-ascii?Q?uEcSD1dqmuRmseRz2E0cG6TJ+33w+UGFQrR+1GWfrYN4jcJU+Yw3Xi0mkUbJ?=
 =?us-ascii?Q?ByPWcubu8JFPpDWQwm5ub7NFYFTnnP+hWf7PxNP1+Oqzmg3VYA7WhiDfsv3v?=
 =?us-ascii?Q?rxpD3qYVATBsK1hAJgWigehF4hxGrCUouAIn6YRK0Ft6Ovm7ka7jsKroBRvB?=
 =?us-ascii?Q?/EGqG8X3vsZDG0rezkaAV95/xDf9SaInA6Qx9lndu7XSPDmLzWHesRy4AAFq?=
 =?us-ascii?Q?ydrrVUt4fWTsQZpv22gZaHdEowIUumns3yxi49ZdBcq01rbgQ3DHmVPSOhEI?=
 =?us-ascii?Q?US0u8taB+Lx/PYF3GnijO8nWZ2t4hKwfAaY/4Mz2M2SKLLKdZQ7HgtOi6yOb?=
 =?us-ascii?Q?+EA7OK6PUligQBz0yg6/dNYN4O1mWrQ8QgAN49b312BhwEJZLWlA7mZx2BFT?=
 =?us-ascii?Q?xyEBho0Z0zyomOIpuDmSF/XzmrgIYts0PR8TQFk+V0cXiblJeAPZ7ImwnMuT?=
 =?us-ascii?Q?Wr6Cyfi5kRBxuxH1drwIYZJU4KxqU6w3/8tTMtrkeQOe7ETF4Od8s+19FO8j?=
 =?us-ascii?Q?KCCsdnmrvzkcq/PArfK4TDyVQBep4z0WQSpAoZyAag7zO5HET3FFqZdnqsOp?=
 =?us-ascii?Q?eeNNAerGWEjoThwz2kh0G7lYeVXPNMhPOkeqvo1DU0DBgGVw59edmEZHfLe4?=
 =?us-ascii?Q?T8QYdMkAKTKCM9BvDuo9w/fgQoFz4leWEuW/H/+E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9134e7b3-b2ec-407c-0b95-08db285c2032
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:14.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkSQVESBuFZkHEWAQycIVUzUPxDkt7mkVyGceRTp6sRqaoduoLfiAfPKXrKwnZvgRtrQ487jdwJs3fkf7ZF4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
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

