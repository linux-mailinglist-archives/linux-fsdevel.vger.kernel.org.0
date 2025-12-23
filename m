Return-Path: <linux-fsdevel+bounces-71907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57314CD782D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94E8F3030707
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C21F3BA4;
	Tue, 23 Dec 2025 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQR8Z1+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD141F63D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450219; cv=none; b=uvZwvufRAbOJDFoguXRTveFGw3pjritc0uaAezXDpf22qghW50p2bsPQY2LwQhxHlAG+yLflLyQY+bYr+tk7Ruw5k+D3O0Zk7j9CvnOKb4XLHnZFAEnRyVGrvaRdRbE843IXQfByA/kmUEO5VonLlEOI+ZQdWXdx9UYQ9NGd3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450219; c=relaxed/simple;
	bh=soNDjN4Hg1HDbO6N47LyqeWtDuXMqLoY2KmCpUhlAu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/sQmxsSSj67J8zAC8lef5UFKvnkXbsfkgof96aqnIyUMBYIOwFYv3n7QK75Qj3nI+RuarU0eTpWETD582B4/Jq+d5efbGFypYRiEJ2ZCqsgxaS2c2lXi727SOS9sMtMsBzWFRYvHv6CobFN3fUEm0OFWyC+6rTt9H7f/GsMEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQR8Z1+J; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so5131502b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450217; x=1767055017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+PMOnADpkrXPeja+JJtAc/R9LXegQj84x9pa/zMxiU=;
        b=RQR8Z1+Jp0UreL1x6N0OT2CEIkg6EjlGdm8moAUJ0etbLakviXb8EFeYvZvR7wdrQC
         Aw7x44pJ+ysoAJDHOqb0FwjbkgcgCDmzeszJzUtturxvtSsv8aa+HP0JqXm+DfS155K8
         XMS6oFBbgCGbGAw53Gjlo7O2HVO7veTq5Ya6MRL58vtJzykyasMjcg2/OGeEbMMGos+k
         2DHRHGtJNdpKdDluw6fNMvbLikg4EjROpuSAT1ZzGOK4PhVVltpJZYX1LMIqUzwv3DhP
         WxDmS5H2j0wGxF8YDfTMcgU5MFw7EzfgwdyO05xWx7jvyX3QmbHpHlFck6deHbF8vQXz
         Hd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450217; x=1767055017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+PMOnADpkrXPeja+JJtAc/R9LXegQj84x9pa/zMxiU=;
        b=docBmy9bJqNhwGuU3im865JzJb0eTtMuUmviD+SuS/3eFEqOG8XYWPnDSVjlddyELC
         SP5IyO4D/4SM5WepdghlmQLzO1Fy7X5tV9QX9rkuw2z0vxnSQawDRFxSiQFcJTtXoFG+
         RoH8xwKngkzlgPFrwZ5ZX3+SCcyXwLEBntdntLdcFl6AclgE7opkKiEn4SAPsUp6NzYj
         TvoL7s/2a/VcpzOiKthHL65GoUlNWElW540B5frgunoS7GQF2Epr0tJ9mHyO4eIqi4xF
         UeyGxqYoGBCe2K587fjsJcGJZpou3nyr05DltgrEEgrmIszg2uz1wWvxAbXlNZ8nmzO1
         EcMw==
X-Forwarded-Encrypted: i=1; AJvYcCXkYBQNyjI+fwiUM8z737UBMSZ5ovQCk9njWa2W/ueNtaZA23zm7HSoh8bYu76YTNSQyKImEaRlO/QJ8dTE@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPH+7UziMmd34rit5ifUDOT7PCfLUzTVddp3rOb+l4KJbeoxd
	CwuRFiuOY/RCfhTsIzGeddVZaFPrhIZ8fw649y3EBJYHvzEBAoSgrXsM
X-Gm-Gg: AY/fxX73otz9Jo97A+l5dd9L+/j1EBor9Z30ALR652HFeHpfqtWPbYAodeO9i+CjrtW
	TeCVt6HaH8Pb7UJ4omk7cFniRcMC3HKH/nJCiMML6o71Lwig2NyET7Iip2MV2YKR1BLfz5+1935
	6CzAkX5rWaZ29aCD0Kdth8LgjlCF5HVjHC+ZLt+XDrZM2s0XCqsdGCpAprZ7N9nQ1OpjaRGKiEK
	mZ+UJOTsBpvNsx2+yXyKsbUXrbizyMBgAeFzEA1G6kzd4HoEAk9Q995fJk/tAGhcFBIlR/Y4mJx
	LfZ5JYnZtm1vqOynvXY1CVworIbtifpTUpSdiBndnNv5g0ySYOpokphaBwgV49BbMl2d/iffSmO
	91ZTAtYR3XMU2je4xXNYlQjDoK8N2Ul9wlaIDLEhOhKHoG3EG7SxCEpy6kb5bYoiUH1DvO+2+ip
	Hptetx6n3E9Xg0tlGhuFaMLm5vWYAl
X-Google-Smtp-Source: AGHT+IHUpKssHtKmkev/GHtoJN+iYX1L9WBQbmA3wHn3NBl1kTZ+y3JVrSXKaGwr1GWpN/nTHuG4Qg==
X-Received: by 2002:a05:6a00:1c96:b0:7fb:c6ce:a858 with SMTP id d2e1a72fcca58-7ff66d5fc2cmr11529486b3a.68.1766450216837;
        Mon, 22 Dec 2025 16:36:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93ab3csm11530102b3a.7.2025.12.22.16.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:56 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 20/25] io_uring/rsrc: rename io_buffer_register_bvec()/io_buffer_unregister_bvec()
Date: Mon, 22 Dec 2025 16:35:17 -0800
Message-ID: <20251223003522.3055912-21-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223003522.3055912-1-joannelkoong@gmail.com>
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
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
index df9831783a13..0a42f6a75b62 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1202,8 +1202,8 @@ __ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 {
 	int ret;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release,
-				      io->buf.auto_reg.index, issue_flags);
+	ret = io_buffer_register_request(cmd, req, ublk_io_release,
+					 io->buf.auto_reg.index, issue_flags);
 	if (ret) {
 		if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
 			ublk_auto_buf_reg_fallback(ubq, req->tag);
@@ -2166,8 +2166,8 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	if (!req)
 		return -EINVAL;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
-				      issue_flags);
+	ret = io_buffer_register_request(cmd, req, ublk_io_release, index,
+					 issue_flags);
 	if (ret) {
 		ublk_put_req_ref(io, req);
 		return ret;
@@ -2198,8 +2198,8 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	if (!ublk_dev_support_zero_copy(ub) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
-				      issue_flags);
+	ret = io_buffer_register_request(cmd, req, ublk_io_release, index,
+					 issue_flags);
 	if (ret)
 		return ret;
 
@@ -2214,7 +2214,7 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	if (!(ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY))
 		return -EINVAL;
 
-	return io_buffer_unregister_bvec(cmd, index, issue_flags);
+	return io_buffer_unregister(cmd, index, issue_flags);
 }
 
 static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
@@ -2350,7 +2350,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		goto out;
 
 	/*
-	 * io_buffer_unregister_bvec() doesn't access the ubq or io,
+	 * io_buffer_unregister() doesn't access the ubq or io,
 	 * so no need to validate the q_id, tag, or task
 	 */
 	if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
@@ -2420,7 +2420,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
-			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
+			io_buffer_unregister(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 61c4ca863ef6..06e4cfadb344 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -102,6 +102,12 @@ int io_uring_cmd_kmbuffer_recycle(struct io_uring_cmd *cmd,
 
 int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd *ioucmd,
 			       unsigned int buf_group, unsigned int issue_flags);
+
+int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
+			       void (*release)(void *), unsigned int index,
+			       unsigned int issue_flags);
+int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
+			 unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -185,6 +191,20 @@ static inline int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd *ioucmd,
 {
 	return -EOPNOTSUPP;
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
@@ -234,10 +254,4 @@ static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s32 ret,
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
index a141aaeb099d..b25b418e5c11 100644
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


