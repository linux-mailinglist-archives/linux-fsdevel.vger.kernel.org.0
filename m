Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE046D703
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhLHPeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 10:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhLHPeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:34:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B16C061746;
        Wed,  8 Dec 2021 07:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1CD3CE1FAC;
        Wed,  8 Dec 2021 15:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F37C00446;
        Wed,  8 Dec 2021 15:30:54 +0000 (UTC)
Date:   Wed, 8 Dec 2021 10:30:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] tracefs: Use d_inode() helper function to get the dentry
 inode
Message-ID: <20211208103052.706253b4@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of referencing the inode from a dentry via dentry->d_inode, use
the helper function d_inode(dentry) instead. This is the considered the
correct way to access it.

Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Reported: https://lore.kernel.org/all/20211208104454.nhxyvmmn6d2qhpwl@wittgenstein/
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 925a621b432e..9899c6078c95 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -109,12 +109,12 @@ static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
 	 * also the directory that is being deleted.
 	 */
 	inode_unlock(inode);
-	inode_unlock(dentry->d_inode);
+	inode_unlock(d_inode(dentry));
 
 	ret = tracefs_ops.rmdir(name);
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
-	inode_lock(dentry->d_inode);
+	inode_lock(d_inode(dentry));
 
 	kfree(name);
 
@@ -212,7 +212,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 static int tracefs_apply_options(struct super_block *sb)
 {
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
-	struct inode *inode = sb->s_root->d_inode;
+	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_mount_opts *opts = &fsi->mount_opts;
 
 	inode->i_mode &= ~S_IALLUGO;
@@ -331,18 +331,18 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	if (!parent)
 		parent = tracefs_mount->mnt_root;
 
-	inode_lock(parent->d_inode);
-	if (unlikely(IS_DEADDIR(parent->d_inode)))
+	inode_lock(d_inode(parent));
+	if (unlikely(IS_DEADDIR(d_inode(parent))))
 		dentry = ERR_PTR(-ENOENT);
 	else
 		dentry = lookup_one_len(name, parent, strlen(name));
-	if (!IS_ERR(dentry) && dentry->d_inode) {
+	if (!IS_ERR(dentry) && d_inode(dentry)) {
 		dput(dentry);
 		dentry = ERR_PTR(-EEXIST);
 	}
 
 	if (IS_ERR(dentry)) {
-		inode_unlock(parent->d_inode);
+		inode_unlock(d_inode(parent));
 		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
 	}
 
@@ -351,7 +351,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 
 static struct dentry *failed_creating(struct dentry *dentry)
 {
-	inode_unlock(dentry->d_parent->d_inode);
+	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
 	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
 	return NULL;
@@ -359,7 +359,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 
 static struct dentry *end_creating(struct dentry *dentry)
 {
-	inode_unlock(dentry->d_parent->d_inode);
+	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
 }
 
@@ -415,7 +415,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
-	fsnotify_create(dentry->d_parent->d_inode, dentry);
+	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
 }
 
@@ -440,8 +440,8 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
-	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	inc_nlink(d_inode(dentry->d_parent));
+	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
 }
 
-- 
2.31.1

