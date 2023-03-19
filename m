Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2902B6C0016
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 09:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCSImH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCSImA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:42:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465F23DB0;
        Sun, 19 Mar 2023 01:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWYNzNPrCPD9II26Y6QFdFkrW/91nx0hSrnXjCz1pgW/VWJ9E9kKVgLgcA77M2H67Ud0Mi8QxvNtKvI+urdls7vDFEP8L9itrTkPQeYpWzalfhXyPOZkH7e4NsMbTcQ+n5XLRuoZ24M1LditLRvWy5cWw258IM2AQxFVlK4dpQc1tIEvT7L/FIhH9lSTOZdXX+Oql8OtyKQtqaNLk4O8+6wU5q0+XmiRyeLMHNhENM0nqv2UVl1mC04MQkJUmGz2lHvnxnRlbHfQQVNBtlj3Wt/mPJFDbLXpUd5DdY5JdgrdcoipymskRA5tj+EfhtRfgWslu9H46Zfyk9kl7fG5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wz/bz364FUglJebWbfcyJUUQKy/BWIZKlCTuj/CjAyU=;
 b=e7ae/7RtXWaAh8d9G24kdDNLJ55Uk+63ductEiohIy6d8KErVkTQoB+FaYvezuABFtsyQ4ZrjGvnEpOxJZK2QVnOG8SG9rvmbcvtwh6NHtkX/2+sNbOr8ioHAjZzULocnlAuKppsuz2+/KVblbQweynC1drIVOnaq2/i12gc56Qhzv/cmpwFcDIFtmUnkcJmHoMuVQEngeDZ1icYm2dq8GKUq82ktcTEN4I4eLbsyV29TMR2SRLHolEimIVwuDsJWEKjUHWYYvetbel1Qo8gkH2PsKEL/dOzPsgOq5Xy5UXG8a6OJe8v957+SnD03WrRHsr//CaOwlSii7R+NPsujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz/bz364FUglJebWbfcyJUUQKy/BWIZKlCTuj/CjAyU=;
 b=eGH/2C73p6n4EMJ+cg3Zn/LzdOp6IxPNIYLG0SiuW1f3Q+hWF250JvdlINcnLyiUNYZ5mtG0yfBWs652cBVkUuJJLAes/DD9KZ03YT1Kw57gQoTvsflIPqwb/LphfWLDMItq3jDK0B5pY2P+95dZIvRe7DhywmQRXkasLDPn3lNUndvokiarXohUUKOJgmnzALktGvfNl/vlK70MIN1HUAoYFELyDgeuIwHaQgv8Ew3JHrGhxuXvEFwkVijA0GGYXeO36KJFA7VEg25CwnesGUY7Yuo47E4XvGOrbtXr825cZI6gef5JI/GeEyotPZl/WmjZbeqKvRHw+2h09FbpFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:41:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:41:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] zonefs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:27 +0800
Message-Id: <20230319084134.11804-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 350ef27b-c405-40f4-d31a-08db2855cc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEj+nSGjFVvEfhTAnNSbwZ9HdlcN2SxI1fAjjNqNRKkQFK2H83siJsK+DJFQaGzOuWYOuKd9k5MSB6x28/9oAmOXIrOQ01eYvCAb8G4lOJmu0LYS+EmlfqILtQTo7yBjAV9artsnlmZ6OEbBELhnCiJneIsRxrzptkBxFGv77NfnG6l0JXMwM1X8RhvWg/PtxlR3VreEIsrpSALpFnBiUFrFCNUCyIxiv7xFII8ugggCZDE7HW3gpIRS+3BlITrYIwMNX0e/80TAeUtfUQ7hRHfR39G8UVf8QRalLHBybzuO+Ou3jbWx90R3LQbB7MP0b7EFshcJycUFwbJwjz/t/EnDhXJWSFa5hd+ZN4K1niMICxS4uJLDRSeM2yV/RKiDxzsS+aA5JickBd/JiVHrFEaLVP3WuZ9EQvX89AUDtjUj82bMqPHPtOsPCS1Z39owtWZ1FN/5YUgNEZ5yxdwtu6JXpZcXuwzv4XN/aU6s+GTWxOPLndBN1ii0BA1gyGbI+STQJKVH4U13QJyE7YM6+iEyXHa92kQDgRXUFdQ0F9sVPIoQX8HfC3LKcDyy6ShyekwAubHJayqLEUSstGbFoGVCSwai0f95LKPdXad0Ml1QVKJ6jOI6+GRmULJtZY+L8viT9h7+dlTqGvz5OxRH2afF7w/IGSwU++FuxnPFgzpGJv/h4wJxdDu2ln7+WuKEYWJHAKzQ5/7ePN3F6uZmrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0QWt+o1twEyrfRl4CNoTMRlOp54/P3iTQCfySJlqNT3daK/ezkxCngG/mmm7?=
 =?us-ascii?Q?tQVzxem7cVnVHMF2VrqJ84w+kNf4ICSj5ZDsRwinbMLrAIOw7DJGn7x7eZpa?=
 =?us-ascii?Q?1ddaF+h+vK/k+gGSgpI5qFmlGVlWbRP4CUwdhss8TJk+uObwObIvqByJswZi?=
 =?us-ascii?Q?baw+8edGkYYtZT0oiviDIX8PBNk7G4Nhn1//kYHCm0gzDt1bQt4SryRvIWOQ?=
 =?us-ascii?Q?lh7B6y7MFc3FU19ZRCF3bnFx0kr5/psWBBgvbLRGUbsFjB7ZJhvApQPPGrEK?=
 =?us-ascii?Q?lc6PPub0XBr9I045y7cwl95pplPfA4c9UcIdOa0js96uDPPHPRwfp5EtOEeu?=
 =?us-ascii?Q?bVDd0sG4qRxYkHXs8UcyzMYc3NXPDhs7xaGBKwpYX2tui2AcIO7k0i9hZ3G/?=
 =?us-ascii?Q?v03nWFPhuUpskkecOWMn4BXN1RR00ko4bo/493tq2eCVRvwFyGUy4JD7PIvm?=
 =?us-ascii?Q?s0zm6iXJGUd4SfbztNPJqmiHo1NMW9uX/z4YxTzb+o40YF1m3ykymzddMs2y?=
 =?us-ascii?Q?MWM3NqUzM6DRKlpkGIc/rVjMbbuIWrS74fitJeUYaMR5KZcbOWRvHdP8cP01?=
 =?us-ascii?Q?nge6TB/XL9gHZV+VqideXMxvKaw65cHS//14DBgJdxe2Q16oJZ1E2smVidjb?=
 =?us-ascii?Q?QoLWuVEt/CNPgQKiCIZHLiwCONS+PIcV2EioMXOwQ/VfMK6Y0/qzN3mBxIyb?=
 =?us-ascii?Q?R1g0dY9muzPY+4VmrYK4b5Nad7VVfGImzlSg1Q4w24JJD7uUvS+BAH4aDPlJ?=
 =?us-ascii?Q?8kZ6BhPRxUUcDZ6QQl/oOtOoEChjolnTaDMr6dwu2dA4xIGWFYI5x5/BnE7Y?=
 =?us-ascii?Q?T8AmzmBaVKhh7CkpvJK5/hIFB+zHhRlCuqGfrqAxVXNnIiwWSINJZ95gH6Ab?=
 =?us-ascii?Q?fjEE2jdwmlZr5GlQRdAGvZ3Ggv2qGtyEzV7KuAP02oyrEnZnWcOoLkgLLb7X?=
 =?us-ascii?Q?S10bH7+u2hzAwDyO/ELgG2q8zd0zxfKRoYBY1wMvttaJo7k8YpUjF0w4Ah6P?=
 =?us-ascii?Q?Km8M+Q1jBgb4nXlmgx0KocPS2chFS5wth0BN7vChY9KcQwkX4mMK+XAJGVpk?=
 =?us-ascii?Q?kVKVNwBPl281+DncqD5rohmBdK5Bq2l6IaU29ZsOJ7aKStmz6tiBBbHamb5W?=
 =?us-ascii?Q?Ob2jvXVgMBHdOAkejZH7MTStNTNDnAQ2PrdrDS/CXzyEDiCLY8WnstZm08d2?=
 =?us-ascii?Q?ofz5dEOoFCdvOa61KxuB2U61rBdcAfrd1lBZeUMV0BJcMyesJjLPV3/R1CKS?=
 =?us-ascii?Q?jCN9WBuDPOhuyAn3xmTnHd/yd/8aUa0IaXdDwp/7K9BaHced1025VLGrG/Go?=
 =?us-ascii?Q?rKvOWLXOh8/kWLdlYDSSDjaskSqf8CAt9nGA9KVm2A/eGFnNsjF9rm6scM73?=
 =?us-ascii?Q?v2pRh5lC+mUgGRGTaT47ANhG8AjHiiKy2JdYNXDbUKXJM7Fu7KPcm1wMMJsi?=
 =?us-ascii?Q?nSaZI5j2J50q+TrT4yPfszqmGxrG/UW/Iv8RuHPEAj457yR1NcjdEIuJ8Vkv?=
 =?us-ascii?Q?hX+Dv1NF9evYooXcFRHnpzMzWG3R7iwZatL5iB5546Hz1Y+84dqtbz8hVnkx?=
 =?us-ascii?Q?lZ1y9NB7iHCQFmDvjJhCD+cY9um06VfVLQ7o5QVe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350ef27b-c405-40f4-d31a-08db2855cc21
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:41:56.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKCFUTiSueRP7QLGBErPNqHPbK7GbMcYEmZdQicJ1AWxxjbFz7PLuwSu1BWEmbPErHbGPal/zDBTXSUzsIskbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

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

