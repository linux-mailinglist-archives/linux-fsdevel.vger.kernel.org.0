Return-Path: <linux-fsdevel+bounces-39754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05816A176BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 05:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6F41882C42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 04:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE0E192D87;
	Tue, 21 Jan 2025 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WqhrZQkB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230522CAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737435527; cv=none; b=lB6ZaGZT5lnlX9L6aUXlS6RZKKoWUpBZjQxOLRm5r9tu6O9bOdasLU/JmMA6WUOd+OPodf2g+ksz148VOrQVQt7C2CQJm3W6BKR99r1wecFeFg5KAByUf4F4+Qlf3PLjxH69gGpuBmcKw8iwqPz4qdKOXujz11RZzSMt7UJguWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737435527; c=relaxed/simple;
	bh=q87/73lEESkgYi19Wlr6trO5e5Lj4IDCaVJBDeh/Az4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YElBSv173ARC1B3Qj3KUShTnnPyNfvYw5WUN287yTPg2haFtOrTRZ/QHrvEKT+GKZtqQZ9kDytHYltfh1BdmAmFp6qDawQSwpRdJuwO2QfsaemQqf/GrfrR68UHmwLw+HP1gVRItVKAmj+HKtb8WysKJFkuKI98861W1feL4+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WqhrZQkB; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737435526; x=1768971526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ptszh8mqHS2pRFmPz3FDHTJ42N+YnEOobK9g5N2PNU=;
  b=WqhrZQkBkfA0lwhvnhpSlQUqLXKNyPJeL1oPg7Vz5uJRO0s/LqtsC9d/
   0LRpE3ipnHQrpBlFrmayctcMKfvCl0kY7JnSfUEr5hJR9EQTixYQqU4B0
   OL47BlxH+mqApBPFpN8RKuiXsSd8OJ+XTaHJsceaIY0KWqbcFNhEV2uJf
   8=;
X-IronPort-AV: E=Sophos;i="6.13,221,1732579200"; 
   d="scan'208";a="402243667"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 04:58:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:44876]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.127:2525] with esmtp (Farcaster)
 id 4d686b76-c6b1-4447-902b-9b4b6e831ee9; Tue, 21 Jan 2025 04:58:39 +0000 (UTC)
X-Farcaster-Flow-ID: 4d686b76-c6b1-4447-902b-9b4b6e831ee9
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 04:58:39 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.143.93.208) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 04:58:36 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v2 vfs 1/2] open: Fix return type of several functions from long to int
Date: Tue, 21 Jan 2025 13:57:07 +0900
Message-ID: <20250121045730.3747-2-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121045730.3747-1-yuichtsu@amazon.com>
References: <20250121045730.3747-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

Fix the return type of several functions from long to int to match its actu
al behavior. These functions only return int values. This change improves
type consistency across the filesystem code and aligns the function signatu
re with its existing implementation and usage.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yuichiro Tsuji <yuichtsu@amazon.com>
---
 fs/internal.h            |  4 ++--
 fs/open.c                | 18 +++++++++---------
 include/linux/fs.h       |  4 ++--
 include/linux/syscalls.h |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..84607e7b05dc 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -187,8 +187,8 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
 
-long do_ftruncate(struct file *file, loff_t length, int small);
-long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
+int do_ftruncate(struct file *file, loff_t length, int small);
+int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
diff --git a/fs/open.c b/fs/open.c
index e6911101fe71..f8d79a5912d7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -67,11 +67,11 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 	return ret;
 }
 
-long vfs_truncate(const struct path *path, loff_t length)
+int vfs_truncate(const struct path *path, loff_t length)
 {
 	struct mnt_idmap *idmap;
 	struct inode *inode;
-	long error;
+	int error;
 
 	inode = path->dentry->d_inode;
 
@@ -119,7 +119,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
 
-long do_sys_truncate(const char __user *pathname, loff_t length)
+int do_sys_truncate(const char __user *pathname, loff_t length)
 {
 	unsigned int lookup_flags = LOOKUP_FOLLOW;
 	struct path path;
@@ -153,7 +153,7 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 }
 #endif
 
-long do_ftruncate(struct file *file, loff_t length, int small)
+int do_ftruncate(struct file *file, loff_t length, int small)
 {
 	struct inode *inode;
 	struct dentry *dentry;
@@ -185,7 +185,7 @@ long do_ftruncate(struct file *file, loff_t length, int small)
 	return error;
 }
 
-long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
 	if (length < 0)
 		return -EINVAL;
@@ -240,7 +240,7 @@ COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd,
 int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	long ret;
+	int ret;
 	loff_t sum;
 
 	if (offset < 0 || len <= 0)
@@ -456,7 +456,7 @@ static const struct cred *access_override_creds(void)
 	return old_cred;
 }
 
-static long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
+static int do_faccessat(int dfd, const char __user *filename, int mode, int flags)
 {
 	struct path path;
 	struct inode *inode;
@@ -1383,7 +1383,7 @@ struct file *file_open_root(const struct path *root,
 }
 EXPORT_SYMBOL(file_open_root);
 
-static long do_sys_openat2(int dfd, const char __user *filename,
+static int do_sys_openat2(int dfd, const char __user *filename,
 			   struct open_how *how)
 {
 	struct open_flags op;
@@ -1411,7 +1411,7 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 	return fd;
 }
 
-long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
+int do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 {
 	struct open_how how = build_open_how(flags, mode);
 	return do_sys_openat2(dfd, filename, &how);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e06ea7e9ca15..999ae4790a5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2747,12 +2747,12 @@ static inline bool is_idmapped_mnt(const struct vfsmount *mnt)
 	return mnt_idmap(mnt) != &nop_mnt_idmap;
 }
 
-extern long vfs_truncate(const struct path *, loff_t);
+int vfs_truncate(const struct path *, loff_t);
 int do_truncate(struct mnt_idmap *, struct dentry *, loff_t start,
 		unsigned int time_attrs, struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
 			loff_t len);
-extern long do_sys_open(int dfd, const char __user *filename, int flags,
+int do_sys_open(int dfd, const char __user *filename, int flags,
 			umode_t mode);
 extern struct file *file_open_name(struct filename *, int, umode_t);
 extern struct file *filp_open(const char *, int, umode_t);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6333204d451..bae4490c1dda 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1266,14 +1266,14 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
 			     AT_SYMLINK_NOFOLLOW);
 }
 
-extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
+int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 
 static inline long ksys_ftruncate(unsigned int fd, loff_t length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
 
-extern long do_sys_truncate(const char __user *pathname, loff_t length);
+int do_sys_truncate(const char __user *pathname, loff_t length);
 
 static inline long ksys_truncate(const char __user *pathname, loff_t length)
 {
-- 
2.43.5


