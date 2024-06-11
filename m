Return-Path: <linux-fsdevel+bounces-21457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D1904292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 19:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7EF1C23BFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D06D1D7;
	Tue, 11 Jun 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQdXiFLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA35EE97;
	Tue, 11 Jun 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127640; cv=none; b=S1nBRFYpYSzHGojnIYtbA69cmzr26XJgSUeNSJ7UpLjvG+KuB1HClCi0EabgdHw8w4LS7s6V6bpgAMBTNs/bM6bR2s200xlQBiPng31/TSoA9bE5M9MCgh81UZctBU0pNyEcFZDz5virLnZPOT8Wqu2iUb/VOJKEBhY2peCgKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127640; c=relaxed/simple;
	bh=7Guzp7H+sn054oFkn9cysgGHfTgqpV/Jo6nOkOH0ihk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckrM5bT9YzWWZelISsaqsMYj8kVK+D8bHJ2tC+Xo1/fbQ/+ol/PzthbAMIzgf8SLlOVKvEmbfjtrUTMI3lHPNyRtkAVesZoq9VObKU+YBCT3v1J1tSNoEuV5NY2IdZSFfWf6hVUg5xULWgt7yxQ6YSNx3k1nIWc1CSMPMK8DJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQdXiFLc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so420745e9.1;
        Tue, 11 Jun 2024 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718127637; x=1718732437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRnmRIX050GD3NpvjnKIWUpEOgBhkp0RuNij9t9xi9A=;
        b=iQdXiFLco71wNJQiXRjxR3+Isgaf/WJ7mxzbSP6uORABHioQfPqnlEnraTQ2/Dddav
         kTZLzuX/r/WWu0LcJ/LbosAiZ+I8DkQiCo1ZSKXbe73jAwdrN7M6t/1Ukkka775bhdx/
         c0TE/lyE+kdmfNhFrRyrsxdVruitYBq0O8uK91tAj7fL/hRU/V4691h1lqFGFmji1H5x
         CC4ihmsdZPEHXEcAHW1SBsmak8nBxfFHdivQeT2ot+X3gm6VybBEXQA/3SEhy9pVBCNk
         CArhdawAGtTG+ppN7ywO6d09ujxkoI80rkzkgY7cacV0C6TVCzriXWQSwUi7f5fpsggt
         D6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718127637; x=1718732437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRnmRIX050GD3NpvjnKIWUpEOgBhkp0RuNij9t9xi9A=;
        b=RXmAojpkmFnC0g1UQGKHEQeOOLK8/AhhJDBi2n39t+3+WvyFNuBYtKXcf8e5pLosYK
         UsCSfIO7UQjdL2auc5eP01/FM+Di+5i+ndJou3ltLPHyDlSvfar3ZvZqPt9uiupWLXbs
         f6GRXDr6iEVliLWp1anx+WoNddQBxsWusQdjScyLjn1CRN3jBj5dHCaJcISStrvBBa+o
         cGYhcPW/KvqjC3BYOJ9hCmHcihJhDxGi4i4kVfE/FkQ7kMGDELwJwD1Dir/mhkcEPEYG
         XRB1L7ttsYzT6gr8nuNP0WhBOBfVl3jDm7PmRUYNmgXDrHNQtEdMBKDsEIg/1v00TjRd
         HxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0frN8eXTd+hZYfcfze7SwyGnnE0oL71Rc3zsIuABVEJAuR/03Tk4r8In6DGv4h9eXeUGmLlo7ERMA/5c2wkDyj2ef/GG0NHMolhjae3UaDhGwgcQW7d/Xtl1rU1Q9vza5ql7qfw7VNMDzHFZY7kDXwJHiWSmFb+ZxOEkyhysRte1aX+68ReYi
X-Gm-Message-State: AOJu0YzfYQPcmaxH+Bvh0HmDUoRqx/jdpeeIDXGF2+B+XncsZn40CiXU
	+0DOiHlzjgMbEOP9totYk3s8mAft5q9Ge7wDZMxSv6YedtMmR13C
X-Google-Smtp-Source: AGHT+IF2Nm7R/n9l5WjOo4eAQ5ziWFfMxE4EIXluLTM5NDFbHsHprkeBNv3ir8E2+cC/OTIFxXaNtQ==
X-Received: by 2002:a05:600c:3590:b0:421:4be2:cf0b with SMTP id 5b1f17b1804b1-4223c77e2b3mr33375335e9.15.1718127636710;
        Tue, 11 Jun 2024 10:40:36 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421be4f0a06sm87232435e9.21.2024.06.11.10.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:40:36 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com,
	hch@infradead.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 1/2] vfs: add rcu-based find_inode variants for iget ops
Date: Tue, 11 Jun 2024 19:38:22 +0200
Message-ID: <20240611173824.535995-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611173824.535995-1-mjguzik@gmail.com>
References: <20240611173824.535995-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids one inode hash lock acquire in the common case on inode
creation, in effect significantly reducing contention.

On the stock kernel said lock is typically taken twice:
1. once to check if the inode happens to already be present
2. once to add it to the hash

The back-to-back lock/unlock pattern is known to degrade performance
significantly, which is further exacerbated if the hash is heavily
populated (long chains to walk, extending hold time). Arguably hash
sizing and hashing algo need to be revisited, but that's beyond the
scope of this patch.

With the acquire from step 1 eliminated with RCU lookup throughput
increases significantly at the scale of 20 cores (benchmark results at
the bottom).

So happens the hash already supports RCU-based operation, but lookups on
inode insertions didn't take advantage of it.

This of course has its limits as the global lock is still a bottleneck.
There was a patchset posted which introduced fine-grained locking[1] but
it appears staled. Apart from that doubt was expressed whether a
handrolled hash implementation is appropriate to begin with, suggesting
replacement with rhashtables. Nobody committed to carrying [1] across
the finish line or implementing anything better, thus the bandaid below.

iget_locked consumers (notably ext4) get away without any changes
because inode comparison method is built-in.

iget5_locked consumers pass a custom callback. Since removal of locking
adds more problems (inode can be changing) it's not safe to assume all
filesystems happen to cope.  Thus iget5_locked_rcu gets added, requiring
manual conversion of interested filesystems.

In order to reduce code duplication find_inode and find_inode_fast grow
an argument indicating whether inode hash lock is held, which is passed
down in case sleeping is necessary. They always rcu_read_lock, which is
redundant but harmless. Doing it conditionally reduces readability for
no real gain that I can see. RCU-alike restrictions were already put on
callbacks due to the hash spinlock being held.

Benchmarking:
There is a real cache-busting workload scanning millions of files in
parallel (it's a backup appliance), where the initial lookup is
guaranteed to fail resulting in the two lock acquires on stock kernel
(and one with the patch at hand).

Implemented below is a synthetic benchmark providing the same behavior.
[I shall note the workload is not running on Linux, instead it was
causing trouble elsewhere. Benchmark below was used while addressing
said problems and was found to adequately represent the real workload.]

Total real time fluctuates by 1-2s.

With 20 threads each walking a dedicated 1000 dirs * 1000 files
directory tree to stat(2) on a 32 core + 24GB RAM vm:

ext4 (needed mkfs.ext4 -N 24000000):
before: 3.77s user 890.90s system 1939% cpu 46.118 total
after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)

That's 20 million files to visit, while the machine can only cache about
15 million at a time (obtained from ext4_inode_cache object count in
/proc/slabinfo). Since each terminal inode is only visited once per run
this amounts to 0% hit ratio for the dentry cache and the hash table
(there are however hits for the intermediate directories).

On repeated runs the kernel caches the last ~15 mln, meaning there is ~5
mln of uncached inodes which are going to be visited first, evicting the
previously cached state as it happens.

Lack of hits can be trivially verified with bpftrace, like so:
bpftrace -e 'kretprobe:find_inode_fast { @[kstack(), retval != 0] = count(); }'\
-c "/bin/sh walktrees /testfs 20"

Best ran more than once.

Expected results after "warmup":
[snip]
@[
    __ext4_iget+275
    ext4_lookup+224
    __lookup_slow+130
    walk_component+219
    link_path_walk.part.0.constprop.0+614
    path_lookupat+62
    filename_lookup+204
    vfs_statx+128
    vfs_fstatat+131
    __do_sys_newfstatat+38
    do_syscall_64+87
    entry_SYSCALL_64_after_hwframe+118
, 1]: 20000
@[
    __ext4_iget+275
    ext4_lookup+224
    __lookup_slow+130
    walk_component+219
    path_lookupat+106
    filename_lookup+204
    vfs_statx+128
    vfs_fstatat+131
    __do_sys_newfstatat+38
    do_syscall_64+87
    entry_SYSCALL_64_after_hwframe+118
, 1]: 20000000

That is 20 million calls for the initial lookup and 20 million after
allocating a new inode, all of them failing to return a value != 0
(i.e., they are returning NULL -- no match found).

Of course aborting the benchmark in the middle and starting it again (or
messing with the state in other ways) is going to alter these results.

Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz

[1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 97 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h |  7 +++-
 2 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..8c57cea7bbbb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -886,36 +886,45 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 	return freed;
 }
 
-static void __wait_on_freeing_inode(struct inode *inode);
+static void __wait_on_freeing_inode(struct inode *inode, bool locked);
 /*
  * Called with the inode lock held.
  */
 static struct inode *find_inode(struct super_block *sb,
 				struct hlist_head *head,
 				int (*test)(struct inode *, void *),
-				void *data)
+				void *data, bool locked)
 {
 	struct inode *inode = NULL;
 
+	if (locked)
+		lockdep_assert_held(&inode_hash_lock);
+	else
+		lockdep_assert_not_held(&inode_hash_lock);
+
+	rcu_read_lock();
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb != sb)
 			continue;
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode);
+			__wait_on_freeing_inode(inode, locked);
 			goto repeat;
 		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
+			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
+		rcu_read_unlock();
 		return inode;
 	}
+	rcu_read_unlock();
 	return NULL;
 }
 
@@ -924,29 +933,39 @@ static struct inode *find_inode(struct super_block *sb,
  * iget_locked for details.
  */
 static struct inode *find_inode_fast(struct super_block *sb,
-				struct hlist_head *head, unsigned long ino)
+				struct hlist_head *head, unsigned long ino,
+				bool locked)
 {
 	struct inode *inode = NULL;
 
+	if (locked)
+		lockdep_assert_held(&inode_hash_lock);
+	else
+		lockdep_assert_not_held(&inode_hash_lock);
+
+	rcu_read_lock();
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino != ino)
 			continue;
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode);
+			__wait_on_freeing_inode(inode, locked);
 			goto repeat;
 		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
+			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
+		rcu_read_unlock();
 		return inode;
 	}
+	rcu_read_unlock();
 	return NULL;
 }
 
@@ -1161,7 +1180,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 
 again:
 	spin_lock(&inode_hash_lock);
-	old = find_inode(inode->i_sb, head, test, data);
+	old = find_inode(inode->i_sb, head, test, data, true);
 	if (unlikely(old)) {
 		/*
 		 * Uhhuh, somebody else created the same inode under us.
@@ -1245,6 +1264,48 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 }
 EXPORT_SYMBOL(iget5_locked);
 
+/**
+ * iget5_locked_rcu - obtain an inode from a mounted file system
+ * @sb:		super block of file system
+ * @hashval:	hash value (usually inode number) to get
+ * @test:	callback used for comparisons between inodes
+ * @set:	callback used to initialize a new struct inode
+ * @data:	opaque data pointer to pass to @test and @set
+ *
+ * This is equivalent to iget5_locked, except the @test callback must
+ * tolerate the inode not being stable, including being mid-teardown.
+ */
+struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *),
+		int (*set)(struct inode *, void *), void *data)
+{
+	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct inode *inode, *new;
+
+again:
+	inode = find_inode(sb, head, test, data, false);
+	if (inode) {
+		if (IS_ERR(inode))
+			return NULL;
+		wait_on_inode(inode);
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
+		}
+		return inode;
+	}
+
+	new = alloc_inode(sb);
+	if (new) {
+		new->i_state = 0;
+		inode = inode_insert5(new, hashval, test, set, data);
+		if (unlikely(inode != new))
+			destroy_inode(new);
+	}
+	return inode;
+}
+EXPORT_SYMBOL_GPL(iget5_locked_rcu);
+
 /**
  * iget_locked - obtain an inode from a mounted file system
  * @sb:		super block of file system
@@ -1263,9 +1324,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
 again:
-	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
-	spin_unlock(&inode_hash_lock);
+	inode = find_inode_fast(sb, head, ino, false);
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
@@ -1283,7 +1342,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 
 		spin_lock(&inode_hash_lock);
 		/* We released the lock, so.. */
-		old = find_inode_fast(sb, head, ino);
+		old = find_inode_fast(sb, head, ino, true);
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
@@ -1419,7 +1478,7 @@ struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
 	struct inode *inode;
 
 	spin_lock(&inode_hash_lock);
-	inode = find_inode(sb, head, test, data);
+	inode = find_inode(sb, head, test, data, true);
 	spin_unlock(&inode_hash_lock);
 
 	return IS_ERR(inode) ? NULL : inode;
@@ -1474,7 +1533,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	struct inode *inode;
 again:
 	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
+	inode = find_inode_fast(sb, head, ino, true);
 	spin_unlock(&inode_hash_lock);
 
 	if (inode) {
@@ -2235,17 +2294,21 @@ EXPORT_SYMBOL(inode_needs_sync);
  * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
  * will DTRT.
  */
-static void __wait_on_freeing_inode(struct inode *inode)
+static void __wait_on_freeing_inode(struct inode *inode, bool locked)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
 	wq = bit_waitqueue(&inode->i_state, __I_NEW);
 	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-	spin_unlock(&inode_hash_lock);
+	rcu_read_unlock();
+	if (locked)
+		spin_unlock(&inode_hash_lock);
 	schedule();
 	finish_wait(wq, &wait.wq_entry);
-	spin_lock(&inode_hash_lock);
+	if (locked)
+		spin_lock(&inode_hash_lock);
+	rcu_read_lock();
 }
 
 static __initdata unsigned long ihash_entries;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bfc1e6407bf6..3eb88cb3c1e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3045,7 +3045,12 @@ extern struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 		int (*test)(struct inode *, void *),
 		int (*set)(struct inode *, void *),
 		void *data);
-extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
+struct inode *iget5_locked(struct super_block *, unsigned long,
+			   int (*test)(struct inode *, void *),
+			   int (*set)(struct inode *, void *), void *);
+struct inode *iget5_locked_rcu(struct super_block *, unsigned long,
+			       int (*test)(struct inode *, void *),
+			       int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);
 extern struct inode *find_inode_nowait(struct super_block *,
 				       unsigned long,
-- 
2.43.0


