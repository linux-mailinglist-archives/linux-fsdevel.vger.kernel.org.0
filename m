Return-Path: <linux-fsdevel+bounces-17867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62EE8B31D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE251F21B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DF513C8ED;
	Fri, 26 Apr 2024 07:59:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449813B7AC
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118375; cv=none; b=UhDP9M8PB/6lG1Iazh9T/gvSwYseM98qIVwyUURvUEMdAZaNpS2INFdz98YWN2YIrSzKaxOu1OyrJq65e5/hNqYFB4DR0yCAKHVaS4HWuV4ZKOuC/XdCkgRB6Lz1Uz9y8/7JduxarEGL1INzR5C0u9oacDRp0urVi8zTmLXGTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118375; c=relaxed/simple;
	bh=lBjhkc1ra6ZR5/NcX4XL4UY9h6ce0GOiAlsOPWRkPvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aabzq2EOxojyVLdp4pCJdUzWL3Wv77rb1YFgKMIuTF0DRo1V8Y2BvIIOD7QheTiJZXy8pwXmyRTmmru7361IM4ZZi0mFb/fdjlYXGIJt8DDnjGm2vq9YqvLOPVb/jmI6kkdvOwLiSf3YWWIi2ns7pBK1lQ9zslpuSe6fdiMz6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski; spf=none smtp.mailfrom=osuchow.ski; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osuchow.ski
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4VQlVh30Dvz9spT;
	Fri, 26 Apr 2024 09:59:24 +0200 (CEST)
From: Dawid Osuchowski <linux@osuchow.ski>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	Dawid Osuchowski <linux@osuchow.ski>
Subject: [PATCH v3] fs: Create anon_inode_getfile_fmode()
Date: Fri, 26 Apr 2024 09:58:54 +0200
Message-ID: <20240426075854.4723-1-linux@osuchow.ski>
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
Changes since v1:
* removed __anon_inode_create_getfile_fmode()
* streamlined if statement and got rid of goto
Changes since v2:
* changed unsigned int for f_mode into fmode_t in anon_inodes.h
* added <linux/types.h> header to anon_inodes.h
---
 fs/anon_inodes.c            | 33 +++++++++++++++++++++++++++++++++
 include/linux/anon_inodes.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 0496cb5b6eab..42bd1cb7c9cd 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -148,6 +148,38 @@ struct file *anon_inode_getfile(const char *name,
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfile);
 
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
+	struct file *file;
+
+	file = __anon_inode_getfile(name, fops, priv, flags, NULL, false);
+	if (!IS_ERR(file))
+		file->f_mode |= f_mode;
+
+	return file;
+}
+EXPORT_SYMBOL_GPL(anon_inode_getfile_fmode);
+
 /**
  * anon_inode_create_getfile - Like anon_inode_getfile(), but creates a new
  *                             !S_PRIVATE anon inode rather than reuse the
@@ -271,6 +303,7 @@ int anon_inode_create_getfd(const char *name, const struct file_operations *fops
 	return __anon_inode_getfd(name, fops, priv, flags, context_inode, true);
 }
 
+
 static int __init anon_inode_init(void)
 {
 	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index 93a5f16d03f3..edef565c2a1a 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -9,12 +9,17 @@
 #ifndef _LINUX_ANON_INODES_H
 #define _LINUX_ANON_INODES_H
 
+#include <linux/types.h>
+
 struct file_operations;
 struct inode;
 
 struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags);
+struct file *anon_inode_getfile_fmode(const char *name,
+				const struct file_operations *fops,
+				void *priv, int flags, fmode_t f_mode);
 struct file *anon_inode_create_getfile(const char *name,
 				       const struct file_operations *fops,
 				       void *priv, int flags,
-- 
2.44.0


