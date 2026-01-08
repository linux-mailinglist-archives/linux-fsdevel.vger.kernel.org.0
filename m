Return-Path: <linux-fsdevel+bounces-72857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DDCD03E29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9F20305475A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2B480DDA;
	Thu,  8 Jan 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="rrfkpwG7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8E47DD71;
	Thu,  8 Jan 2026 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882234; cv=none; b=Jq4dcRRy3kHHXIGzW19aIeHQ5d3oLBOt1Uno9iwz4oaFdjX5kywxJfKcDUqlufBTcA6FX2GD1LNqD4MfHAE77f0T3I5zT8mA6xx9WUenaG0yIR8iTzOY9ZLG4dq9HuVpdbe1x2vYgt9L6kJ9PGGQBzFj6TFemy6LX7cW3qsdlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882234; c=relaxed/simple;
	bh=c8rfkx/eXAt2tJEKpAeOWNZpo1FPtjGDkOigKSPdCbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9/EIvcB1D3e1XeR7emfkZAL0W1hrr0RZJAW1MD84gaj3kIJN7F2u8zbM/QD0HcytXA9L2eKL5xKjQSCFN69cAUGdzXoNWuatIbE/8WCwIb17ZXh8kJ/klcnJdIHbI1ZqCiecqxJRZQGfe+XXG3ObFY5MdfWhVcfRJ1l3LLBJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=rrfkpwG7; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from [127.0.1.1] (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 9C6DEE0805;
	Thu,  8 Jan 2026 15:23:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1767882223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoBKHUPyRE4dv9HQUx7jnaCpPyk1i4YWKhMO2DACI18=;
	b=rrfkpwG7RPdwEuw5PGYNm+O9JUfY8xMQ9MDnBqBB8RJqqaLJIYQPgBo/EH3wYK1YyUJMsi
	qJCpCjc6y+0q24FBB0aiup5JcX9+l9ooKu0CaPQqJHv/6EtUklr2S6lmA8L5/O+JtLrvR8
	cQEd2Pt2QvvmZSNKRyMHRnUh2Bn1lQTcP4OLQZHiPiszoOKk5CMnCg4rAak7rqls6vEZ0Z
	B8Feh0qh7OCPf6qWP+GVQWWOpHKwYgW1dkiViq5RIgUL0kMMT88zAKtrkIYL+RIZi7Bt7q
	2QZ/lf48d6ot+A3IWJB5w/nN7AbS2cliNe5us4ct3etMG10420C+M0FroCFhhg==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: horst@birthelmer.com
Date: Thu, 08 Jan 2026 15:23:35 +0100
Subject: [PATCH RFC v3 2/3] fuse: add an implementation of open+getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-fuse-compounds-upstream-v3-2-8dc91ebf3740@ddn.com>
References: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com>
In-Reply-To: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767882221; l=8381;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=LKb/IffHUUCYsfl1QuQVefttHz9uz5SepmgYOe/ZYbI=;
 b=NFzNiO9SlOOYMDqQP0sg/443jM9yR/3OLORrOlJ5KaKtGzH7zB5S357JIIXb+RQO6cj0NYkuV
 /YG+YGUhV5ACBhkFPxD3ukgOPp8R7XM69Kqh0rXvRL7Oj0XbSoDIx90
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

The discussion about compound commands in fuse was
started over an argument to add a new operation that
will open a file and return its attributes in the same operation.

Here is a demonstration of that use case with compound commands.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/file.c   | 143 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h |  15 +++++-
 fs/fuse/inode.c  |   6 +++
 fs/fuse/ioctl.c  |   2 +-
 4 files changed, 148 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..676f6bfde9f8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -23,6 +23,39 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/iomap.h>
 
+/*
+ * Helper function to initialize fuse_args for OPEN/OPENDIR operations
+ */
+void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+			 struct fuse_open_in *inarg, struct fuse_open_out *outarg)
+{
+	args->opcode = opcode;
+	args->nodeid = nodeid;
+	args->in_numargs = 1;
+	args->in_args[0].size = sizeof(*inarg);
+	args->in_args[0].value = inarg;
+	args->out_numargs = 1;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+}
+
+/*
+ * Helper function to initialize fuse_args for GETATTR operations
+ */
+void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
+			     struct fuse_getattr_in *inarg,
+			     struct fuse_attr_out *outarg)
+{
+	args->opcode = FUSE_GETATTR;
+	args->nodeid = nodeid;
+	args->in_numargs = 1;
+	args->in_args[0].size = sizeof(*inarg);
+	args->in_args[0].value = inarg;
+	args->out_numargs = 1;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+}
+
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
 			  struct fuse_open_out *outargp)
@@ -126,8 +159,66 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 	}
 }
 
+static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
+				      int flags, int opcode,
+				      struct fuse_file *ff,
+				      struct fuse_attr_out *outattrp,
+				      struct fuse_open_out *outopenp)
+{
+	struct fuse_compound_req *compound;
+	struct fuse_args open_args = {};
+	struct fuse_args getattr_args = {};
+	struct fuse_open_in open_in = {};
+	struct fuse_getattr_in getattr_in = {};
+	int err;
+
+	compound = fuse_compound_alloc(fm, 0);
+	if (IS_ERR(compound))
+		return PTR_ERR(compound);
+
+	open_in.flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+	if (!fm->fc->atomic_o_trunc)
+		open_in.flags &= ~O_TRUNC;
+
+	if (fm->fc->handle_killpriv_v2 &&
+	    (open_in.flags & O_TRUNC) && !capable(CAP_FSETID))
+		open_in.open_flags |= FUSE_OPEN_KILL_SUIDGID;
+
+	fuse_open_args_fill(&open_args, nodeid, opcode, &open_in, outopenp);
+
+	err = fuse_compound_add(compound, &open_args);
+	if (err)
+		goto out;
+
+	fuse_getattr_args_fill(&getattr_args, nodeid, &getattr_in, outattrp);
+
+	err = fuse_compound_add(compound, &getattr_args);
+	if (err)
+		goto out;
+
+	err = fuse_compound_send(compound);
+	if (err)
+		goto out;
+
+	err = fuse_compound_get_error(compound, 0);
+	if (err)
+		goto out;
+
+	err = fuse_compound_get_error(compound, 1);
+	if (err)
+		goto out;
+
+	ff->fh = outopenp->fh;
+	ff->open_flags = outopenp->open_flags;
+
+out:
+	fuse_compound_free(compound);
+	return err;
+}
+
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				struct inode *inode,
+				unsigned int open_flags, bool isdir)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
@@ -153,23 +244,44 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	if (open) {
 		/* Store outarg for fuse_finish_open() */
 		struct fuse_open_out *outargp = &ff->args->open_outarg;
-		int err;
+		int err = -ENOSYS;
+
+		if (inode && fc->compound_open_getattr) {
+			struct fuse_attr_out attr_outarg;
+
+			err = fuse_compound_open_getattr(fm, nodeid, open_flags,
+							 opcode, ff,
+							 &attr_outarg, outargp);
+			if (!err)
+				fuse_change_attributes(inode, &attr_outarg.attr,
+						       NULL,
+						       ATTR_TIMEOUT(&attr_outarg),
+						       fuse_get_attr_version(fc));
+		}
+		if (err == -ENOSYS) {
+			err = fuse_send_open(fm, nodeid, open_flags, opcode,
+					     outargp);
+			if (!err) {
+				ff->fh = outargp->fh;
+				ff->open_flags = outargp->open_flags;
+			}
+		}
 
-		err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
-		if (!err) {
-			ff->fh = outargp->fh;
-			ff->open_flags = outargp->open_flags;
-		} else if (err != -ENOSYS) {
-			fuse_file_free(ff);
-			return ERR_PTR(err);
-		} else {
-			if (isdir) {
+		if (err) {
+			if (err != -ENOSYS) {
+				/* err is not ENOSYS */
+				fuse_file_free(ff);
+				return ERR_PTR(err);
+			} else {
 				/* No release needed */
 				kfree(ff->args);
 				ff->args = NULL;
-				fc->no_opendir = 1;
-			} else {
-				fc->no_open = 1;
+
+				/* we don't have open */
+				if (isdir)
+					fc->no_opendir = 1;
+				else
+					fc->no_open = 1;
 			}
 		}
 	}
@@ -185,11 +297,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file_inode(file), file->f_flags, isdir);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
-
 	return PTR_ERR_OR_ZERO(ff);
 }
 EXPORT_SYMBOL_GPL(fuse_do_open);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6dddbe2b027b..e7828405e262 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -924,6 +924,9 @@ struct fuse_conn {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/* Does the filesystem support compound operations? */
+	unsigned int compound_open_getattr:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -1179,6 +1182,14 @@ struct fuse_io_args {
 void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 			 size_t count, int opcode);
 
+/*
+ * Helper functions to initialize fuse_args for common operations
+ */
+void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+			 struct fuse_open_in *inarg, struct fuse_open_out *outarg);
+void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
+			    struct fuse_getattr_in *inarg,
+			    struct fuse_attr_out *outarg);
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
@@ -1555,7 +1566,9 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+								struct inode *inode,
+								unsigned int open_flags,
+								bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d66622..a5fd721be96d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -991,6 +991,12 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->blocked = 0;
 	fc->initialized = 0;
 	fc->connected = 1;
+
+	/* pretend fuse server supports compound operations
+	 * until it tells us otherwise.
+	 */
+	fc->compound_open_getattr = 1;
+
 	atomic64_set(&fc->attr_version, 1);
 	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f74..07a02e47b2c3 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -494,7 +494,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isdir);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)

-- 
2.51.0


