Return-Path: <linux-fsdevel+bounces-9894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB5F845CFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDBF1C210AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C02D5E20E;
	Thu,  1 Feb 2024 16:16:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7316088E;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804160; cv=none; b=SSXuekQKbGrDclHqfNoIbgg1x9Y421strppmFWGp+v5gmJ691cRU4aX+r8YrjuDFNoL709Ca9ZgywE5WVcDgEw+9Pz1+TR+eVNMOdXEqadRlw9OtuNvCT+27V4A5LBbo3WJ5f/9PNAbCh8uuz/Rvk3SR18hT8cf/DecSSH3fEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804160; c=relaxed/simple;
	bh=UgB47jemCzZI8cfp+JEFI8vC2gts63luDIkaSyClb+c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DXMu9nSOLUN9n5Wo+M2r5VeoMQZ5v3U5Dz+lnjpffIZ9EWmqAN01zTaGb/b1Qb4POx4Pzbz3lRPCp2v/l2YvXt6qiU1YCVuq1jTVg4tf95P45Tg2DS9+CX+vYN3IybNINWquD1mNIFBbY9mM5fw8RD+ltMiETl0/umGLHb6+dbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113EFC43394;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVZjd-00000005TjE-0cEI;
	Thu, 01 Feb 2024 11:16:17 -0500
Message-ID: <20240201161617.002321438@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 10:34:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH 2/6] eventfs: Restructure eventfs_inode structure to be more condensed
References: <20240201153446.138990674@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Some of the eventfs_inode structure has holes in it. Rework the structure
to be a bit more condensed, and also remove the no longer used llist
field.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/internal.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 1886f1826cd8..beb3dcd0e434 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -32,40 +32,37 @@ struct eventfs_attr {
 /*
  * struct eventfs_inode - hold the properties of the eventfs directories.
  * @list:	link list into the parent directory
+ * @rcu:	Union with @list for freeing
+ * @children:	link list into the child eventfs_inode
  * @entries:	the array of entries representing the files in the directory
  * @name:	the name of the directory to create
- * @children:	link list into the child eventfs_inode
  * @events_dir: the dentry of the events directory
  * @entry_attrs: Saved mode and ownership of the @d_children
- * @attr:	Saved mode and ownership of eventfs_inode itself
  * @data:	The private data to pass to the callbacks
+ * @attr:	Saved mode and ownership of eventfs_inode itself
  * @is_freed:	Flag set if the eventfs is on its way to be freed
  *                Note if is_freed is set, then dentry is corrupted.
+ * @is_events:	Flag set for only the top level "events" directory
  * @nr_entries: The number of items in @entries
+ * @ino:	The saved inode number
  */
 struct eventfs_inode {
-	struct kref			kref;
-	struct list_head		list;
+	union {
+		struct list_head	list;
+		struct rcu_head		rcu;
+	};
+	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
-	struct list_head		children;
 	struct dentry			*events_dir;
 	struct eventfs_attr		*entry_attrs;
-	struct eventfs_attr		attr;
 	void				*data;
+	struct eventfs_attr		attr;
+	struct kref			kref;
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
 	unsigned int			nr_entries:30;
 	unsigned int			ino;
-	/*
-	 * Union - used for deletion
-	 * @llist:	for calling dput() if needed after RCU
-	 * @rcu:	eventfs_inode to delete in RCU
-	 */
-	union {
-		struct llist_node	llist;
-		struct rcu_head		rcu;
-	};
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.43.0



