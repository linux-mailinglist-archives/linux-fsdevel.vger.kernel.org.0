Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB46E5712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjDRBpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjDRBpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:45:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E59ED4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552e3fa8f2fso32405067b3.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782123; x=1684374123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rV9cf7X8542M+vZlF6IZmm0T2c7Hcn7L+aL9IBbyW5E=;
        b=HzUxzGdXoVkcjZV6vHWK2fyeDSJjSY1BBS0UdnnsTptpTqqiHorVFtUY2wrJbm+wO6
         c6YZbS6lKh3efNHCQ50jJX0wC8VyZjZRkK23zqrpmzD4ei1yb0QYNd5rcDWau5SzeBJQ
         rDlcg6fdSokuniQsaZDb6N8xlmOwZBb8POwJL9DzFUs4EG1RzaiKuvjbe3Lo7t9bQE9x
         7KtfUpluZQaqe3VCF32gmQurOzqALEDbob0EvuC9YrxPDt/0W9mtlVP65GhxaB+gMeEQ
         r1ro2/gZJ93/hQh+dmunABaKF8jUu1yGu0CShwO4GzI+5HpmwSJfNjIOArphd+PrRqgI
         uiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782123; x=1684374123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rV9cf7X8542M+vZlF6IZmm0T2c7Hcn7L+aL9IBbyW5E=;
        b=Mtt1QOAA6KcaYb88Udo3SUEJ/XYumAWs07iB91Y+xi9UlC91l9EblB6HF8MAZU8xoI
         ouPNuUrl7rEX2ieUfhCY6opY7+cpI1Tq2Zn1zMyaSpUnRKB/YoQ7uqKerhsnwcEwRs4a
         Ift0DsOkNC2JJRDUwfI/rp4KHs3kbrlLw/e26MtMjPoax1+mY/EVdfhnF0HnSkOJZ/6A
         jJcq80EfZ8zpxFMwFNf3jxEN+5ZyXmAtBZOFsDgkED/L63FxNeeItzpFcjGWPis2+o2m
         j0hR1GsqttJMhk0wueL8EdHBmqJVmI+aPLPKIBHYWIv/qsw49rccQ7tiCTcsQS0dE8bE
         rGHg==
X-Gm-Message-State: AAQBX9cPEHfA//SnuziiQR2HEy2dNUtwfw9Pge8qZIHPxDT+18FAiNPB
        tA9LdU7mSRq+UolCbWAKttzEfzGjNFk=
X-Google-Smtp-Source: AKy350brwRJR3viQIbnQAfQLMqCkkFC/uJkI1XPJ61jychKX9KIwFh23vN/gKLI87pp9DsQRargy36UV8QQ=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:da89:0:b0:b8f:4f1d:be06 with SMTP id
 n131-20020a25da89000000b00b8f4f1dbe06mr10985720ybf.11.1681782122938; Mon, 17
 Apr 2023 18:42:02 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:32 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-33-drosen@google.com>
Subject: [RFC PATCH v3 32/37] fuse-bpf: Call bpf for pre/post filters
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
        Daniel Rosenberg <drosen@google.com>
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

This allows altering input or output parameters to fuse calls that will
be handled directly by the backing filesystems. BPF programs can signal
whether the entire operation should instead go through regular fuse, or
if a postfilter call is needed.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c | 606 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 606 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d5ba1e334e69..9217e9f83d98 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -14,6 +14,27 @@
 #include <linux/namei.h>
 #include <linux/uio.h>
 
+static inline void bpf_fuse_set_in_immutable(struct bpf_fuse_args *fa)
+{
+	int i;
+
+	for (i = 0; i < FUSE_MAX_ARGS_IN; i++)
+		if (fa->in_args[i].is_buffer)
+			fa->in_args[i].buffer->flags |= BPF_FUSE_IMMUTABLE;
+}
+
+static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
+{
+	int i;
+
+	for (i = 0; i < FUSE_MAX_ARGS_IN; i++)
+		if (fa->in_args[i].is_buffer && (fa->in_args[i].buffer->flags & BPF_FUSE_ALLOCATED))
+			kfree(fa->in_args[i].buffer->data);
+	for (i = 0; i < FUSE_MAX_ARGS_OUT; i++)
+		if (fa->out_args[i].is_buffer && (fa->out_args[i].buffer->flags & BPF_FUSE_ALLOCATED))
+			kfree(fa->out_args[i].buffer->data);
+}
+
 /*
  * expression statement to wrap the backing filter logic
  * struct inode *inode: inode with bpf and backing inode
@@ -23,6 +44,10 @@
  *     up fa and io based on args
  * void initialize_out(struct bpf_fuse_args *fa, io *in_out, args...): function that sets
  *     up fa and io based on args
+ * int call_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta, io *in_out): Calls
+ *     the struct_op prefilter function for the given fuse op
+ * int call_prostfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta, io *in_out): Calls
+ *     the struct_op postfilter function for the given fuse op
  * int backing(struct fuse_bpf_args_internal *fa, args...): function that actually performs
  *     the backing io operation
  * void *finalize(struct fuse_bpf_args *, args...): function that performs any final
@@ -30,13 +55,16 @@
  */
 #define bpf_fuse_backing(inode, io, out,				\
 			 initialize_in, initialize_out,			\
+			 call_prefilter, call_postfilter,		\
 			 backing, finalize, args...)			\
 ({									\
 	struct fuse_inode *fuse_inode = get_fuse_inode(inode);		\
+	struct fuse_ops *fuse_ops = fuse_inode->bpf_ops;		\
 	struct bpf_fuse_args fa = { 0 };				\
 	bool initialized = false;					\
 	bool handled = false;						\
 	ssize_t res;							\
+	int bpf_next;							\
 	io feo = { 0 };							\
 	int error = 0;							\
 									\
@@ -49,16 +77,46 @@
 		if (error)						\
 			break;						\
 									\
+		fa.info.opcode |= FUSE_PREFILTER;			\
+		if (fuse_ops)						\
+			bpf_next = call_prefilter(fuse_ops,		\
+						&fa.info, &feo);	\
+		else							\
+			bpf_next = BPF_FUSE_CONTINUE;			\
+		if (bpf_next < 0) {					\
+			error = bpf_next;				\
+			break;						\
+		}							\
+									\
+		bpf_fuse_set_in_immutable(&fa);				\
+									\
 		error = initialize_out(&fa, &feo, args);		\
 		if (error)						\
 			break;						\
 									\
 		initialized = true;					\
+		if (bpf_next == BPF_FUSE_USER) {			\
+			handled = false;				\
+			break;						\
+		}							\
+									\
+		fa.info.opcode &= ~FUSE_PREFILTER;			\
 									\
 		error = backing(&fa, out, args);			\
 		if (error < 0)						\
 			fa.info.error_in = error;			\
 									\
+		if (bpf_next == BPF_FUSE_CONTINUE)			\
+			break;						\
+									\
+		fa.info.opcode |= FUSE_POSTFILTER;			\
+		if (bpf_next == BPF_FUSE_POSTFILTER)			\
+			bpf_next = call_postfilter(fuse_ops, &fa.info, &feo);\
+		if (bpf_next < 0) {					\
+			error = bpf_next;				\
+			break;						\
+		}							\
+									\
 	} while (false);						\
 									\
 	if (initialized && handled) {					\
@@ -66,6 +124,7 @@
 		if (res)						\
 			error = res;					\
 	}								\
+	bpf_fuse_free_alloced(&fa);					\
 									\
 	*out = error ? _Generic((*out),					\
 			default :					\
@@ -351,6 +410,34 @@ static int fuse_open_initialize_out(struct bpf_fuse_args *fa, struct fuse_open_a
 	return 0;
 }
 
+static int fuse_open_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_open_args *open)
+{
+	if (meta->opcode == (FUSE_OPEN | FUSE_PREFILTER)) {
+		if (ops->open_prefilter)
+			return ops->open_prefilter(meta, &open->in);
+	}
+	if (meta->opcode == (FUSE_OPENDIR | FUSE_PREFILTER)) {
+		if (ops->opendir_prefilter)
+			return ops->opendir_prefilter(meta, &open->in);
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_open_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_open_args *open)
+{
+	if (meta->opcode == (FUSE_OPEN | FUSE_POSTFILTER)) {
+		if (ops->open_postfilter)
+			return ops->open_postfilter(meta, &open->in, &open->out);
+	}
+	if (meta->opcode == (FUSE_OPENDIR | FUSE_POSTFILTER)) {
+		if (ops->opendir_postfilter)
+			return ops->opendir_postfilter(meta, &open->in, &open->out);
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_open_backing(struct bpf_fuse_args *fa, int *out,
 			     struct inode *inode, struct file *file, bool isdir)
 {
@@ -419,6 +506,7 @@ int fuse_bpf_open(int *out, struct inode *inode, struct file *file, bool isdir)
 {
 	return bpf_fuse_backing(inode, struct fuse_open_args, out,
 				fuse_open_initialize_in, fuse_open_initialize_out,
+				fuse_open_prefilter, fuse_open_postfilter,
 				fuse_open_backing, fuse_open_finalize,
 				inode, file, isdir);
 }
@@ -484,6 +572,22 @@ static int fuse_create_open_initialize_out(struct bpf_fuse_args *fa, struct fuse
 	return 0;
 }
 
+static int fuse_create_open_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_create_open_args *args)
+{
+	if (ops->create_open_prefilter)
+		return ops->create_open_prefilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_create_open_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_create_open_args *args)
+{
+	if (ops->create_open_postfilter)
+		return ops->create_open_postfilter(meta, &args->in, &args->name, &args->entry_out, &args->open_out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_open_file_backing(struct inode *inode, struct file *file)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -586,12 +690,16 @@ static int fuse_create_open_finalize(struct bpf_fuse_args *fa, int *out,
 	return 0;
 }
 
+
+
 int fuse_bpf_create_open(int *out, struct inode *dir, struct dentry *entry,
 			 struct file *file, unsigned int flags, umode_t mode)
 {
 	return bpf_fuse_backing(dir, struct fuse_create_open_args, out,
 				fuse_create_open_initialize_in,
 				fuse_create_open_initialize_out,
+				fuse_create_open_prefilter,
+				fuse_create_open_postfilter,
 				fuse_create_open_backing,
 				fuse_create_open_finalize,
 				dir, entry, file, flags, mode);
@@ -652,6 +760,38 @@ static int fuse_releasedir_initialize_in(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_release_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_release_in *args)
+{
+	if (ops->release_prefilter)
+		return ops->release_prefilter(meta, args);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_release_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *args)
+{
+	if (ops->release_postfilter)
+		return ops->release_postfilter(meta, args);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_releasedir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_release_in *args)
+{
+	if (ops->releasedir_prefilter)
+		return ops->releasedir_prefilter(meta, args);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_releasedir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *args)
+{
+	if (ops->releasedir_postfilter)
+		return ops->releasedir_postfilter(meta, args);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_releasedir_initialize_out(struct bpf_fuse_args *fa,
 					  struct fuse_release_in *fri,
 					  struct inode *inode, struct file *file)
@@ -677,6 +817,7 @@ int fuse_bpf_release(int *out, struct inode *inode, struct file *file)
 {
 	return bpf_fuse_backing(inode, struct fuse_release_in, out,
 				fuse_release_initialize_in, fuse_release_initialize_out,
+				fuse_release_prefilter, fuse_release_postfilter,
 				fuse_release_backing, fuse_release_finalize,
 				inode, file);
 }
@@ -685,6 +826,7 @@ int fuse_bpf_releasedir(int *out, struct inode *inode, struct file *file)
 {
 	return bpf_fuse_backing(inode, struct fuse_release_in, out,
 				fuse_releasedir_initialize_in, fuse_releasedir_initialize_out,
+				fuse_releasedir_prefilter, fuse_releasedir_postfilter,
 				fuse_release_backing, fuse_release_finalize, inode, file);
 }
 
@@ -717,6 +859,22 @@ static int fuse_flush_initialize_out(struct bpf_fuse_args *fa, struct fuse_flush
 	return 0;
 }
 
+static int fuse_flush_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_flush_in *args)
+{
+	if (ops->flush_prefilter)
+		return ops->flush_prefilter(meta, args);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_flush_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_flush_in *args)
+{
+	if (ops->flush_postfilter)
+		return ops->flush_postfilter(meta, args);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_flush_backing(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
 {
 	struct fuse_file *fuse_file = file->private_data;
@@ -737,6 +895,7 @@ int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t
 {
 	return bpf_fuse_backing(inode, struct fuse_flush_in, out,
 				fuse_flush_initialize_in, fuse_flush_initialize_out,
+				fuse_flush_prefilter, fuse_flush_postfilter,
 				fuse_flush_backing, fuse_flush_finalize,
 				file, id);
 }
@@ -780,6 +939,22 @@ static int fuse_lseek_initialize_out(struct bpf_fuse_args *fa, struct fuse_lseek
 	return 0;
 }
 
+static int fuse_lseek_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_lseek_args *args)
+{
+	if (ops->lseek_prefilter)
+		return ops->lseek_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_lseek_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_lseek_args *args)
+{
+	if (ops->lseek_postfilter)
+		return ops->lseek_postfilter(meta, &args->in, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out,
 			      struct file *file, loff_t offset, int whence)
 {
@@ -826,6 +1001,7 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
 {
 	return bpf_fuse_backing(inode, struct fuse_lseek_args, out,
 				fuse_lseek_initialize_in, fuse_lseek_initialize_out,
+				fuse_lseek_prefilter, fuse_lseek_postfilter,
 				fuse_lseek_backing, fuse_lseek_finalize,
 				file, offset, whence);
 }
@@ -878,6 +1054,22 @@ static int fuse_copy_file_range_initialize_out(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_copy_file_range_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_copy_file_range_args *args)
+{
+	if (ops->copy_file_range_prefilter)
+		return ops->copy_file_range_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_copy_file_range_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_copy_file_range_args *args)
+{
+	if (ops->copy_file_range_postfilter)
+		return ops->copy_file_range_postfilter(meta, &args->in, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_copy_file_range_backing(struct bpf_fuse_args *fa, ssize_t *out, struct file *file_in,
 					loff_t pos_in, struct file *file_out, loff_t pos_out, size_t len,
 					unsigned int flags)
@@ -912,6 +1104,8 @@ int fuse_bpf_copy_file_range(ssize_t *out, struct inode *inode, struct file *fil
 	return bpf_fuse_backing(inode, struct fuse_copy_file_range_args, out,
 				fuse_copy_file_range_initialize_in,
 				fuse_copy_file_range_initialize_out,
+				fuse_copy_file_range_prefilter,
+				fuse_copy_file_range_postfilter,
 				fuse_copy_file_range_backing,
 				fuse_copy_file_range_finalize,
 				file_in, pos_in, file_out, pos_out, len, flags);
@@ -947,6 +1141,22 @@ static int fuse_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync
 	return 0;
 }
 
+static int fuse_fsync_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_fsync_in *in)
+{
+	if (ops->fsync_prefilter)
+		return ops->fsync_prefilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_fsync_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in)
+{
+	if (ops->fsync_postfilter)
+		return ops->fsync_postfilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_fsync_backing(struct bpf_fuse_args *fa, int *out,
 			      struct file *file, loff_t start, loff_t end, int datasync)
 {
@@ -969,6 +1179,7 @@ int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t star
 {
 	return bpf_fuse_backing(inode, struct fuse_fsync_in, out,
 				fuse_fsync_initialize_in, fuse_fsync_initialize_out,
+				fuse_fsync_prefilter, fuse_fsync_postfilter,
 				fuse_fsync_backing, fuse_fsync_finalize,
 				file, start, end, datasync);
 }
@@ -1003,10 +1214,27 @@ static int fuse_dir_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_f
 	return 0;
 }
 
+static int fuse_dir_fsync_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_fsync_in *in)
+{
+	if (ops->dir_fsync_prefilter)
+		return ops->fsync_prefilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_dir_fsync_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in)
+{
+	if (ops->dir_fsync_postfilter)
+		return ops->dir_fsync_postfilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
 int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
 {
 	return bpf_fuse_backing(inode, struct fuse_fsync_in, out,
 				fuse_dir_fsync_initialize_in, fuse_dir_fsync_initialize_out,
+				fuse_dir_fsync_prefilter, fuse_dir_fsync_postfilter,
 				fuse_fsync_backing, fuse_fsync_finalize,
 				file, start, end, datasync);
 }
@@ -1076,6 +1304,22 @@ static int fuse_getxattr_initialize_out(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_getxattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_getxattr_args *args)
+{
+	if (ops->getxattr_prefilter)
+		return ops->getxattr_prefilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_getxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_args *args)
+{
+	if (ops->getxattr_postfilter)
+		return ops->getxattr_postfilter(meta, &args->in, &args->name, &args->value, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_getxattr_backing(struct bpf_fuse_args *fa, int *out,
 				 struct dentry *dentry, const char *name, void *value,
 				 size_t size)
@@ -1121,6 +1365,7 @@ int fuse_bpf_getxattr(int *out, struct inode *inode, struct dentry *dentry, cons
 {
 	return bpf_fuse_backing(inode, struct fuse_getxattr_args, out,
 				fuse_getxattr_initialize_in, fuse_getxattr_initialize_out,
+				fuse_getxattr_prefilter, fuse_getxattr_postfilter,
 				fuse_getxattr_backing, fuse_getxattr_finalize,
 				dentry, name, value, size);
 }
@@ -1173,6 +1418,22 @@ static int fuse_listxattr_initialize_out(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_listxattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_getxattr_args *args)
+{
+	if (ops->listxattr_prefilter)
+		return ops->listxattr_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_listxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_args *args)
+{
+	if (ops->listxattr_postfilter)
+		return ops->listxattr_postfilter(meta, &args->in, &args->value, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_listxattr_backing(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
 				  char *list, size_t size)
 {
@@ -1212,6 +1473,7 @@ int fuse_bpf_listxattr(ssize_t *out, struct inode *inode, struct dentry *dentry,
 {
 	return bpf_fuse_backing(inode, struct fuse_getxattr_args, out,
 				fuse_listxattr_initialize_in, fuse_listxattr_initialize_out,
+				fuse_listxattr_prefilter, fuse_listxattr_postfilter,
 				fuse_listxattr_backing, fuse_listxattr_finalize,
 				dentry, list, size);
 }
@@ -1277,6 +1539,22 @@ static int fuse_setxattr_initialize_out(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_setxattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_setxattr_args *args)
+{
+	if (ops->setxattr_prefilter)
+		return ops->setxattr_prefilter(meta, &args->in, &args->name, &args->value);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_setxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_setxattr_args *args)
+{
+	if (ops->setxattr_postfilter)
+		return ops->setxattr_postfilter(meta, &args->in, &args->name, &args->value);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_setxattr_backing(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
 				 const char *name, const void *value, size_t size,
 				 int flags)
@@ -1300,6 +1578,7 @@ int fuse_bpf_setxattr(int *out, struct inode *inode, struct dentry *dentry,
 {
 	return bpf_fuse_backing(inode, struct fuse_setxattr_args, out,
 			       fuse_setxattr_initialize_in, fuse_setxattr_initialize_out,
+			       fuse_setxattr_prefilter, fuse_setxattr_postfilter,
 			       fuse_setxattr_backing, fuse_setxattr_finalize,
 			       dentry, name, value, size, flags);
 }
@@ -1336,6 +1615,22 @@ static int fuse_removexattr_initialize_out(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_removexattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				      struct fuse_buffer *in)
+{
+	if (ops->removexattr_prefilter)
+		return ops->removexattr_prefilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_removexattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				       struct fuse_buffer *in)
+{
+	if (ops->removexattr_postfilter)
+		return ops->removexattr_postfilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_removexattr_backing(struct bpf_fuse_args *fa, int *out,
 				    struct dentry *dentry, const char *name)
 {
@@ -1356,6 +1651,7 @@ int fuse_bpf_removexattr(int *out, struct inode *inode, struct dentry *dentry, c
 {
 	return bpf_fuse_backing(inode, struct fuse_buffer, out,
 				fuse_removexattr_initialize_in, fuse_removexattr_initialize_out,
+				fuse_removexattr_prefilter, fuse_removexattr_postfilter,
 				fuse_removexattr_backing, fuse_removexattr_finalize,
 				dentry, name);
 }
@@ -1446,6 +1742,22 @@ static int fuse_file_read_iter_initialize_out(struct bpf_fuse_args *fa, struct f
 	return 0;
 }
 
+static int fuse_file_read_iter_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_file_read_iter_args *args)
+{
+	if (ops->read_iter_prefilter)
+		return ops->read_iter_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_file_read_iter_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_file_read_iter_args *args)
+{
+	if (ops->read_iter_postfilter)
+		return ops->read_iter_postfilter(meta, &args->in, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_file_read_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
 				       struct kiocb *iocb, struct iov_iter *to)
 {
@@ -1513,6 +1825,8 @@ int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *ioc
 	return bpf_fuse_backing(inode, struct fuse_file_read_iter_args, out,
 				fuse_file_read_iter_initialize_in,
 				fuse_file_read_iter_initialize_out,
+				fuse_file_read_iter_prefilter,
+				fuse_file_read_iter_postfilter,
 				fuse_file_read_iter_backing,
 				fuse_file_read_iter_finalize,
 				iocb, to);
@@ -1562,6 +1876,22 @@ static int fuse_file_write_iter_initialize_out(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_write_iter_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_file_write_iter_args *args)
+{
+	if (ops->write_iter_prefilter)
+		return ops->write_iter_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_write_iter_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_file_write_iter_args *args)
+{
+	if (ops->write_iter_postfilter)
+		return ops->write_iter_postfilter(meta, &args->in, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_file_write_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
 					struct kiocb *iocb, struct iov_iter *from)
 {
@@ -1626,6 +1956,8 @@ int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *io
 	return bpf_fuse_backing(inode, struct fuse_file_write_iter_args, out,
 				fuse_file_write_iter_initialize_in,
 				fuse_file_write_iter_initialize_out,
+				fuse_write_iter_prefilter,
+				fuse_write_iter_postfilter,
 				fuse_file_write_iter_backing,
 				fuse_file_write_iter_finalize,
 				iocb, from);
@@ -1701,6 +2033,22 @@ static int fuse_file_fallocate_initialize_out(struct bpf_fuse_args *fa,
 	return 0;
 }
 
+static int fuse_file_fallocate_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_fallocate_in *in)
+{
+	if (ops->file_fallocate_prefilter)
+		return ops->file_fallocate_prefilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_file_fallocate_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_fallocate_in *in)
+{
+	if (ops->file_fallocate_postfilter)
+		return ops->file_fallocate_postfilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_file_fallocate_backing(struct bpf_fuse_args *fa, int *out,
 				       struct file *file, int mode, loff_t offset, loff_t length)
 {
@@ -1723,6 +2071,8 @@ int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, in
 	return bpf_fuse_backing(inode, struct fuse_fallocate_in, out,
 				fuse_file_fallocate_initialize_in,
 				fuse_file_fallocate_initialize_out,
+				fuse_file_fallocate_prefilter,
+				fuse_file_fallocate_postfilter,
 				fuse_file_fallocate_backing,
 				fuse_file_fallocate_finalize,
 				file, mode, offset, length);
@@ -1790,6 +2140,22 @@ static int fuse_lookup_initialize_out(struct bpf_fuse_args *fa, struct fuse_look
 	return 0;
 }
 
+static int fuse_lookup_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_lookup_args *args)
+{
+	if (ops->lookup_prefilter)
+		return ops->lookup_prefilter(meta, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_lookup_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_lookup_args *args)
+{
+	if (ops->lookup_postfilter)
+		return ops->lookup_postfilter(meta, &args->name, &args->out, &args->bpf_entries);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_lookup_backing(struct bpf_fuse_args *fa, struct dentry **out, struct inode *dir,
 			       struct dentry *entry, unsigned int flags)
 {
@@ -1968,6 +2334,7 @@ int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry
 {
 	return bpf_fuse_backing(dir, struct fuse_lookup_args, out,
 				fuse_lookup_initialize_in, fuse_lookup_initialize_out,
+				fuse_lookup_prefilter, fuse_lookup_postfilter,
 				fuse_lookup_backing, fuse_lookup_finalize,
 				dir, entry, flags);
 }
@@ -2034,6 +2401,22 @@ static int fuse_mknod_initialize_out(struct bpf_fuse_args *fa, struct fuse_mknod
 	return 0;
 }
 
+static int fuse_mknod_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_mknod_args *args)
+{
+	if (ops->mknod_prefilter)
+		return ops->mknod_prefilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_mknod_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_mknod_args *args)
+{
+	if (ops->mknod_postfilter)
+		return ops->mknod_postfilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_mknod_backing(struct bpf_fuse_args *fa, int *out,
 			      struct inode *dir, struct dentry *entry, umode_t mode, dev_t rdev)
 {
@@ -2086,6 +2469,7 @@ int fuse_bpf_mknod(int *out, struct inode *dir, struct dentry *entry, umode_t mo
 {
 	return bpf_fuse_backing(dir, struct fuse_mknod_args, out,
 				fuse_mknod_initialize_in, fuse_mknod_initialize_out,
+				fuse_mknod_prefilter, fuse_mknod_postfilter,
 				fuse_mknod_backing, fuse_mknod_finalize,
 				dir, entry, mode, rdev);
 }
@@ -2187,10 +2571,27 @@ static int fuse_mkdir_finalize(struct bpf_fuse_args *fa, int *out,
 	return 0;
 }
 
+static int fuse_mkdir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_args *args)
+{
+	if (ops->mkdir_prefilter)
+		return ops->mkdir_prefilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_mkdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				 struct fuse_mkdir_args *args)
+{
+	if (ops->mkdir_prefilter)
+		return ops->mkdir_postfilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
 int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode)
 {
 	return bpf_fuse_backing(dir, struct fuse_mkdir_args, out,
 				fuse_mkdir_initialize_in, fuse_mkdir_initialize_out,
+				fuse_mkdir_prefilter, fuse_mkdir_postfilter,
 				fuse_mkdir_backing, fuse_mkdir_finalize,
 				dir, entry, mode);
 }
@@ -2224,6 +2625,22 @@ static int fuse_rmdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_buffe
 	return 0;
 }
 
+static int fuse_rmdir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_buffer *name)
+{
+	if (ops->rmdir_prefilter)
+		return ops->rmdir_prefilter(meta, name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_rmdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	if (ops->rmdir_postfilter)
+		return ops->rmdir_postfilter(meta, name);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_rmdir_backing(struct bpf_fuse_args *fa, int *out,
 			      struct inode *dir, struct dentry *entry)
 {
@@ -2258,6 +2675,7 @@ int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry)
 {
 	return bpf_fuse_backing(dir, struct fuse_buffer, out,
 				fuse_rmdir_initialize_in, fuse_rmdir_initialize_out,
+				fuse_rmdir_prefilter, fuse_rmdir_postfilter,
 				fuse_rmdir_backing, fuse_rmdir_finalize,
 				dir, entry);
 }
@@ -2400,6 +2818,22 @@ static int fuse_rename2_initialize_out(struct bpf_fuse_args *fa, struct fuse_ren
 	return 0;
 }
 
+static int fuse_rename2_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_rename2_args *args)
+{
+	if (ops->rename2_prefilter)
+		return ops->rename2_prefilter(meta, &args->in, &args->old_name, &args->new_name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_rename2_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_rename2_args *args)
+{
+	if (ops->rename2_postfilter)
+		return ops->rename2_postfilter(meta, &args->in, &args->old_name, &args->new_name);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_rename2_backing(struct bpf_fuse_args *fa, int *out,
 				struct inode *olddir, struct dentry *oldent,
 				struct inode *newdir, struct dentry *newent,
@@ -2427,6 +2861,7 @@ int fuse_bpf_rename2(int *out, struct inode *olddir, struct dentry *oldent,
 {
 	return bpf_fuse_backing(olddir, struct fuse_rename2_args, out,
 				fuse_rename2_initialize_in, fuse_rename2_initialize_out,
+				fuse_rename2_prefilter, fuse_rename2_postfilter,
 				fuse_rename2_backing, fuse_rename2_finalize,
 				olddir, oldent, newdir, newent, flags);
 }
@@ -2487,6 +2922,22 @@ static int fuse_rename_initialize_out(struct bpf_fuse_args *fa, struct fuse_rena
 	return 0;
 }
 
+static int fuse_rename_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_rename_args *args)
+{
+	if (ops->rename_prefilter)
+		return ops->rename_prefilter(meta, &args->in, &args->old_name, &args->new_name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_rename_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_rename_args *args)
+{
+	if (ops->rename_postfilter)
+		return ops->rename_postfilter(meta, &args->in, &args->old_name, &args->new_name);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_rename_backing(struct bpf_fuse_args *fa, int *out,
 			       struct inode *olddir, struct dentry *oldent,
 			       struct inode *newdir, struct dentry *newent)
@@ -2508,6 +2959,7 @@ int fuse_bpf_rename(int *out, struct inode *olddir, struct dentry *oldent,
 {
 	return bpf_fuse_backing(olddir, struct fuse_rename_args, out,
 				fuse_rename_initialize_in, fuse_rename_initialize_out,
+				fuse_rename_prefilter, fuse_rename_postfilter,
 				fuse_rename_backing, fuse_rename_finalize,
 				olddir, oldent, newdir, newent);
 }
@@ -2541,6 +2993,22 @@ static int fuse_unlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_buff
 	return 0;
 }
 
+static int fuse_unlink_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_buffer *name)
+{
+	if (ops->unlink_prefilter)
+		return ops->unlink_prefilter(meta, name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_unlink_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	if (ops->unlink_postfilter)
+		return ops->unlink_postfilter(meta, name);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_unlink_backing(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
 {
 	struct path backing_path;
@@ -2577,6 +3045,7 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 {
 	return bpf_fuse_backing(dir, struct fuse_buffer, out,
 				fuse_unlink_initialize_in, fuse_unlink_initialize_out,
+				fuse_unlink_prefilter, fuse_unlink_postfilter,
 				fuse_unlink_backing, fuse_unlink_finalize,
 				dir, entry);
 }
@@ -2629,6 +3098,23 @@ static int fuse_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_link_a
 	return 0;
 }
 
+static int fuse_link_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_link_args *args)
+{
+	if (ops->link_prefilter)
+		return ops->link_prefilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_link_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_link_args *args)
+{
+	if (ops->link_postfilter)
+		return ops->link_postfilter(meta, &args->in, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+
 static int fuse_link_backing(struct bpf_fuse_args *fa, int *out, struct dentry *entry,
 			     struct inode *dir, struct dentry *newent)
 {
@@ -2696,6 +3182,7 @@ int fuse_bpf_link(int *out, struct inode *inode, struct dentry *entry,
 {
 	return bpf_fuse_backing(inode, struct fuse_link_args, out,
 				fuse_link_initialize_in, fuse_link_initialize_out,
+				fuse_link_prefilter, fuse_link_postfilter,
 				fuse_link_backing, fuse_link_finalize,
 				entry, newdir, newent);
 }
@@ -2744,6 +3231,22 @@ static int fuse_getattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_get
 	return 0;
 }
 
+static int fuse_getattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_getattr_args *args)
+{
+	if (ops->getattr_prefilter)
+		return ops->getattr_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_getattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_getattr_args *args)
+{
+	if (ops->getattr_postfilter)
+		return ops->getattr_postfilter(meta, &args->in, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_getattr_backing(struct bpf_fuse_args *fa, int *out,
 				const struct dentry *entry, struct kstat *stat,
 				u32 request_mask, unsigned int flags)
@@ -2804,6 +3307,7 @@ int fuse_bpf_getattr(int *out, struct inode *inode, const struct dentry *entry,
 {
 	return bpf_fuse_backing(inode, struct fuse_getattr_args, out,
 				fuse_getattr_initialize_in, fuse_getattr_initialize_out,
+				fuse_getattr_prefilter, fuse_getattr_postfilter,
 				fuse_getattr_backing, fuse_getattr_finalize,
 				entry, stat, request_mask, flags);
 }
@@ -2883,6 +3387,22 @@ static int fuse_setattr_initialize_out(struct bpf_fuse_args *fa, struct fuse_set
 	return 0;
 }
 
+static int fuse_setattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_setattr_args *args)
+{
+	if (ops->setattr_prefilter)
+		return ops->setattr_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_setattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_setattr_args *args)
+{
+	if (ops->setattr_postfilter)
+		return ops->setattr_postfilter(meta, &args->in, &args->out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_setattr_backing(struct bpf_fuse_args *fa, int *out,
 				struct dentry *dentry, struct iattr *attr, struct file *file)
 {
@@ -2920,6 +3440,7 @@ int fuse_bpf_setattr(int *out, struct inode *inode, struct dentry *dentry, struc
 {
 	return bpf_fuse_backing(inode, struct fuse_setattr_args, out,
 				fuse_setattr_initialize_in, fuse_setattr_initialize_out,
+				fuse_setattr_prefilter, fuse_setattr_postfilter,
 				fuse_setattr_backing, fuse_setattr_finalize,
 				dentry, attr, file);
 }
@@ -2949,6 +3470,22 @@ static int fuse_statfs_initialize_out(struct bpf_fuse_args *fa, struct fuse_stat
 	return 0;
 }
 
+static int fuse_statfs_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_statfs_out *out)
+{
+	if (ops->statfs_prefilter)
+		return ops->statfs_prefilter(meta);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_statfs_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_statfs_out *out)
+{
+	if (ops->statfs_postfilter)
+		return ops->statfs_postfilter(meta, out);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_statfs_backing(struct bpf_fuse_args *fa, int *out,
 			       struct dentry *dentry, struct kstatfs *buf)
 {
@@ -2984,6 +3521,7 @@ int fuse_bpf_statfs(int *out, struct inode *inode, struct dentry *dentry, struct
 {
 	return bpf_fuse_backing(dentry->d_inode, struct fuse_statfs_out, out,
 				fuse_statfs_initialize_in, fuse_statfs_initialize_out,
+				fuse_statfs_prefilter, fuse_statfs_postfilter,
 				fuse_statfs_backing, fuse_statfs_finalize,
 				dentry, buf);
 }
@@ -3053,6 +3591,22 @@ static int fuse_get_link_initialize_out(struct bpf_fuse_args *fa, struct fuse_ge
 	return 0;
 }
 
+static int fuse_get_link_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_get_link_args *args)
+{
+	if (ops->get_link_prefilter)
+		return ops->get_link_prefilter(meta, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_get_link_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_get_link_args *args)
+{
+	if (ops->get_link_postfilter)
+		return ops->get_link_postfilter(meta, &args->name);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_get_link_backing(struct bpf_fuse_args *fa, const char **out,
 				 struct inode *inode, struct dentry *dentry,
 				 struct delayed_call *callback)
@@ -3092,6 +3646,7 @@ int fuse_bpf_get_link(const char **out, struct inode *inode, struct dentry *dent
 {
 	return bpf_fuse_backing(inode, struct fuse_get_link_args, out,
 				fuse_get_link_initialize_in, fuse_get_link_initialize_out,
+				fuse_get_link_prefilter, fuse_get_link_postfilter,
 				fuse_get_link_backing, fuse_get_link_finalize,
 				inode, dentry, callback);
 }
@@ -3142,6 +3697,22 @@ static int fuse_symlink_initialize_out(struct bpf_fuse_args *fa, struct fuse_sym
 	return 0;
 }
 
+static int fuse_symlink_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_symlink_args *args)
+{
+	if (ops->symlink_prefilter)
+		return ops->symlink_prefilter(meta, &args->name, &args->path);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_symlink_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_symlink_args *args)
+{
+	if (ops->symlink_postfilter)
+		return ops->symlink_postfilter(meta, &args->name, &args->path);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_symlink_backing(struct bpf_fuse_args *fa, int *out,
 				struct inode *dir, struct dentry *entry, const char *link, int len)
 {
@@ -3192,6 +3763,7 @@ int  fuse_bpf_symlink(int *out, struct inode *dir, struct dentry *entry, const c
 {
 	return bpf_fuse_backing(dir, struct fuse_symlink_args, out,
 				fuse_symlink_initialize_in, fuse_symlink_initialize_out,
+				fuse_symlink_prefilter, fuse_symlink_postfilter,
 				fuse_symlink_backing, fuse_symlink_finalize,
 				dir, entry, link, len);
 }
@@ -3265,6 +3837,22 @@ static int fuse_readdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_rea
 	return 0;
 }
 
+static int fuse_readdir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_read_args *args)
+{
+	if (ops->readdir_prefilter)
+		return ops->readdir_prefilter(meta, &args->in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_readdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_read_args *args)
+{
+	if (ops->readdir_postfilter)
+		return ops->readdir_postfilter(meta, &args->in, &args->out, &args->buffer);
+	return BPF_FUSE_CONTINUE;
+}
+
 struct fusebpf_ctx {
 	struct dir_context ctx;
 	u8 *addr;
@@ -3380,6 +3968,7 @@ int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct di
 again:
 	ret = bpf_fuse_backing(inode, struct fuse_read_args, out,
 			       fuse_readdir_initialize_in, fuse_readdir_initialize_out,
+			       fuse_readdir_prefilter, fuse_readdir_postfilter,
 			       fuse_readdir_backing, fuse_readdir_finalize,
 			       file, ctx, &force_again, &allow_force, is_continued);
 	if (force_again && *out >= 0) {
@@ -3416,6 +4005,22 @@ static int fuse_access_initialize_out(struct bpf_fuse_args *fa, struct fuse_acce
 	return 0;
 }
 
+static int fuse_access_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+			       struct fuse_access_in *in)
+{
+	if (ops->access_prefilter)
+		return ops->access_prefilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
+static int fuse_access_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
+				struct fuse_access_in *in)
+{
+	if (ops->access_postfilter)
+		return ops->access_postfilter(meta, in);
+	return BPF_FUSE_CONTINUE;
+}
+
 static int fuse_access_backing(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -3434,6 +4039,7 @@ int fuse_bpf_access(int *out, struct inode *inode, int mask)
 {
 	return bpf_fuse_backing(inode, struct fuse_access_in, out,
 				fuse_access_initialize_in, fuse_access_initialize_out,
+				fuse_access_prefilter, fuse_access_postfilter,
 				fuse_access_backing, fuse_access_finalize, inode, mask);
 }
 
-- 
2.40.0.634.g4ca3ef3211-goog

