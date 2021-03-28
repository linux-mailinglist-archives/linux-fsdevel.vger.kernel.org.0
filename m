Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46534BD19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhC1P4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1P4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:56:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093F0C061756;
        Sun, 28 Mar 2021 08:56:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x16so10384769wrn.4;
        Sun, 28 Mar 2021 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzaJrj6qm4ly2Blj6LwN/Q19V8tdViJ7JjkrFUtAAFk=;
        b=KFogYeqW56DETH5mHA+fWMQSgLtx0DV6pqTZpm3Q9txnv5IqxQU6zOiyePRYownqxC
         0Tq8IbiNT1u87iG6cO3vL4LAejZ69AsZCKFajopCnMKpJ1eA5m8Jii9EJzznGgo936RG
         XKkIFpojk+qUrEpDlei+9ga8zXiX/4uo9wbln+XDQT0euXwYNXyN5XCuH/dFMU8X9cGL
         tNrmh+S3eSBafGoc9X6SNMqf568p7D4PkHNsZaXI9L/0HHYDkMUQgjgnJW7uZsw4t4iw
         gi6NhFbUi9Qk8mzbwZiXGGYe3g4KPCGNktoLbDO3dzn1IobTuROZgwfuzsEA2vK0LGrM
         c5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzaJrj6qm4ly2Blj6LwN/Q19V8tdViJ7JjkrFUtAAFk=;
        b=TBONg8lYr7Stedurx+DNw9mjRlcNEWXENpL8dK9IKArMcxr7p6EFVT3HrJuwu4cSjV
         NTpApbEmjRpP1fi8mh9pDV1fLYwjOg6Ubkoe2BPE9wUSGUHUlzimiAKDZnESg7rw06rK
         oLEl6UnV+hLI9TqkwV/GcWQxJnkcxncTcOA2x7xWTSAUQrgd1lV1/tmBpDNZiin1UvL7
         ELHe3IwhGHYiA0Y6AjhDfQaTHEaxLBBDbtG/P4YNBJkinYu7QqTi3uY24OIOGHDDX9tO
         8RZPzUWZYiastUvTEL3zW8EURJtSj7ZsQBS34nK676cLldMOawFoddIBiXVVOMUoZw6m
         GwLA==
X-Gm-Message-State: AOAM532SjtcaLZkHSsTbanx9ppSg+urkHYUktE8F5L565ol/rYUhJwo2
        JGU4FyjM5Kz28dOmzi+YcogabA/+17A=
X-Google-Smtp-Source: ABdhPJzpUtNm25ny+sTqtt2G6ptkzX8TkfBOdl9JyDa9IdEo5ik23hdB8K5zCHvVVg+nF+F7lLDJZw==
X-Received: by 2002:adf:f587:: with SMTP id f7mr24490257wro.147.1616946987517;
        Sun, 28 Mar 2021 08:56:27 -0700 (PDT)
Received: from localhost.localdomain ([141.226.241.101])
        by smtp.gmail.com with ESMTPSA id k4sm31683289wrd.9.2021.03.28.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:56:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
Date:   Sun, 28 Mar 2021 18:56:24 +0300
Message-Id: <20210328155624.930558-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a high level hook fsnotify_path_create() which is called from
syscall context where mount context is available, so that FAN_CREATE
event can be added to a mount mark mask.

This high level hook is called in addition to fsnotify_create(),
fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
context is not available.

In the context where fsnotify_path_create() will be called, a dentry flag
flag is set on the new dentry the suppress the FS_CREATE event in the vfs
level hooks.

This functionality was requested by Christian Brauner to replace
recursive inotify watches for detecting when some path was created under
an idmapped mount without having to monitor FAN_CREATE events in the
entire filesystem.

In combination with more changes to allow unprivileged fanotify listener
to watch an idmapped mount, this functionality would be usable also by
nested container managers.

Link: https://lore.kernel.org/linux-fsdevel/20210318143140.jxycfn3fpqntq34z@wittgenstein/
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

After trying several different approaches, I finally realized that
making FAN_CREATE available for mount marks is not that hard and it could
be very useful IMO.

Adding support for other "inode events" with mount mark, such as
FAN_ATTRIB, FAN_DELETE, FAN_MOVE may also be possible, but adding support
for FAN_CREATE was really easy due to the fact that all call sites are
already surrounded by filename_creat()/done_path_create() calls.

Also, there is an inherent a-symetry between FAN_CREATE and other
events. All the rest of the events may be set when watching a postive
path, for example, to know when a path of a bind mount that was
"injected" to a container was moved or deleted, it is possible to start
watching that directory before injecting the bind mount.

It is not possible to do the same with a "negative" path to know when
a positive dentry was instantiated at that path.

This patch provides functionality that is independant of other changes,
but I also tested it along with other changes that demonstrate how it
would be utilized in userns setups [1][2].

As can be seen in dcache.h patch, this patch comes on top a revert patch
to reclaim an unused dentry flag. If you accept this proposal, I will
post the full series.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_userns
[2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns

 fs/namei.c               | 21 ++++++++++++++++++++-
 include/linux/dcache.h   |  2 +-
 include/linux/fanotify.h |  8 ++++----
 include/linux/fsnotify.h | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 216f16e74351..cf979e956938 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3288,7 +3288,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		inode_lock_shared(dir->d_inode);
 	dentry = lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
-		fsnotify_create(dir->d_inode, dentry);
+		fsnotify_path_create(&nd->path, dentry);
 	if (open_flag & O_CREAT)
 		inode_unlock(dir->d_inode);
 	else
@@ -3560,6 +3560,20 @@ struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 	return file;
 }
 
+static void d_set_path_create(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_PATH_CREATE;
+	spin_unlock(&dentry->d_lock);
+}
+
+static void d_clear_path_create(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags &= ~DCACHE_PATH_CREATE;
+	spin_unlock(&dentry->d_lock);
+}
+
 static struct dentry *filename_create(int dfd, struct filename *name,
 				struct path *path, unsigned int lookup_flags)
 {
@@ -3617,6 +3631,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 		goto fail;
 	}
 	putname(name);
+	/* Start "path create" context that ends in done_path_create() */
+	d_set_path_create(dentry);
 	return dentry;
 fail:
 	dput(dentry);
@@ -3641,6 +3657,9 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
+	if (d_inode(dentry))
+		fsnotify_path_create(path, dentry);
+	d_clear_path_create(dentry);
 	dput(dentry);
 	inode_unlock(path->dentry->d_inode);
 	mnt_drop_write(path->mnt);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4225caa8cf02..d153793d5b95 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -213,7 +213,7 @@ struct dentry_operations {
 #define DCACHE_SYMLINK_TYPE		0x00600000 /* Symlink (or fallthru to such) */
 
 #define DCACHE_MAY_FREE			0x00800000
-/* Was #define DCACHE_FALLTHRU			0x01000000 */
+#define DCACHE_PATH_CREATE		0x01000000 /* "path_create" context */
 #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
 
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index bad41bcb25df..f0c5a4a82b6e 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -65,10 +65,10 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 /*
  * Events that can be reported with data type FSNOTIFY_EVENT_PATH.
- * Note that FAN_MODIFY can also be reported with data type
+ * Note that FAN_MODIFY and FAN_CREATE can also be reported with data type
  * FSNOTIFY_EVENT_INODE.
  */
-#define FANOTIFY_PATH_EVENTS	(FAN_ACCESS | FAN_MODIFY | \
+#define FANOTIFY_PATH_EVENTS	(FAN_ACCESS | FAN_MODIFY | FAN_CREATE | \
 				 FAN_CLOSE | FAN_OPEN | FAN_OPEN_EXEC)
 
 /*
@@ -78,8 +78,8 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
 
 /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
-#define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
-				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
+#define FANOTIFY_INODE_EVENTS	(FAN_MOVE | FAN_DELETE | FAN_ATTRIB | \
+				 FAN_MOVE_SELF | FAN_DELETE_SELF)
 
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..9a3d9f7beeb2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -179,6 +179,30 @@ static inline void fsnotify_inoderemove(struct inode *inode)
 	__fsnotify_inode_delete(inode);
 }
 
+/*
+ * fsnotify_path_create - an inode was linked to namespace
+ *
+ * This higher level hook is called in addition to fsnotify_create(),
+ * fsnotify_mkdir() and fsnotify_link() vfs hooks when the mount context is
+ * available, so that FS_CREATE event can be added to a mount mark mask.
+ *
+ * In that case the, DCACHE_PATH_CREATE flag is set to suppress the FS_CREATE
+ * event in the lower level vfs hooks.
+ */
+static inline void fsnotify_path_create(struct path *path,
+					struct dentry *child)
+{
+	struct inode *dir = path->dentry->d_inode;
+	__u32 mask = FS_CREATE;
+
+	WARN_ON_ONCE(!inode_is_locked(dir));
+
+	if (S_ISDIR(d_inode(child)->i_mode))
+		mask |= FS_ISDIR;
+
+	fsnotify(mask, path, FSNOTIFY_EVENT_PATH, dir, &child->d_name, NULL, 0);
+}
+
 /*
  * fsnotify_create - 'name' was linked in
  */
@@ -186,6 +210,10 @@ static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
 {
 	audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 
+	/* fsnotify_path_create() will be called */
+	if (dentry->d_flags & DCACHE_PATH_CREATE)
+		return;
+
 	fsnotify_dirent(inode, dentry, FS_CREATE);
 }
 
@@ -200,6 +228,10 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
 	fsnotify_link_count(inode);
 	audit_inode_child(dir, new_dentry, AUDIT_TYPE_CHILD_CREATE);
 
+	/* fsnotify_path_create() will be called */
+	if (new_dentry->d_flags & DCACHE_PATH_CREATE)
+		return;
+
 	fsnotify_name(dir, FS_CREATE, inode, &new_dentry->d_name, 0);
 }
 
@@ -223,6 +255,10 @@ static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
 {
 	audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 
+	/* fsnotify_path_create() will be called */
+	if (dentry->d_flags & DCACHE_PATH_CREATE)
+		return;
+
 	fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
 }
 
-- 
2.30.0

