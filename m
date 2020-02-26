Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072071703FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBZQPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36101 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727933AbgBZQPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kCzGpCS1aNV/c/qW+M9GWrB1Cx2h9S+8mlMVAKZLeTI=;
        b=NEq3/cmUkWXYj5GNgcCsgL186/AGC5/8/L+pwWwvlCcFmR7PkjQM/hWEFB8N0gdWgWb2pc
        2yzLIiMzLQ3e8fOdG3VhOVIvMCC4DizL3mNQjhFXVT6s6hwieufoM2+BDmX5IfQYd2HCdN
        5SbBBA1mwPezQgwQK0qF5jWvb25KFfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-NJM5qrePP5WY2H0IdBsGmQ-1; Wed, 26 Feb 2020 11:15:15 -0500
X-MC-Unique: NJM5qrePP5WY2H0IdBsGmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C328800D5A;
        Wed, 26 Feb 2020 16:15:13 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53DD660BE1;
        Wed, 26 Feb 2020 16:15:11 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 05/11] fs/dcache: Reclaim excessive negative dentries in directories
Date:   Wed, 26 Feb 2020 11:13:58 -0500
Message-Id: <20200226161404.14136-6-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the "dentry-dir-max" sysctl parameter is set, it will enable the
checking of dentry count in the parent directory when a negative dentry
is being retained. If the count exceeds the given limit, it will schedule
a work function to scan the children of that parent directory to find
negative dentries to be reclaimed. Positive dentries will not be touched.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c            | 207 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |   2 +
 2 files changed, 209 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 8f3ac31a582b..01c6d7277244 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -133,6 +133,11 @@ static DEFINE_PER_CPU(long, nr_dentry_negative);
 int dcache_dentry_dir_max_sysctl __read_mostly;
 EXPORT_SYMBOL_GPL(dcache_dentry_dir_max_sysctl);
 
+static LLIST_HEAD(negative_reclaim_list);
+static void negative_reclaim_check(struct dentry *parent);
+static void negative_reclaim_workfn(struct work_struct *work);
+static DECLARE_WORK(negative_reclaim_work, negative_reclaim_workfn);
+
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
 
 /*
@@ -869,7 +874,20 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
+			struct dentry *neg_parent = NULL;
+
+			if (d_is_negative(dentry)) {
+				neg_parent = dentry->d_parent;
+				rcu_read_lock();
+			}
 			spin_unlock(&dentry->d_lock);
+
+			/*
+			 * Negative dentry reclaim check is only done when
+			 * a negative dentry is being put into a LRU list.
+			 */
+			if (neg_parent)
+				negative_reclaim_check(neg_parent);
 			return;
 		}
 
@@ -1261,6 +1279,195 @@ void shrink_dcache_sb(struct super_block *sb)
 }
 EXPORT_SYMBOL(shrink_dcache_sb);
 
+/*
+ * Return true if reclaiming negative dentry can happen.
+ */
+static inline bool can_reclaim_dentry(unsigned int flags)
+{
+	return !(flags & (DCACHE_SHRINK_LIST | DCACHE_GENOCIDE |
+			  DCACHE_DENTRY_KILLED));
+}
+
+struct reclaim_dentry
+{
+	struct llist_node reclaim_node;
+	struct dentry *parent_dir;
+};
+
+/*
+ * Reclaim excess negative dentries in a directory
+ */
+static void reclaim_negative_dentry(struct dentry *parent,
+				    struct list_head *dispose)
+{
+	struct dentry *child;
+	int limit = READ_ONCE(dcache_dentry_dir_max_sysctl);
+	int cnt;
+
+	lockdep_assert_held(&parent->d_lock);
+
+	cnt = parent->d_nchildren;
+
+	/*
+	 * Compute # of negative dentries to be reclaimed
+	 * An extra 1/8 of dcache_dentry_dir_max_sysctl is added.
+	 */
+	if (cnt <= limit)
+		return;
+	cnt -= limit;
+	cnt += (limit >> 3);
+
+	/*
+	 * The d_subdirs is treated like a kind of LRU where
+	 * non-negative dentries are skipped. Negative dentries
+	 * with DCACHE_REFERENCED bit set are also skipped but
+	 * with DCACHE_REFERENCED cleared.
+	 */
+	list_for_each_entry(child, &parent->d_subdirs, d_child) {
+		/*
+		 * This check is racy and so it may not be accurate.
+		 */
+		if (!d_is_negative(child))
+			continue;
+
+		if (!spin_trylock(&child->d_lock))
+			continue;
+
+		/*
+		 * Only reclaim zero-refcnt negative dentries in the
+		 * LRU, but not in shrink list.
+		 */
+		if (can_reclaim_dentry(child->d_flags) &&
+		    d_is_negative(child) && d_in_lru(child) &&
+		    !child->d_lockref.count) {
+			if (child->d_flags & DCACHE_REFERENCED) {
+				child->d_flags &= ~DCACHE_REFERENCED;
+			} else {
+				cnt--;
+				d_lru_del(child);
+				d_shrink_add(child, dispose);
+			}
+		}
+		spin_unlock(&child->d_lock);
+		if (!cnt) {
+			child = list_next_entry(child, d_child);
+			break;
+		}
+	}
+
+	if (&child->d_child != &parent->d_subdirs) {
+		/*
+		 * Split out the childs from the head up to just
+		 * before the current entry into a separate list and
+		 * then splice it to the end of the child list so
+		 * that the unscanned entries will be in the front.
+		 * This simulates LRU.
+		 */
+		struct list_head list;
+
+		list_cut_before(&list, &parent->d_subdirs,
+				&child->d_child);
+		list_splice_tail(&list, &parent->d_subdirs);
+	}
+}
+
+/*
+ * Excess negative dentry reclaim work function.
+ */
+static void negative_reclaim_workfn(struct work_struct *work)
+{
+	struct llist_node *nodes, *next;
+	struct dentry *parent;
+	struct reclaim_dentry *dentry_node;
+
+	/*
+	 * Collect excess negative dentries in dispose list & shrink them.
+	 */
+	for (nodes = llist_del_all(&negative_reclaim_list);
+	     nodes; nodes = next) {
+		LIST_HEAD(dispose);
+
+		next = llist_next(nodes);
+		dentry_node = container_of(nodes, struct reclaim_dentry,
+					   reclaim_node);
+		parent = dentry_node->parent_dir;
+		spin_lock(&parent->d_lock);
+
+		if (d_is_dir(parent) &&
+		    can_reclaim_dentry(parent->d_flags) &&
+		    (parent->d_flags & DCACHE_RECLAIMING))
+			reclaim_negative_dentry(parent, &dispose);
+
+		if (!list_empty(&dispose)) {
+			spin_unlock(&parent->d_lock);
+			shrink_dentry_list(&dispose);
+			spin_lock(&parent->d_lock);
+		}
+
+		parent->d_flags &= ~DCACHE_RECLAIMING;
+		spin_unlock(&parent->d_lock);
+		dput(parent);
+		kfree(dentry_node);
+		cond_resched();
+	}
+}
+
+/*
+ * Check the parent to see if it has too many negative dentries and queue
+ * it up for the negative dentry reclaim work function to handle it.
+ */
+static void negative_reclaim_check(struct dentry *parent)
+	__releases(rcu)
+{
+	int limit = dcache_dentry_dir_max_sysctl;
+	struct reclaim_dentry *dentry_node;
+
+	if (!limit)
+		goto rcu_unlock_out;
+
+	/*
+	 * These checks are racy before spin_lock().
+	 */
+	if (!can_reclaim_dentry(parent->d_flags) ||
+	    (parent->d_flags & DCACHE_RECLAIMING) ||
+	    (READ_ONCE(parent->d_nchildren) <= limit))
+		goto rcu_unlock_out;
+
+	spin_lock(&parent->d_lock);
+	if (!can_reclaim_dentry(parent->d_flags) ||
+	    (parent->d_flags & DCACHE_RECLAIMING) ||
+	    (READ_ONCE(parent->d_nchildren) <= limit))
+		goto unlock_out;
+
+	if (!d_is_dir(parent))
+		goto unlock_out;
+
+	dentry_node = kzalloc(sizeof(*dentry_node), GFP_NOWAIT);
+	if (!dentry_node)
+		goto unlock_out;
+
+	rcu_read_unlock();
+	__dget_dlock(parent);
+	dentry_node->parent_dir = parent;
+	parent->d_flags |= DCACHE_RECLAIMING;
+	spin_unlock(&parent->d_lock);
+
+	/*
+	 * Only call schedule_work() if negative_reclaim_list is previously
+	 * empty. Otherwise, schedule_work() had been called but the workfn
+	 * workfn hasn't retrieved the list yet.
+	 */
+	if (llist_add(&dentry_node->reclaim_node, &negative_reclaim_list))
+		schedule_work(&negative_reclaim_work);
+	return;
+
+unlock_out:
+	spin_unlock(&parent->d_lock);
+rcu_unlock_out:
+	rcu_read_unlock();
+	return;
+}
+
 /**
  * enum d_walk_ret - action to talke during tree walk
  * @D_WALK_CONTINUE:	contrinue walk
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e9e66eb50d1a..f14d72738903 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -13,6 +13,7 @@
 #include <linux/lockref.h>
 #include <linux/stringhash.h>
 #include <linux/wait.h>
+#include <linux/llist.h>
 
 struct path;
 struct vfsmount;
@@ -214,6 +215,7 @@ struct dentry_operations {
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
 #define DCACHE_ENCRYPTED_NAME		0x02000000 /* Encrypted name (dir key was unavailable) */
 #define DCACHE_OP_REAL			0x04000000
+#define DCACHE_RECLAIMING		0x08000000 /* Reclaiming negative dentries */
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
-- 
2.18.1

