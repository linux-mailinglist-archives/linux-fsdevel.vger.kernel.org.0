Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D097C2185AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgGHLML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHLMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712BC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so3744050wmc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=33Xisl4lMhvn/WaDKdXc9pHfauIoD/BUq0VCz7uTm/s=;
        b=m2NcTcbBYi7vrBWHSDzG0bzZ7d9onedv+8kzDZEPbrKXyADmju8bSiQZ4xY4YD5os+
         9JTZUpLvY1jtvHXnrNJxgVPJw6Q9E9xujWjMnGi2KbY2KFdpe74tE5VEq96AF7PVJkA9
         yzY6NIWxgyz8ch/pbiXNIr0/Vc7w5wPXzUQSZuTakVprPcCNUeJjwhEqc5ISEXR9huxc
         zDpuYJ5Z9wsfmjpPmQYjVxRE4tHZKuWE9jHhLzDRrPv6pWUOZyIewzZgNCqsr21EPQrp
         kon31Te02aJhmFNH47pN9Z/GiLmC2fOX1nq6fYR+T8q+jhfbRar4pwy0QDWvcA/CVUbc
         HPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=33Xisl4lMhvn/WaDKdXc9pHfauIoD/BUq0VCz7uTm/s=;
        b=IEbIx+RQvpV7+pFEl6ITLO+85I3xkXB+UiZLY8u1v4H2R6hpdCLFkKPOO1XZ1GCjej
         RKLbCcxXujzRoInIAlwTQQnUwGP5MQ3pqZDc+icwdgHfnXdUVq/BISfU21vYsLBxBWwC
         td3Kfp/rXPZji/E+WiOeRre7IgjwETm970THnFFIWLUAPLr28N8H8d482ZrnS/bKzeRI
         p9jxeVvek2bfRncWBRYIXNr+1BMaVTYc9KQlY/mRQ5rG1J8THvXkJsjvqTx9bVf7X9/x
         qHcQi9iWbo6bNsHJSxEdIJXycVYztCfIc2QGy/sj+/f+JP9iWkRGPQlqu0EJu/7zZy9t
         DVXg==
X-Gm-Message-State: AOAM530TOrKQTFg1YiD1g5QC0uS5ql9ie/Qf6B7oGyaTh5UuEiDsFd4n
        SdGrancvRo4swFwzrVygCaA=
X-Google-Smtp-Source: ABdhPJzIJdUgxmE+R1EVcAtQ0BCwuBWmK8h9g6ltfa352KfKEUhkI1l8dGbPx3z0wfcOq+oWLlyNxg==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr6953059wmi.94.1594206728380;
        Wed, 08 Jul 2020 04:12:08 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:07 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/20] fsnotify: fold fsnotify() call into fsnotify_parent()
Date:   Wed,  8 Jul 2020 14:11:37 +0300
Message-Id: <20200708111156.24659-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
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
 include/linux/fsnotify.h | 33 +++++++++++++--------------------
 2 files changed, 31 insertions(+), 29 deletions(-)

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
index 508f6bb0b06b..316c9b820517 100644
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
-- 
2.17.1

