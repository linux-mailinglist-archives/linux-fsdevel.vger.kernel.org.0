Return-Path: <linux-fsdevel+bounces-4943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14773806759
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9931F2119D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD118AEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kuoM7EmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D80C10D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:40 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c67c1ad5beso414045a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842799; x=1702447599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rdb9xvX76/xANEogpQRhxIokBrxEBw+rSVcTgSipqa8=;
        b=kuoM7EmEWDdEqIKN8PcgL+FALJqsEhHgZOoMjXlxKXkW6Tnwr2qqTNBjHhUb1gU36y
         WALXNcQPAOvMx/uaf4IgZwfEMKF+6JtdlWMVO0lP4fB4yL6cWGBfZS90bY8mnP+BtfZG
         bXaRHjWZB3VEMDp6mh3RcS3IWzgJhpMNcyUAygik6u1ESFJAVbVC+d46UvhF4lVdJI5x
         gVaoQaNxcXuw6FnXl3BovN3q/Z9Yo140FTTzq0HCLsi3wmrOFhXbK2Y+NPM6jOnz9mN8
         G6HzpAd3Q3zFhG3sfgPEFEPDb6BdaGPeYfyMQ0mvXMb/38KP0BWlkl3s+7C+myZ6NcRO
         I15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842799; x=1702447599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rdb9xvX76/xANEogpQRhxIokBrxEBw+rSVcTgSipqa8=;
        b=Xco43zdcdAff/tBPbKrEB1nA7pIDxTy3sk/5H4rtoS4hPvPxkhc2BDiatODq7VVAuI
         Z7gnVVK+7aI/jyuQyxY3nnMTrGgrBn44NCrHul0uKhR76hCq6Hn9TTt4n+zz1UXWDNYk
         vCY1doXeow3Q4vVJ2jVRDxKodNvIn0g2KB6F8Smwk0QZb0bHjEmmXik2KoqRmjWVYj+M
         32170ytuo4zOK6QSMAGQbRg1zsQ3sbFAz7aLyfCDR6xy7QoEc3PVjW56mIKj/BqIiIih
         RMSDZynlaU0cvYd30+DKJT+0lDb6xUHkSOQgzUsGtye/GCum9whj37wgsY+/mgRBR94d
         4YYQ==
X-Gm-Message-State: AOJu0Ywc4VqmmYVGB4zyoFwZETjJqrsqvhrPk+BCwhV7V7nQEEHqt5n9
	eqWMU+xaGpwloojEVH6fYTBh+A==
X-Google-Smtp-Source: AGHT+IGb5kg0aJnp7AHr6GQcXW1g5UZsc3Lyt04QtAqwhanWpaLLG0z7OKR8itApXUZbOpyN0KCWcA==
X-Received: by 2002:a17:90b:1650:b0:286:d498:1ad with SMTP id il16-20020a17090b165000b00286d49801admr507619pjb.3.1701842799111;
        Tue, 05 Dec 2023 22:06:39 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001cfed5524easm7574769plb.288.2023.12.05.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:36 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3I-004VPB-1D;
	Wed, 06 Dec 2023 17:06:32 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrVk-3uln;
	Wed, 06 Dec 2023 17:06:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-cachefs@redhat.com,
	dhowells@redhat.com,
	gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] list_bl: don't use bit locks for PREEMPT_RT or lockdep
Date: Wed,  6 Dec 2023 17:05:39 +1100
Message-ID: <20231206060629.2827226-11-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

hash-bl nests spinlocks inside the bit locks. This causes problems
for CONFIG_PREEMPT_RT which converts spin locks to sleeping locks,
and we're not allowed to sleep while holding a spinning lock.

Further, lockdep does not support bit locks, so we lose lockdep
coverage of the inode hash table with the hash-bl conversion.

To enable these configs to work, add an external per-chain spinlock
to the hlist_bl_head() and add helpers to use this instead of the
bit spinlock when preempt_rt or lockdep are enabled.

This converts all users of hlist-bl to use the external spinlock in
these situations, so we also gain lockdep coverage of things like
the dentry cache hash table with this change.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/list_bl.h    | 126 ++++++++++++++++++++++++++++---------
 include/linux/rculist_bl.h |  13 ++++
 2 files changed, 110 insertions(+), 29 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 8ee2bf5af131..990ad8e24e0b 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -4,14 +4,27 @@
 
 #include <linux/list.h>
 #include <linux/bit_spinlock.h>
+#include <linux/spinlock.h>
 
 /*
  * Special version of lists, where head of the list has a lock in the lowest
  * bit. This is useful for scalable hash tables without increasing memory
  * footprint overhead.
  *
- * For modification operations, the 0 bit of hlist_bl_head->first
- * pointer must be set.
+ * Whilst the general use of bit spin locking is considered safe, PREEMPT_RT
+ * introduces a problem with nesting spin locks inside bit locks: spin locks
+ * become sleeping locks, and we can't sleep inside spinning locks such as bit
+ * locks. However, for RTPREEMPT, performance is less of an issue than
+ * correctness, so we trade off the memory and cache footprint of a spinlock per
+ * list so the list locks are converted to sleeping locks and work correctly
+ * with PREEMPT_RT kernels.
+ *
+ * An added advantage of this is that we can use the same trick when lockdep is
+ * enabled (again, performance doesn't matter) and gain lockdep coverage of all
+ * the hash-bl operations.
+ *
+ * For modification operations when using pure bit locking, the 0 bit of
+ * hlist_bl_head->first pointer must be set.
  *
  * With some small modifications, this can easily be adapted to store several
  * arbitrary bits (not just a single lock bit), if the need arises to store
@@ -30,16 +43,21 @@
 #define LIST_BL_BUG_ON(x)
 #endif
 
+#undef LIST_BL_USE_SPINLOCKS
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_LOCKDEP)
+#define LIST_BL_USE_SPINLOCKS	1
+#endif
 
 struct hlist_bl_head {
 	struct hlist_bl_node *first;
+#ifdef LIST_BL_USE_SPINLOCKS
+	spinlock_t lock;
+#endif
 };
 
 struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
-#define INIT_HLIST_BL_HEAD(ptr) \
-	((ptr)->first = NULL)
 
 static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
 {
@@ -54,6 +72,69 @@ static inline bool  hlist_bl_unhashed(const struct hlist_bl_node *h)
 	return !h->pprev;
 }
 
+#ifdef LIST_BL_USE_SPINLOCKS
+#define INIT_HLIST_BL_HEAD(ptr) do { \
+	(ptr)->first = NULL; \
+	spin_lock_init(&(ptr)->lock); \
+} while (0)
+
+static inline void hlist_bl_lock(struct hlist_bl_head *b)
+{
+	spin_lock(&b->lock);
+}
+
+static inline void hlist_bl_unlock(struct hlist_bl_head *b)
+{
+	spin_unlock(&b->lock);
+}
+
+static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
+{
+	return spin_is_locked(&b->lock);
+}
+
+static inline struct hlist_bl_node *hlist_bl_first(struct hlist_bl_head *h)
+{
+	return h->first;
+}
+
+static inline void hlist_bl_set_first(struct hlist_bl_head *h,
+					struct hlist_bl_node *n)
+{
+	h->first = n;
+}
+
+static inline void hlist_bl_set_before(struct hlist_bl_node **pprev,
+					struct hlist_bl_node *n)
+{
+	WRITE_ONCE(*pprev, n);
+}
+
+static inline bool hlist_bl_empty(const struct hlist_bl_head *h)
+{
+	return !READ_ONCE(h->first);
+}
+
+#else /* !LIST_BL_USE_SPINLOCKS */
+
+#define INIT_HLIST_BL_HEAD(ptr) \
+	((ptr)->first = NULL)
+
+static inline void hlist_bl_lock(struct hlist_bl_head *b)
+{
+	bit_spin_lock(0, (unsigned long *)b);
+}
+
+static inline void hlist_bl_unlock(struct hlist_bl_head *b)
+{
+	__bit_spin_unlock(0, (unsigned long *)b);
+}
+
+static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
+{
+	return bit_spin_is_locked(0, (unsigned long *)b);
+}
+
 static inline struct hlist_bl_node *hlist_bl_first(struct hlist_bl_head *h)
 {
 	return (struct hlist_bl_node *)
@@ -69,11 +150,21 @@ static inline void hlist_bl_set_first(struct hlist_bl_head *h,
 	h->first = (struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK);
 }
 
+static inline void hlist_bl_set_before(struct hlist_bl_node **pprev,
+					struct hlist_bl_node *n)
+{
+	WRITE_ONCE(*pprev,
+		   (struct hlist_bl_node *)
+			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
+}
+
 static inline bool hlist_bl_empty(const struct hlist_bl_head *h)
 {
 	return !((unsigned long)READ_ONCE(h->first) & ~LIST_BL_LOCKMASK);
 }
 
+#endif /* LIST_BL_USE_SPINLOCKS */
+
 static inline void hlist_bl_add_head(struct hlist_bl_node *n,
 					struct hlist_bl_head *h)
 {
@@ -94,11 +185,7 @@ static inline void hlist_bl_add_before(struct hlist_bl_node *n,
 	n->pprev = pprev;
 	n->next = next;
 	next->pprev = &n->next;
-
-	/* pprev may be `first`, so be careful not to lose the lock bit */
-	WRITE_ONCE(*pprev,
-		   (struct hlist_bl_node *)
-			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
+	hlist_bl_set_before(pprev, n);
 }
 
 static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
@@ -119,11 +206,7 @@ static inline void __hlist_bl_del(struct hlist_bl_node *n)
 
 	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
 
-	/* pprev may be `first`, so be careful not to lose the lock bit */
-	WRITE_ONCE(*pprev,
-		   (struct hlist_bl_node *)
-			((unsigned long)next |
-			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
+	hlist_bl_set_before(pprev, next);
 	if (next)
 		next->pprev = pprev;
 }
@@ -165,21 +248,6 @@ static inline bool hlist_bl_fake(struct hlist_bl_node *n)
 	return n->pprev == &n->next;
 }
 
-static inline void hlist_bl_lock(struct hlist_bl_head *b)
-{
-	bit_spin_lock(0, (unsigned long *)b);
-}
-
-static inline void hlist_bl_unlock(struct hlist_bl_head *b)
-{
-	__bit_spin_unlock(0, (unsigned long *)b);
-}
-
-static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
-{
-	return bit_spin_is_locked(0, (unsigned long *)b);
-}
-
 /**
  * hlist_bl_for_each_entry	- iterate over list of given type
  * @tpos:	the type * to use as a loop cursor.
diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 0b952d06eb0b..2d5eb5153121 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -8,6 +8,18 @@
 #include <linux/list_bl.h>
 #include <linux/rcupdate.h>
 
+#ifdef LIST_BL_USE_SPINLOCKS
+static inline void hlist_bl_set_first_rcu(struct hlist_bl_head *h,
+					struct hlist_bl_node *n)
+{
+	rcu_assign_pointer(h->first, n);
+}
+
+static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
+{
+	return rcu_dereference_check(h->first, hlist_bl_is_locked(h));
+}
+#else /* !LIST_BL_USE_SPINLOCKS */
 static inline void hlist_bl_set_first_rcu(struct hlist_bl_head *h,
 					struct hlist_bl_node *n)
 {
@@ -23,6 +35,7 @@ static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
 	return (struct hlist_bl_node *)
 		((unsigned long)rcu_dereference_check(h->first, hlist_bl_is_locked(h)) & ~LIST_BL_LOCKMASK);
 }
+#endif /* LIST_BL_USE_SPINLOCKS */
 
 /**
  * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
-- 
2.42.0


