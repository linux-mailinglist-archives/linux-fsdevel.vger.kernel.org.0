Return-Path: <linux-fsdevel+bounces-48061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2609AA91DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0775C3A5BD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145302147F8;
	Mon,  5 May 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajTVjPCs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5F205501;
	Mon,  5 May 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443672; cv=none; b=obvNcH3Cjz6zqscuyZJCWE+wP6c7Pq9E8KIK++yzBgKeO8Eu4/mW6CNxnN8y4MDf9HX7ycoDn8Y3MF+XB91317Ea8hYO2oHgYsuxGAJShsZ5z/RynM9rt8kIjQFOzqC6CmKMJMaI69EXuCOru7O2vjiFTkbw3uWGnsyUdgZ7e/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443672; c=relaxed/simple;
	bh=bI0caR6OLZqfvV36W6soJHjyrY3NJW1ltnBAht9lalI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCRoJMjXBlboSvpSKmxQLzobmozr0VjVUty5y1rJtm6oK/zjmarmO07cF3lp3jCFqwKIHqVNG3KABgJcLxb1+j4Ua4Tif6YNMmcIZehpvgZEVXBuLQ//7OsrRB3co9itPeH6lf/i2kk6uMaQQ1tJAykfyCMZhg7zZ3ts3WMn3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajTVjPCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC65FC4CEEF;
	Mon,  5 May 2025 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443671;
	bh=bI0caR6OLZqfvV36W6soJHjyrY3NJW1ltnBAht9lalI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ajTVjPCs6AmpgqRYCYuGldhzEwKX8qtgd+IUJTErCWIhh2XBih3Za1HoUVbOoDXfR
	 kiJ8w1NFHi1qwMieYRfX9kVXAlsZWL1T/P/NltMlR4PHbM+axz1eIfNuiAxemmIX/i
	 zM0HWs/WCNv1fzDpimniAo6gFO25DU5QarjgpyIcZ2CDa9OuL4aiPlXQY9Yne3Sp7G
	 0aN6/6tadstpO4niY6HZMDyVeVyGEAodGyG49P2YetYF8UjcTQN9bp0Yb1bLr3ttXB
	 4rt0V5N2cMjoajN3VNDxpLkbrWcizCLbzOji84rn8TIM2kojKZjGseJxN/C2e4o+3F
	 b22NZ9nQEEhMg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:46 +0200
Subject: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-work-coredump-socket-v3-8-e1832f0e1eae@kernel.org>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6790; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bI0caR6OLZqfvV36W6soJHjyrY3NJW1ltnBAht9lalI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIzM1bVbNp/8eHd4vnJq/OmJJz91xZn3HX7MuM93m2z
 jm2+dYHs45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJJKcyMrxc9WI5t2XP/rvO
 Ej4qpk3b8kS7qm4rzVl+vJprkXBKiCUjwyoLs8uGfArMnO2VlUWpHofPWryQONPN/1TExzRJgaG
 ECwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make sure that only tasks that actually coredumped may connect to the
coredump socket. This restriction may be loosened later in case
userspace processes would like to use it to generate their own
coredumps. Though it'd be wiser if userspace just exposed a separate
socket for that.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c            | 25 +++++++++++++++++++++++++
 fs/pidfs.c               | 13 +++++++++++++
 include/linux/coredump.h | 12 ++++++++++++
 include/linux/pidfs.h    |  1 +
 net/unix/af_unix.c       | 19 +++++++++++++------
 5 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a5f17aaeee32..8a9620ce4fd0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -630,6 +630,31 @@ struct sockaddr_un coredump_unix_socket = {
 #define COREDUMP_UNIX_SOCKET_ADDR_SIZE            \
 	(offsetof(struct sockaddr_un, sun_path) + \
 	 sizeof("\0linuxafsk/coredump.socket") - 1)
+
+static inline bool is_coredump_socket(const struct sockaddr_un *sunname,
+				      unsigned int len)
+{
+	return (COREDUMP_UNIX_SOCKET_ADDR_SIZE == len) &&
+	       !memcmp(&coredump_unix_socket, sunname, len);
+}
+
+/*
+ * For the coredump socket in the initial network namespace we only
+ * allow actual coredumping processes to connect to it, i.e., the kernel
+ * itself.
+ */
+bool unix_use_coredump_socket(const struct net *net, const struct pid *pid,
+			      const struct sockaddr_un *sunname,
+			      unsigned int len)
+{
+	if (net != &init_net)
+		return true;
+
+	if (!is_coredump_socket(sunname, len))
+		return true;
+
+	return pidfs_pid_coredumped(pid);
+}
 #endif
 
 void do_coredump(const kernel_siginfo_t *siginfo)
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 8c4d83fb115b..e0a4c34ddc42 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -258,6 +258,19 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
 	return 0;
 }
 
+bool pidfs_pid_coredumped(const struct pid *pid)
+{
+	struct inode *inode;
+
+	if (!pid)
+		return false;
+
+	/* We expect the caller to hold a reference to @pid->stashed. */
+	VFS_WARN_ON_ONCE(!pid->stashed);
+	inode = d_inode(pid->stashed);
+	return (READ_ONCE(pidfs_i(inode)->__pei.coredump_mask) & PIDFD_COREDUMPED);
+}
+
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 76e41805b92d..2b2f0c016c16 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -7,6 +7,8 @@
 #include <linux/fs.h>
 #include <asm/siginfo.h>
 
+struct sockaddr_un;
+
 #ifdef CONFIG_COREDUMP
 struct core_vma_metadata {
 	unsigned long start, end;
@@ -44,6 +46,9 @@ extern int dump_align(struct coredump_params *cprm, int align);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
 extern void do_coredump(const kernel_siginfo_t *siginfo);
+bool unix_use_coredump_socket(const struct net *net, const struct pid *pid,
+			      const struct sockaddr_un *sunname,
+			      unsigned int len);
 
 /*
  * Logging for the coredump code, ratelimited.
@@ -64,6 +69,13 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
 
 #else
 static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
+static inline bool unix_use_coredump_socket(const struct net *net,
+					    const struct pid *pid,
+					    const struct sockaddr_un *sunname,
+					    unsigned int len)
+{
+	return true;
+}
 
 #define coredump_report(...)
 #define coredump_report_failure(...)
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index f7729b9371bc..f9c287c0e0ff 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -14,5 +14,6 @@ extern const struct dentry_operations pidfs_dentry_operations;
 int pidfs_register_pid(struct pid *pid);
 void pidfs_get_pid(struct pid *pid);
 void pidfs_put_pid(struct pid *pid);
+bool pidfs_pid_coredumped(const struct pid *pid);
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index edc2f143f401..613cf9225381 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -101,6 +101,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <linux/coredump.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
@@ -1217,6 +1218,7 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 }
 
 static struct sock *unix_find_abstract(struct net *net,
+				       const struct pid *peer_pid,
 				       struct sockaddr_un *sunaddr,
 				       int addr_len, int type)
 {
@@ -1224,6 +1226,9 @@ static struct sock *unix_find_abstract(struct net *net,
 	struct dentry *dentry;
 	struct sock *sk;
 
+	if (!unix_use_coredump_socket(net, peer_pid, sunaddr, addr_len))
+		return ERR_PTR(-ECONNREFUSED);
+
 	sk = unix_find_socket_byname(net, sunaddr, addr_len, hash);
 	if (!sk)
 		return ERR_PTR(-ECONNREFUSED);
@@ -1236,15 +1241,16 @@ static struct sock *unix_find_abstract(struct net *net,
 }
 
 static struct sock *unix_find_other(struct net *net,
-				    struct sockaddr_un *sunaddr,
-				    int addr_len, int type)
+				    const struct pid *peer_pid,
+				    struct sockaddr_un *sunaddr, int addr_len,
+				    int type)
 {
 	struct sock *sk;
 
 	if (sunaddr->sun_path[0])
 		sk = unix_find_bsd(sunaddr, addr_len, type);
 	else
-		sk = unix_find_abstract(net, sunaddr, addr_len, type);
+		sk = unix_find_abstract(net, peer_pid, sunaddr, addr_len, type);
 
 	return sk;
 }
@@ -1500,7 +1506,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		}
 
 restart:
-		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
+		other = unix_find_other(sock_net(sk), NULL, sunaddr, alen, sock->type);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out;
@@ -1647,7 +1653,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 restart:
 	/*  Find listening sock. */
-	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
+	other = unix_find_other(net, peercred.peer_pid, sunaddr, addr_len,
+				sk->sk_type);
 	if (IS_ERR(other)) {
 		err = PTR_ERR(other);
 		goto out_free_skb;
@@ -2115,7 +2122,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	if (msg->msg_namelen) {
 lookup:
-		other = unix_find_other(sock_net(sk), msg->msg_name,
+		other = unix_find_other(sock_net(sk), NULL, msg->msg_name,
 					msg->msg_namelen, sk->sk_type);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);

-- 
2.47.2


