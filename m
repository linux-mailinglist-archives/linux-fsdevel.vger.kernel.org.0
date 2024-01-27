Return-Path: <linux-fsdevel+bounces-9184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091FE83E9A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2581F2B6F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081291E88F;
	Sat, 27 Jan 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qJ+Rs5He"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DD171AB
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321328; cv=none; b=QV6ZGvObJ+WEJYyq8BM+8TOpReVLh0fZBsG2chq3gix1tVJNusNquqTNOkgyZ8zDjw8uHU10K3UxDd+c/s8eRbss8NOcj58Amz8MaWh/JzPm2amumxCvb3buc3f52EcJMS/NJaHrTJcQsZgpVTGECu2jIqPokbcCD7j2U3zkSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321328; c=relaxed/simple;
	bh=WEGpc0xxaxj2AY+Xn8ROwEZelU+zXk/EivX8ekFZmeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WM3HiLZvkWcgYXV48scmJOUGI2kjehlbu8GM/i+QfkUUOgm9+qBahJwvu22OC3d7yhRr8QEVsnwo3GfG4d0oQ1M/e4/lHI6xLYe7I6X7ooFS3EJ25v0QD0OXuIWy3waNIiHlwHo9YF8a72sGKPFXr+YTPDRZe4CPXYkV3QhigNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qJ+Rs5He; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706321324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLB5skfy3BEv0JbsXyQzZFD+57i+sZEpeM1MJI3SUiw=;
	b=qJ+Rs5Hetw76AhWzqkBqPEZ/rwuaoaVg6aS11PxBaqriW5WPXxSENcSnZNZXM1c6eVbqmM
	HjfsYmTkTsHI6SIAhoLt7RahUYWkpTQ2q28spAAEQ3SMoy/8FpcbppN6VBQqYXblzzV86c
	YEZMI0JmVQa5R1JwUH/xLTa6AQ/1YSA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com
Subject: [PATCH 4/4] af_unix: convert to lock_cmp_fn
Date: Fri, 26 Jan 2024 21:08:31 -0500
Message-ID: <20240127020833.487907-5-kent.overstreet@linux.dev>
In-Reply-To: <20240127020833.487907-1-kent.overstreet@linux.dev>
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Kill
 - unix_state_lock_nested
 - _nested usage for net->unx.table.locks[].

replace both with lock_set_cmp_fn_ptr_order(&u->lock).

The lock ordering in sk_diag_dump_icons() looks suspicious; this may
turn up a real issue.

Cc: netdev@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/net/af_unix.h |  3 ---
 net/unix/af_unix.c    | 20 ++++++++------------
 net/unix/diag.c       |  2 +-
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 49c4640027d8..4eff0a089640 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -48,9 +48,6 @@ struct scm_stat {
 
 #define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
 #define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-#define unix_state_lock_nested(s) \
-				spin_lock_nested(&unix_sk(s)->lock, \
-				SINGLE_DEPTH_NESTING)
 
 /* The AF_UNIX socket */
 struct unix_sock {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d013de3c5490..1a0d273799c1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -170,7 +170,7 @@ static void unix_table_double_lock(struct net *net,
 		swap(hash1, hash2);
 
 	spin_lock(&net->unx.table.locks[hash1]);
-	spin_lock_nested(&net->unx.table.locks[hash2], SINGLE_DEPTH_NESTING);
+	spin_lock(&net->unx.table.locks[hash2]);
 }
 
 static void unix_table_double_unlock(struct net *net,
@@ -997,6 +997,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
+	lock_set_cmp_fn_ptr_order(&u->lock);
 	atomic_long_set(&u->inflight, 0);
 	INIT_LIST_HEAD(&u->link);
 	mutex_init(&u->iolock); /* single task reading lock */
@@ -1340,17 +1341,11 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 
 static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
 {
-	if (unlikely(sk1 == sk2) || !sk2) {
-		unix_state_lock(sk1);
-		return;
-	}
-	if (sk1 < sk2) {
+	if (sk1 > sk2)
+		swap(sk1, sk2);
+	if (sk1 && sk1 != sk2)
 		unix_state_lock(sk1);
-		unix_state_lock_nested(sk2);
-	} else {
-		unix_state_lock(sk2);
-		unix_state_lock_nested(sk1);
-	}
+	unix_state_lock(sk2);
 }
 
 static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
@@ -1591,7 +1586,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk);
+	unix_state_lock(sk);
 
 	if (sk->sk_state != st) {
 		unix_state_unlock(sk);
@@ -3575,6 +3570,7 @@ static int __net_init unix_net_init(struct net *net)
 
 	for (i = 0; i < UNIX_HASH_SIZE; i++) {
 		spin_lock_init(&net->unx.table.locks[i]);
+		lock_set_cmp_fn_ptr_order(&net->unx.table.locks[i]);
 		INIT_HLIST_HEAD(&net->unx.table.buckets[i]);
 	}
 
diff --git a/net/unix/diag.c b/net/unix/diag.c
index bec09a3a1d44..8ab5e2217e4c 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -84,7 +84,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 			 * queue lock. With the other's queue locked it's
 			 * OK to lock the state.
 			 */
-			unix_state_lock_nested(req);
+			unix_state_lock(req);
 			peer = unix_sk(req)->peer;
 			buf[i++] = (peer ? sock_i_ino(peer) : 0);
 			unix_state_unlock(req);
-- 
2.43.0


