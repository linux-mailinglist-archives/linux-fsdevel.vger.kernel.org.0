Return-Path: <linux-fsdevel+bounces-8118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A180F82FC84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2561C27107
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE132D02A;
	Tue, 16 Jan 2024 21:12:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724D200B7;
	Tue, 16 Jan 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439558; cv=none; b=X6ehvOFD8TKPa+EPPzMtRo7Dahrzi6cac58Fn5ZrxN1lqxy9zm674ebx3lBtW6yl8qUsJ1DBmN7V6cK583Y/sdglNYuZTDuM4oj/e7R7H2FjDBO50hqrsJEfl8V8yRtOE9y9dmu+2TqTldAtqP7A3w7ZhSdMcfdCjbhftDjY5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439558; c=relaxed/simple;
	bh=mSSEti/pws5tstaq4hJGZy7wJkxktJfMLR7SyPu5kN4=;
	h=Received:Received:Message-ID:User-Agent:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type; b=ja7qFTeKCsLpAm2G+MEddfADK42XFCxAOLf7UHZzdqKs0Hq8MHvcNo1YBppuh0M0MZJQlcdmAjUClBpw/AUkOHQ5+L+It2WChGL/VkO4SYniesMGnj7q1B0MxC9PVlkxvj7WJFlKmhCtNBQDisK7IAmwI1pKQqpmtzZWmneGV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A57EC43390;
	Tue, 16 Jan 2024 21:12:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rPqkr-00000001PQy-2KDw;
	Tue, 16 Jan 2024 16:13:53 -0500
Message-ID: <20240116211353.412180363@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 16 Jan 2024 16:12:18 -0500
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
 linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] eventfs: Have the inodes all for files and directories all be the
 same
References: <20240116211217.968123837@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The dentries and inodes are created in the readdir for the sole purpose of
getting a consistent inode number. Linus stated that is unnecessary, and
that all inodes can have the same inode number. For a virtual file system
they are pretty meaningless.

Instead use a single unique inode number for all files and one for all
directories.

Link: https://lore.kernel.org/all/20240116133753.2808d45e@gandalf.local.home/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fdff53d5a1f8..5edf0b96758b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -32,6 +32,10 @@
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
+/* Choose something "unique" ;-) */
+#define EVENTFS_FILE_INODE_INO		0x12c4e37
+#define EVENTFS_DIR_INODE_INO		0x134b2f5
+
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
@@ -352,6 +356,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	inode->i_fop = fop;
 	inode->i_private = data;
 
+	/* All files will have the same inode number */
+	inode->i_ino = EVENTFS_FILE_INODE_INO;
+
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 	d_instantiate(dentry, inode);
@@ -388,6 +395,9 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
+	/* All directories will have the same inode number */
+	inode->i_ino = EVENTFS_DIR_INODE_INO;
+
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 
-- 
2.43.0



