Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FD30DA61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBCM6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:58:53 -0500
Received: from mail-eopbgr10139.outbound.protection.outlook.com ([40.107.1.139]:5454
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230153AbhBCMnP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jadRm75N5snm/qtG0F/4X6A2wMG248p742/wCH1HdEdCM7iQjr9YjJMixCqMAUGphya5PeZo/raPqf5urhDuSw9qQ+sgLeJ/LTepreFDl3fqaOegwRtNkDc052kXQV3x/GTlCOBEnlvxZcr3Z3QcjtthfR6LawXNksmEhaPDStBzbjmNeHgB1peqN0YGnlt/G7QtfmY9eyxJrqsNYKw2/dllBhFQG6IxG6gqN8nGK6GONsVKk0a4a7dU1hNIDHMsBk1CZB7V286vuZt5nd3ucR5q/LWvv9knCyO5+mtyJ2gWmgZxPG3f6x4ZXAo36TXtBiyBQhSPAwLsE/B9fPEx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR4tRWroc0/IPrJ+7QnI3jCqi6K9po62yZk0sCRNISc=;
 b=biKtqUcUTBBVMRPGpLQ2h+s++PmbDd7Alo1zrT29Jj3jRirIavCguCWm3suyWWDmib5RfL19VAgzMoMIWglEvkPwj4ac983vCfimlb+8cnEAY+gxGuSugtSYZL5lApl97VJdqpJffBgi+zHnm5vX7uaJiAk4B31y1Txk6+9tUFcazX0lCMUUKvOz70gEuNbyPbcRvH3sJ3gSGAyPdUvWA6XlUNHAAzQ/B2ri3wQMITn0RfMICCMuHAbPis6GcyDtyZdfE0VyTSXynD25JPye48JNVf79vXezB9p5xjySSSDzfWVbNGBwbfSA9Y0t1pdB7NQ0/2waCutQof9CSPREHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR4tRWroc0/IPrJ+7QnI3jCqi6K9po62yZk0sCRNISc=;
 b=X0VA+foir4K1srb4rxskK3xAx2xUm4K4cx+gfZiKHvgwgkhpjoM1x1ksZ4gSAGkw7nykCI7YYOOvBrt4HNTUlDTBx8fFNElcVkuWxi0F9GTCSZCkdYLn53rcEz6VhTxa8YQTZBrrHETEcpxjE9z0WoKYzSE/gKMZBPI+etUqNZc=
Authentication-Results: poochiereds.net; dkim=none (message not signed)
 header.d=none;poochiereds.net; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB2896.eurprd08.prod.outlook.com (2603:10a6:802:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 12:42:22 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::61e0:7654:24b6:9159]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::61e0:7654:24b6:9159%6]) with mapi id 15.20.3825.017; Wed, 3 Feb 2021
 12:42:22 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Jeff Layton <jlayton@poochiereds.net>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
Date:   Wed,  3 Feb 2021 15:41:56 +0300
Message-Id: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM0PR02CA0203.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::10) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from snorch.sw.ru (81.200.17.122) by AM0PR02CA0203.eurprd02.prod.outlook.com (2603:10a6:20b:28f::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 12:42:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89de8629-320b-40e6-e20e-08d8c84126ef
X-MS-TrafficTypeDiagnostic: VI1PR08MB2896:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2896B9927E3474E9811DC00DB7B49@VI1PR08MB2896.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkX/ADFrGmZoC0w8ACddyarG5N6ldIShi/x9dE15wjeLywqkeksNHOwkFbiGJqw7TUNmgD+xxEYuG/KhZniKmDhNGw6K03jxku9L4NYhSnZ/LbAD2r3+kxOuxhNaERQmNEn2dW8PaRl2wdiqWck6P9Ailv4GDVD9wZodtDJpUMxwV0thXzsyIy/juhIyqMUBHdHDqhl2hIx4HufMkCvnPTiBC9mCa3vvH7goU5ZSt1Z55aDdF6ZVBJ7iQ1Vgqz8SRPTxwf9K0SQXTOiOLVzocNtCjmQwvxjJFTqtef6ZP4w7sx9qkLaJyu0tHAvzYo/Qq3xcXzO1w67MoyhjCsa2SB8hY7rdjpp1OsKZrL5SKFaKM2TnDqJ8+V8xuf502iQeZBCAGa1+ffav+1HIfcDUFaHMWO4y8b8jx3gDOeEwsLzsJSqsHFcPANx73U8yUdFGdM+w0cOS26Y+zY0YZIn+iWQ+9syf4pGGE9fKevEK0sSurLm+QGv/0RqIiuz19u6eB/uM7n4fbolzJ/EcI0PkVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(376002)(396003)(366004)(136003)(66946007)(66556008)(8936002)(6512007)(2906002)(478600001)(36756003)(1076003)(5660300002)(66476007)(316002)(6916009)(8676002)(86362001)(6506007)(83380400001)(16526019)(186003)(6486002)(54906003)(26005)(6666004)(956004)(4326008)(2616005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sUKdRkHLxKYJJFEKHGeopLEyoG7oCRVdsl+6Anh3qur8va9k0HWhVk2m4TE6?=
 =?us-ascii?Q?2g8j2vyPD3BUoLCannvigvDhq7tVnhFbiBS3TRtcHAysJi4PQaGWqeE9Evxx?=
 =?us-ascii?Q?ztGEL63W4R2reJKHhxOn/eexL/CqLOhMZLdqySaip7vPB1rh1ynudJnUdo3P?=
 =?us-ascii?Q?jvzNsAYco1v/9edxUURkO6S78TaI9f3Gyn5LgA8Y1i5gu67csCCnF6HCXWDs?=
 =?us-ascii?Q?R1jP4N3XAKKt8cqQCMVO724QdrnzIyCNkGqHANJn4grrKOJolmGXF6ta0Xp1?=
 =?us-ascii?Q?kFKBgxwMfaVGNHGvMg9zpbpJAlp/Zs/n999diTw+qIcuegRfvqJMuSsLsbCX?=
 =?us-ascii?Q?o5+402YtXeKMGN0yVTHudJorNRg/dPHeI208iofdJ+sOXkfmU1FL+iF9oLy6?=
 =?us-ascii?Q?mA4CSYfuvJ/QmkVlcoT9fcvPnoGbz0o0YOiyVvEdAeos4tmGAhOnCG0FshTE?=
 =?us-ascii?Q?pALkfBDRo1HmCTmADRcryilF25aE5N3HfM74zJ6ZqWEoHNdgFIIjdAFmGPYB?=
 =?us-ascii?Q?4QVEiW8YVQQZ9miA5sUiWkWsa00Tfs7Dbkn97oxHe6AP4SWohtYq7lbIcfPX?=
 =?us-ascii?Q?QUJUKfzPahVyXmjSqMv9K+fKu0cLp6/bqfLBcz4kZtGe/e6+kkHt03xUFnaj?=
 =?us-ascii?Q?6Y3zyeBsxKhvQTbTb6xaXqfqC/Dl3y4QVH/bbyyr64o1NGUCNs+AEnmUXgrv?=
 =?us-ascii?Q?PYGPR+a5jzhL4bEiYZejn26C5Hmfbvf8EiUn4gxlUxiMqlOgSj163XfoK6gU?=
 =?us-ascii?Q?aOggC6F/vOyVJ2owX3nhwKaalv12VwIx92psYjv8K012EYHzm7iF6rSIb5nT?=
 =?us-ascii?Q?qcwuls53/Y5K4toezro6Y1zOik7CsUe6lxqGiyouwTm5IhIq9hjfwKrQPxkP?=
 =?us-ascii?Q?g6toqrcYXPHyrA4Zf6eETplZzRnvhz6GOleC5081GOawvsh8D9QUvQ5hVimZ?=
 =?us-ascii?Q?ukT8ZcUA3Mm24l/zXDCgnxn8PpCT7Jd2FqhlvF6POto1qqetP6dh9p2Gtss9?=
 =?us-ascii?Q?HpA/7EPA1z0Q74FNqD5n7z2LF4A5PNNuDO5svGvoXUVPtReMWZScnpMjNQES?=
 =?us-ascii?Q?ejIjEZSx?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89de8629-320b-40e6-e20e-08d8c84126ef
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 12:42:22.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e496jp6uqXbXx+KVgl/ytQ48OuQWvqTmerGlsMaTs8uVe2nyKXF5y35OzG4KgOa+fOZlePZY8PVnJpz59RlsmS0clzkEWHWHuVEvPhLZ9/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2896
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there is no way to differentiate the file with alive owner
from the file with dead owner but pid of the owner reused. That's why
CRIU can't actually know if it needs to restore file owner or not,
because if it restores owner but actual owner was dead, this can
introduce unexpected signals to the "false"-owner (which reused the
pid).

Let's change the api, so that F_GETOWN(EX) returns 0 in case actual
owner is dead already.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 fs/fcntl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 05b36b28f2e8..483ef8861376 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -148,11 +148,15 @@ void f_delown(struct file *filp)
 
 pid_t f_getown(struct file *filp)
 {
-	pid_t pid;
+	pid_t pid = 0;
 	read_lock(&filp->f_owner.lock);
-	pid = pid_vnr(filp->f_owner.pid);
-	if (filp->f_owner.pid_type == PIDTYPE_PGID)
-		pid = -pid;
+	rcu_read_lock();
+	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type)) {
+		pid = pid_vnr(filp->f_owner.pid);
+		if (filp->f_owner.pid_type == PIDTYPE_PGID)
+			pid = -pid;
+	}
+	rcu_read_unlock();
 	read_unlock(&filp->f_owner.lock);
 	return pid;
 }
@@ -200,11 +204,14 @@ static int f_setown_ex(struct file *filp, unsigned long arg)
 static int f_getown_ex(struct file *filp, unsigned long arg)
 {
 	struct f_owner_ex __user *owner_p = (void __user *)arg;
-	struct f_owner_ex owner;
+	struct f_owner_ex owner = {};
 	int ret = 0;
 
 	read_lock(&filp->f_owner.lock);
-	owner.pid = pid_vnr(filp->f_owner.pid);
+	rcu_read_lock();
+	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type))
+		owner.pid = pid_vnr(filp->f_owner.pid);
+	rcu_read_unlock();
 	switch (filp->f_owner.pid_type) {
 	case PIDTYPE_PID:
 		owner.type = F_OWNER_TID;
-- 
2.26.2

