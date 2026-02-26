Return-Path: <linux-fsdevel+bounces-78600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLZ2Mx5+oGlgkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:08:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C21ABC78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF0613457B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1C3603F1;
	Thu, 26 Feb 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="dNdryYmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF53603CC;
	Thu, 26 Feb 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124246; cv=none; b=AcPTiWj0n/ypZD+WuA5fQQhvD6Mh668hljFHnQ0orOAGvHjZ0gS83Q1cQTP6ch2u7SYGMAeldB7TZ7Y5j2C4JdjlTAVLj3xPzsDv0hihmo2wu/Q53Jf7cKJFWYAWibY/6tRRyxhyuew5fRRNU2spr3zScbZ0NIDXl293ZOy7X9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124246; c=relaxed/simple;
	bh=EjAzSgzjObUM5dhOlxitVf8/fAu+sdE0ybuv8LpQfm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqf+tYugqJ1xg7H/CFNEFKrXAQol5GxZApLaiqZG1hCc2rfnUYGpVftPOmEnqRsAU/xDnP792lxRyoKPkoR6hpfnxk0ozuQ7WqXoHPggPGCL9fnOVPqlR22pbsfz0pTXQb6F6BR+Ahqxyr8lOnf8GusCnGInMbodhAdRRxd5AQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=dNdryYmp; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 28FD8E0354;
	Thu, 26 Feb 2026 17:43:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1772124237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUEBsyMed4N11PbJMO0GR1OSz5oxIcmpiXGAsRr+jQI=;
	b=dNdryYmpF799ZJC+I1Wa7W1FMBlSkAkjuyn5PVhaDkzcl6iCvBcXIvIeIf1PvMsv5NId6y
	ec1/x/Bn46e6aqUYZcjHIiMaeuXmCHav38nvXq+K+dIoqkqx8W6S/E715fv0dyE6pEytb2
	gNj6KkHpIwvpcQZ0RZE0c518XX2rY8h0lBhfuwvj0J9P85Q1mXQKho10kP3R/oqbxsRPTe
	a7R/ncsF4n6b82gKz/p8YUZMnUD3o1/E8ktgtKYQ5B/rXO/rwqGMNgDsV5VG8eL50yPpXO
	D15R607dHBwMqOrQd7PvFQn1U9M61DSBU0o5prmhKjjKkad9QhbOFLL2zm9rAg==
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Thu, 26 Feb 2026 17:43:53 +0100
Subject: [PATCH v6 1/3] fuse: add compound command to combine multiple
 requests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
In-Reply-To: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772124235; l=13452;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=zB9dxl9WuMwc9QRTsSIuZYa0kBA+Bipx0HoYFgbETZc=;
 b=RgsgynSd4s4SFAIfwl12bTondWfPKABtUjJptOiUSr1RkBU11zyZU8Mi/HhyHMc+hh9RkfJFG
 0I+E6o3LPtPCwJ2Ve8WZOo9RTTpNMLhasnj79U1eLNwRcOq8SICbVBo
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[birthelmer.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[birthelmer.com:s=uddkim-202310];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78600-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,ddn.com,gmail.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birthelmer.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ddn.com:mid,ddn.com:email]
X-Rspamd-Queue-Id: D39C21ABC78
X-Rspamd-Action: no action

From: Horst Birthelmer <hbirthelmer@ddn.com>

For a FUSE_COMPOUND we add a small header that informs the
fuse server how much buffer memory the kernel has for the result.
This will make the interpretation in libfuse easier,
since we can preallocate the whole result and work on the return
buffer.
Then we append the requests that belong to this compound.

The API for the compound command has:
  fuse_compound_alloc()
  fuse_compound_add()
  fuse_compound_send()
  fuse_compound_free()

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 308 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  39 ++++++
 include/uapi/linux/fuse.h |  52 ++++++++
 4 files changed, 400 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 22ad9538dfc4b80c6d9b52235bdfead6a6567ae4..4c09038ef995d1b9133c2b6871b97b280a4693b0 100644
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
index 0000000000000000000000000000000000000000..68f30123f39b244dd82b835717077cc271518e14
--- /dev/null
+++ b/fs/fuse/compound.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2025-2026
+ *
+ * Compound operations for FUSE - batch multiple operations into a single
+ * request to reduce round trips between kernel and userspace.
+ */
+
+#include "fuse_i.h"
+
+struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm,
+					       u32 max_count, u32 flags)
+{
+	struct fuse_compound_req *compound;
+
+	if (max_count == 0)
+		return NULL;
+
+	compound = kzalloc(sizeof(*compound), GFP_KERNEL);
+	if (!compound)
+		return NULL;
+
+	compound->max_count = max_count;
+	compound->count = 0;
+	compound->fm = fm;
+	compound->compound_header.flags = flags;
+
+	compound->op_errors = kcalloc(max_count, sizeof(int), GFP_KERNEL);
+	if (!compound->op_errors)
+		goto out_free_compound;
+
+	compound->op_args = kcalloc(max_count, sizeof(struct fuse_args *),
+				    GFP_KERNEL);
+	if (!compound->op_args)
+		goto out_free_op_errors;
+
+	compound->op_converters = kcalloc(max_count,
+					  sizeof(int (*)(struct fuse_compound_req *, unsigned int)),
+					  GFP_KERNEL);
+	if (!compound->op_converters)
+		goto out_free_op_args;
+
+	return compound;
+
+out_free_op_args:
+	kfree(compound->op_args);
+out_free_op_errors:
+	kfree(compound->op_errors);
+out_free_compound:
+	kfree(compound);
+	return NULL;
+}
+
+void fuse_compound_free(struct fuse_compound_req *compound)
+{
+	kfree(compound->op_errors);
+	kfree(compound->op_args);
+	kfree(compound->op_converters);
+	kfree(compound);
+}
+
+int fuse_compound_add(struct fuse_compound_req *compound,
+			struct fuse_args *args,
+			int (*converter)(struct fuse_compound_req *compound,
+			unsigned int index))
+{
+	if (!compound || compound->count >= compound->max_count)
+		return -EINVAL;
+
+	if (args->in_pages)
+		return -EINVAL;
+
+	compound->op_args[compound->count] = args;
+	compound->op_converters[compound->count] = converter;
+	compound->count++;
+	return 0;
+}
+
+static void fuse_copy_resp_data_per_req(const struct fuse_args *args,
+				char *resp)
+{
+	const struct fuse_arg *arg;
+	int i;
+
+	for (i = 0; i < args->out_numargs; i++) {
+		arg = &args->out_args[i];
+		memcpy(arg->value, resp, arg->size);
+		resp += arg->size;
+	}
+}
+
+static char *fuse_compound_parse_one_op(struct fuse_compound_req *compound,
+					char *response,
+					char *response_end,
+					int op_count)
+{
+	struct fuse_out_header *op_hdr = (struct fuse_out_header *)response;
+	struct fuse_args *args;
+
+	if (op_hdr->len < sizeof(struct fuse_out_header))
+		return NULL;
+
+	if (response + op_hdr->len > response_end)
+		return NULL;
+
+	if (op_count >= compound->max_count)
+		return NULL;
+
+	if (op_hdr->error) {
+		compound->op_errors[op_count] = op_hdr->error;
+	} else {
+		args = compound->op_args[op_count];
+		fuse_copy_resp_data_per_req(args, response +
+					    sizeof(struct fuse_out_header));
+	}
+
+	/* In case of error, we still need to advance to the next op */
+	return response + op_hdr->len;
+}
+
+static int fuse_compound_parse_resp(struct fuse_compound_req *compound,
+				    char *response, char *response_end)
+{
+	int op_count = 0;
+
+	while (response < response_end) {
+		response = fuse_compound_parse_one_op(compound, response,
+						      response_end, op_count);
+		if (!response)
+			return -EIO;
+		op_count++;
+	}
+
+	return 0;
+}
+
+static int fuse_handle_compound_results(struct fuse_compound_req *compound,
+					struct fuse_args *args)
+{
+	size_t actual_response_size;
+	size_t buffer_size;
+	char *resp_payload_buffer;
+	int ret;
+
+	buffer_size = compound->compound_header.result_size +
+		      compound->count * sizeof(struct fuse_out_header);
+
+	resp_payload_buffer = args->out_args[1].value;
+	actual_response_size = args->out_args[1].size;
+
+	if (actual_response_size <= buffer_size) {
+		ret = fuse_compound_parse_resp(compound,
+					       (char *)resp_payload_buffer,
+					       resp_payload_buffer +
+					       actual_response_size);
+	} else {
+		/* FUSE server sent more data than expected */
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/*
+ * Build a single operation request in the buffer
+ *
+ * Returns the new buffer position after writing the operation.
+ */
+static char *fuse_compound_build_one_op(struct fuse_conn *fc,
+					struct fuse_args *op_args,
+					char *buffer_pos,
+					unsigned int index)
+{
+	struct fuse_in_header *hdr;
+	size_t needed_size = sizeof(struct fuse_in_header);
+	int j;
+
+	for (j = 0; j < op_args->in_numargs; j++)
+		needed_size += op_args->in_args[j].size;
+
+	hdr = (struct fuse_in_header *)buffer_pos;
+	hdr->unique = index;
+	hdr->len = needed_size;
+	hdr->opcode = op_args->opcode;
+	hdr->nodeid = op_args->nodeid;
+	buffer_pos += sizeof(*hdr);
+
+	for (j = 0; j < op_args->in_numargs; j++) {
+		memcpy(buffer_pos, op_args->in_args[j].value,
+		       op_args->in_args[j].size);
+		buffer_pos += op_args->in_args[j].size;
+	}
+
+	return buffer_pos;
+}
+
+static ssize_t fuse_compound_fallback_separate(struct fuse_compound_req *compound)
+{
+	unsigned int req_count = compound->count;
+	ssize_t ret = 0;
+	unsigned int i;
+
+	/* Try separate requests */
+	for (i = 0; i < req_count; i++) {
+		/* fill the current args from the already received responses */
+		if (compound->op_converters[i])
+			ret = compound->op_converters[i](compound, i);
+
+		ret = fuse_simple_request(compound->fm, compound->op_args[i]);
+		if (ret < 0) {
+			compound->op_errors[i] = ret;
+			if (!(compound->compound_header.flags & FUSE_COMPOUND_CONTINUE))
+				break;
+		}
+	}
+
+	return ret;
+}
+
+ssize_t fuse_compound_send(struct fuse_compound_req *compound)
+{
+	struct fuse_conn *fc = compound->fm->fc;
+	struct fuse_args args = {
+		.opcode = FUSE_COMPOUND,
+		.in_numargs = 2,
+		.out_numargs = 2,
+		.out_argvar = true,
+	};
+	unsigned int req_count = compound->count;
+	size_t total_expected_out_size = 0;
+	size_t buffer_size = 0;
+	void *resp_payload_buffer;
+	char *buffer_pos;
+	void *buffer = NULL;
+	ssize_t ret;
+	unsigned int i, j;
+
+	for (i = 0; i < req_count; i++) {
+		struct fuse_args *op_args = compound->op_args[i];
+		size_t needed_size = sizeof(struct fuse_in_header);
+
+		for (j = 0; j < op_args->in_numargs; j++)
+			needed_size += op_args->in_args[j].size;
+
+		buffer_size += needed_size;
+
+		for (j = 0; j < op_args->out_numargs; j++)
+			total_expected_out_size += op_args->out_args[j].size;
+	}
+
+	buffer = kzalloc(buffer_size, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	buffer_pos = buffer;
+	for (i = 0; i < req_count; i++) {
+		if (compound->op_converters[i]) {
+			ret = compound->op_converters[i](compound, i);
+			if (ret < 0)
+				goto out_free_buffer;
+		}
+
+		buffer_pos = fuse_compound_build_one_op(fc,
+							compound->op_args[i],
+							buffer_pos, i);
+	}
+
+	compound->compound_header.result_size = total_expected_out_size;
+
+	args.in_args[0].size = sizeof(compound->compound_header);
+	args.in_args[0].value = &compound->compound_header;
+	args.in_args[1].size = buffer_size;
+	args.in_args[1].value = buffer;
+
+	buffer_size = total_expected_out_size +
+		      req_count * sizeof(struct fuse_out_header);
+
+	resp_payload_buffer = kzalloc(buffer_size, GFP_KERNEL);
+	if (!resp_payload_buffer) {
+		ret = -ENOMEM;
+		goto out_free_buffer;
+	}
+
+	args.out_args[0].size = sizeof(compound->result_header);
+	args.out_args[0].value = &compound->result_header;
+	args.out_args[1].size = buffer_size;
+	args.out_args[1].value = resp_payload_buffer;
+
+	ret = fuse_simple_request(compound->fm, &args);
+	if (ret < 0)
+		goto fallback_separate;
+
+	ret = fuse_handle_compound_results(compound, &args);
+	if (ret == 0)
+		goto out;
+
+fallback_separate:
+	/* Kernel tries to fallback to separate requests */
+	if (!(compound->compound_header.flags & FUSE_COMPOUND_ATOMIC))
+		ret = fuse_compound_fallback_separate(compound);
+
+out:
+	kfree(resp_payload_buffer);
+out_free_buffer:
+	kfree(buffer);
+	return ret;
+}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d15e869db4be23a93605098588eda9..e46315aa428c9d0e704c62a0b80811172c5ec9c1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1273,6 +1273,45 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
+/*
+ * Compound request builder, state tracker, and args pointer storage
+ */
+struct fuse_compound_req {
+	struct fuse_mount *fm;
+	struct fuse_compound_in compound_header;
+	struct fuse_compound_out result_header;
+
+	struct fuse_args **op_args;
+
+	/*
+	 * Every op can add a converter function to construct the ops args from
+	 * the already received responses.
+	 */
+	int (**op_converters)(struct fuse_compound_req *compound,
+			      unsigned int index);
+	int *op_errors;
+
+	unsigned int max_count;
+	unsigned int count;
+};
+
+/*
+ * Compound request API
+ */
+ssize_t fuse_compound_send(struct fuse_compound_req *compound);
+
+struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm,
+					       u32 max_count, u32 flags);
+int fuse_compound_add(struct fuse_compound_req *compound,
+		      struct fuse_args *args,
+		      int (*converter)(struct fuse_compound_req *compound,
+				       unsigned int index));
+void fuse_compound_free(struct fuse_compound_req *compound);
+static inline int fuse_compound_get_error(struct fuse_compound_req *compound, int op_idx)
+{
+	return compound->op_errors[op_idx];
+}
+
 /**
  * Assign a unique id to a fuse request
  */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12bd39f535188cb5466688eba42263..d43bffd1ccbe2b3d144864407d60ff7a48db53ed 100644
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
 
@@ -1245,6 +1252,51 @@ struct fuse_supp_groups {
 	uint32_t	groups[];
 };
 
+/*
+ * This is a hint to the fuse server that all requests are complete and it can
+ * use automatic decoding and sequential processing from libfuse.
+ */
+#define FUSE_COMPOUND_SEPARABLE (1 << 0)
+/*
+ * This will be used by the kernel to continue on
+ * even after one of the requests fail.
+ */
+#define FUSE_COMPOUND_CONTINUE (1 << 1)
+/*
+ * This flags the compound as atomic, which
+ * means that the operation has to be interpreted
+ * atomically and be directly supported by the fuse server
+ * itself.
+ */
+#define FUSE_COMPOUND_ATOMIC (1 << 2)
+
+/*
+ * Compound request header
+ *
+ * This header is followed by the fuse requests
+ */
+struct fuse_compound_in {
+	uint32_t	flags;			/* Compound flags */
+
+	/* Total size of all results expected from the fuse server.
+	 * This is needed for preallocating the whole result for all
+	 * commands in the fuse server.
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
+	uint32_t	flags;     /* Result flags */
+	uint32_t	padding;
+	uint64_t	reserved;
+};
+
 /**
  * Size of the ring buffer header
  */

-- 
2.53.0


