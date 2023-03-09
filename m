Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214746B206B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjCIJn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCIJno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:43:44 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6853CB057;
        Thu,  9 Mar 2023 01:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bybth6rCiLFPcMFw/aDdfkZEP2ne+5JWWdJ3I/MlKZratAksTAHVuukjR8xu3IuxkAQILHc+5x4l+TaPI33xpm9NNWbTU2WdmSIBkXMByW3GsxVdk7dFtC8CONThw9/jGD+MpjIBoj3ZBk0wfrPDqotwW0rNETQtN856LvrJ20Gtr7+tivv6SoZ4PZznX33Hg55mdRsEczd28TsMu7gzlvSBiqbNAM9whVeNGvoWFmk8OVVaAO9BqzPuUvmwjUN7IwZCrUo75r8TReOFTl35460cSovx3uH/fmlCU9Kk4d1j2+NYo+m3Ffo/4UDj5bQkDFnHeExJv1UN+f3e+0hMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5W73HCDgCnJlmeloyTNe6UjFXFiXr2cZohcMf3gTf8=;
 b=airgDPfe/fCRG3wgrWc+5i3Eqc1fEpHj3nsayUKQYmEReZPwLSGVYV+eIE0PYJZsv+Gxj2fH2A40LRJpjb0N2/gQFQ98NVmi9scoE0u3AJAVc5ukDDbzHbDtcLl/LaElhgus6RifU98tZIsC9l6OAgnhXFdPxu9ZGxNBQGil1kNhwR/7PmKyZNHT5g6rxp0ez4U501j+Qr+MKJbb+in8tO7yD4xxxUrKrsCX2dY9rPVZUBZMorcASnlgEwHCqAB+WiCjoZALgb67fLmat89oDllOKZhHMSw91MOYIbYKVdreed3QOgHz5id1aqIBB6WYLgcVL87C6b3e0eKKZEIJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5W73HCDgCnJlmeloyTNe6UjFXFiXr2cZohcMf3gTf8=;
 b=VVPsdYAU5uQdXI7SXxBvDMUs4+0KalJKyoEhDbM+cK/USnlqCNegQbBQOzU/WnbGO1NmuH6qZVHV6jWxjCkGmqJeJmzTzUl4YeO72kUTDOjD9Yoe/gCD+wXw7eGToUgYTuyfGmY1BN53GdhjoDEvf1zZy1zGjj6Ux7NjF4Brlcsjr4Jlo4bDNA7diNrbTD5fTgsP3ye1TAIjlhD6orSMGlzoIqvIi963V8AVyZ7a7OOOBfOZLzhvG0mqP7hzo+IdjE3v634W0uiErFwIMoBOqenQUdWDQrQN2YM/Db/LCi9I3fb1mfVW7Gt/NJ88Io5d7tmcG41dGOg06aOmALMwvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SI2PR06MB5412.apcprd06.prod.outlook.com (2603:1096:4:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 09:43:34 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 09:43:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/4] erofs: convert to use i_blocksize_mask()
Date:   Thu,  9 Mar 2023 17:43:15 +0800
Message-Id: <20230309094317.69773-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309094317.69773-1-frank.li@vivo.com>
References: <20230309094317.69773-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SI2PR06MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c373218-d5a8-4d07-1956-08db2082bfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16pRo38/+tVOacbF9caxW9PZ1Aw17Ijt/trfca9jzTAsn9vS7f8lgqVIh0pya1rV+B/24JHxmuu2Lj1tbWgW0yxtPEstwUu0zrfudpJapOwhFaUrNCy9eNqxlygyK1sFh8LcyKuS/5MHKqdHsaaAk2e8smjmJVtknNkWWxYspvCmC0Nv60FoLSf0HAMmC4xWeayoCip2QDEPiMvvPUMVh+WbaVMzTnlgwa+w5mvjCMFrgxcanoa+zE/Lyp+UT+xR+4aGsx+8o7W2/qppScZkU+MzA3sybJGD0iHEWEQIrhHIEq1q6Ty/Tl3aRL+qqNbmF8J0/WmT9fbP8iPxLIqskTKlHiIqq/iYnzOdJA1EizyQf+H6lYmyK7puix4k/TXBSObOoy10PVrTMRlt2i64r5WCxNYV7Gk666MNgd5CkZwwIJ0QPUX+r/NlaSkSNE0So7COtbdLi13+CLXNeImalhaFyeFWxfQG9QuLc+AxwKWJ1Ey7PWin8V9Y3WjvDL2eyPMMFPNwUPO2Geu4nROqUw0vRgT79OKsUle+jj+O1gQtjre0esiJF8PetCB+Hk8yYPzUYo9ZSwRjMH5Wb7zYIOVgAcrU73M9l1Tm8YHqprsyWH9GwHj5meVU7YZE1TWO9BN8urCGaWcPm8jeMJ01PUqkIrUbWzy8ISYwhLgnd5UmLnurpQYUKBb9pEKy/fjELaMyP231YmXeqWO3iO5zH9Dg/6cl+E1VexLs2LtCFSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(107886003)(6666004)(83380400001)(36756003)(478600001)(921005)(38350700002)(316002)(38100700002)(6486002)(2616005)(6512007)(52116002)(6506007)(186003)(26005)(1076003)(5660300002)(4744005)(7416002)(66476007)(66556008)(2906002)(8936002)(41300700001)(8676002)(4326008)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4OaB+8+rZATElPiI8iRz2tPxJC46eXgVcrwdYk39vUghhE2ixVIzANvfIMk?=
 =?us-ascii?Q?DVcJhHZ2dpib+KOA9LQffMvEonK/Y5b3NYHKlDjAuwyoq/BrrSpFPaSRJDQ/?=
 =?us-ascii?Q?yV9B4/BGl0p8msunkhJSIxCago0Lwcz7gY/yj04JwBbjggYIRPDt/ZuaD9aO?=
 =?us-ascii?Q?/gp/+oaQ0yyxeXYtVy44LwHEV+Bnk3u6F5vqXngH/gqbxKZb1wIkzWa6TCBM?=
 =?us-ascii?Q?T3TMAiw/yg+o59WTui4Le/rPCMwpbfhYRIYk5CzETmhcT9HdPSqmG/vT2JA0?=
 =?us-ascii?Q?InWkURk0+F7/ge/nh6qXj40fupMbkAgo2vTlyisgJPWih80lxXLcCftEyzfe?=
 =?us-ascii?Q?PwvGAxFBURh7/aORkqh2P9TAUjAB1IVOhfHODY+m2V47sowPocekQbbpiTLF?=
 =?us-ascii?Q?pdI5omg8HNa1ZkNlm1Yv4FfjKZhq1hmLvuiWeyDubmi3XWU2ZRPlqskVDC6I?=
 =?us-ascii?Q?+RPVUfKeq/apKHCYO566MroFfKi4AFL7h2SxjjimDI+ATyGTpZQu3kXAUmh/?=
 =?us-ascii?Q?Gg1QjKFx5C676+Bw2CS6VSprCKUs3bkxYcLSLdTriKTFvtSVXLSOFxhT/d4K?=
 =?us-ascii?Q?2+XSweHKUE8pMvVCfENVVqSHiQxJRDC8TS8zonAR3kb/LmRBvsz/kgk8Awow?=
 =?us-ascii?Q?mNK5O//nYyRQd8FxYPtvVrEwngDdPS07+FQzcxhdFYboP1XSmQHrxOJnP2hY?=
 =?us-ascii?Q?2owjMXgeuub8UcmU6otJZiFx9Nbm3ovhHXiP0j6v+Mra7y80FM7CgeyJ4mvO?=
 =?us-ascii?Q?TJHIOLtile98kGtvzIlh6LWWEVg1mTf++ug5uZPYxVQprFcK996VEHvSjXof?=
 =?us-ascii?Q?497VXKNzi5i+iqixdANUHRLBe/tmuYsg+HNA3YdmUG8QY1hyvI79TgAv9zqT?=
 =?us-ascii?Q?o90xYdBXMQlhP2k2OqYdhjWzif+328sTIIeYT4lwGd2YH7ejyZHy4ZFo2BW5?=
 =?us-ascii?Q?b2XQaMRXUEd22edWYU7bIrNf3fGzCbaGm/xOkmuvBG3fltukIP1khMXWOMEf?=
 =?us-ascii?Q?CmtvQaJAj1MRhlOxNTFvtMSbUa3Vq4EkRL4lghPP0NCDJhmL6rffAbwtwp9b?=
 =?us-ascii?Q?uRCdhFyDWEnxcqZ0OJoOQLrzWMnymdaQhVxb9gDsC9gMBwk4ZIK/FFX01GZU?=
 =?us-ascii?Q?61vrYlolBJklEOhMp+egm0sgWrqOKrbqzfKJhvO+fn/8Rzj6ovv4OHun4ReP?=
 =?us-ascii?Q?fUb+bJXOb10/GvhS30qhUquDEN+Oc27wpBLrXqHQtxiqcqhtBPqFqf5ZrDN9?=
 =?us-ascii?Q?CH88J7d540C551eTvOzYK0P8YDo1V+3QCAyOKgJovZPkyWoxkX3GX0N4sjeD?=
 =?us-ascii?Q?1KD4fze5PBCz9NQ10QX1Ip1AfRUL7BZrtvoUSqMdoJG6lPRGR5NWXedEepgV?=
 =?us-ascii?Q?cB0qrTY1FzXqp1vkLIYux891xVco2CJJvHvOsHDFVytwqQm8otApHfrmRXp/?=
 =?us-ascii?Q?7KnsGFHa8QIdeFF6bVDjce6bCqy570iCu3Sm9do8C8sGqqBXvEf3eVMvs0nJ?=
 =?us-ascii?Q?Z1j2JW4SFiguC60d4Maq2YgxD9nuH34sSBpRU8YXIzrlApGEumLFIDjOoMAz?=
 =?us-ascii?Q?qJpOQcuVve1pmw2Cr1Rw+TbzO95gEPo2bqYQGEqS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c373218-d5a8-4d07-1956-08db2082bfe6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 09:43:34.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goZPO6iBPFWvLNTRXm1fIYJDPeusaXWOMYytJH9OJImHzVn+GB6MHvTpkBBpG2YXjbsbouhZG7AJZG/CS90N9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5412
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blocksize_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 7e8baf56faa5..234ca4dd5053 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (bdev)
 			blksize_mask = bdev_logical_block_size(bdev) - 1;
 		else
-			blksize_mask = i_blocksize(inode) - 1;
+			blksize_mask = i_blocksize_mask(inode);
 
 		if ((iocb->ki_pos | iov_iter_count(to) |
 		     iov_iter_alignment(to)) & blksize_mask)
-- 
2.25.1

