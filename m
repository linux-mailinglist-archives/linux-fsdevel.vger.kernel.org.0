Return-Path: <linux-fsdevel+bounces-9102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623E83E306
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2105282D74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9E2263A;
	Fri, 26 Jan 2024 20:02:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816D1E876;
	Fri, 26 Jan 2024 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299328; cv=none; b=HrjdMRaAdlqzq9Ic8HNLQ9YpWgix+Qobvc44Tb5Ti/m7Jny/O/bla13R2aJYBWi086CRiTSSu8Qz1KTcaperoqM3Nl/WggeyJbpW85vsiJJdntiL812MOU7nvf1Ib0xLOZFKq3S7/sTiP/upWnWV+LTJ3/GDzbXJee1RLlIuApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299328; c=relaxed/simple;
	bh=iC0Vw1MUNFSZSDa2/2hGfEAsJpdJDjskecOmVObMa9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=e0Uu8X//qUlJYqPiWiyU5c3ANVur5hmlinR6IwX7/1TUha+mbwlinrzRu5VKc1zOMfBF8kUGQoxtxMoCh0ks399nL+7JxNzknbnXV0K+5OJl03QdEB3tTqXLhWMwy0K9v8oc/qo7KRlE7zRXlrrocw2hx5IioMjscIeZAudS2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BACFC433F1;
	Fri, 26 Jan 2024 20:02:06 +0000 (UTC)
Date: Fri, 26 Jan 2024 15:02:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Ajay Kaher  <ajay.kaher@broadcom.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240126150209.367ff402@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Linus suggested to use the same inode numbers to make it easier to
implement getdents(), as it was creating inodes just for generating a
unique and consistent inode number. Linus suggested to just use the same
inode for all files and directories.

Later it was discovered that having directories with the same inode number
would mess up the "find" command, but Linus found that on 64 bit machines,
there was a hole in the eventfs_inode structure due to alignment that
could be used to store the inode numbers for directories. That fixed the
directory issue, but the files still had their own inode number.

The 'tar' command uses inode numbers for determining uniqueness between
files, which this would break. Currently, tar is broken with tracefs
because all files show a stat of zero size and tar doesn't copy anything.
But because tar cares about inode numbers, there could be other
applications that do too. It's best to have all files have unique inode
numbers.

Copy the get_next_ino() to tracefs_get_next_ino() that takes a "files"
parameter. As eventfs directories have a fixed number of files within
them, the number of inodes needed for the eventfs directory files is known
when the directory is created. The tracefs_get_next_ino() will return a
new inode number but also reserve the next "files" inode numbers that the
caller is free to use. Then when an inode for a file is created, its inode
number will be its parent directory's inode number plus the index into the
file array of that directory, giving each file a unique inode number that
can be retrieved at any time.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 31 +++++++++++++++----------------
 fs/tracefs/inode.c       | 37 ++++++++++++++++++++++++++++++++++---
 fs/tracefs/internal.h    |  1 +
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6b211522a13e..7be7a694b106 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -32,14 +32,11 @@
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
-/* Choose something "unique" ;-) */
-#define EVENTFS_FILE_INODE_INO		0x12c4e37
-
 /* Just try to make something consistent and unique */
-static int eventfs_dir_ino(struct eventfs_inode *ei)
+static int eventfs_dir_ino(struct eventfs_inode *ei, int nr_files)
 {
 	if (!ei->ino)
-		ei->ino = get_next_ino();
+		ei->ino = tracefs_get_next_ino(nr_files);
 
 	return ei->ino;
 }
@@ -327,6 +324,7 @@ void eventfs_update_gid(struct dentry *dentry, kgid_t gid)
  * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
+ * @ino: inode number for this file
  *
  * This function creates a dentry that represents a file in the eventsfs_inode
  * directory. The inode.i_private pointer will point to @data in the open()
@@ -335,7 +333,8 @@ void eventfs_update_gid(struct dentry *dentry, kgid_t gid)
 static struct dentry *create_file(const char *name, umode_t mode,
 				  struct eventfs_attr *attr,
 				  struct dentry *parent, void *data,
-				  const struct file_operations *fop)
+				  const struct file_operations *fop,
+				  unsigned int ino)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
@@ -363,9 +362,7 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	inode->i_op = &eventfs_file_inode_operations;
 	inode->i_fop = fop;
 	inode->i_private = data;
-
-	/* All files will have the same inode number */
-	inode->i_ino = EVENTFS_FILE_INODE_INO;
+	inode->i_ino = ino;
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
@@ -377,12 +374,14 @@ static struct dentry *create_file(const char *name, umode_t mode,
 /**
  * create_dir - create a dir in the tracefs filesystem
  * @ei: the eventfs_inode that represents the directory to create
- * @parent: parent dentry for this file.
+ * @parent: parent dentry for this directory.
+ * @nr_files: The number of files (not directories) this directory has
  *
  * This function will create a dentry for a directory represented by
  * a eventfs_inode.
  */
-static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent)
+static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent,
+				 int nr_files)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
@@ -404,7 +403,7 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	inode->i_fop = &eventfs_file_operations;
 
 	/* All directories will have the same inode number */
-	inode->i_ino = eventfs_dir_ino(ei);
+	inode->i_ino = eventfs_dir_ino(ei, nr_files);
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
@@ -504,7 +503,7 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 
 	mutex_unlock(&eventfs_mutex);
 
-	dentry = create_file(name, mode, attr, parent, data, fops);
+	dentry = create_file(name, mode, attr, parent, data, fops, ei->ino + idx + 1);
 
 	mutex_lock(&eventfs_mutex);
 
@@ -598,7 +597,7 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	dentry = create_dir(ei, parent);
+	dentry = create_dir(ei, parent, ei->nr_entries);
 
 	mutex_lock(&eventfs_mutex);
 
@@ -786,7 +785,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		if (r <= 0)
 			continue;
 
-		ino = EVENTFS_FILE_INODE_INO;
+		ino = ei->ino + i + 1;
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
 			goto out;
@@ -810,7 +809,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		name = ei_child->name;
 
-		ino = eventfs_dir_ino(ei_child);
+		ino = eventfs_dir_ino(ei_child, ei_child->nr_entries);
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..2187be6d7b23 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -223,13 +223,41 @@ static const struct inode_operations tracefs_file_inode_operations = {
 	.setattr	= tracefs_setattr,
 };
 
+/* Copied from get_next_ino() but adds allocation for multiple inodes */
+#define LAST_INO_BATCH 1024
+#define LAST_INO_MASK (~(LAST_INO_BATCH - 1))
+static DEFINE_PER_CPU(unsigned int, last_ino);
+
+unsigned int tracefs_get_next_ino(int files)
+{
+	unsigned int *p = &get_cpu_var(last_ino);
+	unsigned int res = *p;
+
+#ifdef CONFIG_SMP
+	/* Check if adding files+1 overflows */
+	if (unlikely(!res || (res & LAST_INO_MASK) != ((res + files + 1) & LAST_INO_MASK))) {
+		static atomic_t shared_last_ino;
+		int next = atomic_add_return(LAST_INO_BATCH, &shared_last_ino);
+
+		res = next - LAST_INO_BATCH;
+	}
+#endif
+
+	res++;
+	/* get_next_ino should not provide a 0 inode number */
+	if (unlikely(!res))
+		res++;
+	*p = res + files;
+	put_cpu_var(last_ino);
+	return res;
+}
+
 struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
-	if (inode) {
-		inode->i_ino = get_next_ino();
+	if (inode)
 		simple_inode_init_ts(inode);
-	}
+
 	return inode;
 }
 
@@ -644,6 +672,8 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_private = data;
 	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
 	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
+	inode->i_ino = tracefs_get_next_ino(0);
+
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return tracefs_end_creating(dentry);
@@ -669,6 +699,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	inode->i_fop = &simple_dir_operations;
 	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
 	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
+	inode->i_ino = tracefs_get_next_ino(0);
 
 	ti = get_tracefs(inode);
 	ti->private = instance_inode(parent, inode);
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 45397df9bb65..7dd6678229d0 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -75,6 +75,7 @@ static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
 	return container_of(inode, struct tracefs_inode, vfs_inode);
 }
 
+unsigned int tracefs_get_next_ino(int files);
 struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
-- 
2.43.0


