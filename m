Return-Path: <linux-fsdevel+bounces-21401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92149038AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941A41C23743
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669117B407;
	Tue, 11 Jun 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqp4SDkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0A17966E;
	Tue, 11 Jun 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101008; cv=none; b=eJ/+P0ZdbilZggiTFzqHa7O42/ZmCHmKX5r9Uid8hBWiQ1SDRZdOR/Q6RIjwnc1Ljw7YBWxBcN/006HgCwAa/cMHk6jgxmR8JU4LSVcVBZbHBTHGjJj/cOrcUZ5+ECflHWg1WYyVT7J589j6/LGchdv64wP6EcZbv4ZM8rOs92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101008; c=relaxed/simple;
	bh=GJip/5Xaea9HOgfvAdnPM1xRHYd1ANP/E+2tcG5b1Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmOn7zxEZBsjreF5Ih0C7rA/8bIEkbtQ+Jx4DdTbDGihNc3b5QGUGo50wPcGVLvUNBuUfVEx4QIMZ1KB6NcC0F+VE03DBm1IS9ODt/UT/mtkjPQoTxYfjTNIY6tnyxQAPOGEDeDCztSwE/jphPj6CBz6LV3RfKbSWc86DxnTih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqp4SDkd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421eab59723so14831975e9.3;
        Tue, 11 Jun 2024 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718101005; x=1718705805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tfbpp2/Mza4Dhnt7fnAbluGpGy7jve6tKErJLwOJn64=;
        b=Gqp4SDkdzadXzhOPG5hTWIBHPdNGCdQE8VP8NTnjNWvzRcWpT13aiTLwh8v5lNnS61
         sYpRiuWpjhnNMigNVAQzZgtC0N3+aBmb8HpkiPe/lTKxp2aLtnr3Pnsmt0Zoggwbwk37
         JDZvDlqrxhWgpy52PqgjZxCM4Dgi3qtdQ9VhHxAOlaMuU8jrxiUbLSfkctvkfHT4y4at
         FkOCHnvgpjghmXNP4sxw11xaWGqHHkUAXER6TS44oF5UYJF0ZIvQ/HTUgpUO2b0FRXxs
         iVXN77FlzLkewdRD+byJKgALnAfpj+RrnCfSBHIVHCA3lpItFEfeAzevO7BDbsJNnprx
         +p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101005; x=1718705805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tfbpp2/Mza4Dhnt7fnAbluGpGy7jve6tKErJLwOJn64=;
        b=spWlAh/Hq1oWONBibR0bcCXmplThI/K61qmJYckcqMAVmvr+kg1fgMXPfb4HcKRRWe
         tORJfgvcKEHcPGrBPDsE9j3rJdlD/NytwfYYQcoIxKs8dJiep8iW4lFYA4WHk3I4IYUr
         Q5BglNjtCS9jtWaWQzHgYBZWO1plIx/ATqVe7TpFZHGW8STfKfhS2RPAQIUZvTGiGigi
         nKtZ8OLQLlZTffLUAZq8oJXdymSkQFl2aqoVpokPkFgywi3Yo5qDpZcnsGxOCkmh06AW
         OtV5su7xcWMK64flPJpf48ArMkq3t/R/pmphnTfToWCXClxYQhbmvKZXMnNNfW+tt0gX
         5e/w==
X-Forwarded-Encrypted: i=1; AJvYcCUaGjM4dYuJ05AXqAUp3BgYRxFK405FFDic09bmJeAc2PRD4pI4/+AryGrjcaqD+aeasvaO7kpt/CaQouUWru+5Nt1PAot08smvyqo58JkCY71vslriOBQDRrvmyaUPRSJfAkAH71PGvlc41NFmDE5yk5VMHfSdSuUhksPpu3/yiKtAiar9MQYk
X-Gm-Message-State: AOJu0YwN3MSKy3sBAw9RDtd8QyMPbYCqLZYTrDmeKmRbjI74PVLjiLGv
	rgU5rpMY6+abqy/FEDwNz5ttM1ZwdeVMtCjW28r33VI+s0FwBJaw
X-Google-Smtp-Source: AGHT+IGZ40s/t4zXuxLEDbT6UwuDMtm6fHT/AGDshxOxG50vum1oVRjFwldavwWZQsA7wE4vIzEFKw==
X-Received: by 2002:a05:600c:4e8a:b0:421:7ee4:bbe8 with SMTP id 5b1f17b1804b1-4217ee4be2dmr61477825e9.19.1718101004717;
        Tue, 11 Jun 2024 03:16:44 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa1desm173481275e9.11.2024.06.11.03.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:16:44 -0700 (PDT)
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
Subject: [PATCH v3 1/2] vfs: add rcu-based find_inode variants for iget ops
Date: Tue, 11 Jun 2024 12:16:31 +0200
Message-ID: <20240611101633.507101-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611101633.507101-1-mjguzik@gmail.com>
References: <20240611101633.507101-1-mjguzik@gmail.com>
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

A long term fix would introduce finer-grained locking. An attempt was
made several times, most recently in [1], but the effort appears
stalled.

A simpler idea which solves majority of the problem and which may be
good enough for the time being is to use RCU for the initial lookup.
Basic RCU support is already present in the hash. This being a temporary
measure I tried to keep the change as small as possible.

iget_locked consumers (notably ext4) get away without any changes
because inode comparison method is built-in.

iget5_locked and ilookup5_nowait consumers pass a custom callback. Since
removal of locking adds more problems (inode can be changing) it's not
safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu,
ilookup5_rcu and ilookup5_nowait_rcu get added, requiring manual
conversion.

In order to reduce code duplication find_inode and find_inode_fast grow
an argument indicating whether inode hash lock is held, which is passed
down should sleeping be necessary. They always rcu_read_lock, which is
redundant but harmless. Doing it conditionally reduces readability for
no real gain that I can see. RCU-alike restrictions were already put on
callbacks due to the hash spinlock being held.

There is a real cache-busting workload scanning millions of files in
parallel (it's a backup server thing), where the initial lookup is
guaranteed to fail resulting in the 2 lock acquires.

Implemented below is a synthehic benchmark which provides the same
behavior. [I shall note the workload is not running on Linux, instead it
was causing trouble elsewhere. Benchmark below was used while addressing
said problems and was found to adequately represent the real workload.]

Total real time fluctuates by 1-2s.

With 20 threads each walking a dedicated 1000 dirs * 1000 files
directory tree to stat(2) on a 32 core + 24GB RAM vm:

ext4 (needed mkfs.ext4 -N 24000000):
before:	3.77s user 890.90s system 1939% cpu 46.118 total
after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)

Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz

[1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbit.com/

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 135 +++++++++++++++++++++++++++++++++++++++------
 include/linux/fs.h |  12 +++-
 2 files changed, 129 insertions(+), 18 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..95a093c257ad 100644
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
@@ -1245,6 +1264,37 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
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
+ * This is equivalent to iget5, except the @test callback must
+ * tolerate the inode not being stable, including being mid-teardown.
+ */
+struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *),
+		int (*set)(struct inode *, void *), void *data)
+{
+	struct inode *inode = ilookup5_rcu(sb, hashval, test, data);
+
+	if (!inode) {
+		struct inode *new = alloc_inode(sb);
+
+		if (new) {
+			new->i_state = 0;
+			inode = inode_insert5(new, hashval, test, set, data);
+			if (unlikely(inode != new))
+				destroy_inode(new);
+		}
+	}
+	return inode;
+}
+EXPORT_SYMBOL_GPL(iget5_locked_rcu);
+
 /**
  * iget_locked - obtain an inode from a mounted file system
  * @sb:		super block of file system
@@ -1263,9 +1313,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
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
@@ -1283,7 +1331,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 
 		spin_lock(&inode_hash_lock);
 		/* We released the lock, so.. */
-		old = find_inode_fast(sb, head, ino);
+		old = find_inode_fast(sb, head, ino, true);
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
@@ -1419,13 +1467,35 @@ struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
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
+ * @sb:		super block of file system to search
+ * @hashval:	hash value (usually inode number) to search for
+ * @test:	callback used for comparisons between inodes
+ * @data:	opaque data pointer to pass to @test
+ *
+ * This is equivalent to ilookup5_nowait, except the @test callback must
+ * tolerate the inode not being stable, including being mid-teardown.
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
+EXPORT_SYMBOL_GPL(ilookup5_nowait_rcu);
+
 /**
  * ilookup5 - search for an inode in the inode cache
  * @sb:		super block of file system to search
@@ -1460,6 +1530,33 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 }
 EXPORT_SYMBOL(ilookup5);
 
+/**
+ * ilookup5 - search for an inode in the inode cache
+ * @sb:		super block of file system to search
+ * @hashval:	hash value (usually inode number) to search for
+ * @test:	callback used for comparisons between inodes
+ * @data:	opaque data pointer to pass to @test
+ *
+ * This is equivalent to ilookup5, except the @test callback must
+ * tolerate the inode not being stable, including being mid-teardown.
+ */
+struct inode *ilookup5_rcu(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data)
+{
+	struct inode *inode;
+again:
+	inode = ilookup5_nowait_rcu(sb, hashval, test, data);
+	if (inode) {
+		wait_on_inode(inode);
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
+		}
+	}
+	return inode;
+}
+EXPORT_SYMBOL_GPL(ilookup5_rcu);
+
 /**
  * ilookup - search for an inode in the inode cache
  * @sb:		super block of file system to search
@@ -1474,7 +1571,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	struct inode *inode;
 again:
 	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
+	inode = find_inode_fast(sb, head, ino, true);
 	spin_unlock(&inode_hash_lock);
 
 	if (inode) {
@@ -2235,17 +2332,21 @@ EXPORT_SYMBOL(inode_needs_sync);
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
index bfc1e6407bf6..9d4109fd22c9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3037,15 +3037,25 @@ extern void d_mark_dontcache(struct inode *inode);
 extern struct inode *ilookup5_nowait(struct super_block *sb,
 		unsigned long hashval, int (*test)(struct inode *, void *),
 		void *data);
+struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data);
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data);
+struct inode *ilookup5_rcu(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data);
+
 extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
 
 extern struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
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


