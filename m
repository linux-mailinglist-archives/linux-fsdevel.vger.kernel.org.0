Return-Path: <linux-fsdevel+bounces-50346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D398ACB0FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5481940285
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D65233738;
	Mon,  2 Jun 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc/dEgij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B183233710;
	Mon,  2 Jun 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872976; cv=none; b=fQT2KD/melh4wsFRjEHXhK/RcE/6zp2ZOUPSFQyPKinAyT13c+7copugD1Hr28rfcvbv49r0RZOi4FBvz/Kj7tzCbixz+gLNOv+Ebxgp54p2hnh2nSNJsbR+wT2LKPlVXEelUjqwDcsczLBiA4znvl2MMA4Q3buNlFG6hxWH+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872976; c=relaxed/simple;
	bh=l1z9iLUkJ0KvsPge0I8LFG6jb0PtwW40TMKjx9uD3Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sk4XAuY6QGUyvNLLeOYjGTzr8Y+gu08SJsXJNFAcpHlUksOr9eNd4i1zS5k2Z+yTDkBM0wmPtnm1zz0HIujs7DSfS+vsjQFc/xa0T/+3vBc3lTEdcVw7loNpuYL4LLRlqQ1Db60j6Cxcoyf9UsFHcgU3wMK+cMW1OiYTdBlSAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc/dEgij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C752C4CEEB;
	Mon,  2 Jun 2025 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872976;
	bh=l1z9iLUkJ0KvsPge0I8LFG6jb0PtwW40TMKjx9uD3Ls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xc/dEgijwM+KWINT6xRSiuECZeDVQa0/hGg9S2z7Lavf06L2SOITTHzCRWLUYtXW5
	 p1Vw9s5OeYlBmJNQwaiY/biiyl/RaVNGllgCoCgZsLv+V893IpaFu1ux63LdWlXf3R
	 2YLf589SghXRJ53zrZy0kOUe6dRoMuo4T3X6+50KoLM2hKPaaOWZo9M6Kme1+LVpNg
	 ewDy2ZEBzw9dc8OLtdIu8cix3iaRC6D2uSX7xXVva+6zk2sOf7bfP0FE1PLFnfzsnl
	 iEnTuGhsBDqMLkk/lRWi4EDYjKosyY8pQZMg6amiZk5efmz8gsCQiy54I5FXUQphwu
	 o+C4eoWzvdKNQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:59 -0400
Subject: [PATCH RFC v2 16/28] filelock: add support for ignoring deleg
 breaks for dir change events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-16-a7919700de86@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5743; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=l1z9iLUkJ0KvsPge0I8LFG6jb0PtwW40TMKjx9uD3Ls=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7n5joJeAiGMTeYtl2VHuJMTpkez3iSh3Rzg
 ovZBrIcu4qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5wAKCRAADmhBGVaC
 Fbu/EADE42Xwa7/1tThWNVhEe1pk7DYQS7gD89WSuvz+X9VFYW3asu8vEwNYZtDIaAKLZuOXpe5
 AIhsDQjYIyktimSQdiSNF7K7AAjqSXxlSMSxbhHqRXBTw5CjDXfvKFYfIwQTOaRR7RdVwnptDvH
 ym+9xf3SWSjfJQ4PdvJ+DG6QRwcdKWGUg0lInh0jKU8Vkoc6sq2zYYaAaGTFei+CWctQtDkVaa5
 mAMmoeBbTcIwkcvzeLAoM/2+qaXhj9bxe0pu9MObJsCBRcdjsqpdGURzmd4SFfdGyfwqLf43dkR
 IEpr8W0FtOIvz0/7LwB/xgk5hMvsJ+YM6wOY1kXByQK/6FKoMlDDEzI+U5k8Rnl0nvDgBvvb6Wm
 k0lK+Hg3LIrbPSJzv03sN9s7vtmsXcVAWs7C01j6xsBgES8bHjGwBbvOlDodu+3u3sxCPJyWB6J
 Oci+B5ZNXrDxXLL1lK5xjh19Kp6sdnYHrJxco1hrzHqzHHopS8GoGaSVliuVPUF/ak6Ogoj9SZP
 WnbuOFu3LtVwbX3yAGEXsLoDhGplKSA0IQeVTVlOcm0YbabD2VogWHR0uC+QsEhGGoakJNRgdFa
 TXoeulGoY3NzuFiS2bTDNw9xBucW13BK+KBvbBLsrQjtGJ/GZGUTSRZgOi75PAb6KOyQ9sI6ebY
 1PxaHINBn5WSMvQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If a NFS client requests a directory delegation with a notification
bitmask covering directory change events, the server shouldn't recall
the delegation. Instead the client will be notified of the change after
the fact.

Add a support for ignoring lease breaks on directory changes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 56 ++++++++++++++++++++++++++++++++++++++++--------
 include/linux/filelock.h | 29 ++++++++++++++-----------
 2 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6e46176d1e00962904f03c151500e593f410e4c6..95270a1fab4a1792a6fcad738cc9d937d99ad2af 100644
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
index f2b2d1e1d1ab08671895c3bfe398e5bba02353d8..32b30c14f5fd52727b1a18957e9dbc930c922941 100644
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
 

-- 
2.49.0


