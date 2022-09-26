Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71525EB57B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiIZXTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiIZXTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA268B6553
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349e90aa547so75174487b3.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=YYuobu/TgW52IZroqq3nTyq/vRWQ/QlYYJf8d0XlfiA=;
        b=UINnGAXvEoPOM6Omk6xdWY/hXQvXZ6J6r6kz9giq59GUp44hvbLAzPAxT92ZOwUmb7
         ee2pm5LZMXOEe3ncyxIRHdKxkqUa4VYmObxHcCEvaVqJc3317mxEcK+gRZXiU7WuOPtM
         QZKT50SszWrm48do9r45Nt9dSkADbg2XUXwwUjj/2/yqfzGboQj35nEginBDtsxw2R0p
         KqmY8Q72lsEieP75OnxgawX/KlaYKlUKiiPFPTm3aSZ5p0f38s4ckhktSqEF+7aoPVxK
         dkCLL4UcSJXE8nFrSt5NKQWzsorCyFoDQkEdybPSKvxVtN9ESs5ix+76e9F7Uwph+RmO
         CxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=YYuobu/TgW52IZroqq3nTyq/vRWQ/QlYYJf8d0XlfiA=;
        b=3k2cMsBrqtixF8H/tyPkNjFR2CfQDgagw5fhRCvA5Ijr766aIrQvGihV2Br/QoGeqa
         JB7xdAy8V2pYSP4D7EsGRp8049vahYn8Lr/R3EAcG3Ta50osfF0bzK+4D4J9063Ib9Xa
         ohY7tqgkTfFmo4MVnxjQvB34Fip2hU1PP09R8/ZQLa+Egzzx31PNz0JvT7WQ2IvTS2jg
         WMQ8sde6EwGhISq5pEyr960Y3bYQJubxUJju7+yfyqORmfr1npRheXlLpCxP3VlW9blC
         RP5aKBoZOy+hcDEQ/hXLK1pVQl+XOZaFPI4XHaUp2RmeKWXu/YIJUTjeHHz4CPLqA/aY
         plIw==
X-Gm-Message-State: ACrzQf0vFuJ81O4xwAtNgVsuz4HJ24UaLTCu+mBuqWNel97toxsgQOBB
        OvORyCbdoqdRYGEmtzVQp7xF8EtrAb0=
X-Google-Smtp-Source: AMsMyM6cAMOksrYHFuhvrUZA8Pi6u3OxqPVrTCEVL4TtmUL2eLVtFZLMWm4mYBm1aXfBn44nCMiIx2NFnjM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:3c46:0:b0:6bc:796:d275 with SMTP id
 j67-20020a253c46000000b006bc0796d275mr2466129yba.28.1664234330505; Mon, 26
 Sep 2022 16:18:50 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:04 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-9-drosen@google.com>
Subject: [PATCH 08/26] fuse: Add fuse-bpf, a stacked fs extension for FUSE
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fuse-bpf provides a short circuit path for Fuse implementations that act
as a stacked filesystem. For cases that are directly unchanged,
operations are passed directly to the backing filesystem. Small
adjustments can be handled by bpf prefilters or postfilters, with the
option to fall back to userspace as needed.

Fuse implementations may supply backing node information, as well as bpf
programs via an optional add on to the lookup structure.

This has been split over the next set of patches for readability.
Clusters of fuse ops have been split into their own patches, as well as
the actual bpf calls and userspace calls for filters.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
Signed-off-by: Alessio Balsini <balsini@google.com>
---
 fs/fuse/Kconfig          |  10 ++
 fs/fuse/Makefile         |   1 +
 fs/fuse/backing.c        | 328 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c            |  31 +++-
 fs/fuse/dir.c            | 218 +++++++++++++++++++++-----
 fs/fuse/file.c           |  25 ++-
 fs/fuse/fuse_i.h         | 185 +++++++++++++++++++++-
 fs/fuse/inode.c          | 178 ++++++++++++++++++---
 fs/fuse/ioctl.c          |   2 +-
 include/linux/bpf_fuse.h |   1 +
 10 files changed, 913 insertions(+), 66 deletions(-)
 create mode 100644 fs/fuse/backing.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 038ed0b9aaa5..e4fba7e60d03 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -52,3 +52,13 @@ config FUSE_DAX
 
 	  If you want to allow mounting a Virtio Filesystem with the "dax"
 	  option, answer Y.
+
+config FUSE_BPF
+	bool "Adds BPF to fuse"
+	depends on FUSE_FS
+	depends on BPF
+	help
+	  Extends FUSE by adding BPF to prefilter calls and potentially pass to a
+	  backing file system
+
+	  If you want to use FUSE as a stacked filesystem with bpf, answer Y
\ No newline at end of file
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 0c48b35c058d..a0853c439db2 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
+fuse-$(CONFIG_FUSE_BPF) += backing.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
new file mode 100644
index 000000000000..51088701e7ad
--- /dev/null
+++ b/fs/fuse/backing.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE-BPF: Filesystem in Userspace with BPF
+ * Copyright (c) 2021 Google LLC
+ */
+
+#include "fuse_i.h"
+
+#include <linux/fdtable.h>
+#include <linux/filter.h>
+#include <linux/fs_stack.h>
+#include <linux/namei.h>
+#include <linux/bpf_fuse.h>
+
+struct bpf_prog *fuse_get_bpf_prog(struct file *file)
+{
+	struct bpf_prog *bpf_prog = ERR_PTR(-EINVAL);
+
+	if (!file || IS_ERR(file))
+		return bpf_prog;
+
+	if (file->f_op != &bpf_prog_fops)
+		return bpf_prog;
+
+	bpf_prog = file->private_data;
+	if (bpf_prog->type == BPF_PROG_TYPE_FUSE)
+		bpf_prog_inc(bpf_prog);
+	else
+		bpf_prog = ERR_PTR(-EINVAL);
+
+	return bpf_prog;
+}
+
+void fuse_get_backing_path(struct file *file, struct path *path)
+{
+	path_get(&file->f_path);
+	*path = file->f_path;
+}
+
+int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb)
+{
+	struct fuse_entry_bpf_out *febo = &feb->out;
+	struct bpf_prog *bpf;
+	struct file *file;
+	int err = 0;
+
+	if (febo->backing_action == FUSE_ACTION_REPLACE) {
+		file = fget(febo->backing_fd);
+		if (!file) {
+			err = -EBADF;
+			goto out_err;
+		}
+		fuse_get_backing_path(file, &feb->backing_path);
+		fput(file);
+	}
+	if (febo->bpf_action == FUSE_ACTION_REPLACE) {
+		file = fget(febo->bpf_fd);
+		if (!file) {
+			err = -EBADF;
+			goto out_put;
+		}
+		bpf = fuse_get_bpf_prog(file);
+		if (IS_ERR(bpf)) {
+			err = PTR_ERR(bpf);
+			goto out_fput;
+		}
+		feb->bpf = bpf;
+		fput(file);
+	}
+
+	return 0;
+out_fput:
+	fput(file);
+out_put:
+	path_put_init(&feb->backing_path);
+out_err:
+	return err;
+}
+
+/*******************************************************************************
+ * Directory operations after here                                             *
+ ******************************************************************************/
+
+int fuse_lookup_initialize_in(struct bpf_fuse_args *fa, struct fuse_lookup_io *fli,
+			      struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(dir)->nodeid,
+		.opcode = FUSE_LOOKUP,
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = entry->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_lookup_initialize_out(struct bpf_fuse_args *fa, struct fuse_lookup_io *fli,
+			       struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	fa->out_numargs = 2;
+	fa->flags = FUSE_BPF_OUT_ARGVAR | FUSE_BPF_IS_LOOKUP;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(fli->feo),
+		.value = &fli->feo,
+	};
+	fa->out_args[1] = (struct bpf_fuse_arg) {
+		.size = sizeof(fli->feb.out),
+		.value = &fli->feb.out,
+	};
+
+	return 0;
+}
+
+int fuse_lookup_backing(struct bpf_fuse_args *fa, struct dentry **out, struct inode *dir,
+			struct dentry *entry, unsigned int flags)
+{
+	struct fuse_dentry *fuse_entry = get_fuse_dentry(entry);
+	struct fuse_dentry *dir_fuse_entry = get_fuse_dentry(entry->d_parent);
+	struct dentry *dir_backing_entry = dir_fuse_entry->backing_path.dentry;
+	struct inode *dir_backing_inode = dir_backing_entry->d_inode;
+	struct dentry *backing_entry;
+	const char *name;
+	int len;
+
+	/* TODO this will not handle lookups over mount points */
+	inode_lock_nested(dir_backing_inode, I_MUTEX_PARENT);
+	if (fa->in_args[0].flags & BPF_FUSE_MODIFIED) {
+		name = (char *)fa->in_args[0].value;
+		len = strnlen(name, fa->in_args[0].size);
+	} else {
+		name = entry->d_name.name;
+		len = entry->d_name.len;
+	}
+	backing_entry = lookup_one_len(name, dir_backing_entry, len);
+	inode_unlock(dir_backing_inode);
+
+	if (IS_ERR(backing_entry))
+		return PTR_ERR(backing_entry);
+
+	fuse_entry->backing_path = (struct path) {
+		.dentry = backing_entry,
+		.mnt = dir_fuse_entry->backing_path.mnt,
+	};
+
+	mntget(fuse_entry->backing_path.mnt);
+	return 0;
+}
+
+int fuse_handle_backing(struct fuse_entry_bpf *feb, struct path *backing_path)
+{
+	switch (feb->out.backing_action) {
+	case FUSE_ACTION_KEEP:
+		/* backing inode/path are added in fuse_lookup_backing */
+		break;
+
+	case FUSE_ACTION_REMOVE:
+		path_put_init(backing_path);
+		break;
+
+	case FUSE_ACTION_REPLACE: {
+		if (!feb->backing_path.dentry)
+			return -EINVAL;
+
+		path_put(backing_path);
+		*backing_path = feb->backing_path;
+		feb->backing_path.dentry = NULL;
+		feb->backing_path.mnt = NULL;
+
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int fuse_handle_bpf_prog(struct fuse_entry_bpf *feb, struct inode *parent,
+			 struct bpf_prog **bpf)
+{
+	struct fuse_inode *pi;
+
+	// Parent isn't presented, but we want to keep
+	// Don't touch bpf program at all in this case
+	if (feb->out.bpf_action == FUSE_ACTION_KEEP && !parent)
+		goto out;
+
+	if (*bpf) {
+		bpf_prog_put(*bpf);
+		*bpf = NULL;
+	}
+
+	switch (feb->out.bpf_action) {
+	case FUSE_ACTION_KEEP:
+		pi = get_fuse_inode(parent);
+		*bpf = pi->bpf;
+		if (*bpf)
+			bpf_prog_inc(*bpf);
+		break;
+
+	case FUSE_ACTION_REMOVE:
+		break;
+
+	case FUSE_ACTION_REPLACE: {
+		struct bpf_prog *bpf_prog = feb->bpf;
+
+		if (IS_ERR(bpf_prog))
+			return PTR_ERR(bpf_prog);
+
+		*bpf = bpf_prog;
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
+
+out:
+	return 0;
+}
+
+int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
+			 struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	struct fuse_dentry *fd;
+	struct dentry *backing_dentry;
+	struct inode *inode, *backing_inode;
+	struct inode *d_inode = entry->d_inode;
+	struct fuse_entry_out *feo = fa->out_args[0].value;
+	struct fuse_entry_bpf_out *febo = fa->out_args[1].value;
+	struct fuse_entry_bpf *feb = container_of(febo, struct fuse_entry_bpf, out);
+	int error = -1;
+	u64 target_nodeid = 0;
+
+	fd = get_fuse_dentry(entry);
+	if (!fd)
+		return -EIO;
+	error = fuse_handle_backing(feb, &fd->backing_path);
+	if (error)
+		return error;
+	backing_dentry = fd->backing_path.dentry;
+	if (!backing_dentry)
+		return -ENOENT;
+	backing_inode = backing_dentry->d_inode;
+	if (!backing_inode) {
+		*out = 0;
+		return 0;
+	}
+
+	if (d_inode)
+		target_nodeid = get_fuse_inode(d_inode)->nodeid;
+
+	inode = fuse_iget_backing(dir->i_sb, target_nodeid, backing_inode);
+
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	error = fuse_handle_bpf_prog(feb, dir, &get_fuse_inode(inode)->bpf);
+	if (error)
+		return error;
+
+	get_fuse_inode(inode)->nodeid = feo->nodeid;
+
+	*out = d_splice_alias(inode, entry);
+	return 0;
+}
+
+int fuse_revalidate_backing(struct dentry *entry, unsigned int flags)
+{
+	struct fuse_dentry *fuse_dentry = get_fuse_dentry(entry);
+	struct dentry *backing_entry = fuse_dentry->backing_path.dentry;
+
+	spin_lock(&backing_entry->d_lock);
+	if (d_unhashed(backing_entry)) {
+		spin_unlock(&backing_entry->d_lock);
+		return 0;
+	}
+	spin_unlock(&backing_entry->d_lock);
+
+	if (unlikely(backing_entry->d_flags & DCACHE_OP_REVALIDATE))
+		return backing_entry->d_op->d_revalidate(backing_entry, flags);
+	return 1;
+}
+
+int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
+			      struct inode *inode, int mask)
+{
+	*fai = (struct fuse_access_in) {
+		.mask = mask,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.opcode = FUSE_ACCESS,
+		.nodeid = get_node_id(inode),
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*fai),
+		.in_args[0].value = fai,
+	};
+
+	return 0;
+}
+
+int fuse_access_initialize_out(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
+			       struct inode *inode, int mask)
+{
+	return 0;
+}
+
+int fuse_access_backing(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	const struct fuse_access_in *fai = fa->in_args[0].value;
+
+	*out = inode_permission(&init_user_ns, fi->backing_inode, fai->mask);
+	return 0;
+}
+
+int fuse_access_finalize(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
+{
+	return 0;
+}
+
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51897427a534..626dbbf92874 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -238,6 +238,11 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	if (nodeid == 0) {
+		kfree(forget);
+		return;
+	}
+
 	forget->forget_one.nodeid = nodeid;
 	forget->forget_one.nlookup = nlookup;
 
@@ -475,6 +480,7 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 {
 	req->in.h.opcode = args->opcode;
 	req->in.h.nodeid = args->nodeid;
+	req->in.h.error_in = args->error_in;
 	req->args = args;
 	if (args->end)
 		__set_bit(FR_ASYNC, &req->flags);
@@ -1005,10 +1011,27 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 	return 0;
 }
 
+/* Copy the fuse-bpf lookup args and verify them */
+static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+{
+	struct fuse_entry_bpf_out *febo = (struct fuse_entry_bpf_out *)val;
+	struct fuse_entry_bpf *feb = container_of(febo, struct fuse_entry_bpf, out);
+	int err;
+
+	if (size && size != sizeof(*febo))
+		return -EINVAL;
+	err = fuse_copy_one(cs, val, size);
+	if (err)
+		return err;
+	if (size)
+		err = parse_fuse_entry_bpf(feb);
+	return err;
+}
+
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing)
+			  int zeroing, unsigned is_lookup)
 {
 	int err = 0;
 	unsigned i;
@@ -1017,6 +1040,8 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 		struct fuse_arg *arg = &args[i];
 		if (i == numargs - 1 && argpages)
 			err = fuse_copy_pages(cs, arg->size, zeroing);
+		else if (i == numargs - 1 && is_lookup)
+			err = fuse_copy_lookup(cs, arg->value, arg->size);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1294,7 +1319,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	err = fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
 	if (!err)
 		err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
-				     (struct fuse_arg *) args->in_args, 0);
+				     (struct fuse_arg *) args->in_args, 0, 0);
 	fuse_copy_finish(cs);
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
@@ -1833,7 +1858,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		lastarg->size -= diffsize;
 	}
 	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
-			      args->out_args, args->page_zeroing);
+			      args->out_args, args->page_zeroing, args->is_lookup);
 }
 
 /*
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 74e13af039f1..daaf3576fab9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -10,6 +10,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/filter.h>
 #include <linux/fs_context.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
@@ -34,7 +35,7 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
-#if BITS_PER_LONG >= 64
+#if BITS_PER_LONG >= 64 && !defined(CONFIG_FUSE_BPF)
 static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
 {
 	entry->d_fsdata = (void *) time;
@@ -49,12 +50,12 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 
 static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
-	((union fuse_dentry *) dentry->d_fsdata)->time = time;
+	((struct fuse_dentry *) dentry->d_fsdata)->time = time;
 }
 
 static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
-	return ((union fuse_dentry *) entry->d_fsdata)->time;
+	return ((struct fuse_dentry *) entry->d_fsdata)->time;
 }
 #endif
 
@@ -79,6 +80,17 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	__fuse_dentry_settime(dentry, time);
 }
 
+void fuse_init_dentry_root(struct dentry *root, struct file *backing_dir)
+{
+#ifdef CONFIG_FUSE_BPF
+	struct fuse_dentry *fuse_dentry = root->d_fsdata;
+
+	if (backing_dir) {
+		fuse_dentry->backing_path = backing_dir->f_path;
+		path_get(&fuse_dentry->backing_path);
+	}
+#endif
+}
 
 /*
  * Set dentry and possibly attribute timeouts from the lookup/mk*
@@ -150,7 +162,8 @@ static void fuse_invalidate_entry(struct dentry *entry)
 
 static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 			     u64 nodeid, const struct qstr *name,
-			     struct fuse_entry_out *outarg)
+			     struct fuse_entry_out *outarg,
+			     struct fuse_entry_bpf_out *bpf_outarg)
 {
 	memset(outarg, 0, sizeof(struct fuse_entry_out));
 	args->opcode = FUSE_LOOKUP;
@@ -158,11 +171,51 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->in_numargs = 1;
 	args->in_args[0].size = name->len + 1;
 	args->in_args[0].value = name->name;
-	args->out_numargs = 1;
+	args->out_argvar = true;
+	args->out_numargs = 2;
 	args->out_args[0].size = sizeof(struct fuse_entry_out);
 	args->out_args[0].value = outarg;
+	args->out_args[1].size = sizeof(struct fuse_entry_bpf_out);
+	args->out_args[1].value = bpf_outarg;
+	args->is_lookup = 1;
 }
 
+#ifdef CONFIG_FUSE_BPF
+static bool backing_data_changed(struct fuse_inode *fi, struct dentry *entry,
+				 struct fuse_entry_bpf *bpf_arg)
+{
+	struct path new_backing_path;
+	struct inode *new_backing_inode;
+	struct bpf_prog *bpf = NULL;
+	int err;
+	bool ret = true;
+
+	if (!entry)
+		return false;
+
+	get_fuse_backing_path(entry, &new_backing_path);
+
+	err = fuse_handle_backing(bpf_arg, &new_backing_path);
+	new_backing_inode = d_inode(new_backing_path.dentry);
+
+	if (err)
+		goto put_inode;
+
+	err = fuse_handle_bpf_prog(bpf_arg, entry->d_parent->d_inode, &bpf);
+	if (err)
+		goto put_bpf;
+
+	ret = (bpf != fi->bpf || fi->backing_inode != new_backing_inode ||
+			!path_equal(&get_fuse_dentry(entry)->backing_path, &new_backing_path));
+put_bpf:
+	if (bpf)
+		bpf_prog_put(bpf);
+put_inode:
+	path_put(&new_backing_path);
+	return ret;
+}
+#endif
+
 /*
  * Check whether the dentry is still valid
  *
@@ -183,9 +236,23 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	inode = d_inode_rcu(entry);
 	if (inode && fuse_is_bad(inode))
 		goto invalid;
-	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
+
+#ifdef CONFIG_FUSE_BPF
+	/* TODO: Do we need bpf support for revalidate?
+	 * If the lower filesystem says the entry is invalid, FUSE probably shouldn't
+	 * try to fix that without going through the normal lookup path...
+	 */
+	if (get_fuse_dentry(entry)->backing_path.dentry) {
+		ret = fuse_revalidate_backing(entry, flags);
+		if (ret <= 0) {
+			goto out;
+		}
+	}
+#endif
+	if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL))) {
 		struct fuse_entry_out outarg;
+		struct fuse_entry_bpf bpf_arg;
 		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
 		u64 attr_version;
@@ -197,27 +264,44 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		ret = -ECHILD;
 		if (flags & LOOKUP_RCU)
 			goto out;
-
 		fm = get_fuse_mount(inode);
 
+		parent = dget_parent(entry);
+
+#ifdef CONFIG_FUSE_BPF
+		/* TODO: Once we're handling timeouts for backing inodes, do a
+		 * bpf based lookup_revalidate here.
+		 */
+		if (get_fuse_inode(parent->d_inode)->backing_inode) {
+			dput(parent);
+			ret = 1;
+			goto out;
+		}
+#endif
 		forget = fuse_alloc_forget();
 		ret = -ENOMEM;
-		if (!forget)
+		if (!forget) {
+			dput(parent);
 			goto out;
+		}
 
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		parent = dget_parent(entry);
 		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
-				 &entry->d_name, &outarg);
+				 &entry->d_name, &outarg, &bpf_arg.out);
 		ret = fuse_simple_request(fm, &args);
 		dput(parent);
+
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
 			ret = -ENOENT;
-		if (!ret) {
+		if (!ret || ret == sizeof(bpf_arg.out)) {
 			fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode) ||
+#ifdef CONFIG_FUSE_BPF
+			    (ret == sizeof(bpf_arg.out) &&
+					    backing_data_changed(fi, entry, &bpf_arg)) ||
+#endif
 			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
 						  outarg.nodeid, 1);
@@ -259,17 +343,20 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	goto out;
 }
 
-#if BITS_PER_LONG < 64
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_BPF)
 static int fuse_dentry_init(struct dentry *dentry)
 {
-	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
+	dentry->d_fsdata = kzalloc(sizeof(struct fuse_dentry),
 				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 
 	return dentry->d_fsdata ? 0 : -ENOMEM;
 }
 static void fuse_dentry_release(struct dentry *dentry)
 {
-	union fuse_dentry *fd = dentry->d_fsdata;
+	struct fuse_dentry *fd = dentry->d_fsdata;
+
+	if (fd && fd->backing_path.dentry)
+		path_put(&fd->backing_path);
 
 	kfree_rcu(fd, rcu);
 }
@@ -310,7 +397,7 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 	.d_delete	= fuse_dentry_delete,
-#if BITS_PER_LONG < 64
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_BPF)
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 #endif
@@ -318,7 +405,7 @@ const struct dentry_operations fuse_dentry_operations = {
 };
 
 const struct dentry_operations fuse_root_dentry_operations = {
-#if BITS_PER_LONG < 64
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_BPF)
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 #endif
@@ -336,11 +423,13 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
 		attr->size > LLONG_MAX;
 }
 
-int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode)
+int fuse_lookup_name(struct super_block *sb, u64 nodeid,
+		     const struct qstr *name, struct fuse_entry_out *outarg,
+		     struct dentry *entry, struct inode **inode)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
+	struct fuse_entry_bpf bpf_arg = { 0 };
 	struct fuse_forget_link *forget;
 	u64 attr_version;
 	int err;
@@ -358,23 +447,60 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 
 	attr_version = fuse_get_attr_version(fm->fc);
 
-	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
+	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg, &bpf_arg.out);
 	err = fuse_simple_request(fm, &args);
-	/* Zero nodeid is same as -ENOENT, but with valid timeout */
-	if (err || !outarg->nodeid)
-		goto out_put_forget;
 
-	err = -EIO;
-	if (!outarg->nodeid)
-		goto out_put_forget;
-	if (fuse_invalid_attr(&outarg->attr))
-		goto out_put_forget;
-
-	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
-			   &outarg->attr, entry_attr_timeout(outarg),
-			   attr_version);
+#ifdef CONFIG_FUSE_BPF
+	if (err == sizeof(bpf_arg.out)) {
+		/* TODO Make sure this handles invalid handles */
+		struct path *backing_path;
+		struct inode *backing_inode;
+
+		err = -ENOENT;
+		if (!entry)
+			goto out_queue_forget;
+
+		err = -EINVAL;
+		backing_path = &bpf_arg.backing_path;
+		if (!backing_path->dentry)
+			goto out_queue_forget;
+
+		err = fuse_handle_backing(&bpf_arg,
+				&get_fuse_dentry(entry)->backing_path);
+		if (err)
+			goto out_queue_forget;
+
+		backing_inode = d_inode(get_fuse_dentry(entry)->backing_path.dentry);
+		*inode = fuse_iget_backing(sb, outarg->nodeid, backing_inode);
+		if (!*inode)
+			goto out_queue_forget;
+
+		err = fuse_handle_bpf_prog(&bpf_arg, NULL, &get_fuse_inode(*inode)->bpf);
+		if (err)
+			goto out;
+	} else
+#endif
+	{
+		/* Zero nodeid is same as -ENOENT, but with valid timeout */
+		if (err || !outarg->nodeid)
+			goto out_put_forget;
+
+		err = -EIO;
+		if (!outarg->nodeid)
+			goto out_put_forget;
+		if (fuse_invalid_attr(&outarg->attr))
+			goto out_put_forget;
+
+		*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
+				   &outarg->attr, entry_attr_timeout(outarg),
+				   attr_version);
+	}
+
 	err = -ENOMEM;
-	if (!*inode) {
+#ifdef CONFIG_FUSE_BPF
+out_queue_forget:
+#endif
+	if (!*inode && outarg->nodeid) {
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
 		goto out;
 	}
@@ -396,12 +522,20 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	bool outarg_valid = true;
 	bool locked;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(dir, struct fuse_lookup_io, newent,
+			       fuse_lookup_initialize_in, fuse_lookup_initialize_out,
+			       fuse_lookup_backing, fuse_lookup_finalize,
+			       dir, entry, flags))
+		return newent;
+#endif
+
 	if (fuse_is_bad(dir))
 		return ERR_PTR(-EIO);
 
 	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
-			       &outarg, &inode);
+			       &outarg, entry, &inode);
 	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT) {
 		outarg_valid = false;
@@ -1230,6 +1364,13 @@ static int fuse_access(struct inode *inode, int mask)
 	struct fuse_access_in inarg;
 	int err;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_access_in, err,
+			       fuse_access_initialize_in, fuse_access_initialize_out,
+			       fuse_access_backing, fuse_access_finalize, inode, mask))
+		return err;
+#endif
+
 	BUG_ON(mask & MAY_NOT_BLOCK);
 
 	if (fm->fc->no_access)
@@ -1278,6 +1419,7 @@ static int fuse_permission(struct user_namespace *mnt_userns,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	bool refreshed = false;
 	int err = 0;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1285,12 +1427,18 @@ static int fuse_permission(struct user_namespace *mnt_userns,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_access_in, err,
+			       fuse_access_initialize_in, fuse_access_initialize_out,
+			       fuse_access_backing, fuse_access_finalize, inode, mask))
+		return err;
+#endif
+
 	/*
 	 * If attributes are needed, refresh them before proceeding
 	 */
 	if (fc->default_permissions ||
 	    ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
 		u32 perm_mask = STATX_MODE | STATX_UID | STATX_GID;
 
 		if (perm_mask & READ_ONCE(fi->inval_mask) ||
@@ -1467,7 +1615,7 @@ static long fuse_dir_compat_ioctl(struct file *file, unsigned int cmd,
 				 FUSE_IOCTL_COMPAT | FUSE_IOCTL_DIR);
 }
 
-static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
+static inline bool update_mtime(unsigned int ivalid, bool trust_local_mtime)
 {
 	/* Always update if mtime is explicitly set  */
 	if (ivalid & ATTR_MTIME_SET)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1a3afd469e3a..4fa2ebc068f0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 
+#include <linux/filter.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -125,13 +126,18 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 }
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				 unsigned int open_flags, bool isdir, struct file *file)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
 
-	ff = fuse_file_alloc(fm);
+	if (file && file->private_data) {
+		ff = file->private_data;
+		file->private_data = NULL;
+	} else {
+		ff = fuse_file_alloc(fm);
+	}
 	if (!ff)
 		return ERR_PTR(-ENOMEM);
 
@@ -169,7 +175,7 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir, file);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
@@ -1873,6 +1879,19 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 */
 	WARN_ON(wbc->for_reclaim);
 
+	/**
+	 * TODO - fully understand why this is necessary
+	 *
+	 * With fuse-bpf, fsstress fails if rename is enabled without this
+	 *
+	 * We are getting writes here on directory inodes, which do not have an
+	 * initialized file list so crash.
+	 *
+	 * The question is why we are getting those writes
+	 */
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 054b96c3e061..30ddc298fb27 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -13,9 +13,12 @@
 # define pr_fmt(fmt) "fuse: " fmt
 #endif
 
+#include <linux/filter.h>
 #include <linux/fuse.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/statfs.h>
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -31,6 +34,8 @@
 #include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/user_namespace.h>
+#include <linux/bpf_fuse.h>
+#include <linux/magic.h>
 
 /** Default max number of pages that can be used in a single read request */
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
@@ -64,11 +69,35 @@ struct fuse_forget_link {
 };
 
 /** FUSE specific dentry data */
-#if BITS_PER_LONG < 64
-union fuse_dentry {
-	u64 time;
-	struct rcu_head rcu;
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_BPF)
+struct fuse_dentry {
+	union {
+		u64 time;
+		struct rcu_head rcu;
+	};
+	struct path backing_path;
 };
+
+static inline struct fuse_dentry *get_fuse_dentry(const struct dentry *entry)
+{
+	return entry->d_fsdata;
+}
+#endif
+
+#ifdef CONFIG_FUSE_BPF
+static inline void get_fuse_backing_path(const struct dentry *d,
+					  struct path *path)
+{
+	struct fuse_dentry *di = get_fuse_dentry(d);
+
+	if (!di) {
+		*path = (struct path) { .mnt = 0, .dentry = 0 };
+		return;
+	}
+
+	*path = di->backing_path;
+	path_get(path);
+}
 #endif
 
 /** FUSE inode */
@@ -76,6 +105,20 @@ struct fuse_inode {
 	/** Inode data */
 	struct inode inode;
 
+#ifdef CONFIG_FUSE_BPF
+	/**
+	 * Backing inode, if this inode is from a backing file system.
+	 * If this is set, nodeid is 0.
+	 */
+	struct inode *backing_inode;
+
+	/**
+	 * bpf_prog, run on all operations to determine whether to pass through
+	 * or handle in place
+	 */
+	struct bpf_prog *bpf;
+#endif
+
 	/** Unique ID, which identifies the inode between userspace
 	 * and kernel */
 	u64 nodeid;
@@ -226,6 +269,14 @@ struct fuse_file {
 
 	} readdir;
 
+#ifdef CONFIG_FUSE_BPF
+	/**
+	 * TODO: Reconcile with passthrough file
+	 * backing file when in bpf mode
+	 */
+	struct file *backing_file;
+#endif
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
@@ -257,6 +308,7 @@ struct fuse_page_desc {
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
+	uint32_t error_in;
 	unsigned short in_numargs;
 	unsigned short out_numargs;
 	bool force:1;
@@ -269,6 +321,7 @@ struct fuse_args {
 	bool page_zeroing:1;
 	bool page_replace:1;
 	bool may_block:1;
+	bool is_lookup:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
@@ -522,6 +575,8 @@ struct fuse_fs_context {
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
+	struct bpf_prog *root_bpf;
+	struct file *root_dir;
 
 	/* DAX device, may be NULL */
 	struct dax_device *dax_dev;
@@ -962,12 +1017,16 @@ extern const struct dentry_operations fuse_root_dentry_operations;
 /**
  * Get a filled in inode
  */
+struct inode *fuse_iget_backing(struct super_block *sb,
+				u64 nodeid,
+				struct inode *backing_inode);
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version);
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode);
+		     struct fuse_entry_out *outarg,
+		     struct dentry *entry, struct inode **inode);
 
 /**
  * Send FORGET command
@@ -1112,6 +1171,7 @@ void fuse_invalidate_entry_cache(struct dentry *entry);
 void fuse_invalidate_atime(struct inode *inode);
 
 u64 entry_attr_timeout(struct fuse_entry_out *o);
+void fuse_init_dentry_root(struct dentry *root, struct file *backing_dir);
 void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o);
 
 /**
@@ -1320,10 +1380,58 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 /* file.c */
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+				 unsigned int open_flags, bool isdir,
+				 struct file *file);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/* backing.c */
+
+struct bpf_prog *fuse_get_bpf_prog(struct file *file);
+void fuse_get_backing_path(struct file *file, struct path *path);
+
+/*
+ * Dummy io passed to fuse_bpf_backing when io operation needs no scratch space
+ */
+struct fuse_dummy_io {
+	int unused;
+};
+
+struct fuse_entry_bpf {
+	struct fuse_entry_bpf_out out;
+
+	struct path backing_path;
+	struct bpf_prog *bpf;
+};
+
+int parse_fuse_entry_bpf(struct fuse_entry_bpf *feb);
+
+struct fuse_lookup_io {
+	struct fuse_entry_out feo;
+	struct fuse_entry_bpf feb;
+};
+
+int fuse_handle_backing(struct fuse_entry_bpf *feb, struct path *backing_path);
+int fuse_handle_bpf_prog(struct fuse_entry_bpf *feb, struct inode *parent,
+			 struct bpf_prog **bpf);
+
+int fuse_lookup_initialize_in(struct bpf_fuse_args *fa, struct fuse_lookup_io *feo,
+			      struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_lookup_initialize_out(struct bpf_fuse_args *fa, struct fuse_lookup_io *feo,
+			       struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_lookup_backing(struct bpf_fuse_args *fa, struct dentry **out, struct inode *dir,
+			struct dentry *entry, unsigned int flags);
+int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
+			 struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
+
+int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
+			      struct inode *inode, int mask);
+int fuse_access_initialize_out(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
+			       struct inode *inode, int mask);
+int fuse_access_backing(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask);
+int fuse_access_finalize(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask);
+
 /*
  * FUSE caches dentries and attributes with separate timeout.  The
  * time in jiffies until the dentry/attributes are valid is stored in
@@ -1351,4 +1459,69 @@ static inline u64 attr_timeout(struct fuse_attr_out *o)
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
 }
 
+#ifdef CONFIG_FUSE_BPF
+/*
+ * expression statement to wrap the backing filter logic
+ * struct inode *inode: inode with bpf and backing inode
+ * typedef io: (typically complex) type whose components fuse_args can point to.
+ *	An instance of this type is created locally and passed to initialize
+ * void initialize_in(struct bpf_fuse_args *fa, io *in_out, args...): function that sets
+ *	up fa and io based on args
+ * void initialize_out(struct bpf_fuse_args *fa, io *in_out, args...): function that sets
+ *	up fa and io based on args
+ * int backing(struct fuse_bpf_args_internal *fa, args...): function that actually performs
+ *	the backing io operation
+ * void *finalize(struct fuse_bpf_args *, args...): function that performs any final
+ *	work needed to commit the backing io
+ */
+#define fuse_bpf_backing(inode, io, out, initialize_in, initialize_out,	\
+			 backing, finalize, args...)			\
+({									\
+	struct fuse_inode *fuse_inode = get_fuse_inode(inode);		\
+	struct bpf_fuse_args fa = { 0 };				\
+	bool initialized = false;					\
+	bool handled = false;						\
+	ssize_t res;							\
+	io feo = { 0 };							\
+	int error = 0;							\
+									\
+	do {								\
+		if (!fuse_inode || !fuse_inode->backing_inode)		\
+			break;						\
+									\
+		handled = true;						\
+		error = initialize_in(&fa, &feo, args);			\
+		if (error)						\
+			break;						\
+									\
+		error = initialize_out(&fa, &feo, args);		\
+		if (error)						\
+			break;						\
+									\
+		initialized = true;					\
+									\
+		error = backing(&fa, &out, args);			\
+		if (error < 0)						\
+			fa.error_in = error;				\
+									\
+	} while (false);						\
+									\
+	if (initialized && handled) {					\
+		res = finalize(&fa, &out, args);			\
+		if (res)						\
+			error = res;					\
+	}								\
+									\
+	out = error ? _Generic((out),					\
+			default :					\
+				error,					\
+			struct dentry * :				\
+				ERR_PTR(error),				\
+			const char * :					\
+				ERR_PTR(error)				\
+			) : (out);					\
+	handled;							\
+})
+#endif /* CONFIG_FUSE_BPF */
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 036a14e917e1..ca65199b38cb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -78,6 +78,10 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 
 	fi->i_time = 0;
 	fi->inval_mask = 0;
+#ifdef CONFIG_FUSE_BPF
+	fi->backing_inode = NULL;
+	fi->bpf = NULL;
+#endif
 	fi->nodeid = 0;
 	fi->nlookup = 0;
 	fi->attr_version = 0;
@@ -120,6 +124,13 @@ static void fuse_evict_inode(struct inode *inode)
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode->i_state & I_DIRTY_INODE);
 
+#ifdef CONFIG_FUSE_BPF
+	iput(fi->backing_inode);
+	if (fi->bpf)
+		bpf_prog_put(fi->bpf);
+	fi->bpf = NULL;
+#endif
+
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
@@ -351,28 +362,105 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		fuse_init_common(inode);
-		init_special_inode(inode, inode->i_mode,
-				   new_decode_dev(attr->rdev));
+		init_special_inode(inode, inode->i_mode, attr->rdev);
 	} else
 		BUG();
 }
 
+struct fuse_inode_identifier {
+	u64 nodeid;
+	struct inode *backing_inode;
+};
+
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
 {
-	u64 nodeid = *(u64 *) _nodeidp;
-	if (get_node_id(inode) == nodeid)
-		return 1;
-	else
-		return 0;
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return fii->nodeid == fi->nodeid;
+}
+
+static int fuse_inode_backing_eq(struct inode *inode, void *_nodeidp)
+{
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return fii->nodeid == fi->nodeid
+#ifdef CONFIG_FUSE_BPF
+		&& fii->backing_inode == fi->backing_inode
+#endif
+		;
 }
 
 static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 {
-	u64 nodeid = *(u64 *) _nodeidp;
-	get_fuse_inode(inode)->nodeid = nodeid;
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fi->nodeid = fii->nodeid;
+
+	return 0;
+}
+
+static int fuse_inode_backing_set(struct inode *inode, void *_nodeidp)
+{
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fi->nodeid = fii->nodeid;
+#ifdef CONFIG_FUSE_BPF
+	BUG_ON(fi->backing_inode != NULL);
+	fi->backing_inode = fii->backing_inode;
+	if (fi->backing_inode)
+		ihold(fi->backing_inode);
+#endif
+
 	return 0;
 }
 
+struct inode *fuse_iget_backing(struct super_block *sb, u64 nodeid,
+				struct inode *backing_inode)
+{
+	struct inode *inode;
+	struct fuse_inode *fi;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_inode_identifier fii = {
+		.nodeid = nodeid,
+		.backing_inode = backing_inode,
+	};
+	struct fuse_attr attr;
+	unsigned long hash = (unsigned long) backing_inode;
+
+	if (nodeid)
+		hash = nodeid;
+
+	fuse_fill_attr_from_inode(&attr, backing_inode);
+	inode = iget5_locked(sb, hash, fuse_inode_backing_eq,
+			     fuse_inode_backing_set, &fii);
+	if (!inode)
+		return NULL;
+
+	if ((inode->i_state & I_NEW)) {
+		inode->i_flags |= S_NOATIME;
+		if (!fc->writeback_cache)
+			inode->i_flags |= S_NOCMTIME;
+		fuse_init_common(inode);
+		unlock_new_inode(inode);
+	}
+
+	fi = get_fuse_inode(inode);
+	fuse_init_inode(inode, &attr);
+	spin_lock(&fi->lock);
+	fi->nlookup++;
+	spin_unlock(&fi->lock);
+
+	return inode;
+}
+
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version)
@@ -380,6 +468,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	struct inode *inode;
 	struct fuse_inode *fi;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_inode_identifier fii = {
+		.nodeid = nodeid,
+	};
 
 	/*
 	 * Auto mount points get their node id from the submount root, which is
@@ -401,7 +492,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	}
 
 retry:
-	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &nodeid);
+	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &fii);
 	if (!inode)
 		return NULL;
 
@@ -433,13 +524,16 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
 {
 	struct fuse_mount *fm_iter;
 	struct inode *inode;
+	struct fuse_inode_identifier fii = {
+		.nodeid = nodeid,
+	};
 
 	WARN_ON(!rwsem_is_locked(&fc->killsb));
 	list_for_each_entry(fm_iter, &fc->mounts, fc_entry) {
 		if (!fm_iter->sb)
 			continue;
 
-		inode = ilookup5(fm_iter->sb, nodeid, fuse_inode_eq, &nodeid);
+		inode = ilookup5(fm_iter->sb, nodeid, fuse_inode_eq, &fii);
 		if (inode) {
 			if (fm)
 				*fm = fm_iter;
@@ -669,6 +763,8 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_BPF,
+	OPT_ROOT_DIR,
 	OPT_ERR
 };
 
@@ -683,6 +779,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u32	("root_bpf",		OPT_ROOT_BPF),
+	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
 	{}
 };
 
@@ -766,6 +864,21 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_ROOT_BPF:
+		ctx->root_bpf = bpf_prog_get_type_dev(result.uint_32,
+						BPF_PROG_TYPE_FUSE, false);
+		if (IS_ERR(ctx->root_bpf)) {
+			ctx->root_bpf = NULL;
+			return invalfc(fsc, "Unable to open bpf program");
+		}
+		break;
+
+	case OPT_ROOT_DIR:
+		ctx->root_dir = fget(result.uint_32);
+		if (!ctx->root_dir)
+			return invalfc(fsc, "Unable to open root directory");
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -778,6 +891,10 @@ static void fuse_free_fsc(struct fs_context *fsc)
 	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	if (ctx) {
+		if (ctx->root_dir)
+			fput(ctx->root_dir);
+		if (ctx->root_bpf)
+			bpf_prog_put(ctx->root_bpf);
 		kfree(ctx->subtype);
 		kfree(ctx);
 	}
@@ -905,15 +1022,34 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_conn_get);
 
-static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned mode)
+static struct inode *fuse_get_root_inode(struct super_block *sb,
+					 unsigned int mode,
+					 struct bpf_prog *root_bpf,
+					 struct file *backing_fd)
 {
 	struct fuse_attr attr;
-	memset(&attr, 0, sizeof(attr));
+	struct inode *inode;
 
+	memset(&attr, 0, sizeof(attr));
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
 	attr.nlink = 1;
-	return fuse_iget(sb, 1, 0, &attr, 0, 0);
+	inode = fuse_iget(sb, 1, 0, &attr, 0, 0);
+	if (!inode)
+		return NULL;
+
+#ifdef CONFIG_FUSE_BPF
+	get_fuse_inode(inode)->bpf = root_bpf;
+	if (root_bpf)
+		bpf_prog_inc(root_bpf);
+
+	if (backing_fd) {
+		get_fuse_inode(inode)->backing_inode = backing_fd->f_inode;
+		ihold(backing_fd->f_inode);
+	}
+#endif
+
+	return inode;
 }
 
 struct fuse_inode_handle {
@@ -928,11 +1064,14 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 	struct inode *inode;
 	struct dentry *entry;
 	int err = -ESTALE;
+	struct fuse_inode_identifier fii = {
+		.nodeid = handle->nodeid,
+	};
 
 	if (handle->nodeid == 0)
 		goto out_err;
 
-	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
+	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &fii);
 	if (!inode) {
 		struct fuse_entry_out outarg;
 		const struct qstr name = QSTR_INIT(".", 1);
@@ -941,7 +1080,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 			goto out_err;
 
 		err = fuse_lookup_name(sb, handle->nodeid, &name, &outarg,
-				       &inode);
+				       NULL, &inode);
 		if (err && err != -ENOENT)
 			goto out_err;
 		if (err || !inode) {
@@ -1035,13 +1174,14 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	struct inode *inode;
 	struct dentry *parent;
 	struct fuse_entry_out outarg;
+	const struct qstr name = QSTR_INIT("..", 2);
 	int err;
 
 	if (!fc->export_support)
 		return ERR_PTR(-ESTALE);
 
 	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
-			       &dotdot_name, &outarg, &inode);
+			       &name, &outarg, NULL, &inode);
 	if (err) {
 		if (err == -ENOENT)
 			return ERR_PTR(-ESTALE);
@@ -1580,11 +1720,13 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->no_force_umount = ctx->no_force_umount;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, ctx->rootmode);
+	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_bpf,
+				   ctx->root_dir);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
 		goto err_dev_free;
+	fuse_init_dentry_root(root_dentry, ctx->root_dir);
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 61d8afcb10a3..8bc8d50917e2 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -422,7 +422,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir, NULL);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 91b60d4e78b1..ef5c8fdaffee 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -31,6 +31,7 @@ struct bpf_fuse_arg {
 
 #define FUSE_BPF_FORCE (1 << 0)
 #define FUSE_BPF_OUT_ARGVAR (1 << 6)
+#define FUSE_BPF_IS_LOOKUP (1 << 11)
 
 struct bpf_fuse_args {
 	uint64_t nodeid;
-- 
2.37.3.998.g577e59143f-goog

