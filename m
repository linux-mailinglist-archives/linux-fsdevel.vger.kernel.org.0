Return-Path: <linux-fsdevel+bounces-58654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167FDB30668
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A2A6235BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0662372891;
	Thu, 21 Aug 2025 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LK/o72d5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737C38C5EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807644; cv=none; b=DYmg1qKfytvz/PAsLoXiKskbsyEz5K+szFstrFD7N8mRWWUWqHV8FTWGYx0QeFc2hM41TrYYtt27Gjv1bHxY1JzBoBb9hdQlIH3bVxTC35XjdO6HL/gtPwoBkWhPCqKD6hJQ4eNO5g1hzjPn+fE4WiVm5X5Z+P3RAqEg950Kim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807644; c=relaxed/simple;
	bh=fV5p/+3awxS75ougA5RV42vDHNVvkZqAGNAVTWctFuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdyC7jCU02UPjqnOfV2IU9OnrP16Wn3UwFw7En02j6hlrXN+l/l4QpaBwSduCaOCOgPMCgI79dsrpDh6SjORwNRqXGg48oec07kFJK4bicWtr5aPbUVGqdnZ/YxDHwFmnUHBLinIgdAXcoP5TPx0heacjG865T9Nj1qQFaNAdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LK/o72d5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e9503150139so1445825276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807641; x=1756412441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlcmYDvnqYhjm+UZirxbL4gj7Pts3JE90eIbPqyUpTA=;
        b=LK/o72d5wjXFV/UYJTJmveL65za1dS8XOI5hm0M11UzI2TyC9PnjdeoJnZvIJGk+Nl
         ZO/V0xLGprHWDekv9viPUBtcc+v5oGAVcfFxOcGe0IbbWo5P/Fu42XhPNKHnF7yvyvzh
         qaNeTc2J78GBfut0FgWWsMige+3J5lSILsNeZnRx7EreVqUhYhPsi4SjM72FOfwnQim2
         W34IdUYCZBLcu8xBLkD10RryY3eIcBsKqEOCUxKmyLrhi+/7oPIO4T4TjMH7XTSam1je
         tY4qwgR70S5Z31dEyjp6hwWAK03fzu8qnMY4o5SdYIYym8Dk7CHBwLA43TX12Ga9GfaR
         DhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807641; x=1756412441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlcmYDvnqYhjm+UZirxbL4gj7Pts3JE90eIbPqyUpTA=;
        b=Dtsq63xQsCckZ3/SZ57DmNXfduHh0UXGV5Z75QF94I1c0KNumn9xQmWW7/kIgVfxnS
         rNN0yryavLc/uY4BBTw4fJMp9cYW9p9y4/exdwAU3cRrEuYY0BEP6CpXZNHO0J4d7a7q
         HfjJ98OXpjSeCeCgw75c1Eygda3EDJUCNs/jGn07C54mSbYVavQbtPhB9moJJY1VNx57
         hSIrb3WQv+RNUsfJ6/O/6xImAE/hlwmDmq5WND/PpNihDyWzwmVEEu0o2AJqjjntyGlk
         472jk7mmFJN3KmDod/scG54sUaF561iIarw1QeGc3P5lP4QIUiMIMPx3FApczGKJqKLB
         bnLg==
X-Gm-Message-State: AOJu0YyhwCkHFEifzfLuIhXE5LZ3xE/7JE8vlCqgTL6RkJXh/WuMX26+
	/A8P8lLckyz8argISKksb19DNgIY63WzVp1R1yctiiAuJHqX8KzuGCmeU1SSa+3KQbfcGA9rYfu
	LZaYTRAZ+1A==
X-Gm-Gg: ASbGncvyt8mQU+hTO4gxcV66Kb9JiBLNm5HJcwejsvmsrttzIO2j41VH3XGq9faUmiF
	G7O0NdOy6GPd3GbVWk4M6+v6VUZ5+0mRKZ6Ly1iYV6Wpbd413bIU+7Tlnf7e5VVUehHwixZGapm
	lD9gf7JbXwFWKkAEgA+jOKwGx5HMidXHVb8buLYhsMXbt/aew7uZ9QaGJkm2BMtH0sOXBLdrlxS
	g4WOdb+gv9mc0plONlTnl49pEE78PR63nCm3XgbUdWdgIb7h+fIPBFwG2BajNPjFhHePT7kKI3Z
	UuPGXPFWnhXZiJEircOmhh9xUJHaP9x1H9bP9rKEl4xoU5rHeYzJXT76gGQ84XYJzBywMYaTxi/
	4FVJhY5NiFIe4FyWgRh2CSsWt9I7FIZmRf2D3Oia8exFYIrFr1NgTC4ZcQd4=
X-Google-Smtp-Source: AGHT+IEVGb30aTlZ6mqpJ2U2JFl9khTbNBKHKrEIMKIZlP6Ngd604yyjXYVk+eDHagq4Pn/qTd3rqQ==
X-Received: by 2002:a05:6902:3483:b0:e93:48c7:1c8a with SMTP id 3f1490d57ef6-e951c2e8641mr901346276.19.1755807640575;
        Thu, 21 Aug 2025 13:20:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e93456fa756sm5217450276.30.2025.08.21.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 17/50] fs: hold a full ref while the inode is on a LRU
Date: Thu, 21 Aug 2025 16:18:28 -0400
Message-ID: <113ec167162bbaccc02fa3c3bf1a2c7d3e5a3e82.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to eliminate 0 refcount inodes that can be used. To that end,
make the LRU's hold a full reference on the inode while it is on an LRU
list. From there we can change the eviction code to always just iput the
inode, and the LRU operations will just add or drop a full reference
where appropriate.

We also now must take into account unlink, and drop our LRU reference
when we go to an nlink of 0.  We will also avoid adding inodes with a
nlink of 0 as they can be reclaimed immediately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 105 +++++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 80ad327746a7..de0ec791f9a3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -434,8 +434,18 @@ void drop_nlink(struct inode *inode)
 {
 	WARN_ON(inode->i_nlink == 0);
 	inode->__i_nlink--;
-	if (!inode->i_nlink)
+	if (!inode->i_nlink) {
+		/*
+		 * LRU's hold a full ref on the inode, but if we've unlinked it
+		 * then we want the inode to be freed when the last user goes,
+		 * so delete the inode from the LRU list.
+		 */
+		spin_lock(&inode->i_lock);
+		inode_lru_list_del(inode);
+		spin_unlock(&inode->i_lock);
+
 		atomic_long_inc(&inode->i_sb->s_remove_count);
+	}
 }
 EXPORT_SYMBOL(drop_nlink);
 
@@ -451,6 +461,12 @@ void clear_nlink(struct inode *inode)
 {
 	if (inode->i_nlink) {
 		inode->__i_nlink = 0;
+
+		/* See comment in drop_nlink(). */
+		spin_lock(&inode->i_lock);
+		inode_lru_list_del(inode);
+		spin_unlock(&inode->i_lock);
+
 		atomic_long_inc(&inode->i_sb->s_remove_count);
 	}
 }
@@ -555,6 +571,8 @@ static void inode_add_cached_lru(struct inode *inode)
 
 	if (inode->i_state & I_CACHED_LRU)
 		return;
+	if (inode->__i_nlink == 0)
+		return;
 	if (!list_empty(&inode->i_lru))
 		return;
 
@@ -562,7 +580,7 @@ static void inode_add_cached_lru(struct inode *inode)
 	spin_lock(&inode->i_sb->s_cached_inodes_lock);
 	list_add(&inode->i_lru, &inode->i_sb->s_cached_inodes);
 	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
-	iobj_get(inode);
+	__iget(inode);
 }
 
 static bool __inode_del_cached_lru(struct inode *inode)
@@ -582,7 +600,7 @@ static bool __inode_del_cached_lru(struct inode *inode)
 static bool inode_del_cached_lru(struct inode *inode)
 {
 	if (__inode_del_cached_lru(inode)) {
-		iobj_put(inode);
+		iput(inode);
 		return true;
 	}
 	return false;
@@ -598,6 +616,8 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 		return;
 	if (atomic_read(&inode->i_count))
 		return;
+	if (inode->__i_nlink == 0)
+		return;
 	if (!(inode->i_sb->s_flags & SB_ACTIVE))
 		return;
 	if (inode_needs_cached(inode)) {
@@ -609,7 +629,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		inode->i_state |= I_LRU;
 		if (need_ref)
-			iobj_get(inode);
+			__iget(inode);
 		this_cpu_inc(nr_unused);
 	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
@@ -655,7 +675,7 @@ void inode_lru_list_del(struct inode *inode)
 
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		inode->i_state &= ~I_LRU;
-		iobj_put(inode);
+		iput(inode);
 		this_cpu_dec(nr_unused);
 	}
 }
@@ -926,6 +946,7 @@ static void evict(struct inode *inode)
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 }
 
+static void iput_evict(struct inode *inode);
 /*
  * dispose_list - dispose of the contents of a local list
  * @head: the head of the list to free
@@ -933,20 +954,14 @@ static void evict(struct inode *inode)
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
  */
-static void dispose_list(struct list_head *head, bool for_lru)
+static void dispose_list(struct list_head *head)
 {
 	while (!list_empty(head)) {
 		struct inode *inode;
 
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
-
-		if (for_lru) {
-			evict(inode);
-			iobj_put(inode);
-		} else {
-			iput(inode);
-		}
+		iput_evict(inode);
 		cond_resched();
 	}
 }
@@ -987,13 +1002,13 @@ void evict_inodes(struct super_block *sb)
 		if (need_resched()) {
 			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
-			dispose_list(&dispose, false);
+			dispose_list(&dispose);
 			goto again;
 		}
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 
-	dispose_list(&dispose, false);
+	dispose_list(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
@@ -1031,22 +1046,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (inode_needs_cached(inode)) {
 		list_lru_isolate(lru, &inode->i_lru);
 		inode_add_cached_lru(inode);
-		iobj_put(inode);
-		spin_unlock(&inode->i_lock);
-		this_cpu_dec(nr_unused);
-		return LRU_REMOVED;
-	}
-
-	/*
-	 * Inodes can get referenced, redirtied, or repopulated while
-	 * they're already on the LRU, and this can make them
-	 * unreclaimable for a while. Remove them lazily here; iput,
-	 * sync, or the last page cache deletion will requeue them.
-	 */
-	if (atomic_read(&inode->i_count) ||
-	    (inode->i_state & ~I_REFERENCED)) {
-		list_lru_isolate(lru, &inode->i_lru);
-		inode->i_state &= ~I_LRU;
+		iput(inode);
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
@@ -1082,7 +1082,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	}
 
 	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state |= I_FREEING;
 	inode->i_state &= ~I_LRU;
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
@@ -1104,7 +1103,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 
 	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
 				     inode_lru_isolate, &freeable);
-	dispose_list(&freeable, true);
+	dispose_list(&freeable);
 	return freed;
 }
 
@@ -1967,7 +1966,7 @@ EXPORT_SYMBOL(generic_delete_inode);
  * in cache if fs is alive, sync and evict if fs is
  * shutting down.
  */
-static void iput_final(struct inode *inode)
+static void iput_final(struct inode *inode, bool skip_lru)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct super_operations *op = inode->i_sb->s_op;
@@ -1981,7 +1980,7 @@ static void iput_final(struct inode *inode)
 	else
 		drop = generic_drop_inode(inode);
 
-	if (!drop &&
+	if (!drop && !skip_lru &&
 	    !(inode->i_state & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
 		__inode_add_lru(inode, true);
@@ -1989,6 +1988,8 @@ static void iput_final(struct inode *inode)
 		return;
 	}
 
+	WARN_ON(!list_empty(&inode->i_lru));
+
 	state = inode->i_state;
 	if (!drop) {
 		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
@@ -2003,23 +2004,12 @@ static void iput_final(struct inode *inode)
 	}
 
 	WRITE_ONCE(inode->i_state, state | I_FREEING);
-	if (!list_empty(&inode->i_lru))
-		inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
 
 	evict(inode);
 }
 
-/**
- *	iput	- put an inode
- *	@inode: inode to put
- *
- *	Puts an inode, dropping its usage count. If the inode use count hits
- *	zero, the inode is then freed and may also be destroyed.
- *
- *	Consequently, iput() can sleep.
- */
-void iput(struct inode *inode)
+static void __iput(struct inode *inode, bool skip_lru)
 {
 	if (!inode)
 		return;
@@ -2037,12 +2027,31 @@ void iput(struct inode *inode)
 
 	spin_lock(&inode->i_lock);
 	if (atomic_dec_and_test(&inode->i_count))
-		iput_final(inode);
+		iput_final(inode, skip_lru);
 	else
 		spin_unlock(&inode->i_lock);
 
 	iobj_put(inode);
 }
+
+static void iput_evict(struct inode *inode)
+{
+	__iput(inode, true);
+}
+
+/**
+ *	iput	- put an inode
+ *	@inode: inode to put
+ *
+ *	Puts an inode, dropping its usage count. If the inode use count hits
+ *	zero, the inode is then freed and may also be destroyed.
+ *
+ *	Consequently, iput() can sleep.
+ */
+void iput(struct inode *inode)
+{
+	__iput(inode, false);
+}
 EXPORT_SYMBOL(iput);
 
 /**
-- 
2.49.0


