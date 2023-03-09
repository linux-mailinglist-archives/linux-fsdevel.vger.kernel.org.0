Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3644B6B2467
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCIMmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCIMly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:41:54 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E3EE29B;
        Thu,  9 Mar 2023 04:41:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFyQMCpvCjwpcH7Xhmc/CCrU/Wp/qpLeZb/GB/mLlrNkemJkxfQsdH0XoWkHxwNNw2bwE15f1It99Eebow29i6hXrb+CG/0qRg+wkeg5w6M6+OcRIFywkCY/8FZzK5mS1o2HawkQljlvYXujKe3LFGk/8mYXfqQyFJwH7pRbF7KM2RIPpvXTiphT2WEeex8jJaDPldz8BiyQ0oHDIwxFXSXIuaap3jpsW75VWNNUxJhVn2ep1Go1Jh7uNIqUsEL8B+M13zsQaoD3ijIDiUm46cPtYHKqUYt4F4OLo2eAQFzqAatn4ycLUpdkFwAlS2Emwtu5lojASGfA/OUVUniP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meK3eJWZv3zCgZpfoN2XpmXl+kR+wlAHWD36VfQ5CfE=;
 b=bOzbuU/h6YA5gFpxMp7vdOR7JC2M+lw9SSX0w9HQvXeiI5J2eT/MieLYXRLOuN+7q217IDSL5tdx5zgB7jRoN27fh1JRNNQXL8JRbRLpQmWVqrP4+OrK1CaUL2KsTut9AgubJEBYN9gU/k/diSjJ/uXQ7FSxVrsrME9LllvoUntzOwCdcMbnN1SH+T1I6/hj3g0FMtV4Mbe0lRfYWFX9IShKk1HinTvKAsdqNvtRVJl/0nJK+9LuMhwZkqRpFBL8nt/11Ndij4sq3suXEqMFtNq5VzdU0MpEUVjM6bYgjzxKTlMx8MsbGEAiPIDNp12IfYwr32R0o3RvXQTsmmCQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meK3eJWZv3zCgZpfoN2XpmXl+kR+wlAHWD36VfQ5CfE=;
 b=hbuJDvumQukOVUFj7PR3cO6foLEEqTlEy4wFo+7H1+GCF5Bj7qbBhr7EgXFkh52+Nlf37UdMaOlgZGocoFYWxVQaWhup4o118UdPmL4ejfsFbak2ZJ2zRwQjNT+C5Yxn7H+abYsYAPHCZNTkg5M0Fr6FD7az9+u0Z1XuSvEps8vj1v8CEgKhwqQFzD2AkUwwlrKOx9d0Euih/8gYh6sacTikQGMZy+4FLXLiwJvqTf8SMX31oH/QS3ZONhuyydBrHmbR0KsUR914QHygTS59KjnEnfZ6FZj9HXMgR6Kav1U9KiUInuJbEDloeP8Jv++cf28PjPK2OnDW+HT/bkLLMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6259.apcprd06.prod.outlook.com (2603:1096:820:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 12:41:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:41:37 +0000
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
Subject: [PATCH v2 4/5] ext4: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 20:40:34 +0800
Message-Id: <20230309124035.15820-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: f57bed93-7152-467c-dc4b-08db209b9fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E28tnN0AujbpmRZCk6r838sx8XzdR4QOnZsbXrmykSp75UD0A/y6Xm5/d1Ij6fV5gqqK1fM5Ekm8uo4q9tyermXalqW8exywaZz9u84vs7iCAzxGkSyj9PtnlY2cUDRFyFf0hIUI72uhsAM4dZU0+svfl0xLcAyEkWF8WRH7n8igQD6+1HQELI7qKJSK6YnXKhLvlMEofu8hvRAQ4hy04oKbyrz/13Vymu57P9Ug7wZCdkaBWJTgAIZ8HNtDWFyFEDQiAtTJH2icaH57ug9SjLUALU0QoHPT835TGfBqFLVTZGynRgLgA69eSIwby3BRHljMFP4Mbq8GDQ0Ofa40kx88YKyDRS9ZUeiPwCrLkqia07KxJvBBGcmJ/xpZj7kbBaDoOv4FCJ+N+GyG0VUp1Y1AHT7NgWzwAP95LfiV/ye9dZwA/tdM1UDPmm3BiXR073VQpy1vQcn3us6VcFIZm5r1SiK461i1Aj3lShlFlcg1UqxSC2NPd23+FhS8g1R6k5KMyt2v7Cr0voq2BMgFjZBhr+fI0WbotS1JzEmM6urQMgV25THqSRF5u+XkSKvzW7Rsv9WPTFqmBpBeBcAwM1IKmUaz07UWa9ODGif03lnzt1Fw9P8yNM3q5UEKAo401R1egvamSqc3mdR/OpbuhZaCkTsJwcAmEhG2/an81pmQ0VfvGBudEB1htMym3VEJr/3vlvsE4eeAWGD4C3cntAXt96KoIZucnq7+mXXEa7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199018)(36756003)(186003)(38350700002)(38100700002)(86362001)(1076003)(6512007)(6506007)(26005)(83380400001)(6666004)(921005)(2616005)(316002)(5660300002)(52116002)(7416002)(478600001)(6486002)(107886003)(4326008)(41300700001)(2906002)(8936002)(66946007)(4744005)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZgLxxfX4t1McWSOmo8olL9zhL7a+yo63tKZgLEGPM+bFjj1dBBDPgqMRTNYr?=
 =?us-ascii?Q?BdNh+bcEBs60dG1kBA1T8LqDM2DBpmriz8QVdQ8I5YRldTo/o0LA4YmRFQIE?=
 =?us-ascii?Q?wCXmlTxZ9T1VixePb+TUTweGwczPXYu6Nclr35lrviR4qPBrR5+9jqNCK3i4?=
 =?us-ascii?Q?dJ65DOgTl5UpWXZnOKz2IAUOFJ+zFjsIujWf0QJkwI6PrC6AlYUbwISfAwHC?=
 =?us-ascii?Q?qv1Kug2wkxDx+gQbGlmTaNXf13ctN1hy9cVeWJCmfibRdWOXtd7hlqmRvxqb?=
 =?us-ascii?Q?GCf8Rg1aOtowXDdD6hXEyBd4UtAF4EnC5Wc5uBeJkUckL7B4wmqlrdxpTtHu?=
 =?us-ascii?Q?wXhbnLUXEF+VZ0wxfL34qbS1hglNwPC3BCoUfCV8lS3hTMQV2keqty2HWZF6?=
 =?us-ascii?Q?uKKTJ4lqYMfWycqedrniZA8JcqMAWz0WTOl6/SAPlpk+zUqVfSjyCf2MSax2?=
 =?us-ascii?Q?GRHX+GHdeh+FShO6d/BOdSyp/+IRpMACzUHjwaof9itmgu+f2mSOWkRqmocJ?=
 =?us-ascii?Q?tjxDGwZCmJIa9aqU+Z6lKd2xF91EMuSorqtUNRedXaF/LK7ALBGPWtAi3BLP?=
 =?us-ascii?Q?h+lkurzDb0WUQDgRqnysv5d/COtRXH05I3mM66bozQLd1mXkXoFYC7U5AIMj?=
 =?us-ascii?Q?exs/wgEBcf6dJI6PZ1WoDqR+0sWa5ywRiqnsW3gpKNARmaRrm4406eKYqBRX?=
 =?us-ascii?Q?S77jqkPxhCbv7hA5j6Pql8fD9kK24AgBpkLqKcaHPK5UxSrXhEg6P5qQLwWv?=
 =?us-ascii?Q?YjgcYGzuAKbTl3BiBVMZQf8zOdMcpaccIlxzTDZoXw9P38m0p9X1Z9oukxmW?=
 =?us-ascii?Q?9M2l8RkIJWhi513JMNzHLQJHYNPohSqZ5jRc2xXGKranwyox7Lzuo1yip4NX?=
 =?us-ascii?Q?ZwPVxEQTJMxTDETm3Cbl3jubdEuUPrqUtqayzUrbPf2x9Mjh2elkySCbw1W+?=
 =?us-ascii?Q?6SDF8HHE4DDj5rolI3PVZSZWRidhigHkDXhSfPAaLY6kxnNv4H61bNASph4i?=
 =?us-ascii?Q?DMVn2VzhIkWX5UmYrh2KZ5UdKic1EHB5I4Wpnc24yahLnC9lcwqii790St9v?=
 =?us-ascii?Q?dihSvgB7cq8I3T636aCs4nLu5qveMGVPoiffRqhCeb2slcz9rrxMZCJfmLr8?=
 =?us-ascii?Q?SoFdCPQlH4Gpc7hjQzxqsMtPRpY/unsSgY05CLAaSbwoUql6sY2qi7xerVnz?=
 =?us-ascii?Q?J+CVfv0nLJGPOvNcGLYaDlcK2+rgzc+TAY2Uc0nIiDyTSwVUwRF7DxB4sLmg?=
 =?us-ascii?Q?GDDZuM+U8VZDMhE7+B+0Pz/lKF3vb/10W9h+7lh78fxVUZsKr35Hro9vcoC7?=
 =?us-ascii?Q?oFLLXiuIUKdLS9kPIsgCsQbjGDvksOX439gN7RNXRsoalHG4mo90TeSjY0ip?=
 =?us-ascii?Q?NOslqK3EeE1XK4NeHXtMcBUV+Yn30bgkYAUbmh0BRAyQ5V+Wcu01YEa4e+mz?=
 =?us-ascii?Q?/xC7dvzkBbTYyMGnVzWcYSHuHEsyfTERq8r1jky+K/eokdE3nU9CZvzqa/AK?=
 =?us-ascii?Q?YigYmMsAhbEipJNkqVjr6NCFBV0YIiIey43i4gSFjSAfuv+c+73bFArtWwhQ?=
 =?us-ascii?Q?LIYXU3Gvwf5DzvbRR13H1DRwVgktRb/byIy68c6l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57bed93-7152-467c-dc4b-08db209b9fbc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:41:37.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dlKu3pch/ixyeDj8WZgn90xdOKVnn/PxaOGafWNX4R/lfto4+glIrZ4a8O+iuorfDlSeTgLt506p+3lDGMYdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6259
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
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d251d705c276..eec36520e5e9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2218,7 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 {
 	struct inode *inode = mpd->inode;
 	int err;
-	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
+	ext4_lblk_t blocks = (i_size_read(inode) + i_blockmask(inode))
 							>> inode->i_blkbits;
 
 	if (ext4_verity_in_progress(inode))
-- 
2.25.1

