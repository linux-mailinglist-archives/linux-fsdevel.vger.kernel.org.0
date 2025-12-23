Return-Path: <linux-fsdevel+bounces-71994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA6CDABCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B0C630253F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 22:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84A328618;
	Tue, 23 Dec 2025 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CNELntsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634E313277
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766527999; cv=none; b=tgnTcPYqWOReIhXKLeVjenT/z9h4awUmV++HBqTjcJ7Ytx+n1WX31+DMHnt9w8gQgrQHf/qHLxXmeYXUmTIVCqPGFJaKqQ9YMW5Ic/bpC2ss3zp2xMUvlwztYJXqLPZyJPfzVBXplZjyzi4U6zfH6jld2WkoCPFaHEu+fagSrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766527999; c=relaxed/simple;
	bh=o/+ehmQbcKfzl5w5xn3RAWyTaKfhvi6TjoeXVlqMOn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYVAkf80OWHAK46mlwn2803LbKjysiNc6FCcTgrFAKlVfU51VEN5aQwc2P9NfFr0HrLxau6haKTy/Q6qYGQBDdFZHP/FU+wfTwQEePAB4sZoFljCf3Pz9ufKOqQDQ8kWmiz+xDZA9qb8B4gIZ8WT3xw9tm5aJbq3REfQ9gsDmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CNELntsl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324204so853135266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766527995; x=1767132795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gMQSlXzFMG4X83jevYdPozpDz+7s8+oGhmUUEmbvrE=;
        b=CNELntslOSdxcQyp58N68AWSIZnpMAm0/76GwTkrf594ecEpv2xA7TinBn+gqWx7Yj
         3ZeowyKbDcogRikYQPMqNYLXugxXbm0M6SoCFGVUNxtw64z5jfp+/HZX2Yt5FXyix3gt
         x6xGkMwvEMRnPnd0D986xts7d7f3D7GHfTrb110y8Xx1RPozPX91ftwK7HeL6qKzeEgR
         yAwDADtfZUvkYvGDcxPf5cQKONcqqDVM3F2Cz5eIiiW8FZYL7M/Hdgeu272aDufNhxcf
         RcdJqEAGkJFLf43Swvj+UcH0mmxUySqscpTg6k9+zBiuwD/jV/5U+fvwRjuIzWsNc5nU
         AKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766527995; x=1767132795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9gMQSlXzFMG4X83jevYdPozpDz+7s8+oGhmUUEmbvrE=;
        b=ihxmr3qPNR6/JTC0Gutzvn3UU/lYhR7qKeKBhuqBNw9hqtxXkt/qALGzgO3UbQcN8V
         WuLIUs+kn0eC6KQWaM9uCJj2XRMBAhyO6Ut5XdS5Dv5YEaDhad7MERGjMVpsZkbYWdnw
         buctEpKqS+nmk4iQXcV+D3vxea3DyL94zH/9dUhU9cDuaJGT1MxPll8bBEbAqgv7+GqD
         68CL3DYK6WEZzf+TMzvEyXgjT6xJ9yRlrrUVJy4PQIgpMmvSJ5ZzFZjEx3nkBO9Nkdc8
         /VeJPPoyBx+sCg8Jott/tWV63NaT4IPyjFuZW0l9tYZTpjCM2fokrs07frPuX3TxYbfZ
         08QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVBbddthuI3KbOmFCH/WE1sj9Dr1w02y/ynaCDtSBFoDrJfvLfbEY+ZZ23zI0oXfKOnqLdSaqJTj60fu9f@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhLlrg2BxaLLWY9wKTqjSCTD2bCGi/47DfY15TJPcHyIY5taB
	yhMjVUQ86SJBjXQEDQy8kf8qpjWVKULmN4vQVDaqj2+tF5wwz0KuPwpqd5+bOP7t
X-Gm-Gg: AY/fxX4Mq44tQy0jg7Ob1xqNoXj+Mjm0M/Q/pcIKn0SONVadgtywwxVHOTp5JxxYM0+
	CPfyjhMU9wEFCO1Q3ueMV35SicPgaTRBBUsJxrBfbME8qQA9zZ5L0giW5X9YV70eYXOQAHjdcoA
	lJP9om6O59RTIjQr25gsc53UjHXoAWkM/6Ct6gr2mz/+AoEP/Xn3N1CjM6rRwNrsJ9ptw3T+EXr
	AmzQpeAjgigTAlE/krq/pO8THt9kwormzgvVhg0dOX6V/oWAQPA8rpgFCWL6Kus24YD3FvEE8zC
	P2hFPKqOjkFIDmP0AROCZY8EEbYhP8tiVvcO0LddeH5DpI5IXY+bDlfBIAFA8DOWVBJmrDYPRTq
	Pfta4rk16U7WEPCuf6UL9IBRNNwjK17FoSQ9zdttJWBNvGACKc1vlZ9A4vGMj9miIrGmnSbCfKI
	MGLghi1iy1PNHaqeFgjaudBKRhO9Wag/yYPsQh0mZvWalyZDJu
X-Google-Smtp-Source: AGHT+IH2e0Zu9D0+qgjsxx40lui1cSEyE6Uc6SF04Ix84vIR3KiNoTirLF/SQHPY9JEVzF0V12wWwQ==
X-Received: by 2002:a17:907:75fa:b0:b80:3fff:5fe6 with SMTP id a640c23a62f3a-b803fff60f3mr855701366b.9.1766527994730;
        Tue, 23 Dec 2025 14:13:14 -0800 (PST)
Received: from [127.0.1.1] (178-062-210-188.ip-addr.inexio.net. [188.210.62.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c70sm14903373a12.6.2025.12.23.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 14:13:14 -0800 (PST)
From: Horst Birthelmer <hbirthelmer@googlemail.com>
X-Google-Original-From: Horst Birthelmer <hbirthelmer@ddn.com>
Date: Tue, 23 Dec 2025 23:13:05 +0100
Subject: [PATCH RFC v2 1/2] fuse: add compound command to combine multiple
 requests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-fuse-compounds-upstream-v2-1-0f7b4451c85e@ddn.com>
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
In-Reply-To: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>, syzbot@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766527992; l=15975;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=o/+ehmQbcKfzl5w5xn3RAWyTaKfhvi6TjoeXVlqMOn4=;
 b=A+JwvNxqiGFGwpxrXGtdnB5I8jdu/q43IKqmVSRHmflSEIPuy3yTCzFM3C4Iaswb/Uqf/mv8z
 Rp6r9LHqvZHCvVmiLM0fUbk2Udo34kj8/cmA0x/OfHYCJeQg45AK69n
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
Tested-by: syzbot@syzkaller.appspotmail.com
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
index 000000000000..b15014d61b38
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


