Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA26B2459
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCIMl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCIMlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:41:21 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92882E34BA;
        Thu,  9 Mar 2023 04:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfoCcPgNyexsoORjyg49muBAy11NYhdoggWYvimjNrDKW7OduxtOPXZ8rQtVdUFF7O0vAhTuc+7npsPk3OWRoMbWkz6r1hDyoU3En44+NPvWQKum8wxIYG9xUCRXgqZq/owlC+dtPqrSe8DJwCN2JbgTwL2AZozY80jHIS93Mhp5C4Hw/GYapP9ixJZQfUT8h5vgsdvpBBcfJe/DlqY0SSazEGBi4Wsf/nDpRq3L6wlHpYthPsv0MEFR1mKEQvv1Uki8x9K2OgvFgpvWLkeqjJNtIHAB7LWNS3QYsCVHaKVxumlj82BP3N4RYp2icnFbVFvBmrlxZpvMlygtB7VoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZCLfrca9skSYdR8l+HEgclKLc+LoguwesGZMfxz/10=;
 b=ZRbtAUHM/qA8CT4u7AQ88bJr+zz5FiaTG0Ro2ZDzqDPk2n6mmIkeiJLmZZQ5sD+oaEMmuu6C5MBcK3HzD6ixz2UDfGPHJFXYl1/JbavBS0Uk5FKOtwYr3SGMJSkVbJVaCVPV7pPsL6iHdjAHZ5o8JFJFUtUGfDwcFeuY4pUL2RtOktdFwpQFJTYQqTt5qeMdHFeQEh8dPzyTKm4RTRcn6To99uvHGXBYKzEhfBCdniD5G6gHQbhod9D22BrUP8/yl00H1ZZdZm8ihcOSeXve2si+i2GyCmuU3E4PvANTtD4/1Xkk7zAuvLSmU5SIV/pVG74/TpZigO/DRtfyJttGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZCLfrca9skSYdR8l+HEgclKLc+LoguwesGZMfxz/10=;
 b=hyLKniLS6rTBrNhznzQIPbDC4q67MatosnOOGRKqM7BKkZfQ+OGSmdzG2bY4xdIZ9Pc1CxNOrOR0a0JAi9N0UaT0y61GmF+geV23Ymy8ig1XLAbpn8XTbmk4BBPbIJAC4qO5kFJPSr1mC5sw778+iDn1XfoKLKcOsByQ4aks/9xoZG89OwikGdQd91vISuzlHnsMzFaYvHy4kteW3Z5ocjsJoXE6582F3p2QeTSCmUdcXTubZgh7HKFJz1Xc7tYxGnpc/LL7HvBKNqn4/Ya1QnPjHTm9driimFcK6J7ylUmBbJvp1WD4K85pcxkia+LUkdyAcpnGJ5Gz2+RJaUt18Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB6054.apcprd06.prod.outlook.com (2603:1096:301:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 12:41:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:41:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 2/5] erofs: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 20:40:32 +0800
Message-Id: <20230309124035.15820-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309124035.15820-1-frank.li@vivo.com>
References: <20230309124035.15820-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: a09f7129-6fd4-4738-6fa9-08db209b941a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOqsWdLTmFre0ldLWcpc4R2o56DkeN59ug2DWaUD/Au9L37DSbR52beOhPm6Nw4Dxb4wPtI/ggiji/8/H+cG4GTWs56N9z3haesOT7gxru3gqn/zFIZ1hSKA9JHgAo2GAtCtBT8pozB6h5kg67BzezK4eobH+BYaIHLzOsFv/10VSLDBH+o3ERIclkfVdjIiO/dOldwPjITSpcKX5JhTjbhp6AX8xiQBelNGrT+IVeWfxNDAxQ/mfdgE1b3mKaltYuUjRlOOpYXgRoYEk1KrzFuUyEDd568XH/zbWMrcsGRF6RQn+k9+31/3ym8IkWZMbOTGlXDQVhHXn5Ac+AfiCAg3p1bduS/KUaUKOCiMihY1f+LhkCmjRVZ4rMIs1uVyx4DLayBg7F7yTiNvzhmBZ3GLwk0ZxFt+y8xd/5QP0T2znm92H6iyU+ZlmX/GM9gLIWxLPo0bd/Y2zNWa69e3nbAtIxVjsRL2hCKi5ZE2CJ7rFzmnZAkERqj/2E9g6MUUTYDDVFqOWwB3IQ2DC6IIogOlJSTudgIJh37SXEBtQcTaELtAEaZ4VuXnGwxfopFo641YrxQQbX0Bk0NUrPpjw4LiYIKf4CPUcFW37ztotNckt4fw05GMPN4tunPr0sBlt+diWbdjWyCi1TMF7WHy1UUYN1TO1d2oMDZiK/YfME/KJoUvb26E7Jicf/Uw107l6NQMP4Tgd1YBTlG3SkMPbqOVkfmBZkXsWJ7YbKRhuDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(4744005)(36756003)(5660300002)(7416002)(83380400001)(107886003)(6666004)(26005)(1076003)(6486002)(2616005)(52116002)(6506007)(6512007)(186003)(66476007)(478600001)(921005)(4326008)(8676002)(66946007)(66556008)(8936002)(41300700001)(86362001)(316002)(38350700002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oqYbHCV5OUKh62SXwdkXr7Q3HdSwdiShQ7hp7AfNvqdsnmFdAjeCYm5aEzNj?=
 =?us-ascii?Q?maqiD1Ul6sQTc2TDZRVDyElYOsBikoYh0FTsJHIdxr9XmVWgIYcxGS/2Zxfi?=
 =?us-ascii?Q?hQd1waeQtLC0tQ2T0cBnzHEQUBsbF48qmgaNuvjTHqk9Xdu5uSR0ao+nLNRP?=
 =?us-ascii?Q?OKD7ZxLIcBWiGlHG0rzcFqTauhdfddnC5ZWdawjTAvS2sjFapCKvSKbryiPu?=
 =?us-ascii?Q?fss7ZBBv+mulFoYPz61XYQD3xZO5OdD64wRqdMlNhyppQVD0tyA9oNTuIFKP?=
 =?us-ascii?Q?b7FMBQ7QGXJ65QFRw6hr9Ieyf38ir4dWAQAx+iwjihJhhIagNPGBSbk3+Z1c?=
 =?us-ascii?Q?YjJAHNOGHpi9635YsGv9VV3+0BZgM/vIQ0QZzTbw5rlNEGmWh8NEiCi+JDt4?=
 =?us-ascii?Q?PQowsiZYxhi8WvGTpYcyFSLzeMt6Y+sFIN/QJcKZC9xGHyJciCHA2rshNx0D?=
 =?us-ascii?Q?IWuSkBP9tQVPnSqLhwohL2zj81UDqNFC0XD1L4q+8brzJLfJ5XY3oSeJutRT?=
 =?us-ascii?Q?y+y7YRK9Td3SnUTq6PxkjLP1xfGGKbTGT4fgW2RIN53bd8BE/cj1dl0ccIFc?=
 =?us-ascii?Q?hLF6scWMx72lJ5MCCEAkpKkr+mmWjgJtM1tqeSpyjknKvqllmL6KUEm2gADL?=
 =?us-ascii?Q?N4sHXT7s5MclgKNPRrh9DC4prbASuiWQrLrP58FG+qJJfFyRfQCeYzZ0d0+j?=
 =?us-ascii?Q?tqR3feuVR9WSv/0ys1wP6PnoO3M9DpXLCYdpfdkb45WFAvOFJ5JwthjA9a1F?=
 =?us-ascii?Q?Djfa4yCJRu7qYvDCQIt03yaN5OjirdFfSBpZXrIGjClVAT34cjCxCrHIEDsI?=
 =?us-ascii?Q?3FGATfH9DEYoN1lwRG7batwX7GKs75BchSwOPzBu4wv/HKLSh94gVJ39VU4g?=
 =?us-ascii?Q?3A1i5nKGpQa5a2s3AcLeu40G7x/wtJYPdupznRAZMAl9Q5getnHVAcDkzFKa?=
 =?us-ascii?Q?+hg8CC9LjYmPFlTwhZ1nlWFVnrmhTkrKZo2qaumKkDfkDwQ1hSzk2P+BmaQx?=
 =?us-ascii?Q?gxI+Pg0GpRQWjYH5pIf9YRwyyPD8hoXnCfMV1ap8Qto/00k9Tx2I8GYffonB?=
 =?us-ascii?Q?ew4SNbhoQygyrIfibUwm4s4B0iIyGBkKnXJ2rYwO3CiN0P7imUoDK4mWmn3Z?=
 =?us-ascii?Q?rwoNpgl781u1QkiigkPaK4ZqzvmZTl0HINRmgtDslfh8f4vee3mUhZS1NFR2?=
 =?us-ascii?Q?Y1RKp79OMTcWUDqOaIy5IQuEaLP3t7YIB1cGMUgNJ3XwFIk8nEHkT7lHd+L5?=
 =?us-ascii?Q?s0r0C9/cfa2Sz7oHQZfXfwcwjYYktI/haja4lXzkTLHfZAA8Iu6QZ1rlRQeY?=
 =?us-ascii?Q?hyOMTEM7YWgeRS5/3UitNKAFxTIDZVj9x3RIajpBMo81niS7bGivTkL9UAKa?=
 =?us-ascii?Q?OO8qPKqwStVihQNZ0acfo9aTX8kQlCv19PgIaYINZCM+iMMrY00+mywMJeJw?=
 =?us-ascii?Q?c8jW4j9eRPybb6pqvsQNOe4aG13wPAEkbky16unEKqoddxWA3RPdVBVls0M+?=
 =?us-ascii?Q?ilReBBEh3/P4Bw7xWsp9S9TZ2fcJa3RBW4+J6DKSpKNm12QDaF48wSTYJMWf?=
 =?us-ascii?Q?V6yYuoA6FMFuCBaZ7ruynVuGOE8YYgepa+J6RV3h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09f7129-6fd4-4738-6fa9-08db209b941a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:41:18.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUURUGHeQDg11Thh+MoMMKA1ajppisEJBoN7569mUMWPFKwwQp198r0P000kDVVxGbsiosGku2qqbTBFYN1qbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-convert to i_blockmask()
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 7e8baf56faa5..e9d1869cd4b3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (bdev)
 			blksize_mask = bdev_logical_block_size(bdev) - 1;
 		else
-			blksize_mask = i_blocksize(inode) - 1;
+			blksize_mask = i_blockmask(inode);
 
 		if ((iocb->ki_pos | iov_iter_count(to) |
 		     iov_iter_alignment(to)) & blksize_mask)
-- 
2.25.1

