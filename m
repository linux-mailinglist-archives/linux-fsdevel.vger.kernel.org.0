Return-Path: <linux-fsdevel+bounces-9898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49983845D01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1CC1C214F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1E5E22A;
	Thu,  1 Feb 2024 16:16:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA164161B5A;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804160; cv=none; b=VB8ysJzuZqpiRNu5wDwSEVM69UmeC57KQZuwsfTvqcGO8jeNiaCdVzUXPwsP4RC8Ruy2c5HMC/jRCxQiX2Ty6EtKR21qjyAY5yYfGkYa4ZL4zoGL9/eXtw6wlPy1nN7hj4BPzorSr4g4qOEAF8Mwbf7ulnf4ykNWpwFB2iyLn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804160; c=relaxed/simple;
	bh=TwXMBgsYj3cjkDRxSyydgTaD5Knftq7Y2tB5Ttzmt/o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aMcvm0WCz0C/QiDVpqjkRugXULfZ6vYDjO8AM+gB36+R+xEOlOeCxMCCMdgaHER5K5Q/gDcoY+/r7cngwLRZHzB1OQ0TBw5oYAqDWpg1wMg4UflApcPXxjDWyYUiT3E6KOB3RwevXJDiVZt4EhYFg/rT/43KHN4vbEIBcXs2+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DDFC4166C;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVZjd-00000005TlA-3MFD;
	Thu, 01 Feb 2024 11:16:17 -0500
Message-ID: <20240201161617.658992558@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 10:34:52 -0500
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
Subject: [PATCH 6/6] eventfs: Create eventfs_root_inode to store dentry
References: <20240201153446.138990674@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Only the root "events" directory stores a dentry. There's no reason to
hold a dentry pointer for every eventfs_inode as it is never set except
for the root "events" eventfs_inode.

Create a eventfs_root_inode structure that holds the events_dir dentry.
The "events" eventfs_inode *is* special, let it have its own descriptor.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 65 +++++++++++++++++++++++++++++++++-------
 fs/tracefs/internal.h    |  2 --
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1a831ba1042b..c50d089c9a7f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -35,6 +35,17 @@ static DEFINE_MUTEX(eventfs_mutex);
 /* Choose something "unique" ;-) */
 #define EVENTFS_FILE_INODE_INO		0x12c4e37
 
+struct eventfs_root_inode {
+	struct eventfs_inode		ei;
+	struct dentry			*events_dir;
+};
+
+static struct eventfs_root_inode *get_root_inode(struct eventfs_inode *ei)
+{
+	WARN_ON_ONCE(!ei->is_events);
+	return container_of(ei, struct eventfs_root_inode, ei);
+}
+
 /* Just try to make something consistent and unique */
 static int eventfs_dir_ino(struct eventfs_inode *ei)
 {
@@ -73,12 +84,18 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+	struct eventfs_root_inode *rei;
 
 	WARN_ON_ONCE(!ei->is_freed);
 
 	kfree(ei->entry_attrs);
 	kfree_const(ei->name);
-	kfree_rcu(ei, rcu);
+	if (ei->is_events) {
+		rei = get_root_inode(ei);
+		kfree_rcu(rei, ei.rcu);
+	} else {
+		kfree_rcu(ei, rcu);
+	}
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
@@ -408,19 +425,43 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	return NULL;
 }
 
+static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char *name)
+{
+	ei->name = kstrdup_const(name, GFP_KERNEL);
+	if (!ei->name)
+		return NULL;
+	kref_init(&ei->kref);
+	return ei;
+}
+
 static inline struct eventfs_inode *alloc_ei(const char *name)
 {
 	struct eventfs_inode *ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	struct eventfs_inode *result;
 
 	if (!ei)
 		return NULL;
 
-	ei->name = kstrdup_const(name, GFP_KERNEL);
-	if (!ei->name) {
+	result = init_ei(ei, name);
+	if (!result)
 		kfree(ei);
+
+	return result;
+}
+
+static inline struct eventfs_inode *alloc_root_ei(const char *name)
+{
+	struct eventfs_root_inode *rei = kzalloc(sizeof(*rei), GFP_KERNEL);
+	struct eventfs_inode *ei;
+
+	if (!rei)
 		return NULL;
-	}
-	kref_init(&ei->kref);
+
+	rei->ei.is_events = 1;
+	ei = init_ei(&rei->ei, name);
+	if (!ei)
+		kfree(rei);
+
 	return ei;
 }
 
@@ -710,6 +751,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 						int size, void *data)
 {
 	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct eventfs_root_inode *rei;
 	struct eventfs_inode *ei;
 	struct tracefs_inode *ti;
 	struct inode *inode;
@@ -722,7 +764,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-	ei = alloc_ei(name);
+	ei = alloc_root_ei(name);
 	if (!ei)
 		goto fail;
 
@@ -731,10 +773,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 		goto fail;
 
 	// Note: we have a ref to the dentry from tracefs_start_creating()
-	ei->events_dir = dentry;
+	rei = get_root_inode(ei);
+	rei->events_dir = dentry;
+
 	ei->entries = entries;
 	ei->nr_entries = size;
-	ei->is_events = 1;
 	ei->data = data;
 
 	/* Save the ownership of this directory */
@@ -845,13 +888,15 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
  */
 void eventfs_remove_events_dir(struct eventfs_inode *ei)
 {
+	struct eventfs_root_inode *rei;
 	struct dentry *dentry;
 
-	dentry = ei->events_dir;
+	rei = get_root_inode(ei);
+	dentry = rei->events_dir;
 	if (!dentry)
 		return;
 
-	ei->events_dir = NULL;
+	rei->events_dir = NULL;
 	eventfs_remove_dir(ei);
 
 	/*
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index beb3dcd0e434..15c26f9aaad4 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -36,7 +36,6 @@ struct eventfs_attr {
  * @children:	link list into the child eventfs_inode
  * @entries:	the array of entries representing the files in the directory
  * @name:	the name of the directory to create
- * @events_dir: the dentry of the events directory
  * @entry_attrs: Saved mode and ownership of the @d_children
  * @data:	The private data to pass to the callbacks
  * @attr:	Saved mode and ownership of eventfs_inode itself
@@ -54,7 +53,6 @@ struct eventfs_inode {
 	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
-	struct dentry			*events_dir;
 	struct eventfs_attr		*entry_attrs;
 	void				*data;
 	struct eventfs_attr		attr;
-- 
2.43.0



