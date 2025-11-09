Return-Path: <linux-fsdevel+bounces-67611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B335C4474B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290703B0FB8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B912749E4;
	Sun,  9 Nov 2025 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygpmqw5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B82676DE;
	Sun,  9 Nov 2025 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722813; cv=none; b=rjUcAeDZCwv5PAf51hV58Mf9pM1SmFyaqEakS/1/BpsGzZjD3OfVrnwinctvI6eXF3wriMp5QUUsgwcKmRc8EvlToeOZcG/pmr1y4umQFw+1iDvkMdW0PimsEzSmv83LZvekGbPT6dmKo4FaqkHRhT4/XtZ6uuRH5SHMRDcAMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722813; c=relaxed/simple;
	bh=Bq9qstsnC44ddSAXmzDi/UX9dfyP5an3pKXgC51EVaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jj9mtXOzUHgCk1hVCtuyddJN4SFEv5B0Q3CExBMDqoL58P741hW7oqkGjVDnW1OuxMYRp4lpw4hJ4GhLqDv6UgOLON/8wu0oD9hMxSRGz6eUJ6MN4dHTis5En6iQvFbPPHE9el3GeTSBF0igqAHvTpZSpsVgE2zYztr8TwFD8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygpmqw5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9901C4CEF7;
	Sun,  9 Nov 2025 21:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722813;
	bh=Bq9qstsnC44ddSAXmzDi/UX9dfyP5an3pKXgC51EVaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ygpmqw5rgH8uzKl0RCQraHSu12wI6iq3rVUv/1D9eklofJqvkR1xOgtEIrLYN4SxB
	 t8yClCwocPlXroMGqujVPyc8jXxg5cog3nfnMPHcPIPegGBh0JQJPPJOESZABJaluR
	 /XWGQz6h2D+9seeFTOUEOTDI4S6WODcd+t2mdWNBmKYnuQ4vJTCs7Q5KJvW5KifrG6
	 eTwtHtlh4f4Nwm7cq9YTjHgQlVlx5eb7CbEAqhk0fCH2esPy9wk3FqG3Kw9nUR0bE3
	 L+hO96/nmQj2vZN0sf/QpbxTIFSpSJVFEc9yf7vnx/W5iNvG5/XeE9Ww4S55cAVQZL
	 4Hw22NWBVxmRw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:24 +0100
Subject: [PATCH 3/8] ns: make sure reference are dropped outside of rcu
 lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-3-ae8a4ad5a3b3@kernel.org>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3665; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Bq9qstsnC44ddSAXmzDi/UX9dfyP5an3pKXgC51EVaA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr8oVG2qbjG9w7WD4YRYwN8oVqOiW69vLPxjul53h
 +xm+fJDHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRWszwT0lFMXEJ5/crhr9u
 iJxS0NZ+J5f81q45TSWH0Txs/cYv3xgZ1rWUzle/+G1eT/PmB2vSS7Y9FY06dWfyncyoF7lzXjx
 oZwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The mount namespace may in fact sleep when putting the last passive
reference so we need to drop the namespace reference outside of the rcu
read lock. Do this by delaying the put until the next iteration where
we've already moved on to the next namespace and legitimized it. Once we
drop the rcu read lock to call put_user() we will also drop the
reference to the previous namespace in the tree.

Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 4a8838683b6b..55b72d4f8de4 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -505,13 +505,13 @@ static inline bool __must_check may_list_ns(const struct klistns *kls,
 	return false;
 }
 
-static void __ns_put(struct ns_common *ns)
+static inline void ns_put(struct ns_common *ns)
 {
-	if (ns->ops)
+	if (ns && ns->ops)
 		ns->ops->put(ns);
 }
 
-DEFINE_FREE(ns_put, struct ns_common *, if (!IS_ERR_OR_NULL(_T)) __ns_put(_T))
+DEFINE_FREE(ns_put, struct ns_common *, if (!IS_ERR_OR_NULL(_T)) ns_put(_T))
 
 static inline struct ns_common *__must_check legitimize_ns(const struct klistns *kls,
 							   struct ns_common *candidate)
@@ -535,7 +535,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
 {
 	u64 __user *ns_ids = kls->uns_ids;
 	size_t nr_ns_ids = kls->nr_ns_ids;
-	struct ns_common *ns = NULL, *first_ns = NULL;
+	struct ns_common *ns = NULL, *first_ns = NULL, *prev = NULL;
 	const struct list_head *head;
 	ssize_t ret;
 
@@ -568,9 +568,10 @@ static ssize_t do_listns_userns(struct klistns *kls)
 
 	if (!first_ns)
 		first_ns = list_entry_rcu(head->next, typeof(*ns), ns_owner_entry);
+
 	for (ns = first_ns; &ns->ns_owner_entry != head && nr_ns_ids;
 	     ns = list_entry_rcu(ns->ns_owner_entry.next, typeof(*ns), ns_owner_entry)) {
-		struct ns_common *valid __free(ns_put);
+		struct ns_common *valid;
 
 		valid = legitimize_ns(kls, ns);
 		if (!valid)
@@ -578,8 +579,14 @@ static ssize_t do_listns_userns(struct klistns *kls)
 
 		rcu_read_unlock();
 
-		if (put_user(valid->ns_id, ns_ids + ret))
+		ns_put(prev);
+		prev = valid;
+
+		if (put_user(valid->ns_id, ns_ids + ret)) {
+			ns_put(prev);
 			return -EINVAL;
+		}
+
 		nr_ns_ids--;
 		ret++;
 
@@ -587,6 +594,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
 	}
 
 	rcu_read_unlock();
+	ns_put(prev);
 	return ret;
 }
 
@@ -668,7 +676,7 @@ static ssize_t do_listns(struct klistns *kls)
 {
 	u64 __user *ns_ids = kls->uns_ids;
 	size_t nr_ns_ids = kls->nr_ns_ids;
-	struct ns_common *ns, *first_ns = NULL;
+	struct ns_common *ns, *first_ns = NULL, *prev = NULL;
 	struct ns_tree *ns_tree = NULL;
 	const struct list_head *head;
 	u32 ns_type;
@@ -705,7 +713,7 @@ static ssize_t do_listns(struct klistns *kls)
 
 	for (ns = first_ns; !ns_common_is_head(ns, head, ns_tree) && nr_ns_ids;
 	     ns = next_ns_common(ns, ns_tree)) {
-		struct ns_common *valid __free(ns_put);
+		struct ns_common *valid;
 
 		valid = legitimize_ns(kls, ns);
 		if (!valid)
@@ -713,8 +721,13 @@ static ssize_t do_listns(struct klistns *kls)
 
 		rcu_read_unlock();
 
-		if (put_user(valid->ns_id, ns_ids + ret))
+		ns_put(prev);
+		prev = valid;
+
+		if (put_user(valid->ns_id, ns_ids + ret)) {
+			ns_put(prev);
 			return -EINVAL;
+		}
 
 		nr_ns_ids--;
 		ret++;
@@ -723,6 +736,7 @@ static ssize_t do_listns(struct klistns *kls)
 	}
 
 	rcu_read_unlock();
+	ns_put(prev);
 	return ret;
 }
 

-- 
2.47.3


