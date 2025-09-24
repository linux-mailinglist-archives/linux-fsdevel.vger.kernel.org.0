Return-Path: <linux-fsdevel+bounces-62634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2EB9B45F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7563A2685
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4DA327787;
	Wed, 24 Sep 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHAqkepo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DD326D4F;
	Wed, 24 Sep 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737230; cv=none; b=cYlRBcgPcvOFOA4K3P3+DZOqRAs5PQM9m5b7cNsQManbcRpybDwyYX7Rw/5TPaEP1Q5FRG4CAwGes/JPGD1YBnm+AwYuLXYwDsSvS5PEeVjZXHA6xuU+jiXCDkjZHGHsn2cCIkZ+wWhOF0DbVpsHKFLdWqoLPeTjzwAWy2we37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737230; c=relaxed/simple;
	bh=PDAGku2VIDzqr+3zCnFtJtqq/VItCr6xeQkxALBkWhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTonsXiy0Q44mO+xYTyirZ+p7DsCbTgKKdIfFn0UylRDBdt2M9wkMzh6Cwnytrf4Rf6wstTjmGwLnnHlzRYB2dHsJQvhnFfMvZ2Muyxo39HMXbyomUNrra4APc7gdJQ4ZrzjOnrNM9UHnqHnYfhJd+rueXLDhNOteeLRsZU9oGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHAqkepo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07021C116C6;
	Wed, 24 Sep 2025 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737230;
	bh=PDAGku2VIDzqr+3zCnFtJtqq/VItCr6xeQkxALBkWhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dHAqkepo5U32bvTDFVz0Yw9Vz8HBwyKJnQQsn88nFdZ+S+Rf6OlJTOzQE3CIe+3az
	 0ZBCkqIVtOyzSfYPucgQooiepRVnlL+c/6uyDbDI2im39HAhnUapL5jkFs80SMS+bJ
	 waZ0ACrs9pT4ucER21lGp2U0oANJb8Tm1YYipwimA9h0yGFm64+WHL4U6WUBDHA56k
	 uesTS+UHuXe351yJoH1FOVLJeThhb+ak8GHaZikafSvjgwgfhZmHqNLGBd04i+dgiY
	 glXkQOfgyf7kU8JMERRzxq8OzsA8acuQFj0nwMfS0d4WGyXAmEyCRIFPs/BBl8LPfZ
	 e10Cw9tJvQtZg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:02 -0400
Subject: [PATCH v3 16/38] filelock: add support for ignoring deleg breaks
 for dir change events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-16-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6498; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PDAGku2VIDzqr+3zCnFtJtqq/VItCr6xeQkxALBkWhc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMNGrbbvJhQ3QYeQjYCcSsEZJqBiAVKTRtkH
 A4LNcGiz2KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDQAKCRAADmhBGVaC
 FTxzD/oD3NvM1uxFK5E6hikH3oqBGpzshVdzfwwnfp9oQCAqMa4J6x43pD6fil2dkAg3QTGX5JL
 2AgX9MXEYr56vq5bsynOhg2meOUTQaYWMwndzJ32MpBoE4VyZBGUD0e9MJu8O0LsXF/wiyUGzDw
 5Fg9OBFN9QMnnUgwdl61aRJMO2zAPWY+Y2JQQ/s9KwlqM7crdppTQMO4ZplE5vKRaJKphqM57S0
 SHlr4KBYiccbiS4DKLPVI21buVzNEmgyVJA5fwrVrkj4I4nZzAVAO0+ZVU5bm4GBCNWJkMi2ML8
 aDXLEVo1CyjB7TGvt1i04w/IDR7wILYoB8ZeV9k5JOjG6Viuej8TsZb8YsxXRg8opU/oxWz2fYk
 SaDSYPb4VPnyDynJh69HePacyuVey0qPO//19xO8kexOVMR/yLBHB9Zil3BJcX/nmK6iA/4SBZ2
 ypC9R7qF5+DJYm/ltc4rCakTw15R3/UGvmijLtGmCluG5DqRHj6kT3A6n+0d2BFzMg+4o4XWmWs
 yWQcqJsG3LYSgNKnPlKFrIb7Z9aiYMekPkFF9JwPuionSRmdv2GRb7dM3flyUeJ5F/L3H2i0Ixs
 jQN7O4JXfn5VuCngyoWebu94a/rPdcvfEJgeV7u8Yrm3ba+lt25+kZzWQFgOuI+mHBj1ojqdixi
 n3LImv/Mm3kTF7A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If a NFS client requests a directory delegation with a notification
bitmask covering directory change events, the server shouldn't recall
the delegation. Instead the client will be notified of the change after
the fact.

Add a support for ignoring lease breaks on directory changes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      | 56 ++++++++++++++++++++++++++++++++++-------
 include/linux/filelock.h        | 29 +++++++++++----------
 include/trace/events/filelock.h |  5 +++-
 3 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 4cfa4fc7130137b2850cab871bc3b2b23bbd3db1..ff5f5a85680a2c8511f5828947e829c7ffc1bd59 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1526,15 +1526,52 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 	return false;
 }
 
+static bool
+ignore_dir_deleg_break(struct file_lease *fl, unsigned int flags)
+{
+	if ((flags & LEASE_BREAK_DIR_CREATE) && (fl->c.flc_flags & FL_IGN_DIR_CREATE))
+		return true;
+	if ((flags & LEASE_BREAK_DIR_DELETE) && (fl->c.flc_flags & FL_IGN_DIR_DELETE))
+		return true;
+	if ((flags & LEASE_BREAK_DIR_RENAME) && (fl->c.flc_flags & FL_IGN_DIR_RENAME))
+		return true;
+
+	return false;
+}
+
+static bool
+visible_leases_remaining(struct inode *inode, unsigned int flags)
+{
+	struct file_lock_context *ctx = locks_inode_context(inode);
+	struct file_lease *fl;
+
+	lockdep_assert_held(&ctx->flc_lock);
+
+	if (list_empty(&ctx->flc_lease))
+		return false;
+
+	if (!S_ISDIR(inode->i_mode))
+		return true;
+
+	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
+		if (!ignore_dir_deleg_break(fl, flags))
+			return true;
+	}
+	return false;
+}
+
 /**
- *	__break_lease	-	revoke all outstanding leases on file
- *	@inode: the inode of the file to return
- *	@flags: LEASE_BREAK_* flags
+ * __break_lease	-	revoke all outstanding leases on file
+ * @inode: the inode of the file to return
+ * @flags: LEASE_BREAK_* flags
  *
- *	break_lease (inlined for speed) has checked there already is at least
- *	some kind of lock (maybe a lease) on this file.  Leases are broken on
- *	a call to open() or truncate().  This function can block waiting for the
- *	lease break unless you specify LEASE_BREAK_NONBLOCK.
+ * break_lease (inlined for speed) has checked there already is at least
+ * some kind of lock (maybe a lease) on this file. Leases and Delegations
+ * are broken on a call to open() or truncate(). Delegations are also
+ * broken on any event that would change the ctime. Directory delegations
+ * are broken whenever the directory changes (unless the delegation is set
+ * up to ignore the event). This function can block waiting for the lease
+ * break unless you specify LEASE_BREAK_NONBLOCK.
  */
 int __break_lease(struct inode *inode, unsigned int flags)
 {
@@ -1545,7 +1582,6 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
 	int error = 0;
 
-
 	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
@@ -1584,6 +1620,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
 		if (!leases_conflict(&fl->c, &new_fl->c))
 			continue;
+		if (S_ISDIR(inode->i_mode) && ignore_dir_deleg_break(fl, flags))
+			continue;
 		if (want_write) {
 			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 				continue;
@@ -1599,7 +1637,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 			locks_delete_lock_ctx(&fl->c, &dispose);
 	}
 
-	if (list_empty(&ctx->flc_lease))
+	if (!visible_leases_remaining(inode, flags))
 		goto out;
 
 	if (flags & LEASE_BREAK_NONBLOCK) {
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 68901da7671694f68d939085d08e0da21712540d..0f0e56490c7ba4242c1caa79c68ab1db459609d8 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -4,19 +4,22 @@
 
 #include <linux/fs.h>
 
-#define FL_POSIX	1
-#define FL_FLOCK	2
-#define FL_DELEG	4	/* NFSv4 delegation */
-#define FL_ACCESS	8	/* not trying to lock, just looking */
-#define FL_EXISTS	16	/* when unlocking, test for existence */
-#define FL_LEASE	32	/* lease held on this file */
-#define FL_CLOSE	64	/* unlock on close */
-#define FL_SLEEP	128	/* A blocking lock */
-#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
-#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
-#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
-#define FL_LAYOUT	2048	/* outstanding pNFS layout */
-#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+#define FL_POSIX		BIT(0)	/* POSIX lock */
+#define FL_FLOCK		BIT(1)	/* BSD lock */
+#define FL_LEASE		BIT(2)	/* file lease */
+#define FL_DELEG		BIT(3)	/* NFSv4 delegation */
+#define FL_LAYOUT		BIT(4)	/* outstanding pNFS layout */
+#define FL_ACCESS		BIT(5)	/* not trying to lock, just looking */
+#define FL_EXISTS		BIT(6)	/* when unlocking, test for existence */
+#define FL_CLOSE		BIT(7)	/* unlock on close */
+#define FL_SLEEP		BIT(8)	/* A blocking lock */
+#define FL_DOWNGRADE_PENDING	BIT(9)	/* Lease is being downgraded */
+#define FL_UNLOCK_PENDING	BIT(10) /* Lease is being broken */
+#define FL_OFDLCK		BIT(11) /* POSIX lock "owned" by struct file */
+#define FL_RECLAIM		BIT(12) /* reclaiming from a reboot server */
+#define FL_IGN_DIR_CREATE	BIT(13) /* ignore DIR_CREATE events */
+#define FL_IGN_DIR_DELETE	BIT(14) /* ignore DIR_DELETE events */
+#define FL_IGN_DIR_RENAME	BIT(15) /* ignore DIR_RENAME events */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 2dfeb158e848a528b7d9c0d5f8872c5060df1bf6..4988804908478912c6b8044dfb3b147fc50e4823 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -28,7 +28,10 @@
 		{ FL_DOWNGRADE_PENDING,	"FL_DOWNGRADE_PENDING" },	\
 		{ FL_UNLOCK_PENDING,	"FL_UNLOCK_PENDING" },		\
 		{ FL_OFDLCK,		"FL_OFDLCK" },			\
-		{ FL_RECLAIM,		"FL_RECLAIM"})
+		{ FL_RECLAIM,		"FL_RECLAIM" },			\
+		{ FL_IGN_DIR_CREATE,	"FL_IGN_DIR_CREATE" },		\
+		{ FL_IGN_DIR_DELETE,	"FL_IGN_DIR_DELETE" },		\
+		{ FL_IGN_DIR_RENAME,	"FL_IGN_DIR_RENAME" })
 
 #define show_fl_type(val)				\
 	__print_symbolic(val,				\

-- 
2.51.0


