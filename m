Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86812751F70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjGMLFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjGMLFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:05:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA0211C;
        Thu, 13 Jul 2023 04:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge85yAeRbmoTqkl3PZ8j/s5oPXFdxDe7ExzNY0JoF1KQVy4p1dGnN2J95iGYf6fra+PkvUiN7xfBtmo1WgOp5dokd0h7p2teOInF2kBtMWSf+NcnPZruUJM8xStrBinBjTzF+h+z7ZDxGtD1R021AlZ8OXAiTIfzea6QATK1qlwioi5ii0tPKcVfrkCKTJM9O2KUaIAnbLiQrDljiQXXBAJ9SY4+Qm06kX/sWnQ/sBwmHNbkkXclZ83vZ/12N7U69p0W9+0oIOt16EpoVIZBS+/8DY2wVUCEyMPRH7gBo7ssTrXrXDEK8iKs6UmBTs8ItfOhw1f1iX3Hsup+GVxLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ4aHi2/QlKSI9gpcQ3FCcZBADISTe8CrPt8NhidorM=;
 b=JTW9sS6Y3WqId+FWl1QQDzKe9c7oCM6alPCnZjs868+BdW7bwhElurompGQ5jrKXFRBupT4X82UEuU48v/sGCS9dBa8ZfqSGGAhAGA3AczhpUb6gc0k3A6ZWv+2E8x7MUtVtsAjyr1HrNYy2Z9BMM7Ue2W8egOytxG/HnY6BjQxhHyIk0lSO2VvljHXWV77wxBJIBoAy2LRJ2dAYiSKpaSqhlDowFkR+Fhn5LdI3gI2iebMmQUM62UU2PC3jBfSfGwKW2zdxTPuj/w0/mG3aCBuaWxXuUlOpsUXOENEegVuiQBG3rBcvj5dUOuC5i9+hrcDL3chihg7TlJi5V+tlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ4aHi2/QlKSI9gpcQ3FCcZBADISTe8CrPt8NhidorM=;
 b=M9Ag+ZrG8W/xeH/FbcrQmGHQ+3QCnyD1rjL+ixZq1T5Sk7eua84QFZ+S1aFRaH47LElA3LLjaJZIyYOgvw0imeFIiqDoYaLsc+nr/nw2KMyi6PED/LYiI+R6isv24j64uLzKovInPGqFGWdAmlTTW5QKSQcdNsP/THf9ecIAtOsYTCeKouyOS2z9sLADO3Fo8haIU2nCcfk3bhLpBGdOk9oHG3V11GZArWwfMSS3icpP4iDRRI8gpnyASPM5j0MAt0w1PKl3KNmzAZxiR3UI3HwZhv89mrhMR4/O4ckStEUJc1MzHei7Xaf7Z/+JbRSnASH3TDRZ6Lo2qFEwF/6QUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6403.apcprd06.prod.outlook.com (2603:1096:400:428::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 11:05:44 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 11:05:44 +0000
From:   Wang Ming <machel@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs: Fix error checking for d_hash_and_lookup()
Date:   Thu, 13 Jul 2023 19:05:00 +0800
Message-Id: <20230713110513.5626-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 604016a3-3395-4b48-ac40-08db83911a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ReVBy+s07cmEuF01dQvnQ/CCzSsf58ZAUaZhB86Snc8In9J6wczx+pl1zUOcvIWtUfzGZ1pYpsgaBs62yA1+SV5Ns5kM6ozfSsiBcub+MBFgpYZ3mCMDYUMkDWzFpDFWWO7N3nB91+FVAgpg3AqUz7OwRlk1aup7lcEy6M7TC/2iBH2qyTpU2djBOQkjMkE3a7idbQP9K26vHMmtGii9CnIOFHWFMpcryGQei8wVLHztEJBjakItXMCeYE4L4Bb2y2l+z2wwJiNWarvjjdlUKlIcf3op1qpmCIHFWcQ2y8bUd2RPrIwFoHqnahkR407XFuNvqC8Qw3tYU1fvEBLbrmXrbd6ID0K0YoTUZO9C9jT0mGtO9VUpgyu7LoKfq2gA2thzDKB4cePtujghhLoXIxCGKEwd1qr5KsP6IWNwM/CHxKgFyQm0BRQS6dih4qFt2uPNcDLruAaz89fsNp6pYHA0EwMgen1NOgZBhG5709Zrh8E1q1yZK9qNqSVNNfDY7UJUTd09T0+OUHE7SCir1VsQlKuYGLCkggfeXR66LQo9dYkinvMPZyU6hKaFuocAN2H/cjA7vHDzU0BxIF4WxtJbOtS+1oidjw6HWDkQCcX7op3o4eo3AOys7lRdq2PM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39850400004)(396003)(346002)(451199021)(4744005)(41300700001)(8936002)(316002)(2906002)(8676002)(5660300002)(66556008)(66946007)(66476007)(4326008)(26005)(38350700002)(107886003)(6506007)(1076003)(38100700002)(86362001)(6666004)(83380400001)(36756003)(6512007)(52116002)(6486002)(2616005)(110136005)(478600001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRO0VlKNkOsR2lcOk9eXP3E4mN/DfRiAL2D3t8kIjWykx+DkrjPuVb+PD8P8?=
 =?us-ascii?Q?F5WwQGO6KrA4LOtmrZpC4DqtsayuUcLdgLb7bjZ6WWbWn6OWGTJAyewB4X5f?=
 =?us-ascii?Q?T5twisJHUsVHkZHZjn1NqHdiywM+pYSFnfXTonqoBr4yUiZ1npo/7tvNoPOF?=
 =?us-ascii?Q?q5NaMvLVwuhzY87r7ikLcjfWaHfJUG/+riXCyW3CzlK7qqhn9kg9lq06Cy/e?=
 =?us-ascii?Q?p2Ny9OHuMEajqGFWY54/FQTDA5pixXzkHRS3EoNbBo+Vlo/XJaaX9wiOygxR?=
 =?us-ascii?Q?C+N3vTPRHculLVSrsY38exR8ECLESiVXwxGJUGEXOo3aSeslkq7A41nPPdiG?=
 =?us-ascii?Q?pICG/Ip+6M13k43X/hT+H1Qgo0DaEtpoi36UFRBRCLBgPqHfpqF1l1atIVJ9?=
 =?us-ascii?Q?KcgIeUub8oZQXuTOmWVL/HyMYrp2mJmx5j1VtK1sYnxrM31mokHCacuYKxyV?=
 =?us-ascii?Q?8S6kkdo8wFFNyBDY7YerCBpBqRY8jnE3UYpasFq3uNwWA3p5ZvU4X4/QFX6J?=
 =?us-ascii?Q?pzHl/FcMDMnZ4DZPr8FxzbdD+ICdeSF7dtrGMKqrvQ6vhwB7FGFFEOSkQMLH?=
 =?us-ascii?Q?Q433prCItc6CRiBcESWCPYd7DQwIjSdANCpTEcDvldY5ou/aC/GieuwqwowM?=
 =?us-ascii?Q?DTRQ91aP8PEB2u6m+TjyvLUo0H76tG5M0AB48kw81njW7aL57+ZKBez0yw6b?=
 =?us-ascii?Q?R2KzCo/uGVxynlvMcNwgRCLKfUTXx591ta0N2tsVRac5UNOznNlvmv2/gITz?=
 =?us-ascii?Q?mrWIBebeb4zwwplcpnA2oqvdkeCIL22VsLRQJH+57/iz5k69p0SPMo431Hm2?=
 =?us-ascii?Q?yv7vdO6Gj6DGLMUI0Fb0eED1r6yFoJyNmQ5A3rEPUdfrUBD7+z6iXTQ59AAF?=
 =?us-ascii?Q?Ngyks24kbA7t8SRUE+p9sgb3ffXWi+n6fwdVvAQI1H+hM9mg6+tJ9IgLvrn9?=
 =?us-ascii?Q?PZXgWB6l8QSfg+Q+2ObOtrI49xIF3TBDiwr8j+yvTK6+Ck5xM/PK50/lNN7Z?=
 =?us-ascii?Q?MLIoQFjl8H1+TvOVwgTlOP+bo6evb2N2MkM7OfUN3SEGzCMTMHWDrGCMzfg/?=
 =?us-ascii?Q?Cwy+NF3+qmS6tAj5cCeyiiwEo5bWfwZVYRPKoxUYe4g/00eIhDDqXkDO2q99?=
 =?us-ascii?Q?XBN9gCsaE80S8K1vwPEYQwlp2V36I9EQRs2Y6VDOD/G1teoPh3C6kANzpTgx?=
 =?us-ascii?Q?UB57BjEW+3npA3Mqjn97VGbMD2zT74FtZA125a31v1euUVMSVDs+2AfhSg0/?=
 =?us-ascii?Q?j50k3WT+czLV1/kdzpsyfAcAKX2EBDSbg0EtwsfvGHgga0DF10PcduuDixh8?=
 =?us-ascii?Q?+cWyFV0fdvS7wtmYI0T8OIRaVu81ktASOh8DQVIHddPMwmWMKEWgdZY2rUnC?=
 =?us-ascii?Q?Iy6LmsznTEC3exBsfrvAzMTdy06LievOX1J+YJIW6kUlFN77bBIOtQ25EtxD?=
 =?us-ascii?Q?IHusa8P4SvOp9CCzGVps5sa5u1ZzocTsWrP1ozuILXbL9mP9bgtucH8h8aaG?=
 =?us-ascii?Q?uU8cKPjeaJ/bJXhQShtQnHtHvYO6mqpNp/6LBFvMcpcB/9LGB2QF0VBG8iex?=
 =?us-ascii?Q?Wxk1Sf5yzvMmyhoHRewYb//6lGcP5Lp5iw0c/Cgl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604016a3-3395-4b48-ac40-08db83911a7c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:05:44.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+oxsu+H43Ng5AcG1k734aR7Jo4TLRkFyLl/Iq7vGWaskpU+P7KzIpBv9wV28d03JoIMcRtK8ONy+fmfHHM/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case of failure, debugfs_create_dir() returns NULL or an error
pointer. Most incorrect error checks were fixed, but the one in
d_add_ci() was forgotten.

Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab6b..2f03e275d2e0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2220,7 +2220,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 	 * if not go ahead and create it now.
 	 */
 	found = d_hash_and_lookup(dentry->d_parent, name);
-	if (found) {
+	if (!IS_ERR_OR_NULL(found)) {
 		iput(inode);
 		return found;
 	}
-- 
2.25.1

