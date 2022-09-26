Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18255EB58D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIZXUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIZXTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC8DCD646
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k11-20020a5b038b000000b006bbf786c30aso1833041ybp.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=B0tkby5Vhcs0Q6NvqndRw6DK+svt0eMsOmepS+oKWjE=;
        b=ZXktqes99S3kx/AkiYHB/IMLSxO2IES9D9GMV6zYDjmXtNrD4IuY4y60J1qTqCSUXu
         HFie2UygFJ5tTRH7gIaZn7rz2JUSSuIpUhUiHiJ0yQ2MlAw5c+/xkggzS4fd4rSCKGWU
         SyYvzwGSnFtmZDB1NE7NYKEOMB6dHm7r4lgPSTbmQ26sEDf33T05NcY6PdNsZ2lgoVEW
         tT2MeooOy71v/hXIQ/uoaMOCTa2ZYNQ9FYKqkE/jq2+6yKTAdLTUf8mkPGc2y6E+/CpC
         rVAWQO+X/9+7KvUjsyOV7kYAXBkcmbC40boCN8WufVql5O/CczJMV7M/MOKgBou6MJAt
         YJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=B0tkby5Vhcs0Q6NvqndRw6DK+svt0eMsOmepS+oKWjE=;
        b=rNbNqOz36Z7kvit+qSgNfhC77iKUi4PQgXIl/jdUaO0M0CxmGkLcIQLmQF6vI7BSn9
         YBI97vv8lFm3B7gyXh4zrYAq+jF4caIvyW9BhcAkdv3Zcx9pCnIi7ice1+nn00c6jXDg
         /JV2m9o6cwPakU0IkV3PoqI78n7RvktZvs/1dC/JS57FQ2PGYcMNR9NBFXJlpxnTKB3T
         LoUxHlMcoK1YpwBIhJNvWjw7PBTQjCLys8enJQC6EGOypybnB8vBYXLe9oPlFmDqUd1K
         XNSlApOdF0ffs/oQlJnqwJUT6WCrhJ6neBZOCsKZfL6yqk9U0wBLHe/13ZbW4n7kWJUg
         nfdw==
X-Gm-Message-State: ACrzQf1m42642+2lLe7FrySj/V0GHTPzMydOTgXqunSkqRZPtxXz8/WP
        GF9jUbkqUeH1jQ48hwXN31efyW9inMs=
X-Google-Smtp-Source: AMsMyM5JIC/8Iu6oIivn9ULgJ5hEbNs/bNWMb9VMAF9wloW+Zo12zTjbYlSmmoKbvS6aHQvQ/QFjDy870T8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a0d:ea0f:0:b0:34d:15af:134f with SMTP id
 t15-20020a0dea0f000000b0034d15af134fmr23327090ywe.267.1664234346701; Mon, 26
 Sep 2022 16:19:06 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:10 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-15-drosen@google.com>
Subject: [PATCH 14/26] fuse-bpf: Support mknod/unlink/mkdir/rmdir
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
 fs/fuse/backing.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |  40 +++++++
 fs/fuse/fuse_i.h  |  35 ++++++
 3 files changed, 346 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 1a2a89ddd535..1fe61177cdfb 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -765,6 +765,277 @@ int fuse_revalidate_backing(struct dentry *entry, unsigned int flags)
 	return 1;
 }
 
+int fuse_mknod_initialize_in(struct bpf_fuse_args *fa, struct fuse_mknod_in *fmi,
+			     struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	*fmi = (struct fuse_mknod_in) {
+		.mode = mode,
+		.rdev = new_encode_dev(rdev),
+		.umask = current_umask(),
+	};
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_MKNOD,
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(*fmi),
+			.value = fmi,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_mknod_initialize_out(struct bpf_fuse_args *fa, struct fuse_mknod_in *fmi,
+			      struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+int fuse_mknod_backing(struct bpf_fuse_args *fa, int *out,
+		       struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
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
+	*out = vfs_mknod(&init_user_ns, backing_inode, backing_path.dentry, mode,
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
+int fuse_mknod_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
+{
+	return 0;
+}
+
+int fuse_mkdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_mkdir_in *fmi,
+			     struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	*fmi = (struct fuse_mkdir_in) {
+		.mode = mode,
+		.umask = current_umask(),
+	};
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_MKDIR,
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(*fmi),
+			.value = fmi,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_mkdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_mkdir_in *fmi,
+			      struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+int fuse_mkdir_backing(struct bpf_fuse_args *fa, int *out,
+		       struct inode *dir, struct dentry *entry, umode_t mode)
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
+	*out = vfs_mkdir(&init_user_ns, backing_inode, backing_path.dentry,
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
+int fuse_mkdir_finalize(struct bpf_fuse_args *fa, int *out,
+			  struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	return 0;
+}
+
+int fuse_rmdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *dummy,
+			     struct inode *dir, struct dentry *entry)
+{
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_RMDIR,
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_rmdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *dummy,
+			      struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_rmdir_backing(struct bpf_fuse_args *fa, int *out,
+		       struct inode *dir, struct dentry *entry)
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
+	*out = vfs_rmdir(&init_user_ns, backing_inode, backing_path.dentry);
+	inode_unlock(backing_inode);
+
+	dput(backing_parent_dentry);
+	if (!*out)
+		d_drop(entry);
+	path_put(&backing_path);
+	return *out;
+}
+
+int fuse_rmdir_finalize(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *dummy,
+			      struct inode *dir, struct dentry *entry)
+{
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_node_id(dir),
+		.opcode = FUSE_UNLINK,
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = entry->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+			.value =  (void *) entry->d_name.name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_unlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *dummy,
+			       struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
+int fuse_unlink_backing(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
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
+	*out = vfs_unlink(&init_user_ns, backing_inode, backing_path.dentry,
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
+int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
+			 struct inode *dir, struct dentry *entry)
+{
+	return 0;
+}
+
 int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
 			      struct inode *inode, int mask)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a89690662b3b..d8237b7a23f2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -896,6 +896,16 @@ static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
 
+#ifdef CONFIG_FUSE_BPF
+	int err;
+
+	if (fuse_bpf_backing(dir, struct fuse_mknod_in, err,
+			fuse_mknod_initialize_in, fuse_mknod_initialize_out,
+			fuse_mknod_backing, fuse_mknod_finalize,
+			dir, entry, mode, rdev))
+		return err;
+#endif
+
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
 
@@ -925,6 +935,16 @@ static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
 
+#ifdef CONFIG_FUSE_BPF
+	int err;
+
+	if (fuse_bpf_backing(dir, struct fuse_mkdir_in, err,
+			fuse_mkdir_initialize_in, fuse_mkdir_initialize_out,
+			fuse_mkdir_backing, fuse_mkdir_finalize,
+			dir, entry, mode))
+		return err;
+#endif
+
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
 
@@ -1010,6 +1030,16 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		if (fuse_bpf_backing(dir, struct fuse_dummy_io, err,
+					fuse_unlink_initialize_in, fuse_unlink_initialize_out,
+					fuse_unlink_backing, fuse_unlink_finalize,
+					dir, entry))
+			return err;
+	}
+#endif
+
 	args.opcode = FUSE_UNLINK;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
@@ -1033,6 +1063,16 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		if (fuse_bpf_backing(dir, struct fuse_dummy_io, err,
+					fuse_rmdir_initialize_in, fuse_rmdir_initialize_out,
+					fuse_rmdir_backing, fuse_rmdir_finalize,
+					dir, entry))
+			return err;
+	}
+#endif
+
 	args.opcode = FUSE_RMDIR;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 1;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f36a00e30c3f..9d6c9cc68268 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1439,6 +1439,41 @@ int fuse_create_open_finalize(struct bpf_fuse_args *fa, int *out,
 			      struct inode *dir, struct dentry *entry,
 			      struct file *file, unsigned int flags, umode_t mode);
 
+int fuse_mknod_initialize_in(struct bpf_fuse_args *fa, struct fuse_mknod_in *fmi,
+			     struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
+int fuse_mknod_initialize_out(struct bpf_fuse_args *fa, struct fuse_mknod_in *fmi,
+			      struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
+int fuse_mknod_backing(struct bpf_fuse_args *fa, int *out,
+		       struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
+int fuse_mknod_finalize(struct bpf_fuse_args *fa, int *out,
+			struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
+
+int fuse_mkdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_mkdir_in *fmi,
+			     struct inode *dir, struct dentry *entry, umode_t mode);
+int fuse_mkdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_mkdir_in *fmi,
+			      struct inode *dir, struct dentry *entry, umode_t mode);
+int fuse_mkdir_backing(struct bpf_fuse_args *fa, int *out,
+		       struct inode *dir, struct dentry *entry, umode_t mode);
+int fuse_mkdir_finalize(struct bpf_fuse_args *fa, int *out,
+			struct inode *dir, struct dentry *entry, umode_t mode);
+
+int fuse_rmdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *fmi,
+			     struct inode *dir, struct dentry *entry);
+int fuse_rmdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *fmi,
+			      struct inode *dir, struct dentry *entry);
+int fuse_rmdir_backing(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry);
+int fuse_rmdir_finalize(struct bpf_fuse_args *fa, int *out,
+			struct inode *dir, struct dentry *entry);
+
+int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_dummy_io *fmi,
+			      struct inode *dir, struct dentry *entry);
+int fuse_unlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_dummy_io *fmi,
+			       struct inode *dir, struct dentry *entry);
+int fuse_unlink_backing(struct bpf_fuse_args *fa, int *out,
+			struct inode *dir, struct dentry *entry);
+int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
+			 struct inode *dir, struct dentry *entry);
+
 int fuse_release_initialize_in(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
 			       struct inode *inode, struct file *file);
 int fuse_release_initialize_out(struct bpf_fuse_args *fa, struct fuse_release_in *fri,
-- 
2.37.3.998.g577e59143f-goog

