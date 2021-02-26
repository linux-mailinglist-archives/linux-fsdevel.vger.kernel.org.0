Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A660325DB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 07:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBZGvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 01:51:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12583 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBZGvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:51:17 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dn0by6MRJzMfMs;
        Fri, 26 Feb 2021 14:48:30 +0800 (CST)
Received: from huawei.com (10.151.151.241) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Feb 2021
 14:50:25 +0800
From:   Luo Longjun <luolongjun@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        <bfields@fieldses.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sangyan@huawei.com>, <luchunhua@huawei.com>,
        <luolongjun@huawei.com>
Subject: [PATCH v3] fs/locks: print full locks information
Date:   Thu, 25 Feb 2021 22:58:29 -0500
Message-ID: <685386c2840b76c49b060bf7dcea1fefacf18176.1614322182.git.luolongjun@huawei.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210221201024.GB15975@fieldses.org>
References: <20210221201024.GB15975@fieldses.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.151.151.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit fd7732e033e3 ("fs/locks: create a tree of dependent requests.")
has put blocked locks into a tree.

So, with a for loop, we can't check all locks information.

To solve this problem, we should traverse the tree.

Signed-off-by: Luo Longjun <luolongjun@huawei.com>
---
 fs/locks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 99ca97e81b7a..ecaecd1f1b58 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2828,7 +2828,7 @@ struct locks_iterator {
 };
 
 static void lock_get_status(struct seq_file *f, struct file_lock *fl,
-			    loff_t id, char *pfx)
+			    loff_t id, char *pfx, int repeat)
 {
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
@@ -2844,7 +2844,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (fl->fl_file != NULL)
 		inode = locks_inode(fl->fl_file);
 
-	seq_printf(f, "%lld:%s ", id, pfx);
+	seq_printf(f, "%lld: ", id);
+
+	if (repeat)
+		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
+
 	if (IS_POSIX(fl)) {
 		if (fl->fl_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
@@ -2906,21 +2910,64 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	}
 }
 
+static struct file_lock *get_next_blocked_member(struct file_lock *node)
+{
+	struct file_lock *tmp;
+
+	/* NULL node or root node */
+	if (node == NULL || node->fl_blocker == NULL)
+		return NULL;
+
+	/* Next member in the linked list could be itself */
+	tmp = list_next_entry(node, fl_blocked_member);
+	if (list_entry_is_head(tmp, &node->fl_blocker->fl_blocked_requests, fl_blocked_member)
+		|| tmp == node) {
+		return NULL;
+	}
+
+	return tmp;
+}
+
 static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
-	struct file_lock *fl, *bfl;
+	struct file_lock *cur, *tmp;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
+	int level = 0;
 
-	fl = hlist_entry(v, struct file_lock, fl_link);
+	cur = hlist_entry(v, struct file_lock, fl_link);
 
-	if (locks_translate_pid(fl, proc_pidns) == 0)
+	if (locks_translate_pid(cur, proc_pidns) == 0)
 		return 0;
 
-	lock_get_status(f, fl, iter->li_pos, "");
+	/* View this crossed linked list as a binary tree, the first member of fl_blocked_requests
+	 * is the left child of current node, the next silibing in fl_blocked_member is the
+	 * right child, we can alse get the parent of current node from fl_blocker, so this
+	 * question becomes traversal of a binary tree
+	 */
+	while (cur != NULL) {
+		if (level)
+			lock_get_status(f, cur, iter->li_pos, "-> ", level);
+		else
+			lock_get_status(f, cur, iter->li_pos, "", level);
 
-	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
-		lock_get_status(f, bfl, iter->li_pos, " ->");
+		if (!list_empty(&cur->fl_blocked_requests)) {
+			/* Turn left */
+			cur = list_first_entry_or_null(&cur->fl_blocked_requests,
+				struct file_lock, fl_blocked_member);
+			level++;
+		} else {
+			/* Turn right */
+			tmp = get_next_blocked_member(cur);
+			/* Fall back to parent node */
+			while (tmp == NULL && cur->fl_blocker != NULL) {
+				cur = cur->fl_blocker;
+				level--;
+				tmp = get_next_blocked_member(cur);
+			}
+			cur = tmp;
+		}
+	}
 
 	return 0;
 }
@@ -2941,7 +2988,7 @@ static void __show_fd_locks(struct seq_file *f,
 
 		(*id)++;
 		seq_puts(f, "lock:\t");
-		lock_get_status(f, fl, *id, "");
+		lock_get_status(f, fl, *id, "", 0);
 	}
 }
 
-- 
2.17.1

