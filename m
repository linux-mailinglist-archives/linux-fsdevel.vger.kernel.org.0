Return-Path: <linux-fsdevel+bounces-15648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD6089110E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E81C28596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819985924;
	Fri, 29 Mar 2024 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEqtjOAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3785297
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677303; cv=none; b=ee0pfoXumB5EXCBHszxAfEDOHZc4Us3sO1B7BRArCIbOAIMkx9/gPgluPF44DTUwyw2PgVu4QE3WbwRD0POyhl+y17xBuM7XcwVm13B4i2X4GkrXDbOmOShH8qH1BT/JVGV1X6XJusmYSpxygvO597ALEzMFDX+HevIQxaNn8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677303; c=relaxed/simple;
	bh=Et5mTBi93e0VpaY4zXqcHzFa+ntH32rehSMxUCipauA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lF+4+C7Ei+zLcYu5230/UjB/BSIt5zeuC6Yb6LNBME79eCH9WrlX5MM5fe/JcXoExp1lRUGN8wF5wBEg9bJU1KFlpRcOZM4dA/r4rN+coXgI/zY3yQJAoENs9Wl93FyuoBnxda6sxCFw0yy86kiADWQ1qy7RTG7/SRCnrNqSOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEqtjOAu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso19456567b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677299; x=1712282099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3RVx3rpuKP4Z/vxm8rCI0dcufWl8IOQWTFksEMcfQDY=;
        b=nEqtjOAu2JpC0J1fzeoGlU/whruVHnfzgFu1OFslhaXi/gJGXaUBtJMfe1ddzLdQHr
         BqGWgZ22U9hUdXUPknpaVf/gIQuUzhvEUdTX1w+stRCv7PX/3i/g893DDBgmOqA5vTeQ
         0ZcLYHi5SxthiAnpcaWI5pSE7j0IiTNfPkJx4heh3VvJCOArsQQlRFGadz+OqQMA3UZ8
         mXecfmPKbaDNjW9qzfbhXifk+gK+HyxUimeb8CK8VNlrq6osS7hVhl3HXWJ5uIAR/MiX
         B24z6uSNiQiRAkkwAMHJtiecRPGxmUmDktcfT+Nre+oOJ4/DgpSMEhfQxwRotJ5pfn7c
         QWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677299; x=1712282099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RVx3rpuKP4Z/vxm8rCI0dcufWl8IOQWTFksEMcfQDY=;
        b=LX/erOrBBb0+kSIb2iZJAu2mjTHD6uhj09GblW8VU7QzVhxabH6yQxf7yubJ72BV1C
         QoKJ8sKiAjvKu6L0p3Qo4dQj8ac/ArYTWPMihw/rtWQEjJ6QN5qS5ASAaskl7Tr56UIj
         zURyHGmwzs+NsuueWFQ1vxxLGRI2jum43hqkpJosnb++Ay9x2vtU1d/j60wTJw3xOJZa
         nG3y/6kt60P2xK0T/AtLEigNmg/S3ireS/9maV0RrVwpOMxtm4Fk2SvYMuq0c/dclHfX
         E8Wlt8JhqsXrCsgzCxww6gKZDDPirLvSs1qUi7GvR3Xpvfqsh37kWSl93ENO2Y7PPmET
         I1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW4RxYHMi38MhBePC9I1oI3cfMFOIpQvYmwjl7NNRoJzd1Cj6JVu+MOEvRZ7nZ9mNYNCUKyIesZKGj8AKB3i0m+6F4tiLmCUhw9+nhMw==
X-Gm-Message-State: AOJu0Yz/qc5u33+CFS8OB9nYjxj/Dm8OuxcETtDwOANHgYk3NkZx6QJw
	DXmE8kXc1pV1F3Av2TRDvNEihPsCsQU/fdSTf+wsDuknaN+Sz1wIo84Nwwbrp4bvlJilPqSK8mI
	d6g==
X-Google-Smtp-Source: AGHT+IGlzdw8aXILGmvK5Z65XAKp1rgWPf8oXWGLBbptXj4ClFeTaNoSsKS8izYyiS5spNoIZHXahnhskHo=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a81:914d:0:b0:614:447e:fbcd with SMTP id
 i74-20020a81914d000000b00614447efbcdmr71014ywg.2.1711677298927; Thu, 28 Mar
 2024 18:54:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:41 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-27-drosen@google.com>
Subject: [RFC PATCH v4 26/36] WIP: bpf: Add fuse_ops struct_op programs
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
 include/linux/bpf_fuse.h | 189 +++++++++++
 kernel/bpf/Makefile      |   4 +
 kernel/bpf/bpf_fuse.c    | 716 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/btf.c         |   1 +
 kernel/bpf/verifier.c    |  10 +-
 5 files changed, 919 insertions(+), 1 deletion(-)
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
index 4ce95acfcaa7..1fc22dfc8bee 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -46,3 +46,7 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+ifeq ($(CONFIG_FUSE_BPF),y)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_fuse.o
+endif
diff --git a/kernel/bpf/bpf_fuse.c b/kernel/bpf/bpf_fuse.c
new file mode 100644
index 000000000000..7ae93b5230c7
--- /dev/null
+++ b/kernel/bpf/bpf_fuse.c
@@ -0,0 +1,716 @@
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
+__bpf_kfunc_start_defs();
+__bpf_kfunc void bpf_fuse_get_rw_dynptr(struct fuse_buffer *buffer, struct bpf_dynptr_kern *dynptr__uninit, u64 size, bool copy)
+{
+	buffer->data = bpf_fuse_get_writeable(buffer, size, copy);
+	bpf_dynptr_init(dynptr__uninit, buffer->data, BPF_DYNPTR_TYPE_LOCAL, 0, buffer->size);
+}
+
+__bpf_kfunc void bpf_fuse_get_ro_dynptr(const struct fuse_buffer *buffer, struct bpf_dynptr_kern *dynptr__uninit)
+{
+	bpf_dynptr_init(dynptr__uninit, buffer->data, BPF_DYNPTR_TYPE_LOCAL, 0, buffer->size);
+	bpf_dynptr_set_rdonly(dynptr__uninit);
+}
+
+__bpf_kfunc uint32_t bpf_fuse_return_len(struct fuse_buffer *buffer)
+{
+	return buffer->size;
+}
+__diag_pop();
+__bpf_kfunc_end_defs();
+BTF_KFUNCS_START(fuse_kfunc_set)
+BTF_ID_FLAGS(func, bpf_fuse_get_rw_dynptr)
+BTF_ID_FLAGS(func, bpf_fuse_get_ro_dynptr)
+BTF_ID_FLAGS(func, bpf_fuse_return_len)
+BTF_KFUNCS_END(fuse_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_fuse_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &fuse_kfunc_set,
+};
+
+static const struct bpf_func_proto *bpf_fuse_get_func_proto(enum bpf_func_id func_id,
+							      const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	default:
+		return bpf_base_func_proto(func_id, prog);
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
+/* CFI Stubs */
+static uint32_t bpf_fuse_default_filter(const struct bpf_fuse_meta_info *meta)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_open_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_open_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_opendir_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_opendir_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_create_open_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_create_in *in, struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_create_open_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_create_in *in, const struct fuse_buffer *name,
+				struct fuse_entry_out *entry_out, struct fuse_open_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_release_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_release_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_release_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_releasedir_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_releasedir_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_release_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_flush_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_flush_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_flush_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_flush_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_lseek_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_lseek_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_lseek_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_lseek_in *in,
+				struct fuse_lseek_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_copy_file_range_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_copy_file_range_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_copy_file_range_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_copy_file_range_in *in,
+				struct fuse_write_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_fsync_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_fsync_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fsync_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_dir_fsync_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_dir_fsync_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fsync_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_getxattr_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in, struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_getxattr_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getxattr_in *in, const struct fuse_buffer *name,
+				struct fuse_buffer *value, struct fuse_getxattr_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_listxattr_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_listxattr_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getxattr_in *in,
+				struct fuse_buffer *value, struct fuse_getxattr_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_setxattr_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_setxattr_in *in, struct fuse_buffer *name,
+					struct fuse_buffer *value)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_setxattr_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_setxattr_in *in, const struct fuse_buffer *name,
+					const struct fuse_buffer *value)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_removexattr_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_removexattr_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_read_iter_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_read_iter_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_iter_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_write_iter_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_write_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_write_iter_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_write_in *in,
+				struct fuse_write_iter_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_file_fallocate_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_fallocate_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_file_fallocate_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fallocate_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_lookup_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_lookup_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name,
+				struct fuse_entry_out *out, struct fuse_buffer *entries)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_mknod_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_mknod_in *in, struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_mknod_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_mknod_in *in, const struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_mkdir_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_in *in, struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_mkdir_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_mkdir_in *in, const struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_rmdir_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_rmdir_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_rename2_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename2_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_rename2_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_rename2_in *in, const struct fuse_buffer *old_name,
+				const struct fuse_buffer *new_name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_rename_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_rename_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_rename_in *in, const struct fuse_buffer *old_name,
+				const struct fuse_buffer *new_name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_unlink_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_unlink_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_link_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_link_in *in, struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_link_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_link_in *in, const struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_getattr_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_getattr_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_getattr_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getattr_in *in,
+				struct fuse_attr_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_setattr_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_setattr_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_setattr_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_setattr_in *in,
+				struct fuse_attr_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_statfs_prefilter(const struct bpf_fuse_meta_info *meta)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_statfs_postfilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_statfs_out *out)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_get_link_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_get_link_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_symlink_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name, struct fuse_buffer *path)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_symlink_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name, const struct fuse_buffer *path)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_readdir_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_readdir_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_out *out, struct fuse_buffer *buffer)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_access_prefilter(const struct bpf_fuse_meta_info *meta,
+				struct fuse_access_in *in)
+{
+	return 0;
+}
+
+static uint32_t bpf_fuse_access_postfilter(const struct bpf_fuse_meta_info *meta,
+				const struct fuse_access_in *in)
+{
+	return 0;
+}
+
+static struct fuse_ops __bpf_fuse_ops = {
+	.default_filter = bpf_fuse_default_filter,
+	.open_prefilter = bpf_fuse_open_prefilter,
+	.open_postfilter = bpf_fuse_open_postfilter,
+	.opendir_prefilter = bpf_fuse_opendir_prefilter,
+	.opendir_postfilter = bpf_fuse_opendir_postfilter,
+	.create_open_prefilter = bpf_fuse_create_open_prefilter,
+	.create_open_postfilter = bpf_fuse_create_open_postfilter,
+	.release_prefilter = bpf_fuse_release_prefilter,
+	.release_postfilter = bpf_fuse_release_postfilter,
+	.releasedir_prefilter = bpf_fuse_releasedir_prefilter,
+	.releasedir_postfilter = bpf_fuse_releasedir_postfilter,
+	.flush_prefilter = bpf_fuse_flush_prefilter,
+	.flush_postfilter = bpf_fuse_flush_postfilter,
+	.lseek_prefilter = bpf_fuse_lseek_prefilter,
+	.lseek_postfilter = bpf_fuse_lseek_postfilter,
+	.copy_file_range_prefilter = bpf_fuse_copy_file_range_prefilter,
+	.copy_file_range_postfilter = bpf_fuse_copy_file_range_postfilter,
+	.fsync_prefilter = bpf_fuse_fsync_prefilter,
+	.fsync_postfilter = bpf_fuse_fsync_postfilter,
+	.dir_fsync_prefilter = bpf_fuse_dir_fsync_prefilter,
+	.dir_fsync_postfilter = bpf_fuse_dir_fsync_postfilter,
+	.getxattr_prefilter = bpf_fuse_getxattr_prefilter,
+	.getxattr_postfilter = bpf_fuse_getxattr_postfilter,
+	.listxattr_prefilter = bpf_fuse_listxattr_prefilter,
+	.listxattr_postfilter = bpf_fuse_listxattr_postfilter,
+	.setxattr_prefilter = bpf_fuse_setxattr_prefilter,
+	.setxattr_postfilter = bpf_fuse_setxattr_postfilter,
+	.removexattr_prefilter = bpf_fuse_removexattr_prefilter,
+	.removexattr_postfilter = bpf_fuse_removexattr_postfilter,
+	.read_iter_prefilter = bpf_fuse_read_iter_prefilter,
+	.read_iter_postfilter = bpf_fuse_read_iter_postfilter,
+	.write_iter_prefilter = bpf_fuse_write_iter_prefilter,
+	.write_iter_postfilter = bpf_fuse_write_iter_postfilter,
+	.file_fallocate_prefilter = bpf_fuse_file_fallocate_prefilter,
+	.file_fallocate_postfilter = bpf_fuse_file_fallocate_postfilter,
+	.lookup_prefilter = bpf_fuse_lookup_prefilter,
+	.lookup_postfilter = bpf_fuse_lookup_postfilter,
+	.mknod_prefilter = bpf_fuse_mknod_prefilter,
+	.mknod_postfilter = bpf_fuse_mknod_postfilter,
+	.mkdir_prefilter = bpf_fuse_mkdir_prefilter,
+	.mkdir_postfilter = bpf_fuse_mkdir_postfilter,
+	.rmdir_prefilter = bpf_fuse_rmdir_prefilter,
+	.rmdir_postfilter = bpf_fuse_rmdir_postfilter,
+	.rename2_prefilter = bpf_fuse_rename2_prefilter,
+	.rename2_postfilter = bpf_fuse_rename2_postfilter,
+	.rename_prefilter = bpf_fuse_rename_prefilter,
+	.rename_postfilter = bpf_fuse_rename_postfilter,
+	.unlink_prefilter = bpf_fuse_unlink_prefilter,
+	.unlink_postfilter = bpf_fuse_unlink_postfilter,
+	.link_prefilter = bpf_fuse_link_prefilter,
+	.link_postfilter = bpf_fuse_link_postfilter,
+	.getattr_prefilter = bpf_fuse_getattr_prefilter,
+	.getattr_postfilter = bpf_fuse_getattr_postfilter,
+	.setattr_prefilter = bpf_fuse_setattr_prefilter,
+	.setattr_postfilter = bpf_fuse_setattr_postfilter,
+	.statfs_prefilter = bpf_fuse_statfs_prefilter,
+	.statfs_postfilter = bpf_fuse_statfs_postfilter,
+	.get_link_prefilter = bpf_fuse_get_link_prefilter,
+	.get_link_postfilter = bpf_fuse_get_link_postfilter,
+	.symlink_prefilter = bpf_fuse_symlink_prefilter,
+	.symlink_postfilter = bpf_fuse_symlink_postfilter,
+	.readdir_prefilter = bpf_fuse_readdir_prefilter,
+	.readdir_postfilter = bpf_fuse_readdir_postfilter,
+	.access_prefilter = bpf_fuse_access_prefilter,
+	.access_postfilter = bpf_fuse_access_postfilter,
+};
+
+static struct bpf_struct_ops bpf_fuse_ops = {
+	.verifier_ops = &bpf_fuse_verifier_ops,
+	.reg = bpf_fuse_reg,
+	.unreg = bpf_fuse_unreg,
+	.check_member = bpf_fuse_check_member,
+	.init_member = bpf_fuse_init_member,
+	.init = bpf_fuse_init,
+	.name = "fuse_ops",
+	.cfi_stubs = &__bpf_fuse_ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init bpf_fuse_ops_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_fuse_kfunc_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_fuse_ops, fuse_ops);
+
+	return ret;
+}
+late_initcall(bpf_fuse_ops_init);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 170d017e8e4a..29f7db457127 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -26,6 +26,7 @@
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/bpf_fuse.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee86e4d7d5fc..eb0808ed3cd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10947,6 +10947,8 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_fuse_get_rw_dynptr,
+	KF_bpf_fuse_get_ro_dynptr,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10973,6 +10975,8 @@ BTF_ID(func, bpf_throw)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+BTF_ID(func, bpf_fuse_get_rw_dynptr)
+BTF_ID(func, bpf_fuse_get_ro_dynptr)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11003,6 +11007,8 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_fuse_get_rw_dynptr)
+BTF_ID(func, bpf_fuse_get_ro_dynptr)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11793,7 +11799,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					verbose(env, "verifier internal error: missing ref obj id for parent of clone\n");
 					return -EFAULT;
 				}
-			}
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_fuse_get_rw_dynptr] ||
+					meta->func_id == special_kfunc_list[KF_bpf_fuse_get_ro_dynptr])
+				dynptr_arg_type |= DYNPTR_TYPE_LOCAL;
 
 			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
 			if (ret < 0)
-- 
2.44.0.478.gd926399ef9-goog


