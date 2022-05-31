Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6F53951F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 18:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbiEaQ5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 12:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346231AbiEaQ5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 12:57:47 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A3E32079;
        Tue, 31 May 2022 09:57:46 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56992)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nw5Bg-001lgm-LF; Tue, 31 May 2022 10:57:44 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42704 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nw5Be-007x07-HF; Tue, 31 May 2022 10:57:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        Alexey Gladkov <legion@kernel.org>
References: <20220531153708.3449446-1-chengzhihao1@huawei.com>
Date:   Tue, 31 May 2022 11:57:36 -0500
In-Reply-To: <20220531153708.3449446-1-chengzhihao1@huawei.com> (Zhihao
        Cheng's message of "Tue, 31 May 2022 23:37:08 +0800")
Message-ID: <877d61ej27.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nw5Be-007x07-HF;;;mid=<877d61ej27.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX194TtodTUmxt8k5gyHJn5GVYFunN63ZQUE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Zhihao Cheng <chengzhihao1@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1536 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.3%), b_tie_ro: 2.7 (0.2%), parse: 0.80
        (0.1%), extract_message_metadata: 9 (0.6%), get_uri_detail_list: 1.97
        (0.1%), tests_pri_-1000: 3.8 (0.2%), tests_pri_-950: 0.97 (0.1%),
        tests_pri_-900: 0.79 (0.1%), tests_pri_-90: 98 (6.4%), check_bayes: 96
        (6.3%), b_tokenize: 8 (0.5%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        1.82 (0.1%), b_tok_touch_all: 75 (4.9%), b_finish: 0.79 (0.1%),
        tests_pri_0: 1404 (91.4%), check_dkim_signature: 0.43 (0.0%),
        check_dkim_adsp: 1.87 (0.1%), poll_dns_idle: 0.54 (0.0%),
        tests_pri_10: 3.4 (0.2%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH RFC] proc: Fix a dentry lock race between release_task
 and lookup
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zhihao Cheng <chengzhihao1@huawei.com> writes:

> Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> moved proc_flush_task() behind __exit_signal(). Then, process systemd
> can take long period high cpu usage during releasing task in following
> concurrent processes:
>
>   systemd                                 ps
> kernel_waitid                 stat(/proc/pid)
>   do_wait                       filename_lookup
>     wait_consider_task            lookup_fast
>       release_task
>         __exit_signal
>           __unhash_process
>             detach_pid
>               __change_pid // remove task->pid_links
>                                      d_revalidate -> pid_revalidate  // 0
>                                      d_invalidate(/proc/pid)
>                                        shrink_dcache_parent(/proc/pid)
>                                          d_walk(/proc/pid)
>                                            spin_lock_nested(/proc/pid/fd)
>                                            // iterating opened fd
>         proc_flush_pid                                    |
>            d_invalidate (/proc/pid/fd)                    |
>               shrink_dcache_parent(/proc/pid/fd)          |
>                 shrink_dentry_list(subdirs)               ↓
>                   shrink_lock_dentry(/proc/pid/fd) ---> race on dentry lock
>
> Function d_invalidate() will remove dentry from hash firstly, but why does
> proc_flush_pid() process dentry '/proc/pid/fd' before dentry '/proc/pid'?
> That's because proc_pid_make_inode() adds proc inode in reverse order by
> invoking hlist_add_head_rcu(). But proc should not add any inodes under
> '/proc/pid' except '/proc/pid/task/pid', fix it by adding inode into
> 'pid->inodes' only if the inode is /proc/pid or /proc/pid/task/pid.

If I understand correctly you are saying that under some circumstances
this code runs slow, and you are proposing an optimization.

That optimization is to change the content of the pid->inodes list
from all directories under that pid, to just the /proc/<tgid> and
/proc/<tgid>/task/<pid>.

The justification being that d_invalidate on the parent directory will
invalidate all children.  So only those two directories are interesting
from a d_invalidate point of view.

That seems like a valid optimization.

This could also count as a regression fix if you can show how the
performance changed poorly when the pid->inodes change was introduced
and how the performance improves with your change.   I currently only
see that you hit a pathological case and you are correcting it.

As for the actual code change I think it would be better to
remove the code from proc_pid_make_inode and make a helper
proc_pid_make_base_inode that performs the extra work of
adding to the pid->list.  Not adding a flag makes the code
easier to follow.

Something like the code below.  

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7150fd..9d025e70ddc3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1915,11 +1915,6 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
-	if (S_ISDIR(mode)) {
-		spin_lock(&pid->lock);
-		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
-		spin_unlock(&pid->lock);
-	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 	security_task_to_inode(task, inode);
@@ -1932,6 +1927,27 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	return NULL;
 }
 
+struct inode *proc_pid_make_base_inode(struct super_block * sb,
+				       struct task_struct *task, umode_t mode)
+{
+	struct inode * inode;
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
@@ -3351,7 +3367,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -3650,7 +3666,7 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 

Eric
