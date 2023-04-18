Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E452C6E5704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDRBpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjDRBoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:44:04 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C883F2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517bad1b8c5so1563659a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782114; x=1684374114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uItCp9dmlSq9K5w/dO5KDhSfWqlCiTpddbyFnUdvY1o=;
        b=6ZG7MrPplM5M81seOPN0hvXOXCiSEwqx1nO2/dhdDCrhZSmG9COpDr1eX2fxHouiFO
         e/p0ot7SOR2DqTtejD+ao/RKa21LSQkoUotrF6i4BLWIuTlGH9VzaoyiD599p5QSXw2F
         bQTC68wutfGQQ0eI74oDjeJVg0AEAToVsf2UFB6NyFGzhg8MljgXOsKeuihOuHCSVDsw
         XreW21ONO4vhlYTSSmXeQYqGb7nwbDqxO4UByZJQczd+uVUQorJ83f6LfpPcZj+7/PMk
         2rvlYT4gUyoofHRhNBzeNxQMYk2VT6VUhLo0ZnNohLDKM637Qfr2oAIbXfmiz0imCiDA
         IFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782114; x=1684374114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uItCp9dmlSq9K5w/dO5KDhSfWqlCiTpddbyFnUdvY1o=;
        b=Bu6eSwWLHba0JvPE/B4BzwKynJA/OuywGcQ7gTbDK7t7UgyL0LbEdrXD5Gw4DTyeuM
         HLKdSJimrySYt/2dANu0x781D3TdNw/ewDdQZqUAE3IzlB0tXzexjoJa/O77hVdZNXve
         5XmqNqbA3XyUxjC/uSBYyIPNKeba1rdT/VKOOhVI2SZNp3MTcZOeblXAWmeRbD1nq5a1
         LNot7RYmigBLSukU6ftoc0OXCoNoT1mGSkZW56nMnk734YIYHYS8btEzd6nRj2THtLHa
         2OxXG6vIk2OTqRN0ixg9KQGkQ4cD1AgLlBEa4sqvkGIuGC0pHhMsCZx1scg7nx3skjdz
         mfeg==
X-Gm-Message-State: AAQBX9fzzdxvRC+6FGSZHzsY6mF/bzvsblDtpbnD12H5+VYilR156dsl
        nV+c+9+j1garw3OkLV8ORcilfDcOg7I=
X-Google-Smtp-Source: AKy350ZppNJyCCMUoSVMCNcn1UBo1hOQckQ73RYyKMhi9AzOeJREQF2N4JedMcWfQRQtWg8BteVAlnRCSrQ=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a17:903:294c:b0:1a6:898a:41fd with SMTP id
 li12-20020a170903294c00b001a6898a41fdmr201053plb.6.1681782114402; Mon, 17 Apr
 2023 18:41:54 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:28 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-29-drosen@google.com>
Subject: [RFC PATCH v3 28/37] WIP: bpf: Add fuse_ops struct_op programs
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

This introduces a new struct_op type: fuse_ops. This program set
provides pre and post filters to run around fuse-bpf calls that act
directly on the lower filesystem.

The inputs are either fixed structures, or struct fuse_buffer's.

These programs are not permitted to make any changes to these fuse_buffers
unless they create a dynptr wrapper using the supplied kfunc helpers.

Fuse_buffers maintain additional state information that FUSE uses to
manage memory and determine if additional set up or checks are needed.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/linux/bpf_fuse.h          | 189 +++++++++++++++++++++++
 kernel/bpf/Makefile               |   4 +
 kernel/bpf/bpf_fuse.c             | 241 ++++++++++++++++++++++++++++++
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 kernel/bpf/btf.c                  |   1 +
 kernel/bpf/verifier.c             |   9 ++
 6 files changed, 448 insertions(+)
 create mode 100644 kernel/bpf/bpf_fuse.c

diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index ce8b1b347496..780a7889aea2 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -30,6 +30,8 @@ struct fuse_buffer {
 #define BPF_FUSE_MODIFIED	(1 << 3) // The helper function allowed writes to the buffer
 #define BPF_FUSE_ALLOCATED	(1 << 4) // The helper function allocated the buffer
 
+extern void *bpf_fuse_get_writeable(struct fuse_buffer *arg, u64 size, bool copy);
+
 /*
  * BPF Fuse Args
  *
@@ -81,4 +83,191 @@ static inline unsigned bpf_fuse_arg_size(const struct bpf_fuse_arg *arg)
 	return arg->is_buffer ? arg->buffer->size : arg->size;
 }
 
+struct fuse_ops {
+	uint32_t (*open_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in);
+	uint32_t (*open_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out);
+
+	uint32_t (*opendir_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in);
+	uint32_t (*opendir_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out);
+
+	uint32_t (*create_open_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_create_in *in, struct fuse_buffer *name);
+	uint32_t (*create_open_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_create_in *in, const struct fuse_buffer *name,
+				struct fuse_entry_out *entry_out, struct fuse_open_out *out);
+
+	uint32_t (*release_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in);
+	uint32_t (*release_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_release_in *in);
+
+	uint32_t (*releasedir_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in);
+	uint32_t (*releasedir_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_release_in *in);
+
+	uint32_t (*flush_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_flush_in *in);
+	uint32_t (*flush_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_flush_in *in);
+
+	uint32_t (*lseek_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_lseek_in *in);
+	uint32_t (*lseek_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_lseek_in *in,
+				struct fuse_lseek_out *out);
+
+	uint32_t (*copy_file_range_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_copy_file_range_in *in);
+	uint32_t (*copy_file_range_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_copy_file_range_in *in,
+				struct fuse_write_out *out);
+
+	uint32_t (*fsync_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in);
+	uint32_t (*fsync_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fsync_in *in);
+
+	uint32_t (*dir_fsync_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in);
+	uint32_t (*dir_fsync_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fsync_in *in);
+
+	uint32_t (*getxattr_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in, struct fuse_buffer *name);
+	// if in->size > 0, use value. If in->size == 0, use out.
+	uint32_t (*getxattr_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getxattr_in *in, const struct fuse_buffer *name,
+				struct fuse_buffer *value, struct fuse_getxattr_out *out);
+
+	uint32_t (*listxattr_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in);
+	// if in->size > 0, use value. If in->size == 0, use out.
+	uint32_t (*listxattr_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getxattr_in *in,
+				struct fuse_buffer *value, struct fuse_getxattr_out *out);
+
+	uint32_t (*setxattr_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_setxattr_in *in, struct fuse_buffer *name,
+					struct fuse_buffer *value);
+	uint32_t (*setxattr_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_setxattr_in *in, const struct fuse_buffer *name,
+					const struct fuse_buffer *value);
+
+	uint32_t (*removexattr_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name);
+	uint32_t (*removexattr_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name);
+
+	/* Read and Write iter will likely undergo some sort of change/addition to handle changing
+	 * the data buffer passed in/out. */
+	uint32_t (*read_iter_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in);
+	uint32_t (*read_iter_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_iter_out *out);
+
+	uint32_t (*write_iter_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_write_in *in);
+	uint32_t (*write_iter_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_write_in *in,
+				struct fuse_write_iter_out *out);
+
+	uint32_t (*file_fallocate_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_fallocate_in *in);
+	uint32_t (*file_fallocate_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fallocate_in *in);
+
+	uint32_t (*lookup_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name);
+	uint32_t (*lookup_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name,
+				struct fuse_entry_out *out, struct fuse_buffer *entries);
+
+	uint32_t (*mknod_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_mknod_in *in, struct fuse_buffer *name);
+	uint32_t (*mknod_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_mknod_in *in, const struct fuse_buffer *name);
+
+	uint32_t (*mkdir_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_in *in, struct fuse_buffer *name);
+	uint32_t (*mkdir_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_mkdir_in *in, const struct fuse_buffer *name);
+
+	uint32_t (*rmdir_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name);
+	uint32_t (*rmdir_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name);
+
+	uint32_t (*rename2_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename2_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name);
+	uint32_t (*rename2_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_rename2_in *in, const struct fuse_buffer *old_name,
+				const struct fuse_buffer *new_name);
+
+	uint32_t (*rename_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name);
+	uint32_t (*rename_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_rename_in *in, const struct fuse_buffer *old_name,
+				const struct fuse_buffer *new_name);
+
+	uint32_t (*unlink_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name);
+	uint32_t (*unlink_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name);
+
+	uint32_t (*link_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_link_in *in, struct fuse_buffer *name);
+	uint32_t (*link_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_link_in *in, const struct fuse_buffer *name);
+
+	uint32_t (*getattr_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_getattr_in *in);
+	uint32_t (*getattr_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getattr_in *in,
+				struct fuse_attr_out *out);
+
+	uint32_t (*setattr_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_setattr_in *in);
+	uint32_t (*setattr_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_setattr_in *in,
+				struct fuse_attr_out *out);
+
+	uint32_t (*statfs_prefilter)(const struct bpf_fuse_meta_info *meta);
+	uint32_t (*statfs_postfilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_statfs_out *out);
+
+	//TODO: This does not allow doing anything with path
+	uint32_t (*get_link_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name);
+	uint32_t (*get_link_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name);
+
+	uint32_t (*symlink_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name, struct fuse_buffer *path);
+	uint32_t (*symlink_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name, const struct fuse_buffer *path);
+
+	uint32_t (*readdir_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in);
+	uint32_t (*readdir_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_out *out, struct fuse_buffer *buffer);
+
+	uint32_t (*access_prefilter)(const struct bpf_fuse_meta_info *meta,
+				struct fuse_access_in *in);
+	uint32_t (*access_postfilter)(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_access_in *in);
+
+	char name[BPF_FUSE_NAME_MAX];
+};
+
 #endif /* _BPF_FUSE_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1d3892168d32..26a2e741ef61 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -45,3 +45,7 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+ifeq ($(CONFIG_FUSE_BPF),y)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_fuse.o
+endif
diff --git a/kernel/bpf/bpf_fuse.c b/kernel/bpf/bpf_fuse.c
new file mode 100644
index 000000000000..35125c1f8eef
--- /dev/null
+++ b/kernel/bpf/bpf_fuse.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2021 Google LLC
+
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/bpf_fuse.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+
+void *bpf_fuse_get_writeable(struct fuse_buffer *arg, u64 size, bool copy)
+{
+	void *writeable_val;
+
+	if (arg->flags & BPF_FUSE_IMMUTABLE)
+		return 0;
+
+	if (size <= arg->size &&
+			(!(arg->flags & BPF_FUSE_MUST_ALLOCATE) ||
+			  (arg->flags & BPF_FUSE_ALLOCATED))) {
+		if (arg->flags & BPF_FUSE_VARIABLE_SIZE)
+			arg->size = size;
+		arg->flags |= BPF_FUSE_MODIFIED;
+		return arg->data;
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
+
+	/* If our buffer is big enough, just adjust size */
+	if (size <= arg->alloc_size) {
+		if (!copy)
+			arg->size = size;
+		arg->flags |= BPF_FUSE_MODIFIED;
+		return arg->data;
+	}
+
+	writeable_val = kzalloc(size, GFP_KERNEL);
+	if (!writeable_val)
+		return 0;
+
+	arg->alloc_size = size;
+	/* If we're copying the buffer, assume the same amount is used. If that isn't the case,
+	 * caller must change size. Otherwise, assume entirety of new buffer is used.
+	 */
+	if (copy)
+		memcpy(writeable_val, arg->data, (arg->size > size) ? size : arg->size);
+	else
+		arg->size = size;
+
+	if (arg->flags & BPF_FUSE_ALLOCATED)
+		kfree(arg->data);
+	arg->data = writeable_val;
+
+	arg->flags |= BPF_FUSE_ALLOCATED | BPF_FUSE_MODIFIED;
+
+	return arg->data;
+}
+EXPORT_SYMBOL(bpf_fuse_get_writeable);
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+                  "Global kfuncs as their definitions will be in BTF");
+void bpf_fuse_get_rw_dynptr(struct fuse_buffer *buffer, struct bpf_dynptr_kern *dynptr__uninit, u64 size, bool copy)
+{
+	buffer->data = bpf_fuse_get_writeable(buffer, size, copy);
+	bpf_dynptr_init(dynptr__uninit, buffer->data, BPF_DYNPTR_TYPE_LOCAL, 0, buffer->size);
+}
+
+void bpf_fuse_get_ro_dynptr(const struct fuse_buffer *buffer, struct bpf_dynptr_kern *dynptr__uninit)
+{
+	bpf_dynptr_init(dynptr__uninit, buffer->data, BPF_DYNPTR_TYPE_LOCAL, 0, buffer->size);
+	bpf_dynptr_set_rdonly(dynptr__uninit);
+}
+
+uint32_t bpf_fuse_return_len(struct fuse_buffer *buffer)
+{
+	return buffer->size;
+}
+__diag_pop();
+BTF_SET8_START(fuse_kfunc_set)
+BTF_ID_FLAGS(func, bpf_fuse_get_rw_dynptr)
+BTF_ID_FLAGS(func, bpf_fuse_get_ro_dynptr)
+BTF_ID_FLAGS(func, bpf_fuse_return_len)
+BTF_SET8_END(fuse_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_fuse_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &fuse_kfunc_set,
+};
+
+static int __init bpf_fuse_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_fuse_kfunc_set);
+}
+
+late_initcall(bpf_fuse_kfuncs_init);
+
+static const struct bpf_func_proto *bpf_fuse_get_func_proto(enum bpf_func_id func_id,
+							      const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	default:
+		return bpf_base_func_proto(func_id);
+	}
+}
+
+static bool bpf_fuse_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+const struct btf_type *fuse_buffer_struct_type;
+
+static int bpf_fuse_btf_struct_access(struct bpf_verifier_log *log,
+					const struct bpf_reg_state *reg,
+					int off, int size)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t == fuse_buffer_struct_type) {
+		bpf_log(log,
+			"direct access to fuse_buffer is disallowed\n");
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+static const struct bpf_verifier_ops bpf_fuse_verifier_ops = {
+	.get_func_proto		= bpf_fuse_get_func_proto,
+	.is_valid_access	= bpf_fuse_is_valid_access,
+	.btf_struct_access	= bpf_fuse_btf_struct_access,
+};
+
+static int bpf_fuse_check_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   const struct bpf_prog *prog)
+{
+	//if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
+	//	return -ENOTSUPP;
+	return 0;
+}
+
+static int bpf_fuse_init_member(const struct btf_type *t,
+				  const struct btf_member *member,
+				  void *kdata, const void *udata)
+{
+	const struct fuse_ops *uf_ops;
+	struct fuse_ops *f_ops;
+	u32 moff;
+
+	uf_ops = (const struct fuse_ops *)udata;
+	f_ops = (struct fuse_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct fuse_ops, name):
+		if (bpf_obj_name_cpy(f_ops->name, uf_ops->name,
+				     sizeof(f_ops->name)) <= 0)
+			return -EINVAL;
+		//if (tcp_ca_find(utcp_ca->name))
+		//	return -EEXIST;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int bpf_fuse_init(struct btf *btf)
+{
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "fuse_buffer", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	fuse_buffer_struct_type = btf_type_by_id(btf, type_id);
+
+	return 0;
+}
+
+static struct bpf_fuse_ops_attach *fuse_reg = NULL;
+
+static int bpf_fuse_reg(void *kdata)
+{
+	if (fuse_reg)
+		return fuse_reg->fuse_register_bpf(kdata);
+	pr_warn("Cannot register fuse_ops, FUSE not found");
+	return -EOPNOTSUPP;
+}
+
+static void bpf_fuse_unreg(void *kdata)
+{
+	if(fuse_reg)
+		return fuse_reg->fuse_unregister_bpf(kdata);
+}
+
+int register_fuse_bpf(struct bpf_fuse_ops_attach *reg_ops)
+{
+	fuse_reg = reg_ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_fuse_bpf);
+
+void unregister_fuse_bpf(struct bpf_fuse_ops_attach *reg_ops)
+{
+	if (reg_ops == fuse_reg)
+		fuse_reg = NULL;
+	else
+		pr_warn("Refusing to unregister unregistered FUSE");
+}
+EXPORT_SYMBOL_GPL(unregister_fuse_bpf);
+
+/* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
+extern struct bpf_struct_ops bpf_fuse_ops;
+
+struct bpf_struct_ops bpf_fuse_ops = {
+	.verifier_ops = &bpf_fuse_verifier_ops,
+	.reg = bpf_fuse_reg,
+	.unreg = bpf_fuse_unreg,
+	.check_member = bpf_fuse_check_member,
+	.init_member = bpf_fuse_init_member,
+	.init = bpf_fuse_init,
+	.name = "fuse_ops",
+};
+
diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
index 5678a9ddf817..fabb2c1a9482 100644
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ b/kernel/bpf/bpf_struct_ops_types.h
@@ -5,6 +5,10 @@
 #ifdef CONFIG_NET
 BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
 #endif
+#ifdef CONFIG_FUSE_BPF
+#include <linux/bpf_fuse.h>
+BPF_STRUCT_OPS_TYPE(fuse_ops)
+#endif
 #ifdef CONFIG_INET
 #include <net/tcp.h>
 BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 027f9f8a3551..c34fd9e70039 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/bpf_fuse.h>
 #include <net/sock.h>
 #include "../tools/lib/bpf/relo_core.h"
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd959824469d..b3bda15283c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9597,6 +9597,8 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
+	KF_bpf_fuse_get_rw_dynptr,
+	KF_bpf_fuse_get_ro_dynptr,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -9616,6 +9618,8 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_fuse_get_rw_dynptr)
+BTF_ID(func, bpf_fuse_get_ro_dynptr)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -9637,6 +9641,8 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_fuse_get_rw_dynptr)
+BTF_ID(func, bpf_fuse_get_ro_dynptr)
 
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10349,6 +10355,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp])
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
+			else if (meta->func_id == special_kfunc_list[KF_bpf_fuse_get_rw_dynptr] ||
+					meta->func_id == special_kfunc_list[KF_bpf_fuse_get_ro_dynptr])
+				dynptr_arg_type |= DYNPTR_TYPE_LOCAL;
 
 			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type);
 			if (ret < 0)
-- 
2.40.0.634.g4ca3ef3211-goog

