Return-Path: <linux-fsdevel+bounces-53591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47508AF0AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 07:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604661BC4FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF661EC006;
	Wed,  2 Jul 2025 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="B1g00Ij6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672160B8A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434483; cv=none; b=N6ZPbdqhK43YIFOmNCY/bIMJhAaj/Qm3QGzygnf68xoEIJM8F6D5KCDQMiwGhivuOAYRMQLuLox0zOBID6fMY+uHoS4V7H2dQ42b+tK/VhXFCaHuAFhPPxX/dc9asjl4TDo8ef0WmwXStOZPM4odlOvVjazzTM+UWMhNwP5uzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434483; c=relaxed/simple;
	bh=jCu3TdexZPpAY5iAlslZqYsx/US7sDgITguhvpibR4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G6OmGjAFe4Z9T4mhSEiV4xrwkq9WM3tMSN5fTfCfl22yI30SCBrV8jXgddmLUj9K0ov5JjhY6MK58dfH/WMoAUj5aPsjCh7LkSOKDNjl+QFo79A99/KG8tEDOZe/FdUMkjlZal1DRziU8ehKzSZJAJ+ESV2sBi2lLUWXm1DvTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=B1g00Ij6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9paDXq24RdiH/POl2uzW89wzJY+d0HubUzwA7BfAESI=; b=B1g00Ij6W30VCPhJ0wZSyCuvRi
	CBwkuIPhrW08ysZI3gema9anydshI1cwITf1wXZyrkIoe+U1MsyIwhs4pcs1jXvoaycJKxWo2lZfB
	bPQ17E+oIjLM3QzYUyUcP/6hE4cvV5IXXZQKcK4sDuMQziOy+CC+GxGbTbEeHRehCJJQwceZqkbyj
	NmV1VfTkQ70QzV7D+QRf5PDMo5KKBUbMSl8JJW0EUbnCidVqBZnf9G+VuWcXRun4dwSxLJ0dUl8T9
	1CTIwepfsm8phGxJ3vgxwGDpyRu0HRfFk7jAQjOYLOd9ZPrWXiqSGWuufwJJa1c9r0dD6Jso6KU9J
	oQHNAEHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWq7B-00000008QoR-1qa7;
	Wed, 02 Jul 2025 05:34:37 +0000
Date: Wed, 2 Jul 2025 06:34:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH][RFC] fold fs_struct->{lock,seq} into a seqlock
Message-ID: <20250702053437.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	The combination of spinlock_t lock and seqcount_spinlock_t seq
in struct fs_struct is an open-coded seqlock_t (see linux/seqlock_types.h).
	Combine and switch to equivalent seqlock_t primitives.  AFAICS,
that does end up with the same sequence of underlying operations in all
cases.
	While we are at it, get_fs_pwd() is open-coded verbatim in 
get_path_from_fd(); rather than applying conversion to it, replace with
the call of get_fs_pwd() there.  Not worth splitting the commit for that,
IMO...

	A bit of historical background - conversion of seqlock_t to
use of seqcount_spinlock_t happened several months after the same
had been done to struct fs_struct; switching fs_struct to seqlock_t
could've been done immediately after that, but it looks like nobody
had gotten around to that until now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/d_path.c b/fs/d_path.c
index 5f4da5c8d5db..bb365511066b 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -241,9 +241,9 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 	unsigned seq;
 
 	do {
-		seq = read_seqcount_begin(&fs->seq);
+		seq = read_seqbegin(&fs->seq);
 		*root = fs->root;
-	} while (read_seqcount_retry(&fs->seq, seq));
+	} while (read_seqretry(&fs->seq, seq));
 }
 
 /**
@@ -385,10 +385,10 @@ static void get_fs_root_and_pwd_rcu(struct fs_struct *fs, struct path *root,
 	unsigned seq;
 
 	do {
-		seq = read_seqcount_begin(&fs->seq);
+		seq = read_seqbegin(&fs->seq);
 		*root = fs->root;
 		*pwd = fs->pwd;
-	} while (read_seqcount_retry(&fs->seq, seq));
+	} while (read_seqretry(&fs->seq, seq));
 }
 
 /*
diff --git a/fs/exec.c b/fs/exec.c
index 1f5fdd2e096e..871078ddb220 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1510,7 +1510,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	 * state is protected by cred_guard_mutex we hold.
 	 */
 	n_fs = 1;
-	spin_lock(&p->fs->lock);
+	read_seqlock_excl(&p->fs->seq);
 	rcu_read_lock();
 	for_other_threads(p, t) {
 		if (t->fs == p->fs)
@@ -1523,7 +1523,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
 		p->fs->in_exec = 1;
-	spin_unlock(&p->fs->lock);
+	read_sequnlock_excl(&p->fs->seq);
 }
 
 static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 3e092ae6d142..e2f8e788d33a 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -171,11 +171,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 static int get_path_from_fd(int fd, struct path *root)
 {
 	if (fd == AT_FDCWD) {
-		struct fs_struct *fs = current->fs;
-		spin_lock(&fs->lock);
-		*root = fs->pwd;
-		path_get(root);
-		spin_unlock(&fs->lock);
+		get_fs_pwd(current->fs, root);
 	} else {
 		CLASS(fd, f)(fd);
 		if (fd_empty(f))
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64c2d0814ed6..28be762ac1c6 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -17,12 +17,10 @@ void set_fs_root(struct fs_struct *fs, const struct path *path)
 	struct path old_root;
 
 	path_get(path);
-	spin_lock(&fs->lock);
-	write_seqcount_begin(&fs->seq);
+	write_seqlock(&fs->seq);
 	old_root = fs->root;
 	fs->root = *path;
-	write_seqcount_end(&fs->seq);
-	spin_unlock(&fs->lock);
+	write_sequnlock(&fs->seq);
 	if (old_root.dentry)
 		path_put(&old_root);
 }
@@ -36,12 +34,10 @@ void set_fs_pwd(struct fs_struct *fs, const struct path *path)
 	struct path old_pwd;
 
 	path_get(path);
-	spin_lock(&fs->lock);
-	write_seqcount_begin(&fs->seq);
+	write_seqlock(&fs->seq);
 	old_pwd = fs->pwd;
 	fs->pwd = *path;
-	write_seqcount_end(&fs->seq);
-	spin_unlock(&fs->lock);
+	write_sequnlock(&fs->seq);
 
 	if (old_pwd.dentry)
 		path_put(&old_pwd);
@@ -67,16 +63,14 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 		fs = p->fs;
 		if (fs) {
 			int hits = 0;
-			spin_lock(&fs->lock);
-			write_seqcount_begin(&fs->seq);
+			write_seqlock(&fs->seq);
 			hits += replace_path(&fs->root, old_root, new_root);
 			hits += replace_path(&fs->pwd, old_root, new_root);
-			write_seqcount_end(&fs->seq);
 			while (hits--) {
 				count++;
 				path_get(new_root);
 			}
-			spin_unlock(&fs->lock);
+			write_sequnlock(&fs->seq);
 		}
 		task_unlock(p);
 	}
@@ -99,10 +93,10 @@ void exit_fs(struct task_struct *tsk)
 	if (fs) {
 		int kill;
 		task_lock(tsk);
-		spin_lock(&fs->lock);
+		read_seqlock_excl(&fs->seq);
 		tsk->fs = NULL;
 		kill = !--fs->users;
-		spin_unlock(&fs->lock);
+		read_sequnlock_excl(&fs->seq);
 		task_unlock(tsk);
 		if (kill)
 			free_fs_struct(fs);
@@ -116,16 +110,15 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 	if (fs) {
 		fs->users = 1;
 		fs->in_exec = 0;
-		spin_lock_init(&fs->lock);
-		seqcount_spinlock_init(&fs->seq, &fs->lock);
+		seqlock_init(&fs->seq);
 		fs->umask = old->umask;
 
-		spin_lock(&old->lock);
+		read_seqlock_excl(&old->seq);
 		fs->root = old->root;
 		path_get(&fs->root);
 		fs->pwd = old->pwd;
 		path_get(&fs->pwd);
-		spin_unlock(&old->lock);
+		read_sequnlock_excl(&old->seq);
 	}
 	return fs;
 }
@@ -140,10 +133,10 @@ int unshare_fs_struct(void)
 		return -ENOMEM;
 
 	task_lock(current);
-	spin_lock(&fs->lock);
+	read_seqlock_excl(&fs->seq);
 	kill = !--fs->users;
 	current->fs = new_fs;
-	spin_unlock(&fs->lock);
+	read_sequnlock_excl(&fs->seq);
 	task_unlock(current);
 
 	if (kill)
@@ -162,7 +155,6 @@ EXPORT_SYMBOL(current_umask);
 /* to be mentioned only in INIT_TASK */
 struct fs_struct init_fs = {
 	.users		= 1,
-	.lock		= __SPIN_LOCK_UNLOCKED(init_fs.lock),
-	.seq		= SEQCNT_SPINLOCK_ZERO(init_fs.seq, &init_fs.lock),
+	.seq		= __SEQLOCK_UNLOCKED(init_fs.seq),
 	.umask		= 0022,
 };
diff --git a/fs/namei.c b/fs/namei.c
index f761cafaeaad..cb33780f94dd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1012,10 +1012,10 @@ static int set_root(struct nameidata *nd)
 		unsigned seq;
 
 		do {
-			seq = read_seqcount_begin(&fs->seq);
+			seq = read_seqbegin(&fs->seq);
 			nd->root = fs->root;
 			nd->root_seq = __read_seqcount_begin(&nd->root.dentry->d_seq);
-		} while (read_seqcount_retry(&fs->seq, seq));
+		} while (read_seqretry(&fs->seq, seq));
 	} else {
 		get_fs_root(fs, &nd->root);
 		nd->state |= ND_ROOT_GRABBED;
@@ -2580,11 +2580,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			unsigned seq;
 
 			do {
-				seq = read_seqcount_begin(&fs->seq);
+				seq = read_seqbegin(&fs->seq);
 				nd->path = fs->pwd;
 				nd->inode = nd->path.dentry->d_inode;
 				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
-			} while (read_seqcount_retry(&fs->seq, seq));
+			} while (read_seqretry(&fs->seq, seq));
 		} else {
 			get_fs_pwd(current->fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 783b48dedb72..baf200ab5c77 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -8,8 +8,7 @@
 
 struct fs_struct {
 	int users;
-	spinlock_t lock;
-	seqcount_spinlock_t seq;
+	seqlock_t seq;
 	int umask;
 	int in_exec;
 	struct path root, pwd;
@@ -26,18 +25,18 @@ extern int unshare_fs_struct(void);
 
 static inline void get_fs_root(struct fs_struct *fs, struct path *root)
 {
-	spin_lock(&fs->lock);
+	read_seqlock_excl(&fs->seq);
 	*root = fs->root;
 	path_get(root);
-	spin_unlock(&fs->lock);
+	read_sequnlock_excl(&fs->seq);
 }
 
 static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 {
-	spin_lock(&fs->lock);
+	read_seqlock_excl(&fs->seq);
 	*pwd = fs->pwd;
 	path_get(pwd);
-	spin_unlock(&fs->lock);
+	read_sequnlock_excl(&fs->seq);
 }
 
 extern bool current_chrooted(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..6318a25a16ba 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1542,14 +1542,14 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	struct fs_struct *fs = current->fs;
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
-		spin_lock(&fs->lock);
+		read_seqlock_excl(&fs->seq);
 		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
-			spin_unlock(&fs->lock);
+			read_sequnlock_excl(&fs->seq);
 			return -EAGAIN;
 		}
 		fs->users++;
-		spin_unlock(&fs->lock);
+		read_sequnlock_excl(&fs->seq);
 		return 0;
 	}
 	tsk->fs = copy_fs_struct(fs);
@@ -3149,13 +3149,13 @@ int ksys_unshare(unsigned long unshare_flags)
 
 		if (new_fs) {
 			fs = current->fs;
-			spin_lock(&fs->lock);
+			read_seqlock_excl(&fs->seq);
 			current->fs = new_fs;
 			if (--fs->users)
 				new_fs = NULL;
 			else
 				new_fs = fs;
-			spin_unlock(&fs->lock);
+			read_sequnlock_excl(&fs->seq);
 		}
 
 		if (new_fd)

