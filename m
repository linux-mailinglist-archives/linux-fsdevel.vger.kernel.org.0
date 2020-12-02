Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EFF2CBC70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgLBMIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgLBMIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:08:39 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11659C061A04
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:20 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id pg6so3822407ejb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xSNu6SmhBDBAHCbKMAFp/TAz51yCqOY0BBeUrJN9P4=;
        b=qzNp/n6eKVAFXGos8n6tNMEh69rCMvPXu4nQ7Puu2C2U7VP7twKoqf2zAq3Lmt53cy
         FfJ3g4OdoE5FXxUUaEmsd3KnQApNd7npV+pY11rJAeiVUKvP9YRNt7bbCytKrfHe/5it
         S465XJb4KjEayYY/8h+69ukV/VC4pAGhZQPgQmDoG5yWq+KYRpeSQ+593d+G1pUc342k
         WB8s19zWYJQiLbSyfTX2tLaLf6mNuSEAuMHKUXpJdqs3y0B6971iviuY7pAMIib16tBV
         8K4ZbsyMdSIzsuu7vWGAriUGO4y2Ka2nj0ovhEUxhjvm3iG3JFY1sLuGrwRVjdrpakV4
         M22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xSNu6SmhBDBAHCbKMAFp/TAz51yCqOY0BBeUrJN9P4=;
        b=Gee6SI/mWwNYEWDwLATGfLR8gp85JVh8/mnMjjR/3IV67FXD8xVrj9uuRDlHf2T4QU
         br+3vsPYbmLrn0GTTwNK2rafqxZ23/S5aTGF6B5n+1GywQjpMtuCLUEE+NxlFj74MSZO
         NWODy/bRdZudJlh2DLuMy2BsqXzvdYIZCS5QluDlFBP6QvGdzzbwN2gR8RK9X98Cy+8n
         UyNbgmdYdzIzKsPsiUixnJBPL74LKkID2K+v4j919clQcPTX3yuLR1Z7fn79dlpKHIdT
         fIqgjeN+QXHnMs6OCPN4+zEuIRzK2UH1u7/LJMsA8t51Ou+dBl+1gzqBCG+QUgmX9O6f
         hd1g==
X-Gm-Message-State: AOAM532pceXVIWIwlp1A3SWAas57ORLNWqbs3Yvjj/tD4WBhjnfozKQs
        MH6iI8wWR8YephjJM/ndHzA=
X-Google-Smtp-Source: ABdhPJxjrlZPpghPp4321mvbkOLV4N3yVyHAdETYje9+TJ+wUtl0YV3VHzT1EZuav541pESWUORRuw==
X-Received: by 2002:a17:906:4016:: with SMTP id v22mr2025722ejj.266.1606910838676;
        Wed, 02 Dec 2020 04:07:18 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:18 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] fsnotify: generalize handle_inode_event()
Date:   Wed,  2 Dec 2020 14:07:07 +0200
Message-Id: <20201202120713.702387-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
References: <20201202120713.702387-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The handle_inode_event() interface was added as (quoting comment):
"a simple variant of handle_event() for groups that only have inode
marks and don't have ignore mask".

In other words, all backends except fanotify.  The inotify backend
also falls under this category, but because it required extra arguments
it was left out of the initial pass of backends conversion to the
simple interface.

This results in code duplication between the generic helper
fsnotify_handle_event() and the inotify_handle_event() callback
which also happen to be buggy code.

Generalize the handle_inode_event() arguments and add the check for
FS_EXCL_UNLINK flag to the generic helper, so inotify backend could
be converted to use the simple interface.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c              |  2 +-
 fs/notify/dnotify/dnotify.c      |  2 +-
 fs/notify/fsnotify.c             | 31 ++++++++++++++++++++++++-------
 include/linux/fsnotify_backend.h |  3 ++-
 kernel/audit_fsnotify.c          |  2 +-
 kernel/audit_tree.c              |  2 +-
 kernel/audit_watch.c             |  2 +-
 7 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 3c6c2f7d1688..5849c1bd88f1 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -600,7 +600,7 @@ static struct notifier_block nfsd_file_lease_notifier = {
 static int
 nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
 				struct inode *inode, struct inode *dir,
-				const struct qstr *name)
+				const struct qstr *name, u32 cookie)
 {
 	trace_nfsd_file_fsnotify_handle_event(inode, mask);
 
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 5dcda8f20c04..e45ca6ecba95 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -72,7 +72,7 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
  */
 static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 				struct inode *inode, struct inode *dir,
-				const struct qstr *name)
+				const struct qstr *name, u32 cookie)
 {
 	struct dnotify_mark *dn_mark;
 	struct dnotify_struct *dn;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8d3ad5ef2925..c5c68bcbaadf 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -232,6 +232,26 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 }
 EXPORT_SYMBOL_GPL(__fsnotify_parent);
 
+static int fsnotify_handle_inode_event(struct fsnotify_group *group,
+				       struct fsnotify_mark *inode_mark,
+				       u32 mask, const void *data, int data_type,
+				       struct inode *dir, const struct qstr *name,
+				       u32 cookie)
+{
+	const struct path *path = fsnotify_data_path(data, data_type);
+	struct inode *inode = fsnotify_data_inode(data, data_type);
+	const struct fsnotify_ops *ops = group->ops;
+
+	if (WARN_ON_ONCE(!ops->handle_inode_event))
+		return 0;
+
+	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
+	    path && d_unlinked(path->dentry))
+		return 0;
+
+	return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
+}
+
 static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 				 const void *data, int data_type,
 				 struct inode *dir, const struct qstr *name,
@@ -239,13 +259,8 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
 	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
-	struct inode *inode = fsnotify_data_inode(data, data_type);
-	const struct fsnotify_ops *ops = group->ops;
 	int ret;
 
-	if (WARN_ON_ONCE(!ops->handle_inode_event))
-		return 0;
-
 	if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
 	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
 		return 0;
@@ -262,7 +277,8 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 		name = NULL;
 	}
 
-	ret = ops->handle_inode_event(inode_mark, mask, inode, dir, name);
+	ret = fsnotify_handle_inode_event(group, inode_mark, mask, data, data_type,
+					  dir, name, cookie);
 	if (ret || !child_mark)
 		return ret;
 
@@ -272,7 +288,8 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 	 * report the event once to parent dir with name and once to child
 	 * without name.
 	 */
-	return ops->handle_inode_event(child_mark, mask, inode, NULL, NULL);
+	return fsnotify_handle_inode_event(group, child_mark, mask, data, data_type,
+					   NULL, NULL, 0);
 }
 
 static int send_to_group(__u32 mask, const void *data, int data_type,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index f8529a3a2923..4ee3044eedd0 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -137,6 +137,7 @@ struct mem_cgroup;
  *		if @file_name is not NULL, this is the directory that
  *		@file_name is relative to.
  * @file_name:	optional file name associated with event
+ * @cookie:	inotify rename cookie
  *
  * free_group_priv - called when a group refcnt hits 0 to clean up the private union
  * freeing_mark - called when a mark is being destroyed for some reason.  The group
@@ -151,7 +152,7 @@ struct fsnotify_ops {
 			    struct fsnotify_iter_info *iter_info);
 	int (*handle_inode_event)(struct fsnotify_mark *mark, u32 mask,
 			    struct inode *inode, struct inode *dir,
-			    const struct qstr *file_name);
+			    const struct qstr *file_name, u32 cookie);
 	void (*free_group_priv)(struct fsnotify_group *group);
 	void (*freeing_mark)(struct fsnotify_mark *mark, struct fsnotify_group *group);
 	void (*free_event)(struct fsnotify_event *event);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index bfcfcd61adb6..5b3f01da172b 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -154,7 +154,7 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
 /* Update mark data in audit rules based on fsnotify events. */
 static int audit_mark_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 				   struct inode *inode, struct inode *dir,
-				   const struct qstr *dname)
+				   const struct qstr *dname, u32 cookie)
 {
 	struct audit_fsnotify_mark *audit_mark;
 
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 83e1c07fc99e..6c91902f4f45 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -1037,7 +1037,7 @@ static void evict_chunk(struct audit_chunk *chunk)
 
 static int audit_tree_handle_event(struct fsnotify_mark *mark, u32 mask,
 				   struct inode *inode, struct inode *dir,
-				   const struct qstr *file_name)
+				   const struct qstr *file_name, u32 cookie)
 {
 	return 0;
 }
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 246e5ba704c0..2acf7ca49154 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -466,7 +466,7 @@ void audit_remove_watch_rule(struct audit_krule *krule)
 /* Update watch data in audit rules based on fsnotify events. */
 static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 				    struct inode *inode, struct inode *dir,
-				    const struct qstr *dname)
+				    const struct qstr *dname, u32 cookie)
 {
 	struct audit_parent *parent;
 
-- 
2.25.1

