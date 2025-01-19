Return-Path: <linux-fsdevel+bounces-39602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A92BA160F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 10:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392A1164375
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962FC199230;
	Sun, 19 Jan 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L+InOiUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48D7FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737277464; cv=none; b=oJ2Caa8WV22pTepE5cyKaQJ2czbtFlZWP+JzJC3Mw6U1V/LtqBCGhLasgENR2L2iv8C2Yh3wTs1uTNrdUfR+QcTJO7AlvM6zMWtu2HfINx+oH2kS4naSJNj6Y9nVNDhB66V2BjMOLqRSgz56aW2REcKC9SLYF9xR/2dfiJBzYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737277464; c=relaxed/simple;
	bh=DjX+H+9L40NfiW+7BGLRIRrgfsVdWUy1X2cAF3xVmqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQMkQQq84KvtJYxsB3BVFJhaZb3T22ifSrtjaN3TwlEH+Dp7k7yEV/VZN+DcllYQTqJc6BX4XoSSW2nmWTTamlqMbzPDF5uQ6lCTaH4Ht8lpVs30ohFFaGbDAa4q/9PdWSC1ZaRo+bzdKSa4fNm2bfS3kqvricIXTnKCt9RuGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L+InOiUl; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737277462; x=1768813462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCx4hK6M0apc4N2JfOLEbs9gw2Q/ZW6tWdBKvOozDgY=;
  b=L+InOiUl+IjHU3SLzMAnrYwdvXWVhG1jyUU2q8DeXsfisVYN9laAs1fp
   7wIEri+mA6JaYLt+vDKoO0QrykGvqQHupdYx7eoq7A1FMecWoQW4hsx/K
   dgNz4jwyCr/YzJd86L9ws9OGKkYxnZdPn+BX5MCmH9qDxmRqfqfXYppBi
   g=;
X-IronPort-AV: E=Sophos;i="6.13,216,1732579200"; 
   d="scan'208";a="459893283"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 09:04:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:37433]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.33:2525] with esmtp (Farcaster)
 id 126927c2-c6bd-4b02-9828-407f77f2467f; Sun, 19 Jan 2025 09:04:18 +0000 (UTC)
X-Farcaster-Flow-ID: 126927c2-c6bd-4b02-9828-407f77f2467f
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 19 Jan 2025 09:04:18 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.8) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 19 Jan 2025 09:04:14 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v1 vfs 1/2] open: Fix return type of several functions from long to int
Date: Sun, 19 Jan 2025 18:02:48 +0900
Message-ID: <20250119090322.2598-2-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250119090322.2598-1-yuichtsu@amazon.com>
References: <20250119090322.2598-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

Fix the return type of several functions from long to int to match its actu
al behavior. These functions only return int values. This change improves
type consistency across the filesystem code and aligns the function signatu
re with its existing implementation and usage.
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


