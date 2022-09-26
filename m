Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1D5EB56F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiIZXTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIZXSu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC75D33C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a25bc48000000b00680651cf051so7072804ybk.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=pTBeWa8xTfFgoM9RvB8PGTeLzYOoAC2B0p6BTMamD54=;
        b=enAXsV7F/tBL5JY2ksU0606J/Jce3DkaWnw+Xd7TqkowkS72zlbtkKwg+Q196X/GSt
         DAcTdeGJGhB/GdAm3aZxF5w+Hi9QvIMIgJUFinI4wfVlULzuUCdz0T6GwCwm3LV64Pnz
         0r2aGpMBgVXNyCmCzE4nFf/Q9vgtEZAgbSWEgUf3tZrWP+5Q/800XpLERe985guVA8NZ
         VsjCcrZAz6Q8hicovCqhDrXOrqwqpFLdkY1r2zy6njgmV0HLwtC/tVxVlRTWQorcipbP
         XIPHkxEAcuLa0U+NjpcAYQs1BHSmMdlUIgTGS54yYRhNzDS8oxaH+RWIJCXBjYsl/6SK
         dv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=pTBeWa8xTfFgoM9RvB8PGTeLzYOoAC2B0p6BTMamD54=;
        b=RPEUYaRJ0Lhh+5IpJI56R+ccAGuvWMz8s+TenPg4WIyuCUHfH3FCEuX5x8WnD2r21N
         cRKAcKfGpdqI5WM3AiM5NAyRNKgOs9mB6T8IkxRpD+HXSI24trOWLTIO6UhMeLeQiWWG
         ybyxvz+kjX9j1RxlLlKTXOtZvVnDbjQ6ArWIQZixvUENXFLW5KZmA8pm53LgXxoytThg
         Pgh5ud9YJDR7qP5rjQkQUT+W47IeHOxZaLBbbWd+WemTRHsNpSbzXBdI5vCmRzQWXYs+
         iqd2CAtRahFuPLlTGclIYvPOh84jIPr5PrdlLgcdzBEK79WqYO6ri8M2HQNNkzU0Kfnd
         CcAQ==
X-Gm-Message-State: ACrzQf15lDrevLr2nCHxANi4S/sUWp443iYik7WkWdkqAZGPtNZCT/0h
        cmbSFQuUUFbo0qWS/yxCPQ+xm72KgnQ=
X-Google-Smtp-Source: AMsMyM7LQo6IM6WZlgPsLQdq3HkVe+LOozsF4NgtzRMTCgNSG6MVVp1c7TPKUAxeUdCmWQPql9sA9/AXzNM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a81:11d7:0:b0:351:95a:81a5 with SMTP id
 206-20020a8111d7000000b00351095a81a5mr3665773ywr.160.1664234319827; Mon, 26
 Sep 2022 16:18:39 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:00 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-5-drosen@google.com>
Subject: [PATCH 04/26] fuse-bpf: Add BPF supporting functions
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

This adds support for verifying fuse-bpf programs. These programs are
not permitted to make any changes to their contexts unless they request
the access via fuse_get_writeable_in/fuse_get_writeable_out. These
return a buffer, either to the preexisting buffer, or a newly allocated
one which will replace the preexisting buffer. The caller of the bpf
program is responsible for cleaning up these allocations, and is
notified via the flags set by the helper.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 include/linux/bpf.h      |   2 +
 include/linux/bpf_fuse.h |   1 +
 include/uapi/linux/bpf.h |   2 +
 kernel/bpf/Makefile      |   4 +
 kernel/bpf/bpf_fuse.c    | 342 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/btf.c         |   1 +
 kernel/bpf/verifier.c    |   1 +
 7 files changed, 353 insertions(+)
 create mode 100644 kernel/bpf/bpf_fuse.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e6bfcfd8fea..749e65c438dd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2412,6 +2412,8 @@ extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
 extern const struct bpf_func_proto bpf_set_retval_proto;
 extern const struct bpf_func_proto bpf_get_retval_proto;
+extern const struct bpf_func_proto bpf_fuse_get_writeable_in_proto;
+extern const struct bpf_func_proto bpf_fuse_get_writeable_out_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 9d22205c9ae0..91b60d4e78b1 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -56,6 +56,7 @@ struct bpf_fuse_args {
 #define BPF_FUSE_MODIFIED	(1 << 3) // The helper function allowed writes to the buffer
 #define BPF_FUSE_ALLOCATED	(1 << 4) // The helper function allocated the buffer
 
+extern void *bpf_fuse_get_writeable(struct bpf_fuse_arg *arg, u64 size, bool copy);
 bool bpf_helper_changes_one_pkt_data(void *func);
 
 #endif /* _BPF_FUSE_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ac81763f002b..8218b9ea4313 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5542,6 +5542,8 @@ union bpf_attr {
 	FN(tcp_raw_gen_syncookie_ipv6),	\
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
+	FN(fuse_get_writeable_in),	\
+	FN(fuse_get_writeable_out),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 057ba8e01e70..717212bb8282 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -40,3 +40,7 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+ifeq ($(CONFIG_FUSE_BPF),y)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_fuse.o
+endif
diff --git a/kernel/bpf/bpf_fuse.c b/kernel/bpf/bpf_fuse.c
new file mode 100644
index 000000000000..cc5c9b7fc361
--- /dev/null
+++ b/kernel/bpf/bpf_fuse.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2021 Google LLC
+
+#include <linux/filter.h>
+#include <linux/bpf_fuse.h>
+
+static const struct bpf_func_proto *
+fuse_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_trace_printk:
+			return bpf_get_trace_printk_proto();
+
+	case BPF_FUNC_get_current_uid_gid:
+			return &bpf_get_current_uid_gid_proto;
+
+	case BPF_FUNC_get_current_pid_tgid:
+			return &bpf_get_current_pid_tgid_proto;
+
+	case BPF_FUNC_map_lookup_elem:
+		return &bpf_map_lookup_elem_proto;
+
+	case BPF_FUNC_map_update_elem:
+		return &bpf_map_update_elem_proto;
+
+	case BPF_FUNC_fuse_get_writeable_in:
+		return &bpf_fuse_get_writeable_in_proto;
+
+	case BPF_FUNC_fuse_get_writeable_out:
+		return &bpf_fuse_get_writeable_out_proto;
+
+	default:
+		pr_debug("Invalid fuse bpf func %d\n", func_id);
+		return NULL;
+	}
+}
+
+static bool fuse_arg_valid_access(int off, int start, int size, struct bpf_insn_access_aux *info)
+{
+	int arg_off = (off - start) % sizeof(struct __bpf_fuse_arg);
+	int arg_start = off - arg_off;
+
+	switch (arg_off) {
+	case bpf_ctx_range(struct __bpf_fuse_arg, value):
+	case offsetof(struct __bpf_fuse_arg, end_offset):
+		if (size != sizeof(__u64))
+			return false;
+		break;
+
+	case offsetof(struct __bpf_fuse_arg, max_size):
+	case offsetof(struct __bpf_fuse_arg, size):
+		if (size != sizeof(__u32))
+			return false;
+		break;
+
+	}
+
+	switch (arg_off) {
+	case bpf_ctx_range(struct __bpf_fuse_arg, value):
+		info->reg_type = PTR_TO_PACKET;
+		info->data_id = arg_start;
+		return true;
+
+	case offsetof(struct __bpf_fuse_arg, end_offset):
+		info->reg_type = PTR_TO_PACKET_END;
+		info->data_id = arg_start;
+		return true;
+
+	case offsetof(struct __bpf_fuse_arg, max_size):
+	case offsetof(struct __bpf_fuse_arg, size):
+		info->reg_type = SCALAR_VALUE;
+		return true;
+	}
+	return false;
+}
+
+static bool fuse_prog_is_valid_access(int off, int size,
+				enum bpf_access_type type,
+				const struct bpf_prog *prog,
+				struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off > offsetofend(struct bpf_fuse_args, out_args))
+		return false;
+
+	/* No fields should be written directly. Writable buffers are requested via helper function
+	 * The size fields is set by helper. If bpfs have a need to adjust the size smaller, we may
+	 * revisit this...
+	 */
+	if (type == BPF_WRITE)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct __bpf_fuse_args, nodeid):
+		info->reg_type = SCALAR_VALUE;
+		if (size == sizeof(__u64))
+			return true;
+		break;
+	case bpf_ctx_range(struct __bpf_fuse_args, opcode):
+	case bpf_ctx_range(struct __bpf_fuse_args, error_in):
+	case bpf_ctx_range(struct __bpf_fuse_args, in_numargs):
+	case bpf_ctx_range(struct __bpf_fuse_args, out_numargs):
+	case bpf_ctx_range(struct __bpf_fuse_args, flags):
+		info->reg_type = SCALAR_VALUE;
+		if (size == sizeof(__u32))
+			return true;
+		break;
+	case bpf_ctx_range_till(struct __bpf_fuse_args, in_args[0], in_args[2]):
+		if (fuse_arg_valid_access(off, offsetof(struct __bpf_fuse_args, in_args[0]),
+					  size, info))
+			return true;
+		break;
+	case bpf_ctx_range_till(struct __bpf_fuse_args, out_args[0], out_args[1]):
+		if (fuse_arg_valid_access(off, offsetof(struct __bpf_fuse_args, out_args[0]),
+					  size, info))
+			return true;
+		break;
+	}
+
+	return false;
+}
+
+static struct bpf_insn *fuse_arg_convert_access(int off, int start, int converted_start,
+						const struct bpf_insn *si, struct bpf_insn *insn)
+{
+	int arg_off = (off - start) % sizeof(struct __bpf_fuse_arg);
+	int arg_num = (off - start) / sizeof(struct __bpf_fuse_arg);
+	int arg_start = converted_start + arg_num * sizeof(struct bpf_fuse_arg);
+
+	switch (arg_off) {
+	case offsetof(struct __bpf_fuse_arg, value):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_arg, value),
+				      si->dst_reg, si->src_reg,
+				      arg_start + offsetof(struct bpf_fuse_arg, value));
+		break;
+
+	case offsetof(struct __bpf_fuse_arg, end_offset):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_arg, end_offset),
+				      si->dst_reg, si->src_reg,
+				      arg_start + offsetof(struct bpf_fuse_arg, end_offset));
+		break;
+
+	case offsetof(struct __bpf_fuse_arg, size):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_arg, size),
+				      si->dst_reg, si->src_reg,
+				      arg_start + offsetof(struct bpf_fuse_arg, size));
+		break;
+
+	case offsetof(struct __bpf_fuse_arg, max_size):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_arg, max_size),
+				      si->dst_reg, si->src_reg,
+				      arg_start + offsetof(struct bpf_fuse_arg, max_size));
+		break;
+	}
+	return insn;
+}
+
+static u32 fuse_prog_convert_ctx_access(enum bpf_access_type type,
+		     const struct bpf_insn *si,
+		     struct bpf_insn *insn_buf,
+		     struct bpf_prog *prog,
+		     u32 *target_size)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	switch (si->off) {
+	case offsetof(struct __bpf_fuse_args, nodeid):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_args, nodeid),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_fuse_args, nodeid));
+		break;
+
+	case offsetof(struct __bpf_fuse_args, opcode):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_args, opcode),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_fuse_args, opcode));
+		break;
+
+	case offsetof(struct __bpf_fuse_args, error_in):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_args, error_in),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_fuse_args, error_in));
+		break;
+
+	case offsetof(struct __bpf_fuse_args, in_numargs):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_args, in_numargs),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_fuse_args, in_numargs));
+		break;
+
+	case offsetof(struct __bpf_fuse_args, out_numargs):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_args, out_numargs),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_fuse_args, out_numargs));
+		break;
+
+	case offsetof(struct __bpf_fuse_args, flags):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_fuse_args, flags),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_fuse_args, flags));
+		break;
+
+	case bpf_ctx_range_till(struct __bpf_fuse_args, in_args[0], in_args[2]):
+		insn = fuse_arg_convert_access(si->off,
+					       offsetof(struct __bpf_fuse_args, in_args[0]),
+					       offsetof(struct bpf_fuse_args, in_args[0]),
+					       si, insn);
+		break;
+
+	case bpf_ctx_range_till(struct __bpf_fuse_args, out_args[0], out_args[1]):
+		insn = fuse_arg_convert_access(si->off,
+					       offsetof(struct __bpf_fuse_args, out_args[0]),
+					       offsetof(struct bpf_fuse_args, out_args[0]),
+					       si, insn);
+		break;
+
+	}
+
+	return insn - insn_buf;
+}
+
+static int fuse_prog_get_prologue(struct bpf_insn *insn_buf,
+				   bool direct_write,
+				   const struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static int buff_size(struct bpf_fuse_arg *arg)
+{
+	return ((char *)arg->end_offset - (char *)arg->value);
+}
+
+void *bpf_fuse_get_writeable(struct bpf_fuse_arg *arg, u64 size, bool copy)
+{
+	void *writeable_val;
+
+	if (arg->flags & BPF_FUSE_IMMUTABLE)
+		return 0;
+
+	if (size <= buff_size(arg) &&
+			(!(arg->flags & BPF_FUSE_MUST_ALLOCATE) ||
+			  (arg->flags & BPF_FUSE_ALLOCATED))) {
+		if (arg->flags & BPF_FUSE_VARIABLE_SIZE)
+			arg->size = size;
+		arg->flags |= BPF_FUSE_MODIFIED;
+		return arg->value;
+	}
+	/* Variable sized arrays must stay below max size. If the buffer must be fixed size,
+	 * don't change the allocated size. Verifier will enforce requested size for accesses
+	 */
+	if (arg->flags & BPF_FUSE_VARIABLE_SIZE) {
+		if (size > arg->max_size)
+			return 0;
+	} else {
+		if (size > arg->size)
+			return 0;
+		size = arg->size;
+	}
+
+	if (size != arg->size && size > arg->max_size)
+		return 0;
+	writeable_val = kzalloc(size, GFP_KERNEL);
+	if (!writeable_val)
+		return 0;
+
+	/* If we're copying the buffer, assume the same amount is used. If that isn't the case,
+	 * caller must change size. Otherwise, assume entirety of new buffer is used.
+	 */
+	if (copy)
+		memcpy(writeable_val, arg->value, (arg->size > size) ? size : arg->size);
+	else
+		arg->size = size;
+
+	if (arg->flags & BPF_FUSE_ALLOCATED)
+		kfree(arg->value);
+	arg->value = writeable_val;
+	arg->end_offset = (char *)writeable_val + size;
+
+	arg->flags |= BPF_FUSE_ALLOCATED | BPF_FUSE_MODIFIED;
+
+	return arg->value;
+}
+EXPORT_SYMBOL(bpf_fuse_get_writeable);
+
+BPF_CALL_5(bpf_fuse_get_writeable_in, struct bpf_fuse_args *, ctx, u32, index, void *, value,
+		u64, size, bool, copy)
+{
+	if (ctx->in_args[index].value != value)
+		return 0;
+	return (unsigned long) bpf_fuse_get_writeable(&ctx->in_args[index], size, copy);
+}
+
+BPF_CALL_5(bpf_fuse_get_writeable_out, struct bpf_fuse_args *, ctx, u32, index, void *, value,
+		u64, size, bool, copy)
+{
+	if (ctx->out_args[index].value != value)
+		return 0;
+	return (unsigned long) bpf_fuse_get_writeable(&ctx->out_args[index], size, copy);
+}
+
+bool bpf_helper_changes_one_pkt_data(void *func)
+{
+	if (func == bpf_fuse_get_writeable_in || func == bpf_fuse_get_writeable_out)
+		return true;
+	return false;
+}
+
+const struct bpf_func_proto bpf_fuse_get_writeable_in_proto = {
+	.func		= bpf_fuse_get_writeable_in,
+	.ret_type	= RET_PTR_TO_ALLOC_MEM_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_PACKET,
+	.arg4_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
+	.arg5_type	= ARG_ANYTHING,
+	.gpl_only	= false,
+	.pkt_access	= true,
+};
+
+const struct bpf_func_proto bpf_fuse_get_writeable_out_proto = {
+	.func		= bpf_fuse_get_writeable_out,
+	.ret_type	= RET_PTR_TO_ALLOC_MEM_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_PACKET,
+	.arg4_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
+	.arg5_type	= ARG_ANYTHING,
+	.gpl_only	= false,
+	.pkt_access	= true,
+};
+
+
+const struct bpf_verifier_ops fuse_verifier_ops = {
+	.get_func_proto  = fuse_prog_func_proto,
+	.is_valid_access = fuse_prog_is_valid_access,
+	.convert_ctx_access = fuse_prog_convert_ctx_access,
+	.gen_prologue = fuse_prog_get_prologue,
+};
+
+const struct bpf_prog_ops fuse_prog_ops = {
+};
+
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7e64447659f3..97f4a0889f2b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -24,6 +24,7 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/bpf_fuse.h>
 #include <net/sock.h>
 #include "../tools/lib/bpf/relo_core.h"
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2884650904fe..e076677f63be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3874,6 +3874,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_FUSE:
 		if (t == BPF_WRITE)
 			return false;
 		fallthrough;
-- 
2.37.3.998.g577e59143f-goog

