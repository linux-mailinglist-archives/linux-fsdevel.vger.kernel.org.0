Return-Path: <linux-fsdevel+bounces-52125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD67ADF81D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2F44A0BCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E721D3FD;
	Wed, 18 Jun 2025 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItJ4MZER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020C21CC61
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280049; cv=none; b=c178rulv3PvChewMhtLEjhhxzvKsHEC339msQS9z2g4ZuqMp77vt9iIy79zGIK6exsUYz8mm2if4Qf1P4Kik/YkYU9X4jeKoSJzgz/yZDB81g/lTe/uGcYyk3uS+UNriLXaFPCH/Z2dx6b/Mx9qGrPEK2XVlsa6WVG8chOhxiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280049; c=relaxed/simple;
	bh=rVOAOxFNzbzOQFH5xafnM/dLjvE0X2OUTb+/dNECKII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4MH+Vv/eBz980ZRw3Tg5T0/PeHbfLBYyxgulnBNOVryYdrwoNyDjfFCEP2xLCORHWVca9RnbThWCO0+sHan4R6GFWXukE1M/bOWRuhsVkwyZOsOCjv3wZF4vsm4QOFB/kO2NPfQpE/d1gHCXvLJfOzEqJ/k43i4n/QXnGxX+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItJ4MZER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32524C4CEEF;
	Wed, 18 Jun 2025 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280049;
	bh=rVOAOxFNzbzOQFH5xafnM/dLjvE0X2OUTb+/dNECKII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ItJ4MZERO/pSGz3YQleJtBV++er6+kvZ8kNkugnD8ISUYTrpSwgsKyjL3skNrHqU2
	 e7r6wO5FxHNv0mHefsE9mKl3Jq7XMtVcC0f5Uu5t7gkyM73BadyaBldMAoiucwuEa/
	 HQTpptqz0U02im9GE2uujH8DNVfTbMIZ05zcEVUtlZHr6zebCfmvR6jy3j2KoJ0gKx
	 R/g6XZw1U72Tln8JOUVwA1cP/GeXatw5OtpuuPxSg/jyKENB99YW8BRXQX7tbaJLsR
	 RC+OyfwqK0FdDVNRVtAIkg4nmbOu6hrDc1IunwQz77DUQiNA1rKZw/fxlwDS/liNO8
	 tbkOQ+hoGZ0Zw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:42 +0200
Subject: [PATCH v2 08/16] pidfs: remove pidfs_{get,put}_pid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-8-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3920; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rVOAOxFNzbzOQFH5xafnM/dLjvE0X2OUTb+/dNECKII=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0f2/oq6cI+1bUVOXJvE7xUzTvL4Tr7eqrvxnYGc8
 cFAMSGFjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8+c7I8O5B2vo3t5JLOv3/
 Ok842yEU+rI/Q4vPMyhRRzqDX/nVCoY/XF3fZqRc/vs4qcvmp8Xi1v5reauUfWfa7Tt2XndxwsF
 QRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we stash persistent information in struct pid there's no need
to play volatile games with pinning struct pid via dentries in pidfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c         |  6 ------
 fs/pidfs.c            | 35 +----------------------------------
 include/linux/pidfs.h |  2 --
 net/unix/af_unix.c    |  5 -----
 4 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f217ebf2b3b6..55d6a713a0fb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -898,12 +898,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = kernel_connect(socket, (struct sockaddr *)(&addr),
 					addr_len, O_NONBLOCK | SOCK_COREDUMP);
 
-		/*
-		 * ... Make sure to only put our reference after connect() took
-		 * its own reference keeping the pidfs entry alive ...
-		 */
-		pidfs_put_pid(cprm.pid);
-
 		if (retval) {
 			if (retval == -EAGAIN)
 				coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
diff --git a/fs/pidfs.c b/fs/pidfs.c
index c49c53d6ae51..bc2342cf4492 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -895,8 +895,7 @@ static void pidfs_put_data(void *data)
  * pidfs_register_pid - register a struct pid in pidfs
  * @pid: pid to pin
  *
- * Register a struct pid in pidfs. Needs to be paired with
- * pidfs_put_pid() to not risk leaking the pidfs dentry and inode.
+ * Register a struct pid in pidfs.
  *
  * Return: On success zero, on error a negative error code is returned.
  */
@@ -1007,38 +1006,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	return pidfd_file;
 }
 
-/**
- * pidfs_get_pid - pin a struct pid through pidfs
- * @pid: pid to pin
- *
- * Similar to pidfs_register_pid() but only valid if the caller knows
- * there's a reference to the @pid through a dentry already that can't
- * go away.
- */
-void pidfs_get_pid(struct pid *pid)
-{
-	if (!pid)
-		return;
-	WARN_ON_ONCE(!stashed_dentry_get(&pid->stashed));
-}
-
-/**
- * pidfs_put_pid - drop a pidfs reference
- * @pid: pid to drop
- *
- * Drop a reference to @pid via pidfs. This is only safe if the
- * reference has been taken via pidfs_get_pid().
- */
-void pidfs_put_pid(struct pid *pid)
-{
-	might_sleep();
-
-	if (!pid)
-		return;
-	VFS_WARN_ON_ONCE(!pid->stashed);
-	dput(pid->stashed);
-}
-
 void __init pidfs_init(void)
 {
 	pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 8f6ed59bb3fb..3e08c33da2df 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -14,8 +14,6 @@ void pidfs_coredump(const struct coredump_params *cprm);
 #endif
 extern const struct dentry_operations pidfs_dentry_operations;
 int pidfs_register_pid(struct pid *pid);
-void pidfs_get_pid(struct pid *pid);
-void pidfs_put_pid(struct pid *pid);
 void pidfs_free_pid(struct pid *pid);
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2e2e9997a68e..129388c309b0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -646,9 +646,6 @@ static void unix_sock_destructor(struct sock *sk)
 		return;
 	}
 
-	if (sk->sk_peer_pid)
-		pidfs_put_pid(sk->sk_peer_pid);
-
 	if (u->addr)
 		unix_release_addr(u->addr);
 
@@ -769,7 +766,6 @@ static void drop_peercred(struct unix_peercred *peercred)
 	swap(peercred->peer_pid, pid);
 	swap(peercred->peer_cred, cred);
 
-	pidfs_put_pid(pid);
 	put_pid(pid);
 	put_cred(cred);
 }
@@ -802,7 +798,6 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 	spin_lock(&sk->sk_peer_lock);
 	sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
-	pidfs_get_pid(sk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 }

-- 
2.47.2


