Return-Path: <linux-fsdevel+bounces-50344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403DAACB0D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F291E163C1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4891231A37;
	Mon,  2 Jun 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9ffYvv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF92231849;
	Mon,  2 Jun 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872972; cv=none; b=Ll/PDhLjj+b4TwWQfCNCEiJpW4vUrYmAKGKaOe+/RHdYLLca1uA0H+o2Z4A43dtul0rnWifzLJbvHH98DjV8z9XiY82kPUBnPzla/zWaEs9McVAH1UVzugUgLBFoirgYTQSq8hxnHls4ludUxTkgUgv+KGqcZ8JeYAOrMDkoPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872972; c=relaxed/simple;
	bh=mSZ+Tq+Scvh8C9wum7JJA/yZBWRfnRsmhQedhLJ+MMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mW70TKdYASiaj0nlYk+RGGa21d6/insb3g7LL1qU4g5xuz4pVWS1JIIPw15xYsq0NsOjKP9aLzkudv19IprMIdk0aPCgUhQSbE5FwjoUAgi5pB/Bwh5M7mbX02QjdXHH+eICgqcVz7sJ8niJ/Mpq2swzCJf+oD6xQsXTso8lC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9ffYvv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ABAC4CEF2;
	Mon,  2 Jun 2025 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872971;
	bh=mSZ+Tq+Scvh8C9wum7JJA/yZBWRfnRsmhQedhLJ+MMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K9ffYvv3xQe4fdSRA0UFPMZm3dYPB26TXTOYHwDQ5GbGwrrEExeOgjrs8Fu4fEAlC
	 Bu0ltIJkFtJgtZ70uLp3azfK4yHC+P/LGA5h9yv2S+UkEyaxMPMWt2oRDD8R3ithT6
	 Lzi4EMA4CDadXlzn67OY2vxAowL4n9BhzNJN8u/meKBDlOn3FVmdzAIRZqGG2+gVs2
	 ZL3L0x5zUB0QoDM8VV1tGqADiJTvvEq1qeBLyx/kKln3Df8LmOH81M7v+d36cFCVIr
	 tfz01P5uURxRvzZPA3BlfKczhCfCOCBLkbTo5gMJmGB4VfNOd2UwrS7MUJIoxPNn1d
	 PYsYexGrJOIcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:57 -0400
Subject: [PATCH RFC v2 14/28] filelock: rework the __break_lease API to use
 flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-14-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7075; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mSZ+Tq+Scvh8C9wum7JJA/yZBWRfnRsmhQedhLJ+MMs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7ne7oHoBM+qhMZ3CaFsqLNTMCpC2dhUeaad
 JMhCmVDb1mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5wAKCRAADmhBGVaC
 FetPEACOJPiOO1361MaUQCwy4nzClqOvT5QLoeMe/g1JBE5ZcO8uf6Fr9OZnsIEfDWR297Ef8Px
 gu+5BBdWCIOoDvPi9XmiQCBGWdlIXjV1uVr8KGIzHJ6sikPM17ePimWx/eWNtyyY2Laer2piKMW
 FjyoL3wNb+zxV8ZgvoXmiHT7DjlCHXeQQ3T6F4lEwYW8J2B/D2QMjIbz1IxccH/h4CljZ1FGwC+
 pWsAEgdiDrc3lnj+QMIo+hVvZ5f97qCyplbN7U/WtqXvQ+sKUGZ87crY2cnsB+dVMYXS/iBoqyT
 Q7rwbBXhMXb7cTbi/720XvzcTdnBcb24joHv4+ZMcW0xu02oawvo57OHqPgEAb3tXyKeU0qBqtc
 UgSGsv41xZBKPhVIJ4DSgjSlrEYFSWOCRphNvxQBI+utalonG17PRF7BXDo2+OhteXhMrR8aYyn
 rDCnJ8rlZMjbX8chaW2lSM7BLgv76VzUhSIYPMZZpXEMhMAd6F0U8mn3tXIx9vyDsP24JwrbD0r
 tkqVBsmzke0zlX+Nqw6nYeaKmWgGrqiYj/EVthHLfwX4qnKiX4X9Jb6Ngz3/3YsD9ogK0JnUvAz
 5r1k/AyfhyrPqKGHyzBKAbVRgD+HLBqddQ9CwAs9+MG4w8bhgjVz0y389HHRWYNGDzZJjaWR0co
 8KvYn/51pVA04iA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Declare a set of LEASE_BREAK_* flags that can be used to control how
lease breaks work instead of requiring a type and an openmode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 30 +++++++++++++++++-----------
 include/linux/filelock.h | 52 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 82a1b528dc9dae8c1f3a81084072e649d481e8f1..6e46176d1e00962904f03c151500e593f410e4c6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1529,29 +1529,35 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 /**
  *	__break_lease	-	revoke all outstanding leases on file
  *	@inode: the inode of the file to return
- *	@mode: O_RDONLY: break only write leases; O_WRONLY or O_RDWR:
- *	    break all leases
- *	@type: FL_LEASE: break leases and delegations; FL_DELEG: break
- *	    only delegations
+ *	@flags: LEASE_BREAK_* flags
  *
  *	break_lease (inlined for speed) has checked there already is at least
  *	some kind of lock (maybe a lease) on this file.  Leases are broken on
- *	a call to open() or truncate().  This function can sleep unless you
- *	specified %O_NONBLOCK to your open().
+ *	a call to open() or truncate().  This function can block waiting for the
+ *	lease break unless you specify LEASE_BREAK_NONBLOCK.
  */
-int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
+int __break_lease(struct inode *inode, unsigned int flags)
 {
-	int error = 0;
-	struct file_lock_context *ctx;
 	struct file_lease *new_fl, *fl, *tmp;
+	struct file_lock_context *ctx;
 	unsigned long break_time;
-	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
+	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
+	int error = 0;
+
 
 	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
-	new_fl->c.flc_flags = type;
+
+	if (flags & LEASE_BREAK_LEASE)
+		new_fl->c.flc_flags = FL_LEASE;
+	else if (flags & LEASE_BREAK_DELEG)
+		new_fl->c.flc_flags = FL_DELEG;
+	else if (flags & LEASE_BREAK_LAYOUT)
+		new_fl->c.flc_flags = FL_LAYOUT;
+	else
+		return -EINVAL;
 
 	/* typically we will check that ctx is non-NULL before calling */
 	ctx = locks_inode_context(inode);
@@ -1596,7 +1602,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	if (list_empty(&ctx->flc_lease))
 		goto out;
 
-	if (mode & O_NONBLOCK) {
+	if (flags & LEASE_BREAK_NONBLOCK) {
 		trace_break_lease_noblock(inode, new_fl);
 		error = -EWOULDBLOCK;
 		goto out;
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 60c76c8fb4dfdcaaa2cfa3f41f0f26ffcb3db29f..0fe368060781d0b22f735c2cfb8d8c1a6a238290 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -221,7 +221,14 @@ int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
 void locks_init_lease(struct file_lease *);
 void locks_free_lease(struct file_lease *fl);
 struct file_lease *locks_alloc_lease(void);
-int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
+
+#define LEASE_BREAK_LEASE		BIT(0)	// break leases and delegations
+#define LEASE_BREAK_DELEG		BIT(1)	// break delegations only
+#define LEASE_BREAK_LAYOUT		BIT(2)	// break layouts only
+#define LEASE_BREAK_NONBLOCK		BIT(3)	// non-blocking break
+#define LEASE_BREAK_OPEN_RDONLY		BIT(4)	// readonly open event
+
+int __break_lease(struct inode *inode, unsigned int flags);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
 int generic_setlease(struct file *, int, struct file_lease **, void **priv);
 int kernel_setlease(struct file *, int, struct file_lease **, void **);
@@ -376,7 +383,7 @@ static inline int locks_lock_inode_wait(struct inode *inode, struct file_lock *f
 	return -ENOLCK;
 }
 
-static inline int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
+static inline int __break_lease(struct inode *inode, unsigned int flags)
 {
 	return 0;
 }
@@ -437,6 +444,17 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
 }
 
 #ifdef CONFIG_FILE_LOCKING
+static inline unsigned int openmode_to_lease_flags(unsigned int mode)
+{
+	unsigned int flags = 0;
+
+	if ((mode & O_ACCMODE) == O_RDONLY)
+		flags |= LEASE_BREAK_OPEN_RDONLY;
+	if (mode & O_NONBLOCK)
+		flags |= LEASE_BREAK_NONBLOCK;
+	return flags;
+}
+
 static inline int break_lease(struct inode *inode, unsigned int mode)
 {
 	struct file_lock_context *flctx;
@@ -452,11 +470,11 @@ static inline int break_lease(struct inode *inode, unsigned int mode)
 		return 0;
 	smp_mb();
 	if (!list_empty_careful(&flctx->flc_lease))
-		return __break_lease(inode, mode, FL_LEASE);
+		return __break_lease(inode, LEASE_BREAK_LEASE | openmode_to_lease_flags(mode));
 	return 0;
 }
 
-static inline int break_deleg(struct inode *inode, unsigned int mode)
+static inline int break_deleg(struct inode *inode, unsigned int flags)
 {
 	struct file_lock_context *flctx;
 
@@ -470,8 +488,10 @@ static inline int break_deleg(struct inode *inode, unsigned int mode)
 	if (!flctx)
 		return 0;
 	smp_mb();
-	if (!list_empty_careful(&flctx->flc_lease))
-		return __break_lease(inode, mode, FL_DELEG);
+	if (!list_empty_careful(&flctx->flc_lease)) {
+		flags |= LEASE_BREAK_DELEG;
+		return __break_lease(inode, flags);
+	}
 	return 0;
 }
 
@@ -479,7 +499,7 @@ static inline int try_break_deleg(struct inode *inode, struct inode **delegated_
 {
 	int ret;
 
-	ret = break_deleg(inode, O_WRONLY|O_NONBLOCK);
+	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
 	if (ret == -EWOULDBLOCK && delegated_inode) {
 		*delegated_inode = inode;
 		ihold(inode);
@@ -491,7 +511,7 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
 {
 	int ret;
 
-	ret = break_deleg(*delegated_inode, O_WRONLY);
+	ret = break_deleg(*delegated_inode, 0);
 	iput(*delegated_inode);
 	*delegated_inode = NULL;
 	return ret;
@@ -500,20 +520,24 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
 static inline int break_layout(struct inode *inode, bool wait)
 {
 	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
-		return __break_lease(inode,
-				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
-				FL_LAYOUT);
+	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease)) {
+		unsigned int flags = LEASE_BREAK_LAYOUT;
+
+		if (!wait)
+			flags |= LEASE_BREAK_NONBLOCK;
+
+		return __break_lease(inode, flags);
+	}
 	return 0;
 }
 
 #else /* !CONFIG_FILE_LOCKING */
-static inline int break_lease(struct inode *inode, unsigned int mode)
+static inline int break_lease(struct inode *inode, bool wait)
 {
 	return 0;
 }
 
-static inline int break_deleg(struct inode *inode, unsigned int mode)
+static inline int break_deleg(struct inode *inode, unsigned int flags)
 {
 	return 0;
 }

-- 
2.49.0


