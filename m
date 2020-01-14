Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8121013A953
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 13:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgANMcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 07:32:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbgANMcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:32:36 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 52DC9C669EC908FE657F
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 20:32:34 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 20:32:26 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH v2] fuse: use true,false for bool variable
Date:   Tue, 14 Jan 2020 20:39:45 +0800
Message-ID: <1579005585-20249-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

Fixes coccicheck warning:

fs/fuse/readdir.c:335:1-19: WARNING: Assignment of 0/1 to bool variable
fs/fuse/file.c:1398:2-19: WARNING: Assignment of 0/1 to bool variable
fs/fuse/file.c:1400:2-20: WARNING: Assignment of 0/1 to bool variable
fs/fuse/cuse.c:454:1-20: WARNING: Assignment of 0/1 to bool variable
fs/fuse/cuse.c:455:1-19: WARNING: Assignment of 0/1 to bool variable
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
v1->v2: merge patchset to a patch
 fs/fuse/cuse.c    |  4 ++--
 fs/fuse/file.c    |  4 ++--
 fs/fuse/inode.c   | 14 +++++++-------
 fs/fuse/readdir.c |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 00015d8..030f094 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -451,8 +451,8 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->args.out_args[0].size = sizeof(ia->out);
 	ap->args.out_args[0].value = &ia->out;
 	ap->args.out_args[1].size = CUSE_INIT_INFO_MAX;
-	ap->args.out_argvar = 1;
-	ap->args.out_pages = 1;
+	ap->args.out_argvar = true;
+	ap->args.out_pages = true;
 	ap->num_pages = 1;
 	ap->pages = &ia->page;
 	ap->descs = &ia->desc;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a63d779..16205a0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1395,9 +1395,9 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	}

 	if (write)
-		ap->args.in_pages = 1;
+		ap->args.in_pages = true;
 	else
-		ap->args.out_pages = 1;
+		ap->args.out_pages = true;

 	*nbytesp = nbytes;

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
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 6a40f75..90e3f01 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -332,7 +332,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 		return -ENOMEM;

 	plus = fuse_use_readdirplus(inode, ctx);
-	ap->args.out_pages = 1;
+	ap->args.out_pages = true;
 	ap->num_pages = 1;
 	ap->pages = &page;
 	ap->descs = &desc;
--
2.7.4

