Return-Path: <linux-fsdevel+bounces-71975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DCECD92C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A2EB3031350
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2873321B1;
	Tue, 23 Dec 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eUmSquzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43132BF4B
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766491542; cv=none; b=iz1/YT/dskI921ILaHac3eRMVZe3YNzKBDHju1/rLdBJXFEsr39yslwoqU1p3uN9kOHf7t/on1AaMyJfZKcldUe+02j5Bm8CMFIYViKvdfuSJ71VtjovLNoIfBn4i1gtWFQCnntVOY13aKV1cVz8rA2IZqexBLzEH3TWLLJO26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766491542; c=relaxed/simple;
	bh=35E48HvcYMg0kou9t2yxpZml62/twDfc2Vh6M7v7nc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G95juC4fn3zJ0X9xmNsKVanoP4DAYWBtw1/AQewKzImZ/PYNZjaEHLotlk+S8mvoO6/hgf4EY5bBt+v8dVZ8VBNguNMNs1UnHFjkjrXO/bumbcDGfj37zlSejCxJouyrJr3uqpciq9SBNqP/vEvvwI/U0nX0luhfJiiiFw0Doq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eUmSquzp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324054so805398766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766491539; x=1767096339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUo0nxbK9WUd9ag5FeRCOyqa0TGf8Cy3QKPa2v83ZVI=;
        b=eUmSquzp11F1+4LtYH8e0ytr3xscUbcT2LdtmBn4h0rVbaiX053JASxZTCeketwvAO
         eg0OTqgFoqTQ7U+2v5bZJ4NrvPUWi/4Sx6mZaOTTozkvRotHnPb/Obo202tu1YRWe13t
         gjC7D5qu99x1khmeCFEZ88Yf+OchRwmsrHTeXUu0PtqNBFMj30mMcOYlFMzW7p8oLDB0
         QeyTehKNx04Q5xToiCFOc9wLpabTe+Ua0daVEr/JE/JWdjlVarT2ID5inqKfMOLE36XR
         aAt/l7WOs5YfG6IOwEq94dIskabA113oF/LWzqGogDTiTVbwydaF1tDZiMzqA8sToZTO
         z1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766491539; x=1767096339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUo0nxbK9WUd9ag5FeRCOyqa0TGf8Cy3QKPa2v83ZVI=;
        b=l1L3Q4/SzjX2LgSDR6nX8N62TSonwO7znDPBL585JWiNVZ/MMsWJ//2yUD4Ac6JdU5
         ttZh5fm5ursiQUtolaOSkAU1gas+AxLgr3J0sqRmqSgqfwS8kGIFcokHScxwiIXX9jrN
         puG3O3vXIfCPmkNRoIQPL8/TVP6terOS5ypsaRTWa5ce3PxFfBFs2vsvT3E0hg4JRLsZ
         2hg8XPriV6nO3EwMRbh6NRehhFF2F3gQX0bRvi9aoLUDLP8x0IxbqDzYruXJVgv4ZJgW
         BkETQesyOL1nbs53eSOi9LDXAeHVLTTm8a3Mt57WMKNlZZ2F8aozrvBYqjrX50NnAsga
         0lNA==
X-Forwarded-Encrypted: i=1; AJvYcCXLYXTMWA6hqd229ciRmf3DpwrUrsb2Dc0gcaIseZIOih8Ezj2/pci9pQgi/h7gTwrUv8eDtozWfuIrdMh9@vger.kernel.org
X-Gm-Message-State: AOJu0YyetFoef/hd450kWmnIKDz80lmW0GRiEUnv8Xif54QjvQB4fBgO
	NV79VIWc1U0dEXrbHSwlySNqlpxc9fcOWfinBGM2S/otWa6z/tkitKaXjS4ZTQ==
X-Gm-Gg: AY/fxX4JBC5CZvdgVg6cD/Qw3udoLaxSrJrLU/2oH9X2bWNCWNjiOANWc2+LYvZtr/Y
	1otB1RIvevMw0afZ/6QtZlOwVvlSvHoRU0s6E4eSieoR7wX/aKhS3NZdir6ostF4dqr3XY7UG81
	CrW77G2Tiexas7mXwMX7FUcp4BgwRYCG/cw7NibUtWRSBIsFm7RJmUjlRpxB8AouAY0XW9rrvpd
	BC3TFZ0z19x/cYaM7joQ09KIb7EeGkv+NXp1ussNlbKJzCR8sVr0oflQiOYbKxBRs09akeIuWQ7
	9Ul77PuqCpirVck0QHji62JMD3py6tDhOw8wu6Ct8gv88BcWJElX+hvWDJi2Jh8XTyzYXExGBhN
	M0DqDdnsiYAvRq8mgF9YgunMMhkJsCesdsG6NIsDCGhqIoZUAZTdYk3UQs8H9rFwMBWFEPaV32Z
	RSXzzocfnUV1hJ/9PcRbkEzDwcf3XFy/XgWr2vH8vMt41HvFNL
X-Google-Smtp-Source: AGHT+IFLJeActJn6XnSNbv3Z2CvWbPCRiALI7rP40tY3FFu0qUBeP2jNzvpaubbGyFnIqJvF9ImPqA==
X-Received: by 2002:a17:907:7f07:b0:b6c:38d9:6935 with SMTP id a640c23a62f3a-b8036f6291emr1373112666b.24.1766491538239;
        Tue, 23 Dec 2025 04:05:38 -0800 (PST)
Received: from [127.0.1.1] (178-062-210-188.ip-addr.inexio.net. [188.210.62.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105655asm13720460a12.9.2025.12.23.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:05:37 -0800 (PST)
From: Horst Birthelmer <hbirthelmer@googlemail.com>
X-Google-Original-From: Horst Birthelmer <hbirthelmer@ddn.com>
Date: Tue, 23 Dec 2025 13:05:29 +0100
Subject: [PATCH RFC 1/2] fuse: add compound command to combine multiple
 requests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-fuse-compounds-upstream-v1-1-7bade663947b@ddn.com>
References: <20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com>
In-Reply-To: <20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766491536; l=15926;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=35E48HvcYMg0kou9t2yxpZml62/twDfc2Vh6M7v7nc0=;
 b=rjOiZJoemWucJOf5FKYbGz9uJEJc9drFfWzg4lITgrzdVO8AoLyMdR8Rd5fYM2hxQtpOmNFJd
 VSbN98U346JCDVqCYNCt/AtyK7DabES//BL+XJLMM8gmnloDjJi+3uc
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

For a FUSE_COMPOUND we add a header that contains information
about how many commands there are in the compound and about the
size of the expected result. This will make the interpretation
in libfuse easier, since we can preallocate the whole result.
Then we append the requests that belong to this compound.

The API for the compound command has:
  fuse_compound_alloc()
  fuse_compound_add()
  fuse_compound_request()
  fuse_compound_free()

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 368 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c             |  25 ++++
 fs/fuse/fuse_i.h          |  14 ++
 include/uapi/linux/fuse.h |  37 +++++
 5 files changed, 445 insertions(+), 1 deletion(-)

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
index 000000000000..f86232d55cc7
--- /dev/null
+++ b/fs/fuse/compound.c
@@ -0,0 +1,368 @@
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
+ * Compound request builder and state tracker
+ *
+ * This structure manages the lifecycle of a compound FUSE request, from building
+ * the request by serializing multiple operations into a single buffer, through
+ * sending it to userspace, to parsing the compound response back into individual
+ * operation results.
+ */
+struct fuse_compound_req {
+	struct fuse_mount *fm;
+	struct fuse_compound_in compound_header;
+	struct fuse_compound_out result_header;
+
+	size_t total_size;			/* Total size of serialized operations */
+	char *buffer;				/* Buffer holding serialized requests */
+	size_t buffer_pos;			/* Current write position in buffer */
+	size_t buffer_size;			/* Total allocated buffer size */
+
+	size_t total_expected_out_size;		/* Sum of expected output sizes */
+
+	/* Per-operation error codes */
+	int op_errors[FUSE_MAX_COMPOUND_OPS];
+	/* Original fuse_args for response parsing */
+	struct fuse_args *op_args[FUSE_MAX_COMPOUND_OPS];
+
+	bool parsed;				/* Prevent double-parsing of response */
+};
+
+struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm,
+					       uint32_t flags)
+{
+	struct fuse_compound_req *compound;
+
+	compound = kzalloc(sizeof(*compound), GFP_KERNEL);
+	if (!compound)
+		return ERR_PTR(-ENOMEM);
+
+	compound->fm = fm;
+	compound->compound_header.flags = flags;
+	compound->buffer_size = PAGE_SIZE;
+	compound->buffer = kvmalloc(compound->buffer_size, GFP_KERNEL);
+	if (!compound->buffer) {
+		kfree(compound);
+		return ERR_PTR(-ENOMEM);
+	}
+	return compound;
+}
+
+void fuse_compound_free(struct fuse_compound_req *compound)
+{
+	if (!compound)
+		return;
+
+	kvfree(compound->buffer);
+	kfree(compound);
+}
+
+static int fuse_compound_validate_header(struct fuse_compound_req *compound)
+{
+	struct fuse_compound_in *in_header = &compound->compound_header;
+	size_t offset = 0;
+	int i;
+
+	if (compound->buffer_pos > compound->buffer_size)
+		return -EINVAL;
+
+	if (!compound || !compound->buffer)
+		return -EINVAL;
+
+	if (compound->buffer_pos < sizeof(struct fuse_in_header))
+		return -EINVAL;
+
+	if (in_header->count == 0 || in_header->count > FUSE_MAX_COMPOUND_OPS)
+		return -EINVAL;
+
+	for (i = 0; i < in_header->count; i++) {
+		const struct fuse_in_header *op_hdr;
+
+		if (offset + sizeof(struct fuse_in_header) >
+		    compound->buffer_pos) {
+			pr_info_ratelimited("FUSE: compound operation %d header extends beyond buffer (offset %zu + header size %zu > buffer pos %zu)\n",
+					    i, offset,
+					    sizeof(struct fuse_in_header),
+					    compound->buffer_pos);
+			return -EINVAL;
+		}
+
+		op_hdr = (const struct fuse_in_header *)(compound->buffer +
+							 offset);
+
+		if (op_hdr->len < sizeof(struct fuse_in_header)) {
+			pr_info_ratelimited("FUSE: compound operation %d has invalid length %u (minimum %zu bytes)\n",
+					    i, op_hdr->len,
+					    sizeof(struct fuse_in_header));
+			return -EINVAL;
+		}
+
+		if (offset + op_hdr->len > compound->buffer_pos) {
+			pr_info_ratelimited("FUSE: compound operation %d extends beyond buffer (offset %zu + length %u > buffer pos %zu)\n",
+					    i, offset, op_hdr->len,
+					    compound->buffer_pos);
+			return -EINVAL;
+		}
+
+		if (op_hdr->opcode == 0 || op_hdr->opcode == FUSE_COMPOUND) {
+			pr_info_ratelimited("FUSE: compound operation %d has invalid opcode %u (cannot be 0 or FUSE_COMPOUND)\n",
+					    i, op_hdr->opcode);
+			return -EINVAL;
+		}
+
+		if (op_hdr->nodeid == 0) {
+			pr_info_ratelimited("FUSE: compound operation %d has invalid node ID 0\n",
+					    i);
+			return -EINVAL;
+		}
+
+		offset += op_hdr->len;
+	}
+
+	if (offset != compound->buffer_pos) {
+		pr_info_ratelimited("FUSE: compound buffer size mismatch (calculated %zu bytes, actual %zu bytes)\n",
+				    offset, compound->buffer_pos);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int fuse_compound_add(struct fuse_compound_req *compound,
+		      struct fuse_args *args)
+{
+	struct fuse_in_header *hdr;
+	size_t args_size = 0;
+	size_t needed_size;
+	size_t expected_out_size = 0;
+	int i;
+
+	if (!compound ||
+	    compound->compound_header.count >= FUSE_MAX_COMPOUND_OPS)
+		return -EINVAL;
+
+	if (args->in_pages)
+		return -EINVAL;
+
+	for (i = 0; i < args->in_numargs; i++)
+		args_size += args->in_args[i].size;
+
+	for (i = 0; i < args->out_numargs; i++)
+		expected_out_size += args->out_args[i].size;
+
+	needed_size = sizeof(struct fuse_in_header) + args_size;
+
+	if (compound->buffer_pos + needed_size > compound->buffer_size) {
+		size_t new_size = max(compound->buffer_size * 2,
+				      compound->buffer_pos + needed_size);
+		char *new_buffer;
+
+		new_size = round_up(new_size, PAGE_SIZE);
+		new_buffer = kvrealloc(compound->buffer, new_size,
+				       GFP_KERNEL);
+		if (!new_buffer)
+			return -ENOMEM;
+		compound->buffer = new_buffer;
+		compound->buffer_size = new_size;
+	}
+
+	/* Build request header */
+	hdr = (struct fuse_in_header *)(compound->buffer +
+					compound->buffer_pos);
+	memset(hdr, 0, sizeof(*hdr));
+	hdr->len = needed_size;
+	hdr->opcode = args->opcode;
+	hdr->nodeid = args->nodeid;
+	hdr->uid = from_kuid(compound->fm->fc->user_ns, current_fsuid());
+	hdr->gid = from_kgid(compound->fm->fc->user_ns, current_fsgid());
+	hdr->pid = pid_nr_ns(task_pid(current), compound->fm->fc->pid_ns);
+	hdr->unique = fuse_get_unique(&compound->fm->fc->iq);
+	compound->buffer_pos += sizeof(*hdr);
+
+	for (i = 0; i < args->in_numargs; i++) {
+		memcpy(compound->buffer + compound->buffer_pos,
+		       args->in_args[i].value, args->in_args[i].size);
+		compound->buffer_pos += args->in_args[i].size;
+	}
+
+	compound->total_expected_out_size += expected_out_size;
+
+	/* Store args for response parsing */
+	compound->op_args[compound->compound_header.count] = args;
+
+	compound->compound_header.count++;
+	compound->total_size += needed_size;
+
+	return 0;
+}
+
+static void *fuse_copy_response_data(struct fuse_args *args,
+				     char *response_data)
+{
+	size_t copied = 0;
+	int arg_idx;
+
+	for (arg_idx = 0; arg_idx < args->out_numargs; arg_idx++) {
+		struct fuse_arg current_arg = args->out_args[arg_idx];
+		size_t arg_size;
+
+		/* Last argument with out_pages: copy to pages */
+		if (arg_idx == args->out_numargs - 1 && args->out_pages) {
+			/*
+			 * External payload (in the last out arg)
+			 * is not supported at the moment
+			 */
+			return response_data;
+		}
+
+		arg_size = current_arg.size;
+
+		if (current_arg.value && arg_size > 0) {
+			memcpy(current_arg.value,
+			       (char *)response_data + copied,
+			       arg_size);
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
+				    uint32_t count, void *response,
+				    size_t response_size)
+{
+	void *op_out_data = response;
+	void *response_end = (char *)response + response_size;
+	int i;
+
+	if (compound->parsed)
+		return 0;
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
+	compound->parsed = true;
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
+	size_t expected_response_size;
+	size_t total_buffer_size;
+	size_t actual_response_size;
+	void *resp_payload;
+	ssize_t ret;
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
+	expected_response_size = compound->total_expected_out_size;
+	total_buffer_size = expected_response_size +
+		(compound->compound_header.count *
+		 sizeof(struct fuse_out_header));
+
+	resp_payload = kvmalloc(total_buffer_size, GFP_KERNEL | __GFP_ZERO);
+	if (!resp_payload)
+		return -ENOMEM;
+
+	compound->compound_header.result_size = expected_response_size;
+
+	args.in_args[0].size = sizeof(compound->compound_header);
+	args.in_args[0].value = &compound->compound_header;
+	args.in_args[1].size = compound->buffer_pos;
+	args.in_args[1].value = compound->buffer;
+
+	args.out_args[0].size = sizeof(compound->result_header);
+	args.out_args[0].value = &compound->result_header;
+	args.out_args[1].size = total_buffer_size;
+	args.out_args[1].value = resp_payload;
+
+	ret = fuse_compound_validate_header(compound);
+	if (ret)
+		goto out;
+
+	ret = fuse_compound_request(compound->fm, &args);
+	if (ret)
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
+	return ret;
+}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..2d89ca69308f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -660,6 +660,31 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		__set_bit(FR_ASYNC, &req->flags);
 }
 
+ssize_t fuse_compound_request(
+				struct fuse_mount *fm, struct fuse_args *args)
+{
+	struct fuse_req *req;
+	ssize_t ret;
+
+	req = fuse_get_req(&invalid_mnt_idmap, fm, false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	fuse_args_to_req(req, args);
+
+	if (!args->noreply)
+		__set_bit(FR_ISREPLY, &req->flags);
+
+	__fuse_request_send(req);
+	ret = req->out.h.error;
+	if (!ret && args->out_argvar) {
+		BUG_ON(args->out_numargs == 0);
+		ret = args->out_args[args->out_numargs - 1].size;
+	}
+	fuse_put_request(req);
+	return ret;
+}
+
 ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 			      struct fuse_mount *fm,
 			      struct fuse_args *args)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..86253517f59b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1273,6 +1273,20 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
+/**
+ * Compound request API
+ */
+struct fuse_compound_req;
+ssize_t fuse_compound_request(struct fuse_mount *fm, struct fuse_args *args);
+ssize_t fuse_compound_send(struct fuse_compound_req *compound);
+
+struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, uint32_t flags);
+int fuse_compound_add(struct fuse_compound_req *compound,
+		    struct fuse_args *args);
+int fuse_compound_get_error(struct fuse_compound_req *compound,
+			int op_idx);
+void fuse_compound_free(struct fuse_compound_req *compound);
+
 /**
  * Assign a unique id to a fuse request
  */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..848323acecdc 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -664,6 +664,13 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	/* A compound request works like multiple simple requests.
+	 * This is a special case for calls that can be combined atomic on the
+	 * fuse server. If the server actually does atomically execute the command is
+	 * left to the fuse server implementation.
+	 */
+	FUSE_COMPOUND		= 101,
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


