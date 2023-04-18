Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0DE6E570F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjDRBpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjDRBpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:45:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D15FD6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f8d4f1ca1so155879807b3.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782120; x=1684374120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCFXbIE/7zM5T1Zxz4s1sjI+Fr3ZActGUdsgPEik6eM=;
        b=FB1wts4EjjmXAYzwfnd2fXz7dClLikX5H2f+j5h+pJVNsx6Q6NlCRmHSItjyPUrnLv
         YKyra7iCWVEBF0LSP7pSpNJnt31Essq6CEOYUvx3a7DeB1H1zp6/AzOIMV4nIMmPQ1qh
         qMCnxSgQQEmKpoo+wUGmGbWJWaPB9mdD+g4OxND3tsdF6PhQCvPKTZ1L9qfeLvvDeRwC
         diebbFiKsuAfFKHUnGox1H1Vm8nPX77oEHMs7kh9H6yCekzNrbtTKcZMsq9SW5ZfMvTo
         tES6furCQMp++TtGvH27jawxyKvTX19Ki63HlB/d0cozAwalDTSnp6pYD+fi6iqjgBt8
         e32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782120; x=1684374120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCFXbIE/7zM5T1Zxz4s1sjI+Fr3ZActGUdsgPEik6eM=;
        b=Uj6SBekRjXCcpPG9xOqpr+sZsyMp4wiQADYGxEkz3/IN+QwLPhyZHvZaCH7JxGKUZk
         XxR5z6qnqeabh7uC+qtjnkK2FksdHv/9WsDbAkwqbeS9gfd8z+s/kw5H+tPmN80Za5/+
         wz6bbjWsvKEqwp4jAugt8zuJfMsqhphKWvk43QBYCRVlxNuYzZIJhb1t4TzrgFOXagif
         aDOjSVG3NRkbVREhqAZpZQzHwchbCiN1b2J2iZ0JNayTM82XbXevdgQzV21823QF+o4M
         VMR2n1PXnbo1T5G2LFS+DCxlFS6nBX1UFzzKYs6MO4BHwWNjOdu17VGF+hTsDghxhJ2O
         RaOg==
X-Gm-Message-State: AAQBX9fcseA2YbhJ0igmsKLdrz3N8uASwMPpk+Ub1/TI9d88XpM3V1+N
        MV0biAwkAQyZ10xAdnQ3DeKk2FX/uo0=
X-Google-Smtp-Source: AKy350bP8nkD4q8ZefsJwT0Q2ZhJNsKNBRwFjIJbXhB6OG/HhtE2gYEray13+6teD80zVxL1NhMk7TiPsY0=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:af0c:0:b0:54c:2889:7105 with SMTP id
 n12-20020a81af0c000000b0054c28897105mr10920487ywh.0.1681782120540; Mon, 17
 Apr 2023 18:42:00 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:31 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-32-drosen@google.com>
Subject: [RFC PATCH v3 31/37] fuse-bpf: Set fuse_ops at mount or lookup time
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the ability to associate a fuse_op struct_op program with
inodes in fuse. This can be done at mount time at the root level, or by
inode at lookup time.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c | 91 +++++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/dir.c     | 16 +++++++--
 fs/fuse/fuse_i.h  | 12 +++++++
 fs/fuse/inode.c   | 28 ++++++++++++++-
 4 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 898ef9e05e9d..d5ba1e334e69 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,7 @@
 
 #include "fuse_i.h"
 
+#include <linux/bpf.h>
 #include <linux/bpf_fuse.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
@@ -168,12 +169,13 @@ static void fuse_get_backing_path(struct file *file, struct path *path)
 
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
@@ -182,14 +184,14 @@ static bool has_file(int type)
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
@@ -227,6 +229,11 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
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
@@ -234,8 +241,17 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
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
@@ -252,6 +268,10 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
 		fput(file);
 	if (has_backing)
 		path_put_init(&fbe->backing_path);
+	if (has_bpf_ops) {
+		put_fuse_ops(fbe->ops);
+		fbe->ops = NULL;
+	}
 	return err;
 }
 
@@ -527,6 +547,15 @@ static int fuse_create_open_backing(struct bpf_fuse_args *fa, int *out,
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
@@ -1842,6 +1871,52 @@ int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path)
 	return 0;
 }
 
+int fuse_handle_bpf_ops(struct fuse_bpf_entry *fbe, struct inode *parent,
+			 struct fuse_ops **ops)
+{
+	struct fuse_ops *new_ops;
+
+	/* Parent isn't presented, but we want to keep
+	 * Don't touch bpf program at all in this case
+	 */
+	if (fbe->bpf_action == FUSE_BPF_UNCHANGED && !parent)
+		return 0;
+
+	switch (fbe->bpf_action) {
+	case FUSE_BPF_UNCHANGED: {
+		struct fuse_inode *pi = get_fuse_inode(parent);
+
+		new_ops = pi->bpf_ops;
+		if (new_ops && !get_fuse_ops(new_ops))
+			return -EINVAL;
+		break;
+	}
+
+	case FUSE_BPF_REMOVE:
+		new_ops = NULL;
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
+		put_fuse_ops(new_ops);
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
@@ -1879,6 +1954,10 @@ static int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	error = fuse_handle_bpf_ops(fbe, dir, &get_fuse_inode(inode)->bpf_ops);
+	if (error)
+		return error;
+
 	get_fuse_inode(inode)->nodeid = feo->nodeid;
 
 	*out = d_splice_alias(inode, entry);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d1c3b2bfb0b1..b7bc8260a537 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -10,6 +10,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/filter.h>
 #include <linux/fs_context.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
@@ -185,6 +186,7 @@ static bool backing_data_changed(struct fuse_inode *fi, struct dentry *entry,
 {
 	struct path new_backing_path;
 	struct inode *new_backing_inode;
+	struct fuse_ops *ops = NULL;
 	int err;
 	bool ret = true;
 
@@ -199,9 +201,15 @@ static bool backing_data_changed(struct fuse_inode *fi, struct dentry *entry,
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
@@ -466,6 +474,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid,
 		*inode = fuse_iget_backing(sb, outarg->nodeid, backing_inode);
 		if (!*inode)
 			goto out_queue_forget;
+
+		err = fuse_handle_bpf_ops(&bpf_arg, NULL, &get_fuse_inode(*inode)->bpf_ops);
+		if (err)
+			goto out;
 	} else
 #endif
 	{
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 84c591d02e43..15962ab3b381 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -33,6 +33,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/user_namespace.h>
+#include <linux/bpf_fuse.h>
 #include <linux/magic.h>
 
 /** Default max number of pages that can be used in a single read request */
@@ -109,6 +110,12 @@ struct fuse_inode {
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
@@ -571,6 +578,7 @@ struct fuse_fs_context {
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
+	struct fuse_ops *root_ops;
 	struct file *root_dir;
 
 	/* DAX device, may be NULL */
@@ -1428,6 +1436,8 @@ struct fuse_bpf_entry {
 
 	enum fuse_bpf_set backing_action;
 	struct path backing_path;
+	enum fuse_bpf_set bpf_action;
+	struct fuse_ops *ops;
 	bool is_used;
 };
 
@@ -1651,6 +1661,8 @@ static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
 int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path);
+int fuse_handle_bpf_ops(struct fuse_bpf_entry *fbe, struct inode *parent,
+			 struct fuse_ops **ops);
 
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 31f34962bc9b..7fd79efbdac1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -80,6 +80,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->inval_mask = 0;
 #ifdef CONFIG_FUSE_BPF
 	fi->backing_inode = NULL;
+	fi->bpf_ops = NULL;
 #endif
 	fi->nodeid = 0;
 	fi->nlookup = 0;
@@ -125,6 +126,9 @@ static void fuse_evict_inode(struct inode *inode)
 
 #ifdef CONFIG_FUSE_BPF
 	iput(fi->backing_inode);
+	if (fi->bpf_ops)
+		put_fuse_ops(fi->bpf_ops);
+	fi->bpf_ops = NULL;
 #endif
 
 	truncate_inode_pages_final(&inode->i_data);
@@ -755,6 +759,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_BPF,
 	OPT_ROOT_DIR,
 	OPT_NO_DAEMON,
 	OPT_ERR
@@ -771,6 +776,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_string	("root_bpf",		OPT_ROOT_BPF),
 	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
 	fsparam_flag	("no_daemon",		OPT_NO_DAEMON),
 	{}
@@ -856,6 +862,18 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
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
@@ -881,6 +899,8 @@ static void fuse_free_fsc(struct fs_context *fsc)
 	if (ctx) {
 		if (ctx->root_dir)
 			fput(ctx->root_dir);
+		if (ctx->root_ops)
+			put_fuse_ops(ctx->root_ops);
 		kfree(ctx->subtype);
 		kfree(ctx);
 	}
@@ -1010,6 +1030,7 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
 
 static struct inode *fuse_get_root_inode(struct super_block *sb,
 					 unsigned int mode,
+					 struct fuse_ops *root_bpf_ops,
 					 struct file *backing_fd)
 {
 	struct fuse_attr attr;
@@ -1024,6 +1045,10 @@ static struct inode *fuse_get_root_inode(struct super_block *sb,
 		return NULL;
 
 #ifdef CONFIG_FUSE_BPF
+	get_fuse_inode(inode)->bpf_ops = root_bpf_ops;
+	if (root_bpf_ops)
+		get_fuse_ops(root_bpf_ops);
+
 	if (backing_fd) {
 		get_fuse_inode(inode)->backing_inode = backing_fd->f_inode;
 		ihold(backing_fd->f_inode);
@@ -1704,7 +1729,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->no_daemon = ctx->no_daemon;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_dir);
+	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_ops,
+				   ctx->root_dir);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
-- 
2.40.0.634.g4ca3ef3211-goog

