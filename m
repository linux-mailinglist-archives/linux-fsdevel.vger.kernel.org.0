Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B662FEF4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbhAUPoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:44:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbhAUNVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDF7ke095736;
        Thu, 21 Jan 2021 13:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=JAakYMUma2jefmdeRpGGqctUcknR7wWq0NyR3UJjT+E=;
 b=v1W1XZOLzb9S5EzQIarazmx4SbZsEjE8LFmnJ4cvqwpNjAEj6k46NUHtESgUhnAE/wZZ
 /Ns5T23sqLrT5yH5j11zY78mKe1Ba0+PivfGxmnH1PbK/jaf3MEVt/6ouD1WbQcoO0ur
 2jruQ6s5MAjch+l9fya1dt4RAu4w/YpMV658p5UBgX6mw1y+IprfuDL8gH3ALi6DslG8
 ODnLBPrG5Hn2pussl9DI/1Mra1cLTvZNFiH4eIYsMj6X3C17SNZQnrq5THjcyYOMT0NK
 0Y+qmDZzwHgS5CSJD7LzST1UGLqcno8WdTRhua65XMPjXIN9ujzaqH2dEj47KrgFxbxq 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3668qrf9ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:20:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDFkAW106737;
        Thu, 21 Jan 2021 13:20:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3668rexqhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:20:47 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LDKZJ9123118;
        Thu, 21 Jan 2021 13:20:47 GMT
Received: from gmananth-linux.oraclecorp.com (dhcp-10-166-171-141.vpn.oracle.com [10.166.171.141])
        by userp3030.oracle.com with ESMTP id 3668rexq88-2;
        Thu, 21 Jan 2021 13:20:47 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     viro@zeniv.linux.org.uk, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru, gautham.ananthakrishna@oracle.com
Subject: [PATCH RFC 1/6] dcache: sweep cached negative dentries to the end of list of siblings
Date:   Thu, 21 Jan 2021 18:49:40 +0530
Message-Id: <1611235185-1685-2-git-send-email-gautham.ananthakrishna@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

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
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
---
 fs/dcache.c            | 59 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/dcache.h |  6 +++++
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea04858..a506169 100644
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
+	dentry->d_flags &= ~DCACHE_TAIL_NEGATIVE;
+	if (parent) {
+		list_move(&dentry->d_child, &parent->d_subdirs);
+		spin_unlock(&parent->d_lock);
+	}
+	spin_unlock(&dentry->d_lock);
+}
+
 static inline bool retain_dentry(struct dentry *dentry)
 {
 	WARN_ON(d_in_lookup(dentry));
@@ -737,7 +779,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 static inline bool fast_dput(struct dentry *dentry)
 {
 	int ret;
-	unsigned int d_flags;
+	unsigned int d_flags, required;
 
 	/*
 	 * If we have a d_op->d_delete() operation, we sould not
@@ -785,6 +827,8 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * a 'delete' op, and it's referenced and already on
 	 * the LRU list.
 	 *
+	 * Cached negative dentry must be swept to the tail.
+	 *
 	 * NOTE! Since we aren't locked, these values are
 	 * not "stable". However, it is sufficient that at
 	 * some point after we dropped the reference the
@@ -796,10 +840,15 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
+
+	required = DCACHE_REFERENCED | DCACHE_LRU_LIST |
+		(d_flags_negative(d_flags) ? DCACHE_TAIL_NEGATIVE : 0);
+
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
+		DCACHE_DISCONNECTED | DCACHE_TAIL_NEGATIVE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
-	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
+	if (d_flags == required && !d_unhashed(dentry))
 		return true;
 
 	/*
@@ -871,6 +920,8 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
+			if (d_is_negative(dentry))
+				sweep_negative(dentry);
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
@@ -1970,6 +2021,8 @@ void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
 	if (inode) {
+		if (d_is_tail_negative(entry))
+			recycle_negative(entry);
 		security_d_instantiate(entry, inode);
 		spin_lock(&inode->i_lock);
 		__d_instantiate(entry, inode);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6f95c33..5f4ce3a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -219,6 +219,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_TAIL_NEGATIVE		0x80000000 /* All following siblings are negative */
 
 extern seqlock_t rename_lock;
 
@@ -495,6 +496,11 @@ static inline int simple_positive(const struct dentry *dentry)
 	return d_really_is_positive(dentry) && !d_unhashed(dentry);
 }
 
+static inline bool d_is_tail_negative(const struct dentry *dentry)
+{
+	return unlikely(dentry->d_flags & DCACHE_TAIL_NEGATIVE);
+}
+
 extern void d_set_fallthru(struct dentry *dentry);
 
 static inline bool d_is_fallthru(const struct dentry *dentry)
-- 
1.8.3.1

