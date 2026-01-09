Return-Path: <linux-fsdevel+bounces-73080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA90D0BD2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFA11303FCC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22580368289;
	Fri,  9 Jan 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="nGU/0uVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F54364E95;
	Fri,  9 Jan 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983238; cv=none; b=XqDtPp5bl5fz1z4awgS7lz1CM9v9me1z9yhpgwdWPxpulDoM5cMcLPjY0nW/qUGexgZCrcPezIlum2V2exE0pbTs/nQ4pDOLaec/JoL1k7k3b8LNWO0w+c9+sVIKx1cix/Q1s5LrZTMP89gO9WciMuYxWBaf/Q9k9Ema5/prAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983238; c=relaxed/simple;
	bh=FfNfHuhka45Oh1oAKK9SM76gPbOP7HrYhJ9pgVkxaLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPDAOWGB45tH3shiCah0Ptrh6IU2ERNlTL2Y+jVwxPQuBlqVs3yXMtBvUxSieZZLqJuzBl0PqDmuO5zJ83LUMmjYU03UFWNpHbyoOuzTB1qgL54VK5uArY02S2ObhHzcUtXRw2ucSo/sxNYIq68GlxgjwriozJ8h1nrPxMFxmds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=nGU/0uVZ; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from [127.0.1.1] (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 5474EE01F7;
	Fri,  9 Jan 2026 19:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1767983228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSiK28kg0Qx+lI39xvPxztDwFHl+hlxd3X0is3FrMoQ=;
	b=nGU/0uVZ8WwmXl60vQ0JWZVribYcQJUxm5d7VufN8jQ9UB+idnpHCq5H+0RtlHE5Yf9xYG
	vrNzfdTnHjifni5g+bSst6nigs7PYdVH2iw+yOaY361H8CMp7DKHvgPbsOJAtSGfPmlnfw
	9BIn6CdMzeTfEKOiNmPjfO6WOr+RPoHfTxxhtVMenPXpodC3JYqaO3p4yfkvQ3EbtgKrLx
	cAWxI2Ga20u54/EICJNnd1WlceR1hXlCrcw3jaKZQQhElLT44ehwDk9RqHQhhJcqcsW/Kq
	+7VKSrb7SQkR8flHA8SHut7Jpek7+QAlvNXHJNuvncehtuZwLnTO/t5mHeCTng==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Fri, 09 Jan 2026 19:26:59 +0100
Subject: [PATCH v4 1/3] fuse: add compound command to combine multiple
 requests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-fuse-compounds-upstream-v4-1-0d3b82a4666f@ddn.com>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
In-Reply-To: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767983227; l=11366;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=AQhJiHqXWZQ/xoM10wtTeI1woX0yVXrn5+y/+dfoVWQ=;
 b=8mMES687V2jmWoB/P239dt/TThSzXFctwWUlpqG6Ppdb3ooQr7bl1FZi8UfkLxLNMVuwFNLrZ
 9kow/Aj7ombC361etRVblL/pJzwsKIJJ7FGzDZF2eLycuLyS1UT8QBV
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

For a FUSE_COMPOUND we add a header that contains information
about how many commands there are in the compound and about the
size of the expected result. This will make the interpretation
in libfuse easier, since we can preallocate the whole result.
Then we append the requests that belong to this compound.

The API for the compound command has:
  fuse_compound_alloc()
  fuse_compound_add()
  fuse_compound_send()
  fuse_compound_free()

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 270 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  12 +++
 include/uapi/linux/fuse.h |  37 +++++++
 4 files changed, 320 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 22ad9538dfc4..4c09038ef995 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
-fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
+fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o compound.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
diff --git a/fs/fuse/compound.c b/fs/fuse/compound.c
new file mode 100644
index 000000000000..0f1e4c073d8b
--- /dev/null
+++ b/fs/fuse/compound.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025
+ *
+ * This file implements compound operations for FUSE, allowing multiple
+ * operations to be batched into a single request to reduce round trips
+ * between kernel and userspace.
+ */
+
+#include "fuse_i.h"
+
+/*
+ * Compound request builder and state tracker and args pointer storage
+ */
+struct fuse_compound_req {
+	struct fuse_mount *fm;
+	struct fuse_compound_in compound_header;
+	struct fuse_compound_out result_header;
+
+	/* Per-operation error codes */
+	int op_errors[FUSE_MAX_COMPOUND_OPS];
+	/* Original fuse_args for response parsing */
+	struct fuse_args *op_args[FUSE_MAX_COMPOUND_OPS];
+};
+
+struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, u32 flags)
+{
+	struct fuse_compound_req *compound;
+
+	compound = kzalloc(sizeof(*compound), GFP_KERNEL);
+	if (!compound)
+		return ERR_PTR(-ENOMEM);
+
+	compound->fm = fm;
+	compound->compound_header.flags = flags;
+
+	return compound;
+}
+
+void fuse_compound_free(struct fuse_compound_req *compound)
+{
+	if (!compound)
+		return;
+
+	kfree(compound);
+}
+
+int fuse_compound_add(struct fuse_compound_req *compound,
+		      struct fuse_args *args)
+{
+	if (!compound ||
+	    compound->compound_header.count >= FUSE_MAX_COMPOUND_OPS)
+		return -EINVAL;
+
+	if (args->in_pages)
+		return -EINVAL;
+
+	compound->op_args[compound->compound_header.count] = args;
+	compound->compound_header.count++;
+	return 0;
+}
+
+static void *fuse_copy_response_data(struct fuse_args *args,
+				     char *response_data)
+{
+	size_t copied = 0;
+	int i;
+
+	for (i = 0; i < args->out_numargs; i++) {
+		struct fuse_arg current_arg = args->out_args[i];
+		size_t arg_size;
+
+		/*
+		 * Last argument with out_pages: copy to pages
+		 * External payload (in the last out arg) is not supported
+		 * at the moment
+		 */
+		if (i == args->out_numargs - 1 && args->out_pages)
+			return response_data;
+
+		arg_size = current_arg.size;
+
+		if (current_arg.value && arg_size > 0) {
+			memcpy(current_arg.value,
+			       (char *)response_data + copied, arg_size);
+			copied += arg_size;
+		}
+	}
+
+	return (char *)response_data + copied;
+}
+
+int fuse_compound_get_error(struct fuse_compound_req *compound, int op_idx)
+{
+	return compound->op_errors[op_idx];
+}
+
+static void *fuse_compound_parse_one_op(struct fuse_compound_req *compound,
+					int op_index, void *op_out_data,
+					void *response_end)
+{
+	struct fuse_out_header *op_hdr = op_out_data;
+	struct fuse_args *args = compound->op_args[op_index];
+
+	if (op_hdr->len < sizeof(struct fuse_out_header))
+		return NULL;
+
+	/* Check if the entire operation response fits in the buffer */
+	if ((char *)op_out_data + op_hdr->len > (char *)response_end)
+		return NULL;
+
+	if (op_hdr->error != 0)
+		compound->op_errors[op_index] = op_hdr->error;
+
+	if (args && op_hdr->len > sizeof(struct fuse_out_header))
+		return fuse_copy_response_data(args, op_out_data +
+					       sizeof(struct fuse_out_header));
+
+	/* No response data, just advance past the header */
+	return (char *)op_out_data + op_hdr->len;
+}
+
+static int fuse_compound_parse_resp(struct fuse_compound_req *compound,
+				    u32 count, void *response,
+				    size_t response_size)
+{
+	void *op_out_data = response;
+	void *response_end = (char *)response + response_size;
+	int i;
+
+	if (!response || response_size < sizeof(struct fuse_out_header))
+		return -EIO;
+
+	for (i = 0; i < count && i < compound->result_header.count; i++) {
+		op_out_data = fuse_compound_parse_one_op(compound, i,
+							 op_out_data,
+							 response_end);
+		if (!op_out_data)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+ssize_t fuse_compound_send(struct fuse_compound_req *compound)
+{
+	struct fuse_args args = {
+		.opcode = FUSE_COMPOUND,
+		.nodeid = 0,
+		.in_numargs = 2,
+		.out_numargs = 2,
+		.out_argvar = true,
+	};
+	size_t resp_buffer_size;
+	size_t actual_response_size;
+	size_t buffer_pos;
+	size_t total_expected_out_size;
+	void *buffer = NULL;
+	void *resp_payload;
+	ssize_t ret;
+	int i;
+
+	if (!compound) {
+		pr_info_ratelimited("FUSE: compound request is NULL in %s\n",
+				    __func__);
+		return -EINVAL;
+	}
+
+	if (compound->compound_header.count == 0) {
+		pr_info_ratelimited("FUSE: compound request contains no operations\n");
+		return -EINVAL;
+	}
+
+	buffer_pos = 0;
+	total_expected_out_size = 0;
+
+	for (i = 0; i < compound->compound_header.count; i++) {
+		struct fuse_args *op_args = compound->op_args[i];
+		size_t needed_size = sizeof(struct fuse_in_header);
+		int j;
+
+		for (j = 0; j < op_args->in_numargs; j++)
+			needed_size += op_args->in_args[j].size;
+
+		buffer_pos += needed_size;
+
+		for (j = 0; j < op_args->out_numargs; j++)
+			total_expected_out_size += op_args->out_args[j].size;
+	}
+
+	buffer = kvmalloc(buffer_pos, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	buffer_pos = 0;
+	for (i = 0; i < compound->compound_header.count; i++) {
+		struct fuse_args *op_args = compound->op_args[i];
+		struct fuse_in_header *hdr;
+		size_t needed_size = sizeof(struct fuse_in_header);
+		int j;
+
+		for (j = 0; j < op_args->in_numargs; j++)
+			needed_size += op_args->in_args[j].size;
+
+		hdr = (struct fuse_in_header *)(buffer + buffer_pos);
+		memset(hdr, 0, sizeof(*hdr));
+		hdr->len = needed_size;
+		hdr->opcode = op_args->opcode;
+		hdr->nodeid = op_args->nodeid;
+		hdr->uid = from_kuid(compound->fm->fc->user_ns,
+				     current_fsuid());
+		hdr->gid = from_kgid(compound->fm->fc->user_ns,
+				     current_fsgid());
+		hdr->pid = pid_nr_ns(task_pid(current),
+				     compound->fm->fc->pid_ns);
+		buffer_pos += sizeof(*hdr);
+
+		for (j = 0; j < op_args->in_numargs; j++) {
+			memcpy(buffer + buffer_pos, op_args->in_args[j].value,
+			       op_args->in_args[j].size);
+			buffer_pos += op_args->in_args[j].size;
+		}
+	}
+
+	resp_buffer_size = total_expected_out_size +
+			   (compound->compound_header.count *
+			    sizeof(struct fuse_out_header));
+
+	resp_payload = kvmalloc(resp_buffer_size, GFP_KERNEL | __GFP_ZERO);
+	if (!resp_payload) {
+		ret = -ENOMEM;
+		goto out_free_buffer;
+	}
+
+	compound->compound_header.result_size = total_expected_out_size;
+
+	args.in_args[0].size = sizeof(compound->compound_header);
+	args.in_args[0].value = &compound->compound_header;
+	args.in_args[1].size = buffer_pos;
+	args.in_args[1].value = buffer;
+
+	args.out_args[0].size = sizeof(compound->result_header);
+	args.out_args[0].value = &compound->result_header;
+	args.out_args[1].size = resp_buffer_size;
+	args.out_args[1].value = resp_payload;
+
+	ret = fuse_simple_request(compound->fm, &args);
+	if (ret < 0)
+		goto out;
+
+	actual_response_size = args.out_args[1].size;
+
+	if (actual_response_size < sizeof(struct fuse_compound_out)) {
+		pr_info_ratelimited("FUSE: compound response too small (%zu bytes, minimum %zu bytes)\n",
+				    actual_response_size,
+				    sizeof(struct fuse_compound_out));
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = fuse_compound_parse_resp(compound, compound->result_header.count,
+				       (char *)resp_payload,
+				       actual_response_size);
+out:
+	kvfree(resp_payload);
+out_free_buffer:
+	kvfree(buffer);
+	return ret;
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..6dddbe2b027b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1273,6 +1273,18 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
+/**
+ * Compound request API
+ */
+struct fuse_compound_req;
+ssize_t fuse_compound_send(struct fuse_compound_req *compound);
+
+struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, u32 flags);
+int fuse_compound_add(struct fuse_compound_req *compound,
+		      struct fuse_args *args);
+int fuse_compound_get_error(struct fuse_compound_req *compound, int op_idx);
+void fuse_compound_free(struct fuse_compound_req *compound);
+
 /**
  * Assign a unique id to a fuse request
  */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..4464f28c3242 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -664,6 +664,13 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	/* A compound request is handled like a single request,
+	 * but contains multiple requests as input.
+	 * This can be used to signal to the fuse server that
+	 * the requests can be combined atomically.
+	 */
+	FUSE_COMPOUND		= 54,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1245,6 +1252,36 @@ struct fuse_supp_groups {
 	uint32_t	groups[];
 };
 
+#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per compound */
+
+/*
+ * Compound request header
+ *
+ * This header is followed by the fuse requests
+ */
+struct fuse_compound_in {
+	uint32_t	count;			/* Number of operations */
+	uint32_t	flags;			/* Compound flags */
+
+	/* Total size of all results.
+	 * This is needed for preallocating the whole result for all
+	 * commands in this compound.
+	 */
+	uint32_t	result_size;
+	uint64_t	reserved;
+};
+
+/*
+ * Compound response header
+ *
+ * This header is followed by complete fuse responses
+ */
+struct fuse_compound_out {
+	uint32_t	count;     /* Number of results */
+	uint32_t	flags;     /* Result flags */
+	uint64_t	reserved;
+};
+
 /**
  * Size of the ring buffer header
  */

-- 
2.51.0


