Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46805740D75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF1JsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:48:00 -0400
Received: from mail-sgaapc01on2097.outbound.protection.outlook.com ([40.107.215.97]:47553
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235662AbjF1Jfk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:35:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0y6kFIhIcWYv5KcUiPNVIiaOzk2Nsu/Pf+bnHdlVMnqPFT4GPJGRWxERhpIL7yts7DAApbB96tarUuCZ1dsO19GSe4z5x8pYa2/91ZNtnwywehkaoSEYkTyXd5JPH2w0jtnIRhgLZYGedkrURhYil4nJE+Bkwd33WOilnsAjYMfbPfOBQ4CcdkpFwUgr0tdgLAQ5DWMaRBbg+1fEUH8ivrQndcdl41pjqqNcbYn7AliJUEVn0MQcKVEj1kOLRZaAva5TDrhFtFwOSwzNXyNvp3h4JW9nU/1AxHS5HZ8Y2wuFJ6nwrBWY3g8OI/K7f7hG8xe+h4B/zUoAKNPFSVD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAXnQAczusqQD6IX453zsmGlIdP7yO+3BQ6K7S4HAdk=;
 b=MBYIxaUlti3HkU7NywauTf23JqFqSWMPKmgTW9KBzX1PNEtMjQAmi+ZJf6dE071htUXQlzwEhy9VesOwMWtisg9Jwv5XwUHKwpzsi5JDL2H4ejj1nn8pbM1zJjy0bMKmNRJOdHoJCjiT7BqBEvGHtUp/cWyJiSTqVLBBUU99mMv1itwB1ns5AdwWghHAwtZuubCBfDh1gqb/6MXB+N32V2anOIg4Kq/+DeJFWTLHqrAnJK/IxHbBkXJuHSRFTW/XNMRWN4fIBDVMoYZZwO1RBjysnzBDPKO29VyprVewPISWsDWSOexLFqNxgaYCYKaAbLK7rBGUEgUzHcF9qvLXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAXnQAczusqQD6IX453zsmGlIdP7yO+3BQ6K7S4HAdk=;
 b=hPgYK3gEi72nO5gxKRgqZ5AOn10g6ckS3Sc5S6BCheUsxGD/mMUWlauDz82lXEMBN6aAiGwjj8FLsm9OWdZicRaHI9AXiMnV2FORDqYUqKME6q6M6XnBLhH7Rq4HM4zQ5NQss5yHcfd+50BlvgsVb7Qz6PXDPvC3VSPNxWugfE/OoGhbNxhC+7Qv6QUlcqIVLlB+Dv/y4oUBaKlwZ73zInoyOcs1GeEXJA65hYxillbdVUv3IWs6r1qJ5kTtH7qKsLko83kFTrABQoeM1E+bmKBz5UhvR06J80bamZ67OKSkZUPpcb8luXOjUajJh4L3Ca50A0TliE55yYIKA5kYtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:35:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:35:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/7] block: Convert to bdev_logical_block_mask()
Date:   Wed, 28 Jun 2023 17:34:55 +0800
Message-Id: <20230628093500.68779-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8ebca12-19e3-4b8c-1727-08db77bafd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8JeDrbwj/iD6gZ9uhJicEO/1bI+s5MotfSEub/PXuXSlsF+FVeklD7eIYcdkWz1ETg+0KNzroAyBZM07IKeLoPy46SeDByEIcnRb0kcavsyKPuoQ7Vz9vpMfpUsfm9GW0DIs4t/m6DQ00Tsr4dc2tvQuvnFi4ne28K4J9lbh/dHmq6GBRu9FbWsWMIBA6TlXBSqOerEm2yh7mmCELxHYHK/zc1J1TRBsyGeAxOu4M/n0z5uYG6VBbiQDl6K6BLreoyLRllzz+tWXV8/E5IspjdZm1Xc1EpPCgGfoy6AXFjhFPQKH8H96s4hqlpy0rO22ZUunYbSRr5qpwmnodIpUZEwSDhTZ8a5fSffN7EExo+YOpw9LCMV18sijCz7NNHcmCJsft95Ao88MbWpQuHOG/kTzQOdhWRF8178e74m/IhDgN8WnTlHAzXGZ3ToY1hyP0XNvZTJra76/Up+s5QjQ+EqhGfNDM12y/TGm3gZqk8fvgRUbt47e/x3xDKz9Ug/oM+zrwlfOHs/PtmD/VvaMekYH73OtIpdMIc0ubZuFPk4yECRiGGMsx/SyQysKwzG/FU/m/DzxxHT3q8WydsGsxdLq7YyyChMR9KbW6fRMlHglu5n9mqgKH+z20OPtY4BxY0rQRO8XNk3BlC4KKdHHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(1076003)(6506007)(7416002)(5660300002)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(2906002)(6512007)(26005)(41300700001)(6666004)(6486002)(52116002)(186003)(107886003)(38350700002)(38100700002)(921005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LX0sWQpVDDcvDQ1V+VKVSfRkSpklBxl4Qy9rv1z+InZuf10Koh8Rvz/6pfix?=
 =?us-ascii?Q?R+1/KA90x75LfYU6/1c6ey/A4Y++lXjOkfT2yhOHpNTrBtySGFXY1lNo34d3?=
 =?us-ascii?Q?ZiCUboVWzXNaaoasq+RG+2PFcVllvtFFLYuFVPtEUjv8kLR3paX6DQ/mI7fz?=
 =?us-ascii?Q?ceSZa+r3xZjNcDfa9QiogDaphjgK26rTDMuw2/5SrhDo754+F1QDnWy5q4qB?=
 =?us-ascii?Q?Cs9u9NgD0MfsSkZ9pnWyLSUV14dSEmQuIDPj9XI5Q7app3CHEBelNaBnFGL3?=
 =?us-ascii?Q?0OJKaxrfTnFVLM8t4dSYfvzMEbozITfSPwzTFk4e7VedhM7aWoHCHNZaY58K?=
 =?us-ascii?Q?m2U7rlafL3DzgcK5NUUG636CTUUf1XZasOQHn98jyT6tar/ZNxBUY7e5W4+m?=
 =?us-ascii?Q?xoGgMjWchEXREz+wPZK2F02OGV13xVBwFWWvzsuACoOEtXmWK+vrHYUVjS1j?=
 =?us-ascii?Q?i/x3ul7EauHN45vkKm1j8uMFcMG8QU8tyxrQF2HiW4oCuErXrEkPaMZEQbqe?=
 =?us-ascii?Q?O4cTbfvd/+KaiMYvnu8Tqvrkdc58TJLnkapWpr8z/VN25YwP4s625ztMb43v?=
 =?us-ascii?Q?FijV4/WI9+qWPf3ZDIUvgG0podw1ZtdnAf2MRj4ZzhHtSXd6d9+RCPBOkHMU?=
 =?us-ascii?Q?6Py2OktnYKPLKpphrJPCUObfHEWnrffV4If1AmRWNUjYzrc5eHj443EzzmJ6?=
 =?us-ascii?Q?dRcxWcPiVTwkYek0Ai3+Lph+G3jVqiHSN6CKVlayZf9/a8D61eS/WXmmM+TS?=
 =?us-ascii?Q?jFcVKZkdS+pC5rn5EHPA3eceYre+gbsQTMpIUvpatkpd6rBDm7u8JFU5zPNb?=
 =?us-ascii?Q?sK4DDhMT8ZHNfk729v3rPMnNgfMXfNBGTdysoMApRDmCMIhDW2nv8RBzXb/o?=
 =?us-ascii?Q?vfwtd4Yts+A5qXs2+FASZgKaocpSwn1N9x8TNDROc//sBUt63Kthn+oTSexE?=
 =?us-ascii?Q?PwJtEV+8UURCHXiQXaFzuSdmSwaBGN0i4ZGo0OJmAa//B6/v/1Icel2qlGDe?=
 =?us-ascii?Q?rsCvzV0eaPbSDN8f4Nmdlha1saQwGhL/nQsGjLUCSWu1aVABgtclzYWji47T?=
 =?us-ascii?Q?3Kgs27xIGJ7P1ducKG0Ev4tjN/wmOXM7ZyuPvtvnGSsKAYQcmIlZLn1riBBV?=
 =?us-ascii?Q?1VF0h26+MIKYpLn+yV6DJMJoooOa4ZNxk1o+hvRNQVwYsf1fsmImVhDhiGNg?=
 =?us-ascii?Q?cXVJxMJTiSjKodt9iOGvMN/dm9LDnA26wbftueDfRWj3/H5MbATHBCtMrwV2?=
 =?us-ascii?Q?Og1JzChfkYgYFp491GW3dCQg/oxUQE7VoMz0WnmtB1Tt5cbC23fW9qF1IlUA?=
 =?us-ascii?Q?lxwK6iYAUnJzEX+YT4tQvN6puGKlik1Lkux1WBsWwjLjZPSO6dQcB9+hoP7m?=
 =?us-ascii?Q?eIATPjJjceKhUD+mN+okPpWbW9yuqGVjpibMya9kR06v27Z3f+bioKECV5kt?=
 =?us-ascii?Q?x7UdIVhhAwM81W85HTsdVuskiYF0m1jIqsgbakFp126u3GfkzAf3XrLxpAMH?=
 =?us-ascii?Q?hRI85ZdBprH/gCkW6dQyuH39MJF/tAlo4rALuD0lDtk2Ilvv/ELHeKevjdHP?=
 =?us-ascii?Q?QuYfwUNtIlT8pOPA9GtIMGcI2vustM0qcTMKptLO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ebca12-19e3-4b8c-1727-08db77bafd0c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:35:19.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0O99hSNbjJW7oxyNZLmkbD4JyNKH8VKsKtKgMGnsMCiTAx31woXz6m1NvqIlke/V5neWq2uO5BwFDsPIEuBKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bdev_logical_block_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 block/bio.c   | 2 +-
 block/fops.c  | 4 ++--
 block/ioctl.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8672179213b9..42ccf5a21696 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1281,7 +1281,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 
-	trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+	trim = size & bdev_logical_block_mask(bio->bi_bdev);
 	iov_iter_revert(iter, trim);
 
 	size -= trim;
diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5..754f7014172a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -45,7 +45,7 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 			      struct iov_iter *iter)
 {
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
+	return pos & bdev_logical_block_mask(bdev) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
@@ -653,7 +653,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	/*
 	 * Don't allow IO that isn't aligned to logical block size.
 	 */
-	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
+	if ((start | len) & bdev_logical_block_mask(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(inode->i_mapping);
diff --git a/block/ioctl.c b/block/ioctl.c
index 3be11941fb2d..8544702d6263 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -39,7 +39,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
 		/* check if partition is aligned to blocksize */
-		if (p.start & (bdev_logical_block_size(bdev) - 1))
+		if (p.start & bdev_logical_block_mask(bdev))
 			return -EINVAL;
 		return bdev_add_partition(disk, p.pno, start, length);
 	case BLKPG_RESIZE_PARTITION:
-- 
2.39.0

