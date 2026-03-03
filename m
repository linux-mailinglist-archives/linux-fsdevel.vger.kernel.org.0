Return-Path: <linux-fsdevel+bounces-79228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOgGKx/opmlWZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:54:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEE41F0CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D1D3306BCF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFA4366569;
	Tue,  3 Mar 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XctvIxld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C135C19B;
	Tue,  3 Mar 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545781; cv=none; b=fz/MrpSvxCJQ2Ut81rUqp7DFdliC7smEmtSTZD8Myxf0fw9d2V0FhA/HdPb7SOn9FymB2tAkjQiugrpqvj5JauWAvgKU6GpWjxTMoJ/TH58xrz2mbZxBLxJZ/m330cYynWr4Ze+U4kDxoiHCSNfIy1b5Ruu0TBqPorSbbJrluU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545781; c=relaxed/simple;
	bh=Ikabcn8EKfLA8KEpW72CmxbJ0nkIh821mCuZpNy2Fkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lU85WjT7Pcc2Kpd0EemXbk/pqgHFfDo3hDypMrlOgh9IOil2HLJJ9420qeMTWbbaoKdyLqNK9lGQXBvFntoH46Dh09Tiwq/HE1mty1rYsxmJ8Elboxt0XdfnawGw6n6GtDQcNTiAmkbMgiN+mxT54RrsuvxozzU+OzicMOGvhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XctvIxld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BDDC116C6;
	Tue,  3 Mar 2026 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545780;
	bh=Ikabcn8EKfLA8KEpW72CmxbJ0nkIh821mCuZpNy2Fkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XctvIxldCVUOSOoPBZXpuAX2bMob7wOqPcujevyse76Jpya/f2x9byYNewl2TU6oF
	 BDyQFTkPDYQUBO1pB9DoA3HPGJf0Pml4ieiou2/qOm6BKYEuqc5a+oAK7J4gkSGkBD
	 JGU54KVKLS/F7skBmn3611vO7hM9n+L6ZvsfYL7uDsW1T2+JW8qKNuJj7LUZVFTsjT
	 a6nC5FppW5ZuGi6HtplqCd2hWqkeeBsgKyM0L9GCN71XcgWrYwvRhh+Rf86wBZ0BL+
	 Y4w6USo2BL+4SDIDjjZ3JujyseeKidji4fwXqxoFfu/qJ3BJdjWVrbxWs0iM5QR++D
	 ZzDG3/Yh34tBQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:19 +0100
Subject: [PATCH RFC DRAFT POC 08/11] fs: allow to pass lookup flags to
 filename_*()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-8-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=12595; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ikabcn8EKfLA8KEpW72CmxbJ0nkIh821mCuZpNy2Fkk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3Zvyx3L5wkRnedZPjmfv/79fPfZh5LT5WdUNUmKn
 H9zgnPbxo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ/N3MyNA+/4LN//2XOnY/
 kjZJFfKem7j70av5tf6LxWsP354zzXABw3+ndG3WC83slnwX8qqmnA25Lnb8z2vVD1H767k0zjw
 TUWYCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 4BEE41F0CEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79228-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Allow lookup flags to be passed to filename_*() so callers can pass
LOOUP_IN_INIT to explicitly opt-into to performing lookups in init's
filesystem state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c |  2 +-
 fs/init.c     | 12 ++++++------
 fs/internal.h | 18 ++++++++++++------
 fs/namei.c    | 52 +++++++++++++++++++++++++++-------------------------
 io_uring/fs.c | 10 +++++-----
 5 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 29df8aa19e2e..550a1553f6cb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -900,7 +900,7 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 		 * If it doesn't exist, that's fine. If there's some
 		 * other problem, we'll catch it at the filp_open().
 		 */
-		filename_unlinkat(AT_FDCWD, name);
+		filename_unlinkat(AT_FDCWD, name, 0);
 	}
 
 	/*
diff --git a/fs/init.c b/fs/init.c
index 33e312d74f58..a79872d5af3b 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -158,39 +158,39 @@ int __init init_stat(const char *filename, struct kstat *stat, int flags)
 int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 {
 	CLASS(filename_kernel, name)(filename);
-	return filename_mknodat(AT_FDCWD, name, mode, dev);
+	return filename_mknodat(AT_FDCWD, name, mode, dev, 0);
 }
 
 int __init init_link(const char *oldname, const char *newname)
 {
 	CLASS(filename_kernel, old)(oldname);
 	CLASS(filename_kernel, new)(newname);
-	return filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0);
+	return filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0, 0);
 }
 
 int __init init_symlink(const char *oldname, const char *newname)
 {
 	CLASS(filename_kernel, old)(oldname);
 	CLASS(filename_kernel, new)(newname);
-	return filename_symlinkat(old, AT_FDCWD, new);
+	return filename_symlinkat(old, AT_FDCWD, new, 0);
 }
 
 int __init init_unlink(const char *pathname)
 {
 	CLASS(filename_kernel, name)(pathname);
-	return filename_unlinkat(AT_FDCWD, name);
+	return filename_unlinkat(AT_FDCWD, name, 0);
 }
 
 int __init init_mkdir(const char *pathname, umode_t mode)
 {
 	CLASS(filename_kernel, name)(pathname);
-	return filename_mkdirat(AT_FDCWD, name, mode);
+	return filename_mkdirat(AT_FDCWD, name, mode, 0);
 }
 
 int __init init_rmdir(const char *pathname)
 {
 	CLASS(filename_kernel, name)(pathname);
-	return filename_rmdir(AT_FDCWD, name);
+	return filename_rmdir(AT_FDCWD, name, 0);
 }
 
 int __init init_utimes(char *filename, struct timespec64 *ts)
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..7302badcae69 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -53,16 +53,22 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, const struct path *root);
-int filename_rmdir(int dfd, struct filename *name);
-int filename_unlinkat(int dfd, struct filename *name);
+int filename_rmdir(int dfd, struct filename *name,
+		   unsigned int lookup_flags);
+int filename_unlinkat(int dfd, struct filename *name,
+		      unsigned int lookup_flags);
 int may_linkat(struct mnt_idmap *idmap, const struct path *link);
 int filename_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
-int filename_mkdirat(int dfd, struct filename *name, umode_t mode);
-int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int dev);
-int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
+int filename_mkdirat(int dfd, struct filename *name, umode_t mode,
+		     unsigned int lookup_flags);
+int filename_mknodat(int dfd, struct filename *name, umode_t mode,
+		     unsigned int dev, unsigned int lookup_flags);
+int filename_symlinkat(struct filename *from, int newdfd, struct filename *to,
+		       unsigned int lookup_flags);
 int filename_linkat(int olddfd, struct filename *old, int newdfd,
-			struct filename *new, int flags);
+		    struct filename *new, int flags,
+		    unsigned int lookup_flags);
 int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
diff --git a/fs/namei.c b/fs/namei.c
index dd2710d5f5df..5cf407aad5b3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5125,14 +5125,13 @@ static int may_mknod(umode_t mode)
 }
 
 int filename_mknodat(int dfd, struct filename *name, umode_t mode,
-		     unsigned int dev)
+		     unsigned int dev, unsigned int lookup_flags)
 {
 	struct delegated_inode di = { };
 	struct mnt_idmap *idmap;
 	struct dentry *dentry;
 	struct path path;
 	int error;
-	unsigned int lookup_flags = 0;
 
 	error = may_mknod(mode);
 	if (error)
@@ -5181,13 +5180,13 @@ SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
 		unsigned int, dev)
 {
 	CLASS(filename, name)(filename);
-	return filename_mknodat(dfd, name, mode, dev);
+	return filename_mknodat(dfd, name, mode, dev, 0);
 }
 
 SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev)
 {
 	CLASS(filename, name)(filename);
-	return filename_mknodat(AT_FDCWD, name, mode, dev);
+	return filename_mknodat(AT_FDCWD, name, mode, dev, 0);
 }
 
 /**
@@ -5258,14 +5257,16 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
+int filename_mkdirat(int dfd, struct filename *name, umode_t mode,
+		     unsigned int lookup_flags)
 {
 	struct dentry *dentry;
 	struct path path;
 	int error;
-	unsigned int lookup_flags = LOOKUP_DIRECTORY;
 	struct delegated_inode delegated_inode = { };
 
+	lookup_flags |= LOOKUP_DIRECTORY;
+
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
 	if (IS_ERR(dentry))
@@ -5295,13 +5296,13 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
 {
 	CLASS(filename, name)(pathname);
-	return filename_mkdirat(dfd, name, mode);
+	return filename_mkdirat(dfd, name, mode, 0);
 }
 
 SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 {
 	CLASS(filename, name)(pathname);
-	return filename_mkdirat(AT_FDCWD, name, mode);
+	return filename_mkdirat(AT_FDCWD, name, mode, 0);
 }
 
 /**
@@ -5364,14 +5365,14 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 EXPORT_SYMBOL(vfs_rmdir);
 
-int filename_rmdir(int dfd, struct filename *name)
+int filename_rmdir(int dfd, struct filename *name,
+		   unsigned int lookup_flags)
 {
 	int error;
 	struct dentry *dentry;
 	struct path path;
 	struct qstr last;
 	int type;
-	unsigned int lookup_flags = 0;
 	struct delegated_inode delegated_inode = { };
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
@@ -5424,7 +5425,7 @@ int filename_rmdir(int dfd, struct filename *name)
 SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 {
 	CLASS(filename, name)(pathname);
-	return filename_rmdir(AT_FDCWD, name);
+	return filename_rmdir(AT_FDCWD, name, 0);
 }
 
 /**
@@ -5506,7 +5507,8 @@ EXPORT_SYMBOL(vfs_unlink);
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
  */
-int filename_unlinkat(int dfd, struct filename *name)
+int filename_unlinkat(int dfd, struct filename *name,
+		      unsigned int lookup_flags)
 {
 	int error;
 	struct dentry *dentry;
@@ -5515,7 +5517,6 @@ int filename_unlinkat(int dfd, struct filename *name)
 	int type;
 	struct inode *inode;
 	struct delegated_inode delegated_inode = { };
-	unsigned int lookup_flags = 0;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -5576,14 +5577,14 @@ SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
 
 	CLASS(filename, name)(pathname);
 	if (flag & AT_REMOVEDIR)
-		return filename_rmdir(dfd, name);
-	return filename_unlinkat(dfd, name);
+		return filename_rmdir(dfd, name, 0);
+	return filename_unlinkat(dfd, name, 0);
 }
 
 SYSCALL_DEFINE1(unlink, const char __user *, pathname)
 {
 	CLASS(filename, name)(pathname);
-	return filename_unlinkat(AT_FDCWD, name);
+	return filename_unlinkat(AT_FDCWD, name, 0);
 }
 
 /**
@@ -5630,12 +5631,12 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 }
 EXPORT_SYMBOL(vfs_symlink);
 
-int filename_symlinkat(struct filename *from, int newdfd, struct filename *to)
+int filename_symlinkat(struct filename *from, int newdfd, struct filename *to,
+		       unsigned int lookup_flags)
 {
 	int error;
 	struct dentry *dentry;
 	struct path path;
-	unsigned int lookup_flags = 0;
 	struct delegated_inode delegated_inode = { };
 
 	if (IS_ERR(from))
@@ -5668,14 +5669,14 @@ SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
 {
 	CLASS(filename, old)(oldname);
 	CLASS(filename, new)(newname);
-	return filename_symlinkat(old, newdfd, new);
+	return filename_symlinkat(old, newdfd, new, 0);
 }
 
 SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newname)
 {
 	CLASS(filename, old)(oldname);
 	CLASS(filename, new)(newname);
-	return filename_symlinkat(old, AT_FDCWD, new);
+	return filename_symlinkat(old, AT_FDCWD, new, 0);
 }
 
 /**
@@ -5779,13 +5780,14 @@ EXPORT_SYMBOL(vfs_link);
  * and other special files.  --ADM
 */
 int filename_linkat(int olddfd, struct filename *old,
-		    int newdfd, struct filename *new, int flags)
+		    int newdfd, struct filename *new, int flags,
+		    unsigned int lookup_flags)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
 	struct delegated_inode delegated_inode = { };
-	int how = 0;
+	int how = lookup_flags;
 	int error;
 
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
@@ -5807,7 +5809,7 @@ int filename_linkat(int olddfd, struct filename *old,
 		return error;
 
 	new_dentry = filename_create(newdfd, new, &new_path,
-					(how & LOOKUP_REVAL));
+					(how & (LOOKUP_REVAL | LOOKUP_IN_INIT)));
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto out_putpath;
@@ -5848,14 +5850,14 @@ SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
 {
 	CLASS(filename_uflags, old)(oldname, flags);
 	CLASS(filename, new)(newname);
-	return filename_linkat(olddfd, old, newdfd, new, flags);
+	return filename_linkat(olddfd, old, newdfd, new, flags, 0);
 }
 
 SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname)
 {
 	CLASS(filename, old)(oldname);
 	CLASS(filename, new)(newname);
-	return filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0);
+	return filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0, 0);
 }
 
 /**
diff --git a/io_uring/fs.c b/io_uring/fs.c
index d0580c754bf8..1d9b2939f5ae 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -140,9 +140,9 @@ int io_unlinkat(struct io_kiocb *req, unsigned int issue_flags)
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
 	if (un->flags & AT_REMOVEDIR)
-		ret = filename_rmdir(un->dfd, name);
+		ret = filename_rmdir(un->dfd, name, 0);
 	else
-		ret = filename_unlinkat(un->dfd, name);
+		ret = filename_unlinkat(un->dfd, name, 0);
 
 	req->flags &= ~REQ_F_NEED_CLEANUP;
 	io_req_set_res(req, ret, 0);
@@ -188,7 +188,7 @@ int io_mkdirat(struct io_kiocb *req, unsigned int issue_flags)
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-	ret = filename_mkdirat(mkd->dfd, name, mkd->mode);
+	ret = filename_mkdirat(mkd->dfd, name, mkd->mode, 0);
 
 	req->flags &= ~REQ_F_NEED_CLEANUP;
 	io_req_set_res(req, ret, 0);
@@ -241,7 +241,7 @@ int io_symlinkat(struct io_kiocb *req, unsigned int issue_flags)
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-	ret = filename_symlinkat(old, sl->new_dfd, new);
+	ret = filename_symlinkat(old, sl->new_dfd, new, 0);
 
 	req->flags &= ~REQ_F_NEED_CLEANUP;
 	io_req_set_res(req, ret, 0);
@@ -289,7 +289,7 @@ int io_linkat(struct io_kiocb *req, unsigned int issue_flags)
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-	ret = filename_linkat(lnk->old_dfd, old, lnk->new_dfd, new, lnk->flags);
+	ret = filename_linkat(lnk->old_dfd, old, lnk->new_dfd, new, lnk->flags, 0);
 
 	req->flags &= ~REQ_F_NEED_CLEANUP;
 	io_req_set_res(req, ret, 0);

-- 
2.47.3


