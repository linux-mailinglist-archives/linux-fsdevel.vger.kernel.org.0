Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFC14237
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfEEUHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 16:07:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39456 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEEUHg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 16:07:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so12678715wmk.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2019 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QqxibxNMmfPfD5PyZl52O7idiSeu/yeuNm0c0sVJouM=;
        b=l8OuHSr18TVE/h8E65gCenp+1TnterovA+qrnsaQT8/bRj69kG+liWSIZwKNZyHZjt
         S/vSikBAmii0hhd6E8KEcZapvqZ8OcNMaBZ1RHs/SflG9kGWbXBpuSBjLG5kL6fnqog2
         hsasJTrZmbPkRt2RwCi8Pyagku1LhN84EaGegUoJQrVa1EmHgpSYVBvi0+ksx8Wy9wdW
         LZVgEEwR+ow+KosswR6s8Ok4YUv9Nijcutw89L9akhB5oQb9RCKiDnTfPZfo9NCZaU09
         Ker2bbAvdt6uDdoHTxtXV0lfeXDtT3LfBPF+KdL4ph63oLaI2dZ1jDraqMX0DIcxm2X/
         1AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QqxibxNMmfPfD5PyZl52O7idiSeu/yeuNm0c0sVJouM=;
        b=Vurc7SHDb17LNlJ3CdW4aAPaK/9Nw/nnREkbHuIPcXjFf/z380wa31W2YkfF18X2V+
         VIqxRlYYzzDlUcTlPn83zczaP3X3Bo2NK9m5dCmPzxq1OYly12IGnO0xCeBJFbgLZ+GE
         KlT6WdmXvjzfyuPYFP+DJNjUpHvvniRrZ3dZCkT6NAl6t7eq3O1a+I0tg7LB6fkYCCWZ
         WIdUNkotUTncn5WCnhtM3g4HP0K8RLJ9DN8nGUcJBmHPOI2cyQxQjDLVKR9PMttZxJGG
         fZD2BCcHBfLLCaPF4eJxvVWkRxf4e/YcrVmVwAvBoErts+za5DL+a8SKJfru5GS5yToU
         F8pg==
X-Gm-Message-State: APjAAAURKip2AGMgnUiFnenuwojvfr7Bzd8rDl0egLx6YPhpi+dVOjVh
        bFwfDkVfij3cSGxtP5oGUKU=
X-Google-Smtp-Source: APXvYqxOtb9tClI3BMY9EiOHlbxbn/rUhYSYhpuMcigusk+ypcpbilXLx1dJOXbHqDCud385G3UtyA==
X-Received: by 2002:a1c:1f92:: with SMTP id f140mr11566460wmf.132.1557086854408;
        Sun, 05 May 2019 13:07:34 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n17sm6833711wrw.77.2019.05.05.13.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 13:07:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKP <lkp@01.org>
Subject: [PATCH v2] fsnotify: fix unlink performance regression
Date:   Sun,  5 May 2019 23:07:28 +0300
Message-Id: <20190505200728.5892-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__fsnotify_parent() has an optimization in place to avoid unneeded
take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
not to call __fsnotify_parent(), we left out the optimization.
Kernel test robot reported a 5% performance regression in concurrent
unlink() workload.

Modify __fsnotify_parent() so that it can be called also to report
directory modififcation events and use it from fsnotify_nameremove().

Reported-by: kernel test robot <rong.a.chen@intel.com>
Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

A nicer approach reusing __fsnotify_parent() instead of copying code
from it.

This version does not apply cleanly to Al's for-next branch (there are
some fsnotify changes in work.dcache). The conflict is trivial and
resolved on my fsnotify branch [1].

Thanks,
Amir.

Changes since v1:
- Fix build without CONFIG_FSNOTIFY
- Use __fsnotify_parent() for reporting FS_DELETE

[1] https://github.com/amir73il/linux/commits/fsnotify

 fs/notify/fsnotify.c     | 22 +++++++++++-----------
 include/linux/fsnotify.h | 15 +++------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index df06f3da166c..265b726d6e8d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -151,31 +151,31 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
-/* Notify this dentry's parent about a child's events. */
+/*
+ * Notify this dentry's parent about an event and make sure that name is stable.
+ * Events "on child" are only reported if parent is watching.
+ * Directory modification events are also reported if super block is watching.
+ */
 int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
 {
 	struct dentry *parent;
 	struct inode *p_inode;
 	int ret = 0;
+	bool on_child = (mask & FS_EVENT_ON_CHILD);
+	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 
-	if (!dentry)
-		dentry = path->dentry;
-
-	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
+	if (on_child && !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
 		return 0;
 
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
 
-	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
+	if (on_child && unlikely(!fsnotify_inode_watches_children(p_inode))) {
 		__fsnotify_update_child_dentry_flags(p_inode);
-	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
+	} else if ((p_inode->i_fsnotify_mask & test_mask) ||
+		   (!on_child && (dentry->d_sb->s_fsnotify_mask & test_mask))) {
 		struct name_snapshot name;
 
-		/* we are notifying a parent so come up with the new mask which
-		 * specifies these are events which came from a child. */
-		mask |= FS_EVENT_ON_CHILD;
-
 		take_dentry_name_snapshot(&name, dentry);
 		if (path)
 			ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 09587e2860b5..8641bf9a1eda 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -37,7 +37,7 @@ static inline int fsnotify_parent(const struct path *path,
 	if (!dentry)
 		dentry = path->dentry;
 
-	return __fsnotify_parent(path, dentry, mask);
+	return __fsnotify_parent(path, dentry, mask | FS_EVENT_ON_CHILD);
 }
 
 /*
@@ -158,13 +158,11 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
  * dentry->d_parent should be stable. However there are some corner cases where
  * inode lock is not held. So to be on the safe side and be reselient to future
  * callers and out of tree users of d_delete(), we do not assume that d_parent
- * and d_name are stable and we use dget_parent() and
+ * and d_name are stable and we use __fsnotify_parent() to
  * take_dentry_name_snapshot() to grab stable references.
  */
 static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
 {
-	struct dentry *parent;
-	struct name_snapshot name;
 	__u32 mask = FS_DELETE;
 
 	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
@@ -174,14 +172,7 @@ static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
 	if (isdir)
 		mask |= FS_ISDIR;
 
-	parent = dget_parent(dentry);
-	take_dentry_name_snapshot(&name, dentry);
-
-	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		 name.name, 0);
-
-	release_dentry_name_snapshot(&name);
-	dput(parent);
+	__fsnotify_parent(NULL, dentry, mask);
 }
 
 /*
-- 
2.17.1

