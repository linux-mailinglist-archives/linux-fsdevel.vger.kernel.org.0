Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A22F6E56E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjDRBoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjDRBm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:42:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFACF83D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 188-20020a250ac5000000b00b9265c9a5e9so2183759ybk.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782104; x=1684374104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ap14iOZpnbsKNo6G93wf0F6NVTN36P+wrV7MWQ5vc=;
        b=LNB3R+49gmQhyMAJnqmL6KYI/ZCR+tQ/0jba5N0/i2eEk6OmYIYbiuf0Z7V4bUldDj
         xmAcckNGdRp5IYqNUT8hqhpXD3vdnlrJNfoEzI9hjUpQNlq3IjGbbi4vQ1h9Xgp31A+R
         5jbqBakdNiRAQFySaud23Qc2bb0XZCCsv91cuEDtJ0lsyZMTvQItKMyw0e1gbKSpBG7W
         2yGprGFBTkg9LHUqY/Yx/LEu6jmWcorOClliwxzsxuu4MLRG7YazaQAJntomIhbXgBUg
         9zw6XZJs07Ntzj/gIsAFey2DX1dvCDUPgQXl4rZCW29e5vOds9wU1NhA4cgwPQE9OmSr
         p62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782104; x=1684374104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ap14iOZpnbsKNo6G93wf0F6NVTN36P+wrV7MWQ5vc=;
        b=OYVbt39vjIipvOJ+e1w6zGFvyEJjcF31aovm1fYbINXCPo7wvtj5XSrkQ9H/pjvDbi
         OT0SD1yuEUj86k8bouIg2IBuO34TJcHRUe/4rb42bF0/o6cjaQwQv0M26koq/McGAk88
         /h+ddIwzahzxlh//4bQzQzvWMPWYaBHIvl3mmMqca9V6kZ6s4DLoFNF4Dha9yEj2x2Ll
         fImvvCwdDnZwOtiZvJCNCeFicXpb0/uEYnqCQszePVztQVvwQRXdYhOmnPtM0aGj/GZt
         9Fa2XZuqstSK5ah4L7j8fSlnaoWnmbOkV0MjAFTUYzIDRh3iOSSDIbDJotXW/hZGsIA5
         Tg7w==
X-Gm-Message-State: AAQBX9dGLJZEDOka6eiQFvv7fTqj1piLv1DV8nRaDau85Wmu9OGt4JFY
        hkb82W5+50uigBOeO0krdDXuCndTgDo=
X-Google-Smtp-Source: AKy350aATwmWG/o9YxDsbVJURffOBFykqGN8a34WfB/p7jnkyKN8nP3tgJdz5JXEk/Bod96TuKRjP9ed7Bo=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:d196:0:b0:b8f:6faa:6480 with SMTP id
 i144-20020a25d196000000b00b8f6faa6480mr8469156ybg.7.1681782103829; Mon, 17
 Apr 2023 18:41:43 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:23 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-24-drosen@google.com>
Subject: [RFC PATCH v3 23/37] fuse-bpf: Add xattr support
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

This adds support for FUSE_GETXATTR, FUSE_LISTXATTR, FUSE_SETXATTR, and
FUSE_REMOVEXATTR

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  30 ++++
 fs/fuse/xattr.c   |  18 +++
 3 files changed, 397 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 928b24db2303..eb3eb184c867 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -982,6 +982,355 @@ int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t
 				file, start, end, datasync);
 }
 
+struct fuse_getxattr_args {
+	struct fuse_getxattr_in in;
+	struct fuse_buffer name;
+	struct fuse_buffer value;
+	struct fuse_getxattr_out out;
+};
+
+static int fuse_getxattr_initialize_in(struct bpf_fuse_args *fa,
+				       struct fuse_getxattr_args *args,
+				       struct dentry *dentry, const char *name, void *value,
+				       size_t size)
+{
+	*args = (struct fuse_getxattr_args) {
+		.in.size = size,
+		.name = (struct fuse_buffer) {
+			.data =  (void *) name,
+			.size = strlen(name) + 1,
+			.max_size = XATTR_NAME_MAX + 1,
+			.flags = BPF_FUSE_MUST_ALLOCATE | BPF_FUSE_VARIABLE_SIZE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_GETXATTR,
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
+static int fuse_getxattr_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_getxattr_args *args,
+					struct dentry *dentry, const char *name, void *value,
+					size_t size)
+{
+	fa->flags = size ? FUSE_BPF_OUT_ARGVAR : 0;
+	fa->out_numargs = 1;
+	if (size) {
+		args->value = (struct fuse_buffer) {
+			.data =  (void *) value,
+			.size = size,
+			.alloc_size = size,
+			.max_size = size,
+			.flags = BPF_FUSE_VARIABLE_SIZE,
+		};
+		fa->out_args[0].is_buffer = true;
+		fa->out_args[0].buffer = &args->value;
+	} else {
+		fa->out_args[0].size = sizeof(args->out);
+		fa->out_args[0].value = &args->out;
+	}
+	return 0;
+}
+
+static int fuse_getxattr_backing(struct bpf_fuse_args *fa, int *out,
+				 struct dentry *dentry, const char *name, void *value,
+				 size_t size)
+{
+	ssize_t ret;
+
+	if (fa->in_args[1].buffer->flags & BPF_FUSE_MODIFIED) {
+		// Ensure bpf provided string is null terminated
+		char *new_name = fa->in_args[1].buffer->data;
+		new_name[fa->in_args[1].buffer->size - 1] = 0;
+	}
+	ret = vfs_getxattr(&nop_mnt_idmap,
+				   get_fuse_dentry(dentry)->backing_path.dentry,
+				   fa->in_args[1].buffer->data, value, size);
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR)
+		fa->out_args[0].buffer->size = ret;
+	else
+		((struct fuse_getxattr_out *)fa->out_args[0].value)->size = ret;
+
+	return 0;
+}
+
+static int fuse_getxattr_finalize(struct bpf_fuse_args *fa, int *out,
+				  struct dentry *dentry, const char *name, void *value,
+				  size_t size)
+{
+	struct fuse_getxattr_out *fgo;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR) {
+		*out = fa->out_args[0].buffer->size;
+		return 0;
+	}
+
+	fgo = fa->out_args[0].value;
+
+	*out = fgo->size;
+	return 0;
+}
+
+int fuse_bpf_getxattr(int *out, struct inode *inode, struct dentry *dentry, const char *name,
+		      void *value, size_t size)
+{
+	return bpf_fuse_backing(inode, struct fuse_getxattr_args, out,
+				fuse_getxattr_initialize_in, fuse_getxattr_initialize_out,
+				fuse_getxattr_backing, fuse_getxattr_finalize,
+				dentry, name, value, size);
+}
+
+static int fuse_listxattr_initialize_in(struct bpf_fuse_args *fa,
+					struct fuse_getxattr_args *args,
+					struct dentry *dentry, char *list, size_t size)
+{
+	*args = (struct fuse_getxattr_args) {
+		.in.size = size,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_LISTXATTR,
+		},
+		.in_numargs = 1,
+		.in_args[0] =
+			(struct bpf_fuse_arg) {
+				.size = sizeof(args->in),
+				.value = &args->in,
+			},
+	};
+
+	return 0;
+}
+
+static int fuse_listxattr_initialize_out(struct bpf_fuse_args *fa,
+					 struct fuse_getxattr_args *args,
+					 struct dentry *dentry, char *list, size_t size)
+{
+	fa->out_numargs = 1;
+
+	if (size) {
+		args->value = (struct fuse_buffer) {
+			.data = list,
+			.size = size,
+			.alloc_size = size,
+			.max_size = size,
+			.flags = BPF_FUSE_VARIABLE_SIZE,
+		};
+		fa->flags = FUSE_BPF_OUT_ARGVAR;
+		fa->out_args[0].is_buffer = true;
+		fa->out_args[0].buffer = &args->value;
+	} else {
+		fa->out_args[0].size = sizeof(args->out);
+		fa->out_args[0].value = &args->out;
+	}
+	return 0;
+}
+
+static int fuse_listxattr_backing(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+				  char *list, size_t size)
+{
+	*out = vfs_listxattr(get_fuse_dentry(dentry)->backing_path.dentry, list, size);
+
+	if (*out < 0)
+		return *out;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR)
+		fa->out_args[0].buffer->size = *out;
+	else
+		((struct fuse_getxattr_out *)fa->out_args[0].value)->size = *out;
+
+	return 0;
+}
+
+static int fuse_listxattr_finalize(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+				   char *list, size_t size)
+{
+	struct fuse_getxattr_out *fgo;
+
+	if (fa->info.error_in)
+		return 0;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR) {
+		*out = fa->out_args[0].buffer->size;
+		return 0;
+	}
+
+	fgo = fa->out_args[0].value;
+	*out = fgo->size;
+	return 0;
+}
+
+int fuse_bpf_listxattr(ssize_t *out, struct inode *inode, struct dentry *dentry,
+		       char *list, size_t size)
+{
+	return bpf_fuse_backing(inode, struct fuse_getxattr_args, out,
+				fuse_listxattr_initialize_in, fuse_listxattr_initialize_out,
+				fuse_listxattr_backing, fuse_listxattr_finalize,
+				dentry, list, size);
+}
+
+struct fuse_setxattr_args {
+	struct fuse_setxattr_in in;
+	struct fuse_buffer name;
+	struct fuse_buffer value;
+};
+
+static int fuse_setxattr_initialize_in(struct bpf_fuse_args *fa,
+				       struct fuse_setxattr_args *args,
+				       struct dentry *dentry, const char *name,
+				       const void *value, size_t size, int flags)
+{
+	*args = (struct fuse_setxattr_args) {
+		.in = (struct fuse_setxattr_in) {
+			.size = size,
+			.flags = flags,
+		},
+		.name = (struct fuse_buffer) {
+			.data = (void *) name,
+			.size = strlen(name) + 1,
+			.max_size = XATTR_NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+		.value =(struct fuse_buffer) {
+			.data = (void *) value,
+			.size = size,
+			.max_size = XATTR_SIZE_MAX,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+		},
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_SETXATTR,
+		},
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = &args->value,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_setxattr_initialize_out(struct bpf_fuse_args *fa,
+					struct fuse_setxattr_args *args,
+					struct dentry *dentry, const char *name,
+					const void *value, size_t size, int flags)
+{
+	return 0;
+}
+
+static int fuse_setxattr_backing(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+				 const char *name, const void *value, size_t size,
+				 int flags)
+{
+	// TODO Ensure we actually use filter values
+	*out = vfs_setxattr(&nop_mnt_idmap,
+			    get_fuse_dentry(dentry)->backing_path.dentry, name,
+			    value, size, flags);
+	return 0;
+}
+
+static int fuse_setxattr_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+				  const char *name, const void *value, size_t size,
+				  int flags)
+{
+	return 0;
+}
+
+int fuse_bpf_setxattr(int *out, struct inode *inode, struct dentry *dentry,
+		      const char *name, const void *value, size_t size, int flags)
+{
+	return bpf_fuse_backing(inode, struct fuse_setxattr_args, out,
+			       fuse_setxattr_initialize_in, fuse_setxattr_initialize_out,
+			       fuse_setxattr_backing, fuse_setxattr_finalize,
+			       dentry, name, value, size, flags);
+}
+
+static int fuse_removexattr_initialize_in(struct bpf_fuse_args *fa,
+					  struct fuse_buffer *in,
+					  struct dentry *dentry, const char *name)
+{
+	*in = (struct fuse_buffer) {
+		.data = (void *) name,
+		.size = strlen(name) + 1,
+		.max_size = XATTR_NAME_MAX + 1,
+		.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+	};
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+			.opcode = FUSE_REMOVEXATTR,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.is_buffer = true,
+			.buffer = in,
+		},
+	};
+
+	return 0;
+}
+
+static int fuse_removexattr_initialize_out(struct bpf_fuse_args *fa,
+					   struct fuse_buffer *in,
+					   struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
+static int fuse_removexattr_backing(struct bpf_fuse_args *fa, int *out,
+				    struct dentry *dentry, const char *name)
+{
+	struct path *backing_path = &get_fuse_dentry(dentry)->backing_path;
+
+	/* TODO account for changes of the name by prefilter */
+	*out = vfs_removexattr(&nop_mnt_idmap, backing_path->dentry, name);
+	return 0;
+}
+
+static int fuse_removexattr_finalize(struct bpf_fuse_args *fa, int *out,
+				     struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
+int fuse_bpf_removexattr(int *out, struct inode *inode, struct dentry *dentry, const char *name)
+{
+	return bpf_fuse_backing(inode, struct fuse_buffer, out,
+				fuse_removexattr_initialize_in, fuse_removexattr_initialize_out,
+				fuse_removexattr_backing, fuse_removexattr_finalize,
+				dentry, name);
+}
+
 static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74540f308636..243a8fe0c343 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1426,6 +1426,13 @@ int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *fil
 			     size_t len, unsigned int flags);
 int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_bpf_getxattr(int *out, struct inode *inode, struct dentry *dentry,
+		      const char *name, void *value, size_t size);
+int fuse_bpf_listxattr(ssize_t *out, struct inode *inode, struct dentry *dentry, char *list, size_t size);
+int fuse_bpf_setxattr(int *out, struct inode *inode, struct dentry *dentry,
+		      const char *name, const void *value, size_t size,
+		      int flags);
+int fuse_bpf_removexattr(int *out, struct inode *inode, struct dentry *dentry, const char *name);
 int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
@@ -1520,6 +1527,29 @@ static inline int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file
 	return 0;
 }
 
+static inline int fuse_bpf_getxattr(int *out, struct inode *inode, struct dentry *dentry,
+				    const char *name, void *value, size_t size)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_listxattr(ssize_t *out, struct inode *inode, struct dentry *dentry, char *list, size_t size)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_setxattr(int *out, struct inode *inode, struct dentry *dentry,
+				    const char *name, const void *value, size_t size,
+				    int flags)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_removexattr(int *out, struct inode *inode, struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 49c01559580f..d00f7dc50038 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -118,6 +118,9 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_listxattr(&ret, inode, entry, list, size))
+		return ret;
+
 	if (!fuse_allow_current_process(fm->fc))
 		return -EACCES;
 
@@ -182,9 +185,14 @@ static int fuse_xattr_get(const struct xattr_handler *handler,
 			 struct dentry *dentry, struct inode *inode,
 			 const char *name, void *value, size_t size)
 {
+	int err;
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_getxattr(&err, inode, dentry, name, value, size))
+		return err;
+
 	return fuse_getxattr(inode, name, value, size);
 }
 
@@ -194,9 +202,19 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
 			  const char *name, const void *value, size_t size,
 			  int flags)
 {
+	int err;
+	bool handled;
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (value)
+		handled = fuse_bpf_setxattr(&err, inode, dentry, name, value, size, flags);
+	else
+		handled = fuse_bpf_removexattr(&err, inode, dentry, name);
+	if (handled)
+		return err;
+
 	if (!value)
 		return fuse_removexattr(inode, name);
 
-- 
2.40.0.634.g4ca3ef3211-goog

