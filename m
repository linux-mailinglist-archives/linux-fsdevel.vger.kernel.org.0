Return-Path: <linux-fsdevel+bounces-25770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4825C9504F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001A8283FC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F911993B8;
	Tue, 13 Aug 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQTXGhPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382C1607B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552267; cv=none; b=AANzcSrmfLy6OS7yp2r0LFxNSRygohnxIYOTaRcswY3K+i4rzKOXe4q/vgia0kKeeZTkx0DFmrn7r1fkohpZNsrtR0GvuNw6np6ISCGrSSd1m38YzjgGDO73Do8/g5KQ0pKf4bZTJw2B6jM90KcfafIjdauhoeWCqvZYn79lzlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552267; c=relaxed/simple;
	bh=u4Lw5CcpFNdicgdAXY5GYpOyQURvKagSJze30ohKBbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r+nwoPs9mTfiMYG6Dl6vsc4ibS1+SB8udwsW462l05HJ2pp9LYqRnVrYQHhrbHCsH9+7EtMF2FibD3nQP4J/Ig1f0ePxl+fP7uPi+2ML5DubT6LcsjBjIPCPcWpfQ11Fjgmf+lcfM1BDQtyEtQzGpQYQYWBv224vnqg+ev+ylu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQTXGhPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20231C4AF0E;
	Tue, 13 Aug 2024 12:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723552267;
	bh=u4Lw5CcpFNdicgdAXY5GYpOyQURvKagSJze30ohKBbo=;
	h=From:Date:Subject:To:Cc:From;
	b=rQTXGhPLlLCRus84Aq8Yx3XqEpqiA2IxwohL4Y5Bg4NXu3rlgGId9M1CwZW/xsoUj
	 NkIKHJLxJLZkJBma7ViTEGmVX5KCeguTQKlaoUP7PQjgbzmQi8guiZZfyybDmvh3oM
	 qzodCfN3mnXO0wZpdqshy8muy1IOUJjLF3cB5kALOwVChSC/f4SY7mXRKdbpNhJakp
	 75cuL7Vki4EzJRlnTTiW8uR/3fahsFgcoRxpZeSYzsmlRvbHuiLp9+iDj875FzrMLa
	 wT5sxuKIi48MWX/G+w9HE1VWI5VlYr0MaQKWTKV9nafJRSXb1U8stG+UDa45qxmkS8
	 +69RkWftCeo7g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 13 Aug 2024 14:30:42 +0200
Subject: [PATCH v2] file: reclaim 24 bytes from f_owner
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPFRu2YC/x3MTQrCMBBA4auUWTslSbX+XEVEkjixg5iUGWmF0
 rs3uvwW7y2gJEwKl2YBoYmVS65wuwbi4POTkB/V4Izbm5PtcC7ywnQvcyZBk0KIB5PO/dFCTUa
 hxN//7nqrDl4Jg/gch9/k7fVD0k59ay1KtLCuG3wYHjKBAAAA
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>, 
 Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=18628; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u4Lw5CcpFNdicgdAXY5GYpOyQURvKagSJze30ohKBbo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTtDuLwm1+l6NGxY0f+nl9MHp3LJfdJ8pTKakxc9OyB+
 uuqTaeudJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE/S3D//Tnjvm/bGzk/Vu7
 zO98KZMSP32CJa/mh7XqYrkt6jyhOxkZjkuXCh0I8HmY8Wxxj+aLoI5d6y5XGBZpLUiVl/ssf/g
 FGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We do embedd struct fown_struct into struct file letting it take up 32
bytes in total. We could tweak struct fown_struct to be more compact but
really it shouldn't even be embedded in struct file in the first place.

Instead, actual users of struct fown_struct should allocate the struct
on demand. This frees up 24 bytes in struct file.

That will have some potentially user-visible changes for the ownership
fcntl()s. Some of them can now fail due to allocation failures.
Practically, that probably will almost never happen as the allocations
are small and they only happen once per file.

The fown_struct is used during kill_fasync() which is used by e.g.,
pipes to generate a SIGIO signal. Sending of such signals is conditional
on userspace having set an owner for the file using one of the F_OWNER
fcntl()s. Such users will be unaffected if struct fown_struct is
allocated during the fcntl() call.

There are a few subsystems that call __f_setown() expecting
file->f_owner to be allocated:

(1) tun devices
    file->f_op->fasync::tun_chr_fasync()
    -> __f_setown()

    There are no callers of tun_chr_fasync().

(2) tty devices

    file->f_op->fasync::tty_fasync()
    -> __tty_fasync()
       -> __f_setown()

    tty_fasync() has no additional callers but __tty_fasync() has. Note
    that __tty_fasync() only calls __f_setown() if the @on argument is
    true. It's called from:

    file->f_op->release::tty_release()
    -> tty_release()
       -> __tty_fasync()
          -> __f_setown()

    tty_release() calls __tty_fasync() with @on false
    => __f_setown() is never called from tty_release().
       => All callers of tty_release() are safe as well.

    file->f_op->release::tty_open()
    -> tty_release()
       -> __tty_fasync()
          -> __f_setown()

    __tty_hangup() calls __tty_fasync() with @on false
    => __f_setown() is never called from tty_release().
       => All callers of __tty_hangup() are safe as well.

From the callchains it's obvious that (1) and (2) end up getting called
via file->f_op->fasync(). That can happen either through the F_SETFL
fcntl() with the FASYNC flag raised or via the FIOASYNC ioctl(). If
FASYNC is requested and the file isn't already FASYNC then
file->f_op->fasync() is called with @on true which ends up causing both
(1) and (2) to call __f_setown().

(1) and (2) are the only subsystems that call __f_setown() from the
file->f_op->fasync() handler. So both (1) and (2) have been updated to
allocate a struct fown_struct prior to calling fasync_helper() to
register with the fasync infrastructure. That's safe as they both call
fasync_helper() which also does allocations if @on is true.

The other interesting case are file leases:

(3) file leases
    lease_manager_ops->lm_setup::lease_setup()
    -> __f_setown()

    Which in turn is called from:

    generic_add_lease()
    -> lease_manager_ops->lm_setup::lease_setup()
       -> __f_setown()

So here again we can simply make generic_add_lease() allocate struct
fown_struct prior to the lease_manager_ops->lm_setup::lease_setup()
which happens under a spinlock.

With that the two remaining subsystems that call __f_setown() are:

(4) dnotify
(5) sockets

Both have their own custom ioctls to set struct fown_struct and both
have been converted to allocate a struct fown_struct on demand from
their respective ioctls.

Interactions with O_PATH are fine as well e.g., when opening a /dev/tty
as O_PATH then no file->f_op->open() happens thus no file->f_owner is
allocated. That's fine as no file operation will be set for those and
the device has never been opened. fcntl()s called on such things will
just allocate a ->f_owner on demand. Although I have zero idea why'd you
care about f_owner on an O_PATH fd.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
* There's no more cleanup macros used in this version as we can solve
  that all much simpler.
* Survives LTP which tests a bunch of that stuff.
* Survives perf's watermak signal tests which make use of FASYNC.

Goes into -next unless I hear objections.
---

---
 drivers/net/tun.c           |   6 ++
 drivers/tty/tty_io.c        |   6 ++
 fs/fcntl.c                  | 153 ++++++++++++++++++++++++++++++++++----------
 fs/file_table.c             |   6 +-
 fs/locks.c                  |   6 +-
 fs/notify/dnotify/dnotify.c |   6 +-
 include/linux/fs.h          |  11 +++-
 net/core/sock.c             |   2 +-
 security/selinux/hooks.c    |   2 +-
 security/smack/smack_lsm.c  |   2 +-
 10 files changed, 157 insertions(+), 43 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..6fe5e8f7017c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3451,6 +3451,12 @@ static int tun_chr_fasync(int fd, struct file *file, int on)
 	struct tun_file *tfile = file->private_data;
 	int ret;
 
+	if (on) {
+		ret = file_f_owner_allocate(file);
+		if (ret)
+			goto out;
+	}
+
 	if ((ret = fasync_helper(fd, file, on, &tfile->fasync)) < 0)
 		goto out;
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..7ae0c8934f42 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2225,6 +2225,12 @@ static int __tty_fasync(int fd, struct file *filp, int on)
 	if (tty_paranoia_check(tty, file_inode(filp), "tty_fasync"))
 		goto out;
 
+	if (on) {
+		retval = file_f_owner_allocate(filp);
+		if (retval)
+			goto out;
+	}
+
 	retval = fasync_helper(fd, filp, on, &tty->fasync);
 	if (retval <= 0)
 		goto out;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..b002730fdcd1 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -87,22 +87,53 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
 	return error;
 }
 
+/*
+ * Allocate an file->f_owner struct if it doesn't exist, handling racing
+ * allocations correctly.
+ */
+int file_f_owner_allocate(struct file *file)
+{
+	struct fown_struct *f_owner;
+
+	f_owner = file_f_owner(file);
+	if (f_owner)
+		return 0;
+
+	f_owner = kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
+	if (!f_owner)
+		return -ENOMEM;
+
+	rwlock_init(&f_owner->lock);
+	f_owner->file = file;
+	/* If someone else raced us, drop our allocation. */
+	if (unlikely(cmpxchg(&file->f_owner, NULL, f_owner)))
+		kfree(f_owner);
+	return 0;
+}
+EXPORT_SYMBOL(file_f_owner_allocate);
+
 static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
                      int force)
 {
-	write_lock_irq(&filp->f_owner.lock);
-	if (force || !filp->f_owner.pid) {
-		put_pid(filp->f_owner.pid);
-		filp->f_owner.pid = get_pid(pid);
-		filp->f_owner.pid_type = type;
+	struct fown_struct *f_owner;
+
+	f_owner = file_f_owner(filp);
+	if (WARN_ON_ONCE(!f_owner))
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
@@ -119,6 +150,8 @@ int f_setown(struct file *filp, int who, int force)
 	struct pid *pid = NULL;
 	int ret = 0;
 
+	might_sleep();
+
 	type = PIDTYPE_TGID;
 	if (who < 0) {
 		/* avoid overflow below */
@@ -129,6 +162,10 @@ int f_setown(struct file *filp, int who, int force)
 		who = -who;
 	}
 
+	ret = file_f_owner_allocate(filp);
+	if (ret)
+		return ret;
+
 	rcu_read_lock();
 	if (who) {
 		pid = find_vpid(who);
@@ -152,16 +189,21 @@ void f_delown(struct file *filp)
 pid_t f_getown(struct file *filp)
 {
 	pid_t pid = 0;
+	struct fown_struct *f_owner;
 
-	read_lock_irq(&filp->f_owner.lock);
+	f_owner = file_f_owner(filp);
+	if (!f_owner)
+		return pid;
+
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
 
@@ -194,6 +236,10 @@ static int f_setown_ex(struct file *filp, unsigned long arg)
 		return -EINVAL;
 	}
 
+	ret = file_f_owner_allocate(filp);
+	if (ret)
+		return ret;
+
 	rcu_read_lock();
 	pid = find_vpid(owner.pid);
 	if (owner.pid && !pid)
@@ -210,13 +256,20 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
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
+	f_owner = file_f_owner(filp);
+	if (f_owner) {
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
@@ -234,7 +287,8 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 		ret = -EINVAL;
 		break;
 	}
-	read_unlock_irq(&filp->f_owner.lock);
+	if (f_owner)
+		read_unlock_irq(&f_owner->lock);
 
 	if (!ret) {
 		ret = copy_to_user(owner_p, &owner, sizeof(owner));
@@ -248,14 +302,18 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
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
+	f_owner = file_f_owner(filp);
+	if (f_owner) {
+		read_lock_irq(&f_owner->lock);
+		src[0] = from_kuid(user_ns, f_owner->uid);
+		src[1] = from_kuid(user_ns, f_owner->euid);
+		read_unlock_irq(&f_owner->lock);
+	}
 
 	err  = put_user(src[0], &dst[0]);
 	err |= put_user(src[1], &dst[1]);
@@ -343,6 +401,30 @@ static long f_dupfd_query(int fd, struct file *filp)
 	return f.file == filp;
 }
 
+static int f_owner_sig(struct file *filp, int signum, bool setsig)
+{
+	int ret = 0;
+	struct fown_struct *f_owner;
+
+	might_sleep();
+
+	if (setsig) {
+		if (!valid_signal(signum))
+			return -EINVAL;
+
+		ret = file_f_owner_allocate(filp);
+		if (ret)
+			return ret;
+	}
+
+	f_owner = file_f_owner(filp);
+	if (setsig)
+		f_owner->signum = signum;
+	else if (f_owner)
+		ret = f_owner->signum;
+	return ret;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -421,15 +503,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
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
+		err = f_owner_sig(filp, argi, true);
 		break;
 	case F_GETLEASE:
 		err = fcntl_getlease(filp);
@@ -844,14 +921,19 @@ static void send_sigurg_to_task(struct task_struct *p,
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
 	
+	fown = file_f_owner(file);
+	if (fown)
+		return 0;
+
 	read_lock_irqsave(&fown->lock, flags);
 
 	type = fown->pid_type;
@@ -1027,13 +1109,16 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 		}
 		read_lock_irqsave(&fa->fa_lock, flags);
 		if (fa->fa_file) {
-			fown = &fa->fa_file->f_owner;
+			fown = file_f_owner(fa->fa_file);
+			if (!fown)
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
index ca7843dde56d..41ff037a8dc9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -155,7 +155,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 		return error;
 	}
 
-	rwlock_init(&f->f_owner.lock);
 	spin_lock_init(&f->f_lock);
 	mutex_init(&f->f_pos_lock);
 	f->f_flags = flags;
@@ -425,7 +424,10 @@ static void __fput(struct file *file)
 		cdev_put(inode->i_cdev);
 	}
 	fops_put(file->f_op);
-	put_pid(file->f_owner.pid);
+	if (file->f_owner) {
+		put_pid(file->f_owner->pid);
+		kfree(file->f_owner);
+	}
 	put_file_access(file);
 	dput(dentry);
 	if (unlikely(mode & FMODE_NEED_UNMOUNT))
diff --git a/fs/locks.c b/fs/locks.c
index 9afb16e0683f..c0d312481b97 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1451,7 +1451,7 @@ int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
 		struct file *filp = fl->c.flc_file;
 
 		f_delown(filp);
-		filp->f_owner.signum = 0;
+		file_f_owner(filp)->signum = 0;
 		fasync_helper(0, fl->c.flc_file, 0, &fl->fl_fasync);
 		if (fl->fl_fasync != NULL) {
 			printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
@@ -1783,6 +1783,10 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	lease = *flp;
 	trace_generic_add_lease(inode, lease);
 
+	error = file_f_owner_allocate(filp);
+	if (error)
+		return error;
+
 	/* Note that arg is never F_UNLCK here */
 	ctx = locks_get_lock_context(inode, arg);
 	if (!ctx)
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index f3669403fabf..46440fbb8662 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -110,7 +110,7 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 			prev = &dn->dn_next;
 			continue;
 		}
-		fown = &dn->dn_filp->f_owner;
+		fown = file_f_owner(dn->dn_filp);
 		send_sigio(fown, dn->dn_fd, POLL_MSG);
 		if (dn->dn_mask & FS_DN_MULTISHOT)
 			prev = &dn->dn_next;
@@ -316,6 +316,10 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		goto out_err;
 	}
 
+	error = file_f_owner_allocate(filp);
+	if (error)
+		goto out_err;
+
 	/* set up the new_fsn_mark and new_dn_mark */
 	new_fsn_mark = &new_dn_mark->fsn_mark;
 	fsnotify_init_mark(new_fsn_mark, dnotify_group);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..319c566a9e98 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -947,6 +947,7 @@ static inline unsigned imajor(const struct inode *inode)
 }
 
 struct fown_struct {
+	struct file *file;	/* backpointer for security modules */
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
 	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent to */
@@ -1011,7 +1012,7 @@ struct file {
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
 	unsigned int		f_flags;
-	struct fown_struct	f_owner;
+	struct fown_struct	*f_owner;
 	const struct cred	*f_cred;
 	struct file_ra_state	f_ra;
 	struct path		f_path;
@@ -1076,6 +1077,12 @@ struct file_lease;
 #define OFFT_OFFSET_MAX	type_max(off_t)
 #endif
 
+int file_f_owner_allocate(struct file *file);
+static inline struct fown_struct *file_f_owner(const struct file *file)
+{
+	return READ_ONCE(file->f_owner);
+}
+
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
 static inline struct inode *file_inode(const struct file *f)
@@ -1124,7 +1131,7 @@ extern void __f_setown(struct file *filp, struct pid *, enum pid_type, int force
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

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240813-work-f_owner-0fbbc50f9671


