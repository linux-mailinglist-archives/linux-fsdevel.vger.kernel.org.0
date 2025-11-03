Return-Path: <linux-fsdevel+bounces-66777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A41C2BDFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1FC3B940F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E730F805;
	Mon,  3 Nov 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqmkvBxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E930EF7E;
	Mon,  3 Nov 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174378; cv=none; b=OkMvMhjvvgcpZavodAj21wO+9SHn8PHXJkU8NeZASj315K91QvdSyHtfwkjINr65g9QYZf98VIlXfCndwMZpncSOu+/Ic5x+vrttMNbPDHlXkHXL9px2KDMD9njxxdgH9BKp1OU0jpdUTSFWjdotwRS4d1cr1EKHgV1FaDK5nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174378; c=relaxed/simple;
	bh=GnymqP1pjrUzX2EzwRGc2AVY+sxr9dx2mMhp63lQzMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cu+8vrv6HGs1lcOqvpVI89jmVyyCspgmOqfGfgaQJK4xdwhexXKiqbcL1Pl/ZjiohtdURJ/cP4zZr0YE0gw7nBEE8Jw8tB3JfxRONpbfLFqVlcPPVES0f3HuEGUIqEgbzJxCjU+N4uA2YAWUPklD8FUwQzYdRjxzkPBQcj1GJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqmkvBxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BFBC116B1;
	Mon,  3 Nov 2025 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174377;
	bh=GnymqP1pjrUzX2EzwRGc2AVY+sxr9dx2mMhp63lQzMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QqmkvBxHD/A5VhiFk4JURGaW63GjoAw3rdD8bgIuYoGuxiutRfdKP1luJmWhLcVyq
	 L0hrQ7R+nktgQzfW9sG59x2hjRDIB1oMSNkKPrHjlptsPYvLiNedWbSvPyphoIVxUT
	 YGhwvusoxRA89sE43dSw51U4Fr3q2tbWeGjw6G3F/Et+wx6XkFzf1yap8j8YTWj3jM
	 X9bLfCHuyMbFt/9tEVfCqXt7/BYlz++c2GldwCIog1dlvI2vaWA2LyzreOJokHCQ8e
	 tewUP7ciC7B2hQLbW9PJXP2u/w1j594hxFlxNja1iE56P1lrSbiNT1rhCrJxm7WNDQ
	 mGSjxNENvhj6g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:30 -0500
Subject: [PATCH v4 02/17] filelock: rework the __break_lease API to use
 flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-2-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
In-Reply-To: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7009; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GnymqP1pjrUzX2EzwRGc2AVY+sxr9dx2mMhp63lQzMg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWcGxXe9a/raZjhuA+PmjmirQgEt0MHFP1Gu
 2W0Ge8sy2uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnAAKCRAADmhBGVaC
 FUvTD/4wqLWLTGbFndHVeqqaU+4Qa2xv1eXe1EPFsR2kZW7dioQ1gSZ7OzYzsLMCl+2mzobV/8f
 wo7qsRa+En+XnT4k9znXNPb03yp0Y4V78MaX8i5T5vPUheiG/CZVLOul1+1UKXtDhPjE5cogT4p
 Geo6Z2kTf1bfPHvaLFPOWIzxATuq/LZheyr+8ZEZZ901cmP5An7tt9r+ZMzOHiWbFrxFrSovA9w
 OLJHmb1SitkF2nPJk86GwO5SiyEMKlwI6jYSnyi25FNYyOgCXG3gL1JDou2nsmhSDzUJtXElbAV
 lrnfPyUXgZHP9QfkN70C1af8YLoVZmIWOtFMGo3MPUMxhtImo34mZnI/qAxbH5Mowo288NqXEfH
 A5JaPYtVic9sZ+hmlDSKysUUYKEyTxaJbGyABmTQNWmfDLIfZKynMESjtOR19ytme4PZlpFLoVe
 uvTPiK/M6INLPtmjncu2PixpAGci0eeD6vwO7LsW/BCZ45i+BwvbvAI963FQk/nA7+xvnWBmu5+
 5AV6BnQldUIKxX4jolSj1YPMmr1pdzbTNrKYybW7E8nF9witoRnP2nAAhdjM98m8Fa8VxcP+X2V
 qjDiHdXpxWsnmeHtj9kgr2StDBRfhlDmqzExpoCX7oK30B2ot4Fe5fZu7k4tLCRvxsawdzp9rG4
 iQBf2T3ZbcGlKRw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently __break_lease takes both a type and an openmode. With the
addition of directory leases, that makes less sense. Declare a set of
LEASE_BREAK_* flags that can be used to control how lease breaks work
instead of requiring a type and an openmode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 29 +++++++++++++++++----------
 include/linux/filelock.h | 52 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b33c327c21dcd49341fbeac47caeb72cdf7455db..3cdd84a0fbedc9bd1b47725a9cf963342aafbce9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1529,24 +1529,31 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
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
+	unsigned int type;
 	LIST_HEAD(dispose);
+	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
+	int error = 0;
+
+	if (flags & LEASE_BREAK_LEASE)
+		type = FL_LEASE;
+	else if (flags & LEASE_BREAK_DELEG)
+		type = FL_DELEG;
+	else if (flags & LEASE_BREAK_LAYOUT)
+		type = FL_LAYOUT;
+	else
+		return -EINVAL;
 
 	new_fl = lease_alloc(NULL, type, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
@@ -1595,7 +1602,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	if (list_empty(&ctx->flc_lease))
 		goto out;
 
-	if (mode & O_NONBLOCK) {
+	if (flags & LEASE_BREAK_NONBLOCK) {
 		trace_break_lease_noblock(inode, new_fl);
 		error = -EWOULDBLOCK;
 		goto out;
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d068b451ecf8f513b7e532819a29944..47da6aa28d8dc9122618d02c6608deda0f3c4d3e 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -212,7 +212,14 @@ int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
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
@@ -367,7 +374,7 @@ static inline int locks_lock_inode_wait(struct inode *inode, struct file_lock *f
 	return -ENOLCK;
 }
 
-static inline int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
+static inline int __break_lease(struct inode *inode, unsigned int flags)
 {
 	return 0;
 }
@@ -428,6 +435,17 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
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
@@ -443,11 +461,11 @@ static inline int break_lease(struct inode *inode, unsigned int mode)
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
 
@@ -461,8 +479,10 @@ static inline int break_deleg(struct inode *inode, unsigned int mode)
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
 
@@ -470,7 +490,7 @@ static inline int try_break_deleg(struct inode *inode, struct inode **delegated_
 {
 	int ret;
 
-	ret = break_deleg(inode, O_WRONLY|O_NONBLOCK);
+	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
 	if (ret == -EWOULDBLOCK && delegated_inode) {
 		*delegated_inode = inode;
 		ihold(inode);
@@ -482,7 +502,7 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
 {
 	int ret;
 
-	ret = break_deleg(*delegated_inode, O_WRONLY);
+	ret = break_deleg(*delegated_inode, 0);
 	iput(*delegated_inode);
 	*delegated_inode = NULL;
 	return ret;
@@ -491,20 +511,24 @@ static inline int break_deleg_wait(struct inode **delegated_inode)
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
2.51.1


