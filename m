Return-Path: <linux-fsdevel+bounces-38973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67601A0A798
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D01D164CD7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F419DF8D;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UznBSWUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DB154C0D
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=sCotpSz27O9ZQjCEsgKZ5N1RzbWwfn1lV0Ljgo10KZPrqyCZr0uHxRRVVP1DZNZyqT8gb3Pn7VnMxlNFYYXvDFtDY6VtFimzLTJVag34xYXvWgUfkrpXnme06w+0DMpNj80NJABn5BQ4IbwC1TnQvYOWBJiEedPvE02EDDajQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=FwUYZM0TVKNv5wqkHVr4AjHL+Hk7kjyNm/YNFt3OwIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q//5k6iG1HF19BXIxgBSk7HufUtg1/4JgwmNmJgyZcWUmI57CRzpdmnshtErsD7nKPPBXjwxXU1ty6RL/8CNKhR0UY2MyFv3VKytbmYQRnz5Ilw98zxB+I1HORbnHSFNp0Lw19fTB3/0nCgUMX9SK1zPaD3XLlCZB5/rjidoTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UznBSWUi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V3T8uCU0uGZ15pBuRl+u+HK8/qr0xRBB3gzdxAy7bVk=; b=UznBSWUiTNJnf4xq9STwrBG2m1
	v1Vhz5dhVzGJ0zqjsUCqrkYgBqRMA2WdbPwKUzSR403PinDytGEQYzw7JjFABvT5AqgphsV4hpFQ7
	TfTb+SBBw4UAdJGTmEm3WUap0ggDdicJ9cyKdydq+3Zr/Rrd0ZdNmvzKG2yRRrovria/bs726wIRD
	Ov1Ge0LrKiT36cdmOaW3SvyeTNkS6mA5U6vt3n0lVKXPi4xgeNO1sovcyBBZrnMTCU6WZ86wQ24b4
	DZ1xNzY68s2Alty4QtdX/xF2aTpyxZeb3dydY30IbnqNtY2oTmfvxjLjFD+uuXh6kMT3LXO3/vBFM
	dwxX1gPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszx-00000000ajE-3iih;
	Sun, 12 Jan 2025 08:07:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 05/21] debugfs: allow to store an additional opaque pointer at file creation
Date: Sun, 12 Jan 2025 08:06:49 +0000
Message-ID: <20250112080705.141166-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Set by debugfs_create_file_aux(name, mode, parent, data, aux, fops).
Plain debugfs_create_file() has it set to NULL.
Accessed by debugfs_get_aux(file).

Convenience macros for numeric opaque data - debugfs_create_file_aux_num
and debugfs_get_aux_num, resp.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/file.c       |  6 ++++++
 fs/debugfs/inode.c      | 14 +++++++++-----
 fs/debugfs/internal.h   |  1 +
 include/linux/debugfs.h | 27 ++++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index ae014bd36a6f..e33cc77699cd 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -47,6 +47,12 @@ const struct file_operations debugfs_noop_file_operations = {
 
 #define F_DENTRY(filp) ((filp)->f_path.dentry)
 
+const void *debugfs_get_aux(const struct file *file)
+{
+	return DEBUGFS_I(file_inode(file))->aux;
+}
+EXPORT_SYMBOL_GPL(debugfs_get_aux);
+
 const struct file_operations *debugfs_real_fops(const struct file *filp)
 {
 	struct debugfs_fsdata *fsd = F_DENTRY(filp)->d_fsdata;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index c4e8b7f758e0..51d4c3e9d422 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -424,6 +424,7 @@ static struct dentry *end_creating(struct dentry *dentry)
 
 static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 				struct dentry *parent, void *data,
+				const void *aux,
 				const struct file_operations *proxy_fops,
 				const void *real_fops)
 {
@@ -458,6 +459,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 		proxy_fops = &debugfs_noop_file_operations;
 	inode->i_fop = proxy_fops;
 	DEBUGFS_I(inode)->raw = real_fops;
+	DEBUGFS_I(inode)->aux = aux;
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
@@ -466,19 +468,21 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
+					const void *aux,
 					const struct file_operations *fops)
 {
-	return __debugfs_create_file(name, mode, parent, data,
+	return __debugfs_create_file(name, mode, parent, data, aux,
 				&debugfs_full_proxy_file_operations,
 				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_full);
 
 struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
-					 struct dentry *parent, void *data,
-					 const struct debugfs_short_fops *fops)
+					struct dentry *parent, void *data,
+					const void *aux,
+					const struct debugfs_short_fops *fops)
 {
-	return __debugfs_create_file(name, mode, parent, data,
+	return __debugfs_create_file(name, mode, parent, data, aux,
 				&debugfs_full_short_proxy_file_operations,
 				fops);
 }
@@ -516,7 +520,7 @@ struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 				   const struct file_operations *fops)
 {
 
-	return __debugfs_create_file(name, mode, parent, data,
+	return __debugfs_create_file(name, mode, parent, data, NULL,
 				&debugfs_open_proxy_file_operations,
 				fops);
 }
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 8d2de647b42c..93483fe84425 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -19,6 +19,7 @@ struct debugfs_inode_info {
 		const struct debugfs_short_fops *short_fops;
 		debugfs_automount_t automount;
 	};
+	const void *aux;
 };
 
 static inline struct debugfs_inode_info *DEBUGFS_I(struct inode *inode)
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 59444b495d49..7c97417d73b5 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -79,9 +79,11 @@ struct debugfs_short_fops {
 
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
+					const void *aux,
 					const struct file_operations *fops);
 struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
 					 struct dentry *parent, void *data,
+					 const void *aux,
 					 const struct debugfs_short_fops *fops);
 
 /**
@@ -126,7 +128,15 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
 		 const struct debugfs_short_fops *: debugfs_create_file_short,	\
 		 struct file_operations *: debugfs_create_file_full,		\
 		 struct debugfs_short_fops *: debugfs_create_file_short)	\
-		(name, mode, parent, data, fops)
+		(name, mode, parent, data, NULL, fops)
+
+#define debugfs_create_file_aux(name, mode, parent, data, aux, fops)		\
+	_Generic(fops,								\
+		 const struct file_operations *: debugfs_create_file_full,	\
+		 const struct debugfs_short_fops *: debugfs_create_file_short,	\
+		 struct file_operations *: debugfs_create_file_full,		\
+		 struct debugfs_short_fops *: debugfs_create_file_short)	\
+		(name, mode, parent, data, aux, fops)
 
 struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
@@ -153,6 +163,7 @@ void debugfs_remove(struct dentry *dentry);
 void debugfs_lookup_and_remove(const char *name, struct dentry *parent);
 
 const struct file_operations *debugfs_real_fops(const struct file *filp);
+const void *debugfs_get_aux(const struct file *file);
 
 int debugfs_file_get(struct dentry *dentry);
 void debugfs_file_put(struct dentry *dentry);
@@ -259,6 +270,14 @@ static inline struct dentry *debugfs_lookup(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct dentry *debugfs_create_file_aux(const char *name,
+					umode_t mode, struct dentry *parent,
+					void *data, void *aux,
+					const void *fops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct dentry *debugfs_create_file(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const void *fops)
@@ -312,6 +331,7 @@ static inline void debugfs_lookup_and_remove(const char *name,
 { }
 
 const struct file_operations *debugfs_real_fops(const struct file *filp);
+void *debugfs_get_aux(const struct file *file);
 
 static inline int debugfs_file_get(struct dentry *dentry)
 {
@@ -452,6 +472,11 @@ static inline ssize_t debugfs_read_file_str(struct file *file,
 
 #endif
 
+#define debugfs_create_file_aux_num(name, mode, parent, data, n, fops) \
+	debugfs_create_file_aux(name, mode, parent, data, \
+				(void *)(unsigned long)n, fops)
+#define debugfs_get_aux_num(f) (unsigned long)debugfs_get_aux(f)
+
 /**
  * debugfs_create_xul - create a debugfs file that is used to read and write an
  * unsigned long value, formatted in hexadecimal
-- 
2.39.5


