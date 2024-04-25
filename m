Return-Path: <linux-fsdevel+bounces-17839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CB8B2CB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 00:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74E91C213F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071C16130A;
	Thu, 25 Apr 2024 21:58:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36E15ECF0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082338; cv=none; b=aEvTjDq3TgY/Bj4TOobNg6ymPnCGQFSsjCk44suTAz/JMDh1ARd+rZaBzPdSqt6IbYLW1bFadfmWYx95FlzMFfGA5lBwmQ32w8f7ldmE5D6RM2GKaJ/6fC3v6SgpCA6qTFI7ZAwAPCPd0hom1ix7J1Ap7sEPGiOdL4oWy8VUzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082338; c=relaxed/simple;
	bh=fiX4Ks47gnMeXb4hW0Vuokaij51BPH7dBFctRD13Eeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ajz6spDxwiMoJEGow09Lcz+Ewj4KZhCKIxY8tWhUM5XnbfQsJzhek+6gWrhZTyO4LHYufFFtEcOpZcfw9zJqv7N/N8NU7f1Ad8JSY67H3Xv/xTqEMWbjQEsOf7Cd5oY/+iep0LqvAZE/N37syWOSXcEqC63TlFmfjK94/nxRe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski; spf=none smtp.mailfrom=osuchow.ski; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osuchow.ski
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4VQV9m4wBLz9txn;
	Thu, 25 Apr 2024 23:58:52 +0200 (CEST)
From: Dawid Osuchowski <linux@osuchow.ski>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	Dawid Osuchowski <linux@osuchow.ski>
Subject: [PATCH v2] fs: Create anon_inode_getfile_fmode()
Date: Thu, 25 Apr 2024 23:58:03 +0200
Message-ID: <20240425215803.24267-1-linux@osuchow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VQV9m4wBLz9txn

Creates an anon_inode_getfile_fmode() function that works similarly to
anon_inode_getfile() with the addition of being able to set the fmode
member.

Signed-off-by: Dawid Osuchowski <linux@osuchow.ski>
---
Changes since v1:
* removed __anon_inode_create_getfile_fmode()
* streamlined if statement and got rid of goto
---
 fs/anon_inodes.c            | 33 +++++++++++++++++++++++++++++++++
 include/linux/anon_inodes.h |  3 +++
 2 files changed, 36 insertions(+)

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


