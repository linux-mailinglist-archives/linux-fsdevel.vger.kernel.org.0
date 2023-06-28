Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7AE740D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjF1Jrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:47:46 -0400
Received: from mail-sgaapc01on2133.outbound.protection.outlook.com ([40.107.215.133]:11872
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235873AbjF1Jgk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:36:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwtAFrZzc76Kwz/zjT3x/ke4LMCMq2H2zyDvFQHP7ww2GPgL+vKVWAQX+dbtZ3H+M8G8pXSJR/CfFk3DLZD+DumRHh+bK89P1Pd8nn64Z4jZ8252kclmb8QOAePggBsUgNGXe9KjGm6e5uQ07hrxqywFsm76f/gZVYnV+ZhQkmDBcbm7xqcjUjK++f0pJEfLDN5n1Pbhi3QiXC4dMsP4EYwPBC01GBAvK9/qQ9EUmHeT8tn4n/lHMlYLvy8kaF52YSH+un0wN+t0fcNAZ71fbecWPUF2d9n6/qaoM3HNu7NYf/mOsgS8ymNanSmqnQsKfXbKjgVvG+QfLo+e6iEdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wkj8xNo0+zs83L68WDjAFXJ8Wv4XjEBJ8XBECZe66s=;
 b=bT01KhzX4UO9cd3emsWzIDYiVO0iqS24smfk9HEyMrde+CcVXuo/aFcJPwX+d684rdvCyjxBgIMZn3s7j+2mwB4mT/8zVe2YayWW31x6FcNXYSBN0ZdFwdV/+VkHir0+cuhHuip0H7jOrZhZdTnk81M8o1bXLfbl863+vbsqZvxp2/qrItz0D019F02jAX682KBFre27EG+KpBgulzdyUvBpQxNGjJN+fmUyqC21r5It39oGuHfxNL+sV3by+XAaSHXY01QdzICE3sVfBwe8kT2D1cGS8FzhYC0pwC3uFY96l7nhukZLFo1ga8XIfHpmgDEvIKtDA7c/KwaOUqvjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wkj8xNo0+zs83L68WDjAFXJ8Wv4XjEBJ8XBECZe66s=;
 b=ZpxPVAXRd9KbvjmyvxIBRANTQpFo2RN+M6l2Ite0/lH3/7FR/A+F5W9kP7/3R3K6NHmBhe9pH95mvY3D0v4oM9mZPKXhrCA82pdnxS/JPeh6W+aMW8z07yufrz/9h+sVcSIBzFhFuBcsHJES/T60F7di8t6zeEJlyAXAjDGw6NT698Bb10GDvHXCLpHE9UIeVwJFnbucw6VdAAQQJYHWHnR2aGEHWz4hqo0Cm6kemuC7lCq/X9nWoXyzIGVzgHcAxBSDwRfd8Sj2MwAHT4/PcKCjMUEztLmV0PZiNAUtSKCa77NUu1PZfHgFKPOolU09JhFj9mkckVuPR1I9w8LxZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:35:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:35:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 4/7] buffer: Convert to bdev_logical_block_mask()
Date:   Wed, 28 Jun 2023 17:34:57 +0800
Message-Id: <20230628093500.68779-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad21436a-a05b-48f0-39a2-08db77bb0152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YmnjOmc/PZCBmVPMSA50k1YMnct/HnfZ/UkiP95crG72+t2IMAuMaR4UO1SEKKapZb4tJM2iN2HUz2lpnLv0FH3+3/VRnwJueCAvjgbYaBBYhNgkN3D77ULU/4QsjhqhjdPUyp6+c2SnKcPVTdNFmmCgbkozcOG0l0MGBe4fgcxA4PPpnofsaJrVzsIiwJecRq2ju6qaqMDo6zkFpULoRKzxzfSMuzpv67TUKSJ4mFYFmwd+rrsaB73ovpkppyEDasjJkxYNrSsEWierzZvOFMtcoag5e9OaSy0nv9PVFheX04Tjh9V5I9O60GqaxIKBC3/qhRTY3lfwGu9V9nKe8U7iGYVCKfbMfXVvhZMnrO3dvuSRAdGzrh6IGnBAH/paaqIss8TCDaRGYYUa0RRu7cC8MC2oxGu4qYHWcCmQWkX7XiJuZN3CmRGTc5u2Orts/qf9BbVTeuE8L1l5MVhSOv8BDAWJUDGOH7z+zd7JF/N+oukfdxdwi3hkT0sSyX6pK/tAPVtAjRyC6ed96O8QiTMMI+0N753+E7bflYxlloYMtLdUTQX+bIxNRjgV8SoUKtRz84ax5RuEaOnHVDJgmp5DWXXbLDrydqrWbc9MxznfVL1LgQMS+AxwX94r3ZB1pTAiXjzrKKdi0WPuOjjSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(1076003)(6506007)(7416002)(5660300002)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(4744005)(2906002)(6512007)(26005)(41300700001)(6666004)(6486002)(52116002)(186003)(107886003)(38350700002)(38100700002)(921005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67LmwitXJys7m24x6TBfrG/aTRgyrxIzKU32K1YwacYxLn7efBBdkqlrmPvx?=
 =?us-ascii?Q?zeAMvgn2WMZ4cYe8kNEQhe7UzTD1Z+BrCqRJyLqGg22+5oN0RwvNHpidOfAq?=
 =?us-ascii?Q?5RE0yzsRCOjtBz+cKi09F0hrz1bMvwRYVACfRQZ6xVoh2NcV+stBuOjuVj0c?=
 =?us-ascii?Q?SXPJZzz5Kwv/xTUtcl3LcoZEHLG7WoBdAJ1uVHaLfy7ICOPe8v8six7WZmF+?=
 =?us-ascii?Q?4RvRJj42zotlGh8zWA4aJpfAXrtLgmoKNdE/IeEsQzvBmcMN83SL1t9Xd9AK?=
 =?us-ascii?Q?UcHUg/elPDtiqupRJVGxytMQfbIcTHNvgLR+3QZ94+T0mMgJBJI5OpKBJwxE?=
 =?us-ascii?Q?p6thAu2qLymDcvfWBwEywVTiKGD4hMQAW8ze7Upf7i/5AH/qGHRQIsF6K8iK?=
 =?us-ascii?Q?JEHFNoqIaDBBSWl0WKjPwdv//eV4s9m3yUr6ieNr8n8h9plbZ5eMGj3/wT5z?=
 =?us-ascii?Q?i8V/InYQ29Cl6P8USQS4WIuNXtS5uidAsxP/WOQgObLTbzeSlYt3lTrqRBkK?=
 =?us-ascii?Q?A/Lxb7iGDmUY3FPIJh7sDBtL4e4d2OXcJMJmSppadZc2DdP1XhneIGvYqRUu?=
 =?us-ascii?Q?dwUz2IGcMpxmi0f08RLt7NU06pxWC8BGBAtDIqd3J2BYBvTH/jEiZNx98zZw?=
 =?us-ascii?Q?ol6cgA125q3wyye7f5K707xsg3X1zw+WZHNyw/d7AigJuxyzqSLYy4IAx1VQ?=
 =?us-ascii?Q?tGatp0Ua+nPVt9ctxu7xBUHUkR3bz4RoKdE6BL9N8FcXgYmo4enegUfFK4yO?=
 =?us-ascii?Q?26Q7h9FeFZTYcb1CnvLhXYDJ/Y1vOe6DzW4BQavT6FKeyC51q4Q0QReAxInG?=
 =?us-ascii?Q?ufsnUHhkW3WBx5LJo+ogVdbKjIivAWg8Sw1nM0vrpJL9F4s47a+hhD+W6aKe?=
 =?us-ascii?Q?sbVTFUxF36yx09c69+W+sjrxQaFPrY+XP0Dh8NrLyv+jCKXNz7fR7atLOP6r?=
 =?us-ascii?Q?zyTOKQG7SUqXtADamzgnXeVLhe3oLAvuBzk/FqfZFwWK1aGdy5S940GpYxA0?=
 =?us-ascii?Q?2DEpkF0a4pg2iIwzJkCaycJJfY+75JSTk+1w8T1cPcDK935iUWKrQt7YvcO+?=
 =?us-ascii?Q?QwvxjeMsqO/kA28CdJnFW5TfDP6PbtDSvT4N/N0UUCbN0cqNjo84OGN57lEe?=
 =?us-ascii?Q?pX+NAQitgregYzQi6tQg4ibrWMIZwrvNyFt/PVZq2og010EmuiAAq7rp9zXF?=
 =?us-ascii?Q?1WKLgWm9oKZ7iAvz49Xj7/oXhjuQE58foVx8qTfz4KBln+YtSRY/7azmVMpA?=
 =?us-ascii?Q?38AP/yZyc4uH6XjQm9nu0D3GfC20ttv66Ru9OgW9N2c8SJiBXvXEjXXVMhrG?=
 =?us-ascii?Q?Cc8uwZlRpX8KxMRvS4WfMikI4FQAxk6BA4NBia4zVFmSF7wfzglPXkQY9ofT?=
 =?us-ascii?Q?SrKxMGe3XlLjiVycXuV8C46zHr2GXCJnB4VkeCncfH05dOUzDeTSwF8IMR2y?=
 =?us-ascii?Q?MaSzNdEW8MOjO4F9gJtdTjojDkEzLoXx1wXcY5LstL0BxYiB1C+8/XX9yiu2?=
 =?us-ascii?Q?xCtItggi3IIVoGbOI8SNjkuGOXHEiN4IjO+8xwOkQR2Tjmb91C3ThHYaW8wn?=
 =?us-ascii?Q?+I5iZ1BTVe/6JsZ5ii5o6QQ+tVdV8DI5lFWY4/Hq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad21436a-a05b-48f0-39a2-08db77bb0152
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:35:26.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q2dALsHz4D/2FCng2DqCwpWJtTNbDjKL8KP1Ml83WvhperSYxRjV0FVDcZmn8aNvltGlzMwH+zV2VWUqY2asA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bdev_logical_block_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c..fd2705465a5e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1128,7 +1128,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
 	/* Size must be multiple of hard sectorsize */
-	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
+	if (unlikely(size & bdev_logical_block_mask(bdev) ||
 			(size < 512 || size > PAGE_SIZE))) {
 		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
 					size);
-- 
2.39.0

