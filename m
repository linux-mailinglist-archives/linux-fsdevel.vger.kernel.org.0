Return-Path: <linux-fsdevel+bounces-65211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97139BFE265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79AC34EE9A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79A2FB973;
	Wed, 22 Oct 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm1zGVhm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE52FB633
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164601; cv=none; b=hM8ah8n1pXwil5dccpdku3Qigjb3EFbC62vhvOHykvpTZHNdGY7PgdW1IQE19gtnfbaYF/p0bXrr9cTdSSiIMWcd9jlyomhGiHCGtWHZ+Mbw9pp81O97fk1Lbbjn7cH4yKJgQFdoa1/g/vxSR+G1suvNXrhpyHVy+XQ0EK+ObJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164601; c=relaxed/simple;
	bh=ZypwVfsD9JB5v9qFIvX2gVSg0h+5ZBQJi/2UGbalt04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXhnNoQb/2Q/wu/YlolaxlRf6t7QcUtcuEzg8P1Vqe0ejY1/tPbOF5f2zc17gXRwzISrM8NlFemsaOtxbsMBGPoUx5CztnE3iFmeaqjwJr7mkqrHf3izcO1W5XCE+orM7SuKWmnD37yLoxO5aAc5fsGFcGXbJ3PFmBhS5FprUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm1zGVhm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e0798so114546885ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761164591; x=1761769391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAwPv1ZCGWgqJek2QFv9M4nH8K2JjDsKQB2QpCc4m50=;
        b=jm1zGVhmqBhiMNNZDUfFbXQpqEqrOgG7n1sk7qQzlEpGx5s709OwFPGU/Cu+b8g93c
         cAhEvDSARZW/EVSMlCGZbFu0LjETJL8qQ3p06ikWtDsR4UiFlUs1kmAaiHBIAo1VS84m
         TGosvOgeBhQs8jwQnk4aKRgNl1Dot0wCfD6z5UFJlnsYt7DKWA6XjkuUTj3akF9NoOGk
         8Up2gzNgq3rkBLkkLKnZRuM6lDEMG88jpMvfF4U0N736IUqaAYEQX+S4xRp9ab3ru0mG
         bmL0L/eJiIMe/bTLE7r9CyiYv14Mf7Np04K6TMIFjklugXDrC1EWXDoggVQgiHvCaeTF
         Z/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164591; x=1761769391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAwPv1ZCGWgqJek2QFv9M4nH8K2JjDsKQB2QpCc4m50=;
        b=jGGeGkcVzXAX/hG4XDXQfCS5qGDNvABLqcKJt9KHhQwwzk6GqMKcHRJn9inVuvvnuL
         05dioeq8+7U3O6FNlD6Rj2jVOKPsdx9xFepFF2oITH5HQKIu1w7EE9hIY/l5+k70eUP7
         Vmz1IJCSCVF2fmhiTpwgNlJXio56RCqKZyv90pYpfF7eVHVEt/ST/zp5PyYgksjYNWtF
         Z6evqh9G5dicTk4Cp/Baw3SvnCeihC9xRKEwN8s/kFU469PbPVGrw7D30kwajO4RYFN/
         wR7bNlziVRwiuJL8SQ48wCmA/pXYUkJ9sNPL30uS9kYamsTuDKQCfJsE+ADWhv2x9bgo
         QDMw==
X-Gm-Message-State: AOJu0YwBlp7kSxpsZ3RfRZbnJirjVj1ttpzO6N7y4aJAmiOY0o9WnsQl
	USnBtYCxszj95K+6CohT0rYxnstVIcMLrX4FSMj5kyJqWPgU4lXuH5Dq
X-Gm-Gg: ASbGncs2PX5m2n4s0jV71LnV9+K1g9pMatvd5ELZQLZwxYA/p2q3ko2eFwOLuykMpD0
	LOoZg5/0t5ZSkMHRXaqVCoXXIgng4z0leq3OEm2z8G/hUKUCypC7zhvqXDp+QYcVGtZqtqJyFWH
	q+JqpW1vCyEDlBqfTEJV+NGRVYQWHzmf6fNnm5V86uyo1tXfAbqa5apv8UIDniOqT/lTh35+W37
	h4eWTrEVD7xR9rX8kNY8Mh97bFQX5KoNggko6of9dBRZzzV8sSEf2x80fb1qboCNPdCqqCg3PWY
	knTXNlyb5K+oF4Ljt33p6TKA4xu26Fx8tN24/hyDTA/bCZQyJuP3AvQ50oXBovW7BIlQ1oJHLPY
	DAV+q4IVAZYg6A2PiQfpHDW+Of3waLCY5xvrY5asVhCUesecpuiXabkNUIkcI6TorUuCQ7R7/It
	k6vksPnkurtzEf/rag/ApdEItXZQ==
X-Google-Smtp-Source: AGHT+IElT9ynWn45kEF/QTBldN9gne+wXn8PQg4P0IoT5oqSWQd7KwM6rgYjqjp5h3pkYmlZjcPPQg==
X-Received: by 2002:a17:902:c943:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-290c9d1b907mr313186105ad.14.1761164590822;
        Wed, 22 Oct 2025 13:23:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda5771sm66205ad.18.2025.10.22.13.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:23:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	xiaobing.li@samsung.com
Subject: [PATCH v1 2/2] fuse: support io-uring registered buffers
Date: Wed, 22 Oct 2025 13:20:21 -0700
Message-ID: <20251022202021.3649586-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022202021.3649586-1-joannelkoong@gmail.com>
References: <20251022202021.3649586-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for io-uring registered buffers for fuse daemons
communicating through the io-uring interface. Daemons may register
buffers ahead of time, which will eliminate the overhead of
pinning/unpinning user pages and translating virtual addresses for every
server-kernel interaction.

To support page-aligned payloads, the buffer is structured such that the
payload is at the front of the buffer and the fuse_uring_req_header is
offset from the end of the buffer.

To be backwards compatible, fuse uring still needs to support non-registered
buffers as well.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c   | 216 ++++++++++++++++++++++++++++++++++++++----
 fs/fuse/dev_uring_i.h |  17 +++-
 2 files changed, 213 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..c4dd4d168b61 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -574,6 +574,37 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
+static int fuse_uring_copy_from_ring_fixed_buf(struct fuse_ring *ring,
+					       struct fuse_req *req,
+					       struct fuse_ring_ent *ent)
+{
+	struct fuse_copy_state cs;
+	struct fuse_args *args = req->args;
+	struct iov_iter payload_iter;
+	struct iov_iter headers_iter;
+	struct fuse_uring_ent_in_out ring_in_out;
+	size_t copied;
+
+	payload_iter = ent->fixed_buffer.payload_iter;
+	payload_iter.data_source = ITER_SOURCE;
+	headers_iter = ent->fixed_buffer.headers_iter;
+	headers_iter.data_source = ITER_SOURCE;
+
+	iov_iter_advance(&headers_iter, offsetof(struct fuse_uring_req_header,
+						 ring_ent_in_out));
+
+	copied = copy_from_iter(&ring_in_out, sizeof(ring_in_out),
+				&headers_iter);
+	if (copied != sizeof(ring_in_out))
+		return -EFAULT;
+
+	fuse_copy_init(&cs, false, &payload_iter);
+	cs.is_uring = true;
+	cs.req = req;
+
+	return fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -584,12 +615,12 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
+	err = copy_from_user(&ring_in_out, &ent->user.headers->ring_ent_in_out,
 			     sizeof(ring_in_out));
 	if (err)
 		return -EFAULT;
 
-	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
+	err = import_ubuf(ITER_SOURCE, ent->user.payload, ring->max_payload_sz,
 			  &iter);
 	if (err)
 		return err;
@@ -601,6 +632,79 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	return fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
 }
 
+static int fuse_uring_args_to_ring_fixed_buf(struct fuse_ring *ring,
+					     struct fuse_req *req,
+					     struct fuse_ring_ent *ent)
+{
+	struct fuse_copy_state cs;
+	struct fuse_args *args = req->args;
+	struct fuse_in_arg *in_args = args->in_args;
+	int num_args = args->in_numargs;
+	struct iov_iter payload_iter;
+	struct iov_iter headers_iter;
+	struct fuse_uring_ent_in_out ent_in_out = {
+		.flags = 0,
+		.commit_id = req->in.h.unique,
+	};
+	size_t copied;
+	bool advanced_headers = false;
+	int err;
+
+	payload_iter = ent->fixed_buffer.payload_iter;
+	payload_iter.data_source = ITER_DEST;
+
+	headers_iter = ent->fixed_buffer.headers_iter;
+	headers_iter.data_source = ITER_DEST;
+
+	fuse_copy_init(&cs, true, &payload_iter);
+	cs.is_uring = true;
+	cs.req = req;
+
+	if (num_args > 0) {
+		/*
+		 * Expectation is that the first argument is the per op header.
+		 * Some op code have that as zero size.
+		 */
+		if (args->in_args[0].size > 0) {
+			iov_iter_advance(&headers_iter,
+					 offsetof(struct fuse_uring_req_header,
+						  op_in));
+			copied = copy_to_iter(in_args->value, in_args->size,
+					      &headers_iter);
+			if (copied != in_args->size) {
+				pr_info_ratelimited(
+					"Copying the header failed.\n");
+				return -EFAULT;
+			}
+
+			iov_iter_advance(&headers_iter,
+					 FUSE_URING_OP_IN_OUT_SZ - in_args->size);
+			advanced_headers = true;
+		}
+		in_args++;
+		num_args--;
+	}
+	if (!advanced_headers)
+		iov_iter_advance(&headers_iter,
+				 offsetof(struct fuse_uring_req_header,
+					  ring_ent_in_out));
+
+	/* copy the payload */
+	err = fuse_copy_args(&cs, num_args, args->in_pages,
+			     (struct fuse_arg *)in_args, 0);
+	if (err) {
+		pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
+		return err;
+	}
+
+	ent_in_out.payload_sz = cs.ring.copied_sz;
+	copied = copy_to_iter(&ent_in_out, sizeof(ent_in_out), &headers_iter);
+	if (copied != sizeof(ent_in_out))
+		return -EFAULT;
+
+	return 0;
+}
+
  /*
   * Copy data from the req to the ring buffer
   */
@@ -618,7 +722,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
-	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
+	err = import_ubuf(ITER_DEST, ent->user.payload, ring->max_payload_sz, &iter);
 	if (err) {
 		pr_info_ratelimited("fuse: Import of user buffer failed\n");
 		return err;
@@ -634,7 +738,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_to_user(&ent->headers->op_in, in_args->value,
+			err = copy_to_user(&ent->user.headers->op_in, in_args->value,
 					   in_args->size);
 			if (err) {
 				pr_info_ratelimited(
@@ -655,7 +759,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
+	err = copy_to_user(&ent->user.headers->ring_ent_in_out, &ent_in_out,
 			   sizeof(ent_in_out));
 	return err ? -EFAULT : 0;
 }
@@ -679,18 +783,31 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 		return err;
 
 	/* copy the request */
-	err = fuse_uring_args_to_ring(ring, req, ent);
+	if (ent->is_fixed_buffer)
+		err = fuse_uring_args_to_ring_fixed_buf(ring, req, ent);
+	else
+		err = fuse_uring_args_to_ring(ring, req, ent);
 	if (unlikely(err)) {
 		pr_info_ratelimited("Copy to ring failed: %d\n", err);
 		return err;
 	}
 
 	/* copy fuse_in_header */
-	err = copy_to_user(&ent->headers->in_out, &req->in.h,
-			   sizeof(req->in.h));
-	if (err) {
-		err = -EFAULT;
-		return err;
+	if (ent->is_fixed_buffer) {
+		struct iov_iter headers_iter = ent->fixed_buffer.headers_iter;
+		size_t copied;
+
+		headers_iter.data_source = ITER_DEST;
+		copied = copy_to_iter(&req->in.h, sizeof(req->in.h),
+				      &headers_iter);
+
+		if (copied != sizeof(req->in.h))
+			return -EFAULT;
+	} else {
+		err = copy_to_user(&ent->user.headers->in_out, &req->in.h,
+				   sizeof(req->in.h));
+		if (err)
+			return -EFAULT;
 	}
 
 	return 0;
@@ -815,8 +932,18 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
+	if (ent->is_fixed_buffer) {
+		struct iov_iter headers_iter = ent->fixed_buffer.headers_iter;
+		size_t copied;
+
+		headers_iter.data_source = ITER_SOURCE;
+		copied = copy_from_iter(&req->out.h, sizeof(req->out.h), &headers_iter);
+		if (copied != sizeof(req->out.h))
+			err = -EFAULT;
+	} else {
+		err = copy_from_user(&req->out.h, &ent->user.headers->in_out,
+				     sizeof(req->out.h));
+	}
 	if (err) {
 		req->out.h.error = -EFAULT;
 		goto out;
@@ -828,7 +955,11 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 		goto out;
 	}
 
-	err = fuse_uring_copy_from_ring(ring, req, ent);
+	if (ent->is_fixed_buffer)
+		err = fuse_uring_copy_from_ring_fixed_buf(ring, req, ent);
+	else
+		err = fuse_uring_copy_from_ring(ring, req, ent);
+
 out:
 	fuse_uring_req_end(ent, req, err);
 }
@@ -1027,6 +1158,52 @@ static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
 	return 0;
 }
 
+static struct fuse_ring_ent *
+fuse_uring_create_ring_ent_fixed_buf(struct io_uring_cmd *cmd,
+				     struct fuse_ring_queue *queue)
+{
+	struct fuse_ring *ring = queue->ring;
+	struct fuse_ring_ent *ent;
+	unsigned payload_size, len;
+	u64 ubuf;
+	int err;
+
+	err = -ENOMEM;
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL_ACCOUNT);
+	if (!ent)
+		return ERR_PTR(err);
+
+	INIT_LIST_HEAD(&ent->list);
+
+	ent->queue = queue;
+	ent->is_fixed_buffer = true;
+
+	err = io_uring_cmd_get_buffer_info(cmd, &ubuf, &len);
+	if (err)
+		goto error;
+
+	payload_size = len - sizeof(struct fuse_uring_req_header);
+	err = io_uring_cmd_import_fixed(ubuf, payload_size, ITER_DEST,
+					&ent->fixed_buffer.payload_iter, cmd, 0);
+	if (err)
+		goto error;
+
+	err = io_uring_cmd_import_fixed(ubuf + payload_size,
+					sizeof(struct fuse_uring_req_header),
+					ITER_DEST,
+					&ent->fixed_buffer.headers_iter, cmd, 0);
+	if (err)
+		goto error;
+
+	atomic_inc(&ring->queue_refs);
+
+	return ent;
+
+error:
+	kfree(ent);
+	return ERR_PTR(err);
+}
+
 static struct fuse_ring_ent *
 fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 			   struct fuse_ring_queue *queue)
@@ -1065,8 +1242,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	INIT_LIST_HEAD(&ent->list);
 
 	ent->queue = queue;
-	ent->headers = iov[0].iov_base;
-	ent->payload = iov[1].iov_base;
+	ent->user.headers = iov[0].iov_base;
+	ent->user.payload = iov[1].iov_base;
 
 	atomic_inc(&ring->queue_refs);
 	return ent;
@@ -1085,6 +1262,8 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	struct fuse_ring_ent *ent;
 	int err;
 	unsigned int qid = READ_ONCE(cmd_req->qid);
+	bool is_fixed_buffer =
+		cmd->sqe->uring_cmd_flags & IORING_URING_CMD_FIXED;
 
 	err = -ENOMEM;
 	if (!ring) {
@@ -1110,7 +1289,10 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	 * case of entry errors below, will be done at ring destruction time.
 	 */
 
-	ent = fuse_uring_create_ring_ent(cmd, queue);
+	if (is_fixed_buffer)
+		ent = fuse_uring_create_ring_ent_fixed_buf(cmd, queue);
+	else
+		ent = fuse_uring_create_ring_ent(cmd, queue);
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce1..748c87e325f5 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -38,9 +38,20 @@ enum fuse_ring_req_state {
 
 /** A fuse ring entry, part of the ring queue */
 struct fuse_ring_ent {
-	/* userspace buffer */
-	struct fuse_uring_req_header __user *headers;
-	void __user *payload;
+	/* True if daemon has registered its buffers ahead of time */
+	bool is_fixed_buffer;
+	union {
+		/* userspace buffer */
+		struct {
+			struct fuse_uring_req_header __user *headers;
+			void __user *payload;
+		} user;
+
+		struct {
+			struct iov_iter payload_iter;
+			struct iov_iter headers_iter;
+		} fixed_buffer;
+	};
 
 	/* the ring queue that owns the request */
 	struct fuse_ring_queue *queue;
-- 
2.47.3


