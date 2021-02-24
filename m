Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042B323B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 12:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhBXL2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 06:28:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12570 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhBXL2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:28:33 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dltrl5zRqzMcfL;
        Wed, 24 Feb 2021 19:25:43 +0800 (CST)
Received: from huawei.com (10.151.151.241) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Feb 2021
 19:27:38 +0800
From:   Luo Longjun <luolongjun@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        <bfields@fieldses.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sangyan@huawei.com>, <luchunhua@huawei.com>,
        <luolongjun@huawei.com>
Subject: [PATCH v2 02/24] fs/locks: print full locks information
Date:   Wed, 24 Feb 2021 03:35:44 -0500
Message-ID: <20210224083544.750887-1-luolongjun@huawei.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <YDKP0XdT1TVOaGnj@zeniv-ca.linux.org.uk>
References: <YDKP0XdT1TVOaGnj@zeniv-ca.linux.org.uk>
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

To solve this problem, we should traverse the tree by non-recursion DFS.

Signed-off-by: Luo Longjun <luolongjun@huawei.com>
---
 fs/locks.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 99ca97e81b7a..fdf240626777 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2827,8 +2827,14 @@ struct locks_iterator {
 	loff_t	li_pos;
 };
 
+struct locks_traverse_list {
+	struct list_head head;
+	struct file_lock *lock;
+	int level;
+};
+
 static void lock_get_status(struct seq_file *f, struct file_lock *fl,
-			    loff_t id, char *pfx)
+			    loff_t id, char *pfx, int repeat)
 {
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
@@ -2844,7 +2850,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (fl->fl_file != NULL)
 		inode = locks_inode(fl->fl_file);
 
-	seq_printf(f, "%lld:%s ", id, pfx);
+	seq_printf(f, "%lld: ", id);
+
+	if (repeat)
+		seq_printf(f, "%*s", repeat - 1 + strlen(pfx), pfx);
+
 	if (IS_POSIX(fl)) {
 		if (fl->fl_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
@@ -2912,17 +2922,66 @@ static int locks_show(struct seq_file *f, void *v)
 	struct file_lock *fl, *bfl;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 
+	struct list_head root;
+	struct list_head *tail = &root;
+	struct list_head *pos, *tmp;
+	struct locks_traverse_list *node, *node_child;
+
+	int ret = 0;
+
 	fl = hlist_entry(v, struct file_lock, fl_link);
 
 	if (locks_translate_pid(fl, proc_pidns) == 0)
-		return 0;
+		return ret;
+
+	INIT_LIST_HEAD(&root);
 
-	lock_get_status(f, fl, iter->li_pos, "");
+	node = kmalloc(sizeof(struct locks_traverse_list), GFP_KERNEL);
+	if (!node) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
-		lock_get_status(f, bfl, iter->li_pos, " ->");
+	node->level = 0;
+	node->lock = fl;
+	list_add(&node->head, tail);
+	tail = &node->head;
 
-	return 0;
+	while (tail != &root) {
+		node = list_entry(tail, struct locks_traverse_list, head);
+		if (!node->level)
+			lock_get_status(f, node->lock, iter->li_pos, "", node->level);
+		else
+			lock_get_status(f, node->lock, iter->li_pos, "-> ", node->level);
+
+		tmp = tail->prev;
+		list_del(tail);
+		tail = tmp;
+
+		list_for_each_entry_reverse(bfl, &node->lock->fl_blocked_requests,
+						fl_blocked_member) {
+			node_child = kmalloc(sizeof(struct locks_traverse_list), GFP_KERNEL);
+			if (!node_child) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			node_child->level = node->level + 1;
+			node_child->lock = bfl;
+			list_add(&node_child->head, tail);
+			tail = &node_child->head;
+		}
+		kfree(node);
+	}
+
+out:
+	list_for_each_safe(pos, tmp, &root) {
+		node = list_entry(pos, struct locks_traverse_list, head);
+		list_del(pos);
+		if (!node)
+			kfree(node);
+	}
+	return ret;
 }
 
 static void __show_fd_locks(struct seq_file *f,
@@ -2941,7 +3000,7 @@ static void __show_fd_locks(struct seq_file *f,
 
 		(*id)++;
 		seq_puts(f, "lock:\t");
-		lock_get_status(f, fl, *id, "");
+		lock_get_status(f, fl, *id, "", 0);
 	}
 }
 
-- 
2.17.1

