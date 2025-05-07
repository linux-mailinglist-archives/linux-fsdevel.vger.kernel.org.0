Return-Path: <linux-fsdevel+bounces-48400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3525AAE653
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E395240F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7328CF7E;
	Wed,  7 May 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2QrKJDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872B28B7FD;
	Wed,  7 May 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634444; cv=none; b=DZmg4Qdvyq8zc+QphwJpO+HR4yUAQwKejvMJIJZg05bQ8KFLsIcLefbZ1kt9c5Fu4GIQvvYgcWdR2lyKg7/QDP1uFMIvmnXwGkKaM0UHxEm6zbEucH/HSqBNsRzkTLRB7pWcZwYwxbU4TTSpx/MSDjWhdmU9jLnHYXxOPDfDf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634444; c=relaxed/simple;
	bh=6J3+jrH8mLatCxA+26NtJ7WY3BN4ZJ2WICN0zEMs5IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxxFBpdcqP/Cfx2c1e9MRYRyXUDelSFV+Dr5ybjAaxniLhOiH+2ihNovyD8AvAHCVL3ZLal550Uaf13oP7p1Tca5HU/d7epPWlqLPX14ynstVkdrLSMS34j/tUSUNTnNQqlTeLRSzk16Gw9HVtJsxWBYNceov/yZNALb+53IwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2QrKJDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF4AC4CEE2;
	Wed,  7 May 2025 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634444;
	bh=6J3+jrH8mLatCxA+26NtJ7WY3BN4ZJ2WICN0zEMs5IE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o2QrKJDuR/ZGZkE/LfJdLcIIS/yYUihQhuNTFg1fw55MATOaDR8PpJ0oT/B28/XSa
	 gOBoMZWAGblA+Sx2z92HTcJ9G8/YIq0mD7OiiA2oEuUHKXlpj1vfcobf/3va2cSe01
	 9MIBg6eAvTnQygya/vNThN3PMpU9TcsVyZO9accKgFUHEfIGZ0ywD7M/5QV3C/bDrw
	 3F927yjPfVHdGpPmSP1YkbLNzOlQYTFERIrUkgYBZ5HB02i5pVBftkMopf98erf/nr
	 686U8WsIZgoTUP7VCJuqrAIZu0IzzPK+ZWgxvYhUNPbP+QWyYcxBvFXWR7ZS7T+/d1
	 mw8tplQHM1XWQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:37 +0200
Subject: [PATCH v4 04/11] net: reserve prefix
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-4-af0ef317b2d0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4000; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6J3+jrH8mLatCxA+26NtJ7WY3BN4ZJ2WICN0zEMs5IE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt2394+H4NHb1vOXct9kWnu++5NtrouDsvL/X8PwHq
 4ufF/Ws6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIcRTDH15Ne2e1idPfhvMV
 a/Ynffx1bVKYL9OHn4sOaf/8Nm32Sm6G/4WavWJNrEvf9/cFT9yhJ775wu5EocmF2VeMJ/IJ6ab
 x8QIA
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
 net/unix/af_unix.c      | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

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
index 472f8aa9ea15..148d008862e7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -114,6 +114,13 @@ static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
 static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
 
+static const struct sockaddr_un linuxafsk_addr = {
+	.sun_family = AF_UNIX,
+	.sun_path = "\0"UNIX_SOCKET_NAMESPACE,
+};
+
+#define UNIX_SOCKET_NAMESPACE_ADDR_LEN (offsetof(struct sockaddr_un, sun_path) + sizeof(UNIX_SOCKET_NAMESPACE))
+
 /* SMP locking strategy:
  *    hash table is protected with spinlock.
  *    each socket state is protected by separate spinlock.
@@ -436,6 +443,30 @@ static struct sock *__unix_find_socket_byname(struct net *net,
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
+	if (UNIX_SOCKET_NAMESPACE_ADDR_LEN <= len &&
+	    !memcmp(&linuxafsk_addr, sunname, UNIX_SOCKET_NAMESPACE_ADDR_LEN)) {
+		/* Don't bind the namespace itself. */
+		if (UNIX_SOCKET_NAMESPACE_ADDR_LEN == len)
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
@@ -1258,10 +1289,10 @@ static int unix_autobind(struct sock *sk)
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
@@ -1379,7 +1410,8 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
-	if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash))
+	err = unix_may_bind_name(net, addr->name, addr->len, new_hash);
+	if (err)
 		goto out_spin;
 
 	__unix_set_addr_hash(net, sk, addr, new_hash);
@@ -1389,7 +1421,6 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 
 out_spin:
 	unix_table_double_unlock(net, old_hash, new_hash);
-	err = -EADDRINUSE;
 out_mutex:
 	mutex_unlock(&u->bindlock);
 out:

-- 
2.47.2


