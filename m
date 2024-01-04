Return-Path: <linux-fsdevel+bounces-7431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE2824A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 23:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0088BB23396
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59A2D044;
	Thu,  4 Jan 2024 21:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7272C863;
	Thu,  4 Jan 2024 21:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B59C433CC;
	Thu,  4 Jan 2024 21:59:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLVlg-00000000vhD-1zwl;
	Thu, 04 Jan 2024 17:00:48 -0500
Message-ID: <20240104220048.333115095@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 04 Jan 2024 16:57:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/4] eventfs: Read ei->entries before ei->children in eventfs_iterate()
References: <20240104215711.924088454@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In order to apply a shortcut to skip over the current ctx->pos
immediately, by using the ei->entries array, the reading of that array
should be first. Moving the array reading before the linked list reading
will make the shortcut change diff nicer to read.

Link: https://lore.kernel.org/all/CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index c73fb1f7ddbc..a1934e0eea3b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -752,8 +752,8 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	 * Need to create the dentries and inodes to have a consistent
 	 * inode number.
 	 */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
+	for (i = 0; i < ei->nr_entries; i++) {
+		void *cdata = ei->data;
 
 		if (c > 0) {
 			c--;
@@ -762,23 +762,32 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		ctx->pos++;
 
-		if (ei_child->is_freed)
-			continue;
+		entry = &ei->entries[i];
+		name = entry->name;
 
-		name = ei_child->name;
+		mutex_lock(&eventfs_mutex);
+		/* If ei->is_freed then just bail here, nothing more to do */
+		if (ei->is_freed) {
+			mutex_unlock(&eventfs_mutex);
+			goto out_dec;
+		}
+		r = entry->callback(name, &mode, &cdata, &fops);
+		mutex_unlock(&eventfs_mutex);
+		if (r <= 0)
+			continue;
 
-		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
+		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
 		if (!dentry)
 			goto out_dec;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
 			goto out_dec;
 	}
 
-	for (i = 0; i < ei->nr_entries; i++) {
-		void *cdata = ei->data;
+	list_for_each_entry_srcu(ei_child, &ei->children, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
 
 		if (c > 0) {
 			c--;
@@ -787,27 +796,18 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		ctx->pos++;
 
-		entry = &ei->entries[i];
-		name = entry->name;
-
-		mutex_lock(&eventfs_mutex);
-		/* If ei->is_freed then just bail here, nothing more to do */
-		if (ei->is_freed) {
-			mutex_unlock(&eventfs_mutex);
-			goto out_dec;
-		}
-		r = entry->callback(name, &mode, &cdata, &fops);
-		mutex_unlock(&eventfs_mutex);
-		if (r <= 0)
+		if (ei_child->is_freed)
 			continue;
 
-		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
+		name = ei_child->name;
+
+		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
 		if (!dentry)
 			goto out_dec;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
 	}
 	ret = 1;
-- 
2.42.0



