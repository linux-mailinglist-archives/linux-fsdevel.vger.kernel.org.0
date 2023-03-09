Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B7E6B28A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCIPWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCIPWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:22:20 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E50CF05C4;
        Thu,  9 Mar 2023 07:22:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBAJWSn5iYdhpB+5xdqRyRLOd9k9qit8bZNsJiO34oQzQKdqH6Sr/AK34teHp29ItFqfxQpz632Kas3bQ0Z+oypeGanG5TUJYjxHCKrUqMbPTMFqPhgrOGlrB0g1946RYaDCOAn1pWav7/hOLP28XpEBoOBwmxH7AHKilIQj8XuiP+QrYOhwYczO4UkP8dELyA2FwC+PZXZAIHdIsMHfiUc44yUePcmvPdmBvmHL7cv7VCVWKNVob3FyHGqF4N98fwLDO4mywbYu/D+ymiNLNu5TZVwE8/qFT1OjUFteNKnYpHLhyEHzKhRVV7wmoS+tZKXJf588Irtiy8tnnoeauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN5Y7OXDT4V2bpXioGREHUJ3PuMN8TbPuqNvpGP3jcc=;
 b=XPIwo5mwdrs4NQ6yL9qYHMXUnuP8ONYTt96v62AP1lJUkaZfmQ+zObVYlskFxWc50iSLLMQh7qoT2ZfIFvGwdojaREdXVB4JL3GNO0Tu07+gSF4mT+/SUcPGlk37o1uh1nuFkphO0tmVohaeuzIQDI0oTmaJuvyBPMrJrYJZVUWmBDDZEGChmNFnE9BguhP48lj2IrCKYEpZVaCgpBpvF0R8Ze+upryUND7hXlJkLv6sNUKQeDBgi+BkoLsPUOuC9U+8ZYQchgT+s16x9w9m8AgYtOExobvPAYEpJiQae5E2c10aOhNcPoU06uSB3svs6vbFy+Dwi2RPaIsGq0mcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN5Y7OXDT4V2bpXioGREHUJ3PuMN8TbPuqNvpGP3jcc=;
 b=WLWfPvQU2bhObgm6GxjC+aS9Q596I2BOM2k9fq6Uv86oCb3vOWSmp7XDdyV6fWh5v2LFcEkw3ji4sdyirJA1LbYeruxuYvPZSLR9TL3SNKOmzMkI+tlVO5UtraaJzIvkNi4jzzuRRa5Dq44JGll2I6f2oj8lKC/qU7ODpnI9WI8KZBI/wUVQMG2fleksKeuXo8hu5WgSETOgEi+NJjYTVKWJEfyLVWJnG1xIMoYks6ae1zcc+rCVnsqqjRLzN/Xs83TPsjJkrCwaVtTXbdO+IPb1fNXEyIqe4mDvqTtYaWx/o+1E7RMlEFVrV+c3HxWvt7mPSVTzwV4e53q7ouDgPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4073.apcprd06.prod.outlook.com (2603:1096:4:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Thu, 9 Mar 2023 15:22:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:22:13 +0000
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
Subject: [PATCH v3 3/6] gfs2: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 23:21:24 +0800
Message-Id: <20230309152127.41427-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230309152127.41427-1-frank.li@vivo.com>
References: <20230309152127.41427-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9c6312-19bb-4ca1-342f-08db20b20ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zw4iYeFkgTHMTIZeNkJQD6Ts/vtKZyF060qehqrCBZt1Gok3wu/rHoVurBt9d3xFwtq6mygGzq0NZN8BemSVoOgfcujo+OY07p+6TXy0W+DdnrM6Vnym2YcXhYv51U2/9IXugNs/hZCV7piJbF02H6POkCBsVokTW4Js473fKVpNlZH5hhLIDPZ7wAHoNWRGrg95yTu61qbzMlKA6JPXzpOP/zp136bq4M/LpUhMqDMUauavqgS+rmAVxGSUUmr77X3q0JvSOsbUU0Luba74tDMa+O115DjgP2QRXo+2mrQP8Jqq5LDJ6unI/ZIfnOO+QeI2uxIm6uob9icCqtn6A1J1cXsZyzFvHTkowEne1JPTCTUpWx3iJ7duBkS2Tr7bUl0z87E8+khMM7O+vZdVUulh1W2zLoBi7m47ZH4sUBOiVGiR2+2z6AO4afxqhJtbsNht6Td/WtKUjhJZAnP0UAWvzvTxGnXEjZcyVJy4PdW5zPmJzx9Yv3icjm4Rooo9vUVfBceHMR/Y7Gks2NBlsGeNLZhkqJfUIa7e9ihw35/3mtPZgyHideRhddlxEqqG2vhemQFMoDhdJwjvfLAZgun1yFyhoEE8r01CKoFlxoTWkYZEDzm6sfy3ZYXTXaR3TU3sZSYkfmjnnf80QMN4wWTIz37hF9pq/FVjScK6qTOnqGeFH/O3w9EKVIno4hDpIITGKinL/M1G8CGPe4XtuvAF/qmJP6i7WHMCso83BI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(316002)(36756003)(921005)(86362001)(38350700002)(38100700002)(1076003)(6506007)(26005)(107886003)(6512007)(83380400001)(6666004)(186003)(2616005)(8936002)(5660300002)(6486002)(478600001)(7416002)(52116002)(41300700001)(4744005)(66946007)(2906002)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FdlOoEXvsQSiXX57b9tinHs6OggfuNN8FYqn7UcnWWb9ANcQEYafcJ6eeYtI?=
 =?us-ascii?Q?uihc0DCNa4zgy+cs6MvaY4UjfNE+gADkXhHYoy7z/QK6WyGwLJqWOE3E0Mlf?=
 =?us-ascii?Q?d/BKNy7+Y5FRanoktcqLoXnvz1o0Lne+bP8q0NIAXv0tV+2faEwW4vLXbw+n?=
 =?us-ascii?Q?cfNFClaDIz3NV/YQpobmnRN6YG7RO9GMhGyfMmgHmdtoXqvHRTr4U3D8CXm/?=
 =?us-ascii?Q?jK2CsZcfuW2iQhYosPjhb/oYCU62l2lcSeprzHFHeoP7IEzto6XoFXNNNQrh?=
 =?us-ascii?Q?zXXLsUTmZZkLEExEgHjHmVU/mLNa6RmUkVLmUUgAuoQEHILaJm0sQHZot6kT?=
 =?us-ascii?Q?FwQDubqJLx8rJNR4xKePsQRMgWsbIOzUrBCPYlVO7ROJBeSfiHiSX/MIfCfx?=
 =?us-ascii?Q?UVCdwhtzIWHPE3rG8cabQUhJ/zK/U9jdUybEtAMpWk3L0hFfxX7V3z5Ip0uy?=
 =?us-ascii?Q?6RBNYZ0+/C9Be2dr4S8OXjxxrq5Xz644wgFGrfOUd0nEaf4NuTCOe8KdIUUO?=
 =?us-ascii?Q?fm+932ZZxT8SFbO0rMYZxKoRtep7vIB7NBLKThzDRIloWb8Ax6FFmceEf8Bt?=
 =?us-ascii?Q?+EMopz+/6gkMCVgQ4OKFqC5OFjba9KMAUY5OgIJuLrRY+BwH7/OPV0QI/k6A?=
 =?us-ascii?Q?M8aN1Zdej5FEoSCuuzo05Tb8J6vUUyBIhvDCLJ0WS/ykZzSblE8rYUdvsBfS?=
 =?us-ascii?Q?Qdm5LXTd9Ce4dP7TRf7W9zNMAQAYc78xwr7a8ITFEZSvHbcua1x2fvXZejUN?=
 =?us-ascii?Q?EVgNYSwfGNMBcJ9MDsJ9SUWKrgJx6lB+Jw6muJMmFWZWksNgd38F4uVWdsZA?=
 =?us-ascii?Q?lOgksyHRiGwNjQy5fwxJpI45oFqpA5wwrNGobYcO6m4Rif6o4n4VwWoXbi93?=
 =?us-ascii?Q?Nd5cO1HOjb4bP318SuM00PVObrK3Gon2nbw5umMy3NSfvtXgVU2SZnuBNebV?=
 =?us-ascii?Q?Zfk4oVJS2cYCVPP8wL/MTlBJROunMtShYqAUpcjam+D3X7gtVJOHI5OpsSma?=
 =?us-ascii?Q?sXt+yGWdkqVCoCE9GvyiUWILJESOCgbrErRvTTn50ri5M9pTawGKJ+QoeyaV?=
 =?us-ascii?Q?dFQ8VGy+H+OJr64A2CuBdG+VmqfsX21XUdXByzSWQRU7HWYUg9T0lOZF8mOh?=
 =?us-ascii?Q?TNM0aZQKS5aMCL3nnVcaocxBRoNTuQglgC/yqp+LDzVQHqWUTr0XysE0AbPc?=
 =?us-ascii?Q?u8z7Ym32Bq4FvMqHgADf4bW/58Vg+51HVd5C/er3wEtzfs/Tui9xghtAT06G?=
 =?us-ascii?Q?mTp7ovMGqOhh53lhm/hq80AxBkcbe4UkovLmsNCi8g9JR29vi9he1cu3Cx42?=
 =?us-ascii?Q?TZBqrnNLBabxl21uxaxhmHiVyiGaAkD8lGwZi5/r5n+4HvtTieX+jQeBHNcy?=
 =?us-ascii?Q?SZuap9NNtG7pqgzGUmXvFSD895rwmJJcGVxVAoyXIKwKWugUUsRQdE4MaZTo?=
 =?us-ascii?Q?fEnPr06YthGoexPatzVeo4o8V5yxPvtjqaF2vHqe4bjbYfzH38nTFjG6mSu5?=
 =?us-ascii?Q?HF5nWEXFVNHt1wzyzufr4cIbQ0HjMgvIv4iPCcL2VJp5IxZJmET3KuHwCwxl?=
 =?us-ascii?Q?oliUT3wMXoaRsj1xo/8j4i/sN/+iJrDzoX011Odm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9c6312-19bb-4ca1-342f-08db20b20ee5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:22:13.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGe9vUdPVyn6A7qlLYid3EacqnHwDSvXb5oWXoeWdaBo/XkJYg4ytVLp5Zq8VCxfh7SMnYzeeqxVDXMo06KMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4073
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use i_blockmask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-none
v2:
-convert to i_blockmask()
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index eedf6926c652..1c6874b3851a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -960,7 +960,7 @@ static struct folio *
 gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 {
 	struct inode *inode = iter->inode;
-	unsigned int blockmask = i_blocksize(inode) - 1;
+	unsigned int blockmask = i_blockmask(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	unsigned int blocks;
 	struct folio *folio;
-- 
2.25.1

