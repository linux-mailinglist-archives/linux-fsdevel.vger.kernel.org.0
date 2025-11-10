Return-Path: <linux-fsdevel+bounces-67704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40964C476F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C3B18927FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421E731D725;
	Mon, 10 Nov 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWE1emrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846031619C;
	Mon, 10 Nov 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787358; cv=none; b=I1xoVeqgrEQMY8AdLHI923+/b9nBxlvmy9lzs0Tgc7IgI4LnmsEaaOc9VhhGhwC/gyRjZzdzAbmHxD5nLOwvp5hrCjzI06Q3/rjeyigK6lSUGUgMVFheXwB+psUGCLWG6Zzm5cHgPUDeg3Kpqs22IlMhdTy19vsPPSCp7mav2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787358; c=relaxed/simple;
	bh=t2FpzbmvR+LL/NlBK6vZNdNb6tFZnEAVirEnC6iVTts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hadZB5OBuW1JHapX6JAGmUaadn0gcAolbq2BPLfiBPV5kYH8B+E/qsMJ0t5QruGEi5srFs36eQXucrcFxNj/Bf635q1mzrltXgJdF6THOaZIYebtsNEVdB4lxCOECB3iAt5Wq5/hAiJGZkvQQTaNTQOt8uy2HILdeCB0KZj8Jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWE1emrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD7C4CEF5;
	Mon, 10 Nov 2025 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787358;
	bh=t2FpzbmvR+LL/NlBK6vZNdNb6tFZnEAVirEnC6iVTts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GWE1emrK9S2/86uaqa7thy3IHMwRNMIh3HiQjV/vbLpxrGdviZvz9QdshplSRNRQ/
	 6xzmbiGb3y6OA3hEy007FHr7vb8lLJwxoiv9GYk+QJjBNlUJ3EafxG1WZ4FEpPkZsS
	 vrUKIWmK96bA7lrQvCcWRQOfGj6h33gF0iwSf7SXNzRWaehlSYses4pgtyrisTUFIB
	 6Oe57wN01mcZUA2KrN0HC91mKLlKWMo+3ulwKwZ8Bm/xkjvYOEwtkGIQkUih2vWqY9
	 HVYm691HbKBmelAAv8TDt4GtmNH1TdcVn7lA0eIxq7boVFKtkp5UgC+jdDf/RtJym2
	 E5h9YI6SFAhAA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:19 +0100
Subject: [PATCH 07/17] nstree: use guards for ns_tree_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-7-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t2FpzbmvR+LL/NlBK6vZNdNb6tFZnEAVirEnC6iVTts=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v98vkBt3fSu9tcdLceXtLpfODr/dcxzw/DVd29Mm
 e9yYYmnW0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETMQZGe5ULbiZL3o/vO3j
 5KLYqRybeUOe3VlYPNt7fYWK5RtzRn9Ghv7ZOgcCb712ct+9XU72yvlkrqy4VYl2U/5xHL4uolr
 RyAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make use of the guard infrastructure for ns_tree_lock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 476dd738d653..5270e0fa67a2 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -10,6 +10,14 @@
 
 static __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
 
+DEFINE_LOCK_GUARD_0(ns_tree_writer,
+		    write_seqlock(&ns_tree_lock),
+		    write_sequnlock(&ns_tree_lock))
+
+DEFINE_LOCK_GUARD_0(ns_tree_locked_reader,
+		    read_seqlock_excl(&ns_tree_lock),
+		    read_sequnlock_excl(&ns_tree_lock))
+
 static struct ns_tree_root ns_unified_root = { /* protected by ns_tree_lock */
 	.ns_rb = RB_ROOT,
 	.ns_list_head = LIST_HEAD_INIT(ns_unified_root.ns_list_head),
@@ -193,7 +201,7 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree)
 
 	VFS_WARN_ON_ONCE(!ns->ns_id);
 
-	write_seqlock(&ns_tree_lock);
+	guard(ns_tree_writer)();
 
 	/* Add to per-type tree and list */
 	node = ns_tree_node_add(&ns->ns_tree_node, ns_tree, ns_cmp);
@@ -218,7 +226,6 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree)
 			VFS_WARN_ON_ONCE(ns != to_ns_common(&init_user_ns));
 		}
 	}
-	write_sequnlock(&ns_tree_lock);
 
 	VFS_WARN_ON_ONCE(node);
 }
@@ -461,9 +468,9 @@ static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
 
 	VFS_WARN_ON_ONCE(owner->ns_type != CLONE_NEWUSER);
 
-	read_seqlock_excl(&ns_tree_lock);
-	node = owner->ns_owner_root.ns_rb.rb_node;
+	guard(ns_tree_locked_reader)();
 
+	node = owner->ns_owner_root.ns_rb.rb_node;
 	while (node) {
 		struct ns_common *ns;
 
@@ -480,7 +487,6 @@ static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
 
 	if (ret)
 		ret = ns_get_unless_inactive(ret);
-	read_sequnlock_excl(&ns_tree_lock);
 	return ret;
 }
 
@@ -648,7 +654,8 @@ static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
 			return NULL;
 	}
 
-	read_seqlock_excl(&ns_tree_lock);
+	guard(ns_tree_locked_reader)();
+
 	if (ns_tree)
 		node = ns_tree->ns_rb.rb_node;
 	else
@@ -677,7 +684,6 @@ static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
 
 	if (ret)
 		ret = ns_get_unless_inactive(ret);
-	read_sequnlock_excl(&ns_tree_lock);
 	return ret;
 }
 

-- 
2.47.3


