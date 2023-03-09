Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA416B28B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCIPXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCIPW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:22:27 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3055F05E4;
        Thu,  9 Mar 2023 07:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhPrJ2u7MfwiDhatX2Gt+Hjw2dVwWlqbbSjceE5z+NvV/ugRufrhTqGx3L0aHZ/MOB8fjs1Uqr162mUwNaG8H+LH3u27yL5R8Kt/mR+o17u88cZ+/Y2hS4j6s7D777B73IeGGn6jtSfIV4d3eNL7SPQiby7H7rypxfv+Z62V7mdIWkWzWHsrukyViP5MTHnkSIngFbN8f6F2SbQL9uRj9w66FqAExV9FowPNqIh9PFStioAYRCs4IvoH6CXNGIgS3iAA9aMefxDVW6qeFDCb5BoZkG/Nfec2mEI4T9RWGgV0lU709CqYu5LVdS4yZutMGLyqRKwt3CnnGDBtDbs5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGyFWvLSoU+2mZB6+yv46/cKOs/G2aGN6o/I+8yE17w=;
 b=oMH8TD1bangGMdN1R/mOeBSkFZrGddk+b47R44yo7kSaSqJS0W9xs0lfUsgAquOXqJBt8DPs3qKW3K6cBMoCb1LgKOldon9sfPf9waY1kL0W4sm5vvtPUg5tGxCzbl5vIz75ccvyhSz8e2M12twg/o+I7Ic78G86MYN7rHefKiv9YhOeJOgg8Z5LBqkjvhk6FeD9oUnjQFNtTOaizPP3u7I26F6+TZKWfqgY4nMdO3fjrddFwZ6diEAoR85sANsZTaMxne1uv6tyql1Mq/uc68+P/eNkzpjQQbWAFT7SBuYD3AveU4pZNkdYkd4QugJtfPxG1YjqrjnuagebzTMTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGyFWvLSoU+2mZB6+yv46/cKOs/G2aGN6o/I+8yE17w=;
 b=gbsRCcHS67RA3jsVpo98DqoQo+E1rTaJiWplWrETQ9aI3zbSB0Bgb0jZ5sngjknsZCCR8dYmtWuvUv9jdcijDHQzNxdSYl2Uh70O25U5cD0EvPKwO3RdaygU5WmoEcqVaygXmqULDL+W6JQIwRPy6X0n9o5bPQZ+bG1S3tzNrsrXNaSoe5fxmWlvlZIeOEfMnTEt5jqLQVM9/WsLExc4/Qbi2gkR5t+446MZ5F6A1erzJnZC9torbra/6uEZjYJ9MfeS9CVniBWNftTIUO9Bs902yt4eQdSZrtJ6KyK5joATbc8QSeGa0nPpe6+CTXwWO3nd1MYd/4vACJ8B79SqVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4073.apcprd06.prod.outlook.com (2603:1096:4:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Thu, 9 Mar 2023 15:22:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:22:23 +0000
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
Subject: [PATCH v3 6/6] fs/remap_range: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 23:21:27 +0800
Message-Id: <20230309152127.41427-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0c74165-0494-4652-fce9-08db20b21502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRTfHU0Gm1HEODi3Ljfa6O9bH5g3gFJJw2IY9HPW3uhYS8xluRXK3a23y8m8IgGpmWxwOXO8E8KLYy+VPoBInNSZizmgycC1HobhuNxh6HiJx5AMMOoIulhfFQAWAFzjndOrHSp8c9vSSMNolIjb367EG0oMFWN0HYDIEfK1BQurQlaRZHJV3vNpVTSLkOSJZRQEyAFDQ6oHwbuZI1t2AeP15GDf5O2ynq7sDEdpI9NqjL3KLPVTuaqNjK9DIV5I5LC/oymeUMsaxjyVYWHSPSXk2WEGSKQ38258mo0rbm/D7AVn8ndkoIs40FByzSU0RZSZf9yTD6rR0oe7XDdndhCoaJKgu4lZYY1vOl97vPr1GgwedDE9/H8A/RQe6Lio38lolz8WtPT1ZEQZzcowBk/GChGIRrX7gKtGUYM51W0mCSL/i3vdI4jB1+4BEVHfGTkOBs5wrtiO/y9RA5B3Nd4tWWAhKXaTRVuZZNtU0iIwFCwlI8OAIF09P9oxuwZTmiFGcJ5WF0l3zSJKtr8z64jtQYwXmjWeS3uUX6Hpi64W5B/rQFW5G7sRk67qcSTRUenxnJQ6LKIrh+tcvfGaUQqK8c1uLGtOA9YMNEx+uCv9GxnfF20XPUpHYE16U0mXC0itvE24Kr4CR0PACS7VAgPYyBC/pnpb2l9zl1Z8I86NpwOBRmz9+ZkR76uDHqbjUm7Z0Uyr2LZnmBSguI8CukAaXN5HBOjNXq+b4qhB42Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(316002)(36756003)(921005)(86362001)(38350700002)(38100700002)(1076003)(6506007)(26005)(107886003)(6512007)(83380400001)(186003)(2616005)(8936002)(5660300002)(6486002)(478600001)(7416002)(52116002)(41300700001)(4744005)(66946007)(2906002)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRV+D8aIKWmOGzclNTNYDfgBdfCsAsuBCvKpSVpY4ZJpFbS2WGAP3XmgSIV8?=
 =?us-ascii?Q?g/ZEryBB9wvUAryFpE/cFw79cv/TZkRBhp+VJ4A0li7G1wrv4fTIDlmnx/St?=
 =?us-ascii?Q?bbruLtiD0yubpbSI6fepTXEVkBgW8Upl0ugu1Jnfj1l63dkPnlzRdJRr/lkY?=
 =?us-ascii?Q?M9KSZixEezHDYjQR76WxaKvoJqLLEZMtrewb7gJwKLVhxJQ6zpSdga6G8tYy?=
 =?us-ascii?Q?TklD6Q6ByqqzB+18zioLAcU7bEIQGxLe9mX1/OOL8hc9Xu6R/hBTPYQqoy3S?=
 =?us-ascii?Q?eFMrRWt5RiNq0RkzkvTrXqP0eWNKymOSGtqcqG44BGkK9n+rKf26J9tr8snL?=
 =?us-ascii?Q?LCtJRC2VWbkwcfIkBHxEPoHYoTC3xwIA7CTZZB+VKATw/NFq+rdGTXkvejiL?=
 =?us-ascii?Q?SZPSD/yMT5NkiKJXQqeGnzbSFMXMk7PRwMAnJYPanYhZe0608lNeZiqUvW8O?=
 =?us-ascii?Q?DjmmSgi1Y/nZN/cW6q25pRCKDxyeZaMJ0YIpSC0msFpQ7TKTiotej20kyqIB?=
 =?us-ascii?Q?6OsKK9aBF63ANMi15aZv9DP0q9vL3pS+ZBM9/Vc0IGBDOaeLah7Nn+XM8ZH1?=
 =?us-ascii?Q?pvAxgajUDvyvk91ePNhuivBmisvk2NDma0vrFgEqIvD5PwHhb6tyeKtEJZW6?=
 =?us-ascii?Q?tdCnO3HI4N2hojM9MdA6tMErTWzo9D09fMBxwtwhiQ7nX8BgaSuHBE6Lr1We?=
 =?us-ascii?Q?rwuo/nLam1a8dEgJtiNtsKpKn5LPK4Wzs6jYPpsjNjMfn0ZWJZiUbHXr69Ca?=
 =?us-ascii?Q?2yN02x6iYlEK8KG3bIxJfcG5e67ddkBgXl5+3nOPIBp6+Qk1BagAO8V9/DWq?=
 =?us-ascii?Q?7JcUihraDqMlc6TB/EZsOeV+fylmMk4omEmwHKX5XCgZoQVpY5+J2itJdhag?=
 =?us-ascii?Q?HpetS5CoqXc5EaHqbBgIKlwEYXLSTklTUV4t+ZFOfb57ZnDTYj8e3qj7XD45?=
 =?us-ascii?Q?EyXAavkcBgBdwTzuVTqWgOICLmKjGRyIWgl7Y+6WyjQkPz4i/jvRYmSl82VP?=
 =?us-ascii?Q?U1x5zd7kn9G/7kxLVFbLwKTAQUvsU2NdR0/1QjT75RlTP+kbMDoVkK8oNvCt?=
 =?us-ascii?Q?eRSD8ezyOzl97uN36seO0YaMvFm0EPjqlh4fg0F/lWrLvgCBmQIBqpkNrmA1?=
 =?us-ascii?Q?PnJOio6WE4cM3TEmrc6+8iUNi2Gi9tnHaxmA3xiYb5UIrkoPLQXdApTMr4pU?=
 =?us-ascii?Q?KwRRwmE5QVCwMAA1QOaP6x9mzUBEj8sqscXef9+w0WuocvkuZL6ZbeUqxU4g?=
 =?us-ascii?Q?m0bD9Lrissn7tVKNZeIvhzyfE8vjf05D+SFDzI/SZotye/Vw55JMVTl9FUUJ?=
 =?us-ascii?Q?/5KJrJJCl3MK4HA5WPbRboWy3oiMNgRok2YfCc6eqpYeSWwULgrImjiaPqHc?=
 =?us-ascii?Q?9sN48rVME6aTQvbNcC2QmCDm20j7ZOjDrjzaFcTrFLBuHuuWwShq4s7bmbGn?=
 =?us-ascii?Q?7NbsqO/RRwAKr/FBBXojj4BuYH7HRtcfobHkefrf0T4NODyzQVxlDJtiqS84?=
 =?us-ascii?Q?ymvXKHVag4LBTuZukjiCevVx/NkjP1xoHu5Ng2KP/purCpeuOBSDqha2Vohb?=
 =?us-ascii?Q?96UInTivnktiMxiGg4kdvj9zWJC49ddJeXAquSur?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c74165-0494-4652-fce9-08db20b21502
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:22:23.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwLsINpxtBm3ouemSErTJcMc5WkWVEC2EPQ7vFF10iaOcViQfcsG/LK6F48BJHDGgzO1bs6r1O7WX1uk5r9g4Q==
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
 fs/remap_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 1331a890f2f2..7a524b620e7d 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -127,7 +127,7 @@ static int generic_remap_check_len(struct inode *inode_in,
 				   loff_t *len,
 				   unsigned int remap_flags)
 {
-	u64 blkmask = i_blocksize(inode_in) - 1;
+	u64 blkmask = i_blockmask(inode_in);
 	loff_t new_len = *len;
 
 	if ((*len & blkmask) == 0)
-- 
2.25.1

