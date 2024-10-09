Return-Path: <linux-fsdevel+bounces-31411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDE995E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 05:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3BB286A69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 03:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F931531E8;
	Wed,  9 Oct 2024 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HYtxHtfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE713D8A0;
	Wed,  9 Oct 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444730; cv=none; b=TieZ53D+QYrqu6jPmYRZsTtC8l6QWYF1sD82xUeDVesr5QmasTOkd/zQwedg5HdKoGoajLq5uwlLss1pq7yCYjnCjj+dh1EXzrx6Pjfri6CHkovUMmmkhgFwBa6iAA3kFLcUNV3wMg1mtvRWdPk22syy0Wqm74NwL4d4kkvkDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444730; c=relaxed/simple;
	bh=sCny+DWly5RJeyZY1Z3J5f7VbVnjrMGYmuGDWl04clc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4q60hkSdRvD+vpbKCgsb2BRz8vAgjq2PiS7iuQeB+BA21kUDF5T/MRJK2wnHxnEO0FOkrAm+Wq2ka1ymsZ/E4PQyNn5qifvikYcxrHH60CaArd2TzY3VOBZE85A+Aj59ypfDyyEmq49CDlN/99JFcqBuScXGm6LZbVEcSt7G5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HYtxHtfk; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728444719; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q3VvV8dzU7fDz1bTrlR+T03pQEuaXvrJZsIVuE0YJXE=;
	b=HYtxHtfkDOAIksdAA2twf4tE7yjBqD01IdNJduzSXaTXPL6uVl62h/TbKh/5Kqg4hr97lLTw6e0PjhVVWZnCXn7yKCFxEBTwAToKfiGNwTPA5LMY5cfyLr8bVzs/nH8lkxlXveDgMI7MO1fNNxV5OtBQxe1dcvYGkRdnH3cDm+s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGhJfrz_1728444712)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 11:31:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Date: Wed,  9 Oct 2024 11:31:50 +0800
Message-ID: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Allison reported [1], currently get_tree_bdev() will store
"Can't lookup blockdev" error message.  Although it makes sense for
pure bdev-based fses, this message may mislead users who try to use
EROFS file-backed mounts since get_tree_nodev() is used as a fallback
then.

Add get_tree_bdev_flags() to specify extensible flags [2] and
GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
since it's misleading to EROFS file-backed mounts now.

[1] https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
[2] https://lore.kernel.org/r/ZwUkJEtwIpUA4qMz@infradead.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20241008095606.990466-1-hsiangkao@linux.alibaba.com
change since v1:
 - add get_tree_bdev_flags() suggested by Christoph.

 fs/super.c                 | 26 ++++++++++++++++++++------
 include/linux/fs_context.h |  6 ++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1db230432960..c9c7223bc2a2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1596,13 +1596,14 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 EXPORT_SYMBOL_GPL(setup_bdev_super);
 
 /**
- * get_tree_bdev - Get a superblock based on a single block device
+ * get_tree_bdev_flags - Get a superblock based on a single block device
  * @fc: The filesystem context holding the parameters
  * @fill_super: Helper to initialise a new superblock
+ * @flags: GET_TREE_BDEV_* flags
  */
-int get_tree_bdev(struct fs_context *fc,
-		int (*fill_super)(struct super_block *,
-				  struct fs_context *))
+int get_tree_bdev_flags(struct fs_context *fc,
+		int (*fill_super)(struct super_block *sb,
+				  struct fs_context *fc), unsigned int flags)
 {
 	struct super_block *s;
 	int error = 0;
@@ -1613,10 +1614,10 @@ int get_tree_bdev(struct fs_context *fc,
 
 	error = lookup_bdev(fc->source, &dev);
 	if (error) {
-		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		if (!(flags & GET_TREE_BDEV_QUIET_LOOKUP))
+			errorf(fc, "%s: Can't lookup blockdev", fc->source);
 		return error;
 	}
-
 	fc->sb_flags |= SB_NOSEC;
 	s = sget_dev(fc, dev);
 	if (IS_ERR(s))
@@ -1644,6 +1645,19 @@ int get_tree_bdev(struct fs_context *fc,
 	fc->root = dget(s->s_root);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(get_tree_bdev_flags);
+
+/**
+ * get_tree_bdev - Get a superblock based on a single block device
+ * @fc: The filesystem context holding the parameters
+ * @fill_super: Helper to initialise a new superblock
+ */
+int get_tree_bdev(struct fs_context *fc,
+		int (*fill_super)(struct super_block *,
+				  struct fs_context *))
+{
+	return get_tree_bdev_flags(fc, fill_super, 0);
+}
 EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..4b4bfef6f053 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -160,6 +160,12 @@ extern int get_tree_keyed(struct fs_context *fc,
 
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc);
+
+#define GET_TREE_BDEV_QUIET_LOOKUP		0x0001
+int get_tree_bdev_flags(struct fs_context *fc,
+		int (*fill_super)(struct super_block *sb,
+				  struct fs_context *fc), unsigned int flags);
+
 extern int get_tree_bdev(struct fs_context *fc,
 			       int (*fill_super)(struct super_block *sb,
 						 struct fs_context *fc));
-- 
2.43.5


