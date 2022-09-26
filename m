Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593985EB595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiIZXVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiIZXTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A25B3B33
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m131-20020a252689000000b006b2bf1dd88cso7071349ybm.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=N/Fn546VFHTxflTje61QYJaPnRgurffTw3rKsEYpjMI=;
        b=FBY7Pt+b9l5YuSddNHMRTSmjxw35zPUNrcoPkaPieodcZmf5gZXDOCjL9upAkH+06V
         UTNqA8GN/2xZqWCAvjiidUoPshBU/neyEaIzD0vc4vHOOZuNV18QqeB6OAEpFc3/XLpI
         DO7zkE54XAa19KlBudZI89nnuHoww3VlThDp09TS9PYFKaSIbp4DdLG2jvkb87CUacaT
         BSRNwOelfwZzSc+iiLt46CxoK1p4poKb0ucpMGD5QawWNt2DipgSS7tf1uSZdT7LIWUs
         ZXBJ3R8dBz88aAxuQF1YCJf66iWV83UWW097V50iE8fiToUySt2iK9Qmdv8h+8yczDAa
         N+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=N/Fn546VFHTxflTje61QYJaPnRgurffTw3rKsEYpjMI=;
        b=ocQQEzBUsmLHqMOO5G4j12WetDbrDlMJOeMTbR5RkI3vHbbbpuJBFV4M1V8gR1RtJt
         JKa2n+QvyZ/upFZp/D1r2WVxELuvyF8T09POAfK9/MfafIKCYssfgB/cYGJJD3o26jmN
         EKvPTJMdAtk5YeY7QXXDRJ1SzuCPbqh5bF0a6NxDsovdJAfVyyZO25oBPossgsq/CQV9
         ti0QUicEH/XQm+XE8TmAXjMUdl/X4uKCBGx6TbTIk/IhxfyPYpoI4CmGX5lgmiO1twDU
         DI13nBGkaKriVYxAsIiCZlVWYSpfF8ex1+qNo4bb5c7UfICVK3MswfNXGkGjyO7N/F04
         Ej5g==
X-Gm-Message-State: ACrzQf1TTv43l/4FopWvYn6W+giAsN/3USKxVqiJ6hIAn/7nxn7hjb7J
        42HrEAcOsSXFopOJUN/WAdcMEtIL5Ac=
X-Google-Smtp-Source: AMsMyM4US+RVv7hQtZe0rBb6rHL50rcLRl/LVruuKMEzBDuun/maiJE9Pqp3MYLvOPicAhAnHUxB+WjvkiI=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:3616:0:b0:6b9:ed4d:8c0f with SMTP id
 d22-20020a253616000000b006b9ed4d8c0fmr11126126yba.321.1664234357723; Mon, 26
 Sep 2022 16:19:17 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:14 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-19-drosen@google.com>
Subject: [PATCH 18/26] fuse-bpf: Add Rename support
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

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  19 +++++
 fs/fuse/fuse_i.h  |  30 +++++++
 3 files changed, 246 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 4fd7442c94a1..f4ab92dc8099 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1374,6 +1374,203 @@ int fuse_rmdir_finalize(struct bpf_fuse_args *fa, int *out, struct inode *dir, s
 	return 0;
 }
 
+static int fuse_rename_backing_common(struct inode *olddir,
+				      struct dentry *oldent,
+				      struct inode *newdir,
+				      struct dentry *newent, unsigned int flags)
+{
+	int err = 0;
+	struct path old_backing_path;
+	struct path new_backing_path;
+	struct dentry *old_backing_dir_dentry;
+	struct dentry *old_backing_dentry;
+	struct dentry *new_backing_dir_dentry;
+	struct dentry *new_backing_dentry;
+	struct dentry *trap = NULL;
+	struct inode *target_inode;
+	struct renamedata rd;
+
+	//TODO Actually deal with changing anything that isn't a flag
+	get_fuse_backing_path(oldent, &old_backing_path);
+	if (!old_backing_path.dentry)
+		return -EBADF;
+	get_fuse_backing_path(newent, &new_backing_path);
+	if (!new_backing_path.dentry) {
+		/*
+		 * TODO A file being moved from a backing path to another
+		 * backing path which is not yet instrumented with FUSE-BPF.
+		 * This may be slow and should be substituted with something
+		 * more clever.
+		 */
+		err = -EXDEV;
+		goto put_old_path;
+	}
+	if (new_backing_path.mnt != old_backing_path.mnt) {
+		err = -EXDEV;
+		goto put_new_path;
+	}
+	old_backing_dentry = old_backing_path.dentry;
+	new_backing_dentry = new_backing_path.dentry;
+	old_backing_dir_dentry = dget_parent(old_backing_dentry);
+	new_backing_dir_dentry = dget_parent(new_backing_dentry);
+	target_inode = d_inode(newent);
+
+	trap = lock_rename(old_backing_dir_dentry, new_backing_dir_dentry);
+	if (trap == old_backing_dentry) {
+		err = -EINVAL;
+		goto put_parents;
+	}
+	if (trap == new_backing_dentry) {
+		err = -ENOTEMPTY;
+		goto put_parents;
+	}
+
+	rd = (struct renamedata) {
+		.old_mnt_userns = &init_user_ns,
+		.old_dir = d_inode(old_backing_dir_dentry),
+		.old_dentry = old_backing_dentry,
+		.new_mnt_userns = &init_user_ns,
+		.new_dir = d_inode(new_backing_dir_dentry),
+		.new_dentry = new_backing_dentry,
+		.flags = flags,
+	};
+	err = vfs_rename(&rd);
+	if (err)
+		goto unlock;
+	if (target_inode)
+		fsstack_copy_attr_all(target_inode,
+				get_fuse_inode(target_inode)->backing_inode);
+	fsstack_copy_attr_all(d_inode(oldent), d_inode(old_backing_dentry));
+unlock:
+	unlock_rename(old_backing_dir_dentry, new_backing_dir_dentry);
+put_parents:
+	dput(new_backing_dir_dentry);
+	dput(old_backing_dir_dentry);
+put_new_path:
+	path_put(&new_backing_path);
+put_old_path:
+	path_put(&old_backing_path);
+	return err;
+}
+
+int fuse_rename2_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename2_in *fri,
+			       struct inode *olddir, struct dentry *oldent,
+			       struct inode *newdir, struct dentry *newent,
+			       unsigned int flags)
+{
+	*fri = (struct fuse_rename2_in) {
+		.newdir = get_node_id(newdir),
+		.flags = flags,
+	};
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(olddir),
+		.opcode = FUSE_RENAME2,
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(*fri),
+			.value = fri,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = oldent->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) oldent->d_name.name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.size = newent->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) newent->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_rename2_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename2_in *fri,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent,
+				unsigned int flags)
+{
+	return 0;
+}
+
+int fuse_rename2_backing(struct bpf_fuse_args *fa, int *out,
+			 struct inode *olddir, struct dentry *oldent,
+			 struct inode *newdir, struct dentry *newent,
+			 unsigned int flags)
+{
+	const struct fuse_rename2_in *fri = fa->in_args[0].value;
+
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent,
+					  fri->flags);
+	return *out;
+}
+
+int fuse_rename2_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct inode *olddir, struct dentry *oldent,
+			  struct inode *newdir, struct dentry *newent,
+			  unsigned int flags)
+{
+	return 0;
+}
+
+int fuse_rename_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename_in *fri,
+			      struct inode *olddir, struct dentry *oldent,
+			      struct inode *newdir, struct dentry *newent)
+{
+	*fri = (struct fuse_rename_in) {
+		.newdir = get_node_id(newdir),
+	};
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(olddir),
+		.opcode = FUSE_RENAME,
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(*fri),
+			.value = fri,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = oldent->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) oldent->d_name.name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.size = newent->d_name.len + 1,
+			.max_size = NAME_MAX + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) newent->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_rename_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename_in *fri,
+			       struct inode *olddir, struct dentry *oldent,
+			       struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_rename_backing(struct bpf_fuse_args *fa, int *out,
+			struct inode *olddir, struct dentry *oldent,
+			struct inode *newdir, struct dentry *newent)
+{
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent, 0);
+	return *out;
+}
+
+int fuse_rename_finalize(struct bpf_fuse_args *fa, int *out,
+			 struct inode *olddir, struct dentry *oldent,
+			 struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
 int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *dummy,
 			      struct inode *dir, struct dentry *entry)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f159b9a6d305..7c9d8540668c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1151,6 +1151,16 @@ static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
 		return -EINVAL;
 
 	if (flags) {
+#ifdef CONFIG_FUSE_BPF
+		if (fuse_bpf_backing(olddir, struct fuse_rename2_in, err,
+						fuse_rename2_initialize_in,
+						fuse_rename2_initialize_out, fuse_rename2_backing,
+						fuse_rename2_finalize,
+						olddir, oldent, newdir, newent, flags))
+			return err;
+#endif
+
+		/* TODO: how should this go with bpfs involved? */
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
@@ -1162,6 +1172,15 @@ static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
 			err = -EINVAL;
 		}
 	} else {
+#ifdef CONFIG_FUSE_BPF
+		if (fuse_bpf_backing(olddir, struct fuse_rename_in, err,
+						fuse_rename_initialize_in,
+						fuse_rename_initialize_out, fuse_rename_backing,
+						fuse_rename_finalize,
+						olddir, oldent, newdir, newent))
+			return err;
+#endif
+
 		err = fuse_rename_common(olddir, oldent, newdir, newent, 0,
 					 FUSE_RENAME,
 					 sizeof(struct fuse_rename_in));
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index db769dd0a2e4..6c2f75ae9a5a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1465,6 +1465,36 @@ int fuse_rmdir_backing(struct bpf_fuse_args *fa, int *out, struct inode *dir, st
 int fuse_rmdir_finalize(struct bpf_fuse_args *fa, int *out,
 			struct inode *dir, struct dentry *entry);
 
+int fuse_rename2_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename2_in *fri,
+			       struct inode *olddir, struct dentry *oldent,
+			       struct inode *newdir, struct dentry *newent,
+			       unsigned int flags);
+int fuse_rename2_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename2_in *fri,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent,
+				unsigned int flags);
+int fuse_rename2_backing(struct bpf_fuse_args *fa, int *out,
+			 struct inode *olddir, struct dentry *oldent,
+			 struct inode *newdir, struct dentry *newent,
+			 unsigned int flags);
+int fuse_rename2_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct inode *olddir, struct dentry *oldent,
+			  struct inode *newdir, struct dentry *newent,
+			  unsigned int flags);
+
+int fuse_rename_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename_in *fri,
+			      struct inode *olddir, struct dentry *oldent,
+			      struct inode *newdir, struct dentry *newent);
+int fuse_rename_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename_in *fri,
+			       struct inode *olddir, struct dentry *oldent,
+			       struct inode *newdir, struct dentry *newent);
+int fuse_rename_backing(struct bpf_fuse_args *fa, int *out,
+			struct inode *olddir, struct dentry *oldent,
+			struct inode *newdir, struct dentry *newent);
+int fuse_rename_finalize(struct bpf_fuse_args *fa, int *out,
+			 struct inode *olddir, struct dentry *oldent,
+			 struct inode *newdir, struct dentry *newent);
+
 int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *fmi,
 			      struct inode *dir, struct dentry *entry);
 int fuse_unlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *fmi,
-- 
2.37.3.998.g577e59143f-goog

