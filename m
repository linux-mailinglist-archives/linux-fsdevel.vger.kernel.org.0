Return-Path: <linux-fsdevel+bounces-74268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C92D38A36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E856E30AEE03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7932572A;
	Fri, 16 Jan 2026 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPxeGJBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE71FE44A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606301; cv=none; b=KvvjDEdQkryatu/rdjfJd0RXk6mkwUeYaCQzFoXOlyXdibAzIfciwW/KJorqBcHanjgmk4cVk06q60dPsSsMe2D7KTAPYbVThH+N5ATUXQ42t9VeSx0opImw99697c2CBSSovgFxQ5ESdCZyLo5RRdgHbhHaP6kEnUxuj6ADb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606301; c=relaxed/simple;
	bh=1OEe8SS8ChGxMocB2ZHmK0f7p5RnUJHUh82sMeFtZlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPZh3nkBGqiLKcMCQEnn0DiV9tsp2B/IrAN81SpNEusEx82pLRmumihiT0H7WVj+mgeI03+knXvThsF5N0ZxaWVcNxHtIyofSEVdDYAXGoNIX8BCo1bVerrgKjs8U9CWK7F+4PpuDds/uMyLli3YyFy+hP8GahNa/F28py2Z0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPxeGJBr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso1507851a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606299; x=1769211099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMjth6f+ts5zzz144D+vOhGaR/9FcuDJci6MRh6U3wI=;
        b=CPxeGJBrvgNghUvnTD2jdZthrNWHw0+L+vigYpF3Vce64rYqLIKAkO0YazeJ/r+Zc+
         iicwh5sSd48S9ClW0FRD+5pGL9Bup+EaS0MrxuS1qzlqKctRkkycqf013LjmBBx6DyDY
         /34Xnqv3UUtQD7nan1mAkdKwLhgq7bQZ6RQ5UBcTOLXhP+1f4ytUoW7tSmH4UzAubv6F
         LhlYqy+/Yr8NLmC9rHYdFE5NY6qgcn0lu9O6BlJksuzniklHth8Ii6f2aQr26Nc2D1Fk
         zu5SG0HTNpIjL/SkARTIASDvPQs5L914+hclgLTpZM5UemicfmxMNsjnrRE5aor+Mh7L
         VwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606299; x=1769211099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMjth6f+ts5zzz144D+vOhGaR/9FcuDJci6MRh6U3wI=;
        b=tCg19aW4GP/okDw3pKqOdOaeeVR++yUz1sMA4mBqZwKjpCsSX737jtvlsR2uBO3VgQ
         bqU4qeIVC6qWW8UKrnL0szQUrPhVeDK/pCTx00eFr7LJNXf5oObt4m6kCPyP2Fpx6/TO
         jAgyzuDh25I5iqHUv4AF/b9oM7ezn7SWWDEycyzBo7+JWaIblUuqzN1QDndKle5mZr1Z
         H8OwZUaRUMI6nboa8cQm2RbcA/XW/j0Jcqh3SwMbZd5kr7QYGLgfks1LhwglYzKdBxDJ
         jzolrh7DUMG6ZeVZy9Lxm7Romdv/Ou7VvduzJcozY8OHpr/qLMLx98bhYVNNStfc6KI0
         n15g==
X-Forwarded-Encrypted: i=1; AJvYcCX59JxhXT3CGXj9IvB0UoKdeTKEiDKQvYEMnttXJV0QRCcwMIMtJ/ZM0/Bj1f3Ps+uhp2JCtMFUiK/ePz2C@vger.kernel.org
X-Gm-Message-State: AOJu0YyeunnIsXdR+k5R1ANOPEZlfdvRAys4qDWrTTSoIeegE7wdv7Ko
	4pHjufymKMqR9l5k88GYrxZ78L291iIx/hM5O0V4ee9TNbIQMAS5hfuy
X-Gm-Gg: AY/fxX49PjvtgJlkaTcnn1TawU5psdkAnpmCyjRsK3y++TrfUfS/iq69g4gshYB2TbH
	5On9FPOtZX/v+9oOJY0AFWXvwip4s8vY1NqhL8WnUVVwDDKHZv/g9j1nCzNO3UHk4+wrGuB3XqS
	ytTl14IYsYFM36UKq4vN6qZ4RVZo30Fv8rhWqeBSkOXljRYMd/UBEijh1786c7c0zsW1Q1vwnNG
	T0d1c/mZkbXf9R2iiW2+K6f6k5aLM7GAr6j1Kvg/qJNi7k9rrZS8/JrB3qOAO7taybq4+hZWclZ
	4K47oI8Eh6w4IfhuxJq2EPGsQnZ3JGrUN+dGtYHdGvDfYOrrpXrQiJwzkPei2rmICto1elN2h1t
	mJTpYcD/UTila2s0AoaLQaUZQaHYaOUKCJKSpnpsyokEh62bnu2J2ceMIZqjgMQiOcvtlR8fPD4
	FSo+LhQ5JIb/ty7tH6
X-Received: by 2002:a17:90a:ec86:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-35272bf3522mr3628606a91.6.1768606299396;
        Fri, 16 Jan 2026 15:31:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ca9acsm5490734a91.1.2026.01.16.15.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:39 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 20/25] io_uring/rsrc: rename io_buffer_register_bvec()/io_buffer_unregister_bvec()
Date: Fri, 16 Jan 2026 15:30:39 -0800
Message-ID: <20260116233044.1532965-21-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, io_buffer_register_bvec() takes in a request. In preparation
for supporting kernel-populated buffers in fuse io-uring (which will
need to register bvecs directly, not through a struct request), rename
this to io_buffer_register_request().

A subsequent patch will commandeer the "io_buffer_register_bvec()"
function name to support registering bvecs directly.

Rename io_buffer_unregister_bvec() to a more generic name,
io_buffer_unregister(), as both io_buffer_register_request() and
io_buffer_register_bvec() callers will use it for unregistration.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 Documentation/block/ublk.rst | 14 +++++++-------
 drivers/block/ublk_drv.c     | 18 +++++++++---------
 include/linux/io_uring/cmd.h | 26 ++++++++++++++++++++------
 io_uring/rsrc.c              | 14 +++++++-------
 4 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 8c4030bcabb6..aa6e0bf9405b 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -326,17 +326,17 @@ Zero copy
 ---------
 
 ublk zero copy relies on io_uring's fixed kernel buffer, which provides
-two APIs: `io_buffer_register_bvec()` and `io_buffer_unregister_bvec`.
+two APIs: `io_buffer_register_request()` and `io_buffer_unregister`.
 
 ublk adds IO command of `UBLK_IO_REGISTER_IO_BUF` to call
-`io_buffer_register_bvec()` for ublk server to register client request
+`io_buffer_register_request()` for ublk server to register client request
 buffer into io_uring buffer table, then ublk server can submit io_uring
 IOs with the registered buffer index. IO command of `UBLK_IO_UNREGISTER_IO_BUF`
-calls `io_buffer_unregister_bvec()` to unregister the buffer, which is
-guaranteed to be live between calling `io_buffer_register_bvec()` and
-`io_buffer_unregister_bvec()`. Any io_uring operation which supports this
-kind of kernel buffer will grab one reference of the buffer until the
-operation is completed.
+calls `io_buffer_unregister()` to unregister the buffer, which is guaranteed
+to be live between calling `io_buffer_register_request()` and
+`io_buffer_unregister()`. Any io_uring operation which supports this kind of
+kernel buffer will grab one reference of the buffer until the operation is
+completed.
 
 ublk server implementing zero copy or user copy has to be CAP_SYS_ADMIN and
 be trusted, because it is ublk server's responsibility to make sure IO buffer
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f6e5a0766721..03652d9ce5a4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1227,8 +1227,8 @@ __ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 {
 	int ret;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release,
-				      io->buf.auto_reg.index, issue_flags);
+	ret = io_buffer_register_request(cmd, req, ublk_io_release,
+					 io->buf.auto_reg.index, issue_flags);
 	if (ret) {
 		if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
 			ublk_auto_buf_reg_fallback(ubq, req->tag);
@@ -2212,8 +2212,8 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	if (!req)
 		return -EINVAL;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
-				      issue_flags);
+	ret = io_buffer_register_request(cmd, req, ublk_io_release, index,
+					 issue_flags);
 	if (ret) {
 		ublk_put_req_ref(io, req);
 		return ret;
@@ -2244,8 +2244,8 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	if (!ublk_dev_support_zero_copy(ub) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
-				      issue_flags);
+	ret = io_buffer_register_request(cmd, req, ublk_io_release, index,
+					 issue_flags);
 	if (ret)
 		return ret;
 
@@ -2260,7 +2260,7 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	if (!(ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY))
 		return -EINVAL;
 
-	return io_buffer_unregister_bvec(cmd, index, issue_flags);
+	return io_buffer_unregister(cmd, index, issue_flags);
 }
 
 static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
@@ -2396,7 +2396,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		goto out;
 
 	/*
-	 * io_buffer_unregister_bvec() doesn't access the ubq or io,
+	 * io_buffer_unregister() doesn't access the ubq or io,
 	 * so no need to validate the q_id, tag, or task
 	 */
 	if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
@@ -2466,7 +2466,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
-			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
+			io_buffer_unregister(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 8881fb8da5e6..73f8ff9317d7 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -103,6 +103,12 @@ int io_uring_kmbuf_recycle(struct io_uring_cmd *cmd, unsigned int buf_group,
 
 bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd, unsigned int buf_group,
 			    unsigned int issue_flags);
+
+int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
+			       void (*release)(void *), unsigned int index,
+			       unsigned int issue_flags);
+int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
+			 unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -183,6 +189,20 @@ static inline bool io_uring_is_kmbuf_ring(struct io_uring_cmd *cmd,
 {
 	return false;
 }
+static inline int io_buffer_register_request(struct io_uring_cmd *cmd,
+					     struct request *rq,
+					     void (*release)(void *),
+					     unsigned int index,
+					     unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_buffer_unregister(struct io_uring_cmd *cmd,
+				       unsigned int index,
+				       unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
@@ -232,10 +252,4 @@ static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s32 ret,
 	return __io_uring_cmd_done(ioucmd, ret, res2, issue_flags, true);
 }
 
-int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
-			    void (*release)(void *), unsigned int index,
-			    unsigned int issue_flags);
-int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			      unsigned int issue_flags);
-
 #endif /* _LINUX_IO_URING_CMD_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index fa41cae5e922..2aac2778e5c1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -936,9 +936,9 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
-			    void (*release)(void *), unsigned int index,
-			    unsigned int issue_flags)
+int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
+			       void (*release)(void *), unsigned int index,
+			       unsigned int issue_flags)
 {
 	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
@@ -998,10 +998,10 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
+EXPORT_SYMBOL_GPL(io_buffer_register_request);
 
-int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			      unsigned int issue_flags)
+int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
+			 unsigned int issue_flags)
 {
 	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
@@ -1031,7 +1031,7 @@ int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
+EXPORT_SYMBOL_GPL(io_buffer_unregister);
 
 static int validate_fixed_range(u64 buf_addr, size_t len,
 				const struct io_mapped_ubuf *imu)
-- 
2.47.3


