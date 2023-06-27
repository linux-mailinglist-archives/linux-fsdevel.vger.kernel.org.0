Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA373F9A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 12:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjF0KH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjF0KHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:07:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB735A6;
        Tue, 27 Jun 2023 03:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHXQIrcJHiruGfw0O7RnVjQzjZ4RtZyN20sFRQ75541XBN0Yc+EPYzUapE5GNg+jI5xJ7+vp9QMUTLkBVE/dqZqgLIX9+1dsEW1KUWaaVyy1wijXUhxoqqtLxhbTmCeHdwsddXm6deNYYtxhg59f84JdQlTdeF1YbylKuIfiVhOC2VKYFyJMHyRL1+FNhqeio1h7SagR9bPTz0OGniseGCMRKjMB6ecm+6I6o7hzGdSKotDHb8cw+/fNvc2dZ4NYHvpuqsu7mOotu7BQTqGwe0BFWT3t+hedHiGs+mcNnTQMFnHz3L6fxc3Rx4LaK6rVrhOZ3RUU7S4RZjd+Xj3TUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRviogY77aTWex2r7n6Wwr6YMW8sUve7ln3jrqaszRo=;
 b=lfzZD3zzJmsi/uxYOS1BHPZDTlci7vXP2fijhXY+A7+Je61JUOFR2YO7mvxgHZt2gDVv7a/z5j6ZL+5GAgP0RZ4FjptvPmUvYWFUXmvUkBtu/Xl8D3ySeBTr2aKfR3IvyavU7/Zk9y9maenN4mzhz2BAIW9EUp3cJGku/drt7baw0bL/SIWeIOm2FKSwn0bu5DqHlZse9qo2GnkVo1TvtdGNA/zLTi8n5EV0QojHIUksPMT6S7Ux8Lf97a/Qle3A9SqW+9V2+dh7+cBUUa0uywRaBhSDYaqPfhKQuAdbQRz9YYhB1EmcRHbuAAIxKgd6Djv9cUJpU3NJgjNjYxJrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRviogY77aTWex2r7n6Wwr6YMW8sUve7ln3jrqaszRo=;
 b=dbHBXI2J/LZtWcikcPdGZ/k4jHJp8eOmVUxKmewqR+c8/vBTki7Ss257nTx5lBQw1HWpZvCAMJTgrrXTQPHVPgJz8/HTIxZ8X2AD3xa4LAboTvoVLQE6wPlmHvs3M7lAOOF1JuXHLgvJQzstNXrzoiccMfZ6Um3mh7s+mlX1a/gMkC6+SOIyZKoTTRApbUP/pvoXkbFFNo2eSjKCBvzfJ4AGKqJDUjAt4OaRtdkr7E9I7PEcYhTqCicDlFaJffhQprpsr1gyk+4S+KErlLxgMXtv1Nka043TcLF6fkvVCNc/XX/O61dZrBYli2Yf1nPyKCjpbPK/Buq8qNQqXavWbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by JH0PR06MB6740.apcprd06.prod.outlook.com (2603:1096:990:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 27 Jun
 2023 10:03:36 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%6]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:03:36 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs: iomap: Change the type of blocksize from 'int' to 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Date:   Tue, 27 Jun 2023 18:03:25 +0800
Message-Id: <20230627100325.51290-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:404:e2::32) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|JH0PR06MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: b14ff433-f9f8-40c0-2e7f-08db76f5c5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nc3UYEW5ZWioy+TnhNnlDcPp9y6FzgaSdWjU/8wSQkcs8hyJjfI5pCbsSqfoLli9cobyCvOFtBcJxYOQ2g09eZDdyVvlAyWT9z48sDPok3CwJihYCVHyYFMYHHPKY+UFKg4Xi7X77/IXF6Y4ulwoHbDQG8GvZGGKqC/juEfOrbK8k5FF9AZZpDNA2DTPTsqojRIidU8EXY923CBn2oZ0wm1SwDAEvg9kBWGQwwDRY/j6kV95LVd/I5X4uMC01fH4jfFTBtLKf3xVlApQQyCIOScC3G7RznhkDO0utEl9BNg7B3/BhCuyhWOyWMwHAD9dNj8Xywp2gfsz8AkytrzW/YeZfXe5slKca+IoKqKqRv3yVfoBkr12Juxl3RqsALEodNPKakcXK84of9eULbgX3UOLs21yQ7nJyBP5Mh9oLn8/UYCY2PfJodeIN/N0Kae0QMSpPdafSl4JByvf6KoFyo6tfZuMvNKQqcQTrD+xbdoo/iJTebAFbnJSGYZF+u4VM0Wy7GqlDlq92In/DAy92Gap5YCg5glcsXCH76EIDjeJxjNLOpQPKKNS1CsGuOIyTwFR2HNGWwQLbgcHNVfHlY9zYRh5PlIY0gUCsNUux2nzCHH8rX46saofqJZ1FlLn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(110136005)(2906002)(4744005)(6666004)(6486002)(52116002)(38100700002)(2616005)(107886003)(83380400001)(38350700002)(26005)(6506007)(186003)(86362001)(41300700001)(478600001)(66556008)(66946007)(66476007)(316002)(4326008)(36756003)(8936002)(1076003)(6512007)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGeyur1E0OumfRsZyPWCa5X9TmRGzRW0kz7vttCFhooqRCXeVB26mgxzw/A9?=
 =?us-ascii?Q?63h9G7FoGwvRk2wpwyImVtmdBLPiwYVPmQpWwVBcXjGh6dVeU5yyZ1tk3pZV?=
 =?us-ascii?Q?LtraOK5Mc8+LyZD+wbku9Buf4Jm8CGdCZdV1sQEGhBdu0dcBXmGIysT1z6xF?=
 =?us-ascii?Q?Re1KqCW5Wg09fcm711hI0gzIuPYxC1JUb9/VbyF+A4baj9emvZJZulDLH6RT?=
 =?us-ascii?Q?4Xjqe/oWIrjNCav94Uj0Mw7/Pf9zpaI7XYfH/fQpeVimtCjc8LeCPNpKtqcV?=
 =?us-ascii?Q?980/NUT+oPkK5ZzEQOn8GORnDEpJNYm3a5nCIIaDrtRis6iomdQYOmDG5nTW?=
 =?us-ascii?Q?JQyNzyeS1H7s0/5nD8P3OtLwJna4tGjtUHFJfERZRTsBsHyVjvTIBwdZg5/x?=
 =?us-ascii?Q?MQDN5pqxXAyw9LQ0eCOEyEcR9wdI29VrYO/tcEFfg3ATW9mxne/Vny+DOQZ2?=
 =?us-ascii?Q?aik1n5qHl2YmreFnKD60vp08m1VKiLNhB2xcIJdlOSof58zgyB/+m5HfPvIx?=
 =?us-ascii?Q?w6WUCB3zbnPvl4TMsV1CZwKIQiBM0/TnwuHKCs+0bGIWmJ1NE2RlDMjC7qgg?=
 =?us-ascii?Q?xNdwsJFhmSWqM+7aBQC0cgsd3OpoAudsuM/dIyIf/3b3Gr7rtDYKrCU2r1w2?=
 =?us-ascii?Q?62Vqlom/MHwaYBGj+ZGa5BcjxRNCEIH6FzdipriE9RXmtDakVw8GvQsHVXff?=
 =?us-ascii?Q?A5nnyNKn5suOtxuw4tDw1/BKFRsZ4EYUQBIN7qMjx4rTp3T+4kfK4cWZx3o5?=
 =?us-ascii?Q?yvi63tRQtrqhLqDqQZBK71PAG3YEXOUVLRu16KhWAPSVB6IumZxXM4nhVKDO?=
 =?us-ascii?Q?fOaEMe1yzTWKx3++jt+mqvbUhewtzzYuytMZjoUwjVtqkboVdInJTPPqr8Mh?=
 =?us-ascii?Q?npqavlSOeay2z2RXXAo+Y3y9L5wn5rpQ4sZ9pKsGm/hA9HAgxCKWLrd1+a2Z?=
 =?us-ascii?Q?SmuOyIyzzlIkSG1set5ZXR6EPHRjLE9hiBeQEWPCeo7KsJhK+4h1oaJv/n8+?=
 =?us-ascii?Q?Ape23dDYji1jiT88aVxafKS/pDdrOAXE4yMXvLzs9nIv0TeRenq6UMi4Zmlz?=
 =?us-ascii?Q?AjeX2kgEcyZtPcbk2Qw5KNozgRv5BywC4TxpWrVTPlAJqZAqy1CKHmxLsduO?=
 =?us-ascii?Q?hP6SoZdoFJHNHgoKoFD6snBbj1m/uFPK3BhiSI4wy2qLcDiUvUxVFf2DDCSM?=
 =?us-ascii?Q?RGu6Gru+frA778qMBHRPB7ADPSv4MiwTPou0idViox36QwhAoqAv1f51JKzm?=
 =?us-ascii?Q?pLFtatfJExYN0gx9SbWJFH3jC2x2Zebd6nJbvlJmhQw0u5IObBy1csNuGr9P?=
 =?us-ascii?Q?o3/Jo1uoMNekTZqA+retGdvRWVM3ETbBhhoWNp7FQxkzW2yOnQwUduhLxny2?=
 =?us-ascii?Q?5TGx6Xip/IZGXxw/WMpjVaKdjRFIUyVIDSsrcG+VsyC79YKpp8MdrsmcFPll?=
 =?us-ascii?Q?jlNEakIx5IYHqxEb3X27DNkuTL0ff5um2+giJlT7xcN30SLhkQvLksXl9RMi?=
 =?us-ascii?Q?iV6xbjutkjsvLg/47I5yAe+aGJGjcCN+en6NB3JzShO8ET+XR+T5jdoHiI12?=
 =?us-ascii?Q?gYgZtzm2c6gJ06TqCM7x3AL2J55GRVCG/DcWJxj/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14ff433-f9f8-40c0-2e7f-08db76f5c5ee
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:03:36.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2nSwHz5qfoUIfZmM4rlvPvJiYV+dlz9Fs+tyZ0Oa3sgLoH86Gj64hcIFVS6qt2msB6glgJVWvhBDkXli/OTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The return value type of i_blocksize() is 'unsigned int', so the
type of blocksize has been modified from 'int' to 'unsigned int'
to ensure data type consistency.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a4fa81af60d9..90ea9e09c1ae 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1076,7 +1076,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 {
 	loff_t			start_byte;
 	loff_t			end_byte;
-	int			blocksize = i_blocksize(inode);
+	unsigned int	blocksize = i_blocksize(inode);
 
 	if (iomap->type != IOMAP_DELALLOC)
 		return 0;
-- 
2.39.0

