Return-Path: <linux-fsdevel+bounces-59248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F7BB36E44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE9F2A5974
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDF356905;
	Tue, 26 Aug 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="a/s6ypoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94043568E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222876; cv=none; b=hHgSbCdannQuC7M+ezTq9/hYU6dPqnf+CU/D/RP4Or5n4H/jBiKqm5RSEwsgWujrSXndI8+6GDwScTyti7W++V76z0QGxnmxHqI/jNHZb01YAfcXobS/AsJK2rd0DaFVy/jA4v9mTS5TluVBq871SyvKQaTWx0ymYOYzigcvBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222876; c=relaxed/simple;
	bh=/mjYKAkDomJoeK7GkcBEPZ0BS4mgrDIXcRm00NNVmIQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPQq/5EJP+IRFNtCIgOrX2d1Izy45EhFaa2MchUPkxWkWQOnmGdB3QTlxUb5Mi6EIJXAlJvgcN7JAkWnhO78ZGMh6eTa75BzC1Jog8PlhQ7AfDP4lDYrF4ihCZHdBWDEhVDXGLtmr+baYgSH/iUVlBdKMvQZJ0yR2lOgpT72dLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=a/s6ypoz; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e967d4acaa0so2118082276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222870; x=1756827670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjTYjk0ruULiVrFkSp8RKnffjxGFOC0KjJtgp9EIPnM=;
        b=a/s6ypozDrDEegT7asqr3ETJMyJN4fdz0uP/Xuu8YRNg8XMwxwTJAepuIHEPXR1YZt
         /Oya+oQONG06AP5+NnEXwKKPwm+nJDdKFZrVL3rtki9WzRiRBqdfEv0F4ja/e5L982j2
         ZENkkQMqgvOeR3zJjfAW9bU15exScsZI4DZxLo1GMXn0grw7rVrh+pMP9smNA7L8tliE
         M+ofRK+ay+u7y7SZHy7373q8BiLWcSHXMZueLNrSXzOStGdDGpCqmcwHMT3RfZNvuQWP
         zX2UTueMGfXAG615H7G4YctUowb8OYxeVQfHSumzspSdYbFxP3Gn9+AorDZLUO0A5cxQ
         1iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222870; x=1756827670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjTYjk0ruULiVrFkSp8RKnffjxGFOC0KjJtgp9EIPnM=;
        b=IQcr61xwXI+g0lPvIF/VK5oc6nkUmdVRPKYiB3gHxYaCXfncVwHpnyxHzYJjjkLW0J
         4T26jT/GhumJPVP46tU8+wByXmaaNLWIL9OhM/timwdwQ8SUGSpolBJuQ4AA1Zu1dzqo
         K8AtSjR7PnXJ8efBHKRwC/ttfa/hpE0J+l76QuEbfEy4qLQvE3laECkgIwGdLA13nweP
         KlhiRQdQgECQYVqRDc8yLB+dOT3t1fZPMARapJleGRil7SBr7WA+mh0Yn2lFwBkgNUst
         bO7K2iwIyVrSo0w/Lx6soqAvLYlyNa8+r8bhdcx5p/ttUci8SPU88PchfMeUXsaijdVk
         uyDw==
X-Gm-Message-State: AOJu0YwezmREPTLKoSj0nqFwO/2wNTeGgQarnqRzywxpHI7YB7hiQyrI
	I8Zfd+cc+YUPwC+nDmFSvZapSfyAY9bkozathbUzLqr6MHnvwY0Ii7grQ8MYPs8BYJq0orRng5S
	dvIgv
X-Gm-Gg: ASbGnctNtdPCJsNm9E7tkxTB1x3Zyj0jrd627sJmYNe8Qg9xM/UrzN9l8uMTekhQf55
	IFWSF4gFs7eH7OtzFAKX1Chu7BJlFi0WKt8MDnCdl7TizrxeDzWd6+n6E9MQHOh2XQE10TiDacY
	WG6HykuTXzdpCWJlok4ix4KjAmuw/poIz04yQZV8QAilfkoTByNMORH27xN7+w0sasiWOGxFaon
	rV/hWq3yFcCEovMzsw4te2Me7yjwuRq3/bzasc5C0CofgMqr6E6t3bPJhdCUOmveodf0grmPXVe
	PpbCo46PW5hFp/DsQLblowAVNjuubqgyKDrPXY0ki2darWlC3ZN22UcPJzmZif9UwSlxWTh7wLN
	tY5pHxtGpg6OxmwkSMBTkkTlc9ERaaOeeZjYndlqbRwEQpV3zytzAykI/+B4=
X-Google-Smtp-Source: AGHT+IGlyRHRmfw7t4VnZsH/kMyvmXEokJCG3VxY2NGelQ0UzWz2FzAirv4DQxsEX4CVQpHPERTH5Q==
X-Received: by 2002:a05:6902:110a:b0:e96:8294:6e55 with SMTP id 3f1490d57ef6-e9682946eebmr8347494276.45.1756222870425;
        Tue, 26 Aug 2025 08:41:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c358904sm3307485276.24.2025.08.26.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 15/54] fs: maintain a list of pinned inodes
Date: Tue, 26 Aug 2025 11:39:15 -0400
Message-ID: <35dc849a851470e2a31375ecdfdf70424844c871.1756222465.git.josef@toxicpanda.com>
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

Currently we have relied on dirty inodes and inodes with cache on them
to simply be left hanging around on the system outside of an LRU. The
only way to make sure these inodes are eventually reclaimed is because
dirty writeback will grab a reference on the inode and then iput it when
it's done, potentially getting it on the LRU. For the cached case the
page cache deletion path will call inode_add_lru when the inode no
longer has cached pages in order to make sure the inode object can be
freed eventually.  In the unmount case we walk all inodes and free them
so this all works out fine.

But we want to eliminate 0 i_count objects as a concept, so we need a
mechanism to hold a reference on these pinned inodes. To that end, add a
list to the super block that contains any inodes that are cached for one
reason or another.

When we call inode_add_lru(), if the inode falls into one of these
categories, we will add it to the cached inode list and hold an
i_obj_count reference.  If the inode does not fall into one of these
categories it will be moved to the normal LRU, which is already holds an
i_obj_count reference.

The dirty case we will delete it from the LRU if it is on one, and then
the iput after the writeout will make sure it's placed onto the correct
list at that point.

The page cache case will migrate it when it calls inode_add_lru() when
deleting pages from the page cache.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c                |   8 +++
 fs/inode.c                       | 102 +++++++++++++++++++++++++++++--
 fs/internal.h                    |   1 +
 fs/super.c                       |   3 +
 include/linux/fs.h               |  13 +++-
 include/trace/events/writeback.h |   3 +-
 6 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b83d556d7ffe..dbcb317e7113 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2736,6 +2736,14 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
+
+		/*
+		 * We could have potentially ended up on the cached LRU list, so
+		 * remove ourselves from this list now that we have a reference,
+		 * the iput will handle placing it back on the appropriate LRU
+		 * list if necessary.
+		 */
+		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
diff --git a/fs/inode.c b/fs/inode.c
index 15ff3a0ff7ee..4d39f260901f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -319,6 +319,23 @@ void free_inode_nonrcu(struct inode *inode)
 }
 EXPORT_SYMBOL(free_inode_nonrcu);
 
+/*
+ * Some inodes need to stay pinned in memory because they are dirty or there are
+ * cached pages that the VM wants to keep around to avoid thrashing. This does
+ * the appropriate checks to see if we want to sheild this inode from periodic
+ * reclaim. Must be called with ->i_lock held.
+ */
+static bool inode_needs_cached(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+
+	if (inode->i_state & (I_DIRTY_ALL | I_SYNC))
+		return true;
+	if (!mapping_shrinkable(&inode->i_data))
+		return true;
+	return false;
+}
+
 static void i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
@@ -532,20 +549,67 @@ void ihold(struct inode *inode)
 }
 EXPORT_SYMBOL(ihold);
 
+static void inode_add_cached_lru(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+
+	if (inode->i_state & I_CACHED_LRU)
+		return;
+	if (!list_empty(&inode->i_lru))
+		return;
+
+	inode->i_state |= I_CACHED_LRU;
+	iobj_get(inode);
+	spin_lock(&inode->i_sb->s_cached_inodes_lock);
+	list_add(&inode->i_lru, &inode->i_sb->s_cached_inodes);
+	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
+}
+
+static bool __inode_del_cached_lru(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+
+	if (!(inode->i_state & I_CACHED_LRU))
+		return false;
+
+	inode->i_state &= ~I_CACHED_LRU;
+	spin_lock(&inode->i_sb->s_cached_inodes_lock);
+	list_del_init(&inode->i_lru);
+	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
+	return true;
+}
+
+static bool inode_del_cached_lru(struct inode *inode)
+{
+	if (__inode_del_cached_lru(inode)) {
+		iobj_put(inode);
+		return true;
+	}
+	return false;
+}
+
 static void __inode_add_lru(struct inode *inode, bool rotate)
 {
-	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
+	bool need_ref = true;
+
+	lockdep_assert_held(&inode->i_lock);
+
+	if (inode->i_state & (I_FREEING | I_WILL_FREE))
 		return;
 	if (icount_read(inode))
 		return;
 	if (!(inode->i_sb->s_flags & SB_ACTIVE))
 		return;
-	if (!mapping_shrinkable(&inode->i_data))
+	if (inode_needs_cached(inode)) {
+		inode_add_cached_lru(inode);
 		return;
+	}
 
+	need_ref = __inode_del_cached_lru(inode) == false;
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
-		iobj_get(inode);
 		inode->i_state |= I_LRU;
+		if (need_ref)
+			iobj_get(inode);
 		this_cpu_inc(nr_unused);
 	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
@@ -573,8 +637,19 @@ void inode_add_lru(struct inode *inode)
 	__inode_add_lru(inode, false);
 }
 
-static void inode_lru_list_del(struct inode *inode)
+/*
+ * Caller must be holding it's own i_count reference on this inode in order to
+ * prevent this being the final iput.
+ *
+ * Needs inode->i_lock held.
+ */
+void inode_lru_list_del(struct inode *inode)
 {
+	lockdep_assert_held(&inode->i_lock);
+
+	if (inode_del_cached_lru(inode))
+		return;
+
 	if (!(inode->i_state & I_LRU))
 		return;
 
@@ -950,6 +1025,22 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
+	/*
+	 * This inode is either dirty or has page cache we want to keep around,
+	 * so move it to the cached list.
+	 *
+	 * We drop the extra i_obj_count reference we grab when adding it to the
+	 * cached lru.
+	 */
+	if (inode_needs_cached(inode)) {
+		list_lru_isolate(lru, &inode->i_lru);
+		inode_add_cached_lru(inode);
+		iobj_put(inode);
+		spin_unlock(&inode->i_lock);
+		this_cpu_dec(nr_unused);
+		return LRU_REMOVED;
+	}
+
 	/*
 	 * Inodes can get referenced, redirtied, or repopulated while
 	 * they're already on the LRU, and this can make them
@@ -957,8 +1048,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * sync, or the last page cache deletion will requeue them.
 	 */
 	if (icount_read(inode) ||
-	    (inode->i_state & ~I_REFERENCED) ||
-	    !mapping_shrinkable(&inode->i_data)) {
+	    (inode->i_state & ~I_REFERENCED)) {
 		list_lru_isolate(lru, &inode->i_lru);
 		inode->i_state &= ~I_LRU;
 		spin_unlock(&inode->i_lock);
diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..17ecee7056d5 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -207,6 +207,7 @@ extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
 int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
 bool in_group_or_capable(struct mnt_idmap *idmap,
 			 const struct inode *inode, vfsgid_t vfsgid);
+void inode_lru_list_del(struct inode *inode);
 
 /*
  * fs-writeback.c
diff --git a/fs/super.c b/fs/super.c
index a038848e8d1f..bf3e6d9055af 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -364,6 +364,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
+	INIT_LIST_HEAD(&s->s_cached_inodes);
+	spin_lock_init(&s->s_cached_inodes_lock);
 
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
@@ -409,6 +411,7 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
+		WARN_ON(!list_empty(&s->s_cached_inodes));
 		call_rcu(&s->rcu, destroy_super_rcu);
 	}
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e12c09b9fcaf..999ffea2aac1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -749,6 +749,9 @@ is_uncached_acl(struct posix_acl *acl)
  *			->i_lru is on the LRU and those that are using ->i_lru
  *			for some other means.
  *
+ * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
+ *			and thus is on the s_cached_inode_lru list.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
@@ -780,7 +783,8 @@ enum inode_state_flags_t {
 	I_DONTCACHE		= (1U << 15),
 	I_SYNC_QUEUED		= (1U << 16),
 	I_PINNING_NETFS_WB	= (1U << 17),
-	I_LRU			= (1U << 18)
+	I_LRU			= (1U << 18),
+	I_CACHED_LRU		= (1U << 19)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
@@ -1579,6 +1583,13 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/*
+	 * Cached inodes, any inodes that their reference is held by another
+	 * mechanism, such as dirty inodes or unshrinkable inodes.
+	 */
+	spinlock_t		s_cached_inodes_lock;
+	struct list_head	s_cached_inodes;
 } __randomize_layout;
 
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 486f85aca84d..6949329c744a 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -29,7 +29,8 @@
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
 		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
-		{I_LRU,			"I_LRU"}		\
+		{I_LRU,			"I_LRU"},		\
+		{I_CACHED_LRU,		"I_CACHED_LRU"}		\
 	)
 
 /* enums need to be exported to user space */
-- 
2.49.0


