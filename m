Return-Path: <linux-fsdevel+bounces-15657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A437891137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7681F24118
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1013CF8F;
	Fri, 29 Mar 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSeGM2Oe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2013C67C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677324; cv=none; b=c1owYkBhaCL/Eao7cbeK00irGbgJjzLPai43RSTJ0NwUDXWib4i7iw/z56AWfzM5rJHGpqHWpU+0vpTnbwxpzobAeNOWlxk+K5zXfD8ZY0r3pmCq2xzWjz/xxF+peO31zJKCVQkwUz6vapPT1RSqpOJahyRUqrDi1mOry4cMnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677324; c=relaxed/simple;
	bh=QYiNaoP0wgjmdl7KYo7r8xxfmKhoKe/kT/EhiLUTu0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JahoQEecD3g+vD60v3tef5IlwOBNARPXaffK6iSKrgdvTbZtAs5Rk1Zy3ghv4DuJ19//iI9raJ2vJbiRr/HD/WvJKMa9CKFScsBl6dpab4WDVezpXWLuHzs0Y51DQeqz8xO+GVdC/ezcYej9xtBT63kEZAkMf4N6cplLfmjGD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSeGM2Oe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ad239f8fso26667207b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677320; x=1712282120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUsaTtgkbErn3BD3WrF1FB8TcQrwq3YumJAvXSLdPcQ=;
        b=zSeGM2OeJgyM4PeXDAJaiPVsLJx+U7ndpvAssuJK0jVaEMzucfi/14YPsyKU+s8Lu2
         lD8GPe4yfscOaQHuTPssmlaFNEK/RSmq/94ZbsuuRSIfSdsVAJX05f28PVwcgoRKwR9P
         bs0cGXh1LkW0v9Krn8My53D1BtNRs6Yt7+H+d1/h1zyeXPD6zvFRZwoJTGP0PER5Ow/+
         VicZy4gPL4+cqrrFH6XijIeUYmqKMTTfOWJszuJI2/cWK7LVLkDfsgvY+4lRshpvvqhp
         iZnwLFuE0cQotQ5WbOWS3zTzi4uzELLOAoqqdVx09EYCJYQzQRSMqHcltl7LnvpRiF9V
         9GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677320; x=1712282120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUsaTtgkbErn3BD3WrF1FB8TcQrwq3YumJAvXSLdPcQ=;
        b=QfY/xBNj7ox7MqQT9TOET/MlJcgt7dCv50FK6GLIOU6yuIG+zTtj5oK8vYltiB9yM/
         r7BcYjWt5DOKxrHsW9kXc86pfpqMepGDnwqX1WNGX0XFvXEtHvMN9aifD7BFo+nfKE26
         Wnkk3pl0kopS1eMjitca4EYlXKFXshVPHaZd60CB5gvjDhB/cbiqR2+k1E07SqgIBKxj
         3EdIhbugoYY3ROnT5prW9uk+oiaq01Nm/y9/Dv/j/YKOpwdh745dFPoSSnUl4JoqdVnD
         SZInOWobo7ShOdNYjOAEEef+vXFm9wKYw+TTSeKvFzUg2rTY/Ed2wvK0nC3uT1O27nGp
         4OjA==
X-Forwarded-Encrypted: i=1; AJvYcCUoH7NymX0maPsxvNaT2ypFj6H79Poyyl4X7lK54qQBOP8OX2qAFYqD0Zq3rdf1K7hLVFW8fOykyp+9HBQleiFk1S6hkdU+ts7U9tcufQ==
X-Gm-Message-State: AOJu0Yy3zNB6vvZm/ckpmpEluJBGZxucviGYefzyB8zMYvoo7fbFx9z3
	4eUd2BWK9/lzHJmjV1ILxUtBOhPIJw0OeM62+sG7qRzsc68azBmAqAJK2jm0Tq3Nl2Es2Hrxr2O
	Wsw==
X-Google-Smtp-Source: AGHT+IHHRmevfoLaT4O3ZiZOOorIZcG6OlW64J4uxzsicKT/QzpKc+1r71hBTI36u3UKAsk58C0KEcDo3Qw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:ca01:0:b0:60a:16ae:38ee with SMTP id
 m1-20020a0dca01000000b0060a16ae38eemr282231ywd.3.1711677319906; Thu, 28 Mar
 2024 18:55:19 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:51 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-37-drosen@google.com>
Subject: [RFC PATCH v4 36/36] fuse: Provide easy way to test fuse struct_op call
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

This is useful for quickly testing a struct_op program.
I've been using this set up to test verifier changes.

I'll eventually move those sorts of tests to bpf selftests

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/inode.c                               |  70 ++
 .../selftests/filesystems/fuse/Makefile       |   1 +
 .../filesystems/fuse/struct_op_test.bpf.c     | 642 ++++++++++++++++++
 3 files changed, 713 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/struct_op_test.bpf.c

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 67d70b3c4abb..cf9555e4be1f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2184,16 +2184,83 @@ static void fuse_fs_cleanup(void)
 
 static struct kobject *fuse_kobj;
 
+static char struct_op_name[BPF_FUSE_NAME_MAX];
+static struct fuse_ops *fop = NULL;
+
+static ssize_t struct_op_store(struct kobject *kobj,
+		  struct kobj_attribute *attr,
+		  const char *buf, size_t count)
+{
+	size_t max = count;
+
+	if (max > BPF_FUSE_NAME_MAX) max = BPF_FUSE_NAME_MAX;
+	strncpy(struct_op_name, buf, max);
+	if (struct_op_name[max-1] == '\n')
+		struct_op_name[max-1] = 0;
+	put_fuse_ops(fop);
+	fop = find_fuse_ops(struct_op_name);
+	if (!fop)
+		printk("No struct op named %s found", struct_op_name);
+
+	return count;
+}
+
+static ssize_t struct_op_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	struct fuse_ops *op;
+	uint32_t result = 0;
+	struct bpf_fuse_meta_info meta;
+	struct fuse_mkdir_in in;
+	struct fuse_buffer name;
+	char name_buff[10] = "test";
+
+	name.data = &name_buff[0];
+	name.flags = BPF_FUSE_VARIABLE_SIZE;
+	name.max_size = 10;
+	name.size = 5;
+
+	op = fop;
+	if (!op) {
+		printk("Could not find fuse_op for %s", struct_op_name);
+		return 0;
+	}
+
+	if (op->mkdir_prefilter)
+		result = op->mkdir_prefilter(&meta, &in, &name);
+	else
+		printk("No func!!");
+
+	printk("in->mode:%d, name:%s result:%d", in.mode, (char *)name.data, result);
+	return sprintf(buf, "%d dyn:%s\n", result, (char *)name.data);
+}
+
+static struct kobj_attribute test_attr = __ATTR_RW(struct_op);
+
+static struct attribute *test_attrs[] = {
+	&test_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group test_attr_group = {
+	.attrs = test_attrs,
+};
+
 static int fuse_sysfs_init(void)
 {
 	int err;
 
+	memset(struct_op_name, 0, BPF_FUSE_NAME_MAX);
 	fuse_kobj = kobject_create_and_add("fuse", fs_kobj);
 	if (!fuse_kobj) {
 		err = -ENOMEM;
 		goto out_err;
 	}
 
+	err = sysfs_create_group(fuse_kobj, &test_attr_group);
+	if (err)
+		goto tmp;
+
 	err = sysfs_create_mount_point(fuse_kobj, "connections");
 	if (err)
 		goto out_fuse_unregister;
@@ -2202,6 +2269,8 @@ static int fuse_sysfs_init(void)
 
  out_fuse_unregister:
 	kobject_put(fuse_kobj);
+tmp:
+	sysfs_remove_group(fuse_kobj, &test_attr_group);
  out_err:
 	return err;
 }
@@ -2209,6 +2278,7 @@ static int fuse_sysfs_init(void)
 static void fuse_sysfs_cleanup(void)
 {
 	sysfs_remove_mount_point(fuse_kobj, "connections");
+	sysfs_remove_group(fuse_kobj, &test_attr_group);
 	kobject_put(fuse_kobj);
 }
 
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
index b2df4dec0651..ff28859f3268 100644
--- a/tools/testing/selftests/filesystems/fuse/Makefile
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -52,6 +52,7 @@ SELFTESTS:=$(TOOLSDIR)/testing/selftests/
 LDLIBS := -lpthread -lelf -lz
 TEST_GEN_PROGS := fuse_test fuse_daemon
 TEST_GEN_FILES := \
+  struct_op_test.bpf.o \
 	test.skel.h \
 	fd.sh \
 
diff --git a/tools/testing/selftests/filesystems/fuse/struct_op_test.bpf.c b/tools/testing/selftests/filesystems/fuse/struct_op_test.bpf.c
new file mode 100644
index 000000000000..2cb178d2fa0c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/struct_op_test.bpf.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+// Copyright (c) 2021 Google LLC
+
+#include "vmlinux.h"
+//#include <uapi/linux/bpf.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+//#include <linux/fuse.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define BPF_STRUCT_OPS(type, name, args...)					\
+SEC("struct_ops/"#name)								\
+type BPF_PROG(name, ##args)
+
+/*
+struct test_struct {
+	uint32_t a;
+	uint32_t b;
+};
+
+
+*/
+//struct fuse_buffer;
+#define BPF_FUSE_CONTINUE		0
+/*struct fuse_ops {
+	uint32_t (*test_func)(void);
+	uint32_t (*test_func2)(struct test_struct *a);
+	uint32_t (*test_func3)(struct fuse_name *ptr);
+	//u32 (*open_prefilter)(struct bpf_fuse_hidden_info meh, struct bpf_fuse_meta_info header, struct fuse_open_in foi);
+	//u32 (*open_postfilter)(struct bpf_fuse_hidden_info meh, struct bpf_fuse_meta_info header, const struct fuse_open_in foi, struct fuse_open_out foo);
+	char name[BPF_FUSE_NAME_MAX];
+};
+*/
+extern uint32_t bpf_fuse_return_len(struct fuse_buffer *ptr) __ksym;
+extern void bpf_fuse_get_rw_dynptr(struct fuse_buffer *buffer, struct bpf_dynptr *dynptr, u64 size, bool copy) __ksym;
+extern void bpf_fuse_get_ro_dynptr(const struct fuse_buffer *buffer, struct bpf_dynptr *dynptr) __ksym;
+
+//extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+//extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
+//extern void bpf_key_put(struct bpf_key *key) __ksym;
+//extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
+//				      struct bpf_dynptr *sig_ptr,
+//				      struct bpf_key *trusted_keyring) __ksym;
+
+BPF_STRUCT_OPS(uint32_t, test_func, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_in *in, struct fuse_buffer *name)
+{
+	int res = 0;
+	struct bpf_dynptr name_ptr;
+	char *name_buf;
+	//char dummy[7] = {};
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 4);
+	bpf_printk("Hello test print");
+	if (!name_buf)
+		return -ENOMEM;
+	if (!bpf_strncmp(name_buf, 4, "test"))
+		return 42;	
+
+	//if (bpf_fuse_namecmp(name, "test", 4) == 0)
+	//	return 42;
+
+	return res;
+}
+
+SEC(".struct_ops")
+struct fuse_ops test_ops = {
+	.mkdir_prefilter = (void *)test_func,
+	.name = "test",
+};
+
+BPF_STRUCT_OPS(uint32_t, open_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	bpf_printk("open_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, open_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out)
+{
+	bpf_printk("open_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, opendir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	bpf_printk("opendir_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, opendir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out)
+{
+	bpf_printk("opendir_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, create_open_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_create_in *in, struct fuse_buffer *name)
+{
+	bpf_printk("create_open_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, create_open_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_create_in *in, const struct fuse_buffer *name,
+				struct fuse_entry_out *entry_out, struct fuse_open_out *out)
+{
+	bpf_printk("create_open_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, release_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	bpf_printk("release_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, release_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_release_in *in)
+{
+	bpf_printk("release_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, releasedir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	bpf_printk("releasedir_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, releasedir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_release_in *in)
+{
+	bpf_printk("releasedir_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, flush_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_flush_in *in)
+{
+	bpf_printk("flush_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, flush_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_flush_in *in)
+{
+	bpf_printk("flush_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, lseek_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_lseek_in *in)
+{
+	bpf_printk("lseek_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, lseek_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_lseek_in *in,
+				struct fuse_lseek_out *out)
+{
+	bpf_printk("lseek_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, copy_file_range_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_copy_file_range_in *in)
+{
+	bpf_printk("copy_file_range_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, copy_file_range_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_copy_file_range_in *in,
+				struct fuse_write_out *out)
+{
+	bpf_printk("copy_file_range_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, fsync_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in)
+{
+	bpf_printk("fsync_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, fsync_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fsync_in *in)
+{
+	bpf_printk("fsync_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, dir_fsync_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_fsync_in *in)
+{
+	bpf_printk("dir_fsync_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, dir_fsync_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fsync_in *in)
+{
+	bpf_printk("dir_fsync_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, getxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in, struct fuse_buffer *name)
+{
+	bpf_printk("getxattr_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, getxattr_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getxattr_in *in, const struct fuse_buffer *name,
+				struct fuse_buffer *value, struct fuse_getxattr_out *out)
+{
+	bpf_printk("getxattr_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, listxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in)
+{
+	bpf_printk("listxattr_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, listxattr_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getxattr_in *in,
+				struct fuse_buffer *value, struct fuse_getxattr_out *out)
+{
+	bpf_printk("listxattr_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, setxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_setxattr_in *in, struct fuse_buffer *name,
+					struct fuse_buffer *value)
+{
+	bpf_printk("setxattr_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, setxattr_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_setxattr_in *in, const struct fuse_buffer *name,
+					const struct fuse_buffer *value)
+{
+	bpf_printk("setxattr_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, removexattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	bpf_printk("removexattr_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, removexattr_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	bpf_printk("removexattr_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, read_iter_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("read_iter_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, read_iter_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_iter_out *out)
+{
+	bpf_printk("read_iter_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, write_iter_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_write_in *in)
+{
+	bpf_printk("write_iter_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, write_iter_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_write_in *in,
+				struct fuse_write_iter_out *out)
+{
+	bpf_printk("write_iter_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, file_fallocate_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_fallocate_in *in)
+{
+	bpf_printk("file_fallocate_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, file_fallocate_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_fallocate_in *in)
+{
+	bpf_printk("file_fallocate_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, lookup_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	bpf_printk("lookup_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, lookup_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name,
+				struct fuse_entry_out *out, struct fuse_buffer *entries)
+{
+	bpf_printk("lookup_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, mknod_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mknod_in *in, struct fuse_buffer *name)
+{
+	bpf_printk("mknod_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, mknod_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_mknod_in *in, const struct fuse_buffer *name)
+{
+	bpf_printk("mknod_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, mkdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_in *in, struct fuse_buffer *name)
+{
+	bpf_printk("mkdir_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, mkdir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_mkdir_in *in, const struct fuse_buffer *name)
+{
+	bpf_printk("mkdir_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, rmdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	bpf_printk("rmdir_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, rmdir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	bpf_printk("rmdir_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, rename2_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename2_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	bpf_printk("rename2_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, rename2_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_rename2_in *in, const struct fuse_buffer *old_name,
+				const struct fuse_buffer *new_name)
+{
+	bpf_printk("rename2_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, rename_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	bpf_printk("rename_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, rename_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_rename_in *in, const struct fuse_buffer *old_name,
+				const struct fuse_buffer *new_name)
+{
+	bpf_printk("rename_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, unlink_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	bpf_printk("unlink_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, unlink_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	bpf_printk("unlink_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, link_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_link_in *in, struct fuse_buffer *name)
+{
+	bpf_printk("link_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, link_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_link_in *in, const struct fuse_buffer *name)
+{
+	bpf_printk("link_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, getattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getattr_in *in)
+{
+	bpf_printk("getattr_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, getattr_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_getattr_in *in,
+				struct fuse_attr_out *out)
+{
+	bpf_printk("getattr_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, setattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_setattr_in *in)
+{
+	bpf_printk("setattr_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, setattr_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_setattr_in *in,
+				struct fuse_attr_out *out)
+{
+	bpf_printk("setattr_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, statfs_prefilter, const struct bpf_fuse_meta_info *meta)
+{
+	bpf_printk("statfs_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, statfs_postfilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_statfs_out *out)
+{
+	bpf_printk("statfs_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, get_link_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	bpf_printk("get_link_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, get_link_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name)
+{
+	bpf_printk("get_link_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, symlink_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name, struct fuse_buffer *path)
+{
+	bpf_printk("symlink_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, symlink_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name, const struct fuse_buffer *path)
+{
+	bpf_printk("symlink_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, readdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("readdir_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, readdir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_out *out, struct fuse_buffer *buffer)
+{
+	bpf_printk("readdir_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, access_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_access_in *in)
+{
+	bpf_printk("access_prefilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, access_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_access_in *in)
+{
+	bpf_printk("access_postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC(".struct_ops")
+struct fuse_ops trace_ops = {
+	.open_prefilter = (void *)open_prefilter,
+	.open_postfilter = (void *)open_postfilter,
+
+	.opendir_prefilter = (void *)opendir_prefilter,
+	.opendir_postfilter = (void *)opendir_postfilter,
+
+	.create_open_prefilter = (void *)create_open_prefilter,
+	.create_open_postfilter = (void *)create_open_postfilter,
+
+	.release_prefilter = (void *)release_prefilter,
+	.release_postfilter = (void *)release_postfilter,
+
+	.releasedir_prefilter = (void *)releasedir_prefilter,
+	.releasedir_postfilter = (void *)releasedir_postfilter,
+
+	.flush_prefilter = (void *)flush_prefilter,
+	.flush_postfilter = (void *)flush_postfilter,
+
+	.lseek_prefilter = (void *)lseek_prefilter,
+	.lseek_postfilter = (void *)lseek_postfilter,
+
+	.copy_file_range_prefilter = (void *)copy_file_range_prefilter,
+	.copy_file_range_postfilter = (void *)copy_file_range_postfilter,
+
+	.fsync_prefilter = (void *)fsync_prefilter,
+	.fsync_postfilter = (void *)fsync_postfilter,
+
+	.dir_fsync_prefilter = (void *)dir_fsync_prefilter,
+	.dir_fsync_postfilter = (void *)dir_fsync_postfilter,
+
+	.getxattr_prefilter = (void *)getxattr_prefilter,
+	.getxattr_postfilter = (void *)getxattr_postfilter,
+
+	.listxattr_prefilter = (void *)listxattr_prefilter,
+	.listxattr_postfilter = (void *)listxattr_postfilter,
+
+	.setxattr_prefilter = (void *)setxattr_prefilter,
+	.setxattr_postfilter = (void *)setxattr_postfilter,
+
+	.removexattr_prefilter = (void *)removexattr_prefilter,
+	.removexattr_postfilter = (void *)removexattr_postfilter,
+
+	.read_iter_prefilter = (void *)read_iter_prefilter,
+	.read_iter_postfilter = (void *)read_iter_postfilter,
+
+	.write_iter_prefilter = (void *)write_iter_prefilter,
+	.write_iter_postfilter = (void *)write_iter_postfilter,
+
+	.file_fallocate_prefilter = (void *)file_fallocate_prefilter,
+	.file_fallocate_postfilter = (void *)file_fallocate_postfilter,
+
+	.lookup_prefilter = (void *)lookup_prefilter,
+	.lookup_postfilter = (void *)lookup_postfilter,
+
+	.mknod_prefilter = (void *)mknod_prefilter,
+	.mknod_postfilter = (void *)mknod_postfilter,
+
+	.mkdir_prefilter = (void *)mkdir_prefilter,
+	.mkdir_postfilter = (void *)mkdir_postfilter,
+
+	.rmdir_prefilter = (void *)rmdir_prefilter,
+	.rmdir_postfilter = (void *)rmdir_postfilter,
+
+	.rename2_prefilter = (void *)rename2_prefilter,
+	.rename2_postfilter = (void *)rename2_postfilter,
+
+	.rename_prefilter = (void *)rename_prefilter,
+	.rename_postfilter = (void *)rename_postfilter,
+
+	.unlink_prefilter = (void *)unlink_prefilter,
+	.unlink_postfilter = (void *)unlink_postfilter,
+
+	.link_prefilter = (void *)link_prefilter,
+	.link_postfilter = (void *)link_postfilter,
+
+	.getattr_prefilter = (void *)getattr_prefilter,
+	.getattr_postfilter = (void *)getattr_postfilter,
+
+	.setattr_prefilter = (void *)setattr_prefilter,
+	.setattr_postfilter = (void *)setattr_postfilter,
+
+	.statfs_prefilter = (void *)statfs_prefilter,
+	.statfs_postfilter = (void *)statfs_postfilter,
+
+	.get_link_prefilter = (void *)get_link_prefilter,
+	.get_link_postfilter = (void *)get_link_postfilter,
+
+	.symlink_prefilter = (void *)symlink_prefilter,
+	.symlink_postfilter = (void *)symlink_postfilter,
+
+	.readdir_prefilter = (void *)readdir_prefilter,
+	.readdir_postfilter = (void *)readdir_postfilter,
+
+	.access_prefilter = (void *)access_prefilter,
+	.access_postfilter = (void *)access_postfilter,
+
+	.name = "trace_pre_ops",
+};
-- 
2.44.0.478.gd926399ef9-goog


