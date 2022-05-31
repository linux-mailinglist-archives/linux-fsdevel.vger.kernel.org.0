Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B45393E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbiEaPXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345631AbiEaPXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 11:23:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D962FE4F;
        Tue, 31 May 2022 08:23:47 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LCGJR3c8TzDqXs;
        Tue, 31 May 2022 23:23:35 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 23:23:45 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 23:23:45 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC] proc: Fix a dentry lock race between release_task and lookup
Date:   Tue, 31 May 2022 23:37:08 +0800
Message-ID: <20220531153708.3449446-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
moved proc_flush_task() behind __exit_signal(). Then, process systemd
can take long period high cpu usage during releasing task in following
concurrent processes:

  systemd                                 ps
kernel_waitid                 stat(/proc/pid)
  do_wait                       filename_lookup
    wait_consider_task            lookup_fast
      release_task
        __exit_signal
          __unhash_process
            detach_pid
              __change_pid // remove task->pid_links
                                     d_revalidate -> pid_revalidate  // 0
                                     d_invalidate(/proc/pid)
                                       shrink_dcache_parent(/proc/pid)
                                         d_walk(/proc/pid)
                                           spin_lock_nested(/proc/pid/fd)
                                           // iterating opened fd
        proc_flush_pid                                    |
           d_invalidate (/proc/pid/fd)                    |
              shrink_dcache_parent(/proc/pid/fd)          |
                shrink_dentry_list(subdirs)               ↓
                  shrink_lock_dentry(/proc/pid/fd) ---> race on dentry lock

Function d_invalidate() will remove dentry from hash firstly, but why does
proc_flush_pid() process dentry '/proc/pid/fd' before dentry '/proc/pid'?
That's because proc_pid_make_inode() adds proc inode in reverse order by
invoking hlist_add_head_rcu(). But proc should not add any inodes under
'/proc/pid' except '/proc/pid/task/pid', fix it by adding inode into
'pid->inodes' only if the inode is /proc/pid or /proc/pid/task/pid.

Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/proc/base.c       | 15 +++++++++------
 fs/proc/fd.c         |  4 ++--
 fs/proc/internal.h   |  3 ++-
 fs/proc/namespaces.c |  3 ++-
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..29c0f1175766 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1886,7 +1886,8 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 }
 
 struct inode *proc_pid_make_inode(struct super_block * sb,
-				  struct task_struct *task, umode_t mode)
+				  struct task_struct *task,
+				  umode_t mode, bool add_inode)
 {
 	struct inode * inode;
 	struct proc_inode *ei;
@@ -1914,7 +1915,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
-	if (S_ISDIR(mode)) {
+	if (add_inode) {
 		spin_lock(&pid->lock);
 		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
 		spin_unlock(&pid->lock);
@@ -2243,7 +2244,7 @@ proc_map_files_instantiate(struct dentry *dentry,
 
 	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK |
 				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
-				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
+				    ((mode & FMODE_WRITE) ? S_IWUSR : 0), false);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -2609,7 +2610,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, p->mode);
+	inode = proc_pid_make_inode(dentry->d_sb, task, p->mode, false);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -3350,7 +3351,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_inode(dentry->d_sb, task,
+				    S_IFDIR | S_IRUGO | S_IXUGO, true);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -3649,7 +3651,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_inode(dentry->d_sb, task,
+				    S_IFDIR | S_IRUGO | S_IXUGO, true);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 913bef0d2a36..53365ebb4567 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -199,7 +199,7 @@ static struct dentry *proc_fd_instantiate(struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK);
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK, false);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -332,7 +332,7 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR);
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR, false);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..9894a591a38c 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,7 +162,8 @@ extern int pid_getattr(struct user_namespace *, const struct path *,
 extern int pid_getattr(const struct path *, struct kstat *, u32, unsigned int);
 extern int proc_setattr(struct dentry *, struct iattr *);
 extern void proc_pid_evict_inode(struct proc_inode *);
-extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
+extern struct inode *proc_pid_make_inode(struct super_block *,
+					 struct task_struct *, umode_t, bool);
 extern void pid_update_inode(struct task_struct *, struct inode *);
 extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a..c9006e3b36fc 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -102,7 +102,8 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRWXUGO);
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRWXUGO,
+				    false);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
-- 
2.31.1

