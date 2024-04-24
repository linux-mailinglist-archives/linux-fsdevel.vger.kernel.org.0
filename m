Return-Path: <linux-fsdevel+bounces-17682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5DD8B1748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C79828283E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1EB16F0E4;
	Wed, 24 Apr 2024 23:39:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB102901
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001955; cv=none; b=Zebq0hG3mvAW/8gKpTqVqybTj1E6qenyZCBgTORiapANBCYaNl4s1JT0djmOz7LFCOc5XrDTg8f5TwkQQ0XhN7U9u1E/IeoOGSyNhkqm14RLAa5wH6HFT0/E4kQHc7Yab61w5WcOx7OQkEPZhlKns7HCo2h0hIAvjIyoMRlBS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001955; c=relaxed/simple;
	bh=FZZzVKO8Bg0bp98Bo7rC6cfFb+v4vpYs4mrMF1b6Nbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oB23KwRjzaPhWFMG14bMrXzjegRTtLIbS2KUkEvIfZz4zrx8eYNv5ocrrcRlHlKmNwGyU0eYc0hzryEnSzBGQWFKznrJ9CrfcN2CG3ChC3cN7N0/bnNBXl/BFZyLXg2oxCwAUokbwxkUCI96pPpxWH3tSAU1d9ZAnLNsO72VBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski; spf=none smtp.mailfrom=osuchow.ski; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osuchow.ski
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4VPwRr3ZfWz9xSb;
	Thu, 25 Apr 2024 01:39:04 +0200 (CEST)
From: Dawid Osuchowski <linux@osuchow.ski>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	Dawid Osuchowski <linux@osuchow.ski>
Subject: [PATCH] fs: Create anon_inode_getfile_fmode()
Date: Thu, 25 Apr 2024 01:38:59 +0200
Message-ID: <20240424233859.7640-1-linux@osuchow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creates an anon_inode_getfile_fmode() function that works similarly to
anon_inode_getfile() with the addition of being able to set the fmode
member.

Signed-off-by: Dawid Osuchowski <linux@osuchow.ski>
---
 fs/anon_inodes.c            | 48 +++++++++++++++++++++++++++++++++++++
 include/linux/anon_inodes.h |  3 +++
 2 files changed, 51 insertions(+)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 0496cb5b6eab..6d61d7d1669a 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -148,6 +148,53 @@ struct file *anon_inode_getfile(const char *name,
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfile);
 
+
+static struct file *__anon_inode_getfile_fmode(const char *name,
+			const struct file_operations *fops,
+			void *priv, int flags, fmode_t f_mode)
+{
+
+	struct file *file;
+
+	file = __anon_inode_getfile(name, fops, priv, flags, NULL, false);
+	if (IS_ERR(file))
+		goto err;
+
+	file->f_mode |= f_mode;
+
+	return file;
+
+err:
+	return file;
+}
+
+/**
+ * anon_inode_getfile_fmode - creates a new file instance by hooking it up to an
+ *                      anonymous inode, and a dentry that describe the "class"
+ *                      of the file
+ *
+ * @name:    [in]    name of the "class" of the new file
+ * @fops:    [in]    file operations for the new file
+ * @priv:    [in]    private data for the new file (will be file's private_data)
+ * @flags:   [in]    flags
+ * @f_mode:  [in]    fmode
+ *
+ * Creates a new file by hooking it on a single inode. This is useful for files
+ * that do not need to have a full-fledged inode in order to operate correctly.
+ * All the files created with anon_inode_getfile() will share a single inode,
+ * hence saving memory and avoiding code duplication for the file/inode/dentry
+ * setup. Allows setting the fmode. Returns the newly created file* or an error
+ * pointer.
+ */
+struct file *anon_inode_getfile_fmode(const char *name,
+				const struct file_operations *fops,
+				void *priv, int flags, fmode_t f_mode)
+{
+	return __anon_inode_getfile_fmode(name, fops, priv,
+					flags, f_mode);
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfile_fmode);
+
 /**
  * anon_inode_create_getfile - Like anon_inode_getfile(), but creates a new
  *                             !S_PRIVATE anon inode rather than reuse the
@@ -271,6 +318,7 @@ int anon_inode_create_getfd(const char *name, const struct file_operations *fops
 	return __anon_inode_getfd(name, fops, priv, flags, context_inode, true);
 }
 
+
 static int __init anon_inode_init(void)
 {
 	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index 93a5f16d03f3..ee55f9c11a16 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -15,6 +15,9 @@ struct inode;
 struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags);
+struct file *anon_inode_getfile_fmode(const char *name,
+				const struct file_operations *fops,
+				void *priv, int flags, unsigned int f_mode);
 struct file *anon_inode_create_getfile(const char *name,
 				       const struct file_operations *fops,
 				       void *priv, int flags,
-- 
2.44.0


