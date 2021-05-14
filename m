Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B939B380A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhENNfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhENNfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 09:35:45 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C3C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 06:34:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j19so22165271qtp.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMkew33FkJnYhkAa1nBae0xvy1LzEw1cuOpIFOwG5A8=;
        b=bclNU75em9YaR4PdHMxF8z7n1Xsg6V5JU3CTNWCiEJAX3vV0TvJn5jZxWsp6RluPXx
         WT9uoPbjRIitizLpenZb9yGuq27dhmGnsh2GQurFCZm9iOdiQcn5wDmB+TzujjP6KeKh
         mB/dxGnpdZIb+sg9CnpYXEdLvqbMYnpNO5/JNTXAsfQpcGm5LYoECua0GTlSozNImvBx
         zbsaBeKkG98zAHZnK2sX7mr+6hYUyRzWVuDtWLb9xkj7szgUR5Gxp6ZxaFkkabo/JYtm
         sKHR0A3xvWac6JO/hdgcIKKrSDW4No5/L4i38LxOAc2QSYzBHy4Z0t9X2xtu6KF38OHO
         4NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMkew33FkJnYhkAa1nBae0xvy1LzEw1cuOpIFOwG5A8=;
        b=niRxBx5GbQOKLKlrl/1jETbj4MnDlQDPsTSsfq8q9QtJ9eTSkf2zaDa1zd8zjvXbhH
         Qc1sIzueuOa0uedIqqvZmV9ReVdJZvXp0Gzu9QvWk3JAmkusOpr1K1x3PG3cMtlOd4Ld
         9+XpTAzhio6YTcts+ayTSgc0RxGTWQEzfRr+b3FcVFjmc56GkykEKfGK/HwV6MtosioS
         Q5bYWB0l9mntegVVGOML7KJHZwyVLwHRxT3T2pbcMIKA/PsKfVaWHZRM33rmF9ljvGx2
         XvLJS5sJCaKXwIbw0Nj1jUueGfBLJdbHMmliPV51oPdaAPlmx7zrLDucvGyHxYcRe6l1
         3Uzg==
X-Gm-Message-State: AOAM530pq9KP4v+p2KShh/8W/5WBK4nFYwRJSi9wKn7qW1z8iht4Dq7O
        TU2VYCzLx0Bkfr3mekFUBKlR7uX4zQ2+mw==
X-Google-Smtp-Source: ABdhPJxVqrE4qCvQNSgzTxi5mFTcf/Qc4LKSueYXmKOq0QcZW0NOMnOeteFgFZYnEMt6Ohvg92TaKw==
X-Received: by 2002:ac8:51d6:: with SMTP id d22mr3832986qtn.67.1620999272705;
        Fri, 14 May 2021 06:34:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z4sm4536572qtq.34.2021.05.14.06.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:34:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk,
        jack@suse.cz, amir73il@gmail.com, wangyugui@e16-tech.com
Subject: [PATCH v3] fsnotify: rework unlink/rmdir notify events
Date:   Fri, 14 May 2021 09:34:30 -0400
Message-Id: <568db8243e9faa0efb9ffb545ffac5a2f87e65ef.1620999079.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A regression was introduced by 116b9731ad76 ("fsnotify: add empty
fsnotify_{unlink,rmdir}() hooks"), which moved the fsnotify event for
unlink and rmdir to before the d_delete.  This was noticed by a tool we
have internally for validating a FUSE file system.  This tool watches
for IN_DELETE events and then stat's the file to make sure the file was
actually deleted.  This started failing on our newer kernels, and it was
traced to this patch.

The problem is there's a slight window where we emit the event and
we delete the dentry.  We can easily get the event before we've called
d_delete, and then stat the file before we're able to remove it.  This
is easily reproducible with the following reproducer

static int failed = 0;

static void *watch_inotify(void *arg)
{
	char name_buf[4096];
	char *buf = malloc(EVENT_BUF_LEN);
	char *directory = (char *)arg;
	int fd;
	int wd;

	if (!buf) {
		fprintf(stderr, "Failed to allocate inotify buf\n");
		return NULL;
	}

	fd = inotify_init();
	if (fd < 0) {
		fprintf(stderr, "Failed to init inotify %d %s\n",
				errno, strerror(errno));
		return NULL;
	}

	wd = inotify_add_watch(fd, directory, IN_DELETE);
	if (wd < 0) {
		fprintf(stderr, "inotify watch failed %d %s\n", errno,
				strerror(errno));
		close(fd);
		return NULL;
	}

	while (!failed) {
		ssize_t len = read(fd, buf, EVENT_BUF_LEN);
		size_t cur = 0;

		if (len < 0) {
			fprintf(stderr, "failed to read from inotify %d %s\n",
					errno, strerror(errno));
			break;
		}

		while (cur < len) {
			struct inotify_event *event =
				(struct inotify_event *)(buf + cur);
			struct stat st;
			int ret;

			cur += EVENT_SIZE + event->len;
			if (event->len == 0)
				continue;
			if (!(event->mask & IN_DELETE))
				continue;
			ret = snprintf(name_buf, 4096, "%s/%s", directory,
					event->name);
			if (ret < 0) {
				fprintf(stderr, "Couldn't snprintf %d (%s)\n",
						errno, strerror(errno));
				break;
			}
			if (ret >= 4096) {
				fprintf(stderr, "Name was truncated, pick a shorter dir name\n");
				break;
			}
			ret = stat(name_buf, &st);
			if (!ret) {
				fprintf(stderr, "Found file %s after a delete event\n",
						name_buf);
				failed = 1;
				break;
			}
		}
	}
	inotify_rm_watch( fd, wd );
	close(fd);
	return NULL;
}

int main(int argc, char **argv)
{
	char buf[4096];
	char *dir;
	pthread_t inotify_thread;
	int ret, i;

	if (argc != 2) {
		fprintf(stderr, "Must specify a directory to use\n");
		return 1;
	}

	dir = strdup(argv[1]);
	if (!dir) {
		fprintf(stderr, "Couldn't dup directory\n");
		return 1;
	}

	printf("Creating files...\n");
	for (i = 0; i < NR_FILES; i++) {
		ret = snprintf(buf, 4096, "%s/file_%d", dir, i);
		if (ret < 0) {
			fprintf(stderr, "Couldn't snprintf %d (%s)\n",
					errno, strerror(errno));
			goto out;
		}
		if (ret >= 4096) {
			fprintf(stderr, "Name was truncated, pick a shorter dir name\n");
			goto out;
		}
		ret = creat(buf, 0600);
		if (ret < 0) {
			fprintf(stderr, "Failed to create %s %d %s\n",
					buf, errno, strerror(errno));
			goto out;
		}
		close(ret);
	}

	printf("Starting inotify thread\n");
	ret = pthread_create(&inotify_thread, NULL, watch_inotify, dir);
	if (ret) {
		fprintf(stderr, "Couldn't create inotify thread %d (%s)\n",
				errno, strerror(errno));
		goto out;
	}

	printf("Sleeping for a second\n");
	sleep(1);
	printf("Starting delete\n");
	for (i = 0; i < NR_FILES; i++) {
		ret = snprintf(buf, 4096, "%s/file_%d", dir, i);
		if (ret < 0) {
			fprintf(stderr, "Couldn't snprintf %d (%s)\n",
					errno, strerror(errno));
			goto out_pthread;
		}
		if (ret >= 4096) {
			fprintf(stderr, "Name was truncated, pick a shorter dir name\n");
			goto out_pthread;
		}
		ret = unlink(buf);
		if (ret)
			goto out_pthread;
	}
out_pthread:
	pthread_cancel(inotify_thread);
	pthread_join(inotify_thread, NULL);
out:
	free(dir);
	return ret ? 1 : failed;
}

Fix this by introducing a d_delete_notify() and a fsnotify_delete()
helper.  d_delete_notify() will hold onto the dentry inode, do the
d_delete, and then call fsnotify_delete() so that we avoid the race.
Then fix up all callers of the fsnotify_unlink/fsnotify_rmdir helpers to
either use d_delete_notify(), or use the fsnotify_delete() helper with
the appropriate changes to protect the lifetime of the inode.  This
patch makes the test no longer fail.

Fixes: 116b9731ad76 ("fsnotify: add empty fsnotify_{unlink,rmdir}() hooks")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- Added an EXPORT_SYMBOL() for d_delete_notify, cause I'm an idiot.

v1->v2:
- Took Amir's suggestion and wrapped all the weird work into a d_delete_notify()
  helper and used that everywhere.
- Removed fsnotify_unlink/fsnotify_rmdir, replaced it with a fsnotify_delete()
  helper.

 fs/btrfs/ioctl.c         |  6 ++----
 fs/configfs/dir.c        |  6 ++----
 fs/dcache.c              | 19 +++++++++++++++++++
 fs/devpts/inode.c        |  7 ++++++-
 fs/libfs.c               | 10 +++++-----
 fs/namei.c               |  6 ++----
 fs/nfsd/nfsctl.c         |  3 +--
 include/linux/dcache.h   |  1 +
 include/linux/fsnotify.h | 25 +++++++------------------
 net/sunrpc/rpc_pipe.c    | 15 +++++++++++----
 10 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5dc2fd843ae3..d9854db80e28 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2990,10 +2990,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	btrfs_inode_lock(inode, 0);
 	err = btrfs_delete_subvolume(dir, dentry);
 	btrfs_inode_unlock(inode, 0);
-	if (!err) {
-		fsnotify_rmdir(dir, dentry);
-		d_delete(dentry);
-	}
+	if (!err)
+		d_delete_notify(dir, dentry);
 
 out_dput:
 	dput(dentry);
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ac5e0c0e9181..2f187766f2e2 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1805,8 +1805,7 @@ void configfs_unregister_group(struct config_group *group)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
-	fsnotify_rmdir(d_inode(parent), dentry);
-	d_delete(dentry);
+	d_delete_notify(d_inode(parent), dentry);
 	inode_unlock(d_inode(parent));
 
 	dput(dentry);
@@ -1947,10 +1946,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
-	fsnotify_rmdir(d_inode(root), dentry);
 	inode_unlock(d_inode(dentry));
 
-	d_delete(dentry);
+	d_delete_notify(d_inode(root), dentry);
 
 	inode_unlock(d_inode(root));
 
diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..c4977f6b08db 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2511,6 +2511,25 @@ void d_delete(struct dentry * dentry)
 }
 EXPORT_SYMBOL(d_delete);
 
+/**
+ * d_delete_notify - delete a dentry and emit the fsnotify event
+ * @dir: The directory containing the dentry
+ * @dentry: The dentry to delete
+ *
+ * This operates exactly as d_delete, but also emits the fsnotify event for the
+ * deletion as well.
+ */
+void d_delete_notify(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+
+	ihold(inode);
+	d_delete(dentry);
+	fsnotify_delete(dir, dentry, inode);
+	iput(inode);
+}
+EXPORT_SYMBOL(d_delete_notify);
+
 static void __d_rehash(struct dentry *entry)
 {
 	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d33c..714e6f9b74f5 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -617,12 +617,17 @@ void *devpts_get_priv(struct dentry *dentry)
  */
 void devpts_pty_kill(struct dentry *dentry)
 {
+	struct inode *dir = d_inode(dentry->d_parent);
+	struct inode *inode = d_inode(dentry);
+
 	WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
 
+	ihold(inode);
 	dentry->d_fsdata = NULL;
 	drop_nlink(dentry->d_inode);
-	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
 	d_drop(dentry);
+	fsnotify_delete(dir, dentry, inode);
+	iput(inode);
 	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 }
 
diff --git a/fs/libfs.c b/fs/libfs.c
index e9b29c6ffccb..189e12dc5d9b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -271,7 +271,7 @@ void simple_recursive_removal(struct dentry *dentry,
 	struct dentry *this = dget(dentry);
 	while (true) {
 		struct dentry *victim = NULL, *child;
-		struct inode *inode = this->d_inode;
+		struct inode *inode = this->d_inode, *victim_inode;
 
 		inode_lock(inode);
 		if (d_is_dir(this))
@@ -283,19 +283,19 @@ void simple_recursive_removal(struct dentry *dentry,
 			clear_nlink(inode);
 			inode_unlock(inode);
 			victim = this;
+			victim_inode = d_inode(victim);
+			ihold(victim_inode);
 			this = this->d_parent;
 			inode = this->d_inode;
 			inode_lock(inode);
 			if (simple_positive(victim)) {
 				d_invalidate(victim);	// avoid lost mounts
-				if (d_is_dir(victim))
-					fsnotify_rmdir(inode, victim);
-				else
-					fsnotify_unlink(inode, victim);
+				fsnotify_delete(inode, victim, victim_inode);
 				if (callback)
 					callback(victim);
 				dput(victim);		// unpin it
 			}
+			iput(victim_inode);
 			if (victim == dentry) {
 				inode->i_ctime = inode->i_mtime =
 					current_time(inode);
diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..40c3ea4e5eae 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3900,13 +3900,12 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
 	dentry->d_inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
-	fsnotify_rmdir(dir, dentry);
 
 out:
 	inode_unlock(dentry->d_inode);
 	dput(dentry);
 	if (!error)
-		d_delete(dentry);
+		d_delete_notify(dir, dentry);
 	return error;
 }
 EXPORT_SYMBOL(vfs_rmdir);
@@ -4026,7 +4025,6 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
-				fsnotify_unlink(dir, dentry);
 			}
 		}
 	}
@@ -4036,7 +4034,7 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
 		fsnotify_link_count(target);
-		d_delete(dentry);
+		d_delete_notify(dir, dentry);
 	}
 
 	return error;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c2c3d9077dc5..e95d122ef50d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1337,8 +1337,7 @@ void nfsd_client_rmdir(struct dentry *dentry)
 	dget(dentry);
 	ret = simple_rmdir(dir, dentry);
 	WARN_ON_ONCE(ret);
-	fsnotify_rmdir(dir, dentry);
-	d_delete(dentry);
+	d_delete_notify(dir, dentry);
 	dput(dentry);
 	inode_unlock(dir);
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9e23d33bb6f1..86df9b269f0e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -234,6 +234,7 @@ extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
+extern void d_delete_notify(struct inode *dir, struct dentry *dentry);
 extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
 
 /* allocate/de-allocate */
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..7bb06324c6b3 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -204,16 +204,18 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
 }
 
 /*
- * fsnotify_unlink - 'name' was unlinked
+ * fsnotify_delete - 'name' was unlinked
  *
  * Caller must make sure that dentry->d_name is stable.
  */
-static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
+static inline void fsnotify_delete(struct inode *dir, struct dentry *dentry,
+				   struct inode *inode)
 {
-	/* Expected to be called before d_delete() */
-	WARN_ON_ONCE(d_is_negative(dentry));
+	__u32 mask = FS_DELETE;
 
-	fsnotify_dirent(dir, dentry, FS_DELETE);
+	if (S_ISDIR(inode->i_mode))
+		mask |= FS_ISDIR;
+	fsnotify_name(dir, mask, inode, &dentry->d_name, 0);
 }
 
 /*
@@ -226,19 +228,6 @@ static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
 	fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
 }
 
-/*
- * fsnotify_rmdir - directory 'name' was removed
- *
- * Caller must make sure that dentry->d_name is stable.
- */
-static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
-{
-	/* Expected to be called before d_delete() */
-	WARN_ON_ONCE(d_is_negative(dentry));
-
-	fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
-}
-
 /*
  * fsnotify_access - file was read
  */
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 09c000d490a1..5dca896a60ab 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -596,26 +596,33 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
 
 static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
 {
+	struct inode *inode = d_inode(dentry);
 	int ret;
 
 	dget(dentry);
+	ihold(inode);
 	ret = simple_rmdir(dir, dentry);
-	if (!ret)
-		fsnotify_rmdir(dir, dentry);
 	d_delete(dentry);
+	if (!ret)
+		fsnotify_delete(dir, dentry, inode);
+	iput(inode);
 	dput(dentry);
 	return ret;
 }
 
 static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
 {
+	struct inode *inode;
 	int ret;
 
 	dget(dentry);
+	inode = d_inode(dentry);
+	ihold(inode);
 	ret = simple_unlink(dir, dentry);
-	if (!ret)
-		fsnotify_unlink(dir, dentry);
 	d_delete(dentry);
+	if (!ret)
+		fsnotify_delete(dir, dentry, inode);
+	iput(inode);
 	dput(dentry);
 	return ret;
 }
-- 
2.26.3

