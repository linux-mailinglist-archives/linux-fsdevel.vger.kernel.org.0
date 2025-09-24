Return-Path: <linux-fsdevel+bounces-62632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF26B9B414
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012F71BC0AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA2324B11;
	Wed, 24 Sep 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuIT5u8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743E323411;
	Wed, 24 Sep 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737223; cv=none; b=gN3M8n6ERoI2bzvJz8YvLB+ZEQfNm83lFkv6BuZdS93FlLYWhi4Zk5/8fpt/9BDQWV74GUCnoxE8ZFUFMg8w3JcP6KoT/q8ghIdxTP8WcaZIiD8kbcoFfweCTCkDOdjK0VTv4Gx/1VOZx0iTediuMKrGm7sjddqumwvC0B3Rbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737223; c=relaxed/simple;
	bh=dCDDyTsY1etvvU5msEmOv5kFSHvcq2ty6urx+MqOZ8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAuyi1lGoPhnqHEgy7mwn3RSh/CDZ6A4p0VkXJFfRaLrt5v69PYa/N1rhinzFU7GYsN5xKmyOlv6zYPuHglSz/s3R2nrftl7U2u3xokkwcKY1GdjkF3NU6REG3cwY8/XUUF2ZPkFXkri1+6IFVH5Wyth9K0r6D3NcsgNyJTNeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuIT5u8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD43CC4CEF4;
	Wed, 24 Sep 2025 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737223;
	bh=dCDDyTsY1etvvU5msEmOv5kFSHvcq2ty6urx+MqOZ8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cuIT5u8DYe7vDGT2Mz6pnPop9durJOyucBFoiBqgeeLKLtn40jEub90bG4MibMS9j
	 38gktWVQNVmoMMoBwNoMfopMHMxxZPfzEokGKIDe7Utb6R5desUi3oxvC5IMYpqViD
	 ADCSYFWlY7++KMNN6rDiWi2WJadgrIctN56VkZJDSLyDZYF96Xw6J92BS33yj1ZXSW
	 sogHPnCT6A62H0s5TTwAJ/OF9dEWeN0LvZJEyQrEXr2hg78qDlXBzEik2BvLOT+U7H
	 /4ta5748GtxWagGr/pjqXNkincavN11uGbtY1ZtBZzvhH//pFu4z+M9RWM1HXkyfrM
	 aUqkP4p1r+9jw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:00 -0400
Subject: [PATCH v3 14/38] filelock: rework the __break_lease API to use
 flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-14-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7075; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dCDDyTsY1etvvU5msEmOv5kFSHvcq2ty6urx+MqOZ8o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMN2eKdfQTOPnKduax905GoN/lIPgn5I8zYC
 FqyYUf1xWiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDQAKCRAADmhBGVaC
 FYmHD/wPI9gaN7zT7V5yNUOe9zeBwToAU1ezynIrKvg4l1rlQSIstmcjV34dsZZIUkHu/y7VAo4
 90IR+FlljBnZiXMnC/Jn+hXdPv9JHmesDnSTcPpzYBCw9ASIFLmFonxYScmUEkRz+Q2OdMdE5V7
 Qfw+X/5g8vZ+XoLZ2myTsbQIl1dIj6dyVTd+lJuV6SYsnDa9v5GSMtAyvP88NYPwaN/nBevJG5R
 W6PyHYVLcLA1YJ5yBodxZuz794KbsmvnmekurIF2q1eQ6vBwT26gzjVVswgA0gBmGUqQI+CisLr
 3UFcNvLr1PzMUKQc9+52XGpZoAGQjXRzZdUp0VAYfaDwZ7jAhK7CqUk85uBtR+2XDi0LO3a5tIV
 SG1UD01LpEsw9XbEipAkLP4nUPJSF46kLLT8mJYuvkQy/yLarbRFgoZRx6T1e5VJ+HWNhhEN2Bo
 UsHAhCPnh+wAtlcX+3SNUTGqL2F+vzQV4Wy4jgJZLIPg+SPXDW7Xb9qdaemm+19Vu5mrormFTr+
 MoLiWe3ieaJwsJFwIhIWGk90sZlapSr2QcpWfB/m/OVeVbkawrUV2N4yW7pJIOoC7AURe9CKVtk
 qfgHsGoJqsLBX7XuZ4VPgMnoL+b2OX1lUDJ5V/uh3Q5eVXEMK10ZtAJ71JcAzvSVqvSQAHlxCRg
 pnTdVy34cGTk7Yw==
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
index c1b4575c827648275a8d6628a8f279d382e46fc4..4cfa4fc7130137b2850cab871bc3b2b23bbd3db1 100644
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
index 70079beddf61aa32ef01f1114cf0cb3ffaf2131a..29078156d863b4e66dc59085f7c2cebd2c078ec3 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -226,7 +226,14 @@ int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
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
@@ -381,7 +388,7 @@ static inline int locks_lock_inode_wait(struct inode *inode, struct file_lock *f
 	return -ENOLCK;
 }
 
-static inline int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
+static inline int __break_lease(struct inode *inode, unsigned int flags)
 {
 	return 0;
 }
@@ -442,6 +449,17 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
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
@@ -457,11 +475,11 @@ static inline int break_lease(struct inode *inode, unsigned int mode)
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
 
@@ -475,8 +493,10 @@ static inline int break_deleg(struct inode *inode, unsigned int mode)
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
 
@@ -484,7 +504,7 @@ static inline int try_break_deleg(struct inode *inode, struct inode **delegated_
 {
 	int ret;
 
-	ret = break_deleg(inode, O_WRONLY|O_NONBLOCK);
+	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
 	if (ret == -EWOULDBLOCK && delegated_inode) {
 		*delegated_inode = inode;
 		ihold(inode);
@@ -496,7 +516,7 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
 {
 	int ret;
 
-	ret = break_deleg(*delegated_inode, O_WRONLY);
+	ret = break_deleg(*delegated_inode, 0);
 	iput(*delegated_inode);
 	*delegated_inode = NULL;
 	return ret;
@@ -505,20 +525,24 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
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
2.51.0


