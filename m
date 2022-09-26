Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AA5EB59B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIZXVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiIZXTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52162F34FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m131-20020a252689000000b006b2bf1dd88cso7071577ybm.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=rYjxyvkE9RDezxO9h2K/BZZj12tb0mXu2/j7vaaKhpg=;
        b=KBNHzGr1TYXdTaAWRXVGAoP48vPDgiAkokPCXh0+rbjbhxLuTAym3RSPua+fBmeDb8
         bcXCjc7E+xQsZzv48COgWXWTVIfQ79v+CpGFADgfgXsYLUoSwjMsEmHFDnCN2N305yqX
         QqERox4Ofa1b2bqrY3HRrrQvYRelRHzBaCQchyhCDYvI+THARW2YybXntmvzM0fsERAf
         oxwzMwD8SMDKO7i8LW82FnsXXxczmYZCu4EuAm+mgLV61VaDlTZIemu1yHDfAntwLnm0
         rEiBMmojE6D2HgcX+RZg8o8pWdyn+BGNzG7Ht9rx+969662qcPd4vVknyXLntHjLfrWQ
         OpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=rYjxyvkE9RDezxO9h2K/BZZj12tb0mXu2/j7vaaKhpg=;
        b=a0GKw7dH9mIxzHYcJv+uwNsQR+uc9jIvg7MX12CKyuaEg3qJ4dH/rTMLWuKaWa7Z1I
         cyOw9liCrLRVN5XEBtCKIr0us3tyqvZNDNV4DebLsdMCqdvR1Ir2vNAGF4c3QPFoNmGi
         0QmlA24UdCVoDnknWDrqlVclL5BrTBwFhVqenjwSb7ZbmCdAg7rHCi75wJR985GKAF4S
         3UTmpZ/Nx8l8P+JHQAd3vZLEbOi/t+iRsH0BCth9dWNMrc62ujr3kCbCxqr57FSGKkXP
         bptjAoWWPiOLbZaWloiaaZ0OJ3G5O9EL37SCwyiGetkSUEpnLgdCh+OTjTCgDobeMeTu
         9rVg==
X-Gm-Message-State: ACrzQf2aTreM4by6zPQwd0EY+/rH0F7PA5CPOOw9+Sew6U17pjAQw0dC
        fvp9mAXqzPxzWlZo4UZed34CBMzZpa4=
X-Google-Smtp-Source: AMsMyM4UrkAMF8Ec7bD3xpQxejQrZ+7AzTsLm6GcYdPNdTlGzSGUVfMgQP6yWGS9qUaeysQVWLDzLx9CE4c=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a0d:cf43:0:b0:349:d226:90bb with SMTP id
 r64-20020a0dcf43000000b00349d22690bbmr23797614ywd.136.1664234366038; Mon, 26
 Sep 2022 16:19:26 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:17 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-22-drosen@google.com>
Subject: [PATCH 21/26] fuse-bpf: Add xattr support
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
 fs/fuse/backing.c | 257 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h  |  55 ++++++++++
 fs/fuse/xattr.c   |  36 +++++++
 3 files changed, 348 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 8fd5cbfdd4fa..d8c86234f253 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -695,6 +695,263 @@ int fuse_dir_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in
 	return 0;
 }
 
+int fuse_getxattr_initialize_in(struct bpf_fuse_args *fa,
+				struct fuse_getxattr_io *fgio,
+				struct dentry *dentry, const char *name, void *value,
+				size_t size)
+{
+	*fgio = (struct fuse_getxattr_io) {
+		.fgi.size = size,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+		.opcode = FUSE_GETXATTR,
+		.in_numargs = 2,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(fgio->fgi),
+			.value = &fgio->fgi,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = strlen(name) + 1,
+			.max_size = XATTR_NAME_MAX + 1,
+			.flags = BPF_FUSE_MUST_ALLOCATE | BPF_FUSE_VARIABLE_SIZE,
+			.value =  (void *) name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_getxattr_initialize_out(struct bpf_fuse_args *fa,
+				 struct fuse_getxattr_io *fgio,
+				 struct dentry *dentry, const char *name, void *value,
+				 size_t size)
+{
+	fa->flags = size ? FUSE_BPF_OUT_ARGVAR : 0;
+	fa->out_numargs = 1;
+	if (size) {
+		fa->out_args[0].size = size;
+		fa->out_args[0].max_size = size;
+		fa->out_args[0].flags = BPF_FUSE_VARIABLE_SIZE;
+		fa->out_args[0].value = value;
+	} else {
+		fa->out_args[0].size = sizeof(fgio->fgo);
+		fa->out_args[0].value = &fgio->fgo;
+	}
+	return 0;
+}
+
+int fuse_getxattr_backing(struct bpf_fuse_args *fa, int *out,
+			  struct dentry *dentry, const char *name, void *value,
+			  size_t size)
+{
+	ssize_t ret = vfs_getxattr(&init_user_ns,
+				   get_fuse_dentry(dentry)->backing_path.dentry,
+				   fa->in_args[1].value, value, size);
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR)
+		fa->out_args[0].size = ret;
+	else
+		((struct fuse_getxattr_out *)fa->out_args[0].value)->size = ret;
+
+	return 0;
+}
+
+int fuse_getxattr_finalize(struct bpf_fuse_args *fa, int *out,
+			   struct dentry *dentry, const char *name, void *value,
+			   size_t size)
+{
+	struct fuse_getxattr_out *fgo;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR) {
+		*out = fa->out_args[0].size;
+		return 0;
+	}
+
+	fgo = fa->out_args[0].value;
+
+	*out = fgo->size;
+	return 0;
+}
+
+int fuse_listxattr_initialize_in(struct bpf_fuse_args *fa,
+				 struct fuse_getxattr_io *fgio,
+				 struct dentry *dentry, char *list, size_t size)
+{
+	*fgio = (struct fuse_getxattr_io) {
+		.fgi.size = size,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+		.opcode = FUSE_LISTXATTR,
+		.in_numargs = 1,
+		.in_args[0] =
+			(struct bpf_fuse_arg) {
+				.size = sizeof(fgio->fgi),
+				.value = &fgio->fgi,
+			},
+	};
+
+	return 0;
+}
+
+int fuse_listxattr_initialize_out(struct bpf_fuse_args *fa,
+				  struct fuse_getxattr_io *fgio,
+				  struct dentry *dentry, char *list, size_t size)
+{
+	fa->out_numargs = 1;
+
+	if (size) {
+		fa->flags = FUSE_BPF_OUT_ARGVAR;
+		fa->out_args[0].size = size;
+		fa->out_args[0].max_size = size;
+		fa->out_args[0].flags = BPF_FUSE_VARIABLE_SIZE;
+		fa->out_args[0].value = (void *)list;
+	} else {
+		fa->out_args[0].size = sizeof(fgio->fgo);
+		fa->out_args[0].value = &fgio->fgo;
+	}
+	return 0;
+}
+
+int fuse_listxattr_backing(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+			   char *list, size_t size)
+{
+	*out = vfs_listxattr(get_fuse_dentry(dentry)->backing_path.dentry, list, size);
+
+	if (*out < 0)
+		return *out;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR)
+		fa->out_args[0].size = *out;
+	else
+		((struct fuse_getxattr_out *)fa->out_args[0].value)->size = *out;
+
+	return 0;
+}
+
+int fuse_listxattr_finalize(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+			    char *list, size_t size)
+{
+	struct fuse_getxattr_out *fgo;
+
+	if (fa->error_in)
+		return 0;
+
+	if (fa->flags & FUSE_BPF_OUT_ARGVAR) {
+		*out = fa->out_args[0].size;
+		return 0;
+	}
+
+	fgo = fa->out_args[0].value;
+	*out = fgo->size;
+	return 0;
+}
+
+int fuse_setxattr_initialize_in(struct bpf_fuse_args *fa,
+				struct fuse_setxattr_in *fsxi,
+				struct dentry *dentry, const char *name,
+				const void *value, size_t size, int flags)
+{
+	*fsxi = (struct fuse_setxattr_in) {
+		.size = size,
+		.flags = flags,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+		.opcode = FUSE_SETXATTR,
+		.in_numargs = 3,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(*fsxi),
+			.value = fsxi,
+		},
+		.in_args[1] = (struct bpf_fuse_arg) {
+			.size = strlen(name) + 1,
+			.max_size = XATTR_NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+			.value =  (void *) name,
+		},
+		.in_args[2] = (struct bpf_fuse_arg) {
+			.size = size,
+			.max_size = XATTR_SIZE_MAX,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+			.value = (void *) value,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_setxattr_initialize_out(struct bpf_fuse_args *fa,
+				 struct fuse_setxattr_in *fsxi,
+				 struct dentry *dentry, const char *name,
+				 const void *value, size_t size, int flags)
+{
+	return 0;
+}
+
+int fuse_setxattr_backing(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+			  const char *name, const void *value, size_t size,
+			  int flags)
+{
+	*out = vfs_setxattr(&init_user_ns,
+			    get_fuse_dentry(dentry)->backing_path.dentry, name,
+			    (void *) value, size, flags);
+	return 0;
+}
+
+int fuse_setxattr_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+			   const char *name, const void *value, size_t size,
+			   int flags)
+{
+	return 0;
+}
+
+int fuse_removexattr_initialize_in(struct bpf_fuse_args *fa,
+				   struct fuse_dummy_io *unused,
+				   struct dentry *dentry, const char *name)
+{
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = get_fuse_inode(dentry->d_inode)->nodeid,
+		.opcode = FUSE_REMOVEXATTR,
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = strlen(name) + 1,
+			.max_size = XATTR_NAME_MAX + 1,
+			.flags = BPF_FUSE_VARIABLE_SIZE | BPF_FUSE_MUST_ALLOCATE,
+			.value =  (void *) name,
+		},
+	};
+
+	return 0;
+}
+
+int fuse_removexattr_initialize_out(struct bpf_fuse_args *fa,
+				    struct fuse_dummy_io *unused,
+				    struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
+int fuse_removexattr_backing(struct bpf_fuse_args *fa, int *out,
+			     struct dentry *dentry, const char *name)
+{
+	struct path *backing_path = &get_fuse_dentry(dentry)->backing_path;
+
+	/* TODO account for changes of the name by prefilter */
+	*out = vfs_removexattr(&init_user_ns, backing_path->dentry, name);
+	return 0;
+}
+
+int fuse_removexattr_finalize(struct bpf_fuse_args *fa, int *out,
+			      struct dentry *dentry, const char *name)
+{
+	return 0;
+}
+
 static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 370fe944387e..b313a45c7774 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1578,6 +1578,61 @@ int fuse_dir_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in
 int fuse_dir_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
 				  struct file *file, loff_t start, loff_t end, int datasync);
 
+struct fuse_getxattr_io {
+	struct fuse_getxattr_in fgi;
+	struct fuse_getxattr_out fgo;
+};
+
+int fuse_getxattr_initialize_in(struct bpf_fuse_args *fa, struct fuse_getxattr_io *fgio,
+				struct dentry *dentry, const char *name, void *value,
+				size_t size);
+int fuse_getxattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_getxattr_io *fgio,
+				 struct dentry *dentry, const char *name, void *value,
+				 size_t size);
+int fuse_getxattr_backing(struct bpf_fuse_args *fa, int *out,
+			  struct dentry *dentry, const char *name, void *value,
+			  size_t size);
+int fuse_getxattr_finalize(struct bpf_fuse_args *fa, int *out,
+			   struct dentry *dentry, const char *name, void *value,
+			   size_t size);
+
+int fuse_listxattr_initialize_in(struct bpf_fuse_args *fa,
+				 struct fuse_getxattr_io *fgio,
+				 struct dentry *dentry, char *list, size_t size);
+int fuse_listxattr_initialize_out(struct bpf_fuse_args *fa,
+				  struct fuse_getxattr_io *fgio,
+				  struct dentry *dentry, char *list, size_t size);
+int fuse_listxattr_backing(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+			   char *list, size_t size);
+int fuse_listxattr_finalize(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
+			    char *list, size_t size);
+
+int fuse_setxattr_initialize_in(struct bpf_fuse_args *fa,
+				struct fuse_setxattr_in *fsxi,
+				struct dentry *dentry, const char *name,
+				const void *value, size_t size, int flags);
+int fuse_setxattr_initialize_out(struct bpf_fuse_args *fa,
+				 struct fuse_setxattr_in *fsxi,
+				 struct dentry *dentry, const char *name,
+				 const void *value, size_t size, int flags);
+int fuse_setxattr_backing(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+			  const char *name, const void *value, size_t size,
+			  int flags);
+int fuse_setxattr_finalize(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
+			   const char *name, const void *value, size_t size,
+			   int flags);
+
+int fuse_removexattr_initialize_in(struct bpf_fuse_args *fa,
+				   struct fuse_dummy_io *unused,
+				   struct dentry *dentry, const char *name);
+int fuse_removexattr_initialize_out(struct bpf_fuse_args *fa,
+				    struct fuse_dummy_io *unused,
+				    struct dentry *dentry, const char *name);
+int fuse_removexattr_backing(struct bpf_fuse_args *fa, int *out,
+			     struct dentry *dentry, const char *name);
+int fuse_removexattr_finalize(struct bpf_fuse_args *fa, int *out,
+			      struct dentry *dentry, const char *name);
+
 struct fuse_read_iter_out {
 	uint64_t ret;
 };
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0d3e7177fce0..96728bd907ce 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -115,6 +115,14 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	struct fuse_getxattr_out outarg;
 	ssize_t ret;
 
+#ifdef CONFIG_FUSE_BPF
+	if (fuse_bpf_backing(inode, struct fuse_getxattr_io, ret,
+			       fuse_listxattr_initialize_in, fuse_listxattr_initialize_out,
+			       fuse_listxattr_backing, fuse_listxattr_finalize,
+			       entry, list, size))
+		return ret;
+#endif
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
@@ -182,6 +190,16 @@ static int fuse_xattr_get(const struct xattr_handler *handler,
 			 struct dentry *dentry, struct inode *inode,
 			 const char *name, void *value, size_t size)
 {
+#ifdef CONFIG_FUSE_BPF
+	int err;
+
+	if (fuse_bpf_backing(inode, struct fuse_getxattr_io, err,
+			       fuse_getxattr_initialize_in, fuse_getxattr_initialize_out,
+			       fuse_getxattr_backing, fuse_getxattr_finalize,
+			       dentry, name, value, size))
+		return err;
+#endif
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
@@ -194,6 +212,24 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
 			  const char *name, const void *value, size_t size,
 			  int flags)
 {
+#ifdef CONFIG_FUSE_BPF
+	int err;
+	bool handled;
+
+	if (value)
+		handled = fuse_bpf_backing(inode, struct fuse_setxattr_in, err,
+			       fuse_setxattr_initialize_in, fuse_setxattr_initialize_out,
+			       fuse_setxattr_backing, fuse_setxattr_finalize,
+			       dentry, name, value, size, flags);
+	else
+		handled = fuse_bpf_backing(inode, struct fuse_dummy_io, err,
+			       fuse_removexattr_initialize_in, fuse_removexattr_initialize_out,
+			       fuse_removexattr_backing, fuse_removexattr_finalize,
+			       dentry, name);
+	if (handled)
+		return err;
+#endif
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-- 
2.37.3.998.g577e59143f-goog

