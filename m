Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640996E56CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDRBnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDRBm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA887EF1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f810e01f5so165551897b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782087; x=1684374087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDDGgrzSklW9PeQhCnnSrKGQK+GKlru6fDSS3O5BjmA=;
        b=ZH5Or0LVxK0ACl0MYkteAzESD99/7Y6eEY7bCBEA2/UuGiSKlZfZQrdX8//nPc5nnK
         aJRB9zReYRfrzP6d9Tm5nolDNIPFi0ZArQix6zL92mKogJZGyyJ4PoxLe7+MZrdvb9wO
         kQzhsjswf9u1btEBhZRZNqtsp1rTkCG+uQxMOSb7QE3FpkXqeV2NOwqoXk4OAg1om9pg
         xbA94KAfpNG9a0xgBppvH0P/oMFCe049pKZOYRMru06j+Wx//wEy38p0FUuAuX2U+8I7
         MW5H+7BpQvPjjs+oyFzPJ+0Ar9sgfNJqCfxtarg9uNdtUS4R8CyMoCC4J77InmpYcLjF
         bTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782087; x=1684374087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDDGgrzSklW9PeQhCnnSrKGQK+GKlru6fDSS3O5BjmA=;
        b=ITWwmuwTXtoSJfl8saOHvT7BSI4pCZoDUHcAQ9wyubpbzMUDiAnt6VqJHfgT+IWxLG
         jK0VCa4wsh4iW+TKTDt6blKzW0Daw1fH08st62EibJyj/b1sKSbfaRxvN8CUNXPEyfe2
         Ox28QW5JNYQGy28LGvsJj4RTbintOujcivT3C4uaNgPtxvrGZ3Z5bzIQ/7xux5vuqwZU
         Oxm8MBT9C1oPUnPraAk0H9FN7wW30LL1lhKcXgAE4shmo3zhD7MEi8Jet0PBrxKUTcIv
         PcwqHxuh0Xk2fWykCo/hvv8/STmFahXlyTFEwi9JIJKvLxO/e78p6KVF59HakbPlIx4j
         c0PQ==
X-Gm-Message-State: AAQBX9evW552WjPcA4lXm7udZd8Xn9DTU5fSiL6gP5wQfyi7iOCOFbuP
        cw/Iv8Oj408x3prCuVdCI4uJk0kIrqw=
X-Google-Smtp-Source: AKy350b2QTc7qTknU5iRQ/AMnSRDgnYtVdT/oLHx5r2YmfDH4vM6DkZ756se8OX1GhvWk/AZEjOfYn0mUv0=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:d8c1:0:b0:b8b:f594:d512 with SMTP id
 p184-20020a25d8c1000000b00b8bf594d512mr8744186ybg.13.1681782087328; Mon, 17
 Apr 2023 18:41:27 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:16 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-17-drosen@google.com>
Subject: [RFC PATCH v3 16/37] fuse-bpf: Support mknod/unlink/mkdir/rmdir
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
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
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

This adds backing support for FUSE_MKNOD, FUSE_MKDIR, FUSE_RMDIR,
and FUSE_UNLINK

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 342 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  14 ++
 fs/fuse/fuse_i.h  |  24 ++++
 3 files changed, 380 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d4a214cadc15..c6ef10aeec15 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -972,6 +972,348 @@ int fuse_revalidate_backing(struct dentry *entry, unsigned int flags)
 	return 1;
 }
 
+struct fuse_mknod_args {
+	struct fuse_mknod_in in;
+	struct fuse_buffer name;
+};
+
+static int fuse_mknod_initialize_in(struct bpf_fuse_args *fa, struct fuse_mknod_args *args,
+				    struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	*args = (struct fuse_mknod_args) {
+		.in = (struct fuse_mknod_in) {
+			.mode = mode,
+			.rdev = new_encode_dev(rdev),
+			.umask = current_umask(),
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) entry->d_name.name,
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_MKNOD,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_mknod_initialize_out(struct bpf_fuse_args *fa, struct fuse_mknod_args *args,
+				     struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+static int fuse_mknod_backing(struct bpf_fuse_args *fa, int *out,
+			      struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	const struct fuse_mknod_in *fmi = fa->in_args[0].value;
+	struct fuse_inode *fuse_inode = get_fuse_inode(dir);
+	struct inode *backing_inode = fuse_inode->backing_inode;
+	struct path backing_path;
+	struct inode *inode = NULL;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	mode = fmi->mode;
+	if (!IS_POSIXACL(backing_inode))
+		mode &= ~fmi->umask;
+	*out = vfs_mknod(&nop_mnt_idmap, backing_inode, backing_path.dentry, mode,
+			new_decode_dev(fmi->rdev));
+	inode_unlock(backing_inode);
+	if (*out)
+		goto out;
+	if (d_really_is_negative(backing_path.dentry) ||
+	    unlikely(d_unhashed(backing_path.dentry))) {
+		*out = -EINVAL;
+		/**
+		 * TODO: overlayfs responds to this situation with a
+		 * lookupOneLen. Should we do that too?
+		 */
+		goto out;
+	}
+	inode = fuse_iget_backing(dir->i_sb, fuse_inode->nodeid, backing_inode);
+	if (IS_ERR(inode)) {
+		*out = PTR_ERR(inode);
+		goto out;
+	}
+	d_instantiate(entry, inode);
+out:
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_mknod_finalize(struct bpf_fuse_args *fa, int *out,
+			       struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return bpf_fuse_backing(dir, struct fuse_mknod_args, out,
+				fuse_mknod_initialize_in, fuse_mknod_initialize_out,
+				fuse_mknod_backing, fuse_mknod_finalize,
+				dir, entry, mode, rdev);
+}
+
+struct fuse_mkdir_args {
+	struct fuse_mkdir_in in;
+	struct fuse_buffer name;
+};
+
+static int fuse_mkdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_mkdir_args *args,
+				    struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	*args = (struct fuse_mkdir_args) {
+		.in = (struct fuse_mkdir_in) {
+			.mode = mode,
+			.umask = current_umask(),
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) entry->d_name.name,
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_MKDIR,
+		},
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.value = &args->name,
+			.is_buffer = true,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_mkdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_mkdir_args *args,
+				     struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+static int fuse_mkdir_backing(struct bpf_fuse_args *fa, int *out,
+			      struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	const struct fuse_mkdir_in *fmi = fa->in_args[0].value;
+	struct fuse_inode *fuse_inode = get_fuse_inode(dir);
+	struct inode *backing_inode = fuse_inode->backing_inode;
+	struct path backing_path;
+	struct inode *inode = NULL;
+	struct dentry *d;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	mode = fmi->mode;
+	if (!IS_POSIXACL(backing_inode))
+		mode &= ~fmi->umask;
+	*out = vfs_mkdir(&nop_mnt_idmap, backing_inode, backing_path.dentry,
+			mode);
+	if (*out)
+		goto out;
+	if (d_really_is_negative(backing_path.dentry) ||
+	    unlikely(d_unhashed(backing_path.dentry))) {
+		d = lookup_one_len(entry->d_name.name,
+				   backing_path.dentry->d_parent,
+				   entry->d_name.len);
+		if (IS_ERR(d)) {
+			*out = PTR_ERR(d);
+			goto out;
+		}
+		dput(backing_path.dentry);
+		backing_path.dentry = d;
+	}
+	inode = fuse_iget_backing(dir->i_sb, fuse_inode->nodeid, backing_inode);
+	if (IS_ERR(inode)) {
+		*out = PTR_ERR(inode);
+		goto out;
+	}
+	d_instantiate(entry, inode);
+out:
+	inode_unlock(backing_inode);
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_mkdir_finalize(struct bpf_fuse_args *fa, int *out,
+			       struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return bpf_fuse_backing(dir, struct fuse_mkdir_args, out,
+				fuse_mkdir_initialize_in, fuse_mkdir_initialize_out,
+				fuse_mkdir_backing, fuse_mkdir_finalize,
+				dir, entry, mode);
+}
+
+static int fuse_rmdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				    struct inode *dir, struct dentry *entry)
+{
+	*name = (struct fuse_buffer) {
+		.data = (void *) entry->d_name.name,
+		.size = entry->d_name.len + 1,
+		.flags = BPF_FUSE_IMMUTABLE,
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_RMDIR,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rmdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				     struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static int fuse_rmdir_backing(struct bpf_fuse_args *fa, int *out,
+			      struct inode *dir, struct dentry *entry)
+{
+	struct path backing_path;
+	struct dentry *backing_parent_dentry;
+	struct inode *backing_inode;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	backing_parent_dentry = dget_parent(backing_path.dentry);
+	backing_inode = d_inode(backing_parent_dentry);
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	*out = vfs_rmdir(&nop_mnt_idmap, backing_inode, backing_path.dentry);
+	inode_unlock(backing_inode);
+
+	dput(backing_parent_dentry);
+	if (!*out)
+		d_drop(entry);
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_rmdir_finalize(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
+{
+	return bpf_fuse_backing(dir, struct fuse_buffer, out,
+				fuse_rmdir_initialize_in, fuse_rmdir_initialize_out,
+				fuse_rmdir_backing, fuse_rmdir_finalize,
+				dir, entry);
+}
+
+static int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				     struct inode *dir, struct dentry *entry)
+{
+	*name = (struct fuse_buffer) {
+		.data = (void *) entry->d_name.name,
+		.size = entry->d_name.len + 1,
+		.flags = BPF_FUSE_IMMUTABLE,
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(dir),
+			.opcode = FUSE_UNLINK,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_unlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_buffer *name,
+				      struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static int fuse_unlink_backing(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
+{
+	struct path backing_path;
+	struct dentry *backing_parent_dentry;
+	struct inode *backing_inode;
+
+	get_fuse_backing_path(entry, &backing_path);
+	if (!backing_path.dentry)
+		return -EBADF;
+
+	/* TODO Not sure if we should reverify like overlayfs, or get inode from d_parent */
+	backing_parent_dentry = dget_parent(backing_path.dentry);
+	backing_inode = d_inode(backing_parent_dentry);
+
+	inode_lock_nested(backing_inode, I_MUTEX_PARENT);
+	*out = vfs_unlink(&nop_mnt_idmap, backing_inode, backing_path.dentry,
+			 NULL);
+	inode_unlock(backing_inode);
+
+	dput(backing_parent_dentry);
+	if (!*out)
+		d_drop(entry);
+	path_put(&backing_path);
+	return *out;
+}
+
+static int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
+				struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
+{
+	return bpf_fuse_backing(dir, struct fuse_buffer, out,
+				fuse_unlink_initialize_in, fuse_unlink_initialize_out,
+				fuse_unlink_backing, fuse_unlink_finalize,
+				dir, entry);
+}
+
 static int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *in,
 				     struct inode *inode, int mask)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1df2bbc72396..a763a45fa973 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -937,6 +937,10 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mknod_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_mknod(&err, dir, entry, mode, rdev))
+		return err;
 
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
@@ -983,6 +987,10 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mkdir_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_bpf_mkdir(&err, dir, entry, mode))
+		return err;
 
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
@@ -1069,6 +1077,9 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (fuse_bpf_unlink(&err, dir, entry))
+		return err;
+
 	args.opcode = FUSE_UNLINK;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
@@ -1092,6 +1103,9 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (fuse_bpf_rmdir(&err, dir, entry))
+		return err;
+
 	args.opcode = FUSE_RMDIR;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index feecc1ebfdda..2cbe232c1048 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1408,6 +1408,10 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 int fuse_bpf_open(int *err, struct inode *inode, struct file *file, bool isdir);
 int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
 			 struct file *file, unsigned int flags, umode_t mode);
+int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
+int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode);
+int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
@@ -1428,6 +1432,26 @@ static inline int fuse_bpf_create_open(int *out, struct inode *dir, struct dentr
 	return 0;
 }
 
+static inline int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
 {
 	return 0;
-- 
2.40.0.634.g4ca3ef3211-goog

