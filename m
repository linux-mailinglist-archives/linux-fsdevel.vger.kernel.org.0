Return-Path: <linux-fsdevel+bounces-59251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0AB36E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE063673D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD335FC08;
	Tue, 26 Aug 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZdaxGpja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118135CECB
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222880; cv=none; b=NMCScsbMhMBNRA08aB66+p3pGVbugR75xWQj3WvoHS+pEEuxlHo+7yI7SXuT9AyAwyURoaXvZOArll5LDQnYq6zDPqOujaz5Pjf5c2ROihkWc0uBSW+BaRi7LqesacTGE/p+5QwIHD3wlk8jebznjq5XqS1Ism0m7HmZdihw4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222880; c=relaxed/simple;
	bh=yheV4+FHnR2kwhiEhT3CdzvSmZC4CZ/J0aiCkoLfFqE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cErNdTvlCUedRxUBhCAdFvoYFg6O7iWkmxZtnbIqHIUjnC8AobFj94gc3VybjhFdOGNSWSP1RKiqDcXRpWtoExQzutw3tmp9mxV4Qcys/VJucnm6T3gBo2koma4VJq75LuNWNNH9Of/nvz/mV/joMYfGIeyQ9AKEEGFXFVsBWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZdaxGpja; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e951dd0689bso3910404276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222876; x=1756827676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ceYno3oIiSd2TYF3YKVPnCCOItrP39RmVspW8GkQzI=;
        b=ZdaxGpjaS/w7sWU5l8tcl3JoxO5YdFz+6PzMrP9llHHkUL6SYbUo3x0wXOMq/rEPwg
         R5ECAXgBqSrt5ijgSB2aiZT92jtS87WHi6iyIgDwzcBIwzvD4XjM4zA0+56pzcK6J9e3
         IvyfDFm/MjB6Hmv0LyjGYijzpgaLpFPoR9nMBoUbYKAzHGs2xpt9vIgabJllg7l2tK8p
         P2yUMYhEG2T7+fupSyrHHOWp+RC+WOiNvAFTNBjgU0OlzspxgXhBySSxpEvFwoax73DV
         Q+uQysfAKUK5WK59P/1nMSr1pidK+Hbcav3Vr5gx2iMfd+Z4Hdt0gm8GUYITqrDhaOIW
         wUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222876; x=1756827676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ceYno3oIiSd2TYF3YKVPnCCOItrP39RmVspW8GkQzI=;
        b=U+9QvaLoKNuVi2/71MVwvaX+k0Cn4FZFum6XV6kgJru0H4Pk4RCS2AnPNKnAD+QnrA
         8hNHvRQnAiUE2om6yMMcWkzA1Qrp5YswGzcaw0wxdClPqS39wmgBQ/jwmL/9A6KnL5en
         BeIqUVY5+AWRN+dBZ9VmIYrAVhaV/dTdJk9kKBWEWwZV7p952wgqdhUHbl4AMkK3jqWu
         5MzJCNoIoOVi2UbVlUm21T7ah6/B2bBUXWxhWWwIQ2joAKr381ZjVxTmo7aMTIwm/QPV
         1M9OvgkbHi7qPV5+DoPt4FQHGd3qimeRksZHEEFG+SoJo//2Vl4J2tJxqFGZXCopPhI1
         +uoQ==
X-Gm-Message-State: AOJu0YwWiyOlSPts2ibN59WyZ0AOvpX3tElFK6tCSBPX7dwSTPa3SGeB
	V9F+cZjMJyVcCQ6rrIKRQ/oLBoKI5oLikQZ9MgbOAGuCQe/PYbcPqAzwE8XHbfUj6FqXUaJ2RQl
	tXX5r
X-Gm-Gg: ASbGnctO0VlTUfpOpWJKzmW+swmbyrAhQ0Dy5KPbkaljO/ZEmN026VnQhswjKLxgYrZ
	DkjHTQ4gaBpshZSffXRgEzEcg4R7xE6JNscud9cRvILkOOaAwCD4tKQctlrzPPf0RvxnvhtCqTR
	2mwGy+CKiP80j14qLzvUsRVOUxEuxQG047CENAlVNUmGB1jQM9jZOBfz4DlKP18BRglJbLvEFgr
	XupChThHm0LHwsJjTB4LEwaqKXRlAX7MbUIY4qx3BUKntUNK4WWOaFOC3wRqlSb0f3q0zVSBfxm
	2NwUrrOtyiwVPrGLhQGSkN0KC21nLdNOfkAzXeH6jyYtRho7lwcV81U9BOgmsedH3k9ukAXSYN+
	RjKyC5O2h8ekAIye3xYcKZuxu7ffOMJslsy30WJhJVgmexsu8De+c5OAMx78=
X-Google-Smtp-Source: AGHT+IF7XLnv+VmYNcQPJ4zjnvxRGZaqU5tGI7u7+R9+LA+oe8OkyzktybJ/34tR15o2zH1+U41fcw==
X-Received: by 2002:a05:6902:1147:b0:e95:3d10:e15f with SMTP id 3f1490d57ef6-e953d10e2e2mr7696750276.29.1756222876250;
        Tue, 26 Aug 2025 08:41:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c25df8esm3338844276.7.2025.08.26.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 19/54] fs: hold a full ref while the inode is on a LRU
Date: Tue, 26 Aug 2025 11:39:19 -0400
Message-ID: <7ea665f486c7fba75d44b9d01c5a0151a0ecae73.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
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

We also now must take into account unlink, and avoid adding the inode to
the LRU if it has an nlink of 0.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 87 +++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ede9118bb649..9001f809add0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -555,11 +555,13 @@ static void inode_add_cached_lru(struct inode *inode)
 
 	if (inode->i_state & I_CACHED_LRU)
 		return;
+	if (inode->__i_nlink == 0)
+		return;
 	if (!list_empty(&inode->i_lru))
 		return;
 
 	inode->i_state |= I_CACHED_LRU;
-	iobj_get(inode);
+	__iget(inode);
 	spin_lock(&inode->i_sb->s_cached_inodes_lock);
 	list_add(&inode->i_lru, &inode->i_sb->s_cached_inodes);
 	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
@@ -582,7 +584,7 @@ static bool __inode_del_cached_lru(struct inode *inode)
 static bool inode_del_cached_lru(struct inode *inode)
 {
 	if (__inode_del_cached_lru(inode)) {
-		iobj_put(inode);
+		iput(inode);
 		return true;
 	}
 	return false;
@@ -598,6 +600,8 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 		return;
 	if (icount_read(inode))
 		return;
+	if (inode->__i_nlink == 0)
+		return;
 	if (!(inode->i_sb->s_flags & SB_ACTIVE))
 		return;
 	if (inode_needs_cached(inode)) {
@@ -609,7 +613,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		inode->i_state |= I_LRU;
 		if (need_ref)
-			iobj_get(inode);
+			__iget(inode);
 		this_cpu_inc(nr_unused);
 	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
@@ -655,7 +659,7 @@ void inode_lru_list_del(struct inode *inode)
 
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		inode->i_state &= ~I_LRU;
-		iobj_put(inode);
+		iput(inode);
 		this_cpu_dec(nr_unused);
 	}
 }
@@ -926,6 +930,7 @@ static void evict(struct inode *inode)
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 }
 
+static void iput_evict(struct inode *inode);
 /*
  * dispose_list - dispose of the contents of a local list
  * @head: the head of the list to free
@@ -933,20 +938,14 @@ static void evict(struct inode *inode)
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
@@ -987,13 +986,13 @@ void evict_inodes(struct super_block *sb)
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
 
@@ -1031,22 +1030,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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
-	if (icount_read(inode) ||
-	    (inode->i_state & ~I_REFERENCED)) {
-		list_lru_isolate(lru, &inode->i_lru);
-		inode->i_state &= ~I_LRU;
+		iput(inode);
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
@@ -1082,7 +1066,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	}
 
 	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state |= I_FREEING;
 	inode->i_state &= ~I_LRU;
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
@@ -1104,7 +1087,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 
 	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
 				     inode_lru_isolate, &freeable);
-	dispose_list(&freeable, true);
+	dispose_list(&freeable);
 	return freed;
 }
 
@@ -1967,7 +1950,7 @@ EXPORT_SYMBOL(generic_delete_inode);
  * in cache if fs is alive, sync and evict if fs is
  * shutting down.
  */
-static void iput_final(struct inode *inode)
+static void iput_final(struct inode *inode, bool skip_lru)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct super_operations *op = inode->i_sb->s_op;
@@ -1981,7 +1964,7 @@ static void iput_final(struct inode *inode)
 	else
 		drop = generic_drop_inode(inode);
 
-	if (!drop &&
+	if (!drop && !skip_lru &&
 	    !(inode->i_state & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
 		__inode_add_lru(inode, true);
@@ -1989,6 +1972,8 @@ static void iput_final(struct inode *inode)
 		return;
 	}
 
+	WARN_ON(!list_empty(&inode->i_lru));
+
 	state = inode->i_state;
 	if (!drop) {
 		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
@@ -2003,23 +1988,12 @@ static void iput_final(struct inode *inode)
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
@@ -2038,12 +2012,31 @@ void iput(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	if (atomic_dec_and_test(&inode->i_count)) {
 		/* iput_final() drops i_lock */
-		iput_final(inode);
+		iput_final(inode, skip_lru);
 	} else {
 		spin_unlock(&inode->i_lock);
 	}
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


