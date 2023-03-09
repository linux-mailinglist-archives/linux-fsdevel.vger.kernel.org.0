Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532E76B28B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjCIPXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCIPW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:22:26 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6BCED6AA;
        Thu,  9 Mar 2023 07:22:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7pZHpOASzuOzmN510M7cBLn5DREd2+EAVY7KSRPJqXWaVQSt6XApt4R0DyPer1CmdfWPIFdAJpqIbZ9tlv0/OGeF3sujj6UC/vBeABo36CmcuzvLBnIyD9yEPhNH4R6X1owRvACDT8p2QqZGl2cYRRbDEuV416vZdAoszMk4DYsQJSztk2FLriId/0+QShVpp7wmzYF54oOFx1cOHMHZZZNBwWcyLwzkJS8vd7fPI6rdlUwJJUURRWr5WOmUe3I/ehjhyg3ICuBSxWS+NFuvtiUSLji24P7plUsIuWGwiajBJoIe1seNpwfqQyiYO9Px51Er2DLjufmA1HZlg5qQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvVQHptGy31XI17r+72sjhblJuxhfdQF7kdWesGYqM4=;
 b=da645OWWbUeNb5LMqpvAILCRX7m7PNr74yt3GmFuGZuC9DgcaA9MU27l0nVnz381OEGulcQvkwJwNbH+g85M8GaB+D4+FcnrG+GX9hRNUV08L2uu3Bm/wDxWjqTbw7h0gonHrgYk0gKSdKRkR2MmZ0+Baz62tyrtRbKqVvls5U5x7LjqPDCxYgfpPok1GKjlgKyRoWWmTRnLtSnI3+cDfP8ffjglnTnEKCAfhJOqGPyuvNpH5drNaz7LtA0+viMz1Qbtj2PWxCqdjSBFEdP6o1L0+xFl1Fe5FwVxH0nVPTpBKkZ1t5ut5mYIc+A98Hs/iEx1dJBrrFgfKS7miQXc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvVQHptGy31XI17r+72sjhblJuxhfdQF7kdWesGYqM4=;
 b=YWKK7h6xs4nMPveucItlGK8+U6IcHvpat+StKXJfKwtZOICYUycff/Dzc8AkEazv6dBr719eIMnTvdFxz71xDAm0eqGpnSRrU1y8ILp1Qh7gN7Qe33qLqutwKfCKrDy7ISvnKHym7tWA/n5WZccYNWL+RMP7XwagNtaNBQjQmN5SertXj+aa9/lwiFiPMBHicSJRUljlOUqaoBeUyHdIkJ1/IxdtZhVmfkN52ruYX6TTdbj//oaRVEIAz6cubsAnzAxMGZg4hcCQU5iEDY1FubXTwNmaaRdwOvUxcj/IRFLjFJfRn7TGZqP0d4k76n7jhMMTLYSFNxZvOIp8o7Po7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4073.apcprd06.prod.outlook.com (2603:1096:4:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Thu, 9 Mar 2023 15:22:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:22:20 +0000
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
Subject: [PATCH v3 5/6] ocfs2: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 23:21:26 +0800
Message-Id: <20230309152127.41427-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 043794d5-fc6b-4b0d-6678-08db20b21307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB6/i5Ksh0zI4+rKooh0sNe8ZJMxEIXigfwrfaHKXGYw3SMk4fYCEsAZL2Bp12KI+OGb0Nsdj8NoG/yMPwQNKFRcH61xAs1uzNXblxvrITFrXsawQ0KCdWJ+8Zgk029xSWpJHxZX0BYMHPWmYAL4cjvXtTqby4Z+klBDWi46zIsBPu496JZ1YAv8OCdpj9MG6Wb3fValyFPKszrvAzLQ/hpJ9RZ2SKmAdcUui4mo3J/oU+QlZZxlGfMZodV23sHvbVLSo7DY4G9GSe/JGGOAJXwkvVs59Q5xEW70SCjN9ZM8Wn7xdJkWAalhxwhsfqCvLoPFgckVqfOezReBBCy5htpc7bpANdQyLvqkb/6F5Qf2CP5uxRKcTkhC/YYNykDclzLkLUx1zHtrWLPqNJJxUbhtOT5Mk9O8YxMimDq/bIGNOROjFZEz0yo7Pd1Bl8QiJ1HCFQ5nS8nuCQ/axzKq4BzK3PElS0mDN6CQXwVXQdIl9AuV3/A4+lwi8XpLGiAden8LtOMeGAOgBPWxsHVI0TgQqpimoM/ip9384jW8FljpOz+2i0CoH1glB6eXSsw9YoC+Soqe4L9MLmstKaoPbyJSvR8JjoKcYGY5PZoOZ3FPye2ZKEFVJI3fKhr5fpndk8mdxkxAqOd1vGudejoY+m6aelXr5KNmvz9HgqJxR1A/b5002TPJN+pryQTLLSbkj9KBKdpFjjPcwBK17xhkF0mDmCskl+moOI1yIA21iVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(316002)(36756003)(921005)(86362001)(38350700002)(38100700002)(1076003)(6506007)(26005)(107886003)(6512007)(83380400001)(186003)(2616005)(8936002)(5660300002)(6486002)(478600001)(7416002)(52116002)(41300700001)(4744005)(66946007)(2906002)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yv89NdnJEGQz80CUDNL6sJlMcrOXMyDVM7q+K9YCYddUmo3yTghzHnj5MkxA?=
 =?us-ascii?Q?nY0SWK60PtgzsnQQQI94q+4AH4EYnhL7Cg0Ed817s/6AH2m19TRdh2YyBEdW?=
 =?us-ascii?Q?VoJgHQXMvPQL6wejwlkgN11BTIuPq7e1S7DMjGuWUXUTxZVlWV8VwOgA0lQ/?=
 =?us-ascii?Q?iMWbF2A7fymKvlSUFIJbEPT/GPAkzWAL8D4ji9B9WqXXNdxyrUcW73cUTUfz?=
 =?us-ascii?Q?GUg2BwgHmydurYuMHwdPT57OCwNJj/grfuK58O7zN3Id698/FsmCKcQnZJVv?=
 =?us-ascii?Q?clvkhPKNln017OgN/gd6tfjoHbMDqSm8omWLmOe6/kuXzWvYpySQHYBQFf8p?=
 =?us-ascii?Q?fc+deExZVdnTXEVL8rTHB5TiZQ28MIz5ccejAxwm8fXGEq/VA09tUX5Ntbpd?=
 =?us-ascii?Q?G4+aEPmBopJdFsycyhItLZQZ5REWuyN6Ylf7EkMllqhjqCwzZTMnPlcOFl9k?=
 =?us-ascii?Q?MB0tLukNdHZlsKYvBT9mdmeE0TcF/6MqoYen8SExDcMmmQ0ANO6hJudCtDQ6?=
 =?us-ascii?Q?EHVfi8Jt3CxTyriWAfA13PdSvWPsHNvQ8maKOtlwPVym3G9rnwDaB+k2y4KS?=
 =?us-ascii?Q?wkBKDgty6XBgmjAuOku8J7aUUGAQn1v/pxFifiumrnX9AkZSsyiLj6G6PcPA?=
 =?us-ascii?Q?JlupYlUKN1CwphLbE83dU1lFdP5Bugcqqixjx0yC1a/rO7wHJOg+BN58sYKt?=
 =?us-ascii?Q?ZPiZ5wPRd8FjhjEcqaq5XUBGyCwo6AZHS88TqR+jgt7LULRaJG8ssRRIOv6Q?=
 =?us-ascii?Q?Js4aT++tgpQde6zpnT+FQfUl4EwSDkrS+0l4cB8YjU30mw6B6IWUgcQuKZho?=
 =?us-ascii?Q?d3gpB5J8680mDhPNPWfn6rRNWRWucKC40yvOapjqPZm7Xzy2hUxOcm+hPLvt?=
 =?us-ascii?Q?FlNg6vJK+JoQyshCbvqRfbpCm6NlPPoq6UEHeZKQUg1BDNERCQVILQvgA+OJ?=
 =?us-ascii?Q?ekuTE88TCzOQrFDtiHFB8MgL2AL1Ajib1leGP6QwkVMmugdK00ChzaFyXN76?=
 =?us-ascii?Q?UYioC6akZHv+FeFhgwcUhi0FezEzcx+9qVGq/0wFPrro0gryaR+3OCQ5ulsw?=
 =?us-ascii?Q?UWyxgmOfuK1CH8qGyGIH2RPgcOTWxLf91rbnz4es3n3vOFe55QEeL3gYTM64?=
 =?us-ascii?Q?6o+OhGth6NZhwdEtuxLRiFnanSogrJWatH9Y7dXl1PXwO8Q2BWWjR+Tzjyuw?=
 =?us-ascii?Q?2dJOX/yBQhUj6sZ+iMWJEWzf9u1OefvZarWkhZ7paZzLUDpR+DWZ6XMYDpe5?=
 =?us-ascii?Q?qmPV9i4Qv1SL9jE1EaidjdiktRETQg586sQn9595SVgKNRVmrmUIPj2s5R0h?=
 =?us-ascii?Q?W6hbQGfr42azSW1st0wK6QqYFiDWi7IxqlKVbL5BBLXGVN6E4lheg3JyQfuZ?=
 =?us-ascii?Q?/B3kw0KuGIKVN3P2+GKaesnJCMEQWlphW2btB3H7M7DmTIgDY8dNhPZo9rz4?=
 =?us-ascii?Q?ti8kPMo5Vt1cHxgj9L8Xa00ebNIdnyIeEl2goN1eE9bpf/pa3ueQE9GIJ0o5?=
 =?us-ascii?Q?kWF7QRjcU41d6Wb52Ye6KoltoWs5YDHOHu+2D2w+fCnQ/vSLLwMCVCToZceA?=
 =?us-ascii?Q?dEL89bzT6XhutE4O4KImJZULq/y9MxnxOIalVVpk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043794d5-fc6b-4b0d-6678-08db20b21307
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:22:20.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sthvx/GZxh7zB21B6xH2rrvnX4bQ2COITDPfDBEiKOHe2U5sxTv4WudiIMztiuh8W/BSZFLKqj3eikuhQTlw8g==
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

Use i_blockmask() to simplify code. BTW convert ocfs2_is_io_unaligned
to return bool type.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-none
 fs/ocfs2/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index efb09de4343d..baefab3b12c9 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2159,14 +2159,14 @@ int ocfs2_check_range_for_refcount(struct inode *inode, loff_t pos,
 	return ret;
 }
 
-static int ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
+static bool ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
 {
-	int blockmask = inode->i_sb->s_blocksize - 1;
+	int blockmask = i_blockmask(inode);
 	loff_t final_size = pos + count;
 
 	if ((pos & blockmask) || (final_size & blockmask))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,
-- 
2.25.1

