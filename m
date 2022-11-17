Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A7B62DAD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbiKQM30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbiKQM3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:18 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2058.outbound.protection.outlook.com [40.92.52.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39448655B;
        Thu, 17 Nov 2022 04:29:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXwaxUTGfAXspt9VA+5dsh7LLWFDqeq/zmzrj+lQtkIESOjDJ9s370PNDcDzgT0YSBAJ9ZmXfwTHywSTbYiCqNsdplZXlF17SZXzrzIqkReOil2o1jUT37J5F9MjxTsNUVUkI+NXE91uiuOdbtvOoAMIZaYbbnxBPuMzQLyMybYZpK7EkPQqBPy4VbHUX+heCxMRLKWWSsKp7ftrDuLrhZh1yUDdRAxLudX3fsf/o5HNXDb8N1wlSzMrthDsycM/8yOOg1wr6UzkxV6SUFNsUTKTRaHKHhg/emNDatYbZuJGHQ9TfMWdRwnkF8Bq/mlgokxve0WaDk37wyhnmRO8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU+FHqP91/wG/a+mF+xODp/QmS0dvA5n5T42OrowcR4=;
 b=d9Txnsoxvty/10CErDuscKUqxj0qfTlgVXte19XGp51O9qxIuwiyxjQtPQwgkvvXRbPody7PqXIqKk74r4lIMQPWlCQ3t/uR9FOtnaOIkgABN7qcuNLU8oqMXgxMfbK/seGD2UzhmGLznHnaCHgSAni5vPGe1xN29fkWUKp9ft34wrWrNyx3bSAZULCIwPtCfLQfCp16VcqH1sRnfH7SEq3OL6XwCL97p6UUNTeZBf9lL8+yh2XqIVg4XzLYGk/FeyMsg3OPXVH/ZiqRbXZdOa2pZb1VaiqKWvYcmS08S4a1OEBQUbjDDlHwKzpzbHFlaGDVibdxL3EdBHyjwgW4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU+FHqP91/wG/a+mF+xODp/QmS0dvA5n5T42OrowcR4=;
 b=UEoJFSWUvFFS3lrncD6/PJ/cuDehjWDB6xo6z+oE50ynYTMeKCZMog8i/MnIIZAbJoTJeEFKfB8CSgjG5r9toRwg+l5Z7C/8DurmWsin22/2rwWUICqvM+JJ05x8+SFJmixh7/Erba+mRmJOnEaKfLi9l6Hrqo3v7tc7LUPcH2vvaMcZ6yp0f9GdQ1BL1SLLeY2MRYdtpJ1Ouemdcx603t52+5PyDID00O2w1qU2qfdWL078zsUt2CZIKQ6lV8gAB+lVRkP2EzAJouFTRdVuAWFeD+G01kd3HXaJa9L9sgPBK0sU760oZd/iLo6ybzQkrCO09Ei4QVPaH76nze9exg==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SG2PR01MB3610.apcprd01.prod.exchangelabs.com
 (2603:1096:0:b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 12:29:14 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528%6]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 12:29:14 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: namei: fix two excess parameter description warnings
Date:   Thu, 17 Nov 2022 17:58:45 +0530
Message-ID: <HK0PR01MB28019953A3C47F9B4479D877F8069@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [R6SebZEXFZUL/Fz7IfwqRqpiMP9Fxj6Htnf1pYEi+1RpxLwU2B1guE/aZYiOYfUaUSeOBLEtysY=]
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20221117122845.15729-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK0PR01MB2801:EE_|SG2PR01MB3610:EE_
X-MS-Office365-Filtering-Correlation-Id: da91af67-c866-4824-f748-08dac8975626
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9q/v00LXRlKtdzdy6IgxKMU2hUcM6tXIV6tspiZ/4Gq3NiQuwlEYDS2DD6t8nEKII0/5Zes4rUHu3Z2ZkH6jisCLZfAEqBMV/Bj/ts5Qq2W48Mw4A/CKe/V9zqjVXpEsQkEIifUGEpsvuVNsd9hQ7QFNfWAkBCwOerqz2FgFzIa2Bt2geohZxpjUOeLphzQzJa3Xo7c8xMxLbXH/U6Ps4NZcnfXNHx36/T/Rr7JsVqw1FQDSHJkuD2NgIzc65gGtnVllJpoFzMQyGgGN+1Zsnv2U2XKqeUurPPaO6d+oJZX67q6FYJ+rZGIaILI2zMLB6FSIyW/QEtqiLJ1TqoXz73CT8qK3Wxl/tdiB82uNs8s3QdIaI9BBmbWl4bOMgnEnxyQcBLwfKy7LUciYDTDV6exkraBWps8H723M78TeC6+P2OTSb1z2jX8PtsRvHwmuc86PRHxheJdXCGDoBZTZtQedREyurh+ObupSUpJyIWoKzXllQkvbJG4PYSaibySprBrWnYhcEKYH6Ddnya4s3dIo0zUzkmyXJaFWW1LB1F4t8oOMDM200nnlAlmEdNLb1Aps8zDaYme2mASJf+/3TPAOGgmC7SoN2EB4X0bfbUc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prXDpu5LcIwHqnFsRbJGjDW9c8UKOGRS4/zzuKEi4WgN9j3urxrxacHS0Duj?=
 =?us-ascii?Q?p2hOcLbW64uqGs53YEyNkXpO1EAPQf5u1x50m+rBldl2cS0XjfJO3Q3vPjE1?=
 =?us-ascii?Q?KFU2ykjtW2hEhpRyMjVzcah8kb+T9kkU751jghLhiQjxLPVaaQHF5qJmQbVa?=
 =?us-ascii?Q?MJ36zmbG6aGI5v6f5vb84Ki2khkqNjCANaaGRxt8MC1xnj7G9t5TkkgxotX0?=
 =?us-ascii?Q?nzigF/Kg6QBONGy0dCXlShRX2u0g1nJRZVF6H4po/aFZp4Roxc+AO4ED6HID?=
 =?us-ascii?Q?pXduapts5XDCreZJTKUrjtA82ij+fvv6EY+7kp2DrUvjoHjyccqkWc+/vlH1?=
 =?us-ascii?Q?PsykkNYUUcRxVYajVNG9i40E756GlpVN5UemZ2g4MEzAPUbW0SIPUv+iKNnU?=
 =?us-ascii?Q?+2QZgQwy00VZg26WDzf20yZ4e/ciuu6aIXTF6TBR6WRIiKpSs0e4iLiUUTfK?=
 =?us-ascii?Q?OXtv8zDFcuZZvCq9M5MIgc1drK1QjlH2WvWMaCZDVNVl4+nKHL35hoi19ydj?=
 =?us-ascii?Q?ohIi4GNxU+BT9789ePTxUH6BiPsd/iwQ6B0EQenuGZU7s67SwTTeAzz5EmYY?=
 =?us-ascii?Q?8LXCMWRWr4fFQjZGZfAraKzcbIocnzaflufGWsHflY2He09xNMKQ3DNGo9Fa?=
 =?us-ascii?Q?nICpYMuOkeqHY4I6BjX2iXiAZmATV8CVIRSo0KyVHq5JbbEaZSR05OYA+pi1?=
 =?us-ascii?Q?5Fxlg9SO4iIn6sKjwqifoM9Fj0IKOOffBusd6DLJ6BE+GJ2TEU98iEd5cwzS?=
 =?us-ascii?Q?AuYLlNjlBUbVm+PIQHOVtA2W9K6CvPXHpJUPEnzc7otvx4hkrjuboTQ7yTWE?=
 =?us-ascii?Q?UheCb8PEW0tlWlVV+YthEV8hFV1OaSH7ClA0bCQk8dUlvxkvARdO7cMdPPjs?=
 =?us-ascii?Q?wcnDadqpktS5gkw1hTgsTdAW5H6V9hiNypgeTTsn6IGWhRGzAeZxbMlYftZa?=
 =?us-ascii?Q?FNJSueL5Wn9f6n6DNaXOxmq96Pe3daOSUeeedRB9jkkEX0MyLX9DvpaIrKx9?=
 =?us-ascii?Q?D0sNeuppLLrAjQFSsaCv+Ru+vpaDT8Ds6oWhaY728cfGHUvM58qmE0PQpbWF?=
 =?us-ascii?Q?n7YkrnYcvtTHC9brPk1XIl2wDhlgIl2MPjKovTANdk9iiktF9c9be00zZVeu?=
 =?us-ascii?Q?HYSwGfNY3XSaK6xpexxeuUJqHbQpTpqmEEQsNNWKobjYHQBcar3F0+KLQa5z?=
 =?us-ascii?Q?sED/ecGByUmkgWH345ooVwbM+FE/4+dGPdxZfjU/UlxULpaS9luOu3emeF3p?=
 =?us-ascii?Q?thP9jH6CX3dHnjtqbm1kSM+eqUKcNca1iHhBxhQhnKw2D4u+v3vuf1LJrVWZ?=
 =?us-ascii?Q?a7G2LWdybrtvDDlN+q9ldJzb1znVov8UXR20QJRiAs6eHYnYh2keR6FlbOAk?=
 =?us-ascii?Q?I9BM/c8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da91af67-c866-4824-f748-08dac8975626
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 12:29:14.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3610
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While building the kernel documentation, two excess parameter description
warnings appear:
	./fs/namei.c:3589: warning: Excess function parameter 'dentry'
	description in 'vfs_tmpfile'
	./fs/namei.c:3589: warning: Excess function parameter 'open_flag'
	description in 'vfs_tmpfile'

Fix these warnings by changing 'dentry' to 'parentpath' in the parameter
description and 'open_flag' to 'file' and change 'file' parameter's
description accordingly.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..8e77e194fed5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3571,9 +3571,9 @@ static int do_open(struct nameidata *nd,
 /**
  * vfs_tmpfile - create tmpfile
  * @mnt_userns:	user namespace of the mount the inode was found from
- * @dentry:	pointer to dentry of the base directory
+ * @parentpath:	pointer to dentry of the base directory
  * @mode:	mode of the new tmpfile
- * @open_flag:	flags
+ * @file:	file information
  *
  * Create a temporary file.
  *
-- 
2.38.1

