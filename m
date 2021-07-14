Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66E3C8588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 15:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhGNNu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 09:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhGNNu4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:50:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E588613BF;
        Wed, 14 Jul 2021 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270485;
        bh=jV1Y9ahf/52JK4DMrb5fY352MNgzXbaxD0XC9h3PnQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cxgo6ogW6ZV9vsui6JPTNn6KZ/7exHMGE7vtnL9dQQoaQKusOW5doI9AcF4jBdtDh
         ack5BExdvkFU4jRr6TzT9atpCGSsW/btEu9RBLSP47dbjw03k+50zMoisTXUeWFMNC
         uj8OET2eZWQePgDJflBWWcEI3KyQ1JH+yLi9uvn0MdUc+bFIA7bpNC55x99hMiFYyI
         ZlbnrMb+8ZlPh8ybMhqQerzw6ZMShqiJcV2Xsn/4vaJ9CNuxECmqODi2Z0Mft6bgi7
         jDclAZAepVHXaGP9wrL9+6/fdbbrpQf19ekzZChrqomBgRAxnENAaSGrHOE+9nRpDo
         d0LiqYXd9cbzA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/2] fs: add vfs_parse_fs_param_source() helper
Date:   Wed, 14 Jul 2021 15:47:50 +0200
Message-Id: <20210714134750.1223146-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714134750.1223146-1-brauner@kernel.org>
References: <https://lore.kernel.org/lkml/20210714091446.vt4ieretnkjzi7qg@wittgenstein>
 <20210714134750.1223146-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5044; h=from:subject; bh=8c8204NioZlafLmPKwEmLocaMBtEqXVMoufavG6HxXE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8e83YopLwVu/DBddfNSa3TsZqtFS0Xy99uWi7xuMzi33/ JvzW7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI0gSGX0wdZvYXTla5rrthfMw/51 f5HFU+65XJJofnHO/NPfBdUYOR4UXBNOZ8jY3HNR7/msd5Qqv2gP2un4f2vfX88EjtaoLoTjYA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Add a simple helper that filesystems can use in their parameter parser
to parse the "source" parameter. A few places open-coded this function
and that already caused a bug in the cgroup v1 parser that we fixed.
Let's make it harder to get this wrong by introducing a helper which
performs all necessary checks.

Link: https://syzkaller.appspot.com/bug?id=6312526aba5beae046fdae8f00399f87aab48b12
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/fs_context.c            | 54 +++++++++++++++++++++++++-------------
 include/linux/fs_context.h |  2 ++
 kernel/cgroup/cgroup-v1.c  | 14 ++++------
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 2834d1afa6e8..de1985eae535 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -79,6 +79,35 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 	return -ENOPARAM;
 }
 
+/**
+ * vfs_parse_fs_param_source - Handle setting "source" via parameter
+ * @fc: The filesystem context to modify
+ * @param: The parameter
+ *
+ * This is a simple helper for filesystems to verify that the "source" they
+ * accept is sane.
+ *
+ * Returns 0 on success, -ENOPARAM if this is not  "source" parameter, and
+ * -EINVAL otherwise. In the event of failure, supplementary error information
+ *  is logged.
+ */
+int vfs_parse_fs_param_source(struct fs_context *fc, struct fs_parameter *param)
+{
+	if (strcmp(param->key, "source") != 0)
+		return -ENOPARAM;
+
+	if (param->type != fs_value_is_string)
+		return invalf(fc, "Non-string source");
+
+	if (fc->source)
+		return invalf(fc, "Multiple sources");
+
+	fc->source = param->string;
+	param->string = NULL;
+	return 0;
+}
+EXPORT_SYMBOL(vfs_parse_fs_param_source);
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
@@ -122,15 +151,9 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 	/* If the filesystem doesn't take any arguments, give it the
 	 * default handling of source.
 	 */
-	if (strcmp(param->key, "source") == 0) {
-		if (param->type != fs_value_is_string)
-			return invalf(fc, "VFS: Non-string source");
-		if (fc->source)
-			return invalf(fc, "VFS: Multiple sources");
-		fc->source = param->string;
-		param->string = NULL;
-		return 0;
-	}
+	ret = vfs_parse_fs_param_source(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	return invalf(fc, "%s: Unknown parameter '%s'",
 		      fc->fs_type->name, param->key);
@@ -504,16 +527,11 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct legacy_fs_context *ctx = fc->fs_private;
 	unsigned int size = ctx->data_size;
 	size_t len = 0;
+	int ret;
 
-	if (strcmp(param->key, "source") == 0) {
-		if (param->type != fs_value_is_string)
-			return invalf(fc, "VFS: Legacy: Non-string source");
-		if (fc->source)
-			return invalf(fc, "VFS: Legacy: Multiple sources");
-		fc->source = param->string;
-		param->string = NULL;
-		return 0;
-	}
+	ret = vfs_parse_fs_param_source(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
 	if (ctx->param_type == LEGACY_FS_MONOLITHIC_PARAMS)
 		return invalf(fc, "VFS: Legacy: Can't mix monolithic and individual options");
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 37e1e8f7f08d..e2bc16300c82 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -139,6 +139,8 @@ extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
+extern int vfs_parse_fs_param_source(struct fs_context *fc,
+				     struct fs_parameter *param);
 
 /*
  * sget() wrappers to be called from the ->get_tree() op.
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 527917c0b30b..8d6bf56ed77a 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -911,15 +911,11 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	opt = fs_parse(fc, cgroup1_fs_parameters, param, &result);
 	if (opt == -ENOPARAM) {
-		if (strcmp(param->key, "source") == 0) {
-			if (param->type != fs_value_is_string)
-				return invalf(fc, "Non-string source");
-			if (fc->source)
-				return invalf(fc, "Multiple sources not supported");
-			fc->source = param->string;
-			param->string = NULL;
-			return 0;
-		}
+		int ret;
+
+		ret = vfs_parse_fs_param_source(fc, param);
+		if (ret != -ENOPARAM)
+			return ret;
 		for_each_subsys(ss, i) {
 			if (strcmp(param->key, ss->legacy_name))
 				continue;
-- 
2.30.2

