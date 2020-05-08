Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117021CAA87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEHMXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:54 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:57082 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbgEHMX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:26 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id EF52E2E15F8;
        Fri,  8 May 2020 15:23:21 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id XfLVNoDfkP-NKbWfVBj;
        Fri, 08 May 2020 15:23:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940601; bh=AnWcPTizG7xjvhjIOhOb0nEiHMXwPY48XzAP4e4IE9k=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=JK32nvVH7Xs+gWmfCIoDEGbduc8eAKEkWAZ5F3eBADjN0kX06/bxQkCcCw6GAWyI7
         +UgI2GTHxrqE1QpVcR8DU+vfBnLImz+ooc1uTTUbWPDWqXGwg13DOxDWsC0BVtf02/
         IzZcLiZEP7UaDctHjaGHwZdV/PIshD4bEHaQGU3Y=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id vH1ERg2UWZ-NKWeoUXV;
        Fri, 08 May 2020 15:23:20 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 3/8] dcache: sweep cached negative dentries to the end of
 list of siblings
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:20 +0300
Message-ID: <158894060021.200862.15936671684100629802.stgit@buzz>
In-Reply-To: <158893941613.200862.4094521350329937435.stgit@buzz>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For disk filesystems result of every negative lookup is cached, content of
directories is usually cached too. Production of negative dentries isn't
limited with disk speed. It's really easy to generate millions of them if
system has enough memory. Negative dentries are linked into siblings list
along with normal positive dentries. Some operations walks dcache tree but
looks only for positive dentries: most important is fsnotify/inotify.

This patch moves negative dentries to the end of list at final dput() and
marks with flag which tells that all following dentries are negative too.
Reverse operation is required before instantiating negative dentry.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/dcache.c            |   63 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |    6 +++++
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 386f97eaf2ff..743255773cc7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -632,6 +632,48 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 	return __lock_parent(dentry);
 }
 
+/*
+ * Move cached negative dentry to the tail of parent->d_subdirs.
+ * This lets walkers skip them all together at first sight.
+ * Must be called at dput of negative dentry.
+ */
+static void sweep_negative(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	if (!d_is_tail_negative(dentry)) {
+		parent = lock_parent(dentry);
+		if (!parent)
+			return;
+
+		if (!d_count(dentry) && d_is_negative(dentry) &&
+		    !d_is_tail_negative(dentry)) {
+			dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
+			list_move_tail(&dentry->d_child, &parent->d_subdirs);
+		}
+
+		spin_unlock(&parent->d_lock);
+	}
+}
+
+/*
+ * Undo sweep_negative() and move to the head of parent->d_subdirs.
+ * Must be called before converting negative dentry into positive.
+ */
+static void recycle_negative(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	spin_lock(&dentry->d_lock);
+	parent = lock_parent(dentry);
+	if (parent) {
+		list_move(&dentry->d_child, &parent->d_subdirs);
+		spin_unlock(&parent->d_lock);
+	}
+	dentry->d_flags &= ~DCACHE_TAIL_NEGATIVE;
+	spin_unlock(&dentry->d_lock);
+}
+
 static inline bool retain_dentry(struct dentry *dentry)
 {
 	WARN_ON(d_in_lookup(dentry));
@@ -703,6 +745,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 		spin_unlock(&inode->i_lock);
 	if (parent)
 		spin_unlock(&parent->d_lock);
+	if (d_is_negative(dentry))
+		sweep_negative(dentry);
 	spin_unlock(&dentry->d_lock);
 	return NULL;
 }
@@ -718,7 +762,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 static inline bool fast_dput(struct dentry *dentry)
 {
 	int ret;
-	unsigned int d_flags;
+	unsigned int d_flags, required;
 
 	/*
 	 * If we have a d_op->d_delete() operation, we sould not
@@ -766,6 +810,8 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * a 'delete' op, and it's referenced and already on
 	 * the LRU list.
 	 *
+	 * Cached negative dentry must be swept to the tail.
+	 *
 	 * NOTE! Since we aren't locked, these values are
 	 * not "stable". However, it is sufficient that at
 	 * some point after we dropped the reference the
@@ -777,10 +823,15 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
+
+	required = DCACHE_REFERENCED | DCACHE_LRU_LIST |
+		   (d_flags_negative(d_flags) ? DCACHE_TAIL_NEGATIVE : 0);
+
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
+		   DCACHE_DISCONNECTED | DCACHE_TAIL_NEGATIVE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
-	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
+	if (d_flags == required && !d_unhashed(dentry))
 		return true;
 
 	/*
@@ -852,6 +903,8 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
+			if (d_is_negative(dentry))
+				sweep_negative(dentry);
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
@@ -1951,6 +2004,8 @@ void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
 	if (inode) {
+		if (d_is_tail_negative(entry))
+			recycle_negative(entry);
 		security_d_instantiate(entry, inode);
 		spin_lock(&inode->i_lock);
 		__d_instantiate(entry, inode);
@@ -1970,6 +2025,8 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
 	BUG_ON(!inode);
 	lockdep_annotate_inode_mutex_key(inode);
+	if (d_is_tail_negative(entry))
+		recycle_negative(entry);
 	security_d_instantiate(entry, inode);
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 082b55068e4d..1127a394b931 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -217,6 +217,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_TAIL_NEGATIVE		0x80000000 /* All following siblings are negative */
 
 extern seqlock_t rename_lock;
 
@@ -493,6 +494,11 @@ static inline int simple_positive(const struct dentry *dentry)
 	return d_really_is_positive(dentry) && !d_unhashed(dentry);
 }
 
+static inline bool d_is_tail_negative(const struct dentry *dentry)
+{
+	return unlikely(dentry->d_flags & DCACHE_TAIL_NEGATIVE);
+}
+
 extern void d_set_fallthru(struct dentry *dentry);
 
 static inline bool d_is_fallthru(const struct dentry *dentry)

