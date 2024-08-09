Return-Path: <linux-fsdevel+bounces-25574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB294D7E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 22:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309C9283AA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72E167D83;
	Fri,  9 Aug 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1yp3bFE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45141161328
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234264; cv=none; b=TRSFR+PUeAasbzV/lN/SAGovfGXk37K0WOBtULUEL4tcw9vxYFobNPyjx6GBmOqHT3x/Ycxoj5y4B/3ZJE6te2TSvBRKtgaZu6DInFrTnnQMNm/JaPfbaAT/co7OAYK/4ZbdwHVKyZpPu2ZYmAi9qIqwVe23k2R3s6oa0ZvHRnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234264; c=relaxed/simple;
	bh=hiLCJpKOp+FXU1FJy5gIYYjyRZ2MV1YcKrWZ7c6Ie9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D50gtnrlk13Ln4WaSvnk0XKx1B4dfq0KvpRMls80Aw2lVjqDZyaJKfJ4KuuUvgXP6nj4yUUAU0EeKk9NMgHh3ffYL7sKwrq4JdDCgx42HChvI3qn7D8ZCmhZ+jCf5NvXAdh6l5lifzP5/KeULPTd0nRkrNG3a2X5w6i62awpuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1yp3bFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CA8C32786;
	Fri,  9 Aug 2024 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723234263;
	bh=hiLCJpKOp+FXU1FJy5gIYYjyRZ2MV1YcKrWZ7c6Ie9o=;
	h=From:To:Cc:Subject:Date:From;
	b=W1yp3bFEhFgz6QXf0+Y4kZuMuRy2EBSWxi1DiutfP6geiiniKZjAluuPo8ErAWjPq
	 zKQeHGT3u2mSTWi5iMP2Lr2XLg9VHZXkCv/+9dZVHktFEhRbbJN9edakNHuCI9q5Iu
	 JkfaQJ2vOT+Q0YmFCDRF6LR9obptoJZmTaqPjtAbKj5srss29YTTnNOLVkNLRJVjdY
	 KjRgBgyv+OuQKXjZ6mbzA+THZULGLs1IUGm5gJ/kVaH6EiJLUWi6h8pY+G0zOS9W3M
	 BNEs7+gaxB8MsiJBOMxv3D3QIUxazPhj0RgsNt8SnywUbZCzc3FL7kSLIhuzwkkIMz
	 HlLsopCWmpNUA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] [DRAFT RFC]: file: reclaim 24 bytes from f_owner
Date: Fri,  9 Aug 2024 22:10:40 +0200
Message-ID: <20240809-koriander-biobauer-6237cbc106f3@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17301; i=brauner@kernel.org; h=from:subject:message-id; bh=hiLCJpKOp+FXU1FJy5gIYYjyRZ2MV1YcKrWZ7c6Ie9o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtKz8yZ7bH4WqBBz73jmSUTbm9pzNbynvZ7n7HaWKd8 zz5N9tFdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExktTQjw3H9/WemrmAstag8 8iJm2iHfqa+f/2vbIKzw+vnJlIv+K3IZ/pfckXTdmTP1zS3DW9fmVBqk/ba36PnM+vDGhGjBu6x lVkwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This is in rough shape. I just drafted it quickly to get the idea
across. Compiled with all the SANS we have, booted and ran parts of LTP
and so far nothing murderd my vms. /me goes to get some sleep

The struct fown_struct wastes 32 bytes of precious memory in struct
file. It is often unused in a lot of workloads. We should put the burden
on the use-cases that care about this and make them allocate the struct
on demand. This will allow us to free up 24 bytes in struct file.

It will have some potentially user visible changes for the ownership
fcntl()s. Some of them might now fail due to allocation failures. How
realistic it is that we fail a 32 byte allocation and for someone to
actually notice it I'm not sure but I would think it's ok to risk it for
24 bytes.

Drivers that always want a f_owner can allocate it right at open time.
That's really just tun and tty devices because they may end up calling
__f_setown() at some point.

fcntl()s and file leases can just allocate on demand easily. Cleanup
happens during __fput() when file was really opend. For fcntl()s and
file leases this is guaranteed because the file is already alive. For
drivers they need to cleanup the allocated memory before they've
succesfully finished ->open(). Afterwards we'll just clean it up.

Interactions with O_PATH should be fine as well e.g., when opening a
/dev/tty as O_PATH then no ->open() happens thus no filp->f_owner is
allocated. That's fine as no file operation will be set for those and
the device has never been opened. fcntl()s called on such things will
just allocate a ->f_owner on demand. Although I have zero idea why'd you
care about f_owner on an O_PATH fd.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/net/tun.c           |   6 ++
 drivers/tty/tty_io.c        |   6 ++
 fs/fcntl.c                  | 151 ++++++++++++++++++++++++++++--------
 fs/file_table.c             |   7 +-
 fs/locks.c                  |   7 +-
 fs/notify/dnotify/dnotify.c |   5 +-
 include/linux/fs.h          |   9 ++-
 net/core/sock.c             |   2 +-
 security/selinux/hooks.c    |   2 +-
 security/smack/smack_lsm.c  |   2 +-
 10 files changed, 154 insertions(+), 43 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..1aab0bde1532 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3467,8 +3467,13 @@ static int tun_chr_fasync(int fd, struct file *file, int on)
 static int tun_chr_open(struct inode *inode, struct file * file)
 {
 	struct net *net = current->nsproxy->net_ns;
+	struct fown_struct *f_owner = __free(kfree) = NULL;
 	struct tun_file *tfile;
 
+	f_owner = file_f_owner_allocate(file);
+	if (IS_ERR(fowner))
+		return PTR_ERR(fowner);
+
 	tfile = (struct tun_file *)sk_alloc(net, AF_UNSPEC, GFP_KERNEL,
 					    &tun_proto, 0);
 	if (!tfile)
@@ -3500,6 +3505,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 
 	/* tun groks IOCB_NOWAIT just fine, mark it as such */
 	file->f_mode |= FMODE_NOWAIT;
+	f_owner = NULL;
 	return 0;
 }
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..c6ac57d289b3 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2119,12 +2119,17 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
 static int tty_open(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty;
+	struct fown_struct *f_owner __free(kfree) = NULL;
 	int noctty, retval;
 	dev_t device = inode->i_rdev;
 	unsigned saved_flags = filp->f_flags;
 
 	nonseekable_open(inode, filp);
 
+	f_owner = file_f_owner_allocate(filp);
+	if (IS_ERR(f_owner))
+		return PTR_ERR(f_owner);
+
 retry_open:
 	retval = tty_alloc_file(filp);
 	if (retval)
@@ -2183,6 +2188,7 @@ static int tty_open(struct inode *inode, struct file *filp)
 	if (!noctty)
 		tty_open_proc_set_tty(filp, tty);
 	tty_unlock(tty);
+	f_owner = NULL;
 	return 0;
 }
 
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..01bc626c881e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -87,22 +87,63 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
 	return error;
 }
 
+struct fown_struct nop_fown_struct = {
+	.lock		= __RW_LOCK_UNLOCKED(nop_fown_struct.lock),
+	.pid		= NULL,
+	.pid_type	= PIDTYPE_MAX,
+	.uid		= INVALID_UID,
+	.euid		= INVALID_UID,
+	.signum		= 0,
+};
+
+/*
+ * Allocate an file->f_owner struct if it doesn't exist, handling racing
+ * allocations correctly.
+ */
+struct fown_struct *file_f_owner_allocate(struct file *file)
+{
+	struct fown_struct *f_owner;
+
+	f_owner = smp_load_acquire(&file->f_owner);
+	if (f_owner != &nop_fown_struct)
+		return NULL;
+
+	f_owner = kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
+	if (!f_owner)
+		return ERR_PTR(-ENOMEM);
+
+	rwlock_init(&f_owner->lock);
+	f_owner->file = file;
+	/* If someone else raced us, drop our allocation. */
+	if (unlikely(cmpxchg(&file->f_owner, &nop_fown_struct, f_owner) !=
+		     &nop_fown_struct)) {
+		kfree(f_owner);
+		return NULL;
+	}
+
+	return f_owner;
+}
+
 static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
                      int force)
 {
-	write_lock_irq(&filp->f_owner.lock);
-	if (force || !filp->f_owner.pid) {
-		put_pid(filp->f_owner.pid);
-		filp->f_owner.pid = get_pid(pid);
-		filp->f_owner.pid_type = type;
+	struct fown_struct *f_owner = smp_load_acquire(&filp->f_owner);
+	if (WARN_ON_ONCE(f_owner == &nop_fown_struct))
+		return;
+
+	write_lock_irq(&f_owner->lock);
+	if (force || !f_owner->pid) {
+		put_pid(f_owner->pid);
+		f_owner->pid = get_pid(pid);
+		f_owner->pid_type = type;
 
 		if (pid) {
 			const struct cred *cred = current_cred();
-			filp->f_owner.uid = cred->uid;
-			filp->f_owner.euid = cred->euid;
+			f_owner->uid = cred->uid;
+			f_owner->euid = cred->euid;
 		}
 	}
-	write_unlock_irq(&filp->f_owner.lock);
+	write_unlock_irq(&f_owner->lock);
 }
 
 void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
@@ -119,6 +160,8 @@ int f_setown(struct file *filp, int who, int force)
 	struct pid *pid = NULL;
 	int ret = 0;
 
+	might_sleep();
+
 	type = PIDTYPE_TGID;
 	if (who < 0) {
 		/* avoid overflow below */
@@ -129,6 +172,9 @@ int f_setown(struct file *filp, int who, int force)
 		who = -who;
 	}
 
+	if (IS_ERR(file_f_owner_allocate(filp)))
+		return -ENOMEM;
+
 	rcu_read_lock();
 	if (who) {
 		pid = find_vpid(who);
@@ -152,16 +198,20 @@ void f_delown(struct file *filp)
 pid_t f_getown(struct file *filp)
 {
 	pid_t pid = 0;
+	struct fown_struct *f_owner = smp_load_acquire(&filp->f_owner);
+
+	if (f_owner == &nop_fown_struct)
+		return pid;
 
-	read_lock_irq(&filp->f_owner.lock);
+	read_lock_irq(&f_owner->lock);
 	rcu_read_lock();
-	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type)) {
-		pid = pid_vnr(filp->f_owner.pid);
-		if (filp->f_owner.pid_type == PIDTYPE_PGID)
+	if (pid_task(f_owner->pid, f_owner->pid_type)) {
+		pid = pid_vnr(f_owner->pid);
+		if (f_owner->pid_type == PIDTYPE_PGID)
 			pid = -pid;
 	}
 	rcu_read_unlock();
-	read_unlock_irq(&filp->f_owner.lock);
+	read_unlock_irq(&f_owner->lock);
 	return pid;
 }
 
@@ -210,13 +260,20 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 	struct f_owner_ex __user *owner_p = (void __user *)arg;
 	struct f_owner_ex owner = {};
 	int ret = 0;
+	struct fown_struct *f_owner;
+	enum pid_type pid_type = PIDTYPE_PID;
 
-	read_lock_irq(&filp->f_owner.lock);
-	rcu_read_lock();
-	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type))
-		owner.pid = pid_vnr(filp->f_owner.pid);
-	rcu_read_unlock();
-	switch (filp->f_owner.pid_type) {
+	f_owner = smp_load_acquire(&filp->f_owner);
+	if (f_owner != &nop_fown_struct) {
+		read_lock_irq(&f_owner->lock);
+		rcu_read_lock();
+		if (pid_task(f_owner->pid, f_owner->pid_type))
+			owner.pid = pid_vnr(f_owner->pid);
+		rcu_read_unlock();
+		pid_type = f_owner->pid_type;
+	}
+
+	switch (pid_type) {
 	case PIDTYPE_PID:
 		owner.type = F_OWNER_TID;
 		break;
@@ -234,7 +291,8 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 		ret = -EINVAL;
 		break;
 	}
-	read_unlock_irq(&filp->f_owner.lock);
+	if (f_owner != &nop_fown_struct)
+		read_unlock_irq(&f_owner->lock);
 
 	if (!ret) {
 		ret = copy_to_user(owner_p, &owner, sizeof(owner));
@@ -248,14 +306,18 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 static int f_getowner_uids(struct file *filp, unsigned long arg)
 {
 	struct user_namespace *user_ns = current_user_ns();
+	struct fown_struct *f_owner;
 	uid_t __user *dst = (void __user *)arg;
-	uid_t src[2];
+	uid_t src[2] = {0, 0};
 	int err;
 
-	read_lock_irq(&filp->f_owner.lock);
-	src[0] = from_kuid(user_ns, filp->f_owner.uid);
-	src[1] = from_kuid(user_ns, filp->f_owner.euid);
-	read_unlock_irq(&filp->f_owner.lock);
+	f_owner = smp_load_acquire(&filp->f_owner);
+	if (f_owner != &nop_fown_struct) {
+		read_lock_irq(&f_owner->lock);
+		src[0] = from_kuid(user_ns, f_owner->uid);
+		src[1] = from_kuid(user_ns, f_owner->euid);
+		read_unlock_irq(&f_owner->lock);
+	}
 
 	err  = put_user(src[0], &dst[0]);
 	err |= put_user(src[1], &dst[1]);
@@ -343,6 +405,24 @@ static long f_dupfd_query(int fd, struct file *filp)
 	return f.file == filp;
 }
 
+static int f_owner_sig(struct file *filp, int signum, bool setsig)
+{
+	struct fown_struct *f_owner;
+
+	f_owner = file_f_owner_allocate(filp);
+	if (IS_ERR(f_owner))
+		return PTR_ERR(f_owner);
+	f_owner = filp->f_owner;
+	if (setsig) {
+		if (!valid_signal(signum))
+			return -EINVAL;
+		f_owner->signum = signum;
+		return 0;
+	}
+
+	return f_owner->signum;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -421,15 +501,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = f_getowner_uids(filp, arg);
 		break;
 	case F_GETSIG:
-		err = filp->f_owner.signum;
+		err = f_owner_sig(filp, 0, false);
 		break;
 	case F_SETSIG:
-		/* arg == 0 restores default behaviour. */
-		if (!valid_signal(argi)) {
-			break;
-		}
-		err = 0;
-		filp->f_owner.signum = argi;
+		err = f_owner_sig(filp, 0, true);
 		break;
 	case F_GETLEASE:
 		err = fcntl_getlease(filp);
@@ -844,14 +919,19 @@ static void send_sigurg_to_task(struct task_struct *p,
 		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, type);
 }
 
-int send_sigurg(struct fown_struct *fown)
+int send_sigurg(struct file *file)
 {
+	struct fown_struct *fown;
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
 	unsigned long flags;
 	int ret = 0;
 	
+	fown = smp_load_acquire(&file->f_owner);
+	if (fown == &nop_fown_struct)
+		return 0;
+
 	read_lock_irqsave(&fown->lock, flags);
 
 	type = fown->pid_type;
@@ -1027,13 +1107,16 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 		}
 		read_lock_irqsave(&fa->fa_lock, flags);
 		if (fa->fa_file) {
-			fown = &fa->fa_file->f_owner;
+			fown = smp_load_acquire(&fa->fa_file->f_owner);
+			if (fown == &nop_fown_struct)
+				goto next;
 			/* Don't send SIGURG to processes which have not set a
 			   queued signum: SIGURG has its own default signalling
 			   mechanism. */
 			if (!(sig == SIGURG && fown->signum == 0))
 				send_sigio(fown, fa->fa_fd, band);
 		}
+next:
 		read_unlock_irqrestore(&fa->fa_lock, flags);
 		fa = rcu_dereference(fa->fa_next);
 	}
diff --git a/fs/file_table.c b/fs/file_table.c
index ca7843dde56d..b8dd40454784 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -155,11 +155,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 		return error;
 	}
 
-	rwlock_init(&f->f_owner.lock);
 	spin_lock_init(&f->f_lock);
 	mutex_init(&f->f_pos_lock);
 	f->f_flags = flags;
 	f->f_mode = OPEN_FMODE(flags);
+	f->f_owner = &nop_fown_struct;
 	/* f->f_version: 0 */
 
 	/*
@@ -425,7 +425,10 @@ static void __fput(struct file *file)
 		cdev_put(inode->i_cdev);
 	}
 	fops_put(file->f_op);
-	put_pid(file->f_owner.pid);
+	if (file->f_owner != &nop_fown_struct) {
+		put_pid(file->f_owner->pid);
+		kfree(file->f_owner);
+	}
 	put_file_access(file);
 	dput(dentry);
 	if (unlikely(mode & FMODE_NEED_UNMOUNT))
diff --git a/fs/locks.c b/fs/locks.c
index 9afb16e0683f..32c5260f7a17 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -603,11 +603,16 @@ static int lease_init(struct file *filp, int type, struct file_lease *fl)
 static struct file_lease *lease_alloc(struct file *filp, int type)
 {
 	struct file_lease *fl = locks_alloc_lease();
+	struct fown_struct *f_owner;
 	int error = -ENOMEM;
 
 	if (fl == NULL)
 		return ERR_PTR(error);
 
+	f_owner = file_f_owner_allocate(filp);
+	if (IS_ERR(f_owner))
+		return ERR_CAST(f_owner);
+
 	error = lease_init(filp, type, fl);
 	if (error) {
 		locks_free_lease(fl);
@@ -1451,7 +1456,7 @@ int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
 		struct file *filp = fl->c.flc_file;
 
 		f_delown(filp);
-		filp->f_owner.signum = 0;
+		filp->f_owner->signum = 0;
 		fasync_helper(0, fl->c.flc_file, 0, &fl->fl_fasync);
 		if (fl->fl_fasync != NULL) {
 			printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index f3669403fabf..480b932cb1d0 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -110,7 +110,7 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 			prev = &dn->dn_next;
 			continue;
 		}
-		fown = &dn->dn_filp->f_owner;
+		fown = smp_load_acquire(&dn->dn_filp->f_owner);
 		send_sigio(fown, dn->dn_fd, POLL_MSG);
 		if (dn->dn_mask & FS_DN_MULTISHOT)
 			prev = &dn->dn_next;
@@ -316,6 +316,9 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		goto out_err;
 	}
 
+	if (IS_ERR(file_f_owner_allocate(filp)))
+		return -ENOMEM;
+
 	/* set up the new_fsn_mark and new_dn_mark */
 	new_fsn_mark = &new_dn_mark->fsn_mark;
 	fsnotify_init_mark(new_fsn_mark, dnotify_group);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..39eec530591d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -947,6 +947,7 @@ static inline unsigned imajor(const struct inode *inode)
 }
 
 struct fown_struct {
+	struct file *file;	/* backpointer for security modules */
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
 	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent to */
@@ -954,6 +955,10 @@ struct fown_struct {
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
+extern struct fown_struct nop_fown_struct;
+
+struct fown_struct *file_f_owner_allocate(struct file *file);
+
 /**
  * struct file_ra_state - Track a file's readahead state.
  * @start: Where the most recent readahead started.
@@ -1011,7 +1016,7 @@ struct file {
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
 	unsigned int		f_flags;
-	struct fown_struct	f_owner;
+	struct fown_struct	*f_owner;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
 	struct path		f_path;
@@ -1124,7 +1129,7 @@ extern void __f_setown(struct file *filp, struct pid *, enum pid_type, int force
 extern int f_setown(struct file *filp, int who, int force);
 extern void f_delown(struct file *filp);
 extern pid_t f_getown(struct file *filp);
-extern int send_sigurg(struct fown_struct *fown);
+extern int send_sigurg(struct file *file);
 
 /*
  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..bbe4c58470c3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3429,7 +3429,7 @@ static void sock_def_destruct(struct sock *sk)
 void sk_send_sigurg(struct sock *sk)
 {
 	if (sk->sk_socket && sk->sk_socket->file)
-		if (send_sigurg(&sk->sk_socket->file->f_owner))
+		if (send_sigurg(sk->sk_socket->file))
 			sk_wake_async(sk, SOCK_WAKE_URG, POLL_PRI);
 }
 EXPORT_SYMBOL(sk_send_sigurg);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..ed252cfba4e9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3940,7 +3940,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	struct file_security_struct *fsec;
 
 	/* struct fown_struct is never outside the context of a struct file */
-	file = container_of(fown, struct file, f_owner);
+	file = fown->file;
 
 	fsec = selinux_file(file);
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4164699cd4f6..cb33920ab67c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1950,7 +1950,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	/*
 	 * struct fown_struct is never outside the context of a struct file
 	 */
-	file = container_of(fown, struct file, f_owner);
+	file = fown->file;
 
 	/* we don't log here as rc can be overriden */
 	blob = smack_file(file);
-- 
2.43.0


