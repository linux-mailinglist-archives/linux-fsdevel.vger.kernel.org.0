Return-Path: <linux-fsdevel+bounces-74257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EBED38A1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD9A7301B8A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50721FE44A;
	Fri, 16 Jan 2026 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKz5G6DW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AB32470D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606279; cv=none; b=pg3WXdgJDFP5e8QWalosft2qs1VySN/Hn2WaL9eoS5Mhnhg0ApafAEcF+LPI+sWA+QD+lJ30v1sho+r5ZBGwb9xPyEtQ8Oo/DNlxaDV9HPMCOhgEWsBooAh5XASBXFAaAsdTN3OOy/p8UivSChRVriPBAXyd2MCtonz8fwH2w4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606279; c=relaxed/simple;
	bh=EjxjOTqFgOvtuA4dLM7t0iYArbhOiNrx/OUSqoXDm5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfHso8r2UNNFDfjMG2ZVQFQ31KUL616X+sWfjlgUQLsRJIIDn7VeHxUYZkOH/Iuso44ZgnGEINZckodBqoid8dlxbPCkZG96V6cjJhkPQqksvHpX8kCZ/KdEoV+4FeeX+IwpF1uJen01l9GchzPouS+JAWQJo0Wvpv0F8Cir6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKz5G6DW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1462190a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606277; x=1769211077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3Gk2tIrXgyqFEboxPRB2FY0HeGB+AitSR/ivtptxU8=;
        b=CKz5G6DWeZyjVaOKhBTX1+I3waY4/yfr9/pvb3kd+E1DGci+OI/TQLfYDgrlaiMsRZ
         uDNCaH4lOUBPFRL5jVX7DHBjYGaCzeT+K5USaF3JryIDLp39gpgVCZGX283TA7HRTJqc
         6gVUl7HJnQHUaAXECXnxW2MIc8IcewxWNmnMjv5mcJbHqbTb2QaZedpF7ZyxpAls/oRq
         oUPOfLk/hXcm6PQopyvBG/SbTHhb/JG974/IFAvtIDMI/HpEdDBWY33RQnDfTMQBiMP2
         WlNfA9yrTUKCNvRoRul9mxVHEHr6F7ojV4vQxxz4OFD66MUMwmqaA+0Zy/9npr1+nAN/
         /18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606277; x=1769211077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R3Gk2tIrXgyqFEboxPRB2FY0HeGB+AitSR/ivtptxU8=;
        b=f5N7Juof8B0ZQJsQ3i/oO1O8aGtjCUYLRmTBG312k4jM0k0bPlVFnb3+ivmpAvPyTv
         Gri5ZfGeCHr7tdSO+BMrI8kF78Nvusj3lv8PEduSLmWIEvg1S2TgQDwH3xVWJGI0ue9m
         NtDks3OhzOdVZRPzf+tKJ+azOtLafX7NYc/ltwc5WePtwoxqnf6PIMS8yHdh9ibmMEQH
         s4gXkiJsASDISiEbLvv7fJ4tOTojGQVL1zu3RtEivET/RAPCVALHmHMhtsGTV3ACADG+
         z4PJjW4fvZm3XOliuEy3HWTxG7fw0kD6kYhhPKyaj/bTacZLhbx1LnD6HZL6eX0hYPjt
         SPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKI3KZ6OgfaU3TeAsIm1+ICya3AHmkKMH6aApDlVbXWH3XorS9p9hbPxbAfyTStVViJSaV4My86YzJpqlX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzits8hyGXQ4evogXSK+o9xH63Vh0t3AoZbaCNVFajbq7fUoLjB
	oRfrutmGyaO12KW2oSJ8cBmAhvOEQYzs0k2JfMCyaqlUz4exkoJ0yGKY
X-Gm-Gg: AY/fxX5qVZ/ZXkVCpsOIKBhrSLZ2fFJUfdqcD2PdizkKJ73rGgWL5MbOFtDydFXPFXT
	ocSKJQxeq03fU8tm5rJgdWPVctp2sbCpglsc12pOElm8fuHT0AejTdmCwDTJOO6qRVmJjgt1KUB
	fa5WvUQlyWdtNpAO/5pC+2cWkPXDM/mxMgMR5p+u0lzzPjTyp5xxD2D7zPVDiI6BYnW4vUMwYre
	j8wcLZddlj4B/dtM+mpuz3OSxecMgH6NHeBnSwD6c3MGNjvHJm2bGX+grFm+Q9J2fHv7N14aSM0
	Ldo5FBTJVyNeCo6MyZLjzYCViN1uWXyUqoXVHQarGim0DXSmUgpDloUW/jzWrae/brmwAcuZrjq
	tT8T/wRQHmgy7dvbVMQyqY+ytP9hPRT10E8bsllc1an26vHeZIvySx32LF7fIkZXBS4EPugbsV9
	PdsVbk/A==
X-Received: by 2002:a05:6300:6199:b0:38d:fe2a:4b16 with SMTP id adf61e73a8af0-38e00dbadecmr4272032637.73.1768606277262;
        Fri, 16 Jan 2026 15:31:17 -0800 (PST)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf23390asm966847a12.3.2026.01.16.15.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:16 -0800 (PST)
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
Subject: [PATCH v4 08/25] io_uring: add io_uring_fixed_index_get() and io_uring_fixed_index_put()
Date: Fri, 16 Jan 2026 15:30:27 -0800
Message-ID: <20260116233044.1532965-9-joannelkoong@gmail.com>
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

Add two new helpers, io_uring_fixed_index_get() and
io_uring_fixed_index_put(). io_uring_fixed_index_get() constructs an
iter for a fixed buffer at a given index and acquires a refcount on
the underlying node. io_uring_fixed_index_put() decrements this
refcount. The caller is responsible for ensuring
io_uring_fixed_index_put() is properly called for releasing the refcount
after it is done using the iter it obtained through
io_uring_fixed_index_get().

The struct io_rsrc_node pointer needs to be returned in
io_uring_fixed_index_get() because the buffer at the index may be
unregistered/replaced in the meantime between this and the
io_uring_fixed_index_put() call. io_uring_fixed_index_put() takes in the
struct io_rsrc_node pointer as an arg.

This is a preparatory patch needed for fuse-over-io-uring support, as
the metadata for fuse requests will be stored at the last index, which
will be different from the buf index set on the sqe.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 20 ++++++++++++
 io_uring/rsrc.c              | 59 ++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index a488e945f883..de3f550598cf 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,14 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
+struct io_rsrc_node *io_uring_fixed_index_get(struct io_uring_cmd *cmd,
+					      int buf_index, unsigned int off,
+					      size_t len, int ddir,
+					      struct iov_iter *iter,
+					      unsigned int issue_flags);
+void io_uring_fixed_index_put(struct io_uring_cmd *cmd,
+			      struct io_rsrc_node *node,
+			      unsigned int issue_flags);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
@@ -108,6 +116,18 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline struct io_rsrc_node *
+io_uring_fixed_index_get(struct io_uring_cmd *cmd, int buf_index,
+			 unsigned int off, size_t len, int ddir,
+			 struct iov_iter *iter, unsigned int issue_flags)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline void io_uring_fixed_index_put(struct io_uring_cmd *cmd,
+					    struct io_rsrc_node *node,
+					    unsigned int issue_flags)
+{
+}
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
 		u64 ret2, unsigned issue_flags, bool is_cqe32)
 {
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 41c89f5c616d..fa41cae5e922 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1152,6 +1152,65 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
 }
 
+struct io_rsrc_node *io_uring_fixed_index_get(struct io_uring_cmd *cmd,
+					      int buf_index, unsigned int off,
+					      size_t len, int ddir,
+					      struct iov_iter *iter,
+					      unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_rsrc_node *node;
+	struct io_mapped_ubuf *imu;
+	u64 addr;
+	int err;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	node = io_rsrc_node_lookup(&ctx->buf_table, buf_index);
+	if (!node) {
+		io_ring_submit_unlock(ctx, issue_flags);
+		return ERR_PTR(-EINVAL);
+	}
+
+	node->refs++;
+
+	io_ring_submit_unlock(ctx, issue_flags);
+
+	imu = node->buf;
+	if (!imu) {
+		err = -EFAULT;
+		goto error;
+	}
+
+	if (check_add_overflow(imu->ubuf, off, &addr)) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	err = io_import_fixed(ddir, iter, imu, addr, len);
+	if (err)
+		goto error;
+
+	return node;
+
+error:
+	io_uring_fixed_index_put(cmd, node, issue_flags);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(io_uring_fixed_index_get);
+
+void io_uring_fixed_index_put(struct io_uring_cmd *cmd,
+			      struct io_rsrc_node *node,
+			      unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	io_put_rsrc_node(ctx, node);
+	io_ring_submit_unlock(ctx, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_fixed_index_put);
+
 /* Lock two rings at once. The rings must be different! */
 static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
 {
-- 
2.47.3


