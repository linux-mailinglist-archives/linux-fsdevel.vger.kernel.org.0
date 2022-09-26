Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C015EB5A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiIZXVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiIZXUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:20:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2536168
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-350b9af86e8so46027167b3.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=IbvaNd7xkv6qLbqXS+UwVE+DkcAWaiLiz540c1KNyRs=;
        b=Z8drp21nnocmfjMVXdPLwqgBmC3rl5N9wLVtRBXkcdTiN9HL3S6/MfQRW9TJe265Vt
         qIEo6wfrg6T5gPZQAhFk9PRhRrQCCKzwn67IENRgTm5cKoTyPfR4yFIem3b7ML0UqNkh
         wrn5vUuQNOVMfApnU54UGot+lFj616P9bn0fgmX+I/ybxgVnEtSZvWVMYMmS84QDzAaf
         iwQoLTHVzAxyl8KQep8J20Wmd1FEDMkTsYS8NmnIWcQJEXKJHpNg9rMSw1BAboKU3Qhe
         Hxk6yKFEmTOIq4FJhVZijMLOuUHsubi/mdb8wAvhgFsINlZ6IhiuvGWlyI8TbbgSCVYg
         KNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=IbvaNd7xkv6qLbqXS+UwVE+DkcAWaiLiz540c1KNyRs=;
        b=GGbu4OImBQZIg9Q1eMpCVIF12O765CVP0EP+vj9RMv66rZ8hZVMTyadAnxMnMnuRLR
         4USf8AR73o6GYpmynOnZa0FT1xp8RiE+QIORf0taxA9NvBYEHSeaD4Wgej+AinoqlXzu
         xUnYSfmYmXIN2pyyTA4lntS4xoaqAkJF+r8D8G0HNNVn8eT8XkIPZPgR55ZD3EtuaAiJ
         FwkAxfxzZGxCuRHTYWO+kgdCBDwbAHTZynVoSzPJad7OCKS8TKS4szcIwJkDbv6MJi/M
         gbi9HP/QULgR/8YIuWxRRuBbqmZFwbyS7Kc8aGEj9a/s+r146ctKupV9nqzLrUOkFZ3d
         4/zQ==
X-Gm-Message-State: ACrzQf1Kbl2Lq60ZDReOgKCtjWPTEawTAav/+d0fmdM+mq/Y9LFkFKeq
        Gpyu+Brw+6Bz9t8wNeNeAYWTBQy8Od8=
X-Google-Smtp-Source: AMsMyM6vYxoJSrr3KuG3WwQXnjLQZz0oa4O4bxGnmvWSze+nbZAdsph4QDPFsfZxi4J2rflsR1JgdH5WodE=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a0d:d345:0:b0:349:f274:a0f with SMTP id
 v66-20020a0dd345000000b00349f2740a0fmr21914221ywd.13.1664234373645; Mon, 26
 Sep 2022 16:19:33 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:20 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-25-drosen@google.com>
Subject: [PATCH 24/26] fuse-bpf: Call bpf for pre/post filters
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

This allows altering input or output parameters to fuse calls that will
be handled directly by the backing filesystems. BPF programs can signal
whether the entire operation should instead go through regular fuse, or
if a postfilter call is needed.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/fuse_i.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6fb5c7a1ff11..07b50be2c6e4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1936,6 +1936,46 @@ static inline void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatf
 int __init fuse_bpf_init(void);
 void __exit fuse_bpf_cleanup(void);
 
+static inline void fuse_bpf_set_in_ends(struct bpf_fuse_args *fa)
+{
+	int i;
+
+	for (i = 0; i < FUSE_MAX_ARGS_IN; i++)
+		fa->in_args[i].end_offset = (void *)
+			((char *)fa->in_args[i].value
+			+ fa->in_args[i].size);
+}
+
+static inline void fuse_bpf_set_in_immutable(struct bpf_fuse_args *fa)
+{
+	int i;
+
+	for (i = 0; i < FUSE_MAX_ARGS_IN; i++)
+		fa->in_args[i].flags |= BPF_FUSE_IMMUTABLE;
+}
+
+static inline void fuse_bpf_set_out_ends(struct bpf_fuse_args *fa)
+{
+	int i;
+
+	for (i = 0; i < FUSE_MAX_ARGS_OUT; i++)
+		fa->out_args[i].end_offset = (void *)
+			((char *)fa->out_args[i].value
+			+ fa->out_args[i].size);
+}
+
+static inline void fuse_bpf_free_alloced(struct bpf_fuse_args *fa)
+{
+	int i;
+
+	for (i = 0; i < FUSE_MAX_ARGS_IN; i++)
+		if (fa->in_args[i].flags & BPF_FUSE_ALLOCATED)
+			kfree(fa->in_args[i].value);
+	for (i = 0; i < FUSE_MAX_ARGS_OUT; i++)
+		if (fa->out_args[i].flags & BPF_FUSE_ALLOCATED)
+			kfree(fa->out_args[i].value);
+}
+
 /*
  * expression statement to wrap the backing filter logic
  * struct inode *inode: inode with bpf and backing inode
@@ -1958,6 +1998,7 @@ void __exit fuse_bpf_cleanup(void);
 	bool initialized = false;					\
 	bool handled = false;						\
 	ssize_t res;							\
+	int bpf_next;							\
 	io feo = { 0 };							\
 	int error = 0;							\
 									\
@@ -1969,17 +2010,47 @@ void __exit fuse_bpf_cleanup(void);
 		error = initialize_in(&fa, &feo, args);			\
 		if (error)						\
 			break;						\
+		fuse_bpf_set_in_ends(&fa);				\
+									\
+		fa.opcode |= FUSE_PREFILTER;				\
+		bpf_next = fuse_inode->bpf ?				\
+			bpf_prog_run(fuse_inode->bpf, &fa) :		\
+			BPF_FUSE_CONTINUE;				\
+		if (bpf_next < 0) {					\
+			error = bpf_next;				\
+			break;						\
+		}							\
+									\
+		fuse_bpf_set_in_immutable(&fa);				\
 									\
 		error = initialize_out(&fa, &feo, args);		\
 		if (error)						\
 			break;						\
+		fuse_bpf_set_out_ends(&fa);				\
 									\
 		initialized = true;					\
+		if (bpf_next == BPF_FUSE_USER) {			\
+			handled = false;				\
+			break;						\
+		}							\
+									\
+		fa.opcode &= ~FUSE_PREFILTER;				\
 									\
 		error = backing(&fa, &out, args);			\
 		if (error < 0)						\
 			fa.error_in = error;				\
 									\
+		if (bpf_next == BPF_FUSE_CONTINUE)			\
+			break;						\
+									\
+		fa.opcode |= FUSE_POSTFILTER;				\
+		if (bpf_next == BPF_FUSE_POSTFILTER)			\
+			bpf_next = bpf_prog_run(fuse_inode->bpf, &fa);	\
+		if (bpf_next < 0) {					\
+			error = bpf_next;				\
+			break;						\
+		}							\
+									\
 	} while (false);						\
 									\
 	if (initialized && handled) {					\
@@ -1987,6 +2058,7 @@ void __exit fuse_bpf_cleanup(void);
 		if (res)						\
 			error = res;					\
 	}								\
+	fuse_bpf_free_alloced(&fa);					\
 									\
 	out = error ? _Generic((out),					\
 			default :					\
-- 
2.37.3.998.g577e59143f-goog

