Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F52AA4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfEZOel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45933 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfEZOel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so14296240wrq.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9d358PysRh93Ovn290SWir3DJbBZNRuE7uqJqn8lz2E=;
        b=V4a1SfQQdakhCawG2VcrqbByDGo0c02K7PHM3qgBOsizWXWITdxED30GpaYCyAIhqc
         npTL9fgpzrps3Kkzx6qRiFbFS/imxd8fGhWe8cO39xqKGJlMGIq9Nd+lz1/hj9BBtutq
         CqCQifxlR9d0NrugXMqhKctFnv+ATcH2vFvgn5linfygk5LtJJdgCLk34MGWZe9BGV7D
         4tfOLHxg+qzdNfHTLLnk/eSzGil/I2+1iun2JVltBj0zeBbIKfhoXzvTBvFaLhL5hdl/
         vzUZQ6Zr0LCPFYjvNIYyC1361YXbR50v/ZJNeGi5DixwrIw3mlndKncnB8lKrIgvTiXg
         k/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9d358PysRh93Ovn290SWir3DJbBZNRuE7uqJqn8lz2E=;
        b=rbJg4/ZWA3GlUitT5gdVLcBX34Um10Bl8Dzm0bXmjm4mpGjp4GzjsFG176VjIRjst1
         82czWIy0ZbuleQOqfTDD3t/WOgVaq/20O9eO4X9sSxj/EdcCCIyjWUWyXCorNcAcpfkM
         oiqJQIgQ6cl4kSKPWaypdpglL8tpBYrI93alOTt9jSBj4s0QO6/g0M6+bewrHWvM7CAM
         KI0SzZhwrXJwKyOfttdOD24bG6OqFcmu2V5xxp6vf0Rf99ndwkezy+6hc+86FVL7J2XY
         yVuQBo+h5y/jv7ZKquh/jCCqEToBULjA8cKcigW9JdxItKe/7JfMImgAVMDuO8yLsyy8
         eVGg==
X-Gm-Message-State: APjAAAVweEtpZ7VfRFGv6rYc1GIBOrO85/69hN/vjG5/PDEguKbYJid1
        X1rtUMQlcfVh+loWcOiyVUs=
X-Google-Smtp-Source: APXvYqzNnokfNZSi3ZVEHGbqli37swIH5YPILBUpEg51tgQl6hYc9foQHtkHPhlRi9jFTwEog9rFvw==
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr15593529wrx.63.1558881279454;
        Sun, 26 May 2019 07:34:39 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:38 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 10/10] fsnotify: get rid of fsnotify_nameremove()
Date:   Sun, 26 May 2019 17:34:11 +0300
Message-Id: <20190526143411.11244-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For all callers of fsnotify_{unlink,rmdir}(), we made sure that d_parent
and d_name are stable.  Therefore, fsnotify_{unlink,rmdir}() do not need
the safety measures in fsnotify_nameremove() to stabilize parent and name.
We can now simplify those hooks and get rid of fsnotify_nameremove().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 41 --------------------------------
 include/linux/fsnotify.h         |  6 ++---
 include/linux/fsnotify_backend.h |  4 ----
 3 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8c7cbac7183c..5433e37fb0c5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -107,47 +107,6 @@ void fsnotify_sb_delete(struct super_block *sb)
 	fsnotify_clear_marks_by_sb(sb);
 }
 
-/*
- * fsnotify_nameremove - a filename was removed from a directory
- *
- * This is mostly called under parent vfs inode lock so name and
- * dentry->d_parent should be stable. However there are some corner cases where
- * inode lock is not held. So to be on the safe side and be reselient to future
- * callers and out of tree users of d_delete(), we do not assume that d_parent
- * and d_name are stable and we use dget_parent() and
- * take_dentry_name_snapshot() to grab stable references.
- */
-void fsnotify_nameremove(struct dentry *dentry, int isdir)
-{
-	struct dentry *parent;
-	struct name_snapshot name;
-	__u32 mask = FS_DELETE;
-
-	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
-	if (IS_ROOT(dentry))
-		return;
-
-	if (isdir)
-		mask |= FS_ISDIR;
-
-	parent = dget_parent(dentry);
-	/* Avoid unneeded take_dentry_name_snapshot() */
-	if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
-	    !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
-		goto out_dput;
-
-	take_dentry_name_snapshot(&name, dentry);
-
-	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		 &name.name, 0);
-
-	release_dentry_name_snapshot(&name);
-
-out_dput:
-	dput(parent);
-}
-EXPORT_SYMBOL(fsnotify_nameremove);
-
 /*
  * Given an inode, first check if we care what happens to our children.  Inotify
  * and dnotify both tell their parents about events.  If we care about any event
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 0145073c2b42..a2d5d175d3c1 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -198,8 +198,7 @@ static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
 	/* Expected to be called before d_delete() */
 	WARN_ON_ONCE(d_is_negative(dentry));
 
-	/* TODO: call fsnotify_dirent() */
-	fsnotify_nameremove(dentry, 0);
+	fsnotify_dirent(dir, dentry, FS_DELETE);
 }
 
 /*
@@ -222,8 +221,7 @@ static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
 	/* Expected to be called before d_delete() */
 	WARN_ON_ONCE(d_is_negative(dentry));
 
-	/* TODO: call fsnotify_dirent() */
-	fsnotify_nameremove(dentry, 1);
+	fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a9f9dcc1e515..c28f6ed1f59b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -355,7 +355,6 @@ extern int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
-extern void fsnotify_nameremove(struct dentry *dentry, int isdir);
 extern u32 fsnotify_get_cookie(void);
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
@@ -525,9 +524,6 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
-static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
-{}
-
 static inline void fsnotify_update_flags(struct dentry *dentry)
 {}
 
-- 
2.17.1

