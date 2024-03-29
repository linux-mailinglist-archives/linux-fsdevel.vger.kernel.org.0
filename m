Return-Path: <linux-fsdevel+bounces-15626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EF8910AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C59D1C26539
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD1381D3;
	Fri, 29 Mar 2024 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ8lLSkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132E31A94
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677252; cv=none; b=AzFofu0IV0+g/G3CpbYzhHMq5pVGxRSWg46nP73doYHQrvXNfAc6dqvy1yMsFUkaojsjNf7O4CGCV8jx6kp3pJvEdFz4/Fbudo4eYGFG7T8vmjZ7Hstb8uIIcdpHmyGb3/AN3bTUcpqVzFZLdNz+nPXHyWquDCAFvqf507emkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677252; c=relaxed/simple;
	bh=HwibsSMFiRAR0fnshHvGFB5IbKiOaqSe+Y1UKWsx8cU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ivXSlZ2tJPhhHvQFnPaiPAKlORXB3ZIlOKqrKe3ZtDYq3xdkkE5HlZofGOaZRBHSixzEK/lAc9/xue6AuwUtqwP8k+I221k6o5VZylvTl2BOW+Y8nh+ZW3Op16TRt1een0q8wWlv528A8fynZWcQoU0W9fV3kXriDOpByI9xnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQ8lLSkF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a55cd262aso26554527b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677248; x=1712282048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHzI1Uvt7hSz2zKDPtn1Czmy96ylAwQFOSMTDSDsZ5g=;
        b=aQ8lLSkFnHH8czOTuJ/x3KM9DjXCEcBC5Zou6fEqWpexEwNYCbY2EifSJlYTTsSu4v
         +ft/IhDvmMd/3l9Ugu1LQ63p+MGxmA3iVBm5VcExsVAbWbHkk0lkJIupsHvEulsu5BzT
         8XT6WdMl3fvEGaF07n1nePFO76k1eJsFgoik3jo9aWOoETcKDgm8Jad963SBkospLxJT
         +6C9kyTSqeTW+U31lCSqqYxVVBHvZA7kMfDVnGe4UEd7utiBBDkREMnnd3CCjo2a3Lws
         hBH6mb5BGm/B6wSAjbY+EwnZCkgcC1Y8IvzeRSNLiHahc0vQvFDe0xsBGNqpDPXT/GLn
         qOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677248; x=1712282048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHzI1Uvt7hSz2zKDPtn1Czmy96ylAwQFOSMTDSDsZ5g=;
        b=btVwlGwmD41eCHJQFvGNX+DIMWXxiLpOEaoOth0VIHhrfXzYMtlD1FGJ949aRyFu8Z
         29tQQl7BG5iHra19SDdaQJO1dYU0E9a8uAq3O6xQLbOasRve7Swz/vFn39xY7y1zGsW/
         L2s+2Vkq94JAbAK8H4avhZ7qm5+H+5Xvd6unCaVpsK5VQXT0fCz7fVy0fu0r4n9N0d94
         NQDmCdXSpZi2dmnTJc/QZAiDmZOCvPbupo5G80JE5Y+Pa/EsEeyjOpYqp9k5tiEm4n2Z
         +kqLEuR5elm3Nm2fE3aJw/EuKAL2hjuu6NjZmoFjYrdSj2Izi/cvo02Z+m9HOpDuGBl9
         t/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxpc+63E0i1KhK5U4bRXcAG87Z7ozo5BecRGl63gqVns0FCug0Lq7MkTcCsJU1ClVH7SDs0MlYUCLwcZ/OBEe0plqWNPT8xUSPz7HBOg==
X-Gm-Message-State: AOJu0YxP/jG6Ak5AGQBN9j34aVMunPQZIeAkwZYDx8sM4qTdkZ0Ralt4
	qNr6eq+/MvL+3ajFU1Ox7ALA91zYTZLFNaC0Ct9BLVif11XIfjIqStRxELNzOsch7mtxNOcurfE
	jMw==
X-Google-Smtp-Source: AGHT+IG0Zlr5ZkyPEVA/AdJ/e7E7t3v1uduc7lU0aEjzNyLpgzPVabwHLLc+66UK1SBfIYar8i49KtRyZZI=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a81:bb52:0:b0:613:eaaa:9288 with SMTP id
 a18-20020a81bb52000000b00613eaaa9288mr308507ywl.5.1711677248572; Thu, 28 Mar
 2024 18:54:08 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:19 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-5-drosen@google.com>
Subject: [RFC PATCH v4 04/36] fuse: Add fuse-bpf, a stacked fs extension for FUSE
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
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, 
	Alessio Balsini <balsini@google.com>
Content-Type: text/plain; charset="UTF-8"

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
 fs/fuse/Kconfig   |   8 +
 fs/fuse/Makefile  |   1 +
 fs/fuse/backing.c | 422 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c     |  41 ++++-
 fs/fuse/dir.c     | 184 ++++++++++++++++----
 fs/fuse/file.c    |  25 ++-
 fs/fuse/fuse_i.h  | 100 ++++++++++-
 fs/fuse/inode.c   | 183 ++++++++++++++++----
 fs/fuse/ioctl.c   |   2 +-
 9 files changed, 887 insertions(+), 79 deletions(-)
 create mode 100644 fs/fuse/backing.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 038ed0b9aaa5..3a64fa73e591 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -52,3 +52,11 @@ config FUSE_DAX
 
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
index 000000000000..14fcc2032764
--- /dev/null
+++ b/fs/fuse/backing.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE-BPF: Filesystem in Userspace with BPF
+ * Copyright (c) 2021 Google LLC
+ */
+
+#include "fuse_i.h"
+
+#include <linux/bpf_fuse.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs_stack.h>
+#include <linux/namei.h>
+
+/*
+ * expression statement to wrap the backing filter logic
+ * struct inode *inode: inode with bpf and backing inode
+ * typedef io: (typically complex) type whose components fuse_args can point to.
+ *     An instance of this type is created locally and passed to initialize
+ * void initialize_in(struct bpf_fuse_args *fa, io *in_out, args...): function that sets
+ *     up fa and io based on args
+ * void initialize_out(struct bpf_fuse_args *fa, io *in_out, args...): function that sets
+ *     up fa and io based on args
+ * int backing(struct fuse_bpf_args_internal *fa, args...): function that actually performs
+ *     the backing io operation
+ * void *finalize(struct fuse_bpf_args *, args...): function that performs any final
+ *     work needed to commit the backing io
+ */
+#define bpf_fuse_backing(inode, io, out,				\
+			 initialize_in, initialize_out,			\
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
+		if (!inode || !fuse_inode->backing_inode)		\
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
+		error = backing(&fa, out, args);			\
+		if (error < 0)						\
+			fa.info.error_in = error;			\
+									\
+	} while (false);						\
+									\
+	if (initialized && handled) {					\
+		res = finalize(&fa, out, args);				\
+		if (res)						\
+			error = res;					\
+	}								\
+									\
+	*out = error ? _Generic((*out),					\
+			default :					\
+				error,					\
+			struct dentry * :				\
+				ERR_PTR(error),				\
+			const char * :					\
+				ERR_PTR(error)				\
+			) : (*out);					\
+	handled;							\
+})
+
+static void fuse_get_backing_path(struct file *file, struct path *path)
+{
+	path_get(&file->f_path);
+	*path = file->f_path;
+}
+
+static bool has_file(int type)
+{
+	return type == FUSE_ENTRY_BACKING;
+}
+
+/*
+ * The optional fuse bpf entry lists the backing file for a particular
+ * lookup. These are inherited by default.
+ *
+ * In the future, we may support multiple bpfs, and multiple backing files for
+ * the bpf to choose between.
+ *
+ * Currently, the expected format is possibly a bpf program, then the backing
+ * file. Changing only the bpf is valid, though meaningless if there isn't an
+ * inherited backing file.
+ *
+ * Support for the bpf program will be added in a later patch
+ *
+ */
+int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num)
+{
+	struct fuse_bpf_entry_out *fbeo;
+	struct file *file;
+	bool has_backing = false;
+	int num_entries;
+	int err = -EINVAL;
+	int i;
+
+	if (num > 0)
+		num_entries = num;
+	else
+		num_entries = FUSE_BPF_MAX_ENTRIES;
+
+	for (i = 0; i < num_entries; i++) {
+		file = NULL;
+		fbeo = &fbe->out[i];
+
+		/* reserved for future use */
+		if (fbeo->unused != 0)
+			goto out_err;
+
+		if (has_file(fbeo->entry_type)) {
+			file = fget(fbeo->fd);
+			if (!file) {
+				err = -EBADF;
+				goto out_err;
+			}
+		}
+
+		switch (fbeo->entry_type) {
+		case 0:
+			if (num == -1)
+				num_entries = i;
+			else
+				goto out_err;
+			break;
+		case FUSE_ENTRY_REMOVE_BACKING:
+			if (fbe->backing_action)
+				goto out_err;
+			fbe->backing_action = FUSE_BPF_REMOVE;
+			break;
+		case FUSE_ENTRY_BACKING:
+			if (fbe->backing_action)
+				goto out_err;
+			fuse_get_backing_path(file, &fbe->backing_path);
+			fbe->backing_action = FUSE_BPF_SET;
+			has_backing = true;
+			break;
+		default:
+			err = -EINVAL;
+			goto out_err;
+		}
+		if (has_file(fbeo->entry_type)) {
+			fput(file);
+			file = NULL;
+		}
+	}
+
+	fbe->is_used = num_entries > 0;
+
+	return 0;
+out_err:
+	if (file)
+		fput(file);
+	if (has_backing)
+		path_put_init(&fbe->backing_path);
+	return err;
+}
+
+static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
+			      struct kstat *stat, struct fuse_attr *attr)
+{
+	unsigned int blkbits;
+
+	/* see the comment in fuse_change_attributes() */
+	if (fc->writeback_cache && S_ISREG(inode->i_mode)) {
+		struct timespec64 mtime = inode_get_mtime(inode);
+		struct timespec64 ctime = inode_get_ctime(inode);
+
+		stat->size = i_size_read(inode);
+		stat->mtime.tv_sec = mtime.tv_sec;
+		stat->mtime.tv_nsec = mtime.tv_nsec;
+		stat->ctime.tv_sec = ctime.tv_sec;
+		stat->ctime.tv_nsec = ctime.tv_nsec;
+	}
+
+	attr->ino = stat->ino;
+	attr->mode = (inode->i_mode & S_IFMT) | (stat->mode & 07777);
+	attr->nlink = stat->nlink;
+	attr->uid = from_kuid(fc->user_ns, stat->uid);
+	attr->gid = from_kgid(fc->user_ns, stat->gid);
+	attr->atime = stat->atime.tv_sec;
+	attr->atimensec = stat->atime.tv_nsec;
+	attr->mtime = stat->mtime.tv_sec;
+	attr->mtimensec = stat->mtime.tv_nsec;
+	attr->ctime = stat->ctime.tv_sec;
+	attr->ctimensec = stat->ctime.tv_nsec;
+	attr->size = stat->size;
+	attr->blocks = stat->blocks;
+
+	if (stat->blksize != 0)
+		blkbits = ilog2(stat->blksize);
+	else
+		blkbits = inode->i_sb->s_blocksize_bits;
+
+	attr->blksize = 1 << blkbits;
+}
+
+/*******************************************************************************
+ * Directory operations after here                                             *
+ ******************************************************************************/
+
+struct fuse_lookup_args {
+	struct fuse_buffer name;
+	struct fuse_entry_out out;
+	struct fuse_bpf_entry entries_storage;
+	struct fuse_buffer bpf_entries;
+};
+
+static int fuse_lookup_initialize_in(struct bpf_fuse_args *fa, struct fuse_lookup_args *args,
+				     struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	*args = (struct fuse_lookup_args) {
+		.name = (struct fuse_buffer) {
+			.data = (void *) entry->d_name.name,
+			.size = entry->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dir)->nodeid,
+			.opcode = FUSE_LOOKUP,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_lookup_initialize_out(struct bpf_fuse_args *fa, struct fuse_lookup_args *args,
+				      struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	args->bpf_entries = (struct fuse_buffer) {
+		.data = args->entries_storage.out,
+		.size = 0,
+		.alloc_size = sizeof(args->entries_storage.out),
+		.max_size = sizeof(args->entries_storage.out),
+		.flags = BPF_FUSE_VARIABLE_SIZE,
+	},
+
+	fa->out_numargs = 2;
+	fa->flags = FUSE_BPF_OUT_ARGVAR | FUSE_BPF_IS_LOOKUP;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(args->out),
+		.value = &args->out,
+	};
+	fa->out_args[1] = (struct bpf_fuse_arg) {
+		.is_buffer = true,
+		.buffer = &args->bpf_entries,
+	};
+
+	return 0;
+}
+
+static int fuse_lookup_backing(struct bpf_fuse_args *fa, struct dentry **out, struct inode *dir,
+			       struct dentry *entry, unsigned int flags)
+{
+	struct fuse_dentry *fuse_entry = get_fuse_dentry(entry);
+	struct fuse_dentry *dir_fuse_entry = get_fuse_dentry(entry->d_parent);
+	struct dentry *dir_backing_entry = dir_fuse_entry->backing_path.dentry;
+	struct inode *dir_backing_inode = dir_backing_entry->d_inode;
+	struct fuse_entry_out *feo = (void *)fa->out_args[0].value;
+	struct dentry *backing_entry;
+	const char *name;
+	struct kstat stat;
+	int len;
+	int err;
+
+	/* TODO this will not handle lookups over mount points */
+	inode_lock_nested(dir_backing_inode, I_MUTEX_PARENT);
+	if (fa->in_args[0].buffer->flags & BPF_FUSE_MODIFIED) {
+		name = (char *)fa->in_args[0].buffer->data;
+		len = strnlen(name, fa->in_args[0].buffer->size);
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
+		.mnt = mntget(dir_fuse_entry->backing_path.mnt),
+	};
+
+	if (d_is_negative(backing_entry)) {
+		fa->info.error_in = -ENOENT;
+		return 0;
+	}
+
+	err = vfs_getattr(&fuse_entry->backing_path, &stat,
+				  STATX_BASIC_STATS, 0);
+	if (err) {
+		path_put_init(&fuse_entry->backing_path);
+		return err;
+	}
+
+	fuse_stat_to_attr(get_fuse_conn(dir),
+			  backing_entry->d_inode, &stat, &feo->attr);
+	return 0;
+}
+
+int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path)
+{
+	switch (fbe->backing_action) {
+	case FUSE_BPF_UNCHANGED:
+		/* backing inode/path are added in fuse_lookup_backing */
+		break;
+
+	case FUSE_BPF_REMOVE:
+		path_put_init(backing_path);
+		break;
+
+	case FUSE_BPF_SET: {
+		if (!fbe->backing_path.dentry)
+			return -EINVAL;
+
+		path_put(backing_path);
+		*backing_path = fbe->backing_path;
+		fbe->backing_path.dentry = NULL;
+		fbe->backing_path.mnt = NULL;
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
+static int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
+				struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	struct fuse_dentry *fd;
+	struct dentry *backing_dentry;
+	struct inode *inode, *backing_inode;
+	struct inode *d_inode = entry->d_inode;
+	struct fuse_entry_out *feo = fa->out_args[0].value;
+	struct fuse_bpf_entry_out *febo = fa->out_args[1].buffer->data;
+	struct fuse_bpf_entry *fbe = container_of(febo, struct fuse_bpf_entry, out[0]);
+	int error = -1;
+	u64 target_nodeid = 0;
+
+	parse_fuse_bpf_entry(fbe, -1);
+	fd = get_fuse_dentry(entry);
+	if (!fd)
+		return -EIO;
+	error = fuse_handle_backing(fbe, &fd->backing_path);
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
+	get_fuse_inode(inode)->nodeid = feo->nodeid;
+
+	*out = d_splice_alias(inode, entry);
+	return 0;
+}
+
+int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	return bpf_fuse_backing(dir, struct fuse_lookup_args, out,
+				fuse_lookup_initialize_in, fuse_lookup_initialize_out,
+				fuse_lookup_backing, fuse_lookup_finalize,
+				dir, entry, flags);
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
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..b413e0bfd61c 100644
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
 
@@ -1009,10 +1014,38 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 	return 0;
 }
 
+/* Copy the fuse-bpf lookup args and verify them */
+#ifdef CONFIG_FUSE_BPF
+static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+{
+	struct fuse_bpf_entry_out *fbeo = (struct fuse_bpf_entry_out *)val;
+	struct fuse_bpf_entry *feb = container_of(fbeo, struct fuse_bpf_entry, out[0]);
+	int num_entries = size / sizeof(*fbeo);
+	int err;
+
+	if (size && size % sizeof(*fbeo) != 0)
+		return -EINVAL;
+
+	if (num_entries > FUSE_BPF_MAX_ENTRIES)
+		return -EINVAL;
+	err = fuse_copy_one(cs, val, size);
+	if (err)
+		return err;
+	if (size)
+		err = parse_fuse_bpf_entry(feb, num_entries);
+	return err;
+}
+#else
+static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+{
+	return fuse_copy_one(cs, val, size);
+}
+#endif
+
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing)
+			  int zeroing, unsigned is_lookup)
 {
 	int err = 0;
 	unsigned i;
@@ -1021,6 +1054,8 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 		struct fuse_arg *arg = &args[i];
 		if (i == numargs - 1 && argpages)
 			err = fuse_copy_pages(cs, arg->size, zeroing);
+		else if (i == numargs - 1 && is_lookup)
+			err = fuse_copy_lookup(cs, arg->value, arg->size);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1298,7 +1333,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	err = fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
 	if (!err)
 		err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
-				     (struct fuse_arg *) args->in_args, 0);
+				     (struct fuse_arg *) args->in_args, 0, 0);
 	fuse_copy_finish(cs);
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
@@ -1837,7 +1872,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		lastarg->size -= diffsize;
 	}
 	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
-			      args->out_args, args->page_zeroing);
+			      args->out_args, args->page_zeroing, args->is_lookup);
 }
 
 /*
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cd8d6b2f6d78..6503c91886f6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -34,7 +34,7 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
-#if BITS_PER_LONG >= 64
+#if BITS_PER_LONG >= 64 && !defined(CONFIG_FUSE_BPF)
 static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
 {
 	entry->d_fsdata = (void *) time;
@@ -49,12 +49,12 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 
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
 
@@ -111,6 +111,18 @@ void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o)
 		fuse_time_to_jiffies(o->entry_valid, o->entry_valid_nsec));
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
+
 void fuse_invalidate_attr_mask(struct inode *inode, u32 mask)
 {
 	set_mask_bits(&get_fuse_inode(inode)->inval_mask, 0, mask);
@@ -166,7 +178,8 @@ static void fuse_invalidate_entry(struct dentry *entry)
 
 static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 			     u64 nodeid, const struct qstr *name,
-			     struct fuse_entry_out *outarg)
+			     struct fuse_entry_out *outarg,
+			     struct fuse_bpf_entry_out *bpf_outarg)
 {
 	memset(outarg, 0, sizeof(struct fuse_entry_out));
 	args->opcode = FUSE_LOOKUP;
@@ -174,10 +187,43 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->in_numargs = 1;
 	args->in_args[0].size = name->len + 1;
 	args->in_args[0].value = name->name;
-	args->out_numargs = 1;
+	args->out_argvar = true;
+	args->out_numargs = 2;
 	args->out_args[0].size = sizeof(struct fuse_entry_out);
 	args->out_args[0].value = outarg;
+	args->out_args[1].size = sizeof(struct fuse_bpf_entry_out) * FUSE_BPF_MAX_ENTRIES;
+	args->out_args[1].value = bpf_outarg;
+	args->is_lookup = 1;
+}
+
+#ifdef CONFIG_FUSE_BPF
+static bool backing_data_changed(struct fuse_inode *fi, struct dentry *entry,
+				 struct fuse_bpf_entry *bpf_arg)
+{
+	struct path new_backing_path;
+	struct inode *new_backing_inode;
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
+	ret = (fi->backing_inode != new_backing_inode ||
+			!path_equal(&get_fuse_dentry(entry)->backing_path, &new_backing_path));
+
+put_inode:
+	path_put(&new_backing_path);
+	return ret;
 }
+#endif
 
 /*
  * Check whether the dentry is still valid
@@ -199,9 +245,23 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
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
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
+		struct fuse_bpf_entry bpf_arg;
 		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
 		u64 attr_version;
@@ -213,27 +273,44 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
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
+				 &entry->d_name, &outarg, bpf_arg.out);
 		ret = fuse_simple_request(fm, &args);
 		dput(parent);
+
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
 			ret = -ENOENT;
-		if (!ret) {
+		if (!ret || bpf_arg.is_used) {
 			fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode) ||
+#ifdef CONFIG_FUSE_BPF
+			    (bpf_arg.is_used &&
+					    backing_data_changed(fi, entry, &bpf_arg)) ||
+#endif
 			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
 						  outarg.nodeid, 1);
@@ -275,17 +352,20 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
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
@@ -326,7 +406,7 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 	.d_delete	= fuse_dentry_delete,
-#if BITS_PER_LONG < 64
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_BPF)
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 #endif
@@ -334,7 +414,7 @@ const struct dentry_operations fuse_dentry_operations = {
 };
 
 const struct dentry_operations fuse_root_dentry_operations = {
-#if BITS_PER_LONG < 64
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_BPF)
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 #endif
@@ -356,11 +436,13 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
 	return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
 }
 
-int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode)
+int fuse_lookup_name(struct super_block *sb, u64 nodeid,
+		     const struct qstr *name, struct fuse_entry_out *outarg,
+		     struct dentry *entry, struct inode **inode)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
+	struct fuse_bpf_entry bpf_arg = { 0 };
 	struct fuse_forget_link *forget;
 	u64 attr_version;
 	int err;
@@ -370,7 +452,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (name->len > FUSE_NAME_MAX)
 		goto out;
 
-
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
@@ -378,21 +459,53 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 
 	attr_version = fuse_get_attr_version(fm->fc);
 
-	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
+	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg, bpf_arg.out);
 	err = fuse_simple_request(fm, &args);
-	/* Zero nodeid is same as -ENOENT, but with valid timeout */
-	if (err || !outarg->nodeid)
-		goto out_put_forget;
 
-	err = -EIO;
-	if (fuse_invalid_attr(&outarg->attr))
-		goto out_put_forget;
+#ifdef CONFIG_FUSE_BPF
+	if (bpf_arg.is_used) {
+		/* TODO Make sure this handles invalid handles */
+		struct path *backing_path;
+		struct inode *backing_inode;
 
-	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
-			   &outarg->attr, ATTR_TIMEOUT(outarg),
-			   attr_version);
-	err = -ENOMEM;
-	if (!*inode) {
+		err = -ENOENT;
+		if (!entry)
+			goto out_put_forget;
+
+		err = -EINVAL;
+		backing_path = &bpf_arg.backing_path;
+		if (!backing_path->dentry)
+			goto out_put_forget;
+
+		err = fuse_handle_backing(&bpf_arg,
+				&get_fuse_dentry(entry)->backing_path);
+		if (err)
+			goto out_put_forget;
+
+		backing_inode = d_inode(get_fuse_dentry(entry)->backing_path.dentry);
+		*inode = fuse_iget_backing(sb, outarg->nodeid, backing_inode);
+		if (!*inode)
+			goto out_queue_forget;
+	} else
+#endif
+	{
+		/* Zero nodeid is same as -ENOENT, but with valid timeout */
+		if (err || !outarg->nodeid)
+			goto out_put_forget;
+
+		err = -EIO;
+		if (fuse_invalid_attr(&outarg->attr))
+			goto out_put_forget;
+
+		*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
+				   &outarg->attr, ATTR_TIMEOUT(outarg),
+				   attr_version);
+		err = -ENOMEM;
+	}
+#ifdef CONFIG_FUSE_BPF
+out_queue_forget:
+#endif
+	if (!*inode && outarg->nodeid) {
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
 		goto out;
 	}
@@ -417,9 +530,12 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	if (fuse_is_bad(dir))
 		return ERR_PTR(-EIO);
 
+	if (fuse_bpf_lookup(&newent, dir, entry, flags))
+		return newent;
+
 	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
-			       &outarg, &inode);
+			       &outarg, entry, &inode);
 	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT) {
 		outarg_valid = false;
@@ -1495,6 +1611,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	bool refreshed = false;
 	int err = 0;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -1507,7 +1624,6 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	 */
 	if (fc->default_permissions ||
 	    ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
 		u32 perm_mask = STATX_MODE | STATX_UID | STATX_GID;
 
 		if (perm_mask & READ_ONCE(fi->inval_mask) ||
@@ -1684,7 +1800,7 @@ static long fuse_dir_compat_ioctl(struct file *file, unsigned int cmd,
 				 FUSE_IOCTL_COMPAT | FUSE_IOCTL_DIR);
 }
 
-static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
+static inline bool update_mtime(unsigned int ivalid, bool trust_local_mtime)
 {
 	/* Always update if mtime is explicitly set  */
 	if (ivalid & ATTR_MTIME_SET)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0..41a2e88e8646 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 
+#include <linux/filter.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -127,13 +128,18 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
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
 
@@ -171,7 +177,7 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir, file);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
@@ -1906,6 +1912,19 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
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
index 797bcfd6fa06..ac61f08fd85d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -16,6 +16,8 @@
 #include <linux/fuse.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/statfs.h>
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -31,6 +33,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/user_namespace.h>
+#include <linux/magic.h>
 
 /** Default max number of pages that can be used in a single read request */
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
@@ -77,11 +80,35 @@ struct fuse_submount_lookup {
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
@@ -89,6 +116,14 @@ struct fuse_inode {
 	/** Inode data */
 	struct inode inode;
 
+#ifdef CONFIG_FUSE_BPF
+	/**
+	 * Backing inode, if this inode is from a backing file system.
+	 * If this is set, nodeid is 0.
+	 */
+	struct inode *backing_inode;
+#endif
+
 	/** Unique ID, which identifies the inode between userspace
 	 * and kernel */
 	u64 nodeid;
@@ -246,6 +281,14 @@ struct fuse_file {
 
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
 
@@ -277,6 +320,7 @@ struct fuse_page_desc {
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
+	uint32_t error_in; // May need adjustments???
 	uint8_t in_numargs;
 	uint8_t out_numargs;
 	uint8_t ext_idx;
@@ -291,6 +335,7 @@ struct fuse_args {
 	bool page_replace:1;
 	bool may_block:1;
 	bool is_ext:1;
+	bool is_lookup:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
@@ -544,6 +589,7 @@ struct fuse_fs_context {
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
+	struct file *root_dir;
 
 	/* DAX device, may be NULL */
 	struct dax_device *dax_dev;
@@ -997,12 +1043,16 @@ extern const struct dentry_operations fuse_root_dentry_operations;
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
@@ -1154,6 +1204,8 @@ u64 fuse_time_to_jiffies(u64 sec, u32 nsec);
 
 void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o);
 
+void fuse_init_dentry_root(struct dentry *root, struct file *backing_dir);
+
 /**
  * Acquire reference to fuse_conn
  */
@@ -1360,8 +1412,44 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 /* file.c */
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+				 unsigned int open_flags, bool isdir,
+				 struct file *file);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/* backing.c */
+
+enum fuse_bpf_set {
+	FUSE_BPF_UNCHANGED = 0,
+	FUSE_BPF_SET,
+	FUSE_BPF_REMOVE,
+};
+
+struct fuse_bpf_entry {
+	struct fuse_bpf_entry_out out[FUSE_BPF_MAX_ENTRIES];
+
+	enum fuse_bpf_set backing_action;
+	struct path backing_path;
+	bool is_used;
+};
+
+int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
+
+#ifdef CONFIG_FUSE_BPF
+
+int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+
+#else
+
+static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
+{
+	return 0;
+}
+
+#endif // CONFIG_FUSE_BPF
+
+int fuse_handle_backing(struct fuse_bpf_entry *feb, struct path *backing_path);
+
+int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8eff618ac47b..6570fe7a9b53 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -96,6 +96,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 
 	fi->i_time = 0;
 	fi->inval_mask = ~0;
+#ifdef CONFIG_FUSE_BPF
+	fi->backing_inode = NULL;
+#endif
 	fi->nodeid = 0;
 	fi->nlookup = 0;
 	fi->attr_version = 0;
@@ -150,6 +153,10 @@ static void fuse_evict_inode(struct inode *inode)
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode->i_state & I_DIRTY_INODE);
 
+#ifdef CONFIG_FUSE_BPF
+	iput(fi->backing_inode);
+#endif
+
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
@@ -198,28 +205,28 @@ static ino_t fuse_squash_ino(u64 ino64)
 }
 
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
-				      const struct fuse_inode *fi)
+				      const struct inode *inode)
 {
-	struct timespec64 atime = inode_get_atime(&fi->inode);
-	struct timespec64 mtime = inode_get_mtime(&fi->inode);
-	struct timespec64 ctime = inode_get_ctime(&fi->inode);
+	struct timespec64 atime = inode_get_atime(inode);
+	struct timespec64 mtime = inode_get_mtime(inode);
+	struct timespec64 ctime = inode_get_ctime(inode);
 
 	*attr = (struct fuse_attr){
-		.ino		= fi->inode.i_ino,
-		.size		= fi->inode.i_size,
-		.blocks		= fi->inode.i_blocks,
+		.ino		= inode->i_ino,
+		.size		= inode->i_size,
+		.blocks		= inode->i_blocks,
 		.atime		= atime.tv_sec,
 		.mtime		= mtime.tv_sec,
 		.ctime		= ctime.tv_sec,
 		.atimensec	= atime.tv_nsec,
 		.mtimensec	= mtime.tv_nsec,
 		.ctimensec	= ctime.tv_nsec,
-		.mode		= fi->inode.i_mode,
-		.nlink		= fi->inode.i_nlink,
-		.uid		= fi->inode.i_uid.val,
-		.gid		= fi->inode.i_gid.val,
-		.rdev		= fi->inode.i_rdev,
-		.blksize	= 1u << fi->inode.i_blkbits,
+		.mode		= inode->i_mode,
+		.nlink		= inode->i_nlink,
+		.uid		= inode->i_uid.val,
+		.gid		= inode->i_gid.val,
+		.rdev		= inode->i_rdev,
+		.blksize	= 1u << inode->i_blkbits,
 	};
 }
 
@@ -415,8 +422,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		fuse_init_common(inode);
-		init_special_inode(inode, inode->i_mode,
-				   new_decode_dev(attr->rdev));
+		init_special_inode(inode, inode->i_mode, attr->rdev);
 	} else
 		BUG();
 	/*
@@ -427,22 +433,100 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 		inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
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
+	fuse_init_inode(inode, &attr, fc);
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
@@ -450,6 +534,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	struct inode *inode;
 	struct fuse_inode *fi;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_inode_identifier fii = {
+		.nodeid = nodeid,
+	};
 
 	/*
 	 * Auto mount points get their node id from the submount root, which is
@@ -481,7 +568,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	}
 
 retry:
-	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &nodeid);
+	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &fii);
 	if (!inode)
 		return NULL;
 
@@ -513,13 +600,16 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
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
@@ -749,6 +839,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_DIR,
 	OPT_ERR
 };
 
@@ -763,6 +854,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
 	{}
 };
 
@@ -846,6 +938,12 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_ROOT_DIR:
+		ctx->root_dir = fget(result.uint_32);
+		if (!ctx->root_dir)
+			return invalfc(fsc, "Unable to open root directory");
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -858,6 +956,8 @@ static void fuse_free_fsc(struct fs_context *fsc)
 	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	if (ctx) {
+		if (ctx->root_dir)
+			fput(ctx->root_dir);
 		kfree(ctx->subtype);
 		kfree(ctx);
 	}
@@ -992,15 +1092,29 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_conn_get);
 
-static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned mode)
+static struct inode *fuse_get_root_inode(struct super_block *sb,
+					 unsigned int mode,
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
+	if (backing_fd) {
+		get_fuse_inode(inode)->backing_inode = backing_fd->f_inode;
+		ihold(backing_fd->f_inode);
+	}
+#endif
+
+	return inode;
 }
 
 struct fuse_inode_handle {
@@ -1015,11 +1129,14 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
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
@@ -1028,7 +1145,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 			goto out_err;
 
 		err = fuse_lookup_name(sb, handle->nodeid, &name, &outarg,
-				       &inode);
+				       NULL, &inode);
 		if (err && err != -ENOENT)
 			goto out_err;
 		if (err || !inode) {
@@ -1123,13 +1240,14 @@ static struct dentry *fuse_get_parent(struct dentry *child)
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
@@ -1541,7 +1659,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	if (parent_sb->s_subtype && !sb->s_subtype)
 		return -ENOMEM;
 
-	fuse_fill_attr_from_inode(&root_attr, parent_fi);
+	fuse_fill_attr_from_inode(&root_attr, &parent_fi->inode);
 	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
 	/*
 	 * This inode is just a duplicate, so it is not looked up and
@@ -1685,11 +1803,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->no_force_umount = ctx->no_force_umount;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, ctx->rootmode);
+	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_dir);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
 		goto err_dev_free;
+	fuse_init_dentry_root(root_dentry, ctx->root_dir);
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 726640fa439e..8929dfec4970 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -433,7 +433,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir, NULL);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
-- 
2.44.0.478.gd926399ef9-goog


