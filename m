Return-Path: <linux-fsdevel+bounces-31305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C39944E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4883A1F234E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93619306C;
	Tue,  8 Oct 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fxhacmP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3F17E006;
	Tue,  8 Oct 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381380; cv=none; b=KEXx2SGW5IXFbFJHlDzLvoTbPjTrotxOxj+bycseHSRODtIfMKWen4W19lywHZqmb/by9EqbORijTYyW4tyK47p+a46C3kOzJ4aIcTpF4xBQD9xw3NkzgKac3XAnjMFO0mEWIf4KBywWAGR5l4pZyeNsR4N64IZyiz66rnYiaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381380; c=relaxed/simple;
	bh=lUwKMcQVYzur2G+7p/nJve3ooy1uAGRwIPQGdd96sLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQoqCKyi8Uvv4fzgR5VkWvXk8Bvg9UPMEcTbo5B36Y24JPNArsFZgKtnBynNqtaKjO1kfvZPAQt/wd1WfG2WPfavCmraIAzjB6SjJAx5p1cStDjrNFqvdiBZ9Dle9Y81T9WqTvkrrUpBMw/olvzqq5MK0oHrbuLfNZ8luwgGVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fxhacmP0; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728381375; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R40RoxvI5Y2ML/F8sE+GUL5WsI1GRLpUALW+tN6AodQ=;
	b=fxhacmP0XCsR3VU2xJxNlOJPOtusKKbeSdFCAw/bKo0YxryfVmyeX06IYvmxjsGp0usOwO8Vky1/91kpS5mHov20rAtBtO+0x1nLgVTMAbUWn24oFD6MoxUTIPxh5RA5VjhKLkJ+e4jeiGzKDlBiM6ULAQEKDBXZcoLIwTeXEVg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGdZ8q3_1728381368)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 17:56:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Date: Tue,  8 Oct 2024 17:56:05 +0800
Message-ID: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
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

Add get_tree_bdev_by_dev() to specify a device number explicitly
instead of the hardcoded fc->source as mentioned in [2], there are
other benefits like:
  - Filesystems can have other ways to get a bdev-based sb
    in addition to the current hard-coded source path;

  - Pseudo-filesystems can utilize this method to generate a
    filesystem from given device numbers too.

  - Like get_tree_nodev(), it doesn't strictly tie to fc->source
    either.

[1] https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
[2] https://lore.kernel.org/r/b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/super.c                 | 41 ++++++++++++++++++++++++++------------
 include/linux/fs_context.h |  3 +++
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1db230432960..8cc8350b9ba6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1596,26 +1596,17 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 EXPORT_SYMBOL_GPL(setup_bdev_super);
 
 /**
- * get_tree_bdev - Get a superblock based on a single block device
+ * get_tree_bdev_by_dev - Get a bdev-based superblock with a given device number
  * @fc: The filesystem context holding the parameters
  * @fill_super: Helper to initialise a new superblock
+ * @dev: The device number indicating the target block device
  */
-int get_tree_bdev(struct fs_context *fc,
+int get_tree_bdev_by_dev(struct fs_context *fc,
 		int (*fill_super)(struct super_block *,
-				  struct fs_context *))
+				  struct fs_context *), dev_t dev)
 {
 	struct super_block *s;
 	int error = 0;
-	dev_t dev;
-
-	if (!fc->source)
-		return invalf(fc, "No source specified");
-
-	error = lookup_bdev(fc->source, &dev);
-	if (error) {
-		errorf(fc, "%s: Can't lookup blockdev", fc->source);
-		return error;
-	}
 
 	fc->sb_flags |= SB_NOSEC;
 	s = sget_dev(fc, dev);
@@ -1644,6 +1635,30 @@ int get_tree_bdev(struct fs_context *fc,
 	fc->root = dget(s->s_root);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(get_tree_bdev_by_dev);
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
+	int error;
+	dev_t dev;
+
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+
+	error = lookup_bdev(fc->source, &dev);
+	if (error) {
+		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		return error;
+	}
+	return get_tree_bdev_by_dev(fc, fill_super, dev);
+}
 EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..54f23589ad5b 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -160,6 +160,9 @@ extern int get_tree_keyed(struct fs_context *fc,
 
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc);
+int get_tree_bdev_by_dev(struct fs_context *fc,
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc), dev_t dev);
 extern int get_tree_bdev(struct fs_context *fc,
 			       int (*fill_super)(struct super_block *sb,
 						 struct fs_context *fc));
-- 
2.43.5


