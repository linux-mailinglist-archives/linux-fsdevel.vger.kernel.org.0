Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD25EB58F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiIZXUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiIZXTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDEB2CCE
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-350b9af86e8so46021807b3.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=4aH9WjQOeQQx2PJx5YUK/k9FfDLlxDnoz2TckhpfaO8=;
        b=owJtIFFajyoIIzra3aBaBUn0U8VES46+dTIZYx3WvH4q1sD68GlGUOH78paFBToAjz
         hka1LoouNb3ejladAjidizXbJmp0sJ7oMrRq8F7plJi9efDspgdtHjxCvsZTXlBdgyl0
         3sQ84XxkNc/BKtpaMCpn/ekmseu7leDNvb572pvHFXR53NWRSEOKlQDkQwecSwr874fF
         B9u/TNQrnaBbcyVg7vXpMiz72HFWnbSGzUYRsqa7K7a7wVLM4yah9NwHi8XW4Z7YJaV4
         28WRpWqewbGR5XrzIGQpLYENmhpluQPf9uxPMfPtOutkWPPGb4+q5F5PC8h3YFgHfydF
         Ss1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=4aH9WjQOeQQx2PJx5YUK/k9FfDLlxDnoz2TckhpfaO8=;
        b=xeFlDR7XxuR7frT2iP/5YZuOXpu9OCHRERCJ5JIzfLnhvZwGj8e/Wv1VyNu0WzPPsZ
         caH6qrAHnYqEfHIrqpzcL3qc4sXh3q4F+qMdkPKYshHBJ1nfT9QgQsFPpNIsw9z/ra3u
         l3cLHlGQg+fooIkk6KtUVHOGHmKgxKaBDMV1ZuuEWJzlr8hHvqAqNnp/9oZRo3wV2yXH
         hyYVIbzuWaICNeT6unDiadSJOwX/NHf/Saih9gXS7kcxlwVOzsJtQeR+0Rm+bAspEpm8
         luExxgd0WyAyUXMqoh3hRh96zHf6p8UuDiVwapbQQdVbkqYT+OHkHnGKWOwcR96xc/Gs
         lsAQ==
X-Gm-Message-State: ACrzQf0DQsKJOv66vNx8GqRueQF7DzGtE/rboYo3GMXuIzVL2s6qlKNs
        wenCNie/F8hZMSfESozEqdKSg1KlWYY=
X-Google-Smtp-Source: AMsMyM6gCp5D5lZ+hYmr0RklbZNK5kjwwuChTXIjTFC5duGJMseZMT5jOSiRIselwHmo6GNwDw+9eveQL4g=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a81:3985:0:b0:350:7c64:cfcc with SMTP id
 g127-20020a813985000000b003507c64cfccmr15428496ywa.226.1664234352106; Mon, 26
 Sep 2022 16:19:12 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:12 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-17-drosen@google.com>
Subject: [PATCH 16/26] fuse-bpf: support FUSE_READDIR
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
 fs/fuse/backing.c         | 162 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  18 +++++
 fs/fuse/readdir.c         |  22 ++++++
 include/uapi/linux/fuse.h |   6 ++
 4 files changed, 208 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index cf4ad9f4fe10..a31199064dc7 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1312,6 +1312,168 @@ int fuse_unlink_finalize(struct bpf_fuse_args *fa, int *out,
 	return 0;
 }
 
+int fuse_readdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_read_io *frio,
+			    struct file *file, struct dir_context *ctx,
+			    bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*fa = (struct bpf_fuse_args) {
+		.nodeid = ff->nodeid,
+		.opcode = FUSE_READDIR,
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
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
+int fuse_readdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_read_io *frio,
+				struct file *file, struct dir_context *ctx,
+				bool *force_again, bool *allow_force, bool is_continued)
+{
+	u8 *page = (u8 *)__get_free_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	fa->flags = FUSE_BPF_OUT_ARGVAR;
+	fa->out_numargs = 2;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(frio->fro),
+		.value = &frio->fro,
+	};
+	fa->out_args[1] = (struct bpf_fuse_arg) {
+		.size = PAGE_SIZE,
+		.max_size = PAGE_SIZE,
+		.flags = BPF_FUSE_VARIABLE_SIZE,
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
+static int filldir(struct dir_context *ctx, const char *name, int namelen,
+		   loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct extfuse_ctx *ec = container_of(ctx, struct extfuse_ctx, ctx);
+	struct fuse_dirent *fd = (struct fuse_dirent *)(ec->addr + ec->offset);
+
+	if (ec->offset + sizeof(struct fuse_dirent) + namelen > PAGE_SIZE)
+		return -ENOMEM;
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
+	return 0;
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
+int fuse_readdir_backing(struct bpf_fuse_args *fa, int *out,
+			 struct file *file, struct dir_context *ctx,
+			 bool *force_again, bool *allow_force, bool is_continued)
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
+int fuse_readdir_finalize(struct bpf_fuse_args *fa, int *out,
+			    struct file *file, struct dir_context *ctx,
+			    bool *force_again, bool *allow_force, bool is_continued)
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
 int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
 			      struct inode *inode, int mask)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f427a7bb367c..8780a50be244 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1572,6 +1572,24 @@ int fuse_lookup_finalize(struct bpf_fuse_args *fa, struct dentry **out,
 			 struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
+struct fuse_read_io {
+	struct fuse_read_in fri;
+	struct fuse_read_out fro;
+};
+
+int fuse_readdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_read_io *frio,
+			       struct file *file, struct dir_context *ctx,
+			       bool *force_again, bool *allow_force, bool is_continued);
+int fuse_readdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_read_io *frio,
+				struct file *file, struct dir_context *ctx,
+				bool *force_again, bool *allow_force, bool is_continued);
+int fuse_readdir_backing(struct bpf_fuse_args *fa, int *out,
+			 struct file *file, struct dir_context *ctx,
+			 bool *force_again, bool *allow_force, bool is_continued);
+int fuse_readdir_finalize(struct bpf_fuse_args *fa, int *out,
+			    struct file *file, struct dir_context *ctx,
+			    bool *force_again, bool *allow_force, bool is_continued);
+
 int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
 			      struct inode *inode, int mask);
 int fuse_access_initialize_out(struct bpf_fuse_args *fa, struct fuse_access_in *fai,
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index b4e565711045..07da8570e337 100644
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
@@ -571,6 +573,26 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	int err;
 
+#ifdef CONFIG_FUSE_BPF
+	bool bpf_ret = false;
+	bool allow_force;
+	bool force_again = false;
+	bool is_continued = false;
+
+again:
+	bpf_ret = fuse_bpf_backing(inode, struct fuse_read_io, err,
+			       fuse_readdir_initialize_in, fuse_readdir_initialize_out,
+			       fuse_readdir_backing, fuse_readdir_finalize,
+			       file, ctx, &force_again, &allow_force, is_continued);
+	if (force_again && err >= 0) {
+		is_continued = true;
+		goto again;
+	}
+
+	if (bpf_ret)
+		return err;
+#endif
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 8c80c146e69b..b7736cb4bdaf 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -701,6 +701,12 @@ struct fuse_read_in {
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
2.37.3.998.g577e59143f-goog

