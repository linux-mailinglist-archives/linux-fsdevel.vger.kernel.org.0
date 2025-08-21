Return-Path: <linux-fsdevel+bounces-58651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692BB3065C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE29C1891C71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0B38B67A;
	Thu, 21 Aug 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0fJbjXmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FC3128C6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807639; cv=none; b=a822xcxUo4tn2GKZ2Lo1x6Z94dIonh3n9bzAh0qdqDmEj03+KjjFYi/aeTBPFcZWz+RjYEcPCGpUXSU2W0g/zxYWFDYPuTtI1ffMLKxvxM0fgMm7AzYPygIXKEqb1v9nDMxEQC7LLn8lGVXLtYCe9492wi+KKsLBNWxOu0K/Cc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807639; c=relaxed/simple;
	bh=9JJsShQL4nGkbiSbvmaKfxfRxX7wGr8Yu/AuAL4vbS8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwwYuO1pmtI+KaB0mY7ggokHKc6OH+Lh8ykHDEQVRYG3Q/HfYP5iCe4LiiuHIamk3sQSDTsW9jvPngrerTNGBA48sz0i8rGBZpjVIgVwlgyi1SfjuwmjqXS4k2Ya6jtxOS3WdpeMo1HbmRG23F6FswROBI81oxZpwPeAyk7E4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0fJbjXmQ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60504bf8so12597047b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807636; x=1756412436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cu/SZ6kZWGQ0mt9krttxqzikg/aRXh0UmvLyuq14xUk=;
        b=0fJbjXmQ2QsgfAK46cwp3bgvluk6VNpaWgVcUv49Y0MbXXbKDjx1es2thzjl8pAtis
         lJqw2sbSfAERKoW9Ns+t8MAE1S8Ks2V/PhPOeaUFZT/3e2mvsIhuIzrz10L8RgGgtdbL
         3UudlTDkJmS7eeKh+2JtqvubXnkhrbhLFe5/YGp7L/g75Oqhdr9H3EanUB/Qe30FJ9Nc
         NpqBjALtadLHVhi+EKiZMk2yZxEyr4++cRsjJj2cSsskbg4Uc/mRYjXbG5YPwKtCmfic
         /XAiTz9wBr4zRJHPC/czhIzvDkMPIITZd6CG5fCIjGLK4LyS1mVIDN8wv9QQV1BtyIRI
         JuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807636; x=1756412436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu/SZ6kZWGQ0mt9krttxqzikg/aRXh0UmvLyuq14xUk=;
        b=P8ghAfXpt5C1BruEvua3yO/ZwYLQcy2h7YWQLzgd1ViogJ0LFemFVEjZT8rFcuqGF4
         HKK5iGF0tAd9KnccsCAGZZNw2XYwy6DuF0x7cjzStxinXPmKw6gRQLdrOgd4+C9g+Jrw
         m8CMj3GsX8Efx9CZwgy1lLvWW2siPZogUkLMiHntGs8qKQuodnVC2DOHNivUa2l+v1Ng
         yxgPu8SzQj49YRYPlOkwOIB7gK27Bu+duw+kH7gclAZAp2gqxpMChTPbYZ5ZqIneku1O
         Iiru+UJVEjNyFPQFCvKWI/+b7Sz91CKpSjAN/v64tdikYUIIJkXtkTL4zi0R4vazSkxR
         PyTg==
X-Gm-Message-State: AOJu0Yz8ITFH7uBWKDanpB89fDsJ1umCnswGahzse1a3i4s66A8cFNld
	MtNN7aeX7GKnRVxTFKw5VbJQekwwApJxNuRQyoy0OHZRdkl6VSGmPKoDCkcJBNLZFgl28Ae5Rvz
	dFLcickklHg==
X-Gm-Gg: ASbGncuCCA4vHv1ZteDuZz1QtXpaXwth8FMHOiTmMqWMHceG30diwiwYAQ5PU/p60IE
	0ZfPgdim/7IdDdczVYQegfrsdZ+rfOVkS5kIgc+9RGXBpgf5lAC02WhAM1l+e5Z52me+gHOQKJn
	uU3NQJI3eVfJsF4vY/U3gtMknBXkAsCrOcK9QMgyM9JBeZ+75roFg7YnpgcdDJqN0BwHTL99I8E
	kb6RnLfTCg0g/rYwXsXI/57qVDW5Lcg9uz0NhigA9KijB2tAblIGDcUnY5iCDgc/rKpnK4lLRKO
	WaoMEysZVDxwfJpjumDKUX8UzWzY9FBBtSr7jg8n/CtjGR+8lwytayaTr8cbvnTBU73M1sQJlFu
	4QvJ0+ckTp72V5ftHUVFa9mU8QWRb19iRR5M89IjZQsSFKahrQEaBefWNLyU=
X-Google-Smtp-Source: AGHT+IF7MATu7l8Nuwj+BUtwCNJA2NMDHdht08rF3xFue6u7BWDW0DjuUsdbuHLMNLXyrmOO4z09jg==
X-Received: by 2002:a05:690c:46c7:b0:71b:d209:2d1c with SMTP id 00721157ae682-71fdc2b14b7mr5873137b3.5.1755807636261;
        Thu, 21 Aug 2025 13:20:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6daf0f38sm46768767b3.0.2025.08.21.13.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 14/50] fs: maintain a list of pinned inodes
Date: Thu, 21 Aug 2025 16:18:25 -0400
Message-ID: <cbca76c429c4f3418cc219deb1a9eb917a77cde0.1755806649.git.josef@toxicpanda.com>
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
 include/linux/fs.h               |  11 ++++
 include/trace/events/writeback.h |   3 +-
 6 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d2e1fb1a0787..111a9d8215bf 100644
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
index 94769b356224..adcba0a4d776 100644
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
+	spin_lock(&inode->i_sb->s_cached_inodes_lock);
+	list_add(&inode->i_lru, &inode->i_sb->s_cached_inodes);
+	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
+	iobj_get(inode);
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
 	if (atomic_read(&inode->i_count))
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
 	if (atomic_read(&inode->i_count) ||
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
index 509e696a4df0..8384ed81a5ad 100644
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
@@ -786,6 +789,7 @@ enum inode_state_bits {
 	INODE_BIT(I_SYNC_QUEUED),
 	INODE_BIT(I_PINNING_NETFS_WB),
 	INODE_BIT(I_LRU),
+	INODE_BIT(I_CACHED_LRU),
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
@@ -1584,6 +1588,13 @@ struct super_block {
 
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


