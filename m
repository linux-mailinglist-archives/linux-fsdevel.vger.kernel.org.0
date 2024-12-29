Return-Path: <linux-fsdevel+bounces-38227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228859FDDF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8482D3A1707
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338413AD22;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Zn6+WRUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CA381AA
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459949; cv=none; b=COQrI8JHdGgFQf1Ef0C72gS6tJ09QZBN/pTxZRpQd/MiUNKh3W4Ql064ZsT8HiD+CUmD8ut3UH1tG0fyuHbqAdG7pFJbKcI7qn/z16v7buqgvpyvWk/ZHBbZdlDMlHL4w/4DF4YcKs4Zd9E+WCXwJcy4wxqdKRp2ZGqnO32dAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459949; c=relaxed/simple;
	bh=eM446Sekp3XKzW2rwkZu5r1szDzcSuPR4cYf00QRNG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqyDy/+v6uOxaq62WYKN+88rvxA4KK0hDnvoQUwQZWo/fMZhMU0dJv//QVNS0QeJoDlpITiniILV8ok75v71UN8gwNi6qPExx2nlVzLYq28+Kbeia4OR13H0i+8lohA1DDPwsVj4tQ1JvhLHKBQlbDQPkQGVNnXcTtC/Rec1SPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Zn6+WRUn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gIhjTYAW9h/E6hIv4wYkL7oy1/tnTyks3iGkEHQnDuQ=; b=Zn6+WRUnu41d+A2f8EET+6PU5w
	ty5zSXBG0T2gCgQ59gN0I5gParG7mlj0+Mp8QDLj5MgZLJ8eELK+m2pfIkAROCFfyCPw3iV1NRQgB
	Vfemci9extz9wGic9wkdXFIlNilbnPfNuMdzrXQ9UpEMxhQv7CEnzhghnAaRfzXPNsDdWzMjzXtj5
	M6bUbbXNw4naJRsiUQvN++xSyQRyrNdkyNiItutOaH5BU+l5DKmUYNtVEe4NWNbDknSodHJp0AZa/
	jwvI8RvsbyjHZavnp+6+cvarvoXsQDYsviV3KMfTTcO5Ebu+pAGA5j5+CI7aBIASKweHikEa6URuu
	vKDNlfCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPQ-0000000DOiC-0D2h;
	Sun, 29 Dec 2024 08:12:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 06/20] debugfs: allow to store an additional opaque pointer at file creation
Date: Sun, 29 Dec 2024 08:12:09 +0000
Message-ID: <20241229081223.3193228-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
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
index cb65ebc1a992..dec23ede8d6c 100644
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
index 590d77757c92..c62e6b26412a 100644
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
 				&debugfs_short_proxy_file_operations,
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
index a168951a751a..01e18c42eb83 100644
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


