Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D34539D04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 08:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349841AbiFAGK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 02:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349824AbiFAGKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:10:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1350E10;
        Tue, 31 May 2022 23:10:21 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LCdxh256MzgYJS;
        Wed,  1 Jun 2022 14:08:40 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 14:10:19 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 14:10:19 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v4] proc: Fix a dentry lock race between release_task and lookup
Date:   Wed, 1 Jun 2022 14:23:32 +0800
Message-ID: <20220601062332.232439-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
kernel_waitid                 stat(/proc/tgid)
  do_wait                       filename_lookup
    wait_consider_task            lookup_fast
      release_task
        __exit_signal
          __unhash_process
            detach_pid
              __change_pid // remove task->pid_links
                                     d_revalidate -> pid_revalidate  // 0
                                     d_invalidate(/proc/tgid)
                                       shrink_dcache_parent(/proc/tgid)
                                         d_walk(/proc/tgid)
                                           spin_lock_nested(/proc/tgid/fd)
                                           // iterating opened fd
        proc_flush_pid                                    |
           d_invalidate (/proc/tgid/fd)                   |
              shrink_dcache_parent(/proc/tgid/fd)         |
                shrink_dentry_list(subdirs)               ↓
                  shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock

Function d_invalidate() will remove dentry from hash firstly, but why does
proc_flush_pid() process dentry '/proc/tgid/fd' before dentry '/proc/tgid'?
That's because proc_pid_make_inode() adds proc inode in reverse order by
invoking hlist_add_head_rcu(). But proc should not add any inodes under
'/proc/tgid' except '/proc/tgid/task/pid', fix it by adding inode into
'pid->inodes' only if the inode is /proc/tgid or /proc/tgid/task/pid.

Performance regression:
Create 200 tasks, each task open one file for 50,000 times. Kill all
tasks when opened files exceed 10,000,000 (cat /proc/sys/fs/file-nr).

Before fix:
$ time killall -wq aa
  real    4m40.946s   # During this period, we can see 'ps' and 'systemd'
			taking high cpu usage.

After fix:
$ time killall -wq aa
  real    1m20.732s   # During this period, we can see 'systemd' taking
			high cpu usage.

Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 v1->v2: Add new helper proc_pid_make_base_inode that performs the extra
	 work of adding to the pid->list.
 v2->v3: Add performance regression in commit message.
 v3->v4: Make proc_pid_make_base_inode() static
 fs/proc/base.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..d884933950fd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1885,7 +1885,7 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 	put_pid(pid);
 }
 
-struct inode *proc_pid_make_inode(struct super_block * sb,
+struct inode *proc_pid_make_inode(struct super_block *sb,
 				  struct task_struct *task, umode_t mode)
 {
 	struct inode * inode;
@@ -1914,11 +1914,6 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
-	if (S_ISDIR(mode)) {
-		spin_lock(&pid->lock);
-		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
-		spin_unlock(&pid->lock);
-	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 	security_task_to_inode(task, inode);
@@ -1931,6 +1926,27 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	return NULL;
 }
 
+static struct inode *proc_pid_make_base_inode(struct super_block *sb,
+				struct task_struct *task, umode_t mode)
+{
+	struct inode *inode;
+	struct proc_inode *ei;
+	struct pid *pid;
+
+	inode = proc_pid_make_inode(sb, task, mode);
+	if (!inode)
+		return NULL;
+
+	/* Let proc_flush_pid find this directory inode */
+	ei = PROC_I(inode);
+	pid = ei->pid;
+	spin_lock(&pid->lock);
+	hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
+	spin_unlock(&pid->lock);
+
+	return inode;
+}
+
 int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
@@ -3350,7 +3366,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task,
+					 S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -3649,7 +3666,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task,
+					 S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
-- 
2.31.1

