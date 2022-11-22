Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23590633316
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiKVCTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKVCRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:17:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D4E6EC7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o142-20020a257394000000b006eae582c285so5670019ybc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXC86U5/hdvmtqoI3CrBqri1fBKx6hffM6aKsOurzIQ=;
        b=nviEqECcUVQGFZCSjYX27H4M5ju7f+JT7lEyRab0UT5tVqqZE8Nr3TDs0EYlPUSSRs
         IgVAP+mJQk0CFNsd0y2gZllcV9H5NC6rztxOhHtbo2yj20wWri1irhqXA0aEpof27HPJ
         /2mVbS/N1xkIu4emdYQWAs34awPkiLIz1dX5QmHedJTpqS2auwDSAwRDXZ5kV4uw80bW
         lcrV3OSql4Gqyn+NM/cCyEw0DYv9BxSFlBZW3oVxq4MqyDQanhisbwCzf2ekYZQaJr9m
         slJntZYFnJ2tls7oCuJKp6UhuZbW7W7/FRkg2LQaPjFYBH1ZHSpGhD7doqxaX1FJJpKn
         tjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXC86U5/hdvmtqoI3CrBqri1fBKx6hffM6aKsOurzIQ=;
        b=stVeACrbtF+jLSue/DMaM4oMMSThBbxzrNMPwWKgQVJ/6DMyAShF9sXMuC6hCAEjso
         P6ZwpoS3zsjMTLF4o9iEZlzrv/D6kCvKNzxc1Vrdasw8t04mRkKdJNjQgvl9t8ZNI9Oj
         JV9KZKX69y0LImWHZB/IjUgn4U3EIFIumBTK05X8nv2iTpJBO4t/UwieSbhCVknalpUM
         6pRbU9/VAPEhf+OFC09Hrz7iUHOlP6UNkRYNlWDMzQ+V2+rLcLRLzDLdZYhBCxQBKmDi
         XfrB12ghfFkbO1lZN61RoqH+C5/r4oJnXyZxGAnIQ+GCDvpDKWKUYRoCtBVcVlyqpV/Y
         nPRA==
X-Gm-Message-State: ANoB5plc6McOcPVKS67Q7m0T574UXgdRhqQvBEhNbgkdXkylMkwA/JIw
        g1L9xypfpTaOz4Ygpe5FkQeyuIFvZKI=
X-Google-Smtp-Source: AA0mqf4BhlbPHTes02ABbjotB/JyZWY+vbUvzJOF4pcG5MOu08hPs+emLNEYY0m782nCmCcjPsBqaEVmAak=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a05:6902:729:b0:6dc:c7e9:17e0 with SMTP id
 l9-20020a056902072900b006dcc7e917e0mr5539541ybt.411.1669083385614; Mon, 21
 Nov 2022 18:16:25 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:29 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-15-drosen@google.com>
Subject: [RFC PATCH v2 14/21] fuse-bpf: support FUSE_READDIR
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c         | 185 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |   6 ++
 fs/fuse/readdir.c         |   5 ++
 include/uapi/linux/fuse.h |   6 ++
 4 files changed, 202 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 425815d7f5dc..a15b5c107cfe 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1597,6 +1597,191 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_read_io {
+	struct fuse_read_in fri;
+	struct fuse_read_out fro;
+};
+
+static int fuse_readdir_initialize_in(struct fuse_args *fa, struct fuse_read_io *frio,
+				      struct file *file, struct dir_context *ctx,
+				      bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*fa = (struct fuse_args) {
+		.nodeid = ff->nodeid,
+		.opcode = FUSE_READDIR,
+		.in_numargs = 1,
+		.in_args[0] = (struct fuse_in_arg) {
+			.size = sizeof(frio->fri),
+			.value = &frio->fri,
+		},
+	};
+
+	frio->fri = (struct fuse_read_in) {
+		.fh = ff->fh,
+		.offset = ctx->pos,
+		.size = PAGE_SIZE,
+	};
+
+	*force_again = false;
+	*allow_force = true;
+	return 0;
+}
+
+static int fuse_readdir_initialize_out(struct fuse_args *fa, struct fuse_read_io *frio,
+				       struct file *file, struct dir_context *ctx,
+				       bool *force_again, bool *allow_force, bool is_continued)
+{
+	u8 *page = (u8 *)__get_free_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	fa->out_argvar = true;
+	fa->out_numargs = 2;
+	fa->out_args[0] = (struct fuse_arg) {
+		.size = sizeof(frio->fro),
+		.value = &frio->fro,
+	};
+	fa->out_args[1] = (struct fuse_arg) {
+		.size = PAGE_SIZE,
+		.value = page,
+	};
+	frio->fro = (struct fuse_read_out) {
+		.again = 0,
+		.offset = 0,
+	};
+
+	return 0;
+}
+
+struct extfuse_ctx {
+	struct dir_context ctx;
+	u8 *addr;
+	size_t offset;
+};
+
+static bool filldir(struct dir_context *ctx, const char *name, int namelen,
+		   loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct extfuse_ctx *ec = container_of(ctx, struct extfuse_ctx, ctx);
+	struct fuse_dirent *fd = (struct fuse_dirent *)(ec->addr + ec->offset);
+
+	if (ec->offset + sizeof(struct fuse_dirent) + namelen > PAGE_SIZE)
+		return false;
+
+	*fd = (struct fuse_dirent) {
+		.ino = ino,
+		.off = offset,
+		.namelen = namelen,
+		.type = d_type,
+	};
+
+	memcpy(fd->name, name, namelen);
+	ec->offset += FUSE_DIRENT_SIZE(fd);
+
+	return true;
+}
+
+static int parse_dirfile(char *buf, size_t nbytes, struct dir_context *ctx)
+{
+	while (nbytes >= FUSE_NAME_OFFSET) {
+		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
+		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+
+		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
+			return -EIO;
+		if (reclen > nbytes)
+			break;
+		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+			return -EIO;
+
+		ctx->pos = dirent->off;
+		if (!dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
+				dirent->type))
+			break;
+
+		buf += reclen;
+		nbytes -= reclen;
+	}
+
+	return 0;
+}
+
+
+static int fuse_readdir_backing(struct fuse_args *fa, int *out,
+				struct file *file, struct dir_context *ctx,
+				bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_dir = ff->backing_file;
+	struct fuse_read_out *fro = fa->out_args[0].value;
+	struct extfuse_ctx ec;
+
+	ec = (struct extfuse_ctx) {
+		.ctx.actor = filldir,
+		.ctx.pos = ctx->pos,
+		.addr = fa->out_args[1].value,
+	};
+
+	if (!ec.addr)
+		return -ENOMEM;
+
+	if (!is_continued)
+		backing_dir->f_pos = file->f_pos;
+
+	*out = iterate_dir(backing_dir, &ec.ctx);
+	if (ec.offset == 0)
+		*allow_force = false;
+	fa->out_args[1].size = ec.offset;
+
+	fro->offset = ec.ctx.pos;
+	fro->again = false;
+
+	return *out;
+}
+
+static int fuse_readdir_finalize(struct fuse_args *fa, int *out,
+				 struct file *file, struct dir_context *ctx,
+				 bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_read_out *fro = fa->out_args[0].value;
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_dir = ff->backing_file;
+
+	*out = parse_dirfile(fa->out_args[1].value, fa->out_args[1].size, ctx);
+	*force_again = !!fro->again;
+	if (*force_again && !*allow_force)
+		*out = -EINVAL;
+
+	ctx->pos = fro->offset;
+	backing_dir->f_pos = fro->offset;
+
+	free_page((unsigned long)fa->out_args[1].value);
+	return *out;
+}
+
+int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
+{
+	int ret;
+	bool allow_force;
+	bool force_again = false;
+	bool is_continued = false;
+
+again:
+	ret = fuse_bpf_backing(inode, struct fuse_read_io, out,
+			       fuse_readdir_initialize_in, fuse_readdir_initialize_out,
+			       fuse_readdir_backing, fuse_readdir_finalize,
+			       file, ctx, &force_again, &allow_force, is_continued);
+	if (force_again && *out >= 0) {
+		is_continued = true;
+		goto again;
+	}
+
+	return ret;
+}
+
 static int fuse_access_initialize_in(struct fuse_args *fa, struct fuse_access_in *fai,
 				     struct inode *inode, int mask)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 25cedaa9014c..0ea3fb74caab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1414,6 +1414,7 @@ int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *ioc
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
@@ -1484,6 +1485,11 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
 	return 0;
 }
 
+static inline int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 {
 	return 0;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index e8deaacf1832..f32105679057 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -20,6 +20,8 @@ static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 
 	if (!fc->do_readdirplus)
 		return false;
+	if (fi->nodeid == 0)
+		return false;
 	if (!fc->readdirplus_auto)
 		return true;
 	if (test_and_clear_bit(FUSE_I_ADVISE_RDPLUS, &fi->state))
@@ -582,6 +584,9 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_readdir(&err, inode, file, ctx))
+		return err;
+
 	mutex_lock(&ff->readdir.lock);
 
 	err = UNCACHED;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e49e5a8e044c..8c13483f240e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -709,6 +709,12 @@ struct fuse_read_in {
 	uint32_t	padding;
 };
 
+struct fuse_read_out {
+	uint64_t	offset;
+	uint32_t	again;
+	uint32_t	padding;
+};
+
 #define FUSE_COMPAT_WRITE_IN_SIZE 24
 
 struct fuse_write_in {
-- 
2.38.1.584.g0f3c55d4c2-goog

