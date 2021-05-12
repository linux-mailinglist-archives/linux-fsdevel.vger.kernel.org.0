Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10A337EE84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbhELVwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389269AbhELUvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 16:51:53 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4863EC061343
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 13:49:13 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id m13so3039167qtk.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEy0sVnAIxB4dopJYiKboVHqlPZeN5AVm2M2R2IhBEY=;
        b=QTAnY8rfpvb9Mzpj1YAzJf7MvoFe15LtvgPXDvgsTLd/+2+i2ewnqrTGrFzxL2p1gB
         w2S7lRNhwY5FydPlDdUvHufE2ooXUMzh1a3idAzXeasZ9oLC2Tm7McNkLK4MGc5llqis
         0tWmpaFviADcYqm97DQN2aHeu49DtjGq8SEe4ZjRLQ7olGY/gsAXXElx0CyejoLS+QAL
         iaQAQWF6w+U5KaLaIdRuwYGkF/nguJe1jG0xBnqH1NyTOBkuVrJt556C4DAyWlUW1lao
         OyQAJCJUYVstB42iBYsTLw1oWPW/4gPD1voMJ6ShZIoH5uTp94yB6glMzHLyHnXIl75P
         9aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEy0sVnAIxB4dopJYiKboVHqlPZeN5AVm2M2R2IhBEY=;
        b=Tp2lGo/+iWC0rLc41gOtXH/A6rPi7K0fPherYllPB/b6OJNgM7TVanWO5dMbd2ac+4
         1sIK4g85op6Qt64jWxjbbM96QB109lmGRk85W1SdVz6NldBwpvrtrn5dOJ8BFoSwuMCm
         Ha91qQob4+K7GT72fHWSLi7ixCOuTaDOG1AlcNVUi//62zzKEFaqDDooa7lhglbsx1YI
         tiNkRN/xC1yTCSPA7g/pGu1WoixLRTyAAJcZD3M4zsG0egXz6pemE2Hc44ZX2W2a3qAJ
         0oRUHjM5b0D2VlYlXyOPn04RulOclPpKEd0VXlbMBoPTEgOeUCOXKFwm4n8hEL+aMklN
         Sc6A==
X-Gm-Message-State: AOAM532PxNaLQba9e1dsD+lm/Qt+N5UdGTKT5cUOfgLFH18JepChsV59
        BjmdL2bZPi7cn2pz5WcvwWymR65dF4KvZA==
X-Google-Smtp-Source: ABdhPJznqfgM7ndQ1+Y3OSIHtBgoy8E5H9UN6Lgc2gewq0/yzzHAXu8Zf5bppMoCidgE4plb+7TNqA==
X-Received: by 2002:a05:622a:1350:: with SMTP id w16mr34566303qtk.331.1620852552265;
        Wed, 12 May 2021 13:49:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p193sm857488qke.45.2021.05.12.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:49:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk
Subject: [RFC][PATCH] fsnotify: move unlink/rmdir events to after d_delete
Date:   Wed, 12 May 2021 16:49:10 -0400
Message-Id: <df48bd23ecacdc0b95a315d176d2cc03a8ffe81c.1620852240.git.josef@toxicpanda.com>
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

The problem is there's a slight window where we emit the event and we
delete the dentry.  We can easily get the event before we've called
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

Fix this by adjusting the fsnotify hooks to take the inode that we
unlink'ed/rmdir'ed, and simply hold onto the inode so that we can still
access it after the d_delete.  This patch returns us to the previous
behavior and fixes the problem we were seeing.

Fixes: 116b9731ad76 ("fsnotify: add empty fsnotify_{unlink,rmdir}() hooks")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---

I'm not married to this solution at all, I'm not sure how important it is to
have the original inode.  We could also push this back into d_delete().

 fs/btrfs/ioctl.c         |  2 +-
 fs/configfs/dir.c        | 16 ++++++++++++----
 fs/devpts/inode.c        |  8 ++++++--
 fs/libfs.c               | 10 ++++++++--
 fs/namei.c               | 17 +++++++++++------
 include/linux/fsnotify.h | 16 ++++++----------
 6 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5dc2fd843ae3..08cc7407ec6e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2991,8 +2991,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	err = btrfs_delete_subvolume(dir, dentry);
 	btrfs_inode_unlock(inode, 0);
 	if (!err) {
-		fsnotify_rmdir(dir, dentry);
 		d_delete(dentry);
+		fsnotify_rmdir(dir, inode, dentry);
 	}
 
 out_dput:
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ac5e0c0e9181..3714791a3dd9 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1792,6 +1792,7 @@ void configfs_unregister_group(struct config_group *group)
 	struct dentry *parent = group->cg_item.ci_parent->ci_dentry;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
+	struct inode *inode;
 
 	down_write(&frag->frag_sem);
 	frag->frag_dead = true;
@@ -1803,10 +1804,13 @@ void configfs_unregister_group(struct config_group *group)
 	spin_unlock(&configfs_dirent_lock);
 
 	configfs_detach_group(&group->cg_item);
-	d_inode(dentry)->i_flags |= S_DEAD;
+	inode = d_inode(dentry);
+	ihold(inode);
+	inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
-	fsnotify_rmdir(d_inode(parent), dentry);
 	d_delete(dentry);
+	fsnotify_rmdir(d_inode(parent), inode, dentry);
+	iput(inode);
 	inode_unlock(d_inode(parent));
 
 	dput(dentry);
@@ -1924,6 +1928,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
+	struct inode *inode;
 
 	if (dentry->d_parent != root) {
 		pr_err("Tried to unregister non-subsystem!\n");
@@ -1945,12 +1950,15 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	spin_unlock(&configfs_dirent_lock);
 	mutex_unlock(&configfs_symlink_mutex);
 	configfs_detach_group(&group->cg_item);
-	d_inode(dentry)->i_flags |= S_DEAD;
+	inode = d_inode(dentry);
+	ihold(inode);
+	inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
-	fsnotify_rmdir(d_inode(root), dentry);
 	inode_unlock(d_inode(dentry));
 
 	d_delete(dentry);
+	fsnotify_rmdir(d_inode(root), inode, dentry);
+	iput(inode);
 
 	inode_unlock(d_inode(root));
 
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d33c..59a0420b04e3 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -617,12 +617,16 @@ void *devpts_get_priv(struct dentry *dentry)
  */
 void devpts_pty_kill(struct dentry *dentry)
 {
+	struct inode *inode;
 	WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
 
 	dentry->d_fsdata = NULL;
-	drop_nlink(dentry->d_inode);
-	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
+	inode = dentry->d_inode;
+	ihold(inode);
+	drop_nlink(inode);
 	d_drop(dentry);
+	fsnotify_unlink(d_inode(dentry->d_parent), inode, dentry);
+	iput(inode);
 	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 }
 
diff --git a/fs/libfs.c b/fs/libfs.c
index e9b29c6ffccb..2006d340a58d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -272,6 +272,7 @@ void simple_recursive_removal(struct dentry *dentry,
 	while (true) {
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
+		struct inode *victim_inode = NULL;
 
 		inode_lock(inode);
 		if (d_is_dir(this))
@@ -283,19 +284,24 @@ void simple_recursive_removal(struct dentry *dentry,
 			clear_nlink(inode);
 			inode_unlock(inode);
 			victim = this;
+			victim_inode = victim->d_inode;
+			ihold(victim_inode);
 			this = this->d_parent;
 			inode = this->d_inode;
 			inode_lock(inode);
 			if (simple_positive(victim)) {
 				d_invalidate(victim);	// avoid lost mounts
 				if (d_is_dir(victim))
-					fsnotify_rmdir(inode, victim);
+					fsnotify_rmdir(inode, victim_inode,
+						       victim);
 				else
-					fsnotify_unlink(inode, victim);
+					fsnotify_unlink(inode, victim_inode,
+							victim);
 				if (callback)
 					callback(victim);
 				dput(victim);		// unpin it
 			}
+			iput(victim_inode);
 			if (victim == dentry) {
 				inode->i_ctime = inode->i_mtime =
 					current_time(inode);
diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..23ce7aab43a5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3873,6 +3873,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry)
 {
+	struct inode *inode;
 	int error = may_delete(mnt_userns, dir, dentry, 1);
 
 	if (error)
@@ -3882,7 +3883,9 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
 		return -EPERM;
 
 	dget(dentry);
-	inode_lock(dentry->d_inode);
+	inode = dentry->d_inode;
+	ihold(inode);
+	inode_lock(inode);
 
 	error = -EBUSY;
 	if (is_local_mountpoint(dentry))
@@ -3897,16 +3900,18 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 
 	shrink_dcache_parent(dentry);
-	dentry->d_inode->i_flags |= S_DEAD;
+	inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
-	fsnotify_rmdir(dir, dentry);
 
 out:
-	inode_unlock(dentry->d_inode);
+	inode_unlock(inode);
 	dput(dentry);
-	if (!error)
+	if (!error) {
 		d_delete(dentry);
+		fsnotify_rmdir(dir, inode, dentry);
+	}
+	iput(inode);
 	return error;
 }
 EXPORT_SYMBOL(vfs_rmdir);
@@ -4026,7 +4031,6 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
-				fsnotify_unlink(dir, dentry);
 			}
 		}
 	}
@@ -4037,6 +4041,7 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
 		fsnotify_link_count(target);
 		d_delete(dentry);
+		fsnotify_unlink(dir, target, dentry);
 	}
 
 	return error;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..40303704cec1 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -208,12 +208,10 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
  *
  * Caller must make sure that dentry->d_name is stable.
  */
-static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
+static inline void fsnotify_unlink(struct inode *dir, struct inode *inode,
+				   struct dentry *dentry)
 {
-	/* Expected to be called before d_delete() */
-	WARN_ON_ONCE(d_is_negative(dentry));
-
-	fsnotify_dirent(dir, dentry, FS_DELETE);
+	fsnotify_name(dir, FS_DELETE, inode, &dentry->d_name, 0);
 }
 
 /*
@@ -231,12 +229,10 @@ static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
  *
  * Caller must make sure that dentry->d_name is stable.
  */
-static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
+static inline void fsnotify_rmdir(struct inode *dir, struct inode *inode,
+				  struct dentry *dentry)
 {
-	/* Expected to be called before d_delete() */
-	WARN_ON_ONCE(d_is_negative(dentry));
-
-	fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
+	fsnotify_name(dir, FS_DELETE | FS_ISDIR, inode, &dentry->d_name, 0);
 }
 
 /*
-- 
2.26.3

