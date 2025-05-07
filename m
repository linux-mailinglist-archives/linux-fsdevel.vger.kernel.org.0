Return-Path: <linux-fsdevel+bounces-48405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECEAAE67F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6181BA0A69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817E28DF45;
	Wed,  7 May 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSHPiCPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C228C2A2;
	Wed,  7 May 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634467; cv=none; b=d0JKkVhUXJrBpnI+5FInHDZaU1Z3gcLTTGPTqVVxEGV1qiumAu3gZlopzLBYPlE0mxGQ6v2O07kqSxc6eO2NMadPgm0PzkQlr+7STbpIP+QSXrcZF2O+WNhfW/JuAYOyz6SyhYyMm7VRoLqswJ97p6a/u8sGkeSH8+iacAMwVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634467; c=relaxed/simple;
	bh=u6UBg0rIcAFolpvGo5OrOssHZiALZ/tfKtbvsSEz8Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDzcEpvEX9MQzfyksqq/74aWBShtxPOGOBfUcjCDtT0+AI7DVAp0JdmN6EQK3z4G2svwvWoZuozF5v/VV80q8RHUToRr+AUfqp8kDL0R58cGmoz4iO0rKjpjxi2oHCtw3ZAq4evxijhTI6tdfpCXVxxlKPq/bUawgKKEtE+VnQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSHPiCPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7CDC4CEE9;
	Wed,  7 May 2025 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634467;
	bh=u6UBg0rIcAFolpvGo5OrOssHZiALZ/tfKtbvsSEz8Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iSHPiCPxez04iAp6vBQCTmqYdJ7fpd8TJ+m0v1egxGzmTRK/MkHrcZyJhKyyGLGBe
	 4E7ZQP/ZIejhVtwsfzGhswWekj1srPZXKRHTfDoWpWwBOHSbr+piDRFDxpVGf+Unrr
	 ufLyrbODLrUGs6xSGoKGE57M8FlFt3E6XuY0+e4l2Qv4pRs2PuiL1q7IZkk2NdZKkH
	 3OYFCdqtW2hbSVylbae9AqOhL8Soysmg7d1eby60MzgsoJIZJcXE6PTvOHo4xbZMZ2
	 vqP0mz6bCa1cSpUYM+k0tZ10wSi4exMN41YK55ahJ8A+WfxsgQlYw3YDAqhzq3Fecp
	 K2ojlWtqbSKrw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:42 +0200
Subject: [PATCH v4 09/11] pidfs, coredump: allow to verify coredump
 connection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-9-af0ef317b2d0@kernel.org>
References: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
In-Reply-To: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6339; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u6UBg0rIcAFolpvGo5OrOssHZiALZ/tfKtbvsSEz8Fk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt20tM/ngPEf8qOK3OfLZMXdvZRio8PszPXOJaZ+ao
 b5jp3xyRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESe/2Bk6E/bcz4lzOeG2N4d
 0boNz/Ji/n1N89G6uPxbzdXIBWGbExj+F7g7tkqeq9T6XXa2y8NUx+ZLkmtAxLRMNmuZKwWpndx
 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When a coredump connection is initiated use the socket cookie as the
coredump cookie and store it in the pidfd. The receiver can now easily
authenticate that the connection is coming from the kernel.

Unless the coredump server expects to handle connection from
non-crashing task it can validate that the connection has been made from
a crashing task:

   fd_coredump = accept4(fd_socket, NULL, NULL, SOCK_CLOEXEC);
   getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd, &fd_peer_pidfd_len);

   struct pidfd_info info = {
           info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
   };

   ioctl(pidfd, PIDFD_GET_INFO, &info);
   /* Refuse connections that aren't from a crashing task. */
   if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED) )
           close(fd_coredump);

   /*
    * Make sure that the coredump cookie matches the connection cookie.
    * If they don't it's not the coredump connection from the kernel.
    * We'll get another connection request in a bit.
    */
   getsocketop(fd_coredump, SOL_SOCKET, SO_COOKIE, &peer_cookie, &peer_cookie_len);
   if (!info.coredump_cookie || (info.coredump_cookie != peer_cookie))
           close(fd_coredump);

The kernel guarantees that by the time the connection is made the
coredump info is available.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c              |  3 ++-
 fs/pidfs.c                 | 20 +++++++++++++++++++-
 include/linux/net.h        |  1 +
 include/linux/pidfs.h      |  1 +
 include/uapi/linux/pidfd.h |  1 +
 net/unix/af_unix.c         |  7 +++++++
 6 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ddff1854988f..cfb7a3459785 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -907,7 +907,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 */
 		retval = kernel_connect(socket,
 					(struct sockaddr *)(&coredump_unix_socket),
-					COREDUMP_UNIX_SOCKET_ADDR_SIZE, O_NONBLOCK);
+					COREDUMP_UNIX_SOCKET_ADDR_SIZE, O_NONBLOCK |
+					SOCK_COREDUMP);
 
 		/*
 		 * ... So we can safely put our pidfs reference now...
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 8c4d83fb115b..7ff1e7923f19 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -35,6 +35,7 @@ struct pidfs_exit_info {
 	__u64 cgroupid;
 	__s32 exit_code;
 	__u32 coredump_mask;
+	__u64 coredump_cookie;
 };
 
 struct pidfs_inode {
@@ -300,6 +301,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 	if (mask & PIDFD_INFO_COREDUMP) {
 		kinfo.mask |= PIDFD_INFO_COREDUMP;
+		kinfo.coredump_cookie = READ_ONCE(pidfs_i(inode)->__pei.coredump_cookie);
 		kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
 	}
 
@@ -321,8 +323,10 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 	if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
 		task_lock(task);
-		if (task->mm)
+		if (task->mm) {
+			kinfo.coredump_cookie = READ_ONCE(pidfs_i(inode)->__pei.coredump_cookie);
 			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
+		}
 		task_unlock(task);
 	}
 
@@ -589,6 +593,20 @@ void pidfs_exit(struct task_struct *tsk)
 	}
 }
 
+void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie)
+{
+	struct pidfs_exit_info *exit_info;
+	struct dentry *dentry = pid->stashed;
+	struct inode *inode;
+
+	if (WARN_ON_ONCE(!dentry))
+		return;
+
+	inode = d_inode(dentry);
+	exit_info = &pidfs_i(inode)->__pei;
+	smp_store_release(&exit_info->coredump_cookie, coredump_cookie);
+}
+
 void pidfs_coredump(const struct coredump_params *cprm)
 {
 	struct pid *pid = cprm->pid;
diff --git a/include/linux/net.h b/include/linux/net.h
index 0ff950eecc6b..005f1e52e7f1 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -81,6 +81,7 @@ enum sock_type {
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
+#define SOCK_COREDUMP	O_TRUNC
 
 #endif /* ARCH_HAS_SOCKET_TYPES */
 
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index f7729b9371bc..5875037be272 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -10,6 +10,7 @@ void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
 void pidfs_exit(struct task_struct *tsk);
 void pidfs_coredump(const struct coredump_params *cprm);
+void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie);
 extern const struct dentry_operations pidfs_dentry_operations;
 int pidfs_register_pid(struct pid *pid);
 void pidfs_get_pid(struct pid *pid);
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 84ac709f560c..f46819a02d23 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -108,6 +108,7 @@ struct pidfd_info {
 	__s32 exit_code;
 	__u32 coredump_mask;
 	__u32 __spare1;
+	__u64 coredump_cookie;
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 148d008862e7..45e7a6363939 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -101,6 +101,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <linux/sock_diag.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
@@ -771,6 +772,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 struct unix_peercred {
 	struct pid *peer_pid;
+	u64 cookie;
 	const struct cred *peer_cred;
 };
 
@@ -806,6 +808,8 @@ static void drop_peercred(struct unix_peercred *peercred)
 static inline void init_peercred(struct sock *sk,
 				 const struct unix_peercred *peercred)
 {
+	if (peercred->cookie)
+		pidfs_coredump_cookie(peercred->peer_pid, peercred->cookie);
 	sk->sk_peer_pid = peercred->peer_pid;
 	sk->sk_peer_cred = peercred->peer_cred;
 }
@@ -1717,6 +1721,9 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	unix_peer(newsk)	= sk;
 	newsk->sk_state		= TCP_ESTABLISHED;
 	newsk->sk_type		= sk->sk_type;
+	/* Prepare a new socket cookie for the receiver. */
+	if (flags & SOCK_COREDUMP)
+		peercred.cookie = sock_gen_cookie(newsk);
 	init_peercred(newsk, &peercred);
 	newu = unix_sk(newsk);
 	newu->listener = other;

-- 
2.47.2


