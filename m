Return-Path: <linux-fsdevel+bounces-62103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF2B84010
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC70B6259D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6702F6195;
	Thu, 18 Sep 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm/orFue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82E286D63;
	Thu, 18 Sep 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190363; cv=none; b=CIUq14VBD/FMLSN7+SADsowSoIiMCQUaRQAvr35l/qZuY9KMppnVhr6BbJuulsnzYA1mbJsZXDgojC5TA/55kcTY8BnBm59O8O7sD7qPkYgnvSeEaLKyzf/vufJI6+vb/rMJDH7A6JpuNYD/WaAkzOtUDXW47NikaQoenZUWHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190363; c=relaxed/simple;
	bh=uIMSsnAHpbWVr4ui+E6CVDbYyiFvAOabEJHQhnFAdhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghqr4ZB3C0m7xLQ43uL9YQbuVFKsrIg6nQ637gsqGZA5Q7G/+IZXLmpWntNgoBr6Yj887639sMlevJDNKBghTrL6ECinLaFCRCIT8swKL8O15l7wyRP1AK9PrsigLHkAL9GK5fZ4CDBRqc9f59yYpoZgl7VlY1LjtTEvByaaFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm/orFue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF46AC4CEE7;
	Thu, 18 Sep 2025 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190362;
	bh=uIMSsnAHpbWVr4ui+E6CVDbYyiFvAOabEJHQhnFAdhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dm/orFuerIhBd0+fZDV4YCNTfqwx55BB3XDRJ8gUyXb6PwUfN9WXQkmgrxnpxhqCD
	 XAwp1oDUVwtkh/9WOTf5Zi86OUb9nYLS2UkYok4Pms7F5qH+/mcJj+9186ukWBE5fz
	 Zuld4zoDaQ1NGxfmqMsCw1JdoIt9iZTq5kcuQvHKbEbPKfPnB6BWfy+aTVz0pLPUYq
	 8yrBf2fyBZAnK/xsX7t1N9Sq/SrrZGWsNXCDyPvOtI38UO9kzts9mtjMonSE162M/a
	 ShDHW6yhEd0EHSoBj83V/1KgY9PL9MelFBwXfs9lEEYI6SmLSbuTMom5oPmJmwyzr1
	 avpy//fwTTVZg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:55 +0200
Subject: [PATCH 10/14] ipv4: use check_net()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-10-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uIMSsnAHpbWVr4ui+E6CVDbYyiFvAOabEJHQhnFAdhg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvVMeFrb6jtJN86ufvB9zWIdf6ONsYxyT79nZJol7
 1LSsLM70lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRND9GhttVnpzW24VZ7NqU
 1y45bzJxgUn8oZJQkQdmjQFmYt+K4xkZtqfPufEnxePWFdnuy3Xnrs69H5ibdjc5VEb5oYC7sak
 fHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't directly acess the namespace count. There's even a dedicated
helper for this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/ipv4/inet_timewait_sock.c | 4 ++--
 net/ipv4/tcp_metrics.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 875ff923a8ed..56a117560c0c 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -329,13 +329,13 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 					     TCPF_NEW_SYN_RECV))
 				continue;
 
-			if (refcount_read(&sock_net(sk)->ns.count))
+			if (check_net(sock_net(sk)))
 				continue;
 
 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				continue;
 
-			if (refcount_read(&sock_net(sk)->ns.count)) {
+			if (check_net(sock_net(sk))) {
 				sock_gen_put(sk);
 				goto restart;
 			}
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 03c068ea27b6..b67f94c60f9f 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -912,7 +912,7 @@ static void tcp_metrics_flush_all(struct net *net)
 		spin_lock_bh(&tcp_metrics_lock);
 		for (tm = deref_locked(*pp); tm; tm = deref_locked(*pp)) {
 			match = net ? net_eq(tm_net(tm), net) :
-				!refcount_read(&tm_net(tm)->ns.count);
+				!check_net(tm_net(tm));
 			if (match) {
 				rcu_assign_pointer(*pp, tm->tcpm_next);
 				kfree_rcu(tm, rcu_head);

-- 
2.47.3


