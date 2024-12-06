Return-Path: <linux-fsdevel+bounces-36643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D89E73E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341F62884F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF6207DFA;
	Fri,  6 Dec 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azMAGsoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566F1F4735
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498728; cv=none; b=pa6oQ58rpB74JpCgxoGjBKMwBzyotj2pkbrj9iePdRPD5QUHgNY8mXYmDh5IBLbuB/DYnYpLpwZcejXwjYylSO7cHYpPjeMtB7ppohH6eCF2TjcBWfkupF8FHTd76DJsbvYLJDLQW2wB5eg2vuV0/OpZhKzFHL1FJiNYFs4YxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498728; c=relaxed/simple;
	bh=+WT0fF7+aj1AK5Ua/CmbrkbvqKXUCyw9LYgWMNWpnP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EK161qpi+XHnB6MT8oFJudVpFNrkS+5eU+HEa8MqRd5nmRk3nSw3XNrm6g8tWGo54qoYKrs2wcb/GxJ9xhoXQAE6+Nga3yVFCXbNfwvfDXBvSJ+mSV5Fia9z85V9mbqBfAnvkLaxevUgatibY3RAhGYxVljh62aTEtyRqdPUvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azMAGsoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E7CC4CEDF;
	Fri,  6 Dec 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733498727;
	bh=+WT0fF7+aj1AK5Ua/CmbrkbvqKXUCyw9LYgWMNWpnP0=;
	h=From:Date:Subject:To:Cc:From;
	b=azMAGsojeslqopZffTI6vnA/qLdRBRHunfVgIgqQrgvfCRLVp3NoQbff1ovmcbsUN
	 v8dObgjFo7czTZF/RxnpW6urgDbsWjU1U1Cy4xLxMVETYDe3T4ADzkSyWaoQIdSdvZ
	 tsDh5Ywx3FbphGXWmXhDIQzVa/OY5wyaEf2SWy8SHZb5stwqLKZxhSfZg27HIdlbaj
	 OOtaUzlWmPeRVn4BLoHwudH8/eEe64EBdazS6x2SVLA/h1cAj9VByA2dV6KDv5FiFY
	 dcbHH7v0k3IUoj2O9XfAJRvzGzdbpo98ixjIm+cO3NpObHH/+V/oH/AJHqdD9HVLOB
	 ZJ3tP3gVpo6Ow==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Dec 2024 16:25:13 +0100
Subject: [PATCH RFC] pidfs: use maple tree
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFgXU2cC/x3MwQ6CMBAE0F8he7aEFsTg1cQP8EqMaWErG7E0W
 4ImhH935TiTmbdCQiZMcM5WYFwo0RQk6EMG3WDDExX1ksEUptKmqNVn4peK1Puk3jaO+JgZUbn
 SGO+PZdO4E8g3Mnr67m4Lt+sF7lI6m2TJNnTDn1yEqHNd5bsG2/YDghOB/40AAAA=
X-Change-ID: 20241206-work-pidfs-maple_tree-b322ff5399b7
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
 maple-tree@lists.infradead.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6897; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+WT0fF7+aj1AK5Ua/CmbrkbvqKXUCyw9LYgWMNWpnP0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQHi6dJvRVnSJp+YPJ/7mk6pVMkOaZk7vIJ1nEKd691F
 A1rFBDqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIjeGUaGbR4z43eWTmaXObx/
 /rMMrTDjD4GvOeK/dUxcytC3srvfn5Hh5H/fX1FPXy+xfbPb6o5X0beIK2HaghycoTYufc0NDZv
 4AQ==
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
Hey Liam,

Could you look this over and tell me whether my port makes any sense and
is safe? This is the first time I've been playing with the maple tree.

I've also considerd preallocating the node during pid allocation outside
of the spinlock using mas_preallocate() similar to how idr_preload()
works but I'm unclear how the mas_preallocate() api is supposed to
work in this case.

For the pidfs inode maple tree we use an external lock for add and
remove. While looking at the maple_tree code I saw that mas_nomem()
is called in mas_alloc_cyclic(). And mas_nomem() has a
__must_hold(mas->tree->ma_lock) annotation. But then the code checks
mt_external_lock() which is placed in a union with ma_lock iirc. So that
annotation seems wrong?

bool mas_nomem(struct ma_state *mas, gfp_t gfp)
        __must_hold(mas->tree->ma_lock)
{
        if (likely(mas->node != MA_ERROR(-ENOMEM)))
                return false;

        if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
                mtree_unlock(mas->tree);
                mas_alloc_nodes(mas, gfp);
                mtree_lock(mas->tree);
        } else {
                mas_alloc_nodes(mas, gfp);
        }

        if (!mas_allocated(mas))
                return false;

        mas->status = ma_start;
        return true;
}

If you want to look at this in context I would please ask you to pull:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.14.pidfs

Thanks!
Christian
---
 fs/pidfs.c          | 35 ++++++++++++++++++-----------------
 include/linux/pid.h |  1 +
 kernel/pid.c        |  8 +++++---
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7a1d606b09d7b315e780c81fc7341f4ec82f2639..d1584afc9fe5729d5dbad8e084c62a6c19754dcc 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -19,13 +19,12 @@
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
 #include <linux/utsname.h>
+#include <linux/maple_tree.h>
 #include <net/net_namespace.h>
 
 #include "internal.h"
 #include "mount.h"
 
-static DEFINE_IDR(pidfs_ino_idr);
-
 static u32 pidfs_ino_upper_32_bits = 0;
 
 #if BITS_PER_LONG == 32
@@ -34,8 +33,6 @@ static u32 pidfs_ino_upper_32_bits = 0;
  * the higher 32 bits are the generation number. The starting
  * value for the inode number and the generation number is one.
  */
-static u32 pidfs_ino_lower_32_bits = 1;
-
 static inline unsigned long pidfs_ino(u64 ino)
 {
 	return lower_32_bits(ino);
@@ -49,8 +46,6 @@ static inline u32 pidfs_gen(u64 ino)
 
 #else
 
-static u32 pidfs_ino_lower_32_bits = 0;
-
 /* On 64 bit simply return ino. */
 static inline unsigned long pidfs_ino(u64 ino)
 {
@@ -71,22 +66,25 @@ static inline u32 pidfs_gen(u64 ino)
  */
 int pidfs_add_pid(struct pid *pid)
 {
-	u32 upper;
-	int lower;
+	static unsigned long lower_next = 0;
+	unsigned long lower;
+	int ret;
+
+	MA_STATE(mas, &pidfs_ino_mtree, 0, 0);
 
         /*
 	 * Inode numbering for pidfs start at 2. This avoids collisions
 	 * with the root inode which is 1 for pseudo filesystems.
          */
-	lower = idr_alloc_cyclic(&pidfs_ino_idr, pid, 2, 0, GFP_ATOMIC);
-	if (lower >= 0 && lower < pidfs_ino_lower_32_bits)
+	ret = mas_alloc_cyclic(&mas, &lower, pid, 2, ULONG_MAX, &lower_next, GFP_ATOMIC);
+	if (ret < 0)
+		return ret;
+
+	/* Wrapping really only happens on 32 bit. */
+	if (ret == 1)
 		pidfs_ino_upper_32_bits++;
-	upper = pidfs_ino_upper_32_bits;
-	pidfs_ino_lower_32_bits = lower;
-	if (lower < 0)
-		return lower;
 
-	pid->ino = ((u64)upper << 32) | lower;
+	pid->ino = ((u64)pidfs_ino_upper_32_bits << 32) | lower;
 	pid->stashed = NULL;
 	return 0;
 }
@@ -94,7 +92,10 @@ int pidfs_add_pid(struct pid *pid)
 /* The idr number to remove is the lower 32 bits of the inode. */
 void pidfs_remove_pid(struct pid *pid)
 {
-	idr_remove(&pidfs_ino_idr, lower_32_bits(pid->ino));
+	unsigned long pid_ino = pidfs_ino(pid->ino);
+
+	MA_STATE(mas, &pidfs_ino_mtree, pid_ino, pid_ino);
+	mas_erase(&mas);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -522,7 +523,7 @@ static struct pid *pidfs_ino_get_pid(u64 ino)
 
 	guard(rcu)();
 
-	pid = idr_find(&pidfs_ino_idr, lower_32_bits(pid_ino));
+	pid = mtree_load(&pidfs_ino_mtree, pid_ino);
 	if (!pid)
 		return NULL;
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074cb09b12ec1cb98c8148250c506e0a..f023af78eaf67520311ed723f2407125f72253b7 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -68,6 +68,7 @@ struct pid
 	struct upid numbers[];
 };
 
+extern struct maple_tree pidfs_ino_mtree;
 extern struct pid init_struct_pid;
 
 struct file;
diff --git a/kernel/pid.c b/kernel/pid.c
index 6131543e7c090c164a2bac014f8eeee61926b13d..bb46e3ca2468d7b6657ee4b1b00009ecf7b28fb5 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -104,6 +104,11 @@ EXPORT_SYMBOL_GPL(init_pid_ns);
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
 
+struct maple_tree pidfs_ino_mtree = MTREE_INIT_EXT(pidfs_ino_mtree,
+						   MT_FLAGS_ALLOC_RANGE |
+						   MT_FLAGS_LOCK_EXTERN,
+						   pidmap_lock);
+
 void put_pid(struct pid *pid)
 {
 	struct pid_namespace *ns;
@@ -269,7 +274,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	INIT_HLIST_HEAD(&pid->inodes);
 
 	upid = pid->numbers + ns->level;
-	idr_preload(GFP_KERNEL);
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
@@ -282,13 +286,11 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
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

---
base-commit: 963c8e506c6d4769d04fcb64d4bf783e4ef6093e
change-id: 20241206-work-pidfs-maple_tree-b322ff5399b7


