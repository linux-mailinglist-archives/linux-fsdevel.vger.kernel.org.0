Return-Path: <linux-fsdevel+bounces-70517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC992C9D6F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3260D34117E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C122E3E9;
	Wed,  3 Dec 2025 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We//Ij8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823525B1D2
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722231; cv=none; b=haebTxgclcpTrZOyrZijZ+60t/rIYXdz1oDvJ3QHPnqhPSB1/3Wfq1Kuqo7+0/jG5eUVlSSmoT3SUQLxP3LEz/73wInb44X2T+gFIAEu6IzYTFlwqn5vlaKIA0yoZCR0pOjlWxxhoyB0OtOBUF/bcAfc9jIa9QdcIkzu8HtEHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722231; c=relaxed/simple;
	bh=+5vBYR+SgGW/l/syg9bA+vMsBlNuUivD8APsUQB7KXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITJ89gAHgdJGdE/zvqTrKzhKAA2iqKzmRkjSZd44IW3v1corsrAIQdotkCvgIWoXmcLrq/g52cpzl5p/+G5/7izsGgYZsFhMRZBeN3Bh9NBqlAt1u5PxSnyUm7ZBJ3N4Ypoa7hButDKYGGlRsoj6q+UyRCmaa6+/Xdw/mfaYudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We//Ij8C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b80fed1505so7137086b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722227; x=1765327027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjeb3YgopjuqhEACygVcbH2aWw/4BqNh5zZAMKieE6s=;
        b=We//Ij8CK/T0zC7yHUfHXSv6+0DWcrcx5N4mC+kvELos6YA6bV26rOJBIrcUAcV2v6
         RQzrhpsMYuRepeCRfu3bYBWYHGnWkl79x6mZ3JHiUmHxZoPvXqpnMZuuu93NyOqTeWGL
         Q1CwUS2ufH8/QImfojs5hE4a3+L9bcaZSpkVMMrn7/yE1Y81fa34XEV6VVV23tKvaIcc
         UJe4zOmL1KAZSR1WYMiHxRx3/MWxV4hz5Uaex+t8GyAiVGRGcNi+7+5z9JCrSlRxVmCy
         zviz+vQ9VyfunJ7hYJd6dxq4/EL7DWZBtS4wrbdRdVQOWy9tp0PvtjMLAi40hCeYJYDn
         p0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722227; x=1765327027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fjeb3YgopjuqhEACygVcbH2aWw/4BqNh5zZAMKieE6s=;
        b=T+1ldaOus8bqYmnOZ224/dMXCEagvH/ARI5mFLmCN7qWdJpNUmJccO3pUxtZyFo+OI
         ajw9dxtkvHkNi25hrtqluX8KOojQ7My+9vg/QxCeAwuB32AxP4ettBZI16HYK0IZ1aEj
         yEOgSGGF7cVqcSHReN9rKQXs74iBONkjYik40434nk7DucPnayYh/cpFWeyviaU3DRb7
         TbOah5l242DbH1zL26VmsCA7IkEL2HrvBSj7NuBG3Dggrjx/dlSzkXwTvo5KddXcRkEE
         yXVDENfQXPq1GNZQZ5ucZcXBDDjl04d/wbVQi0VBbeYhXpH7zqtylV88A1fJQmYdWGjY
         h1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCXeBemJ+ynnXqZpGsQJAI11GphlhKZoO/YTfxe2uvxNyszGoCAQ6qf4TT5F8+vF3LPubrbQ1sp0CBEMpJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3vKjYZpKW7jUCLC3lWlhIB+Wi8WykT0+MXFR/u1mLMj386G5
	vTQUw3DvBW5RUVvvMr5GM3IjjBv3wqOh4pDnPYLk+RX1W4BO6IVFo1VJ
X-Gm-Gg: ASbGncsrFkgnYlKYZY5tiJeHmLszaAF+aTlPae3jIjp6jgrmJIw0FxFxBlCa8L7iPoK
	RzjCjVUanZHFsZkf8eKKzwD5HjsgvuyouV/Lps7G0wYvAS/84/0U/J14DrDIL5uSKSpUaK1w/gK
	HtqZSiKQ25fVspIAbtI3bz5T4CNdqlzKOKu0gu/crJU686qcbhql4gE7nNWHpYpADl+VdPz4xA4
	8QFKGS994XnCwSHTybFO9GCn4esEPEgRRPYvqos1/OhNzz1j1ixNLMr529db2dOkzUdY14EWyjS
	aLuwb/vDBMTS7iRjCzLsCE02gg7+wxfax29Rmz0i0Eb6aZAHTLxCQgDGg8xcyrP0CsTpxoFkyzy
	OgMeWIDjPkDP7ucgelJqzNcAyilMnsBb4EPj+6IfAOde8Tjl4NjbC3KE5lFTlnqKMhvubPmGiWC
	BXC6+22FIHfP7lKpam
X-Google-Smtp-Source: AGHT+IHKjXl4xrufnK/iZPwaL9tOuSw9Hpcoz+W9ZE7Qvqswa4CPj3DhTNsJ8WyNYPtdszc1YZ2S3w==
X-Received: by 2002:a05:6a20:7f83:b0:342:fa4f:5843 with SMTP id adf61e73a8af0-363f5e96442mr662191637.43.1764722226703;
        Tue, 02 Dec 2025 16:37:06 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm17953587b3a.42.2025.12.02.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:37:06 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 22/30] io_uring/rsrc: refactor io_buffer_register_bvec()/io_buffer_unregister_bvec()
Date: Tue,  2 Dec 2025 16:35:17 -0800
Message-ID: <20251203003526.2889477-23-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-1-joannelkoong@gmail.com>
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
- Rename io_buffer_register_bvec() to io_buffer_register_request()
- Rename io_buffer_unregister_bvec() to io_buffer_unregister()
- Add cmd wrappers for io_buffer_register_request() and
  io_buffer_unregister() for ublk to use

This is in preparation for supporting kernel-populated buffers in fuse
io-uring, which will need to register bvecs directly (not through a
block-based request) and will need to do unregistration through an
io_ring_ctx directly.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 Documentation/block/ublk.rst | 15 ++++++++-------
 drivers/block/ublk_drv.c     | 20 +++++++++++---------
 include/linux/io_uring/cmd.h | 13 ++++++++-----
 io_uring/rsrc.c              | 14 +++++---------
 io_uring/rsrc.h              |  7 +++++++
 io_uring/uring_cmd.c         | 21 +++++++++++++++++++++
 6 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 8c4030bcabb6..1546477e768b 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -326,16 +326,17 @@ Zero copy
 ---------
 
 ublk zero copy relies on io_uring's fixed kernel buffer, which provides
-two APIs: `io_buffer_register_bvec()` and `io_buffer_unregister_bvec`.
+two APIs: `io_uring_cmd_buffer_register_request()` and
+`io_uring_cmd_buffer_unregister`.
 
 ublk adds IO command of `UBLK_IO_REGISTER_IO_BUF` to call
-`io_buffer_register_bvec()` for ublk server to register client request
-buffer into io_uring buffer table, then ublk server can submit io_uring
+`io_uring_cmd_buffer_register_request()` for ublk server to register client
+request buffer into io_uring buffer table, then ublk server can submit io_uring
 IOs with the registered buffer index. IO command of `UBLK_IO_UNREGISTER_IO_BUF`
-calls `io_buffer_unregister_bvec()` to unregister the buffer, which is
-guaranteed to be live between calling `io_buffer_register_bvec()` and
-`io_buffer_unregister_bvec()`. Any io_uring operation which supports this
-kind of kernel buffer will grab one reference of the buffer until the
+calls `io_uring_cmd_buffer_unregister()` to unregister the buffer, which is
+guaranteed to be live between calling `io_uring_cmd_buffer_register_request()`
+and `io_uring_cmd_buffer_unregister()`. Any io_uring operation which supports
+this kind of kernel buffer will grab one reference of the buffer until the
 operation is completed.
 
 ublk server implementing zero copy or user copy has to be CAP_SYS_ADMIN and
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e0c601128efa..d671d08533c9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1246,8 +1246,9 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 {
 	int ret;
 
-	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
-				      io->buf.index, issue_flags);
+	ret = io_uring_cmd_buffer_register_request(io->cmd, req,
+						   ublk_io_release,
+						   io->buf.index, issue_flags);
 	if (ret) {
 		if (io->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
 			ublk_auto_buf_reg_fallback(ubq, io);
@@ -2204,8 +2205,8 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	if (!req)
 		return -EINVAL;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
-				      issue_flags);
+	ret = io_uring_cmd_buffer_register_request(cmd, req, ublk_io_release,
+						   index, issue_flags);
 	if (ret) {
 		ublk_put_req_ref(io, req);
 		return ret;
@@ -2236,8 +2237,8 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	if (!ublk_dev_support_zero_copy(ub) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
-	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
-				      issue_flags);
+	ret = io_uring_cmd_buffer_register_request(cmd, req, ublk_io_release,
+						   index, issue_flags);
 	if (ret)
 		return ret;
 
@@ -2252,7 +2253,7 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	if (!(ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY))
 		return -EINVAL;
 
-	return io_buffer_unregister_bvec(cmd, index, issue_flags);
+	return io_uring_cmd_buffer_unregister(cmd, index, issue_flags);
 }
 
 static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
@@ -2386,7 +2387,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		goto out;
 
 	/*
-	 * io_buffer_unregister_bvec() doesn't access the ubq or io,
+	 * io_uring_cmd_buffer_unregister() doesn't access the ubq or io,
 	 * so no need to validate the q_id, tag, or task
 	 */
 	if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
@@ -2456,7 +2457,8 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
-			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
+			io_uring_cmd_buffer_unregister(cmd, buf_idx,
+						       issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 795b846d1e11..fc956f8f7ed2 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -185,10 +185,13 @@ static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s32 ret,
 	return __io_uring_cmd_done(ioucmd, ret, res2, issue_flags, true);
 }
 
-int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
-			    void (*release)(void *), unsigned int index,
-			    unsigned int issue_flags);
-int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			      unsigned int issue_flags);
+int io_uring_cmd_buffer_register_request(struct io_uring_cmd *cmd,
+					 struct request *rq,
+					 void (*release)(void *),
+					 unsigned int index,
+					 unsigned int issue_flags);
+
+int io_uring_cmd_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
+				   unsigned int issue_flags);
 
 #endif /* _LINUX_IO_URING_CMD_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index b6dd62118311..59cafe63d187 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -941,11 +941,10 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
-			    void (*release)(void *), unsigned int index,
-			    unsigned int issue_flags)
+int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *rq,
+			       void (*release)(void *), unsigned int index,
+			       unsigned int issue_flags)
 {
-	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
 	struct req_iterator rq_iter;
 	struct io_mapped_ubuf *imu;
@@ -1003,12 +1002,10 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
 
-int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			      unsigned int issue_flags)
+int io_buffer_unregister(struct io_ring_ctx *ctx, unsigned int index,
+			 unsigned int issue_flags)
 {
-	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
 	struct io_rsrc_node *node;
 	int ret = 0;
@@ -1036,7 +1033,6 @@ int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
 
 static int validate_fixed_range(u64 buf_addr, size_t len,
 				const struct io_mapped_ubuf *imu)
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 658934f4d3ff..d1ca33f3319a 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -91,6 +91,13 @@ int io_validate_user_buf_range(u64 uaddr, u64 ulen);
 bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 			      struct io_imu_folio_data *data);
 
+int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *rq,
+			       void (*release)(void *), unsigned int index,
+			       unsigned int issue_flags);
+
+int io_buffer_unregister(struct io_ring_ctx *ctx, unsigned int index,
+			 unsigned int issue_flags);
+
 static inline struct io_rsrc_node *io_rsrc_node_lookup(struct io_rsrc_data *data,
 						       int index)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 3eb10bbba177..3922ac86b481 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -383,6 +383,27 @@ struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_buffer_select);
 
+int io_uring_cmd_buffer_register_request(struct io_uring_cmd *cmd,
+					 struct request *rq,
+					 void (*release)(void *),
+					 unsigned int index,
+					 unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+
+	return io_buffer_register_request(ctx, rq, release, index, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_buffer_register_request);
+
+int io_uring_cmd_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
+				   unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+
+	return io_buffer_unregister(ctx, index, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_buffer_unregister);
+
 /*
  * Return true if this multishot uring_cmd needs to be completed, otherwise
  * the event CQE is posted successfully.
-- 
2.47.3


