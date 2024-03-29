Return-Path: <linux-fsdevel+bounces-15651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF889111D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F25E28CA55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04652E407;
	Fri, 29 Mar 2024 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUPv+h9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904985C6C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677309; cv=none; b=oUG74amgnQ/egbkSqcxk7b9zcWHQyfYPuPL/c5Qi2kcHsVRMoJu3uZWvjjOjNE1iQMStkYDDpswaKGt3yUClQAhjimNo79pdG3LaaqhO45abkzh25Ge2hw2LYZhcNzPcns91lpeN6n5EH9JY/A9KK0zX1AF85bN1CFLKQGKYEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677309; c=relaxed/simple;
	bh=WB2+aIBBnGAmjt8YgnuqmpzErACdvxw+HOIgdgWZMeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kGDEcpRhFrL5w2FDnVBhWq6nStoQYR2dgB5kp2Rc8id3l5gW1sa70ShYJy8dm3xck2Er3c+Dm+HTugZE9iyAUpxzW2v+IsnwJQxsZaZP3YFafv81XnwlzT0PY1xOQ9Mz00bJlBlWR9Wqu4m8QxGKqCRjpm5CDf5/qI6HGf1K9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUPv+h9A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a61b31993so28359397b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677305; x=1712282105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIGNuIERprRFbYtu59mkQ7iO+y89Tk9z1OQnfjfFmpQ=;
        b=uUPv+h9At/DZmmUS5UHauSMsxolAYT2I4HmesATKLo33m3H3/lFPEB5WcYldth6M/i
         5eUaZ0eEsBfqVyZkd2KY0nfRzAXhajb8DVJmNg86c+EBoAgol9nv5XOzovNvaOT3wZhu
         XCYD13/JLXBhicIy6xURmLR3gVuUr9qNaXZ53+aFCza5zBmzZK2pCISyn0SG9ZYgxG3I
         kk8VklGsuFs0mnM+eZyIbu+q0H9nMURPn5yl6I9ke+LCfpnq8h89LggvDq8/r666Jt2c
         2ZxU7wQ82r5WWsnNrkkJuj+lFn6CQdoStwh/t+xQZKQLe87CNxjtO8kJ38BiOEiWKviB
         UiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677305; x=1712282105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIGNuIERprRFbYtu59mkQ7iO+y89Tk9z1OQnfjfFmpQ=;
        b=VJLqm+dvQ+FIEsaN83NdBBC9VuXhT3xK+0q4uH+VXKDjX8IlNwxAL1Mst59o9jd+UN
         w3JM20KekoIrJliAmIZ8FpOCQbjlO3X1dAQg28Jqv7jKlQU0j8zrkU04SixxC2QfHaDu
         ZGT59am/PDnkj2bg0kafLuA3ewLiJcXbBqvISXFIyvZ+NQUi0Qlu9hmJ3YK71ka5HlVV
         YomTX129BE1VRPFIEQAm5WZM+4kQNo/7UByyySGsompIVSwJyTY4sxfyHP2dtwg+9jb0
         pq6pJInqOq2SmORi5X6SKgxZhnDRwTvbzg0DJjs3BcXVFzutcdVGpIe+f7Bgkd3d+e1f
         nOHg==
X-Forwarded-Encrypted: i=1; AJvYcCXYDcWTjbshIPlOTUbSEySWIdtdTY30DLRCJTV4XsfCs2sXcLZvlSHW7tdtNu1F3RY35XBJBWR0k/csu2OTmlsYBd8Vft+81zMh3VBLIg==
X-Gm-Message-State: AOJu0Yy1tAGh8epIIDrw4vUd2zmf81+kieLtWeE6V5XXZJ+XxNw87g4o
	t+uRv6d9oVrAD8PHjKcWwmJr/g4mV9sQY1A7oAcrgFzHarX3SBRKRXtXrBWJ0wlHW47t7sL8grl
	aeg==
X-Google-Smtp-Source: AGHT+IGkSDFcSAQR5ALwwIQ3JXRpP9Dx6/nMJka01ohuszHNcmHsTHrY0ZAI1RYhTHOqdHZpZX4PSnyy7Pg=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a81:6f86:0:b0:611:2af3:8e07 with SMTP id
 k128-20020a816f86000000b006112af38e07mr308268ywc.3.1711677305218; Thu, 28 Mar
 2024 18:55:05 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:44 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-30-drosen@google.com>
Subject: [RFC PATCH v4 29/36] fuse-bpf: Set fuse_ops at mount or lookup time
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds the ability to associate a fuse_op struct_op program with
inodes in fuse. This can be done at mount time at the root level, or by
inode at lookup time.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c | 100 +++++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/dir.c     |  19 ++++++++-
 fs/fuse/fuse_i.h  |  12 ++++++
 fs/fuse/inode.c   |  45 ++++++++++++++++++---
 4 files changed, 160 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d5fcaef8e6b5..5fdca3a6183f 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,7 @@
 
 #include "fuse_i.h"
 
+#include <linux/bpf.h>
 #include <linux/bpf_fuse.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
@@ -176,12 +177,13 @@ static void fuse_get_backing_path(struct file *file, struct path *path)
 
 static bool has_file(int type)
 {
-	return type == FUSE_ENTRY_BACKING;
+	return (type == FUSE_ENTRY_BACKING);
 }
 
 /*
- * The optional fuse bpf entry lists the backing file for a particular
- * lookup. These are inherited by default.
+ * The optional fuse bpf entry lists the bpf and backing files for a particular
+ * lookup. These are inherited by default. A Bpf requires a backing file to be
+ * meaningful.
  *
  * In the future, we may support multiple bpfs, and multiple backing files for
  * the bpf to choose between.
@@ -190,14 +192,14 @@ static bool has_file(int type)
  * file. Changing only the bpf is valid, though meaningless if there isn't an
  * inherited backing file.
  *
- * Support for the bpf program will be added in a later patch
- *
  */
 int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
 {
 	struct fuse_bpf_entry_out *fbeo;
+	struct fuse_ops *ops;
 	struct file *file;
 	bool has_backing = false;
+	bool has_bpf_ops = false;
 	int num_entries;
 	int err = -EINVAL;
 	int i;
@@ -235,6 +237,11 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
 				goto out_err;
 			fbe->backing_action = FUSE_BPF_REMOVE;
 			break;
+		case FUSE_ENTRY_REMOVE_BPF:
+			if (fbe->bpf_action || i == 2)
+				goto out_err;
+			fbe->bpf_action = FUSE_BPF_REMOVE;
+			break;
 		case FUSE_ENTRY_BACKING:
 			if (fbe->backing_action)
 				goto out_err;
@@ -242,8 +249,17 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
 			fbe->backing_action = FUSE_BPF_SET;
 			has_backing = true;
 			break;
+		case FUSE_ENTRY_BPF:
+			if (fbe->bpf_action || i == 2)
+				goto out_err;
+			ops = find_fuse_ops(fbeo->name);
+			if (!ops)
+				goto out_err;
+			has_bpf_ops = true;
+			fbe->bpf_action = FUSE_BPF_SET;
+			fbe->ops = ops;
+			break;
 		default:
-			err = -EINVAL;
 			goto out_err;
 		}
 		if (has_file(fbeo->entry_type)) {
@@ -260,6 +276,10 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
 		fput(file);
 	if (has_backing)
 		path_put_init(&fbe->backing_path);
+	if (has_bpf_ops) {
+		put_fuse_ops(fbe->ops);
+		fbe->ops = NULL;
+	}
 	return err;
 }
 
@@ -538,6 +558,15 @@ static int fuse_create_open_backing(struct bpf_fuse_args *fa, int *out,
 		goto out;
 	}
 
+	if (get_fuse_inode(inode)->bpf_ops)
+		put_fuse_ops(get_fuse_inode(inode)->bpf_ops);
+	get_fuse_inode(inode)->bpf_ops = dir_fuse_inode->bpf_ops;
+	if (get_fuse_inode(inode)->bpf_ops)
+		if (!get_fuse_ops(get_fuse_inode(inode)->bpf_ops)) {
+			*out = -EINVAL;
+			goto out;
+		}
+
 	newent = d_splice_alias(inode, entry);
 	if (IS_ERR(newent)) {
 		*out = PTR_ERR(newent);
@@ -1858,12 +1887,56 @@ int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path)
 	return 0;
 }
 
+int fuse_handle_bpf_ops(struct fuse_bpf_entry *fbe, struct inode *parent,
+			 struct fuse_ops **ops)
+{
+	struct fuse_ops *new_ops = NULL;
+
+	switch (fbe->bpf_action) {
+	case FUSE_BPF_UNCHANGED: {
+		/* Parent isn't presented, but we want to keep
+		 * Don't touch bpf program at all in this case
+		 */
+		if (!parent)
+			return 0;
+
+		new_ops = get_fuse_inode(parent)->bpf_ops;
+		if (new_ops && !get_fuse_ops(new_ops))
+			return -EINVAL;
+		break;
+	}
+
+	case FUSE_BPF_REMOVE:
+		break;
+
+	case FUSE_BPF_SET:
+		new_ops = fbe->ops;
+
+		if (!new_ops)
+			return -EINVAL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Cannot change existing program */
+	if (*ops) {
+		if (new_ops)
+			put_fuse_ops(new_ops);
+		return new_ops == *ops ? 0 : -EINVAL;
+	}
+
+	*ops = new_ops;
+	return 0;
+}
+
 static int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
 				struct inode *dir, struct dentry *entry, unsigned int flags)
 {
 	struct fuse_dentry *fd;
 	struct dentry *backing_dentry;
-	struct inode *inode, *backing_inode;
+	struct inode *inode = NULL, *backing_inode;
 	struct inode *d_inode = entry->d_inode;
 	struct fuse_entry_out *feo = fa->out_args[0].value;
 	struct fuse_bpf_entry_out *febo = fa->out_args[1].buffer->data;
@@ -1891,13 +1964,22 @@ static int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
 		target_nodeid = get_fuse_inode(d_inode)->nodeid;
 
 	inode = fuse_iget_backing(dir->i_sb, target_nodeid, backing_inode);
+	if (!inode)
+		return -EIO;
 
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+	error = fuse_handle_bpf_ops(fbe, dir, &get_fuse_inode(inode)->bpf_ops);
+	if (error) {
+		return error;
+		goto out;
+	}
 
 	get_fuse_inode(inode)->nodeid = feo->nodeid;
 
 	*out = d_splice_alias(inode, entry);
+	if (!IS_ERR(*out))
+		inode = NULL;
+out:
+	iput(inode);
 	return 0;
 }
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 08f93a981665..f5ab3b79b3cc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -10,6 +10,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/filter.h>
 #include <linux/fs_context.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
@@ -202,6 +203,7 @@ static bool backing_data_changed(struct fuse_inode *fi, struct dentry *entry,
 {
 	struct path new_backing_path;
 	struct inode *new_backing_inode;
+	struct fuse_ops *ops = NULL;
 	int err;
 	bool ret = true;
 
@@ -216,9 +218,15 @@ static bool backing_data_changed(struct fuse_inode *fi, struct dentry *entry,
 	if (err)
 		goto put_inode;
 
-	ret = (fi->backing_inode != new_backing_inode ||
-			!path_equal(&get_fuse_dentry(entry)->backing_path, &new_backing_path));
+	err = fuse_handle_bpf_ops(bpf_arg, entry->d_parent->d_inode, &ops);
+	if (err)
+		goto put_bpf;
 
+	ret = (ops != fi->bpf_ops || fi->backing_inode != new_backing_inode ||
+			!path_equal(&get_fuse_dentry(entry)->backing_path, &new_backing_path));
+put_bpf:
+	if (ops)
+		put_fuse_ops(ops);
 put_inode:
 	path_put(&new_backing_path);
 	return ret;
@@ -486,6 +494,13 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid,
 		*inode = fuse_iget_backing(sb, outarg->nodeid, backing_inode);
 		if (!*inode)
 			goto out_queue_forget;
+
+		err = fuse_handle_bpf_ops(&bpf_arg, NULL, &get_fuse_inode(*inode)->bpf_ops);
+		if (err) {
+			iput(*inode);
+			*inode = NULL;
+			goto out_put_forget;
+		}
 	} else
 #endif
 	{
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 082cfd14de53..665673d91753 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -33,6 +33,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/user_namespace.h>
+#include <linux/bpf_fuse.h>
 #include <linux/magic.h>
 
 /** Default max number of pages that can be used in a single read request */
@@ -122,6 +123,12 @@ struct fuse_inode {
 	 * If this is set, nodeid is 0.
 	 */
 	struct inode *backing_inode;
+
+	/**
+	 * fuse_ops, provides handlers to run on all operations to determine
+	 * whether to pass through or handle in place
+	 */
+	struct fuse_ops *bpf_ops;
 #endif
 
 	/** Unique ID, which identifies the inode between userspace
@@ -591,6 +598,7 @@ struct fuse_fs_context {
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
+	struct fuse_ops *root_ops;
 	struct file *root_dir;
 
 	/* DAX device, may be NULL */
@@ -1461,6 +1469,8 @@ struct fuse_bpf_entry {
 
 	enum fuse_bpf_set backing_action;
 	struct path backing_path;
+	enum fuse_bpf_set bpf_action;
+	struct fuse_ops *ops;
 	bool is_used;
 };
 
@@ -1687,6 +1697,8 @@ int fuse_file_flock_backing(struct file *file, int cmd, struct file_lock *fl);
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
 int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path);
+int fuse_handle_bpf_ops(struct fuse_bpf_entry *fbe, struct inode *parent,
+			 struct fuse_ops **ops);
 
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b4332416e23a..67d70b3c4abb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -98,6 +98,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->inval_mask = ~0;
 #ifdef CONFIG_FUSE_BPF
 	fi->backing_inode = NULL;
+	fi->bpf_ops = NULL;
 #endif
 	fi->nodeid = 0;
 	fi->nlookup = 0;
@@ -131,6 +132,10 @@ static void fuse_free_inode(struct inode *inode)
 	kfree(fi->forget);
 #ifdef CONFIG_FUSE_DAX
 	kfree(fi->dax);
+#endif
+#ifdef CONFIG_FUSE_BPF
+	if (fi->bpf_ops)
+		put_fuse_ops(fi->bpf_ops);
 #endif
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
@@ -153,10 +158,6 @@ static void fuse_evict_inode(struct inode *inode)
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode->i_state & I_DIRTY_INODE);
 
-#ifdef CONFIG_FUSE_BPF
-	iput(fi->backing_inode);
-#endif
-
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
@@ -181,6 +182,15 @@ static void fuse_evict_inode(struct inode *inode)
 	}
 }
 
+#ifdef CONFIG_FUSE_BPF
+static void fuse_destroy_inode(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	iput(fi->backing_inode);
+}
+#endif
+
 static int fuse_reconfigure(struct fs_context *fsc)
 {
 	struct super_block *sb = fsc->root->d_sb;
@@ -828,6 +838,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_BPF,
 	OPT_ROOT_DIR,
 	OPT_NO_DAEMON,
 	OPT_ERR
@@ -844,6 +855,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_string	("root_bpf",		OPT_ROOT_BPF),
 	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
 	fsparam_flag	("no_daemon",		OPT_NO_DAEMON),
 	{}
@@ -929,6 +941,18 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_ROOT_BPF:
+		if (strnlen(param->string, BPF_FUSE_NAME_MAX + 1) > BPF_FUSE_NAME_MAX) {
+			return invalfc(fsc, "root_bpf name too long. Max length is %d", BPF_FUSE_NAME_MAX);
+		}
+
+		ctx->root_ops = find_fuse_ops(param->string);
+		if (IS_ERR_OR_NULL(ctx->root_ops)) {
+			ctx->root_ops = NULL;
+			return invalfc(fsc, "Unable to find bpf program");
+		}
+		break;
+
 	case OPT_ROOT_DIR:
 		ctx->root_dir = fget(result.uint_32);
 		if (!ctx->root_dir)
@@ -954,6 +978,8 @@ static void fuse_free_fsc(struct fs_context *fsc)
 	if (ctx) {
 		if (ctx->root_dir)
 			fput(ctx->root_dir);
+		if (ctx->root_ops)
+			put_fuse_ops(ctx->root_ops);
 		kfree(ctx->subtype);
 		kfree(ctx);
 	}
@@ -1090,6 +1116,7 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
 
 static struct inode *fuse_get_root_inode(struct super_block *sb,
 					 unsigned int mode,
+					 struct fuse_ops *root_bpf_ops,
 					 struct file *backing_fd)
 {
 	struct fuse_attr attr;
@@ -1104,6 +1131,10 @@ static struct inode *fuse_get_root_inode(struct super_block *sb,
 		return NULL;
 
 #ifdef CONFIG_FUSE_BPF
+	get_fuse_inode(inode)->bpf_ops = root_bpf_ops;
+	if (root_bpf_ops)
+		get_fuse_ops(root_bpf_ops);
+
 	if (backing_fd) {
 		get_fuse_inode(inode)->backing_inode = backing_fd->f_inode;
 		ihold(backing_fd->f_inode);
@@ -1274,6 +1305,9 @@ static const struct export_operations fuse_export_operations = {
 
 static const struct super_operations fuse_super_operations = {
 	.alloc_inode    = fuse_alloc_inode,
+#ifdef CONFIG_FUSE_BPF
+	.destroy_inode	= fuse_destroy_inode,
+#endif
 	.free_inode     = fuse_free_inode,
 	.evict_inode	= fuse_evict_inode,
 	.write_inode	= fuse_write_inode,
@@ -1808,7 +1842,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->no_daemon = ctx->no_daemon;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_dir);
+	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_ops,
+				   ctx->root_dir);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
-- 
2.44.0.478.gd926399ef9-goog


