Return-Path: <linux-fsdevel+bounces-15653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0F891123
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2C21F23F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E3813B581;
	Fri, 29 Mar 2024 01:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rr1EVrE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE6136E35
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677312; cv=none; b=EyW1sjrp2Dy7J07/uF49ElXrynJXzQVYsIJ3/EtWMqUzJgKcc6Cam3bHIT4QoSNSIgc1RRrW3CUUJtJqjIH66zYA2EuXP4DdbYoJDcu5NyqZclEtRjhApBJ7YWmZ4mQpfthwKalpyMv0wiT9UrpOfsmIZVMbyizknU3/PsC1Ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677312; c=relaxed/simple;
	bh=0MMp9URgTl3q02pasvnZIboYGP3n5FtVhyJWa7EOO6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jzM+WlY50O4fnCQb+rZmInzlVLgLPZ+F24aEK8GUFjWHGeWg8f6ZdTt+HYkSkxqStGseMjQd5tFBcCayUzIZRvjCXoko/+lNFT5wa7yZLVEcmO9jZX6iyMPq7UM1MVYp3xmb9lnW4BZw0rvurl7YI/kQXG/3WQgphnItMW8Z/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rr1EVrE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a3bb05c9bso25240207b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677309; x=1712282109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxI1XKtAfOqWqF4S724gatu41by9k0x994bvTDA+8mc=;
        b=3rr1EVrE6vJz5zZF0MzFKSOApyxCJ1gWuHiMuZDYKpI8SbQUtCqxeXFDcEOGIFH88r
         mClnbvXi/+L/gSNJu+c2u95mrWUtd1+HkiePHZO2uK80ajWF0sONYoSvCENaaHtWux9u
         7LHVEKz51rcXRgI0it0YeAjaWdleI3IKG6z/V73ZPx6Z4LQmv8JgBXo6TXZvo98DroLO
         a+C0vXSFAfXXT+xjVHZyZV5j/KtDnNC0+eUCU2WcdfiGWko+4BYaaW5DRdKyYDCdO10l
         tf/7vntb5t8v/zLZDHD2cJwlAurhKByKvrYEV9lGTk9fFx6P1JmWAfqz+Sb3+S3Wvaef
         0LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677309; x=1712282109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxI1XKtAfOqWqF4S724gatu41by9k0x994bvTDA+8mc=;
        b=evk8Px+msSDBU3dIg24Fr/zd3VUeGi3drUCOLHjvDBMDaaoLTzzTIFl2bxoJfc4s6A
         mE3b4//PtWZlpjcGIXwyVOoL/lngHo1HDqXQ0LIQFG7biHaHmee0S5NaBEZAPmOw5FdJ
         YMtgvG5BvO0J66ag/0CI3BS2nK5crPgKTcLob9xNNOsTAuqbs0t9Ckgp81PqOksZkMq+
         FdPuhslapZm5VRo0aQNNN27tU05M+G7tFPAYtthdUFEE7MNUL6Gv1VkfXtpbm78P4kky
         oON0p0F7oYS1pN+hXvRJ2tl4a7pu8o5lNQ1LXd5uUrXctCYz5Ca5chS+zN9ovSqi8rl8
         jZyw==
X-Forwarded-Encrypted: i=1; AJvYcCXMzi9uux5BHtDLCeo+xVfHkR0M0oqP1FRyvKhGgIgM9/Fwe6h1Cg1ukWndeVFISfWrvfoHegm5JcEjtaCwIGOOeojqOZ6ePzBxa4ojmA==
X-Gm-Message-State: AOJu0Ywsh1XO6PZTaKZGDwOgIVs8yi5iCKUMTyIcW7dzfIvM2ZvCBxiR
	a9d4L/scHTsiqigvwiQwx5LLpPTXzg51Z1FBFuI5y2iKN36yPWntdpBTuXt85V1ys6YBBOOkhKj
	KwA==
X-Google-Smtp-Source: AGHT+IGNBTlq0+EGPMU+HiHxZbFEWcdafvcP8XEsPnWaMVxWsw+zlkZHIH5AxV5uO27CGTp5IKDk+ZlrdgI=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:ca83:0:b0:614:26ed:19a9 with SMTP id
 m125-20020a0dca83000000b0061426ed19a9mr273364ywd.3.1711677309339; Thu, 28 Mar
 2024 18:55:09 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:46 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-32-drosen@google.com>
Subject: [RFC PATCH v4 31/36] fuse-bpf: Add userspace pre/post filters
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
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

This allows fuse-bpf to call out to userspace to handle pre and post
filters. Any of the inputs may be changed by the prefilter, so we must
handle up to 3 outputs. For the postfilter, our inputs include the
output arguments, so we must handle up to 5 inputs.

Additionally, we add an extension for passing the return code of
the backing call to the postfilter, adding one additional possible
output bringing the total to 4.

As long as you don't request both pre-filter and post-filter in
userspace, we will end up doing fewer round trips to userspace.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c         | 179 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c             |   2 +
 fs/fuse/dir.c             |   6 +-
 fs/fuse/fuse_i.h          |  33 ++++++-
 include/linux/bpf_fuse.h  |   1 +
 include/uapi/linux/fuse.h |   1 +
 6 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 8172144e557d..9227e62b8734 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -16,6 +16,163 @@
 #include <linux/splice.h>
 #include <linux/uio.h>
 
+static void set_in_args(struct fuse_in_arg *dst, struct bpf_fuse_arg *src)
+{
+	if (src->is_buffer) {
+		struct fuse_buffer *buffer = src->buffer;
+
+		*dst = (struct fuse_in_arg) {
+			.size = buffer->size,
+			.value = buffer->data,
+		};
+	} else {
+		*dst = (struct fuse_in_arg) {
+			.size = src->size,
+			.value = src->value,
+		};
+	}
+}
+
+static void set_out_args(struct fuse_arg *dst, struct bpf_fuse_arg *src)
+{
+	if (src->is_buffer) {
+		struct fuse_buffer *buffer = src->buffer;
+
+		// Userspace out args presents as much space as needed
+		*dst = (struct fuse_arg) {
+			.size = buffer->max_size,
+			.value = buffer->data,
+		};
+	} else {
+		*dst = (struct fuse_arg) {
+			.size = src->size,
+			.value = src->value,
+		};
+	}
+}
+
+static int get_err_in(uint32_t error, struct fuse_in_arg *ext)
+{
+	struct fuse_ext_header *xh;
+	uint32_t *err_in;
+	uint32_t err_in_size = fuse_ext_size(sizeof(*err_in));
+
+	xh = extend_arg(ext, err_in_size);
+	if (!xh)
+		return -ENOMEM;
+	xh->size = err_in_size;
+	xh->type = FUSE_ERROR_IN;
+
+	err_in = (uint32_t *)&xh[1];
+	*err_in = error;
+	return 0;
+}
+
+static int get_filter_ext(struct fuse_args *args)
+{
+	struct fuse_in_arg ext = { .size  = 0, .value = NULL };
+	int err = 0;
+
+	if (args->is_filter)
+		err = get_err_in(args->error_in, &ext);
+	if (!err && ext.size) {
+		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
+		args->is_ext = true;
+		args->ext_idx = args->in_numargs++;
+		args->in_args[args->ext_idx] = ext;
+	} else {
+		kfree(ext.value);
+	}
+	return err;
+}
+
+static ssize_t fuse_bpf_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *fa,
+				       unsigned short in_numargs, unsigned short out_numargs,
+				       struct bpf_fuse_arg *out_arg_array, bool add_out_to_in)
+{
+	int i;
+	ssize_t res;
+
+	struct fuse_args args = {
+		.nodeid = fa->info.nodeid,
+		.opcode = fa->info.opcode,
+		.error_in = fa->info.error_in,
+		.in_numargs = in_numargs,
+		.out_numargs = out_numargs,
+		.force = !!(fa->flags & FUSE_BPF_FORCE),
+		.out_argvar = !!(fa->flags & FUSE_BPF_OUT_ARGVAR),
+		.is_lookup = !!(fa->flags & FUSE_BPF_IS_LOOKUP),
+		.is_filter = true,
+	};
+
+	/* All out args must be writeable */
+	for (i = 0; i < out_numargs; ++i) {
+		struct fuse_buffer *buffer;
+
+		if (!out_arg_array[i].is_buffer)
+			continue;
+		buffer = out_arg_array[i].buffer;
+		if (!bpf_fuse_get_writeable(buffer, buffer->max_size, true))
+			return -ENOMEM;
+	}
+
+	/* Set in args */
+	for (i = 0; i < fa->in_numargs; ++i)
+		set_in_args(&args.in_args[i], &fa->in_args[i]);
+	if (add_out_to_in) {
+		for (i = 0; i < fa->out_numargs; ++i) {
+			set_in_args(&args.in_args[fa->in_numargs + i], &fa->out_args[i]);
+		}
+	}
+
+	/* Set out args */
+	for (i = 0; i < out_numargs; ++i)
+		set_out_args(&args.out_args[i], &out_arg_array[i]);
+
+	if (out_arg_array[out_numargs - 1].is_buffer) {
+		struct fuse_buffer *buff = out_arg_array[out_numargs - 1].buffer;
+
+		if (buff->flags & BPF_FUSE_VARIABLE_SIZE)
+			args.out_argvar = true;
+	}
+	if (add_out_to_in) {
+		res = get_filter_ext(&args);
+		if (res)
+			return res;
+	}
+	res = fuse_simple_request(fm, &args);
+
+	/* update used areas of buffers */
+	for (i = 0; i < out_numargs; ++i)
+		if (out_arg_array[i].is_buffer &&
+				(out_arg_array[i].buffer->flags & BPF_FUSE_VARIABLE_SIZE))
+			out_arg_array[i].buffer->size = args.out_args[i].size;
+	fa->ret = args.ret;
+
+	free_ext_value(&args);
+
+	return res;
+}
+
+static ssize_t fuse_prefilter_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *fa)
+{
+	uint32_t out_args = fa->in_numargs;
+
+	// mkdir and company are not permitted to change the name. This should be done at lookup
+	// Thus, these can't be set by the userspace prefilter
+	if (fa->in_args[fa->in_numargs - 1].is_buffer &&
+			(fa->in_args[fa->in_numargs - 1].buffer->flags & BPF_FUSE_IMMUTABLE))
+		out_args--;
+	return fuse_bpf_simple_request(fm, fa, fa->in_numargs, out_args,
+				       fa->in_args, false);
+}
+
+static ssize_t fuse_postfilter_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *fa)
+{
+	return fuse_bpf_simple_request(fm, fa, fa->in_numargs + fa->out_numargs, fa->out_numargs,
+				       fa->out_args, true);
+}
+
 static inline void bpf_fuse_set_in_immutable(struct bpf_fuse_args *fa)
 {
 	int i;
@@ -62,9 +219,11 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
 ({									\
 	struct fuse_inode *fuse_inode = get_fuse_inode(inode);		\
 	struct fuse_ops *fuse_ops = fuse_inode->bpf_ops;		\
+	struct fuse_mount *fm = get_fuse_mount(inode);			\
 	struct bpf_fuse_args fa = { 0 };				\
 	bool initialized = false;					\
 	bool handled = false;						\
+	bool locked;							\
 	ssize_t res;							\
 	int bpf_next;							\
 	io feo = { 0 };							\
@@ -90,6 +249,16 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
 			break;						\
 		}							\
 									\
+		if (bpf_next == BPF_FUSE_USER_PREFILTER) {		\
+			locked = fuse_lock_inode(inode);		\
+			res = fuse_prefilter_simple_request(fm, &fa);	\
+			fuse_unlock_inode(inode, locked);		\
+			if (res < 0) {					\
+				error = res;				\
+				break;					\
+			}						\
+			bpf_next = fa.ret;				\
+		}							\
 		bpf_fuse_set_in_immutable(&fa);				\
 									\
 		error = initialize_out(&fa, &feo, args);		\
@@ -119,6 +288,16 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
 			break;						\
 		}							\
 									\
+		if (!(bpf_next == BPF_FUSE_USER_POSTFILTER))		\
+			break;						\
+									\
+		locked = fuse_lock_inode(inode);			\
+		res = fuse_postfilter_simple_request(fm, &fa);		\
+		fuse_unlock_inode(inode, locked);			\
+		if (res < 0) {						\
+			error = res;					\
+			break;						\
+		}							\
 	} while (false);						\
 									\
 	if (initialized && handled) {					\
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e51ec198af3f..fca2ca440f55 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -521,6 +521,8 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 		BUG_ON(args->out_numargs == 0);
 		ret = args->out_args[args->out_numargs - 1].size;
 	}
+	if (args->is_filter && args->is_ext)
+		args->ret = req->out.h.error;
 	fuse_put_request(req);
 
 	return ret;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f5ab3b79b3cc..2167cbd04b0c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -640,7 +640,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	return err;
 }
 
-static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
+void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
 {
 	void *p;
 	u32 newlen = buf->size + bytes;
@@ -660,7 +660,7 @@ static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
 	return p + newlen - bytes;
 }
 
-static u32 fuse_ext_size(size_t size)
+u32 fuse_ext_size(size_t size)
 {
 	return FUSE_REC_ALIGN(sizeof(struct fuse_ext_header) + size);
 }
@@ -720,7 +720,7 @@ static int get_create_ext(struct fuse_args *args,
 	return err;
 }
 
-static void free_ext_value(struct fuse_args *args)
+void free_ext_value(struct fuse_args *args)
 {
 	if (args->is_ext)
 		kfree(args->in_args[args->ext_idx].value);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 665673d91753..c75822c433a0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -324,6 +324,17 @@ struct fuse_page_desc {
 	unsigned int offset;
 };
 
+/* To deal with bpf pre and post filters in userspace calls, we must support
+ * passing the inputs and outputs as inputs, and we must have enough space in
+ * outputs to handle all of the inputs. Plus one more for extensions.
+ */
+#define FUSE_EXTENDED_MAX_ARGS_IN (FUSE_MAX_ARGS_IN + FUSE_MAX_ARGS_OUT + 1)
+#if FUSE_MAX_ARGS_IN > FUSE_MAX_ARGS_OUT
+#define FUSE_EXTENDED_MAX_ARGS_OUT FUSE_MAX_ARGS_IN
+#else
+#define FUSE_EXTENDED_MAX_ARGS_OUT FUSE_MAX_ARGS_OUT
+#endif
+
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
@@ -342,10 +353,12 @@ struct fuse_args {
 	bool page_replace:1;
 	bool may_block:1;
 	bool is_ext:1;
+	bool is_filter:1;
 	bool is_lookup:1;
 	bool via_ioctl:1;
-	struct fuse_in_arg in_args[3];
-	struct fuse_arg out_args[2];
+	uint32_t ret;
+	struct fuse_in_arg in_args[FUSE_EXTENDED_MAX_ARGS_IN];
+	struct fuse_arg out_args[FUSE_EXTENDED_MAX_ARGS_OUT];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
 };
 
@@ -1194,6 +1207,22 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+/**
+ * Allocated/Reallocate extended header information
+ * Returns pointer to start of most recent allocation
+ */
+void *extend_arg(struct fuse_in_arg *buf, u32 bytes);
+
+/**
+ * Returns adjusted size field for extensions
+ */
+u32 fuse_ext_size(size_t size);
+
+/**
+ * Free allocated extended header information
+ */
+void free_ext_value(struct fuse_args *args);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 2183a7a45c92..159b850e1b46 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -64,6 +64,7 @@ struct bpf_fuse_args {
 	uint32_t in_numargs;
 	uint32_t out_numargs;
 	uint32_t flags;
+	uint32_t ret;
 	struct bpf_fuse_arg in_args[FUSE_MAX_ARGS_IN];
 	struct bpf_fuse_arg out_args[FUSE_MAX_ARGS_OUT];
 };
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 3417717c1a55..b37d5b015454 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -566,6 +566,7 @@ enum fuse_ext_type {
 	/* Types 0..31 are reserved for fuse_secctx_header */
 	FUSE_MAX_NR_SECCTX	= 31,
 	FUSE_EXT_GROUPS		= 32,
+	FUSE_ERROR_IN		= 33,
 };
 
 enum fuse_opcode {
-- 
2.44.0.478.gd926399ef9-goog


