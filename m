Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9265EB5A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiIZXVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIZXUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:20:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812CF7C
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y5-20020a25bb85000000b006af8f244604so7017586ybg.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=3kKQhUy3GgfTUs2XqsE2p/tpjXuKF60ZFWTA7axrd5g=;
        b=FJ35sU9CTuaufxxGlJsxtKwZ6iHg1TrEj44HRGuLcL1Yiuw9P4IY1Mipu1YMsNMYB6
         td4Xn7inBm4ZWrYkMFD4Gm+3NyLuz0Bkr8lb+BdysmqL9fkVfi3vwtPu5AmjBGaeVWzr
         abjsr6ArnbwmaQqU4at+bCD24exy2qCRyqv3RzFQbAE8rN5q7f9LRxn8ZNF1p1OpaAun
         cWBh7ES8935aOBz6sxNQyvt6swXeST1SNGKCNVWt4rEPiumszmJ5GKSYAVJEHnn+FKDm
         jfo5x+UHiiG55B/QLF3QC2WjH0nkoxfVuiNNN2esYIvM+wHlYtLM/40Zhj2/pO18vmHt
         +s9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=3kKQhUy3GgfTUs2XqsE2p/tpjXuKF60ZFWTA7axrd5g=;
        b=bZYUGlbMv/brQum1VnlZDE37CG6OcB9T9waoozswpNv7WUWP7J/jHxMgffzzE9Ss3T
         kIUGqN471eQ36OwhQPagMw57AK4/2bCK61jrDYt4OKTPnu81+gs3LOixFjvqcX7kqAkW
         YBMYx1gnTvKG00hUm94ZS1V6+/x4WhvHUYSOE52v1gBqNcWYEy2ktU5LjuD5Z79+Tc4f
         rf/s8HOjlKxnMqg3iwj+p5t0nOiqaSdUB7qzULyvATeTMigpWUJ7bf42g6Q/g6grwD1J
         ez88xXTv1uhGU/iv/4VZ8LrKR9/mIdKbPSwm29pN6rHcKcK0ypff7LLdy/ENFfRUK9Vs
         9gRg==
X-Gm-Message-State: ACrzQf0RBydbHb8I4p4IkzeZDGagskUa6xYKWLIHHya6Rbn+/z7pRqnR
        Z79ZA/H5MAgJpwvwuLVvFTOcGTrEjQQ=
X-Google-Smtp-Source: AMsMyM7e1l9e7JNsHdFJhhHVXJweh8dMrCEs+fDgUG+ci2JaksKMyEybOv2Ju8rlqilhOjxJt5O7SpM9uco=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:e6d5:0:b0:6bc:8d4:d76f with SMTP id
 d204-20020a25e6d5000000b006bc08d4d76fmr2226477ybh.582.1664234376269; Mon, 26
 Sep 2022 16:19:36 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:21 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-26-drosen@google.com>
Subject: [PATCH 25/26] fuse-bpf: Add userspace pre/post filters
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows fuse-bpf to call out to userspace to handle pre and post
filters. Any of the inputs may be changed by the prefilter, so we must
handle up to 3 outputs. For the postfilter, our inputs include the
output arguments, so we must handle up to 5 inputs.

As long as you don't request both pre-filter and post-filter in
userspace, we will end up doing fewer round trips to userspace.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c        | 70 ++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c            |  2 ++
 fs/fuse/fuse_i.h         | 42 ++++++++++++++++++++++--
 include/linux/bpf_fuse.h |  1 +
 4 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 485b6f1e8503..7a3b1fdb2c56 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -2681,3 +2681,73 @@ void __exit fuse_bpf_cleanup(void)
 {
 	kmem_cache_destroy(fuse_bpf_aio_request_cachep);
 }
+
+static ssize_t fuse_bpf_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *fa,
+				       unsigned short in_numargs, unsigned short out_numargs,
+				       struct bpf_fuse_arg *out_arg_array, bool add_out_to_in)
+{
+	int i;
+	uint32_t max_size;
+	ssize_t res;
+
+	struct fuse_args args = {
+		.nodeid = fa->nodeid,
+		.opcode = fa->opcode,
+		.error_in = fa->error_in,
+		.in_numargs = in_numargs,
+		.out_numargs = out_numargs,
+		.force = !!(fa->flags & FUSE_BPF_FORCE),
+		.out_argvar = !!(fa->flags & FUSE_BPF_OUT_ARGVAR),
+		.is_lookup = !!(fa->flags & FUSE_BPF_IS_LOOKUP),
+	};
+
+	/* Set in args */
+	for (i = 0; i < fa->in_numargs; ++i)
+		args.in_args[i] = (struct fuse_in_arg) {
+			.size = fa->in_args[i].size,
+			.value = fa->in_args[i].value,
+		};
+	if (add_out_to_in) {
+		for (i = 0; i < fa->out_numargs; ++i)
+			args.in_args[fa->in_numargs + i] = (struct fuse_in_arg) {
+				.size = fa->out_args[i].size,
+				.value = fa->out_args[i].value,
+			};
+	}
+
+	/* All out args must be writeable */
+	for (i = 0; i < out_numargs; ++i) {
+		max_size = out_arg_array[i].max_size ?: out_arg_array[i].size;
+		if (!bpf_fuse_get_writeable(&out_arg_array[i], max_size, true))
+			return -ENOMEM;
+	}
+
+	/* Set out args */
+	for (i = 0; i < out_numargs; ++i)
+		args.out_args[i] = (struct fuse_arg) {
+			.size = out_arg_array[i].size,
+			.value = out_arg_array[i].value,
+		};
+
+	res = fuse_simple_request(fm, &args);
+
+	/* update used areas of buffers */
+	for (i = 0; i < out_numargs; ++i)
+		if (out_arg_array[i].flags & BPF_FUSE_VARIABLE_SIZE)
+			out_arg_array[i].size = args.out_args[i].size;
+	fa->ret = args.ret;
+
+	return res;
+}
+
+ssize_t fuse_prefilter_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *fa)
+{
+	return fuse_bpf_simple_request(fm, fa, fa->in_numargs, fa->in_numargs,
+				       fa->in_args, false);
+}
+
+ssize_t fuse_postfilter_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *fa)
+{
+	return fuse_bpf_simple_request(fm, fa, fa->in_numargs + fa->out_numargs, fa->out_numargs,
+				       fa->out_args, true);
+}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 626dbbf92874..765bc95bd560 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -520,6 +520,8 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 		BUG_ON(args->out_numargs == 0);
 		ret = args->out_args[args->out_numargs - 1].size;
 	}
+	if (args->is_filter)
+		args->ret = req->out.h.error;
 	fuse_put_request(req);
 
 	return ret;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 07b50be2c6e4..a619c6eac6e5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -305,6 +305,17 @@ struct fuse_page_desc {
 	unsigned int offset;
 };
 
+/* To deal with bpf pre and post filters in userspace calls, we must support
+ * passing the inputs and outputs as inputs, and we must have enough space in
+ * outputs to handle all of the inputs.
+ */
+#define FUSE_EXTENDED_MAX_ARGS_IN (FUSE_MAX_ARGS_IN + FUSE_MAX_ARGS_OUT)
+#if FUSE_MAX_ARGS_IN > FUSE_MAX_ARGS_OUT
+#define FUSE_EXTENDED_MAX_ARGS_OUT FUSE_MAX_ARGS_IN
+#else
+#define FUSE_EXTENDED_MAX_ARGS_OUT FUSE_MAX_ARGS_OUT
+#endif
+
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
@@ -321,9 +332,11 @@ struct fuse_args {
 	bool page_zeroing:1;
 	bool page_replace:1;
 	bool may_block:1;
+	bool is_filter:1;
 	bool is_lookup:1;
-	struct fuse_in_arg in_args[3];
-	struct fuse_arg out_args[2];
+	uint32_t ret;
+	struct fuse_in_arg in_args[FUSE_EXTENDED_MAX_ARGS_IN];
+	struct fuse_arg out_args[FUSE_EXTENDED_MAX_ARGS_OUT];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
 };
 
@@ -1936,6 +1949,9 @@ static inline void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatf
 int __init fuse_bpf_init(void);
 void __exit fuse_bpf_cleanup(void);
 
+ssize_t fuse_prefilter_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *args);
+ssize_t fuse_postfilter_simple_request(struct fuse_mount *fm, struct bpf_fuse_args *args);
+
 static inline void fuse_bpf_set_in_ends(struct bpf_fuse_args *fa)
 {
 	int i;
@@ -1994,9 +2010,11 @@ static inline void fuse_bpf_free_alloced(struct bpf_fuse_args *fa)
 			 backing, finalize, args...)			\
 ({									\
 	struct fuse_inode *fuse_inode = get_fuse_inode(inode);		\
+	struct fuse_mount *fm = get_fuse_mount(inode);			\
 	struct bpf_fuse_args fa = { 0 };				\
 	bool initialized = false;					\
 	bool handled = false;						\
+	bool locked;							\
 	ssize_t res;							\
 	int bpf_next;							\
 	io feo = { 0 };							\
@@ -2021,6 +2039,16 @@ static inline void fuse_bpf_free_alloced(struct bpf_fuse_args *fa)
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
 		fuse_bpf_set_in_immutable(&fa);				\
 									\
 		error = initialize_out(&fa, &feo, args);		\
@@ -2051,6 +2079,16 @@ static inline void fuse_bpf_free_alloced(struct bpf_fuse_args *fa)
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
diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index ef5c8fdaffee..2802ca71ddd1 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -40,6 +40,7 @@ struct bpf_fuse_args {
 	uint32_t in_numargs;
 	uint32_t out_numargs;
 	uint32_t flags;
+	uint32_t ret;
 	struct bpf_fuse_arg in_args[FUSE_MAX_ARGS_IN];
 	struct bpf_fuse_arg out_args[FUSE_MAX_ARGS_OUT];
 };
-- 
2.37.3.998.g577e59143f-goog

