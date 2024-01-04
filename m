Return-Path: <linux-fsdevel+bounces-7429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BABEF824A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 23:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5EA1F2558E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9629D2D03B;
	Thu,  4 Jan 2024 21:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B932C861;
	Thu,  4 Jan 2024 21:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CB9C43395;
	Thu,  4 Jan 2024 21:59:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLVlg-00000000vhh-2eTY;
	Thu, 04 Jan 2024 17:00:48 -0500
Message-ID: <20240104220048.494956957@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 04 Jan 2024 16:57:15 -0500
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
Subject: [PATCH 4/4] eventfs: Shortcut eventfs_iterate() by skipping entries already read
References: <20240104215711.924088454@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As the ei->entries array is fixed for the duration of the eventfs_inode,
it can be used to skip over already read entries in eventfs_iterate().

That is, if ctx->pos is greater than zero, there's no reason in doing the
loop across the ei->entries array for the entries less than ctx->pos.
Instead, start the lookup of the entries at the current ctx->pos.

Link: https://lore.kernel.org/all/CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a1934e0eea3b..fdff53d5a1f8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -746,21 +746,15 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	if (!ei || !ei_dentry)
 		goto out;
 
-	ret = 0;
-
 	/*
 	 * Need to create the dentries and inodes to have a consistent
 	 * inode number.
 	 */
-	for (i = 0; i < ei->nr_entries; i++) {
-		void *cdata = ei->data;
-
-		if (c > 0) {
-			c--;
-			continue;
-		}
+	ret = 0;
 
-		ctx->pos++;
+	/* Start at 'c' to jump over already read entries */
+	for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
+		void *cdata = ei->data;
 
 		entry = &ei->entries[i];
 		name = entry->name;
@@ -769,7 +763,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		/* If ei->is_freed then just bail here, nothing more to do */
 		if (ei->is_freed) {
 			mutex_unlock(&eventfs_mutex);
-			goto out_dec;
+			goto out;
 		}
 		r = entry->callback(name, &mode, &cdata, &fops);
 		mutex_unlock(&eventfs_mutex);
@@ -778,14 +772,17 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
 		if (!dentry)
-			goto out_dec;
+			goto out;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
-			goto out_dec;
+			goto out;
 	}
 
+	/* Subtract the skipped entries above */
+	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
+
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 
-- 
2.42.0



