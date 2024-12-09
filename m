Return-Path: <linux-fsdevel+bounces-36804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D09E97BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3191888A3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE31A238E;
	Mon,  9 Dec 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK4igdah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A71ACEA3
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752030; cv=none; b=Ct+O8Sq9J0bSK4+jkLgM5dpQNXlERYaRV3ErIdNMJWnNXtFKShnWKn6Zam+GT0QpMhGKIrWl8qUqvNKR+7j8g5OENM9xbx/YwqB02AHIRQxHEmoKz7av91/F4LYmjMjRbZXhoDiyKXKZvj32r9jrsBEHk1PWP+zOfON+NEfQpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752030; c=relaxed/simple;
	bh=HN/6pH0bDhtapHp61g29TgiirpAyv/VHkbKmYYVptS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSL4Kcwx4zSG/kM/5S0gMrEf6t1LcDx9pXj7USL3X+d1jU9kt/SUsfE8s9ts4Nd+KRbfrTYmeSipPJKK1ziM/jEcb0a0O96B2HreaZqte4+nE6dS/XOV+CVEBVk3lGEH4Z9eNw1snoNjKm2whVXXqDqVT3wxmhgjin1VgU4bqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK4igdah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4BAC4CEDD;
	Mon,  9 Dec 2024 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733752029;
	bh=HN/6pH0bDhtapHp61g29TgiirpAyv/VHkbKmYYVptS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NK4igdahLFssy5R4T0IEdXbewcehtrgll2jXxjQdIn/6jsJpIcYKqco/6Sy3YkirY
	 o7qhvb58XADVA8uacHuHaITT1gMbJ6tGmJHqWIOMSYtf7JyR+GXMv/1+esiuWroKRZ
	 pSfPQeQP2YaCVWJmum9vEYEsNeRyTtAPGDd6iIUhE2ShwLzIcB+7rmDmBjPQbnvym3
	 BodGg+I+4ou8mhoki9BRGdwpSAEqGlJjYJCSTWSvnbxiPt4d4qzu7lsvdOjN24wJXz
	 tQVr6Shn0RUID8kiWTXHTtXI0dh5oDty45W6ffaEumtL0KT751qSoE238dRlA5+EfG
	 idgzfMq/Bg8Bg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 09 Dec 2024 14:46:58 +0100
Subject: [PATCH RFC v2 2/2] pidfs: use maple tree
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-work-pidfs-maple_tree-v2-2-003dbf3bd96b@kernel.org>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
In-Reply-To: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6621; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HN/6pH0bDhtapHp61g29TgiirpAyv/VHkbKmYYVptS8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSHfbnhEuvB1//e5kXykjLt2/az0+bbO//e8u6VV8VUl
 rernNwvdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkRpyR4ciqzuXX6ibGKGry
 Mq12u+DJfCW7JubIkpSUyH+Pbta9lGP4K+ncp/1TUd2i+ufxnXk6rTx+2y3+Hi1nnpzgOtsqbUc
 yEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So far we've been using an idr to track pidfs inodes. For some time now
each struct pid has a unique 64bit value that is used as the inode
number on 64 bit. That unique inode couldn't be used for looking up a
specific struct pid though.

Now that we support file handles we need this ability while avoiding to
leak actual pid identifiers into userspace which can be problematic in
containers.

So far I had used an idr-based mechanism where the idr is used to
generate a 32 bit number and each time it wraps we increment an upper
bit value and generate a unique 64 bit value. The lower 32 bits are used
to lookup the pid.

I've been looking at the maple tree because it now has
mas_alloc_cyclic(). Since it uses unsigned long it would simplify the
64bit implementation and its dense node mode supposedly also helps to
mitigate fragmentation.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c   | 52 +++++++++++++++++++++++++++++++---------------------
 kernel/pid.c | 34 +++++++++++++++++-----------------
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7a1d606b09d7b315e780c81fc7341f4ec82f2639..4a622f906fc210d5e81ba2ac856cfe0ca930f219 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -19,14 +19,15 @@
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
 #include <linux/utsname.h>
+#include <linux/maple_tree.h>
 #include <net/net_namespace.h>
 
 #include "internal.h"
 #include "mount.h"
 
-static DEFINE_IDR(pidfs_ino_idr);
-
-static u32 pidfs_ino_upper_32_bits = 0;
+static struct maple_tree pidfs_ino_mtree = MTREE_INIT(pidfs_ino_mtree,
+						      MT_FLAGS_ALLOC_RANGE |
+						      MT_FLAGS_LOCK_IRQ);
 
 #if BITS_PER_LONG == 32
 /*
@@ -34,8 +35,6 @@ static u32 pidfs_ino_upper_32_bits = 0;
  * the higher 32 bits are the generation number. The starting
  * value for the inode number and the generation number is one.
  */
-static u32 pidfs_ino_lower_32_bits = 1;
-
 static inline unsigned long pidfs_ino(u64 ino)
 {
 	return lower_32_bits(ino);
@@ -49,8 +48,6 @@ static inline u32 pidfs_gen(u64 ino)
 
 #else
 
-static u32 pidfs_ino_lower_32_bits = 0;
-
 /* On 64 bit simply return ino. */
 static inline unsigned long pidfs_ino(u64 ino)
 {
@@ -71,30 +68,43 @@ static inline u32 pidfs_gen(u64 ino)
  */
 int pidfs_add_pid(struct pid *pid)
 {
-	u32 upper;
-	int lower;
+	static unsigned long lower_next = 0;
+	static u32 pidfs_ino_upper_32_bits = 0;
+	unsigned long lower;
+	int ret;
+	MA_STATE(mas, &pidfs_ino_mtree, 0, 0);
 
         /*
 	 * Inode numbering for pidfs start at 2. This avoids collisions
 	 * with the root inode which is 1 for pseudo filesystems.
          */
-	lower = idr_alloc_cyclic(&pidfs_ino_idr, pid, 2, 0, GFP_ATOMIC);
-	if (lower >= 0 && lower < pidfs_ino_lower_32_bits)
-		pidfs_ino_upper_32_bits++;
-	upper = pidfs_ino_upper_32_bits;
-	pidfs_ino_lower_32_bits = lower;
-	if (lower < 0)
-		return lower;
-
-	pid->ino = ((u64)upper << 32) | lower;
+	mtree_lock(&pidfs_ino_mtree);
+	ret = mas_alloc_cyclic(&mas, &lower, pid, 2, ULONG_MAX, &lower_next,
+			       GFP_KERNEL);
+	if (ret < 0)
+		goto out_unlock;
+
+#if BITS_PER_LONG == 32
+	if (ret == 1) {
+		u32 higher;
+
+		if (check_add_overflow(pidfs_ino_upper_32_bits, 1, &higher))
+			goto out_unlock;
+		pidfs_ino_upper_32_bits = higher;
+	}
+#endif
+	pid->ino = ((u64)pidfs_ino_upper_32_bits << 32) | lower;
 	pid->stashed = NULL;
-	return 0;
+
+out_unlock:
+	mtree_unlock(&pidfs_ino_mtree);
+	return ret;
 }
 
 /* The idr number to remove is the lower 32 bits of the inode. */
 void pidfs_remove_pid(struct pid *pid)
 {
-	idr_remove(&pidfs_ino_idr, lower_32_bits(pid->ino));
+	mtree_erase(&pidfs_ino_mtree, pidfs_ino(pid->ino));
 }
 
 #ifdef CONFIG_PROC_FS
@@ -522,7 +532,7 @@ static struct pid *pidfs_ino_get_pid(u64 ino)
 
 	guard(rcu)();
 
-	pid = idr_find(&pidfs_ino_idr, lower_32_bits(pid_ino));
+	pid = mtree_load(&pidfs_ino_mtree, pid_ino);
 	if (!pid)
 		return NULL;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 6131543e7c090c164a2bac014f8eeee61926b13d..28100bbac4c130e192abf65d88cca9d330971c5c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -131,6 +131,8 @@ void free_pid(struct pid *pid)
 	int i;
 	unsigned long flags;
 
+	pidfs_remove_pid(pid);
+
 	spin_lock_irqsave(&pidmap_lock, flags);
 	for (i = 0; i <= pid->level; i++) {
 		struct upid *upid = pid->numbers + i;
@@ -152,7 +154,6 @@ void free_pid(struct pid *pid)
 		}
 
 		idr_remove(&ns->idr, upid->nr);
-		pidfs_remove_pid(pid);
 	}
 	spin_unlock_irqrestore(&pidmap_lock, flags);
 
@@ -249,16 +250,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		tmp = tmp->parent;
 	}
 
-	/*
-	 * ENOMEM is not the most obvious choice especially for the case
-	 * where the child subreaper has already exited and the pid
-	 * namespace denies the creation of any new processes. But ENOMEM
-	 * is what we have exposed to userspace for a long time and it is
-	 * documented behavior for pid namespaces. So we can't easily
-	 * change it even if there were an error code better suited.
-	 */
-	retval = -ENOMEM;
-
 	get_pid_ns(ns);
 	refcount_set(&pid->count, 1);
 	spin_lock_init(&pid->lock);
@@ -269,12 +260,23 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	INIT_HLIST_HEAD(&pid->inodes);
 
 	upid = pid->numbers + ns->level;
-	idr_preload(GFP_KERNEL);
-	spin_lock_irq(&pidmap_lock);
-	if (!(ns->pid_allocated & PIDNS_ADDING))
-		goto out_unlock;
+
 	retval = pidfs_add_pid(pid);
 	if (retval)
+		goto out_free;
+
+	/*
+	 * ENOMEM is not the most obvious choice especially for the case
+	 * where the child subreaper has already exited and the pid
+	 * namespace denies the creation of any new processes. But ENOMEM
+	 * is what we have exposed to userspace for a long time and it is
+	 * documented behavior for pid namespaces. So we can't easily
+	 * change it even if there were an error code better suited.
+	 */
+	retval = -ENOMEM;
+
+	spin_lock_irq(&pidmap_lock);
+	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
 	for ( ; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
@@ -282,13 +284,11 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		upid->ns->pid_allocated++;
 	}
 	spin_unlock_irq(&pidmap_lock);
-	idr_preload_end();
 
 	return pid;
 
 out_unlock:
 	spin_unlock_irq(&pidmap_lock);
-	idr_preload_end();
 	put_pid_ns(ns);
 
 out_free:

-- 
2.45.2


