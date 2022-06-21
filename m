Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75255329D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350705AbiFUM5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 08:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiFUM5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:57:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679601409A;
        Tue, 21 Jun 2022 05:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5bWUrz5+dLf5YHx1YRGHyyiVg9mSX4pnwSHs0yVZm0W6kAOWyJ2+ySDuedY90cwIqBnTPdpmBF1lofczx25knlq501DzQyuXG0h5eUfnJTM/ghOg3Fspm5CbtfMb4UQq64DH71U7aU0OsRiLg5qyTEmaJfLcLHNz7jIv+ZYrMJmKGadf2iTi9HT409O51kvMT3s/eP959n7mrhs6rjRv6YpZpg8D994hx7QF6G1txMd44znwHevXG9+NKClQyjlIJZEFuyUs2DcJ3w1SGIPn8Urn6PqHR6LXk4ow/z5gf/4Qnv4ef1pvHZr0UbGdglnZSI9AF4+2lALpXss5mOaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8LIvp/0UKx5Ib1btm+RxZY2UH9uF871iqAz0MknzTI=;
 b=FdiLXo5QQoQFQ/Fu/1Ez4dfhmyCqO8hjJvX1O9y+/EJdX93YQaT6Zfov9ouLV1CAvpl4MSQk4g71nU65x9JzYdROssuwMnv9AWl3beCXhYz2uyroIUb2+bc+TdtoUa1VShxEYjXvDa8br+Q9AZHRVy+dp4k7pU9AiXx2OLdCCSERBKJtD6KQ+5cxyY0qaSHK+2XiIbvAJzZcXO5FmzGrx2r7QdRHU1CHU1p02OiOoJB6UNCO7eVbeKVBvlnkVrv9ysLgwkWu9gz1yeyeVtgJSEKnpbPS68UOEveSSfzAcI3UJaiavJ7vwSJ7mezccEpuT86Zgp/WF6buQazAfKZOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8LIvp/0UKx5Ib1btm+RxZY2UH9uF871iqAz0MknzTI=;
 b=HDRIcSpKLn4FZ9AbrYypmKwtT4hJRlIYPy/7bOsRtT4Pv7x3mynii+PrJckqPGbBm6ZOQrw21Vvp5SXiPCKyFp2dX2JQ8P/ABot8al7Na82El7YSQNkJcw45ZuiTe8lHiQjLTvhJY8MZMKI/saQO6f9dffAr0pNpvMQbGjqONtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by SG2PR06MB3872.apcprd06.prod.outlook.com (2603:1096:4:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Tue, 21 Jun
 2022 12:57:04 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::9c97:b22a:d5d5:d670]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::9c97:b22a:d5d5:d670%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 12:57:04 +0000
From:   wubo <11123156@vivo.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Bo <bo.wu@vivo.com>
Subject: [PATCH] fuse: force sync attr when inode is invalidated
Date:   Tue, 21 Jun 2022 20:56:51 +0800
Message-Id: <20220621125651.14954-1-11123156@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba761d1d-98c3-439d-e7be-08da538589f7
X-MS-TrafficTypeDiagnostic: SG2PR06MB3872:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB387218309BB3AD0C42814EF592B39@SG2PR06MB3872.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atIGXEN1gWqqQ05iNg9dyGEyBqCZajqF8dwJMrfYyD+xIJwY6nVshdqikibz2H5nP07c71+l2MYpBXvtzD8pbt2GbcmClLklyazZ8H46BB2HEk3gtOYXhfZt1xPAzsiU+/vxJeVtClzlBNnR9C94DRFLRdx7KQmztqJEhxEe1tQlvy9xo3fvXvMkjUVYTF2EjzHb/ObJhb4foI0vZmEZGTL4Z/OQl2kuvz6lgmyBtqJUIHS8GCnW4FxXvC8/TvaN6hYdCsxSfPfmwuIdAxRtduRXyTgBOG/eIC9etvtH85Z9/FHv8Fm8ci9B2RgS8ndspCfBcbk+qnxY8IPKpfWQMQCnZh/hlkx1CcHWcBMXFZUjTQOkVaKHmwCn+QSVcbhRfvNUZOXaitQi8CHrF7zcETJvgmOxs0ltxT4AkX5AkNdIr7dpC+0gwIdW17Cp4lNoRDd3wrKrm8WbwPZUDkyQI3xxM0vWCfW8Pa5pEmoY8tzkqEElAb9zO1cr96ExjZ9CGeZuC3zLa4z6Y2HdNpGpW5SD7vaqZ+mdRtJv8ogmyptUG/Zj5sWBm8pEfuY175WMGckWQfbDIIn8cZ7auZMOVkbv/irLpqNf2YLp2SS7MEbAu0sTkeohEHQrTi8WxRE4r/6uignMZQZe4/lHpMgIE7eInkSpquhGBffw6xk0yR312UmlJ8cXLkwXXEcBrbEGTteIRxblJzYfDqdvpvzFZ9h/3yVOY5Ts/ktC21vXxTIDRSRK4hZSmQJ/8nj1Hzgg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(52116002)(107886003)(316002)(8936002)(6666004)(2616005)(6506007)(186003)(41300700001)(26005)(1076003)(38350700002)(38100700002)(6512007)(83380400001)(6916009)(36756003)(4326008)(66946007)(66556008)(6486002)(478600001)(5660300002)(66476007)(8676002)(2906002)(43062005)(81742002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Jxq2C4M93Wh9Hng8C0jWsVeBL1X1tQIzEsh6f2uPm3h/Z/imcvR2UrNqUUj?=
 =?us-ascii?Q?0PZWlF5HkLrCYaDB0Br+tM7439SSl1Y29QhmGKuEoijIFn8LD1ebagArH5Bi?=
 =?us-ascii?Q?y4G+2GYR5TmHp3zhOwIRnTrYv/XGMVZuQrJez4byOtFGMuzh00BaoUffo01n?=
 =?us-ascii?Q?j+kKJfHPf2dA4EFBTrKKd1n4VJgb+k4qvu+AaOuAz0MdlXUnP81z7slYo//m?=
 =?us-ascii?Q?B0xx/sKuJSyYnDDCZpwd/p2Su0Khoa8LcB9vLOf2klLblynoR+hN4BNg3jJJ?=
 =?us-ascii?Q?CClir5YA4AcfvIGNv6jAgPWLhROcvZ8bP/tmAK/B7cKzwtN5cRP3lYh6rApk?=
 =?us-ascii?Q?mbNeI+3ywVYossMG0DK9QGCprdFiWOCP0xNMH97jZ5qwEw5rZS9WNIOINfZ9?=
 =?us-ascii?Q?rnfScXnFlgXhzUtg4U4e8CTmcADhHD7tF2lUs1rsbhKETC5An6RUg7ear/gl?=
 =?us-ascii?Q?VWjazqaI82h7z0gJ5wd7Jik1bl3JHwDyTms4EkzcGMKbgMuD/K3otrG0014e?=
 =?us-ascii?Q?diE+mOHE2wtSIgzspsyLzHISpVpyCg27Ag4vhyamrOjz5M1s7p5rSRGP4erw?=
 =?us-ascii?Q?GmpZBy9k90w4gI0BEvEs0K4prtbOQzIwjSXf+NJQ0aJNdxRoFLZItoo/FEfe?=
 =?us-ascii?Q?B2F2afygK20TXy9NYk60BAlHPEa4nSmr8Hm3bpLquxRGBOOXY4MnN1AfUt5z?=
 =?us-ascii?Q?qAtjxVAauMChXPyHB757qt6NiEQ3sSMk3LEtivusB5XBGaN+JI7Z0IGZN1Gt?=
 =?us-ascii?Q?CCpqgmdkA4S0jHoELlYWETxxwJF3AE8I1X8AM5B4j6Ri/88P86hWapuQd+E+?=
 =?us-ascii?Q?B2rbMDQyXQ5U5BX2alD7SIwjDiJsyEoupsJc6aT0fPUXqRIlnSoKvkD73fUd?=
 =?us-ascii?Q?ArvnXjJPl/6iYps/Yv60++xKV9wNiTwGPtFWj4U1scJ0jnr4DjhQvVWCO0IU?=
 =?us-ascii?Q?Lqpa5bg+ClzI7gx3/p5ymo8hSVqAtLWC+qCu6li9V7/sUpj9PZeQQGgU/BTp?=
 =?us-ascii?Q?E+SZSFn2UzrRaF3/oDCZHkAXlNyI/U+PYGsLlBv0Ru1+oDhtuQdCsdb4NPBK?=
 =?us-ascii?Q?jdgTWNocaVrWqR6Sd+gs0/Fc14MWgu8yuVX+HJ8aRnE8CxEH4PPf70RFnZe4?=
 =?us-ascii?Q?YE5yImvD8x4K48OCjlB+qYRuCsf/HlqnE7WeGy8QCwTC+9KYCbgI4UEJWulO?=
 =?us-ascii?Q?nWQUtf34hEt5w+VDWE2AIqiQDuxLRV/kae7SwWQITsSYF72TLmtIaFi7ohxo?=
 =?us-ascii?Q?AVRBs5yLyYaCWJdL673bCSS9keY9UC5dUA+I2gEiM/p+g1+hcSuLsUpmJ/Ui?=
 =?us-ascii?Q?0xtD/kTvUuOLQ6++1EQ91otGIWHR5NyBt0EUf9dh4l7GbO4RdJ4I25AFTFR7?=
 =?us-ascii?Q?LqTbYHTzRLc6J4ZVGqE2DH3p+tq8FqTvtTogxCfsc/g7LGs/wOpZBCUdeiu7?=
 =?us-ascii?Q?U1D/xUYRRbsJGhrhJVd3vrJNEOREADzj9hqsux2bEoaSqbXbtKDJJpqw3tS8?=
 =?us-ascii?Q?Xt64kRkTPTjeOKh8BON3Mk+9R39mza56S9eAAUbEYxrWctbpFaNf6Z7xHJHU?=
 =?us-ascii?Q?JEBSlaKa4YU+Yy8aiyaMss7efPePxbiEVsL8vW36vSnHbnCu5fFhM+hLUnxn?=
 =?us-ascii?Q?6I9M59urspkaO1mnPCjNUd71zFtfeQKVnqvOZGukDZnqzofSQOE7wPQ31QtD?=
 =?us-ascii?Q?E0TxuXWXimDhl/bpNfzomxvkJd5lEw+LkG8gboBejnJTv6fOKuG2Ji3fflGm?=
 =?us-ascii?Q?BRoc05Qd0g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba761d1d-98c3-439d-e7be-08da538589f7
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 12:57:03.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDCnSjyP4Sd78EFUqWrIJJXaMQHYmIG7rb1HmHoNszctXO1ffzV6j7JbtKmRcsUP2XlZy6u/zbNDEW4vmCbHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3872
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wu Bo <bo.wu@vivo.com>

Now the fuse driver only trust it's local inode size when
writeback_cache is enabled. Even the userspace server tell the driver
the inode cache is invalidated, the size attrabute will not update. And
will keep it's out-of-date size till the inode cache is dropped. This is
not reasonable.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/fuse/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff8..a4e62c7f2b83 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -162,6 +162,11 @@ static ino_t fuse_squash_ino(u64 ino64)
 	return ino;
 }
 
+static bool fuse_force_sync(struct fuse_inode *fi)
+{
+	return fi->i_time == 0;
+}
+
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask)
 {
@@ -222,8 +227,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	bool is_force_sync = fuse_force_sync(fi);
 
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
+	if (!fc->writeback_cache || !S_ISREG(inode->i_mode) || is_force_sync)
 		return 0;
 
 	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
@@ -437,6 +444,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	fi->i_time = 0;
 	spin_unlock(&fi->lock);
 
 	fuse_invalidate_attr(inode);
-- 
2.35.1

