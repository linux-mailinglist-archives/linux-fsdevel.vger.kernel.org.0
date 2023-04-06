Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD56D92B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjDFJbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjDFJbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:31:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98410FA;
        Thu,  6 Apr 2023 02:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcFmYr6KYwAkosT5TDH2roHuJ88shha0kSK+IFYEV/ccQqpiDU7Ewj8Tlri8k0MAhSkAlAlfFj3TDCzw1FWt2wBslFTCcyOXbI1lXLL8M7uPgIRdhyCAtRbIyfFTm9XwcKuC9bH3Jp0fzUc1XMWDuodTUE2ER/Y5pGOphzLyABWiOR+Jrcn6l5ROqdo+waSoThg0GoUAOowmLSFZoo2oljGwI0tUmIWb3a8wPqIbe50LMFPWJ1EyFAPK2kFevQ/66O110KnDDzOqxQQrq+Q8On+Ba7Q9pRwt76Frn4CqY/G208OtvaVcMQhScdPjPjm8jalsYuvW7/jjvEQKT6kypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zqjim39DIisZ7CZ7Sr05kyKwRd1flA6zfSGRc5ebc8=;
 b=Pk9SkjhrjPFCpSdEBH7d8coDnyPF6uW7GD9SOj9OgwREg5We6Su8g/xNloaqGAB7nxRjJJinnlrf61fAZ3TTr/bXGcw/eS6b3sArslwe8n6O7f7bWu6g5gg35JNQnTTlH4YNvtpT7jcGsIHn/80uitoH8DjqbYMAgKA/3V5x2/ycKoliGx/4X/5kQ18s+dnrJUaq20OR+Lqz9VS8Mg70PBM7gnN8GRFjCMSImogI5QZsxn6lmkadocXGzs4GX6iwJrOvRNXlWbIErDqBrvwFIDyreuLJtiVKkXZB5jy3a/daX8FT0tZt8rvphCRMSllGzsBOa3qgpEbP2g1tAtknZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zqjim39DIisZ7CZ7Sr05kyKwRd1flA6zfSGRc5ebc8=;
 b=nT90jryq0ZBULWCGCQL9k0EM7pJFkXcDMPjWcQG6L+5VxcAQiJK2Qi9lp7Far4cW2mONoMp557Ye72vUjmaK17p2BPiCP6YdLLIU4//WVJpcRU/eU9W+0KOVeK5hai6DodpQHLvUuxF29x9YES4HB+PZBGcBRLyMS5wDQ1qNEKIbcIw4HFcgYyKqOnRS05y7t1t5BErdAB8KwK6Mvh5cs4z4GQt06ZhCVrLgx3HDKAvKvOO/yeCa6o5Mb2kuLt7tW7IFoVp6+U2+Jdv/Vgop8NmV/cmw+PDP2h4a+BhyR1iReFR9tSQdvyO5OOFLp1lFmS83OGPD0YADOih9t6ktpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by PUZPR06MB5772.apcprd06.prod.outlook.com (2603:1096:301:f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 09:31:07 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb%5]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 09:31:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, damien.lemoal@opensource.wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/3] kobject: introduce kobject_is_added()
Date:   Thu,  6 Apr 2023 17:30:54 +0800
Message-Id: <20230406093056.33916-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|PUZPR06MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7899c5-a214-42e7-cb0a-08db3681a653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDHTM020T8uZcPYTGJhHQhaCVRysAeGuI1AN2aI995bgol5eVVdmRHusPomrtUChT7Wv/dbv/NCHxwio/uNOxLfneC0vATPbBLshT4KXauVWNXFzn9duFWJFukGrrjjlXxeEnoHItK52M27/wVsal9CeEN3vP+8B2U6UeCk+K0Aqd3zobu4mKKEBsQqw8Wtlgha4YyXXJ4GXXKgNDnr/YlTy6V89kzoYi0uXEdEdMF740Nvosn/Y4PKYCcjNx9qz8lUN7jtmUFL75EB1hP/1mZ4I9jqTorvuoG5rqaW2L0rFWtm857KmUAcZLMM4xfMMzHcCtTlsNXNqaWuKlRG4qJMBNNs807poEIpQzhe0dUk27exrZd1x/REBflnWTTXfxcY3C9JtNOWmf9IHv/dllZ8PeB63lYkKOU2pVV7JufmU+a0yMkO9cORp56n2bsKu7nVGJBkM69oXQMGnSYz/Q6MUlbxOFcjt/R6lCZCUrDofwWHjeGoWdEfAQ1sXOpBJDi0x9UHVveFg/7d2DYWbo7mvyaAHFMydlCYPtV8eAz1pKUfj0JI/wr43pIr2iTflyTIjGs1opf0CbGZutEhHrZAyC5wvdLbx8OoHyOGlJ6daLLx/dOrIcnoOXh2HhYNA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(4744005)(86362001)(36756003)(2906002)(6666004)(2616005)(186003)(83380400001)(6486002)(6506007)(6512007)(107886003)(1076003)(26005)(8676002)(4326008)(66556008)(66946007)(66476007)(52116002)(316002)(5660300002)(38350700002)(38100700002)(41300700001)(478600001)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3GqxyVR7oFg05vhGpizd8Pupng54OhHyVB5zH/gLqL56uhNUdKoLt1fVjVIw?=
 =?us-ascii?Q?UZTkmuW5plrkumZSIXkQv8rtHiKHl3O6PDUFvzUXet2rs+JZi5k2z+mB48qA?=
 =?us-ascii?Q?Ya5a62yAtCJul5yVAUJ0FN9TfNP8rKFWIA7AoV2uc1s7BJbLkuS6XOUZZHH5?=
 =?us-ascii?Q?FvndXUHUFrasZ7BrDcVnDRhkdVFB3m6jLG9sOXLsDvLmV7RVCMwHxsRTyhx+?=
 =?us-ascii?Q?K1vSWLILCQ8mm/khMV4xSSchVnaYJONqOW9szevys/70d90BGZcGzzex+WMQ?=
 =?us-ascii?Q?x6e6oWi1Wp2nNovU06CFJJtPmxCr087fRo9eL3Pcu90QQk/zRywikP0Ib7v/?=
 =?us-ascii?Q?VZsYG75PKQmDYFFGtfYhqiTajRoSROn5cC8E15HoXUynMtGgAfrCf0gO8fX0?=
 =?us-ascii?Q?50LDgooGNAxtbIh6oXjwKcQeIAFYwbFjTbHhXA99/YIG37+aqPwTjMAPUi/q?=
 =?us-ascii?Q?laNMfCJhv5xTw26Ofq/8h2eWnx2axFGdh1+/kJxEWwjUbmpzLHRtmldsyzdE?=
 =?us-ascii?Q?+QaRZBcDjswF6onWUVhOHoFLQKt2bhsoPVASBcHzpfJJnMLYPaDQ924w5pNL?=
 =?us-ascii?Q?fJDsUl1EFvZvO4b2kDvKTg/XXoGItKk7XmpK6jWbZ8PxXLQykERswG89/kb/?=
 =?us-ascii?Q?EpgmKZ7e/duTL09D09aw/0K9p3KQ0LykxLdpgoGQzBcutg+zr12sGgHUDcBJ?=
 =?us-ascii?Q?MMxJiTCfzhFXiSy5ueOJ8sp2nbPDNPdFiFVFp9+2qsNHNkRLwLPZsjst4JAz?=
 =?us-ascii?Q?3TQTvnZmRcEwrzlHJIpT3ILBeczZzmsmryziDyVk+cMKak7zC5uHr4/Gm9Jf?=
 =?us-ascii?Q?EqKNDhHiQDFVz02APCHWjmXugccIizZGT3NXby2ZnOHMz4C91WI7ctkj4yyk?=
 =?us-ascii?Q?vW1zqCie3zdmxTGFK68XFXVEa/kZY4/W3hwJhsLLuX58tDa+aXooPX14iAzV?=
 =?us-ascii?Q?JKN/ThxWsEST+HMUl3HNAErm9lFzt0x4HvtRWNtWoEWYckxjIZfpDxa50QK2?=
 =?us-ascii?Q?VJ8xP3HExpDWDAQPsM7kx1JM6k5NPaMpzBUGjSmBVOE7XNaac5plBkMwd5Ji?=
 =?us-ascii?Q?0/M7w2accUd8xm8CdPigwpJL8vxOPfg94icmnXHZFvJW0woURYRfXYGBmyYV?=
 =?us-ascii?Q?+Sgugnhb2/d4nZiC8RrV4CYiMTYJziq8V28LJAA/pGRvmIqSNJt5AFODb1VK?=
 =?us-ascii?Q?CVVdIG4xlBi9o6iOtOYF7RH8AHZLkgXXU7R8pznISxQn935pT9oTZ+hd5Jvr?=
 =?us-ascii?Q?KfBXhUQ+7r5ubdg4cY4H0cKmK9BrFewv9QJFHQvu5rYA7nE6grAt/BrvOqIX?=
 =?us-ascii?Q?/tP7Wf64eLOccpegWC0nrtf6RYx5kme6TxTNj/fO47pow7E9hdLyLRJQA2nl?=
 =?us-ascii?Q?Wbiwy2gDisiEHOHhictC9J6mnhwfrmm4V9lkYKQwWrW35yoImHls/OHjTdoU?=
 =?us-ascii?Q?dfcgwzPo4ODP9xjzfRqV5cETj4rQGrthX1moukfcxvSqKwIxJK1Otv2bV1zn?=
 =?us-ascii?Q?YigGaMTvd7oxrUFQ8mSfaPOTDflHBk8TrNTDLMGUcAHIIAhAvluNWwDSvmAC?=
 =?us-ascii?Q?JuBL7XuFbDZHrd1HhdQOfo5vOulw77uK1lSz1Yye?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7899c5-a214-42e7-cb0a-08db3681a653
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:31:07.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0w3m0qMc/Ib2fuDaXngM6BgK/Rl16OcahSsH+iLWeAItmw0atKHKnAXSJZSOjX1/p5S7ERVtmAGAOxdWLPpxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5772
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kobject_is_added() to avoid consumers from directly accessing
the internal variables of kobject.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 include/linux/kobject.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index bdab370a24f4..b5cdb0c58729 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -203,6 +203,11 @@ static inline const struct kobj_type *get_ktype(const struct kobject *kobj)
 	return kobj->ktype;
 }
 
+static inline int kobject_is_added(struct kobject *kobj)
+{
+	return kobj->state_in_sysfs;
+}
+
 extern struct kobject *kset_find_obj(struct kset *, const char *);
 
 /* The global /sys/kernel/ kobject for people to chain off of */
-- 
2.35.1

