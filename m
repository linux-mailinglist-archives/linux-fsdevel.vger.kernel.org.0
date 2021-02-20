Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE153204AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 10:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhBTJZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 04:25:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12559 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBTJZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:25:31 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DjNJq2PzBzMc4Z;
        Sat, 20 Feb 2021 17:22:51 +0800 (CST)
Received: from huawei.com (10.151.151.241) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Feb 2021
 17:24:40 +0800
From:   Luo Longjun <luolongjun@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        <bfields@fieldses.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sangyan@huawei.com>, <luchunhua@huawei.com>
Subject: [PATCH] fs/locks: print full locks information
Date:   Sat, 20 Feb 2021 01:32:50 -0500
Message-ID: <20210220063250.742164-1-luolongjun@huawei.com>
X-Mailer: git-send-email 2.28.0
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

To solve this problem, we should traverse the tree by DFS.

Signed-off-by: Luo Longjun <luolongjun@huawei.com>
---
 fs/locks.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 99ca97e81b7a..1f7b6683ed54 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2828,9 +2828,10 @@ struct locks_iterator {
 };
 
 static void lock_get_status(struct seq_file *f, struct file_lock *fl,
-			    loff_t id, char *pfx)
+			    loff_t id, char *pfx, int repeat)
 {
 	struct inode *inode = NULL;
+	int i;
 	unsigned int fl_pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 
@@ -2844,7 +2845,13 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (fl->fl_file != NULL)
 		inode = locks_inode(fl->fl_file);
 
-	seq_printf(f, "%lld:%s ", id, pfx);
+	seq_printf(f, "%lld: ", id);
+	for (i = 1; i < repeat; i++)
+		seq_puts(f, " ");
+
+	if (repeat)
+		seq_printf(f, "%s", pfx);
+
 	if (IS_POSIX(fl)) {
 		if (fl->fl_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
@@ -2906,6 +2913,19 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	}
 }
 
+static int __locks_show(struct seq_file *f, struct file_lock *fl, int level)
+{
+	struct locks_iterator *iter = f->private;
+	struct file_lock *bfl;
+
+	lock_get_status(f, fl, iter->li_pos, "-> ", level);
+
+	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
+		__locks_show(f, bfl, level + 1);
+
+	return 0;
+}
+
 static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
@@ -2917,10 +2937,10 @@ static int locks_show(struct seq_file *f, void *v)
 	if (locks_translate_pid(fl, proc_pidns) == 0)
 		return 0;
 
-	lock_get_status(f, fl, iter->li_pos, "");
+	lock_get_status(f, fl, iter->li_pos, "", 0);
 
 	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
-		lock_get_status(f, bfl, iter->li_pos, " ->");
+		__locks_show(f, bfl, 1);
 
 	return 0;
 }
@@ -2941,7 +2961,7 @@ static void __show_fd_locks(struct seq_file *f,
 
 		(*id)++;
 		seq_puts(f, "lock:\t");
-		lock_get_status(f, fl, *id, "");
+		lock_get_status(f, fl, *id, "", 0);
 	}
 }
 
-- 
2.17.1

