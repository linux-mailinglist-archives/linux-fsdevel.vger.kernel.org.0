Return-Path: <linux-fsdevel+bounces-21105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B28FE85D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3C61F25FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1EB196C6D;
	Thu,  6 Jun 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2jsQ7mg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CA2BAF1;
	Thu,  6 Jun 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682725; cv=none; b=OapcKM+T7IIAIwIHU/UXsDHsgJZ8mQh1nQJ2W1uPovp09+pScpahbcOnul/i5czhfRH1EuN3nqT39d/M/icXXjCteB09eniPqxlqT4Wmdg3FZtb3fDfup8CQOcG4ux3yhF4x0GPg+C/CFbOqoTITbw4+nkkx30zOnYrjb5n5dC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682725; c=relaxed/simple;
	bh=LWdBlyuoixXaarEa/Ch7VRkV0mMirXLo8qg7ylR0U7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uksFJOEI+8we10tRE4p2xVsM6pR7IFigLCjRxbRi8Su2Ne0197j11PPnqVVFNMp23M4RwmQwzI6UohQcjk6dsKZMEOZRpsSbSMIAF20d+8IMDdkatNKsLjKLrQFnSV6z2Ik4roojhixSBpQTEU+q5JlBixLSg/U8cnBWgEu+9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2jsQ7mg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dc04717a1so749685f8f.2;
        Thu, 06 Jun 2024 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717682722; x=1718287522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7C6CVAVvn5ySgr1lmmWzp0kCYHADltetwDtVfV2s2o=;
        b=C2jsQ7mg8URo8kVrw1LVC14i6W4EZzpLdESZa+RD34pYxn/JAnXsHy5ajiLdvNlESC
         3GlZAaEgUOeFK/8F9UMiPKPCD6PoAltaX50Tn6RJms2cGEdZX/+uZDn75OjdlH5EUteH
         mUaDQWVSDhjssVu1tdsb3nXsP6Cf6dH0zf59QQbEPibPiFuaderZ8vFbmNg54aBwHU30
         xbkaxLSD76/snijXrr0F4QtYkTDBNzNhbFoyXeOlmQIvaxoZOL5bLSSYpemiVzljxagU
         KYHKTKNHzJPwVIt6vkSx5qYwmys2HDjKenRb1TOkybTcGBArVUfpcnteAJ9EqXjbq5kW
         2i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682722; x=1718287522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7C6CVAVvn5ySgr1lmmWzp0kCYHADltetwDtVfV2s2o=;
        b=LFvZiqXWmUfZzskj5FFhtfm8aiU5llgUAeF2B8i2vN5Vwttm9bw0yhZxIeDz/E4rEg
         dXwQL5ZJzGt61zyakI4NaaoWg8+6Ksmsz/QoyuPsHUqhub09+0C7f+FC/zhYH1rQHl5W
         L84nAoFzGjiycKzXcS1kn6KtTuIOsDl5j45RTx0TLeTlYzv1dRkyIHqvwOZhpks71uaw
         TawMfayZQMU8OamTuMSHbQwmP8RXCfi7HuPr0FO2/qDHhx/sMlRkJC/wiFNTH5Xn756v
         x/fHi9cedwt3T6UqWWdMfQx7hNDuCmYffEaGfKhmfoP3ciJoFTbbN4ZqZoO2i7/45ygV
         7fLA==
X-Forwarded-Encrypted: i=1; AJvYcCUo5ycgCwqf4q24M2pKT3HiaQcSYfvLQFLPPZKwOhQJImgmMn9SO+1RgHH5YBJ46sQgol8OhIRACq+fOz2ALc3EDoCsYCw+jF8s8qhhQbdSrjDqz8v7FeZ2tz6eKNX8S3ETvwdWiFXEMjnrMA==
X-Gm-Message-State: AOJu0YzJXiArExJCh/pTPzFoVbhdlGaZaiEQkArcrJvd1J2OE8QWt2nk
	1lyNteUDKLhb6l+HVaBt5ME6xAz1K3JgOYYCaTKFDjEoNC3NHVHP
X-Google-Smtp-Source: AGHT+IHOHgOV5KfcbAHpPBEybS7gZtuCWClYCtSSsDL10GhDISwPoib2yuCo/llxqYqyy0WRMjF5Ew==
X-Received: by 2002:adf:a3c2:0:b0:354:fbb6:1b16 with SMTP id ffacd0b85a97d-35e8ef8fecdmr4510321f8f.52.1717682721313;
        Thu, 06 Jun 2024 07:05:21 -0700 (PDT)
Received: from f.. (cst-prg-5-143.cust.vodafone.cz. [46.135.5.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d484absm1653328f8f.30.2024.06.06.07.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:05:20 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Date: Thu,  6 Jun 2024 16:05:15 +0200
Message-ID: <20240606140515.216424-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instantiating a new inode normally takes the global inode hash lock
twice:
1. once to check if it happens to already be present
2. once to add it to the hash

The back-to-back lock/unlock pattern is known to degrade performance
significantly, which is further exacerbated if the hash is heavily
populated (long chains to walk, extending hold time). Arguably hash
sizing and hashing algo need to be revisited, but that's beyond the
scope of this patch.

A long term fix would introduce fine-grained locking, this was attempted
in [1], but that patchset was already posted several times and appears
stalled.

A simpler idea which solves majority of the problem and which may be
good enough for the time being is to use RCU for the initial lookup.
Basic RCU support is already present in the hash, it is just not being
used for lookup on inode creation.

iget_locked consumers (notably ext4) get away without any changes
because inode comparison method is built-in.

iget5_locked and ilookup5_nowait consumers pass a custom callback. Since
removal of locking adds more problems (inode can be changing) it's not
safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu
ilookup5_nowait_rcu get added, requiring manual conversion.

In order to reduce code duplication find_inode and find_inode_fast grow
an argument indicating whether inode hash lock is held, which is passed
down should sleeping be necessary. They always rcu_read_lock, which is
redundant but harmless. Doing it conditionally reduces readability for
no real gain that I can see. RCU-alike restrictions were already put on
callbacks due to the hash spinlock being held.

Benchmarked with the following: a 32-core vm with 24GB of RAM, a
dedicated fs partition. 20 separate trees with 1000 directories * 1000
files.  Then walked by 20 processes issuing stat on files, each on a
dedicated tree. Testcase is at [2].

In this particular workload, mimicking a real-world setup $elsewhere,
the initial lookup is guaranteed to fail, guaranteeing the 2 lock
acquires. At the same time RAM is scarce enough enough compared to the
demand that inodes keep needing to be recycled.

Total real time fluctuates by 1-2s, sample results:

ext4 (needed mkfs.ext4 -N 24000000):
before:	3.77s user 890.90s system 1939% cpu 46.118 total
after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)

btrfs (s/iget5_locked/iget5_locked_rcu in fs/btrfs/inode.c):
before: 3.54s user 892.30s system 1966% cpu 45.549 total
after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)

btrfs is heavily bottlenecked on its own locks, so the improvement is
small in comparison.

[1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/
[2] https://people.freebsd.org/~mjg/fstree.tgz

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is an initial submission to gauge interest.

I do claim this provides great bang for the buck, I don't claim it
solves the problem overall. *something* finer-grained will need to
land.

I wanted to add bcachefs to the list, but I ran into memory reclamation
issues again (first time here:
https://lore.kernel.org/all/CAGudoHGenxzk0ZqPXXi1_QDbfqQhGHu+wUwzyS6WmfkUZ1HiXA@mail.gmail.com/),
did not have time to mess with diagnostic to write a report yet.

I'll post a patchset with this (+ tidy ups to comments and whatnot) +
btrfs + bcachefs conversion after the above gets reported and sorted
out.

Also interestingly things improved since last year, when Linux needed
about a minute.

 fs/inode.c         | 106 +++++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h |  10 ++++-
 2 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..f40b868f491f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -886,36 +886,43 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
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
 
@@ -924,29 +931,37 @@ static struct inode *find_inode(struct super_block *sb,
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
 
@@ -1161,7 +1176,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 
 again:
 	spin_lock(&inode_hash_lock);
-	old = find_inode(inode->i_sb, head, test, data);
+	old = find_inode(inode->i_sb, head, test, data, true);
 	if (unlikely(old)) {
 		/*
 		 * Uhhuh, somebody else created the same inode under us.
@@ -1245,6 +1260,43 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 }
 EXPORT_SYMBOL(iget5_locked);
 
+/**
+ * iget5_locked_rcu - obtain an inode from a mounted file system
+ *
+ * This is equivalent to iget5_locked, except the @test callback must
+ * tolerate inode not being stable, including being mid-teardown.
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
+EXPORT_SYMBOL(iget5_locked_rcu);
+
 /**
  * iget_locked - obtain an inode from a mounted file system
  * @sb:		super block of file system
@@ -1263,9 +1315,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
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
@@ -1283,7 +1333,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 
 		spin_lock(&inode_hash_lock);
 		/* We released the lock, so.. */
-		old = find_inode_fast(sb, head, ino);
+		old = find_inode_fast(sb, head, ino, true);
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
@@ -1419,13 +1469,31 @@ struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
 	struct inode *inode;
 
 	spin_lock(&inode_hash_lock);
-	inode = find_inode(sb, head, test, data);
+	inode = find_inode(sb, head, test, data, true);
 	spin_unlock(&inode_hash_lock);
 
 	return IS_ERR(inode) ? NULL : inode;
 }
 EXPORT_SYMBOL(ilookup5_nowait);
 
+/**
+ * ilookup5_nowait_rcu - search for an inode in the inode cache
+ *
+ * This is equivalent to ilookup5_nowait, except the @test callback must
+ * tolerate inode not being stable, including being mid-teardown.
+ */
+struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data)
+{
+	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
+	struct inode *inode;
+
+	inode = find_inode(sb, head, test, data, false);
+
+	return IS_ERR(inode) ? NULL : inode;
+}
+EXPORT_SYMBOL(ilookup5_nowait_rcu);
+
 /**
  * ilookup5 - search for an inode in the inode cache
  * @sb:		super block of file system to search
@@ -1474,7 +1542,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	struct inode *inode;
 again:
 	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
+	inode = find_inode_fast(sb, head, ino, true);
 	spin_unlock(&inode_hash_lock);
 
 	if (inode) {
@@ -2235,17 +2303,21 @@ EXPORT_SYMBOL(inode_needs_sync);
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
index 0283cf366c2a..2817c915d355 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3021,6 +3021,9 @@ extern void d_mark_dontcache(struct inode *inode);
 extern struct inode *ilookup5_nowait(struct super_block *sb,
 		unsigned long hashval, int (*test)(struct inode *, void *),
 		void *data);
+extern struct inode *ilookup5_nowait_rcu(struct super_block *sb,
+		unsigned long hashval, int (*test)(struct inode *, void *),
+		void *data);
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data);
 extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
@@ -3029,7 +3032,12 @@ extern struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 		int (*test)(struct inode *, void *),
 		int (*set)(struct inode *, void *),
 		void *data);
-extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
+extern struct inode * iget5_locked(struct super_block *, unsigned long,
+				   int (*test)(struct inode *, void *),
+				   int (*set)(struct inode *, void *), void *);
+extern struct inode * iget5_locked_rcu(struct super_block *, unsigned long,
+				       int (*test)(struct inode *, void *),
+				       int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);
 extern struct inode *find_inode_nowait(struct super_block *,
 				       unsigned long,
-- 
2.43.0


