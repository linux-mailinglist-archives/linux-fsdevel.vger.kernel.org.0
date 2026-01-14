Return-Path: <linux-fsdevel+bounces-73651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E4BD1DB04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32FD4300558E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7CE36B042;
	Wed, 14 Jan 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9qpQBi7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795034D4F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384046; cv=none; b=GsJqSk3Ne4Dk0nMxkQW3qAh0ZUoEFOIPL2FGWajkR4AywiaqQlL95Lb/t+SsTcw+vchBgMW5YKIoJ4mEfAF/Vge2ZgIusXXulwFr1vIzmlYO9a/wtT4mZrz/G5XQHUUebxbTQaxMNcDFlv1V7C+cEKFLzng+dlVWd8zBc0E8vp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384046; c=relaxed/simple;
	bh=7lPFQylPXc3CQb5CpLAmjWiXpGsB0agm+Fa00+nsTSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gyzf7LjzSLLihmThh1a2UuGPyXZWPFW89g52tvR0fwlQQvyPsa4iusOVCopsjifv3HGprzUIesdsfxeUaGXIjJPt/Jo5WE5wpC/HeFu1OBSCZiMO1DBcavl1A0nEX2x5XJj2YO5kYnnkgqwxQgeyEQfkyanIGQT3PNCN8JNTQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9qpQBi7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so13582916a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 01:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768384043; x=1768988843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTMoV76WS/2nFd0nWu1noI9EQv5QDwFEJLeNSydz65s=;
        b=V9qpQBi7KTeytPukGoSdbDS9tEiT5h6P/CzIuEg9FxWoIP/kLJwXiUynJKIMbLHmYl
         nqFDOwrvw8881rRQIpUQEdQKBqgK5WKNXAMU8xcJCdaG47zjyhr0tnf5I6MeTF9LXn3/
         eeeDrIqYsMgHtJIorDq+uGsbVPj60fC4V0ItBtkuvQBWKGLz52/g1tO4mpASlXMPCgaT
         09pbGPOhOKl/uyt1+W/6/ebqU2SoUIeUMcWRruV9W7pAmScjGJxShBlwX7Ll1Bu/oyBE
         70jp3SUV5udkA9bgd99iKOAe6yW3pg2jmvjBnDyyTjE52pLB51o2Tm0WVNABe7G3UtCa
         yGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384043; x=1768988843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTMoV76WS/2nFd0nWu1noI9EQv5QDwFEJLeNSydz65s=;
        b=NeASMvvoHeCLrMqYfMhLfJjHME3TDonFsG44hesXAWXArjUCqo5sCan3tgfuN+4C0K
         ti3nHbQgVgpoDT7k/zdc2R2VigXcK2/yrmabzie0eHTZOq6ituIdWHFUZJIGd+i9yzZ6
         ztIyJ57FVfcqz1Ie1eP9uOTjk5Xf44TuDec7C0sHnjNlXB5B3mrEaKnA4ampRAAJAHNE
         pMZu1dIvLaxKyB6mJ8NXfT7IRQRsoNADlo5DPiS1v7r+9+yWjhT6KTEA4lOwY0f2Onb8
         n96MGxSMLbEQdpyvPWNe0/xYRzk56ZNC2YRVwEEz/N1O3/xmLc9YuTD7Y3LuQiixr9kN
         tXqw==
X-Forwarded-Encrypted: i=1; AJvYcCWaqFFM7wLWsyILkq3RPjA3quZUJreeVi+cPV2/SO77JWLY5AGBSiPzNv7m11d4uCyKXUCK29q/Tea9TlQm@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIY1p7mqAttOgzYGTxWlp7sF7Y7YROWBZa3YI2rSW4/oNFZJR
	GpzpzDf0OdW8gidiEp4FyvPutHUjygxhtq3L8NVkgBn4VzBkCCf5qEAX
X-Gm-Gg: AY/fxX6MmoiC7U5y1aK7i0f0gTBe9MgiKvaQAjjd8bcsMZPPQX9SNH8+kAGspEp10Hu
	TK6I7NtngoUwCCQIlItfyeV8Rw9jwll50e/pVMZHU+xYAvzWJCD4LlBH2oMc3DAG5K09Q8VSiij
	TAszXndm6Uh2xIiSeQksVWhncAVd23rWcJhN4HcZgq/hI7gKv76TNmjvjIDDE3kJ7DBZydc4+ko
	1YTNDDP+6iCwhMWgCQZsWVLSe4behoenA41p5Xz7MwJyhTs2iHd5NB0g4+d9AFbcRKQ5LjRyecc
	2kRkMSH8qoGXmfx4NBPpGM6ZTpZvglwhqfdZzoT3LmbdytNCf+lUT211cFmAh16eyLrD1PiA6/z
	yKHseRH5X3WoucOaKYa9dNfN2yK/rOav4koGyOrchh0khc+Uc0/9sbSB6nORo4sZWTz0lkrxqwd
	bYdW4boyE8QZtIkpBFvhUAUybpE4NUNmqH7/RHy1HmbpDXZEhsFOj/pEULZwg=
X-Received: by 2002:a17:907:26cd:b0:b87:3395:7f05 with SMTP id a640c23a62f3a-b87613da2a6mr170071166b.62.1768384042822;
        Wed, 14 Jan 2026 01:47:22 -0800 (PST)
Received: from f.. (cst-prg-93-36.cust.vodafone.cz. [46.135.93.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87162bf433sm931732266b.33.2026.01.14.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:47:22 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	yi1.lai@linux.intel.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: make insert_inode_locked() wait for inode destruction
Date: Wed, 14 Jan 2026 10:47:16 +0100
Message-ID: <20260114094717.236202-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the only routine which instead skipped instead of waiting.

The current behavior is arguably a bug as it results in a corner case
where the inode hash can have *two* matching inodes, one of which is on
its way out.

Ironing out this difference is an incremental step towards sanitizing
the API.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- add a way to avoid the rcu dance in __wait_on_freeing_inode


 fs/inode.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8a47c4da603f..a4cfe9182a7c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1028,19 +1028,20 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 	return freed;
 }
 
-static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
+static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
+
 /*
  * Called with the inode lock held.
  */
 static struct inode *find_inode(struct super_block *sb,
 				struct hlist_head *head,
 				int (*test)(struct inode *, void *),
-				void *data, bool is_inode_hash_locked,
+				void *data, bool hash_locked,
 				bool *isnew)
 {
 	struct inode *inode = NULL;
 
-	if (is_inode_hash_locked)
+	if (hash_locked)
 		lockdep_assert_held(&inode_hash_lock);
 	else
 		lockdep_assert_not_held(&inode_hash_lock);
@@ -1054,7 +1055,7 @@ static struct inode *find_inode(struct super_block *sb,
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			__wait_on_freeing_inode(inode, hash_locked, true);
 			goto repeat;
 		}
 		if (unlikely(inode_state_read(inode) & I_CREATING)) {
@@ -1078,11 +1079,11 @@ static struct inode *find_inode(struct super_block *sb,
  */
 static struct inode *find_inode_fast(struct super_block *sb,
 				struct hlist_head *head, unsigned long ino,
-				bool is_inode_hash_locked, bool *isnew)
+				bool hash_locked, bool *isnew)
 {
 	struct inode *inode = NULL;
 
-	if (is_inode_hash_locked)
+	if (hash_locked)
 		lockdep_assert_held(&inode_hash_lock);
 	else
 		lockdep_assert_not_held(&inode_hash_lock);
@@ -1096,7 +1097,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			__wait_on_freeing_inode(inode, hash_locked, true);
 			goto repeat;
 		}
 		if (unlikely(inode_state_read(inode) & I_CREATING)) {
@@ -1832,16 +1833,13 @@ int insert_inode_locked(struct inode *inode)
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
+repeat:
 		hlist_for_each_entry(old, head, i_hash) {
 			if (old->i_ino != ino)
 				continue;
 			if (old->i_sb != sb)
 				continue;
 			spin_lock(&old->i_lock);
-			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
-				continue;
-			}
 			break;
 		}
 		if (likely(!old)) {
@@ -1852,6 +1850,11 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
+			__wait_on_freeing_inode(old, true, false);
+			old = NULL;
+			goto repeat;
+		}
 		if (unlikely(inode_state_read(old) & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
@@ -2522,16 +2525,18 @@ EXPORT_SYMBOL(inode_needs_sync);
  * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
  * will DTRT.
  */
-static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked)
+static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked)
 {
 	struct wait_bit_queue_entry wqe;
 	struct wait_queue_head *wq_head;
 
+	VFS_BUG_ON(!hash_locked && !rcu_locked);
+
 	/*
 	 * Handle racing against evict(), see that routine for more details.
 	 */
 	if (unlikely(inode_unhashed(inode))) {
-		WARN_ON(is_inode_hash_locked);
+		WARN_ON(hash_locked);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
@@ -2539,14 +2544,16 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
 	wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
 	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-	rcu_read_unlock();
-	if (is_inode_hash_locked)
+	if (rcu_locked)
+		rcu_read_unlock();
+	if (hash_locked)
 		spin_unlock(&inode_hash_lock);
 	schedule();
 	finish_wait(wq_head, &wqe.wq_entry);
-	if (is_inode_hash_locked)
+	if (hash_locked)
 		spin_lock(&inode_hash_lock);
-	rcu_read_lock();
+	if (rcu_locked)
+		rcu_read_lock();
 }
 
 static __initdata unsigned long ihash_entries;
-- 
2.48.1


