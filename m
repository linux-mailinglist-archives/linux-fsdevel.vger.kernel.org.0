Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00D2432A9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhJSACu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSACu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:02:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67476C06161C;
        Mon, 18 Oct 2021 17:00:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D17291F41A9C;
        Tue, 19 Oct 2021 01:00:36 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, kernel@collabora.com,
        Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v8 02/32] fsnotify: pass dentry instead of inode data
Date:   Mon, 18 Oct 2021 20:59:45 -0300
Message-Id: <20211019000015.1666608-3-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

Define a new data type to pass for event - FSNOTIFY_EVENT_DENTRY.
Use it to pass the dentry instead of it's ->d_inode where available.

This is needed in preparation to the refactor to retrieve the super
block from the data field.  In some cases (i.e. mkdir in kernfs), the
data inode comes from a negative dentry, such that no super block
information would be available. By receiving the dentry itself, instead
of the inode, fsnotify can derive the super block even on these cases.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[Expand explanation in commit message]
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v7:
  - Improve commit message (Jan)
---
 include/linux/fsnotify.h         |  5 ++---
 include/linux/fsnotify_backend.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index d1144d7c3536..df0fa4687a18 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -39,8 +39,7 @@ static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
 static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 				   __u32 mask)
 {
-	fsnotify_name(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		      dir, &dentry->d_name, 0);
+	fsnotify_name(mask, dentry, FSNOTIFY_EVENT_DENTRY, dir, &dentry->d_name, 0);
 }
 
 static inline void fsnotify_inode(struct inode *inode, __u32 mask)
@@ -87,7 +86,7 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
  */
 static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 {
-	fsnotify_parent(dentry, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE);
+	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
 }
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1ce66748a2d2..a2db821e8a8f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -248,6 +248,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
+	FSNOTIFY_EVENT_DENTRY,
 };
 
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
@@ -255,6 +256,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 	switch (data_type) {
 	case FSNOTIFY_EVENT_INODE:
 		return (struct inode *)data;
+	case FSNOTIFY_EVENT_DENTRY:
+		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
 	default:
@@ -262,6 +265,19 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 	}
 }
 
+static inline struct dentry *fsnotify_data_dentry(const void *data, int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_DENTRY:
+		/* Non const is needed for dget() */
+		return (struct dentry *)data;
+	case FSNOTIFY_EVENT_PATH:
+		return ((const struct path *)data)->dentry;
+	default:
+		return NULL;
+	}
+}
+
 static inline const struct path *fsnotify_data_path(const void *data,
 						    int data_type)
 {
-- 
2.33.0

