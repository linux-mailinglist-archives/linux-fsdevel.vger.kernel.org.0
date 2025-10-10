Return-Path: <linux-fsdevel+bounces-63819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F29BCEAF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B81544758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32F276025;
	Fri, 10 Oct 2025 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRI7Uvp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD0258CD0
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134667; cv=none; b=FBHk+8nFkiYnsof22YGrnQhtAXIFDN3mLapXViviU9I+BTKtclMHEYtblhcNcOOx4qkVqFQ+Rb+7VwP7xB4KjApej4tNIdrwZATukJZKCTWpVKNzmIcOIP1fAxi7Qe2JzGE5UI/uzRp4gXhN8Lp1QNts2BwB/nYGtuCX/WUuhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134667; c=relaxed/simple;
	bh=w1T9GeSwriOHz1us7VegZsxeoRhTe4hxz+3gec3k1fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfCp2PKFqa6MdEyeMd2Foq+vTb0Sa7xSPWZ2xx5DkjxmfeH/upPhlVcKjAo3PPwUubLMllIPOodju5TB3aBSHJ7DUAh1gf9w5geJ+havo5HZr2QOl7sD2ozXn5PdQUod4uLNTyAeOCeNWXAExmbEWkrJnDjaNNXA+bO1CdO1x1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRI7Uvp0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b50645ecfbbso516638566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760134661; x=1760739461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LKQtbwvgtZO6Ou2ow3imMF0f8RAbSKVvOayIwxBwtQw=;
        b=IRI7Uvp0W2q4VmWsiAtnxGupajmImF7D9vPVsJYBP034FtW4BoBy+jAFtItEhREMLJ
         6ZEsY+ZOO1++OCN0S2rm6S2LML16cqdgqCe1h1lkumAIvaswm96E8sxOeV+LqgNUiuqY
         5W3eqiGkDMIz1UlOaLWA8ldYwlYgrqpa23Wsj7sG7+gxYCS8vVoLyb7BqEds0wTLfFdx
         LmsOD/dS+V7w2UogUp1nQxRyckBsR+7kAAVu1wUV1BlQvB7yNPyl4jCy2FoHaiQA/Jlg
         Oe9EbPQdOMWAV4MI5qccef1kwKi6BNlgXq7HVDGyyDiu7OdFdusaTD5l+RFRZUHZGjmf
         9vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134661; x=1760739461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKQtbwvgtZO6Ou2ow3imMF0f8RAbSKVvOayIwxBwtQw=;
        b=FVy8j4xXQiF0vVW0GqDeh8WBoXcjBQIPE1lCVQd6taM6gMiciaoUPIeTC7xuvCL0ST
         BNPGti2gvDmG0GyfWvn7kMMC/I7tjUwTLFkFHhkPBS8+y+x6/ctq4+Q6/avbH1oRKQie
         T/+ZqdFT/mgjjNWAIobu6QURpJ9PTB/Le8jserD8CiSzs3pdwbFnWiMAeY9s2gVCwm4k
         /KRljeYe2AAIQIRz9GpGGr4RkOqVPItQbg96X0LEAhkyNun4oterB3sfi2csNMCpZmzm
         R5ibydbTmg1bigrpcovJL09vaipUwKHNo20iZuGzmhe2AFUxr94RbopfyOitSLs+KAa9
         D8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX46OQe5CeDpBINgyfrPeoxrCl+wfX4oYcXFNC9asyQpGdSi1ii2HGauV9bbnrQWejb/AFBi87me8yg7jHI@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvWhQ7/ySrkfXLXcZ2844KhwuW/2ubfacbWR1JB9LerUSfeR/
	f34m0Sun8PHFdvncCRGRuwnKby0UolI+pTrYHkSEWGdIFh15YrMk7msa
X-Gm-Gg: ASbGnct0XiY3/99L0HWsWm8jTAOKoYO4/ZxBov3YyWXXFk/sC8cDgNaIEJOWO5Fr44u
	O97AK5Z47esxR8VB1kb9FFcCmxKSjMRQpyGFeDbCR2kGtPLUm3dk1iQS4FPZc8G68FnbthujEdM
	bttrtzp3UZRe6ZrAWePcbdugZiw7cnMu4ZNerXdzHnR4F5jkDNm5UPUvug2zLvXnZZpJ7lUjB7r
	jYYBwo+whM3hEZ9ZBhiCE+ci3rBhXuxbnWHRXP9PcJQwGwxooeLaMWiLu1nK6FM1IE+IgY3MOry
	lAT/w8xkRwSVcvGa4cFpXqiMywiyEJF39xnWebLd/bWfS0fiA4aGWJQDYGiFAhAttWJyIqMKOqx
	f1fLRTN/Kqu1u1QXKPHlXAgzmKel8/8mWATplmpRR/1Wb7Jf2VQhi/lMYwPfquAWZciC21orkcN
	P+4549zNDpZUu7wviXdaaMc/alPEM=
X-Google-Smtp-Source: AGHT+IHIkPtl6T0qfdYDVwta+NY5U8nDtnRpyI9VpPx6t7WYBKcSYOsWUTGZI1qD5t5eYXJnGFmU2g==
X-Received: by 2002:a17:906:c105:b0:b3e:907c:9e26 with SMTP id a640c23a62f3a-b50ac5cfaf7mr1384462966b.59.1760134661125;
        Fri, 10 Oct 2025 15:17:41 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2db4sm331467666b.36.2025.10.10.15.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:17:40 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: rework I_NEW handling to operate without fences
Date: Sat, 11 Oct 2025 00:17:36 +0200
Message-ID: <20251010221737.1403539-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the inode hash code grab the state while ->i_lock is held. If found
to be set, synchronize the sleep once more with the lock held.

In the real world the flag is not set most of the time.

Apart from being simpler to reason about, it comes with a minor speed up
as now clearing the flag does not require the smp_mb() fence.

While here rename wait_on_inode() to wait_on_new_inode() to line it up
with __wait_on_freeing_inode().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This temporarily duplicated sleep code from inode_wait_for_lru_isolating().
This is going to get dedupped later.

There is high repetition of:
	if (unlikely(isnew)) {
		wait_on_new_inode(old);
		if (unlikely(inode_unhashed(old))) {
			iput(old);
			goto again;
		}

I expect this is going to go away after I post a patch to sanitize the
current APIs for the hash.


 fs/afs/dir.c       |   4 +-
 fs/dcache.c        |  10 ----
 fs/gfs2/glock.c    |   2 +-
 fs/inode.c         | 146 +++++++++++++++++++++++++++------------------
 include/linux/fs.h |  12 +---
 5 files changed, 93 insertions(+), 81 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 89d36e3e5c79..f4e9e12373ac 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -779,7 +779,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
 	struct inode *inode = NULL, *ti;
 	afs_dataversion_t data_version = READ_ONCE(dvnode->status.data_version);
-	bool supports_ibulk;
+	bool supports_ibulk, isnew;
 	long ret;
 	int i;
 
@@ -850,7 +850,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 			 * callback counters.
 			 */
 			ti = ilookup5_nowait(dir->i_sb, vp->fid.vnode,
-					     afs_ilookup5_test_by_fid, &vp->fid);
+					     afs_ilookup5_test_by_fid, &vp->fid, &isnew);
 			if (!IS_ERR_OR_NULL(ti)) {
 				vnode = AFS_FS_I(ti);
 				vp->dv_before = vnode->status.data_version;
diff --git a/fs/dcache.c b/fs/dcache.c
index 78ffa7b7e824..25131f105a60 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1981,17 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
-	/*
-	 * Pairs with smp_rmb in wait_on_inode().
-	 */
-	smp_wmb();
 	inode_state_clear(inode, I_NEW | I_CREATING);
-	/*
-	 * Pairs with the barrier in prepare_to_wait_event() to make sure
-	 * ___wait_var_event() either sees the bit cleared or
-	 * waitqueue_active() check in wake_up_var() sees the waiter.
-	 */
-	smp_mb();
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b677c0e6b9ab..c9712235e7a0 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -957,7 +957,7 @@ static struct gfs2_inode *gfs2_grab_existing_inode(struct gfs2_glock *gl)
 		ip = NULL;
 	spin_unlock(&gl->gl_lockref.lock);
 	if (ip) {
-		wait_on_inode(&ip->i_inode);
+		wait_on_new_inode(&ip->i_inode);
 		if (is_bad_inode(&ip->i_inode)) {
 			iput(&ip->i_inode);
 			ip = NULL;
diff --git a/fs/inode.c b/fs/inode.c
index 3153d725859c..1396f79b2551 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -558,6 +558,32 @@ struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
 }
 EXPORT_SYMBOL(inode_bit_waitqueue);
 
+void wait_on_new_inode(struct inode *inode)
+{
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
+
+	spin_lock(&inode->i_lock);
+	if (!(inode_state_read(inode) & I_NEW)) {
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
+	for (;;) {
+		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (!(inode_state_read(inode) & I_NEW))
+			break;
+		spin_unlock(&inode->i_lock);
+		schedule();
+		spin_lock(&inode->i_lock);
+	}
+	finish_wait(wq_head, &wqe.wq_entry);
+	WARN_ON(inode_state_read(inode) & I_NEW);
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL(wait_on_new_inode);
+
 /*
  * Add inode to LRU if needed (inode is unused and clean).
  *
@@ -1008,7 +1034,8 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
 static struct inode *find_inode(struct super_block *sb,
 				struct hlist_head *head,
 				int (*test)(struct inode *, void *),
-				void *data, bool is_inode_hash_locked)
+				void *data, bool is_inode_hash_locked,
+				bool *isnew)
 {
 	struct inode *inode = NULL;
 
@@ -1035,6 +1062,7 @@ static struct inode *find_inode(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		*isnew = !!(inode_state_read(inode) & I_NEW);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1049,7 +1077,7 @@ static struct inode *find_inode(struct super_block *sb,
  */
 static struct inode *find_inode_fast(struct super_block *sb,
 				struct hlist_head *head, unsigned long ino,
-				bool is_inode_hash_locked)
+				bool is_inode_hash_locked, bool *isnew)
 {
 	struct inode *inode = NULL;
 
@@ -1076,6 +1104,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			return ERR_PTR(-ESTALE);
 		}
 		__iget(inode);
+		*isnew = !!(inode_state_read(inode) & I_NEW);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		return inode;
@@ -1181,17 +1210,7 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
-	/*
-	 * Pairs with smp_rmb in wait_on_inode().
-	 */
-	smp_wmb();
 	inode_state_clear(inode, I_NEW | I_CREATING);
-	/*
-	 * Pairs with the barrier in prepare_to_wait_event() to make sure
-	 * ___wait_var_event() either sees the bit cleared or
-	 * waitqueue_active() check in wake_up_var() sees the waiter.
-	 */
-	smp_mb();
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
@@ -1202,17 +1221,7 @@ void discard_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
-	/*
-	 * Pairs with smp_rmb in wait_on_inode().
-	 */
-	smp_wmb();
 	inode_state_clear(inode, I_NEW);
-	/*
-	 * Pairs with the barrier in prepare_to_wait_event() to make sure
-	 * ___wait_var_event() either sees the bit cleared or
-	 * waitqueue_active() check in wake_up_var() sees the waiter.
-	 */
-	smp_mb();
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
 	iput(inode);
@@ -1286,12 +1295,13 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 {
 	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
 	struct inode *old;
+	bool isnew;
 
 	might_sleep();
 
 again:
 	spin_lock(&inode_hash_lock);
-	old = find_inode(inode->i_sb, head, test, data, true);
+	old = find_inode(inode->i_sb, head, test, data, true, &isnew);
 	if (unlikely(old)) {
 		/*
 		 * Uhhuh, somebody else created the same inode under us.
@@ -1300,10 +1310,12 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 		spin_unlock(&inode_hash_lock);
 		if (IS_ERR(old))
 			return NULL;
-		wait_on_inode(old);
-		if (unlikely(inode_unhashed(old))) {
-			iput(old);
-			goto again;
+		if (unlikely(isnew)) {
+			wait_on_new_inode(old);
+			if (unlikely(inode_unhashed(old))) {
+				iput(old);
+				goto again;
+			}
 		}
 		return old;
 	}
@@ -1391,18 +1403,21 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode, *new;
+	bool isnew;
 
 	might_sleep();
 
 again:
-	inode = find_inode(sb, head, test, data, false);
+	inode = find_inode(sb, head, test, data, false, &isnew);
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		wait_on_inode(inode);
-		if (unlikely(inode_unhashed(inode))) {
-			iput(inode);
-			goto again;
+		if (unlikely(isnew)) {
+			wait_on_new_inode(inode);
+			if (unlikely(inode_unhashed(inode))) {
+				iput(inode);
+				goto again;
+			}
 		}
 		return inode;
 	}
@@ -1434,18 +1449,21 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
+	bool isnew;
 
 	might_sleep();
 
 again:
-	inode = find_inode_fast(sb, head, ino, false);
+	inode = find_inode_fast(sb, head, ino, false, &isnew);
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		wait_on_inode(inode);
-		if (unlikely(inode_unhashed(inode))) {
-			iput(inode);
-			goto again;
+		if (unlikely(isnew)) {
+			wait_on_new_inode(inode);
+			if (unlikely(inode_unhashed(inode))) {
+				iput(inode);
+				goto again;
+			}
 		}
 		return inode;
 	}
@@ -1456,7 +1474,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 
 		spin_lock(&inode_hash_lock);
 		/* We released the lock, so.. */
-		old = find_inode_fast(sb, head, ino, true);
+		old = find_inode_fast(sb, head, ino, true, &isnew);
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
@@ -1482,10 +1500,12 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (IS_ERR(old))
 			return NULL;
 		inode = old;
-		wait_on_inode(inode);
-		if (unlikely(inode_unhashed(inode))) {
-			iput(inode);
-			goto again;
+		if (unlikely(isnew)) {
+			wait_on_new_inode(inode);
+			if (unlikely(inode_unhashed(inode))) {
+				iput(inode);
+				goto again;
+			}
 		}
 	}
 	return inode;
@@ -1586,13 +1606,13 @@ EXPORT_SYMBOL(igrab);
  * Note2: @test is called with the inode_hash_lock held, so can't sleep.
  */
 struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
-		int (*test)(struct inode *, void *), void *data)
+		int (*test)(struct inode *, void *), void *data, bool *isnew)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode;
 
 	spin_lock(&inode_hash_lock);
-	inode = find_inode(sb, head, test, data, true);
+	inode = find_inode(sb, head, test, data, true, isnew);
 	spin_unlock(&inode_hash_lock);
 
 	return IS_ERR(inode) ? NULL : inode;
@@ -1620,16 +1640,19 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
 	struct inode *inode;
+	bool isnew;
 
 	might_sleep();
 
 again:
-	inode = ilookup5_nowait(sb, hashval, test, data);
+	inode = ilookup5_nowait(sb, hashval, test, data, &isnew);
 	if (inode) {
-		wait_on_inode(inode);
-		if (unlikely(inode_unhashed(inode))) {
-			iput(inode);
-			goto again;
+		if (unlikely(isnew)) {
+			wait_on_new_inode(inode);
+			if (unlikely(inode_unhashed(inode))) {
+				iput(inode);
+				goto again;
+			}
 		}
 	}
 	return inode;
@@ -1648,19 +1671,22 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
+	bool isnew;
 
 	might_sleep();
 
 again:
-	inode = find_inode_fast(sb, head, ino, false);
+	inode = find_inode_fast(sb, head, ino, false, &isnew);
 
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		wait_on_inode(inode);
-		if (unlikely(inode_unhashed(inode))) {
-			iput(inode);
-			goto again;
+		if (unlikely(isnew)) {
+			wait_on_new_inode(inode);
+			if (unlikely(inode_unhashed(inode))) {
+				iput(inode);
+				goto again;
+			}
 		}
 	}
 	return inode;
@@ -1800,6 +1826,7 @@ int insert_inode_locked(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 	ino_t ino = inode->i_ino;
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
+	bool isnew;
 
 	might_sleep();
 
@@ -1832,12 +1859,15 @@ int insert_inode_locked(struct inode *inode)
 			return -EBUSY;
 		}
 		__iget(old);
+		isnew = !!(inode_state_read(old) & I_NEW);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
-		wait_on_inode(old);
-		if (unlikely(!inode_unhashed(old))) {
-			iput(old);
-			return -EBUSY;
+		if (isnew) {
+			wait_on_new_inode(old);
+			if (unlikely(!inode_unhashed(old))) {
+				iput(old);
+				return -EBUSY;
+			}
 		}
 		iput(old);
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21c73df3ce75..a813abdcf218 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1030,15 +1030,7 @@ static inline void inode_fake_hash(struct inode *inode)
 	hlist_add_fake(&inode->i_hash);
 }
 
-static inline void wait_on_inode(struct inode *inode)
-{
-	wait_var_event(inode_state_wait_address(inode, __I_NEW),
-		       !(inode_state_read_once(inode) & I_NEW));
-	/*
-	 * Pairs with routines clearing I_NEW.
-	 */
-	smp_rmb();
-}
+void wait_on_new_inode(struct inode *inode);
 
 /*
  * inode->i_rwsem nesting subclasses for the lock validator:
@@ -3417,7 +3409,7 @@ extern void d_mark_dontcache(struct inode *inode);
 
 extern struct inode *ilookup5_nowait(struct super_block *sb,
 		unsigned long hashval, int (*test)(struct inode *, void *),
-		void *data);
+		void *data, bool *isnew);
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data);
 extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
-- 
2.34.1


