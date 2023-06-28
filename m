Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597F2740D72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF1Jrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:47:55 -0400
Received: from mail-tyzapc01on2119.outbound.protection.outlook.com ([40.107.117.119]:38454
        "EHLO APC01-TYZ-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235748AbjF1JgK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQHFd+OoQA7c5uIodhzwXqZQVExQRmB/45fPfFwOvHKJBywE2yM0RMTkcaRvNYGccXcE64fGJyjYc79uozKAtI9VrgFaoX+XfT1VMIrWnAlybxzg2nx8IWSo1KKUiLhe6tedC8trV2BWBc0Tcj5J7I1C2ZFYwBG4zB5bwNv3vldnMC1CIj+Ejvy4uCWdRTUDLxcVeA+Sx9CjjwPlVzHemoFpPdpkM0yp4RfZXkUrNiAXE5u3yjBq2ykepSfqImRkGKVMBYn1kEczKl83ZOTwT7vIEvqzctJHreigTgVfVVt+EEQfpEmOdejg8IgQ/vaQ9qfmw5zsZT+oFGbHRIyP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RevQJUfiyRbn8eEH1zSheGovhyYz11yL9wYLmwRTbhY=;
 b=PHJk0hiXs0z96DEd/+dz1aOAx4hVL1BIbbevIfuWDG3ZBQtDc+MEMtML7GFW128nR63L3wpY1pd2m6wWoHHppRYqxomp21Yo25Avvbwvw342Zw2XEzlrGCgG+tcA2/JLJKwigc5xMhizSyriMQRcsKsEnt86xRh6FNLRNZLPf/8y+d+biTgAEIMSZ8d30pKMKjRzioR3sl0s5xbHhRarBB5vcrGBDUYlL8bpjkex/y70cFodmD3W29JDTuY+yb5JShkaajDD8eJzCBGFrG+1Dh2KeEuspFWr4nidVUulTk/3K+QBDL4UmW/ZDjXRB3Dv/bajIrD2n2owD9SKbK6oMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RevQJUfiyRbn8eEH1zSheGovhyYz11yL9wYLmwRTbhY=;
 b=FZprmZAFsn8WOc8jIedFlyqRL8yZqM8Q1Noq94x9UraWhLSjqqkR01Vhg3ja6vWa8iwo8Bj1G2eHiIwymKTkNTrXgnKFvBOB0q5FLQ1sm190gut2uV8Mi5yWUG6I6ImO0kpcEn8ZmnSc7lbdqEbhKz8ONBOz8OtPxBhwGg0TUJaE73m1AZwTBl43PAHIZBNGH3TKuQi8q9GktJDwFcuKHbzPHD+W0l/GuaXCMQO2kfql3r4mVRsZK4U2yaeE+fRCZArawe/rVa1r8L56p2CxFVIZH3hwdx7C5owZhK96kmRv2MmTJc2oIeZ/0xJ1DVzw0lXr7JQg+YRP26GIeCieDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:35:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:35:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 3/7] md: Convert to queue_logical_block_mask()
Date:   Wed, 28 Jun 2023 17:34:56 +0800
Message-Id: <20230628093500.68779-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: b086d052-bdd6-4a8b-1816-08db77baff73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+TeHtcBaelEJ1Ujg1nLtFTFkN8iIDVKgNBYzVsvEdIZYSuCLGXx1fc0kFXfudo4YV6PJm+sdpLCwG7vWMRV6Sx2kpT8Ws1Dv5tWNs8dhftktwiEqDmQSwurhPmLB7RefCts3pWTFuqWh5v8CO7T4Pol/7y4zkTu3zd5rJxMjXQu5EfAGuJEerr6u/aIvelW2R2qpQXDV5BFe87LAONBWjvuEaOkhU+/YJDlOfD6zTy79cn99j1O+skhHynr0Qt03N5XcOupJcM1abKiQB/MoZ+vZC6iBaotw/mlVSrer8WeTcRTjdhRkUoQrGS0anwOohJ76qsXDPFHMnqRkG+OJal4FobSWeocT/rDjYGq8XZqdQEI4RTNUG4TAnYQTnvneqhpXHvVUkBjEpyaq7wu6lYfRwtfPqvlo/svmQ8yV1zdXp9LZJGS9ogbY7nbOU1B2tF92ViLK924IUkaa6s82B5kxHpy3fiYxm5Jf1XWmO1GE8fh26wuQJimMUK8ivSP78ghrZvtP/zrRUBsHRIpgPwAeGUoX1E76MFj+ENyYMHChX0CdFKtPXscrBgME+nqMDGQD6T2bJ2Mg+LQlWEDE6iBCXlGwYmGfxJOYSUjEHwj27oSJAm4dUwuMbHVNRINKlj0Lfx4AMJqU2XSohrwMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(1076003)(6506007)(7416002)(5660300002)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(2906002)(6512007)(26005)(41300700001)(6666004)(6486002)(52116002)(186003)(107886003)(38350700002)(38100700002)(921005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jbuJzBLQ7CTYO/ZyDNTjISEEjfVXBNyoacZC7M9wiXzQF/f/fSO+fmqH4mxg?=
 =?us-ascii?Q?PdAQ0+LwE4j6FR4Vxvsbo2WElcaM0jjFx4eSTuUSBHoWZZ/D8GhCTdhVASQ0?=
 =?us-ascii?Q?V/lRTaLVey07mlmvmQbLHFQF7f/ONWGIYBuMIYUCfWpmPxdX0E8N0C9GUBv4?=
 =?us-ascii?Q?Q26DVcBEJRhVbTeQrWmpO2VwoN3kfTOeh7kp1WMVy3BSX1ATc7b98Dl40P4Z?=
 =?us-ascii?Q?T9YsTKwomOKBroDBrCZf9pphyaM2p61xu+jToze7Coy8aEl5wjKyD5FwhH7i?=
 =?us-ascii?Q?n5raCyZ3OY7yKDdVAAKTPclpjPWHW9DKH3TzgcyIyjFetsQEsW1ChwBJw/7y?=
 =?us-ascii?Q?VAAIJ7zOlesk+e5FJFjSlOJQqbTU/HZqeI0MqzP5BFeJXxCWAuT3myF3lFPT?=
 =?us-ascii?Q?DWc155gJVCeQ4j4ZZye3JyBP/0ilcbi9ZMtVcltIhy4yk0vXynaQBo+6jmwe?=
 =?us-ascii?Q?04WsCUTynFcbhhlIHsNylso+Hygh/9R3lbfFpReEQaXDNAcUzpj4spvn0YAd?=
 =?us-ascii?Q?PdAE9z9CWsAk1YXFPw8y7prdEfB7AwWkI1j48YcZY6dNKW/FkBv0i8f6SfcB?=
 =?us-ascii?Q?E8WquNXxLLaffQYmB1xi5oSJIQ6uP4cSKahkpAZHl+hLxWoX9/494jUVOpik?=
 =?us-ascii?Q?fiGj0klXxJrYnJ0ETjXWgKIpNbtgSvcPNYsEjs+xV+Rp+Arny7ihLengB7/S?=
 =?us-ascii?Q?KZjulh5m5R5LkuglD5+vxqqfB89aNq6yMj4dKFLuu4gaM1NtGzYa3Fl8Oce+?=
 =?us-ascii?Q?hXid3KutoR8FJI8Z1GUj+jhkaBV0zXRodXXN4FVM0g6vQuN3Z/koqwjX8UP7?=
 =?us-ascii?Q?D4bQsn1x3UVclxEAoXwR2KRmzuL+A1jInJLwpxixQ9WjhBeYl2Ox3urEQl9/?=
 =?us-ascii?Q?tPOm7vGAmoGMCUUwA6AkB7bI3zLdkV/NedscvUY5E8PpDCzorno3CLgi6uWD?=
 =?us-ascii?Q?Xux1ai7Ojn6HOYSaPgsJ+aqttFdcXICqDI9VfREBTgq4CHX5nd7letSBNLul?=
 =?us-ascii?Q?Uy4Oek0nHySLA3KfNwB3m+hWoNOyjPWiHWij+jdA+aUjNNyY+F3BxLDJB8oP?=
 =?us-ascii?Q?GRLA46y1+24tADYHB8pGVJkCt11noohEQyILY0wgy9u5wHPU+c0CN6pbPayI?=
 =?us-ascii?Q?Yjvhkl5xq6VTJSUzFLGvqnHpPcyd/QxKha76D2WNLhQXGxfxwXtuhHlbQTov?=
 =?us-ascii?Q?hnU3dWHcEfWjNjDWrMjKsnWSgak7rG9OL1v1sYlBXCm1ASrMevGZNtvJmkmc?=
 =?us-ascii?Q?go/qi2vbuzrD1YxtaOK5gtFbAX/6BSHtWPRBrrh+Ic+Js61cqlYwXrQCO8wb?=
 =?us-ascii?Q?iI7g/AXajpXYVOFd+6hu5XXmS+/8nyJs6KbCkjd5sdC+OwL60AYNjAtl2653?=
 =?us-ascii?Q?G+Zd8uHcnIbEwGOWGtUE9qvPntSnUXa1rrvwBIhiBqTyQXOOhBVyTlpXsHKk?=
 =?us-ascii?Q?kz25+CBbSXznT9AvIYwaaJOopfv6GqYvYgnIRCDkHDOPmdDmjsRL7i50MksJ?=
 =?us-ascii?Q?lAI/OUsriCFAYGR/jS9IUS+SIyy2N8JRskocQ6SYd4D9fZW/wzKr0oDzX7ty?=
 =?us-ascii?Q?zfS6LFCaCOW99hAqtaXZPoMjFnFqlPWpABrJXRto?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b086d052-bdd6-4a8b-1816-08db77baff73
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:35:23.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fijrr8w34IvV2VgqLajcnIebXYMsMjFJ/xtol2EGGjr9av/BUgkFrCmpdms5OS2khZcYtVQRqVONCBFUXGvcmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use queue_logical_block_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2e38ef421d69..fd646e5ed082 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1649,7 +1649,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	atomic_set(&rdev->corrected_errors, le32_to_cpu(sb->cnt_corrected_read));
 
 	rdev->sb_size = le32_to_cpu(sb->max_dev) * 2 + 256;
-	bmask = queue_logical_block_size(rdev->bdev->bd_disk->queue)-1;
+	bmask = queue_logical_block_mask(rdev->bdev->bd_disk->queue);
 	if (rdev->sb_size & bmask)
 		rdev->sb_size = (rdev->sb_size | bmask) + 1;
 
@@ -2062,7 +2062,7 @@ static void super_1_sync(struct mddev *mddev, struct md_rdev *rdev)
 		int bmask;
 		sb->max_dev = cpu_to_le32(max_dev);
 		rdev->sb_size = max_dev * 2 + 256;
-		bmask = queue_logical_block_size(rdev->bdev->bd_disk->queue)-1;
+		bmask = queue_logical_block_mask(rdev->bdev->bd_disk->queue);
 		if (rdev->sb_size & bmask)
 			rdev->sb_size = (rdev->sb_size | bmask) + 1;
 	} else
-- 
2.39.0

