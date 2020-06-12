Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1984A1F7607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFLJeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLJeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16FBC03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so9418838ejd.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihtLpHYyi0rKzy2ED0I8iYxTkDs0p8KPUsaKJBF33CM=;
        b=Hh2U6RlRdvTw6MEARYRnPUPe+3DEY7vtm+DvSv2i/UOEnvoprX7RvXNVOX/jk9C0s0
         zCBA8XfaOUXcQfqhZ85RpWmPYh3KeKng+1Dg7Kt5CIKmL51z7KSg90m2DDFJnnVbCRLY
         aPD71fkBtAqFPvpDqoFA6ka2ZitgZsBfpUpein8p2ZbWlXS1Qgw/8EpTfCqSWhbaKy96
         ijYUdYMeMuMeRwXGksWCXd8klcV49n6NWKRgCG9k9vvSMcScX0qS17ndLSpauIrGCDe1
         CJ4LSqyOa9+nr75sxG9Oq5vv2ZtAHSSsL4kRlh2a3oJwX0BukjRgq7esOECGWjRgT11D
         Jhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihtLpHYyi0rKzy2ED0I8iYxTkDs0p8KPUsaKJBF33CM=;
        b=MOeysUqxKvD624YfXAL9CgIdg+HIGLRa2scXLh9nH6c9I22jHqZmZFRqIOHg63xLC2
         bgS33xw6zR6rh6QUiJjq+THUgQ14pKyFtC0u4LrdwZWxj8hv5WV9kVGzftXltAf4bFCF
         0yBjM9fDnl3b1LKRymA8TBySS2KbfziChMFEGhRRDyecXKdWqtSKnQLv/zhQBlXAWAmV
         JyHN7fKPsHTVj14jWUrugB62eXq2tbukdFuUd/LJh9vO8nymtWxPHb5bF3PooKKE5BDq
         oVjk3DcGjW5hs7aOC0YOnXS5oFaAPYmIatSj+Stk2mMVF+vtX5D0GAf2J1ciwh7DA4M0
         IIXg==
X-Gm-Message-State: AOAM532VOLh5Iu9B1d7VqkVcLGCkMqfBeJVNBrdYHOBAmmWlDhJQYpeg
        buECVcQEGsqcJljO7r00K1rkjU4O
X-Google-Smtp-Source: ABdhPJxipWlYLTQjmRmeXh7gwQyenee1YZR/o2xU3XcBlK3NThJ8dgZzSMyY3a+Te6zziVGFqwGFBw==
X-Received: by 2002:a17:906:2615:: with SMTP id h21mr12049941ejc.84.1591954444546;
        Fri, 12 Jun 2020 02:34:04 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/20] fsnotify: fold fsnotify() call into fsnotify_parent()
Date:   Fri, 12 Jun 2020 12:33:25 +0300
Message-Id: <20200612093343.5669-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All (two) callers of fsnotify_parent() also call fsnotify() to notify
the child inode. Move the second fsnotify() call into fsnotify_parent().

This will allow more flexibility in making decisions about which of the
two event falvors should be sent.

Using 'goto notify_child' in the inline helper seems a bit strange, but
it mimics the code in __fsnotify_parent() for clarity and the goto
pattern will become less strage after following patches are applied.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c     | 27 ++++++++++++++++++---------
 include/linux/fsnotify.h | 34 ++++++++++++++--------------------
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index d59a58d10b84..30628a72ca01 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -142,16 +142,20 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
-/* Notify this dentry's parent about a child's events. */
+/*
+ * Notify this dentry's parent about a child's events with child name info
+ * if parent is watching.
+ * Notify also the child without name info if child inode is watching.
+ */
 int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
-		    int data_type)
+		      int data_type)
 {
 	struct dentry *parent;
 	struct inode *p_inode;
 	int ret = 0;
 
 	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
-		return 0;
+		goto notify_child;
 
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
@@ -161,18 +165,23 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
 		struct name_snapshot name;
 
-		/* we are notifying a parent so come up with the new mask which
-		 * specifies these are events which came from a child. */
-		mask |= FS_EVENT_ON_CHILD;
-
+		/*
+		 * We are notifying a parent, so set a flag in mask to inform
+		 * backend that event has information about a child entry.
+		 */
 		take_dentry_name_snapshot(&name, dentry);
-		ret = fsnotify(p_inode, mask, data, data_type, &name.name, 0);
+		ret = fsnotify(p_inode, mask | FS_EVENT_ON_CHILD, data,
+			       data_type, &name.name, 0);
 		release_dentry_name_snapshot(&name);
 	}
 
 	dput(parent);
 
-	return ret;
+	if (ret)
+		return ret;
+
+notify_child:
+	return fsnotify(d_inode(dentry), mask, data, data_type, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(__fsnotify_parent);
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 508f6bb0b06b..e73ae6117a61 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -48,44 +48,37 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 				  const void *data, int data_type)
 {
+	struct inode *inode = d_inode(dentry);
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= FS_ISDIR;
+
 	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
-		return 0;
+		goto notify_child;
 
 	return __fsnotify_parent(dentry, mask, data, data_type);
+
+notify_child:
+	return fsnotify(inode, mask, data, data_type, NULL, 0);
 }
 
 /*
- * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
- * an event is on a file/dentry.
+ * Simple wrappers to consolidate calls to fsnotify_parent() when an event
+ * is on a file/dentry.
  */
 static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 {
-	struct inode *inode = d_inode(dentry);
-
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_parent(dentry, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE);
 }
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
 {
 	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
-	int ret;
 
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
 
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	ret = fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
-	if (ret)
-		return ret;
-
-	return fsnotify(inode, mask, path, FSNOTIFY_EVENT_PATH, NULL, 0);
+	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
 /* Simple call site for access decisions */
@@ -158,6 +151,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 
 	if (source)
 		fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
+
 	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
 }
 
-- 
2.17.1

