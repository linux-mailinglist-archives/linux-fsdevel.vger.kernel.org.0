Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C713ADD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgANPkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:40:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgANPkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:40:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so12581661wro.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NQcaL4c74CpFOK3F9bUh9+e+CJEtQ5Fse1Ac9uVSGko=;
        b=vBfdbP1p3yYaRgy1S7ZHDnYd3qJ7C3reQ5GUp2zV6KP6CHHGVVJwPuzs6/R1WyNOJF
         /ow5gkhLbvgxnGzmmm/4REFzSiDlOyf1yuotagJL2D2U26Lne4l0477HQ/8U5jUCfvkc
         VcVJ5J4UPnUU4zwst/ySYHdh002zDbvDd3sPKvQHqrLp3N/3xttE1YCjzkjDIDjscsen
         Y1wNJ8hEAa/qjbBv1peJmwSR9m6vtyg4O55Rlbh2JW+JrVNnnk9b8alVJ9gd/S8XnqqQ
         dESa6XkQsHAfEyTuKoNnpv4wJXMOxLBgA5gJc8Pwmtj8U6hNqRCB7ypIWS7LoN4dCrvm
         JVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NQcaL4c74CpFOK3F9bUh9+e+CJEtQ5Fse1Ac9uVSGko=;
        b=TuWaykfydDw+hViWxzeJiIdnaQRXJ1w5Gbw3y9HgEa0LGEXnA3i4uwnY7nwJpGBT2e
         qy/0ohqPuhbjJqKEUX8eyHPkYoOD7jT+/WsAxrGdFSudbOUedtgly+2dWEsvmRswNr5P
         VWBLKWOeMouvWZZJs2SObzNQBUjCWXrLFEPoNKszYq0MZqsxt0vswl91efzTZx+590Tj
         DR+502cO4E97DCjm40WWbnlo+w4RxYXoX1XyisAUgWBel0zQ5GlRCZ9c7pawmVuim32c
         WpwBHk4qo1rvgNVfl6bo6gl1KOZrbzpPazMfZw0LxcvmSTuhQF0QrjEFItWKOHaQp4R1
         QNDw==
X-Gm-Message-State: APjAAAXsFCzSqgOIoaMjEXuNSUy9eJgE7f1JFXYcEoDsEIWf5zLNRqqC
        vgq8FCcCW5ajt+R9sZv/inpUykXa
X-Google-Smtp-Source: APXvYqwepsOhcYvsYOcAXCKYx+7C510jijfAHv0eKh6gBdSLFcYzC5Hs5RXJtvtdoL7Iwf/hsGGQJw==
X-Received: by 2002:a5d:548e:: with SMTP id h14mr27630626wrv.380.1579016444209;
        Tue, 14 Jan 2020 07:40:44 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id l6sm19947585wmf.21.2020.01.14.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:40:43 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: dcache: abstract take_name_snapshot() interface
Date:   Tue, 14 Jan 2020 17:40:34 +0200
Message-Id: <20200114154034.30999-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Generalize the take_name_snapshot()/release_name_snapshot() interface
so it is possible to snapshot either a dentry d_name or its snapshot.

The order of fields d_name and d_inode in struct dentry is swapped
so d_name is adjacent to d_iname.  This does not change struct size
nor cache lines alignment.

Currently, we snapshot the old name in vfs_rename() and we snapshot the
snapshot the dentry name in __fsnotify_parent() and then we pass qstr
to inotify which allocated a variable length event struct and copied the
name.

This new interface allows us to snapshot the name directly into an
fanotify event struct instead of allocating a variable length struct
and copying the name to it.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This vfs patch is a pre-requisite to fanotify name event patches [1].

I wanted to get it out in advance for wider audience review and in the
hope that you or Al could pick up this patch for v5.6-rc1 in preparation
for the fanotify patches.

Al, any objections?

Thanks,
Amir.


[1] https://github.com/amir73il/linux/commits/fanotify_name

 fs/dcache.c            | 50 ++++++++++++++++++++++++++++++++----------
 fs/debugfs/inode.c     |  4 ++--
 fs/namei.c             |  2 +-
 fs/notify/fsnotify.c   |  2 +-
 fs/overlayfs/export.c  |  2 +-
 include/linux/dcache.h | 29 ++++++++++++++++++------
 6 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b280e07e162b..a2b9ff77db18 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -259,9 +259,15 @@ struct external_name {
 	unsigned char name[];
 };
 
+static inline struct external_name *external_name_snap(
+					const struct name_snapshot *name)
+{
+	return container_of(name->name.name, struct external_name, name[0]);
+}
+
 static inline struct external_name *external_name(struct dentry *dentry)
 {
-	return container_of(dentry->d_name.name, struct external_name, name[0]);
+	return external_name_snap(&dentry->d_name_snap);
 }
 
 static void __d_free(struct rcu_head *head)
@@ -278,27 +284,49 @@ static void __d_free_external(struct rcu_head *head)
 	kmem_cache_free(dentry_cache, dentry);
 }
 
+static inline int name_snap_is_external(const struct name_snapshot *name)
+{
+	return name->name.name != name->inline_name;
+}
+
 static inline int dname_external(const struct dentry *dentry)
 {
-	return dentry->d_name.name != dentry->d_iname;
+	return name_snap_is_external(&dentry->d_name_snap);
 }
 
-void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
+/*
+ * Snapshot either a dentry d_name or it's snapshot.  When snapshotting a dentry
+ * d_name, caller is responsible that d_name is stable.
+ */
+void take_name_snapshot(struct name_snapshot *name,
+			const struct name_snapshot *orig)
 {
-	spin_lock(&dentry->d_lock);
-	name->name = dentry->d_name;
-	if (unlikely(dname_external(dentry))) {
-		atomic_inc(&external_name(dentry)->u.count);
+	name->name = orig->name;
+	if (unlikely(name_snap_is_external(orig))) {
+		atomic_inc(&external_name_snap(orig)->u.count);
 	} else {
-		memcpy(name->inline_name, dentry->d_iname,
-		       dentry->d_name.len + 1);
+		memcpy(name->inline_name, orig->inline_name,
+		       orig->name.len + 1);
 		name->name.name = name->inline_name;
 	}
+}
+EXPORT_SYMBOL(take_name_snapshot);
+
+void take_dentry_name_snapshot(struct name_snapshot *name,
+			       struct dentry *dentry)
+{
+	BUILD_BUG_ON(offsetof(struct dentry, d_iname) !=
+		     offsetof(struct dentry, d_name_snap.inline_name));
+	BUILD_BUG_ON(sizeof_field(struct dentry, d_iname) !=
+		     sizeof_field(struct dentry, d_name_snap.inline_name));
+
+	spin_lock(&dentry->d_lock);
+	take_name_snapshot(name, &dentry->d_name_snap);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(take_dentry_name_snapshot);
 
-void release_dentry_name_snapshot(struct name_snapshot *name)
+void release_name_snapshot(struct name_snapshot *name)
 {
 	if (unlikely(name->name.name != name->inline_name)) {
 		struct external_name *p;
@@ -307,7 +335,7 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 			kfree_rcu(p, u.head);
 	}
 }
-EXPORT_SYMBOL(release_dentry_name_snapshot);
+EXPORT_SYMBOL(release_name_snapshot);
 
 static inline void __d_set_inode_and_type(struct dentry *dentry,
 					  struct inode *inode,
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f4d8df5e4714..149128da7c4c 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -859,14 +859,14 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 	error = simple_rename(d_inode(old_dir), old_dentry, d_inode(new_dir),
 			      dentry, 0);
 	if (error) {
-		release_dentry_name_snapshot(&old_name);
+		release_name_snapshot(&old_name);
 		goto exit;
 	}
 	d_move(old_dentry, dentry);
 	fsnotify_move(d_inode(old_dir), d_inode(new_dir), &old_name.name,
 		d_is_dir(old_dentry),
 		NULL, old_dentry);
-	release_dentry_name_snapshot(&old_name);
+	release_name_snapshot(&old_name);
 	unlock_rename(new_dir, old_dir);
 	dput(dentry);
 	return old_dentry;
diff --git a/fs/namei.c b/fs/namei.c
index d6c91d1e88cb..de9cb22a95b0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4511,7 +4511,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 				      new_is_dir, NULL, new_dentry);
 		}
 	}
-	release_dentry_name_snapshot(&old_name);
+	release_name_snapshot(&old_name);
 
 	return error;
 }
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index a8b281569bbf..b7665b0e7edd 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -173,7 +173,7 @@ int fsnotify_parent(__u32 mask, const void *data, int data_type)
 
 		take_dentry_name_snapshot(&name, dentry);
 		ret = fsnotify(p_inode, mask, data, data_type, &name.name, 0);
-		release_dentry_name_snapshot(&name);
+		release_name_snapshot(&name);
 	}
 
 	dput(parent);
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 70e55588aedc..fd2856075373 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -400,7 +400,7 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	}
 
 out:
-	release_dentry_name_snapshot(&name);
+	release_name_snapshot(&name);
 	dput(parent);
 	inode_unlock(dir);
 	return this;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1488cc84fd9..8aebca3830a5 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -86,16 +86,34 @@ extern struct dentry_stat_t dentry_stat;
 
 #define d_lock	d_lockref.lock
 
+struct name_snapshot {
+	struct qstr name;
+	unsigned char inline_name[DNAME_INLINE_LEN];
+};
+
 struct dentry {
 	/* RCU lookup touched fields */
 	unsigned int d_flags;		/* protected by d_lock */
 	seqcount_t d_seq;		/* per dentry seqlock */
 	struct hlist_bl_node d_hash;	/* lookup hash list */
 	struct dentry *d_parent;	/* parent directory */
-	struct qstr d_name;
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
-	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+	union {
+		struct name_snapshot d_name_snap;
+		/*
+		 * Unfolded replica of the above struct instead of:
+		 *
+		 * #define d_name d_name_snap.name
+		 *
+		 * which isn't popssible anyway because d_name keyword is also
+		 * in use by coda and msdos structs in uapi.
+		 */
+		struct {
+			struct qstr d_name;
+			unsigned char d_iname[DNAME_INLINE_LEN];
+		};
+	};
 
 	/* Ref lookup also touches following */
 	struct lockref d_lockref;	/* per-dentry lock and refcount */
@@ -596,11 +614,8 @@ static inline struct inode *d_real_inode(const struct dentry *dentry)
 	return d_backing_inode(d_real((struct dentry *) dentry, NULL));
 }
 
-struct name_snapshot {
-	struct qstr name;
-	unsigned char inline_name[DNAME_INLINE_LEN];
-};
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
-void release_dentry_name_snapshot(struct name_snapshot *);
+void take_name_snapshot(struct name_snapshot *, const struct name_snapshot *);
+void release_name_snapshot(struct name_snapshot *);
 
 #endif	/* __LINUX_DCACHE_H */
-- 
2.17.1

