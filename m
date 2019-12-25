Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D10112A5A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 03:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfLYCzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 21:55:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfLYCzU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:55:20 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D0D8D244F6E1A80BF4A;
        Wed, 25 Dec 2019 10:55:18 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 10:55:11 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <mszeredi@redhat.com>, <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 4/4] fuse: use true,false for bool variable in inode.c
Date:   Wed, 25 Dec 2019 11:02:30 +0800
Message-ID: <1577242950-30981-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577242950-30981-1-git-send-email-zhengbin13@huawei.com>
References: <1577242950-30981-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes coccicheck warning:

fs/fuse/inode.c:497:2-17: WARNING: Assignment of 0/1 to bool variable
fs/fuse/inode.c:504:2-23: WARNING: Assignment of 0/1 to bool variable
fs/fuse/inode.c:511:2-22: WARNING: Assignment of 0/1 to bool variable
fs/fuse/inode.c:518:2-23: WARNING: Assignment of 0/1 to bool variable
fs/fuse/inode.c:522:2-26: WARNING: Assignment of 0/1 to bool variable
fs/fuse/inode.c:526:2-18: WARNING: Assignment of 0/1 to bool variable
fs/fuse/inode.c:1000:1-20: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/fuse/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 16aec32..77fef29 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -494,36 +494,36 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)

 	case OPT_FD:
 		ctx->fd = result.uint_32;
-		ctx->fd_present = 1;
+		ctx->fd_present = true;
 		break;

 	case OPT_ROOTMODE:
 		if (!fuse_valid_type(result.uint_32))
 			return invalf(fc, "fuse: Invalid rootmode");
 		ctx->rootmode = result.uint_32;
-		ctx->rootmode_present = 1;
+		ctx->rootmode_present = true;
 		break;

 	case OPT_USER_ID:
 		ctx->user_id = make_kuid(fc->user_ns, result.uint_32);
 		if (!uid_valid(ctx->user_id))
 			return invalf(fc, "fuse: Invalid user_id");
-		ctx->user_id_present = 1;
+		ctx->user_id_present = true;
 		break;

 	case OPT_GROUP_ID:
 		ctx->group_id = make_kgid(fc->user_ns, result.uint_32);
 		if (!gid_valid(ctx->group_id))
 			return invalf(fc, "fuse: Invalid group_id");
-		ctx->group_id_present = 1;
+		ctx->group_id_present = true;
 		break;

 	case OPT_DEFAULT_PERMISSIONS:
-		ctx->default_permissions = 1;
+		ctx->default_permissions = true;
 		break;

 	case OPT_ALLOW_OTHER:
-		ctx->allow_other = 1;
+		ctx->allow_other = true;
 		break;

 	case OPT_MAX_READ:
@@ -997,7 +997,7 @@ void fuse_send_init(struct fuse_conn *fc)
 	/* Variable length argument used for backward compatibility
 	   with interface version < 7.5.  Rest of init_out is zeroed
 	   by do_get_request(), so a short reply is not a problem */
-	ia->args.out_argvar = 1;
+	ia->args.out_argvar = true;
 	ia->args.out_args[0].size = sizeof(ia->out);
 	ia->args.out_args[0].value = &ia->out;
 	ia->args.force = true;
--
2.7.4

