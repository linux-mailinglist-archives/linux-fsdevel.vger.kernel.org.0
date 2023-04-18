Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44C46E5715
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjDRBps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjDRBpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:45:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBE977C
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 81-20020a251854000000b00b8f5b60b760so11393070yby.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782125; x=1684374125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9AGDYeuciPVrN915Qcuh9H5YY4BpsMk+FO3fkMyYec=;
        b=VrPrsw2bmIPnUEb2XN3ynu2DfaIBg5kjX6yHgZ+daQdf4ahQzkoZoDDJ/j3zK9mhn0
         ihY05K+k0Wdzb+pobv2yPCs/mtGZLkjsBIBCNie6c+RAIF2PN2A4TYaV+awyzNs/97JO
         4QvTBNjWrWQld0yZckQ8YWsYK/0ESvJMFy0QKQuc1LZA3usE9Eik7oeDIO2SD9GAEjlV
         b6Byxc+kS4ICk2MND+KAZIzsj03hdQU2XOmxLL8wMOJdjLkHLRiM72bO2UEsaoU33HAw
         BETE2SUeDZaNZOTmoWT9KJSdOYkkwz4mCp2S23gxi4Ts1cpkx4bIb6ox0s83mhudTU9Z
         RX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782125; x=1684374125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9AGDYeuciPVrN915Qcuh9H5YY4BpsMk+FO3fkMyYec=;
        b=F71QagR0VNBVZD2dhxGr4qK0QstONJTQO+PEVBeKSUVJFVDHpUu03wXxgtFo1eg9c0
         THjC9o0pV+YMPcxTiCshT7BEgtJc7TUnGEq8Df5QyCMi17NQxc0W7jX3kkhUXKQ4v5Th
         p2R9NPb8Nfv1gBS3lnht9U7giyV5TvBHZ0MHXUC9Lfk+pioUk8YYrBLlUAY7Y/SccaNw
         VsKXudwZY2Vg38SBmYnljDG02EBCmAv/3UkkZeTrzICVOouqeKR3YvsyayWGMfPl+Zne
         mAGzWcXYJ4yo2flIIxo5xHn3Prbt2whFdXg3Z+41CRXBy3lCgRyqawQifIM5CSb1pXR4
         SG4w==
X-Gm-Message-State: AAQBX9eIHDFSDNGHCxVwSHz7cj42y5SCXbxR70UtZirOdO6Mq61DF+RH
        q/IHVA9/Md5dmGTpxvyZmsc/TS/1hCA=
X-Google-Smtp-Source: AKy350ZLirn3I/BrcVzO0YqPwNPD1HbdzOUcnYLbOs6JaJ1QgTQX8WAFlA2B666sWoEpeNpU9WPT5G7v98g=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a05:690c:d91:b0:54f:e88d:79ba with SMTP id
 da17-20020a05690c0d9100b0054fe88d79bamr9715005ywb.5.1681782125267; Mon, 17
 Apr 2023 18:42:05 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:33 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-34-drosen@google.com>
Subject: [RFC PATCH v3 33/37] fuse-bpf: Add userspace pre/post filters
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
index 9217e9f83d98..1de302fc91b6 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -14,6 +14,163 @@
 #include <linux/namei.h>
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
@@ -60,9 +217,11 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
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
@@ -88,6 +247,16 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
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
@@ -117,6 +286,16 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
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
index ad7d9d1e6da5..139f40b70228 100644
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
index b7bc8260a537..bea5f1698127 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -620,7 +620,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	return err;
 }
 
-static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
+void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
 {
 	void *p;
 	u32 newlen = buf->size + bytes;
@@ -640,7 +640,7 @@ static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
 	return p + newlen - bytes;
 }
 
-static u32 fuse_ext_size(size_t size)
+u32 fuse_ext_size(size_t size)
 {
 	return FUSE_REC_ALIGN(sizeof(struct fuse_ext_header) + size);
 }
@@ -700,7 +700,7 @@ static int get_create_ext(struct fuse_args *args,
 	return err;
 }
 
-static void free_ext_value(struct fuse_args *args)
+void free_ext_value(struct fuse_args *args)
 {
 	if (args->is_ext)
 		kfree(args->in_args[args->ext_idx].value);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 15962ab3b381..0504c136632d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -304,6 +304,17 @@ struct fuse_page_desc {
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
@@ -322,10 +333,12 @@ struct fuse_args {
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
 
@@ -1165,6 +1178,22 @@ void fuse_request_end(struct fuse_req *req);
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
index e779064f5fad..bbcda421ee8e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -520,6 +520,7 @@ enum fuse_ext_type {
 	/* Types 0..31 are reserved for fuse_secctx_header */
 	FUSE_MAX_NR_SECCTX	= 31,
 	FUSE_EXT_GROUPS		= 32,
+	FUSE_ERROR_IN		= 33,
 };
 
 enum fuse_opcode {
-- 
2.40.0.634.g4ca3ef3211-goog

