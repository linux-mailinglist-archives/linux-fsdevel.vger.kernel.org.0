Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEFE1D7C6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgERPJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 11:09:51 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:45912 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgERPJu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 11:09:50 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 2CA0720479;
        Mon, 18 May 2020 15:09:44 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-next@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3] proc: proc_pid_ns takes super_block as an argument
Date:   Mon, 18 May 2020 17:08:18 +0200
Message-Id: <20200518150818.2929164-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <87lfltcbc4.fsf@x220.int.ebiederm.org>
References: <87lfltcbc4.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Mon, 18 May 2020 15:09:47 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot writes:
> general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> CPU: 0 PID: 6698 Comm: sshd Not tainted 5.7.0-rc5-next-20200515-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:tomoyo_get_local_path+0x450/0x800 security/tomoyo/realpath.c:165
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b4 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 60 49 8d 7f 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 87 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc900063d7450 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: ffff88809975c000 RCX: ffffffff8363deda
> RDX: 0000000000000005 RSI: ffffffff8363dee8 RDI: 0000000000000028
> RBP: 1ffff92000c7ae8b R08: ffff8880a47644c0 R09: fffffbfff155a0a2
> R10: ffffffff8aad050f R11: fffffbfff155a0a1 R12: ffff88809df3cfea
> R13: ffff88809df3c000 R14: 0000000000001a2a R15: 0000000000000000
> FS:  00007efe13ce28c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e78cf578f5 CR3: 00000000987ed000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  tomoyo_realpath_from_path+0x393/0x620 security/tomoyo/realpath.c:282
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_number_perm+0x1c2/0x4d0 security/tomoyo/file.c:723
>  tomoyo_path_mknod+0x10d/0x190 security/tomoyo/tomoyo.c:246
>  security_path_mknod+0x116/0x180 security/security.c:1072
>  may_o_create fs/namei.c:2905 [inline]
>  lookup_open+0x5ae/0x1320 fs/namei.c:3046
>  open_last_lookups fs/namei.c:3155 [inline]
>  path_openat+0x93c/0x27f0 fs/namei.c:3343
>  do_filp_open+0x192/0x260 fs/namei.c:3373
>  do_sys_openat2+0x585/0x7d0 fs/open.c:1179
>  do_sys_open+0xc3/0x140 fs/open.c:1195
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x7efe11e4b6f0
> Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 83 3d 19 30 2c 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe 9d 01 00 48 89 04 24
> RSP: 002b:00007ffc3d0894d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 000055e78f0bc110 RCX: 00007efe11e4b6f0
> RDX: 00000000000001b6 RSI: 0000000000000241 RDI: 000055e78cf578f5
> RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000001
> R10: 0000000000000240 R11: 0000000000000246 R12: 000055e78cf2851e
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 0a58064de06d50f4 ]---
> RIP: 0010:tomoyo_get_local_path+0x450/0x800 security/tomoyo/realpath.c:165
> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b4 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 60 49 8d 7f 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 87 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc900063d7450 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: ffff88809975c000 RCX: ffffffff8363deda
> RDX: 0000000000000005 RSI: ffffffff8363dee8 RDI: 0000000000000028
> RBP: 1ffff92000c7ae8b R08: ffff8880a47644c0 R09: fffffbfff155a0a2
> R10: ffffffff8aad050f R11: fffffbfff155a0a1 R12: ffff88809df3cfea
> R13: ffff88809df3c000 R14: 0000000000001a2a R15: 0000000000000000
> FS:  00007efe13ce28c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dfe16c15f8 CR3: 00000000987ed000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

This is happening as part of creating a file or a device node. The
dentry that is passed in most likely comes from d_alloc_parallel and
does not have a d_inode.

Before c59f415a7cb6, Tomoyo received pid_ns from proc's s_fs_info
directly. Since proc_pid_ns() can only work with inode, using it in
the tomoyo_get_local_path() was wrong.

To avoid creating more functions for getting proc_ns would be more
correct to change the argument type of the proc_pid_ns() function.

In this case, Tomoyo can use the existing super_block to get pid_ns.

Reported-by: syzbot+c1af344512918c61362c@syzkaller.appspotmail.com
Fixes: c59f415a7cb6 ("Use proc_pid_ns() to get pid_namespace from the proc superblock")
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/locks.c                 |  4 ++--
 fs/proc/array.c            |  2 +-
 fs/proc/base.c             | 10 +++++-----
 fs/proc/self.c             |  2 +-
 fs/proc/thread_self.c      |  2 +-
 include/linux/proc_fs.h    |  4 ++--
 kernel/fork.c              |  2 +-
 net/ipv6/ip6_flowlabel.c   |  2 +-
 security/tomoyo/realpath.c |  2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 399c5dbb72c4..ab702d6efb55 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2823,7 +2823,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 {
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
-	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
+	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 
 	fl_pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2901,7 +2901,7 @@ static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
 	struct file_lock *fl, *bfl;
-	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
+	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 
 	fl = hlist_entry(v, struct file_lock, fl_link);
 
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 8e16f14bb05a..043311014db2 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -728,7 +728,7 @@ static int children_seq_show(struct seq_file *seq, void *v)
 {
 	struct inode *inode = file_inode(seq->file);
 
-	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(inode)));
+	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(inode->i_sb)));
 	return 0;
 }
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5a307b3bb2d1..30c9fceca0b7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -754,7 +754,7 @@ static const struct inode_operations proc_def_inode_operations = {
 static int proc_single_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct pid_namespace *ns = proc_pid_ns(inode);
+	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	struct pid *pid = proc_pid(inode);
 	struct task_struct *task;
 	int ret;
@@ -1423,7 +1423,7 @@ static const struct file_operations proc_fail_nth_operations = {
 static int sched_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct pid_namespace *ns = proc_pid_ns(inode);
+	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -2466,7 +2466,7 @@ static int proc_timers_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	tp->pid = proc_pid(inode);
-	tp->ns = proc_pid_ns(inode);
+	tp->ns = proc_pid_ns(inode->i_sb);
 	return 0;
 }
 
@@ -3377,7 +3377,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
 	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
-	struct pid_namespace *ns = proc_pid_ns(file_inode(file));
+	struct pid_namespace *ns = proc_pid_ns(file_inode(file)->i_sb);
 	loff_t pos = ctx->pos;
 
 	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
@@ -3730,7 +3730,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
 	 */
-	ns = proc_pid_ns(inode);
+	ns = proc_pid_ns(inode->i_sb);
 	tid = (int)file->f_version;
 	file->f_version = 0;
 	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 309301ac0136..ca5158fa561c 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -12,7 +12,7 @@ static const char *proc_self_get_link(struct dentry *dentry,
 				      struct inode *inode,
 				      struct delayed_call *done)
 {
-	struct pid_namespace *ns = proc_pid_ns(inode);
+	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	char *name;
 
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index 2493cbbdfa6f..ac284f409568 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -12,7 +12,7 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
 					     struct inode *inode,
 					     struct delayed_call *done)
 {
-	struct pid_namespace *ns = proc_pid_ns(inode);
+	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	pid_t pid = task_pid_nr_ns(current, ns);
 	char *name;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 2cb424e6f36a..6ec524d8842c 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -202,9 +202,9 @@ int open_related_ns(struct ns_common *ns,
 		   struct ns_common *(*get_ns)(struct ns_common *ns));
 
 /* get the associated pid namespace for a file in procfs */
-static inline struct pid_namespace *proc_pid_ns(const struct inode *inode)
+static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
 {
-	return proc_sb_info(inode->i_sb)->pid_ns;
+	return proc_sb_info(sb)->pid_ns;
 }
 
 #endif /* _LINUX_PROC_FS_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 4385f3d639f2..e7bdaccad942 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1745,7 +1745,7 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 	pid_t nr = -1;
 
 	if (likely(pid_has_task(pid, PIDTYPE_PID))) {
-		ns = proc_pid_ns(file_inode(m->file));
+		ns = proc_pid_ns(file_inode(m->file)->i_sb);
 		nr = pid_nr_ns(pid, ns);
 	}
 
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index d64b83e85642..ce4fbba4acce 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -779,7 +779,7 @@ static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
 
-	state->pid_ns = proc_pid_ns(file_inode(seq->file));
+	state->pid_ns = proc_pid_ns(file_inode(seq->file)->i_sb);
 
 	rcu_read_lock_bh();
 	return *pos ? ip6fl_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index 08b096e2f7e3..df4798980416 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -162,7 +162,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
 		char *ep;
 		const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
-		struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
+		struct pid_namespace *proc_pidns = proc_pid_ns(sb);
 
 		if (*ep == '/' && pid && pid ==
 		    task_tgid_nr_ns(current, proc_pidns)) {
-- 
2.25.4

