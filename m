Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD58E5EB56C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiIZXTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiIZXSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF019B14E7
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so76159267b3.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=oVFvJR4OdSBz8jEGY2bk02KLDgmIc1+T4MHAuS02Jcs=;
        b=I6GbLsFxJgTygTcZfHIxUxiMFf9w+Xtu3hA0y982MmIQMnv+eN66XSQwnU3fA3HfXL
         Z1VcX5VFM5T83x1xCwxv9QK1rGcXmLi/9dPpWlSbzwK8Uo+1kRRfCQ+MtUzrL7rOFToK
         KFGk0FSEp3UimYXlhQril1LsxLtWyU9HlmiSy4WexK3UK5s5AL52sqT5l7h93dSDSJ7X
         9EH6UwdJfj+H0kT5vgMEQj53HvqUgRNZASKKyqWoXylr2ZEBGQ6CoVR6V/WaBcJ9INtx
         WCkGmrGVYA0sI7fFhgAKyaHDWpl7Iby+rvLN/AstcQ+9GTXxI8p83bR2Mz2IV/y0Y955
         TfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=oVFvJR4OdSBz8jEGY2bk02KLDgmIc1+T4MHAuS02Jcs=;
        b=2lsoxVIxM7aPLbCyPw9lLbhwlb7dxJBhMIM4cKx5y8h3steWqIVMizf8xbiOTJ0jK/
         OEMU7Gdi51vH3nYs4rcCYIIvqGKaaUfqjvTSm7hWWg1sWeTbieteTtsSh8SUniVdHbY7
         O6a7jFhw5OnTBtftCfp+I80KjUq2cBLEHY4ThKutW5SM+4GO3WD6MCBdXro2ts2cLwa+
         5U1TB3C6jMtrPWR9iL8XOKB/h8CFMlBeE+4CIAIQJSB//YoOsrAwkPEmbeCnudP8jYWb
         Go19iAzYV6S2t4veGs1eZOkLjZS7NShESLVva29lEPnNcKEpTgnZwHHO/m3KPoTxyO3j
         UijQ==
X-Gm-Message-State: ACrzQf0dkgsqoEJ2dWnEyALWxttHdVO7zZyq1dsbmoXmMpS4U5d6IMYE
        QikAEmw/0+hXyILmz5ShTNX2HnOfZns=
X-Google-Smtp-Source: AMsMyM5L3Kbi+AtpufhWkHrInTI1CTOrQSz0EP+DieLqmDEcI3OtasU7xDE9zeLviDjP5CNu0NxoTxsS+vY=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a5b:94e:0:b0:6bb:ee52:1a66 with SMTP id
 x14-20020a5b094e000000b006bbee521a66mr3598602ybq.506.1664234317049; Mon, 26
 Sep 2022 16:18:37 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:17:59 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-4-drosen@google.com>
Subject: [PATCH 03/26] fuse-bpf: Update uapi for fuse-bpf
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

This adds the bpf prog type for fuse-bpf, and the associated structures.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 include/linux/bpf_fuse.h  | 50 +++++++++++++++++++++++++++++++++++++++
 include/linux/bpf_types.h |  4 ++++
 include/uapi/linux/bpf.h  | 31 ++++++++++++++++++++++++
 include/uapi/linux/fuse.h | 13 +++++++++-
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 18e2ec5bf453..9d22205c9ae0 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -6,6 +6,56 @@
 #ifndef _BPF_FUSE_H
 #define _BPF_FUSE_H
 
+/*
+ * Fuse BPF Args
+ *
+ * Used to communicate with bpf programs to allow checking or altering certain values.
+ * The end_offset allows the bpf verifier to check boundaries statically. This reflects
+ * the ends of the buffer. size shows the length that was actually used.
+ *
+ * In order to write to the output args, you must use the pointer returned by
+ * bpf_fuse_get_writeable.
+ *
+ */
+
+#define FUSE_MAX_ARGS_IN 3
+#define FUSE_MAX_ARGS_OUT 2
+
+struct bpf_fuse_arg {
+	void *value;		// Start of the buffer
+	void *end_offset;	// End of the buffer
+	uint32_t size;		// Used size of the buffer
+	uint32_t max_size;	// Max permitted size, if buffer is resizable. Otherwise 0
+	uint32_t flags;		// Flags indicating buffer status
+};
+
+#define FUSE_BPF_FORCE (1 << 0)
+#define FUSE_BPF_OUT_ARGVAR (1 << 6)
+
+struct bpf_fuse_args {
+	uint64_t nodeid;
+	uint32_t opcode;
+	uint32_t error_in;
+	uint32_t in_numargs;
+	uint32_t out_numargs;
+	uint32_t flags;
+	struct bpf_fuse_arg in_args[FUSE_MAX_ARGS_IN];
+	struct bpf_fuse_arg out_args[FUSE_MAX_ARGS_OUT];
+};
+
+/* These flags are used internally to track information about the fuse buffers.
+ * Fuse sets some of the flags in init. The helper functions sets others, depending on what
+ * was requested by the bpf program.
+ */
+// Flags set by FUSE
+#define BPF_FUSE_IMMUTABLE	(1 << 0) // Buffer may not be written to
+#define BPF_FUSE_VARIABLE_SIZE	(1 << 1) // Buffer length may be changed (growth requires alloc)
+#define BPF_FUSE_MUST_ALLOCATE	(1 << 2) // Buffer must be re allocated before allowing writes
+
+// Flags set by helper function
+#define BPF_FUSE_MODIFIED	(1 << 3) // The helper function allowed writes to the buffer
+#define BPF_FUSE_ALLOCATED	(1 << 4) // The helper function allocated the buffer
+
 bool bpf_helper_changes_one_pkt_data(void *func);
 
 #endif /* _BPF_FUSE_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 2b9112b80171..80c7f7d69794 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -79,6 +79,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
 #endif
 BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 	      void *, void *)
+#ifdef CONFIG_FUSE_BPF
+BPF_PROG_TYPE(BPF_PROG_TYPE_FUSE, fuse,
+	      struct __bpf_fuse_args, struct bpf_fuse_args)
+#endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 59a217ca2dfd..ac81763f002b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -952,6 +952,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_FUSE,
 };
 
 enum bpf_attach_type {
@@ -6848,4 +6849,34 @@ struct bpf_core_relo {
 	enum bpf_core_relo_kind kind;
 };
 
+struct __bpf_fuse_arg {
+	__u64 value;
+	__u64 end_offset;
+	__u32 size;
+	__u32 max_size;
+};
+
+struct __bpf_fuse_args {
+	__u64 nodeid;
+	__u32 opcode;
+	__u32 error_in;
+	__u32 in_numargs;
+	__u32 out_numargs;
+	__u32 flags;
+	struct __bpf_fuse_arg in_args[3];
+	struct __bpf_fuse_arg out_args[2];
+};
+
+/* Return Codes for Fuse BPF programs */
+#define BPF_FUSE_CONTINUE		0
+#define BPF_FUSE_USER			1
+#define BPF_FUSE_USER_PREFILTER		2
+#define BPF_FUSE_POSTFILTER		3
+#define BPF_FUSE_USER_POSTFILTER	4
+
+/* Op Code Filter values for BPF Programs */
+#define FUSE_OPCODE_FILTER	0x0ffff
+#define FUSE_PREFILTER		0x10000
+#define FUSE_POSTFILTER		0x20000
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..8c80c146e69b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -572,6 +572,17 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+#define FUSE_ACTION_KEEP	0
+#define FUSE_ACTION_REMOVE	1
+#define FUSE_ACTION_REPLACE	2
+
+struct fuse_entry_bpf_out {
+	uint64_t	backing_action;
+	uint64_t	backing_fd;
+	uint64_t	bpf_action;
+	uint64_t	bpf_fd;
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
@@ -870,7 +881,7 @@ struct fuse_in_header {
 	uint32_t	uid;
 	uint32_t	gid;
 	uint32_t	pid;
-	uint32_t	padding;
+	uint32_t	error_in;
 };
 
 struct fuse_out_header {
-- 
2.37.3.998.g577e59143f-goog

