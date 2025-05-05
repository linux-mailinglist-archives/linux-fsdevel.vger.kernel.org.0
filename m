Return-Path: <linux-fsdevel+bounces-48056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDAAA91BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FF17700F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24461204680;
	Mon,  5 May 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGuXjLIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95320299B;
	Mon,  5 May 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443649; cv=none; b=Gnql+xQFTlTo8NHy3K9iV9Kad9VZn2gfZl4SDfmDvXBLbdcmiJjLAOwb+zhm3Pl4r1UvdcBp5sHJkBjSkp7votISZmTTK6cD10iKHaRqa65+8so/EuaOrWruNBmEQdTtdwmv3vFojIyRxLA9HU191VHs0nbM39zqzgLrwx9qIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443649; c=relaxed/simple;
	bh=M/nfP+nWzNfyDS+hsdkqduv5bjH+2u+KfH7py/tn25g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxXrlXt7F1FSwtYzRjiQnWcuxauDfL6WrQXnanHN6Jc3A2Utg2uVNxOiPYOQvcB2pdKLlbEcda3FollcmaO2hBDBlgRPcm8CJ62ag7rlHiUKzgF8tAVJ4IkTfntJFHHfHaThUwjGylw8+GbtraxZRm/rbnWZlZ+jm8ltz+g0S4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGuXjLIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1741C4CEF0;
	Mon,  5 May 2025 11:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443648;
	bh=M/nfP+nWzNfyDS+hsdkqduv5bjH+2u+KfH7py/tn25g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kGuXjLIAaTGgKQhAsYkggP5Gp9Jg0WaL2xqiiIQ51kL+kpyxIT6EBqdFPX8z5oyWo
	 s3UuUuj/gZz3fXGIHYI5i4bgyrdR/awg+Q8VZRp4p1q5vjUJOKlRVR3rqDmln+gUio
	 sPHGHmI6XY7LcvrdLeW31c+dB3oulmKBr3RUSTONNKG1oOwnfzAMldzDRxkz5P8AJ3
	 lKstb2sTwtFZZIhcHfjk+faDgq7jHrjCI6jkpldk/XIJKsgVRA4gYApvd4aAsXelCI
	 Y2oUt+jVqdTa6PD42dJs3m3nGg5DoZdFVLJ1GyEYHyCSOBwno8ZztUo6FVMBZ9f8z/
	 LgOVKU8yCTAxg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:41 +0200
Subject: [PATCH RFC v3 03/10] net: reserve prefix
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-work-coredump-socket-v3-3-e1832f0e1eae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4545; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M/nfP+nWzNfyDS+hsdkqduv5bjH+2u+KfH7py/tn25g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIzM3T0P3D/IQ7IHliiLiy8M3fm7pbY2UrJpqdulfwX
 NllT0VPRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETq2hj+u7JHZ22bcbfOO9ho
 r7BAXsu39XFmETXKJk/elk9LabEJZ2S47seeb62Q77BP03Hipptnf1fOO7m1fufD7sPPtE6a7H7
 OBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add the reserved "linuxafsk/" prefix for AF_UNIX sockets and require
CAP_NET_ADMIN in the owning user namespace of the network namespace to
bind it. This will be used in next patches to support the coredump
socket but is a generally useful concept.

The collision risk is so low that we can just start using it. Userspace
must already be prepared to retry if a given abstract address isn't
usable anyway.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/un.h |  2 ++
 net/unix/af_unix.c      | 45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/un.h b/include/uapi/linux/un.h
index 0ad59dc8b686..bbd5ad508dfa 100644
--- a/include/uapi/linux/un.h
+++ b/include/uapi/linux/un.h
@@ -5,6 +5,8 @@
 #include <linux/socket.h>
 
 #define UNIX_PATH_MAX	108
+/* reserved AF_UNIX socket namespace. */
+#define UNIX_SOCKET_NAMESPACE "linuxafsk/"
 
 struct sockaddr_un {
 	__kernel_sa_family_t sun_family; /* AF_UNIX */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 472f8aa9ea15..edc2f143f401 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -114,6 +114,9 @@ static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
 static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
 
+static struct sockaddr_un linuxafsk_addr;
+static size_t linuxafsk_addr_len;
+
 /* SMP locking strategy:
  *    hash table is protected with spinlock.
  *    each socket state is protected by separate spinlock.
@@ -436,6 +439,30 @@ static struct sock *__unix_find_socket_byname(struct net *net,
 	return NULL;
 }
 
+static int unix_may_bind_name(struct net *net, struct sockaddr_un *sunname,
+			      int len, unsigned int hash)
+{
+	struct sock *s;
+
+	s = __unix_find_socket_byname(net, sunname, len, hash);
+	if (s)
+		return -EADDRINUSE;
+
+	/*
+	 * Check whether this is our reserved prefix and if so ensure
+	 * that only privileged processes can bind it.
+	 */
+	if (linuxafsk_addr_len <= len &&
+	    !memcmp(&linuxafsk_addr, sunname, linuxafsk_addr_len)) {
+		/* Don't bind the namespace itself. */
+		if (linuxafsk_addr_len == len)
+			return -ECONNREFUSED;
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -ECONNREFUSED;
+	}
+	return 0;
+}
+
 static inline struct sock *unix_find_socket_byname(struct net *net,
 						   struct sockaddr_un *sunname,
 						   int len, unsigned int hash)
@@ -1258,10 +1285,10 @@ static int unix_autobind(struct sock *sk)
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
-	if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash)) {
+	if (unix_may_bind_name(net, addr->name, addr->len, new_hash)) {
 		unix_table_double_unlock(net, old_hash, new_hash);
 
-		/* __unix_find_socket_byname() may take long time if many names
+		/* unix_may_bind_name() may take long time if many names
 		 * are already in use.
 		 */
 		cond_resched();
@@ -1379,7 +1406,8 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
-	if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash))
+	err = unix_may_bind_name(net, addr->name, addr->len, new_hash);
+	if (err)
 		goto out_spin;
 
 	__unix_set_addr_hash(net, sk, addr, new_hash);
@@ -1389,7 +1417,6 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 
 out_spin:
 	unix_table_double_unlock(net, old_hash, new_hash);
-	err = -EADDRINUSE;
 out_mutex:
 	mutex_unlock(&u->bindlock);
 out:
@@ -3841,6 +3868,16 @@ static int __init af_unix_init(void)
 
 	BUILD_BUG_ON(sizeof(struct unix_skb_parms) > sizeof_field(struct sk_buff, cb));
 
+	/*
+	 * We need a leading NUL byte for the abstract namespace. Just
+	 * use the trailing one given by sizeof().
+	 */
+	linuxafsk_addr_len = offsetof(struct sockaddr_un, sun_path) + sizeof(UNIX_SOCKET_NAMESPACE);
+	linuxafsk_addr.sun_family = AF_UNIX;
+	memcpy(linuxafsk_addr.sun_path + 1, UNIX_SOCKET_NAMESPACE, sizeof(UNIX_SOCKET_NAMESPACE) - 1);
+	/* Technically not needed, but let's be explicit. */
+	linuxafsk_addr.sun_path[0] = '\0';
+
 	for (i = 0; i < UNIX_HASH_SIZE / 2; i++) {
 		spin_lock_init(&bsd_socket_locks[i]);
 		INIT_HLIST_HEAD(&bsd_socket_buckets[i]);

-- 
2.47.2


