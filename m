Return-Path: <linux-fsdevel+bounces-8129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524C82FDCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 00:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2018F1F254FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4201D6BA;
	Tue, 16 Jan 2024 23:39:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33D67C70;
	Tue, 16 Jan 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448339; cv=none; b=qXOMEZD30fxwBFWLnnmTSvLaA9CyKWkVUB3O6bbnVAqe2nkwZ3ymLwX4VFSZCAxIdldxhPl2m+fGxQe0nrLBgKAVNfUL3jcTtMvF+FPY/Ku7oUZctpGKzPnYteJBd2dSqkw2jLAZw/w/cHHR5i6R2Q4MYb3XI7nRx/hQXMkVAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448339; c=relaxed/simple;
	bh=kdVBorZqhrlAzJnHue7J/bMpS46boW/Qgz6CQs5DZdw=;
	h=Received:Received:Message-ID:User-Agent:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type; b=HNkCOi4aqKBChOr6+/+EhO8YaAsl9Mk7LIkYRHrwbEM1QyYV1twQDB+dN4zoG7dCJtgfdUM+WX/rmI44pQ4vIfIwh1nOw3pIi6xlR8qX4LyUJQ4932esgBuxwR0ekB9lfm7Zb0e3Yf9T37jbs42IAiufCh/Y8EneUlOinmlup4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAE3C43399;
	Tue, 16 Jan 2024 23:38:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rPt2U-00000001QfM-3DfO;
	Tue, 16 Jan 2024 18:40:14 -0500
Message-ID: <20240116234014.624901641@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 16 Jan 2024 17:55:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al  Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 linux-fsdevel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3 2/2] eventfs: Do not create dentries nor inodes in iterate_shared
References: <20240116225531.681181743@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The original eventfs code added a wrapper around the dcache_readdir open
callback and created all the dentries and inodes at open, and increment
their ref count. A wrapper was added around the dcache_readdir release
function to decrement all the ref counts of those created inodes and
dentries. But this proved to be buggy[1] for when a kprobe was created
during a dir read, it would create a dentry between the open and the
release, and because the release would decrement all ref counts of all
files and directories, that would include the kprobe directory that was
not there to have its ref count incremented in open. This would cause the
ref count to go to negative and later crash the kernel.

To solve this, the dentries and inodes that were created and had their ref
count upped in open needed to be saved. That list needed to be passed from
the open to the release, so that the release would only decrement the ref
counts of the entries that were incremented in the open.

Unfortunately, the dcache_readdir logic was already using the
file->private_data, which is the only field that can be used to pass
information from the open to the release. What was done was the eventfs
created another descriptor that had a void pointer to save the
dcache_readdir pointer, and it wrapped all the callbacks, so that it could
save the list of entries that had their ref counts incremented in the
open, and pass it to the release. The wrapped callbacks would just put
back the dcache_readdir pointer and call the functions it used so it could
still use its data[2].

But Linus had an issue with the "hijacking" of the file->private_data
(unfortunately this discussion was on a security list, so no public link).
Which we finally agreed on doing everything within the iterate_shared
callback and leave the dcache_readdir out of it[3]. All the information
needed for the getents() could be created then.

But this ended up being buggy too[4]. The iterate_shared callback was not
the right place to create the dentries and inodes. Even Christian Brauner
had issues with that[5].

An attempt was to go back to creating the inodes and dentries at
the open, create an array to store the information in the
file->private_data, and pass that information to the other callbacks.[6]

The difference between that and the original method, is that it does not
use dcache_readdir. It also does not up the ref counts of the dentries and
pass them. Instead, it creates an array of a structure that saves the
dentry's name and inode number. That information is used in the
iterate_shared callback, and the array is freed in the dir release. The
dentries and inodes created in the open are not used for the iterate_share
or release callbacks. Just their names and inode numbers.

Linus did not like that either[7] and just wanted to remove the dentries
being created in iterate_shared and use the hard coded inode numbers.

[ All this while Linus enjoyed an unexpected vacation during the merge
  window due to lack of power. ]

[1] https://lore.kernel.org/linux-trace-kernel/20230919211804.230edf1e@gandalf.local.home/
[2] https://lore.kernel.org/linux-trace-kernel/20230922163446.1431d4fa@gandalf.local.home/
[3] https://lore.kernel.org/linux-trace-kernel/20240104015435.682218477@goodmis.org/
[4] https://lore.kernel.org/all/202401152142.bfc28861-oliver.sang@intel.com/
[5] https://lore.kernel.org/all/20240111-unzahl-gefegt-433acb8a841d@brauner/
[6] https://lore.kernel.org/all/20240116114711.7e8637be@gandalf.local.home/
[7] https://lore.kernel.org/all/20240116170154.5bf0a250@gandalf.local.home/

Link: https://lore.kernel.org/linux-trace-kernel/20240116211353.573784051@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al  Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Fixes: 493ec81a8fb8 ("eventfs: Stop using dcache_readdir() for getdents()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401152142.bfc28861-oliver.sang@intel.com
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5edf0b96758b..10580d6b5012 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -727,8 +727,6 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry *ei_dentry = NULL;
-	struct dentry *dentry;
 	const char *name;
 	umode_t mode;
 	int idx;
@@ -749,11 +747,11 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
-	if (ei && !ei->is_freed)
-		ei_dentry = READ_ONCE(ei->dentry);
+	if (ei && ei->is_freed)
+		ei = NULL;
 	mutex_unlock(&eventfs_mutex);
 
-	if (!ei || !ei_dentry)
+	if (!ei)
 		goto out;
 
 	/*
@@ -780,11 +778,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		if (r <= 0)
 			continue;
 
-		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
-		if (!dentry)
-			goto out;
-		ino = dentry->d_inode->i_ino;
-		dput(dentry);
+		ino = EVENTFS_FILE_INODE_INO;
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
 			goto out;
@@ -808,11 +802,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		name = ei_child->name;
 
-		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
-		if (!dentry)
-			goto out_dec;
-		ino = dentry->d_inode->i_ino;
-		dput(dentry);
+		ino = EVENTFS_DIR_INODE_INO;
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
-- 
2.43.0



