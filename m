Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35C46E56D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDRBng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDRBmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB316E9E
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552e3fa8f2fso32399207b3.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782097; x=1684374097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mM3VEDiu9mRhnxPoyHTlcLFFgOhw6pqe5rwY+welbQE=;
        b=73fduone9MSuyhI/Vj/EBtrUNK1HlKqIXi2R/1WFSMzTZeGfp5VAaZvM2T8Z1A2hT+
         TW4GWEQGhkVXdJu5a2/KltZOzXD1AQjbMH7CIR0D5QETP4evRehG6EDqGgw/XSPXtGTD
         vVM4cpWKlgSrNskNHkKA3nkSoYyOvtjcA/osyf9wix2pqxY+xmbkY9RApyC6c7CrreuR
         ziFJAw8vrjwNraBMSSyT/8rY6SHmX6pnezYrpgPEU6LWtlkL/qSjF7IjcX7GLUKf/v2+
         cH0jszXzfhYMnGCvrW87cOI//DWQdwJdFT43fsUzo5cCWupIGklT1pKXaLA4TRnEWYuZ
         o5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782097; x=1684374097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM3VEDiu9mRhnxPoyHTlcLFFgOhw6pqe5rwY+welbQE=;
        b=YSu/H/u+2BVN7B+SolpNd+p/N52SlX8WtHGp+CxeWKq6rUOsfSQHB5zYIRnb4CGgDU
         g9skeg8imKAiYobfuowJyOwbaVsTfINOf2WVNRUQJylhs28igiXPRVug4bswdM5EYk4l
         Dcc/z3fLrPwPg5OvcnjAfCccaJecwET3Q2WFuEokiDmrhRjlnQad18yayvsMIrkX1gFo
         LTGQFhNpweZUY3lKXccYzKXyE10OwgMIqfDY1yp5TyGmD2oDTRhw4FoY1VhN7IvJIxj6
         Q0JQ7w52hc4P+hTw81eH8Kh9RTN7R2i6YYeCUfxt+MtqW32Yi8vjLccuOnFr+o1uql3D
         dVCg==
X-Gm-Message-State: AAQBX9dRwRAOOzad/rGPVsQ8DAN7GZzVoECjrN0scL/hSR9rjDuAUABZ
        KDGyBlrnTkcPKkTX/U2lX4NKU9Rhfgo=
X-Google-Smtp-Source: AKy350Zd0zSOj3A4RVvFzehl/6ZADh+4u0SSYtyXG0ZS+awJjZupIGXSlNBiv6NTnINRlJ+t8jkY64w9PeM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:d24d:0:b0:b90:1777:7194 with SMTP id
 j74-20020a25d24d000000b00b9017777194mr8137204ybg.6.1681782096895; Mon, 17 Apr
 2023 18:41:36 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:20 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-21-drosen@google.com>
Subject: [RFC PATCH v3 20/37] fuse-bpf: Add Rename support
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

This adds backing support for FUSE_RENAME and FUSE_RENAME2

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   7 ++
 fs/fuse/fuse_i.h  |  18 ++++
 3 files changed, 275 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 30492f7b2a05..d3a706b55905 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1747,6 +1747,256 @@ int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
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
+		.old_mnt_idmap = &nop_mnt_idmap,
+		.old_dir = d_inode(old_backing_dir_dentry),
+		.old_dentry = old_backing_dentry,
+		.new_mnt_idmap = &nop_mnt_idmap,
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
+struct fuse_rename2_args {
+	struct fuse_rename2_in in;
+	struct fuse_buffer old_name;
+	struct fuse_buffer new_name;
+};
+
+static int fuse_rename2_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename2_args *args,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent,
+				      unsigned int flags)
+{
+	*args = (struct fuse_rename2_args) {
+		.in = (struct fuse_rename2_in) {
+			.newdir = get_node_id(newdir),
+			.flags = flags,
+		},
+		.old_name = (struct fuse_buffer) {
+			.data = (void *) oldent->d_name.name,
+			.size = oldent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+		.new_name = (struct fuse_buffer) {
+			.data = (void *) newent->d_name.name,
+			.size = newent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(olddir),
+			.opcode = FUSE_RENAME2,
+		},
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->old_name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->new_name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rename2_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename2_args *args,
+				       struct inode *olddir, struct dentry *oldent,
+				       struct inode *newdir, struct dentry *newent,
+				       unsigned int flags)
+{
+	return 0;
+}
+
+static int fuse_rename2_backing(struct bpf_fuse_args *fa, int *out,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent,
+				unsigned int flags)
+{
+	const struct fuse_rename2_args *fri = fa->in_args[0].value;
+
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent,
+					  fri->in.flags);
+	return *out;
+}
+
+static int fuse_rename2_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct inode *olddir, struct dentry *oldent,
+				 struct inode *newdir, struct dentry *newent,
+				 unsigned int flags)
+{
+	return 0;
+}
+
+int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+		     struct inode *newdir, struct dentry *newent,
+		     unsigned int flags)
+{
+	return bpf_fuse_backing(olddir, struct fuse_rename2_args, out,
+				fuse_rename2_initialize_in, fuse_rename2_initialize_out,
+				fuse_rename2_backing, fuse_rename2_finalize,
+				olddir, oldent, newdir, newent, flags);
+}
+
+struct fuse_rename_args {
+	struct fuse_rename_in in;
+	struct fuse_buffer old_name;
+	struct fuse_buffer new_name;
+};
+
+static int fuse_rename_initialize_in(struct bpf_fuse_args *fa, struct fuse_rename_args *args,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent)
+{
+	*args = (struct fuse_rename_args) {
+		.in = (struct fuse_rename_in) {
+			.newdir = get_node_id(newdir),
+		},
+		.old_name = (struct fuse_buffer) {
+			.data = (void *) oldent->d_name.name,
+			.size = oldent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+		.new_name = (struct fuse_buffer) {
+			.data = (void *) newent->d_name.name,
+			.size = newent->d_name.len + 1,
+			.flags = BPF_FUSE_IMMUTABLE,
+		},
+
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(olddir),
+			.opcode = FUSE_RENAME,
+		},
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->old_name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->new_name,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_rename_initialize_out(struct bpf_fuse_args *fa, struct fuse_rename_args *args,
+				      struct inode *olddir, struct dentry *oldent,
+				      struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
+static int fuse_rename_backing(struct bpf_fuse_args *fa, int *out,
+			       struct inode *olddir, struct dentry *oldent,
+			       struct inode *newdir, struct dentry *newent)
+{
+	/* TODO: deal with changing dirs/ents */
+	*out = fuse_rename_backing_common(olddir, oldent, newdir, newent, 0);
+	return *out;
+}
+
+static int fuse_rename_finalize(struct bpf_fuse_args *fa, int *out,
+				struct inode *olddir, struct dentry *oldent,
+				struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
+int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+		    struct inode *newdir, struct dentry *newent)
+{
+	return bpf_fuse_backing(olddir, struct fuse_rename_args, out,
+				fuse_rename_initialize_in, fuse_rename_initialize_out,
+				fuse_rename_backing, fuse_rename_finalize,
+				olddir, oldent, newdir, newent);
+}
+
 static int fuse_unlink_initialize_in(struct bpf_fuse_args *fa, struct fuse_buffer *name,
 				     struct inode *dir, struct dentry *entry)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5ce65f696980..086e3ecada19 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1184,6 +1184,10 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 		return -EINVAL;
 
 	if (flags) {
+		if (fuse_bpf_rename2(&err, olddir, oldent, newdir, newent, flags))
+			return err;
+
+		/* TODO: how should this go with bpfs involved? */
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
@@ -1195,6 +1199,9 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 			err = -EINVAL;
 		}
 	} else {
+		if (fuse_bpf_rename(&err, olddir, oldent, newdir, newent))
+			return err;
+
 		err = fuse_rename_common(olddir, oldent, newdir, newent, 0,
 					 FUSE_RENAME,
 					 sizeof(struct fuse_rename_in));
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e60207bf66de..5c8bd2f76fb9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1411,6 +1411,11 @@ int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
 int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev);
 int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode);
 int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
+int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+		     struct inode *newdir, struct dentry *newent,
+		     unsigned int flags);
+int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+		    struct inode *newdir, struct dentry *newent);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct file *file);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file);
@@ -1453,6 +1458,19 @@ static inline int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *ent
 	return 0;
 }
 
+static inline int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
+				   struct inode *newdir, struct dentry *newent,
+				   unsigned int flags)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
+				  struct inode *newdir, struct dentry *newent)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 {
 	return 0;
-- 
2.40.0.634.g4ca3ef3211-goog

