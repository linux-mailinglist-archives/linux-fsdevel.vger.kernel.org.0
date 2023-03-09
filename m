Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B836B2460
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCIMlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCIMlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:41:44 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E822EDB7B;
        Thu,  9 Mar 2023 04:41:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS0jPPtC2MNIaXPnMOFiHSlfsglqEwsefJSwoHoHG4DWfERutRnlRrYhf6Cs94qFhb2Pgelmp7FNvmoK99iRrKzRzc/JZc5OYcffJ5jcUji9L5dDVSDgsNGDUwqqX5kq2JtqvrmglybanjgTNw+cM3a9q4zXiz//l1ZzbyfNGFyW5wjy3gWDFwL14Ap7MJcaK40PT4T3lNe+MWou/9RrGAvMqrZxIZ+3+owfpgzr8R4FJxygKy9avAaeEdphs1wtJ7elBSDVRExmrTJZvzvp7xT6KxcEWfSXdoUYu0ziR83zC8CB/Z7Xebt5QfyZWYHpvuccSqqkH46T5U8+rT/APQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z7X19ELXxbAoyy0SRQNbX79+Ll785DAlNhB1quh3gM=;
 b=EJ3lsYjFpyjy9CY7wnmtrJ/tnMcpZQORhFcqe3eHV18s9t8ZPRBIBkYDEGp7E1OAQ2Nwgf1j1LPdUMbiM7UD1Ap2FUTwZ5XfrItfdJtCROzGPfxQvRRW2p9Vk2kjnQYLTY3U/VydoPROS8BOWKpsl/Jy+4sOcX+xTZ+5qmTfPkWo1czqSLB8JRDQWRsQQ7tXitxnWSVWBhyjvDyhQzRigVwReIk/HOqy6m8YjL1nodj73toWacIrECuP6B1AGNnPxro5n2nInXkayJfPuDphXyc1FNc8LVa6w0yXrs6mIBz9Ypm3TT8qQ1Zckb967TYZcmW6xSz5cffjGudWKXS0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z7X19ELXxbAoyy0SRQNbX79+Ll785DAlNhB1quh3gM=;
 b=SnhJGLxFtCPjfixZcRmm/jyGrKC6ORp/INWYhRQvXkTBAK/Xpl8S5R3A6dD+KOVjSh2811cwTkkmMZb/RO0ykoffVRmicb9ZduBpvWX0OCrnLPGoCbDiN8nY+pXS3JjjgyXzZU3gt8qr7NM2j/34ONpmd4ZzpXF7qQ2a6DasPPD0lvv7Acn9OdktsbhCtHn+T5QDNOsQ/+ojeVQMFM1izTFYZ8CfO3b9PnUMmh6fzz+5LwUE1kCtaTJUcoXBEgDQa/QpsywI0Ronf/kkB7bVXq5qpL7Zf9gUF56LTcR7BJ67jtAI7F7FWXfRIy/8sVGVdyif9cTjHMZqCWNb6vXQMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6259.apcprd06.prod.outlook.com (2603:1096:820:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 12:41:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:41:29 +0000
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
Subject: [PATCH v2 3/5] gfs2: convert to use i_blockmask()
Date:   Thu,  9 Mar 2023 20:40:33 +0800
Message-Id: <20230309124035.15820-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2f2f4c0-3ffa-4533-c8d5-08db209b9ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bmxk9LMJ19LLxjIK7Gnr090TyGqOW7U46Y/tZmZifSSDSW4RNf7aH6rgN4EnpgSJisoOTOoMkHVafZqTDlU8msIpBXMFbpDS+jsKa2P/edT7j9ria3jhO4dZjRk9VDF3zUprP1PHXFdsgP7PrEJ+MD8YRd2o4o7AEE+Jv5IFdX2QFQcrb3A/vZUPDLO6uiVlkgrGePjb/hc98LZ91n/uyKEFWKMG/NIlPm0cl3yvZroDVUiPPapwGquGRtBUeXJkIKnfFWwvitViCbNqua219Ok7OQUcrhiJ4EVVS7PLzWus7RLImno8GKn7MzRnp1vFs8Wb82X2if5oeRFiRrnoQ4k+wzePOpPu4IG4BUmLq5VaRHwsZ4jo1DSw6F5FiqDhg2TBtPNXufABq0JWDfpVTmpZF0OamnKVjc1RcvZ64wpRIz+xkjsFwekkBCqDEM89q1mF8B46EjvcsglqLQONx3ST1U0Kz5ozBzCpmX0TehZhIwCdlD7WpoSnNQ69stjjsERCZkKz4x4l/UV4/7cFBtJ2J2RC3H6WaEncMp5RdY/tKlJcoLxsLwVVENBASGxBHOk6O27xspHAwW8BmckSC5X7h9O5dZpM+XEuXLue4QEw/2MeSBaare4aHlBpPdJSgZ6KYpR+96juFg08d6KZeXYMcXwNoms2dzsQi5tZ/+M7Wm9TY57ie6Y01kzqakxME4mgN9ZyJpWrBYCpQxgUslXk9SQXKWJ2E4+pjfILdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199018)(36756003)(186003)(38350700002)(38100700002)(86362001)(1076003)(6512007)(6506007)(26005)(83380400001)(6666004)(921005)(2616005)(316002)(5660300002)(52116002)(7416002)(478600001)(6486002)(107886003)(4326008)(41300700001)(2906002)(8936002)(66946007)(4744005)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ozMcl8yJ2xNy0sbfFZEJjzTtGv0fuq5gde9UNKZIflRh20tKbOCtIEfA6u2j?=
 =?us-ascii?Q?6xEh1rsLzoxZiOlrae5NEFxbXRrbB4sVIU7u9w7Pue5sdBpugpvtQbEeLHQw?=
 =?us-ascii?Q?9rxl7wIJYGvAYM41hMK2EguFseEiUy3kIQd4jDLtARIj4u6z8rqviGd6iK99?=
 =?us-ascii?Q?qFlzObrLU3RbZiEiB6hPZ5v/2NLt2H5ZV0izdnnEO0H7POFE3ua9h1huC/pH?=
 =?us-ascii?Q?6D4lPySMBYlFSog52QAQJx5eVrIubh4lxmQfL34LPHZdbX9nWRKMc8QTkmc6?=
 =?us-ascii?Q?WOko8rs0fnAZ1hX9l91uDFBJjXiqyKK7Rjh3pUxrOyXu0Ejs/xxcfduLNJPV?=
 =?us-ascii?Q?qjA+QKMWWDvbLlUDNZVSqXw03ANqQ6TiQ2HEQTQ+Px8XPn9VNuK1YzQ9+BUK?=
 =?us-ascii?Q?TIyG49/kC0KJmADeO9Q0wRfuRZxAwqfrRjKP9HlScCZer28w5Z2R9CUYdl2O?=
 =?us-ascii?Q?D40+9ksnDsYBpXxfs+ovp95dyReb07QjzLN5XPzCexuQqFHMuAm0Y0jIa+SK?=
 =?us-ascii?Q?On3bf0tTNgEKPmQcg97sE5VyAwG3CK/qVilKulok8NsehLOIvni+F1UgSHy2?=
 =?us-ascii?Q?1bQD3aVz0THMrw6kI9kjCt8JNJY8zv+kWO14L/m1ILWoWxIt6sv0SI0ajG/6?=
 =?us-ascii?Q?uDUOq7zsNaa5OCgqHgdtcbK+2Gu/DTjrJPbmCgXueddi+V1V1hQpc4BI3RXE?=
 =?us-ascii?Q?hDJRXrWEOfp3pagdAxgtecAUlRDtUdfhev14SOK5DmXz6DLH0KhiSnI5Mml9?=
 =?us-ascii?Q?skc8UxnO0QNV7KrW03xfzxCczoutI8Vdl8qF1oy64OYLGKzvdjc9c7pbvPHT?=
 =?us-ascii?Q?KHf11b4UjgQ5P5DIqtlalZ1F9qn1vatS1LFMoUZk0YbdbpWt8dyuYY8udB3P?=
 =?us-ascii?Q?DGbMbY//St7Ev7VQuEKgnZhcYp8KWWXEiwPGGu1RAv9SAjmHL+kZQRfkX/xO?=
 =?us-ascii?Q?gJ64HfGoe8TFVFL7QdX04guA4wTMJ7VBVy/6x2uXZJbCkbdN6/6IcGgi0Fva?=
 =?us-ascii?Q?hdF8v5/nVybMe8I8a+WyyYyc8A4ycL9fzRXq0mkpxslYwagp07Px2GVfSu6F?=
 =?us-ascii?Q?iVSj3ukrDuxu+g2nyi1bTan67R7Pw+9vBu2KtuUB77O1R7j0xor3UB/9XVSy?=
 =?us-ascii?Q?g4RzLXarC4x4oBe/6nrebkNRN9C+rDnLYq5ofVEcZ7wyYr7wnbBeEJ5w8V0F?=
 =?us-ascii?Q?+kBPQqVAJJKeUBHa/oeZ5VBplGvooL4NCxbpoH6gymzpDgBCf4kw5x0U96XL?=
 =?us-ascii?Q?czaOpJtQ/3C40T98atC5s8Ymoku8tYh7Ies4qCUkrrBNW1/iNKlrrGYDT1SG?=
 =?us-ascii?Q?Cnhw3cXbyaToLVyDFK29GUf2hOCEbIZjoZ1mIwoAKC5QGe0RIGzSMTGocmgE?=
 =?us-ascii?Q?vJ4ps05YRnLJttZ5AxPaWUh+J7FBgvHnUy8RbenUqdStZ5XCQ6p4oVPMuZiX?=
 =?us-ascii?Q?mQf1svO+YRjuSuqUJI6nGVhXSgkA3n1qaQ+pyCsVhMNYO6NRlCK0OBiu7i6W?=
 =?us-ascii?Q?SQ3UpBhxqDvF5iXX9pd4gpTsU1aI6IlrmWrEx1cD5ATexwmnZRwqxXg/Yo2t?=
 =?us-ascii?Q?GxB8ZP0DgK6ZGhcgBJ9She1hyPHnSO7RJeyTfenE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f2f4c0-3ffa-4533-c8d5-08db209b9ab9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:41:29.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VHGA17u1WDd0a0giZZqm7Sr2Ozv/qboL9WeHNxlJ9yk5qFcTq6iwG1GG/IDREqnaydWCJMDjt9u6XAJY6z1IQ==
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

