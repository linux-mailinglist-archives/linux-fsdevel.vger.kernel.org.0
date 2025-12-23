Return-Path: <linux-fsdevel+bounces-71896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF3CD7821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED8D13038F5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5B1FE47B;
	Tue, 23 Dec 2025 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyj25nUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682F1F3BA4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450202; cv=none; b=eL3S1H3wzq2WxHtUe43Fu6OyN6LWFbbxH5MIj/AIv6dyFSJfLtS++ic1gKaKOoivCzBiiYMFBBcskmd29zs+SFO2sY4WyVVnNayBEkahf6HpaFNHEcD7ejN/ZBbgRywH+5d24nXevAD0Y4oaMSmHgzH2v7LIS1p9IiXHI2Y3K7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450202; c=relaxed/simple;
	bh=9kYMGOrHb3wl/0cEqDb01/TiX6ovIKjmJdmUpX+3jZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6MnyuJRKkiBNUP30vnAnnvIuGymPPGhmUfv7FGGDsHevdnYy9Lpfwh0sq2BUnaMAuyT4zcbsbjH15auBczDLLKQGL6dsF3567Hw69PU2l+vQQyBfReWRzQ3mzfU0bkcXFJW3UHtV8npbigCVIKy61c46Re5GHKfgKlKogwZ0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyj25nUx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so3923229b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450199; x=1767054999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck2Q1qPyrUc/Jo+wdlrTe48UP28F3NhBZmyq0UwZoeM=;
        b=Eyj25nUx52BJxrns8GKD1ynfWWaNTZsf/K5uQ4r9UidM8wIKRx6nRiA0+6Cep9wBde
         e7Or3bBcF+OqjC7Gu4OLj/B3rdXXOm8z6BcEcULgvPWHpNvS3ENgrfmzy8IgDmvryP7W
         gQ9vM3pDUwiUvLW2pTU9l3EhP7DXHo6///h5RYikv7X7/MKgJbKH7b17DYrtIFnGDSKO
         +dr720gGox2qVE6EHIjPQadmiScTiq01oa9ca8ceMwzMG9kKLuQ6akZHsViPmGctKRV1
         3aeF5JqH3VNJCvHqGnJWm4ByjHF/d4erujQbSd3iKenpTQhiZgNDzNa1wUibmmVT+wiI
         HD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450199; x=1767054999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ck2Q1qPyrUc/Jo+wdlrTe48UP28F3NhBZmyq0UwZoeM=;
        b=UbxmGj5mJiRfhQ39qZYh2S1SV1YTYfmQdhXc08E/IyX3r8vY2CYrRyMWIFQkM1f98+
         7IhSfrGaZij3kQ3/fOwt5Urm2E7zZB6lwxQBMKydwkh6YTQk8HYbRn8Uehg7K/fT8Xf+
         PSJar2EiS2rmvbZtfrP58z7faZorf5kuiWzZT/IZqrf44CI274eDvQeex062CX/DxGoD
         fE75dGp9SUIFa4BRPztVnYlmWlUAMRi7y9P4B2WbvF9t6WBBmppVr0FceypY2v5VLVVI
         EEzFWwEGA+xVvkY0Bom59ouCZDXS4/TUebuZRHoWVOn6Rf+01Mt/0ZPwaFdNjGepAEun
         nb9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0Q6k7mhie5eeFfI0d62EiahqJ0qZ5tNyLN6WWWtqkq6VOZHEVgru0C69V+l14XqXcv3uMmJF4265CX8sj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0MGAjAFs1exSDNgNkwL6OuPbgagPpvo9qR6j8jE/1kbrsUNv
	cvVMHDP738NIUGiru5WIxKSvhaYZeKdZMITVm9c+nIn/doL61wNgal1wCqB6p5ma
X-Gm-Gg: AY/fxX77chNShxMewKIxj8mWawhOEmZ2/rkWFbWihUuckhMNrkbPZeWEi+YUNGY/16Q
	2oWWXOTiXD3zOikeAsOFa7W/z+nLczRL5RCCoVPiSRfkrvSVxO6fK19Eg/2OrQ2gmwnyt5KeiCA
	9FlfPDiwGkYo5vaWpvyKz3b+0YXTWKetwWwmfUv7i7P+jrDL82Ggw/8IBKBq+W5ocM1JOemq33j
	LQGzkHMd0zotBaphhfE4k7eOvJzPZ6w9v363i5AW2GrpX6ildnE1UGFWnURFxPhgh2c+FxuGjEx
	1jnuJlptXrDTyS9VW5F/vzQpcmVyXxdPef0CXhvz+37gBH9Y1uJaz8wsZJevLXGIH4lu+uiHhtx
	VX3pJIiWnCJf/QT1bMDjTdxiArXQqZeDIrwQEMTDejkj/jw85Mo9DJ5p+najZ2bt50snuSYWaYb
	0rY7uDQ4oIAO6jY0sM
X-Google-Smtp-Source: AGHT+IFAVtigN7MKHO773AaRUhiCRsCfbmfFL6lRlBjR5abztZvo9rRlblje7J2mbsYKfqAbxM161Q==
X-Received: by 2002:a05:6a00:328f:b0:7e8:4587:e8cc with SMTP id d2e1a72fcca58-7ff66a6d95emr11334837b3a.63.1766450198981;
        Mon, 22 Dec 2025 16:36:38 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b22536esm11526697b3a.23.2025.12.22.16.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:38 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/25] io_uring: add io_uring_cmd_fixed_index_get() and io_uring_cmd_fixed_index_put()
Date: Mon, 22 Dec 2025 16:35:05 -0800
Message-ID: <20251223003522.3055912-9-joannelkoong@gmail.com>
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

Add two new helpers, io_uring_cmd_fixed_index_get() and
io_uring_cmd_fixed_index_put(). io_uring_cmd_fixed_index_get()
constructs an iter for a fixed buffer at a given index and acquires a
refcount on the underlying node. io_uring_cmd_fixed_index_put()
decrements this refcount. The caller is responsible for ensuring
io_uring_cmd_fixed_index_put() is properly called for releasing the
refcount after it is done using the iter it obtained through
io_uring_cmd_fixed_index_get().

This is a preparatory patch needed for fuse-over-io-uring support, as
the metadata for fuse requests will be stored at the last index, which
will be different from the buf index set on the sqe.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 20 +++++++++++
 io_uring/rsrc.c              | 65 ++++++++++++++++++++++++++++++++++++
 io_uring/rsrc.h              |  5 +++
 io_uring/uring_cmd.c         | 21 ++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7169a2a9a744..2988592e045c 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,12 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
+int io_uring_cmd_fixed_index_get(struct io_uring_cmd *ioucmd, u16 buf_index,
+				 unsigned int off, size_t len, int ddir,
+				 struct iov_iter *iter,
+				 unsigned int issue_flags);
+int io_uring_cmd_fixed_index_put(struct io_uring_cmd *ioucmd, u16 buf_index,
+				 unsigned int issue_flags);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
@@ -109,6 +115,20 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_uring_cmd_fixed_index_get(struct io_uring_cmd *ioucmd,
+					       u16 buf_index, unsigned int off,
+					       size_t len, int ddir,
+					       struct iov_iter *iter,
+					       unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_uring_cmd_fixed_index_put(struct io_uring_cmd *ioucmd,
+					       u16 buf_index,
+					       unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
 		u64 ret2, unsigned issue_flags, bool is_cqe32)
 {
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index a63474b331bf..a141aaeb099d 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1151,6 +1151,71 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
 }
 
+int io_reg_buf_index_get(struct io_kiocb *req, struct iov_iter *iter,
+			 u16 buf_index, unsigned int off, size_t len,
+			 int ddir, unsigned issue_flags)
+{
+	struct io_ring_ctx *ctx = req->ctx;
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
+		return -EINVAL;
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
+	return 0;
+
+error:
+	io_reg_buf_index_put(req, buf_index, issue_flags);
+	return err;
+}
+
+int io_reg_buf_index_put(struct io_kiocb *req, u16 buf_index,
+			 unsigned issue_flags)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_rsrc_node *node;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	node = io_rsrc_node_lookup(&ctx->buf_table, buf_index);
+	if (WARN_ON_ONCE(!node)) {
+		io_ring_submit_unlock(ctx, issue_flags);
+		return -EFAULT;
+	}
+
+	io_put_rsrc_node(ctx, node);
+
+	io_ring_submit_unlock(ctx, issue_flags);
+
+	return 0;
+}
+
 /* Lock two rings at once. The rings must be different! */
 static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
 {
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index d603f6a47f5e..16f4bab9582b 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -64,6 +64,11 @@ struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
 			unsigned issue_flags);
+int io_reg_buf_index_get(struct io_kiocb *req, struct iov_iter *iter,
+			 u16 buf_index, unsigned int off, size_t len,
+			 int ddir, unsigned issue_flags);
+int io_reg_buf_index_put(struct io_kiocb *req, u16 buf_index,
+			 unsigned issue_flags);
 int io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index b6b675010bfd..ee95d1102505 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -314,6 +314,27 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
 
+int io_uring_cmd_fixed_index_get(struct io_uring_cmd *ioucmd, u16 buf_index,
+				 unsigned int off, size_t len, int ddir,
+				 struct iov_iter *iter,
+				 unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_reg_buf_index_get(req, iter, buf_index, off, len, ddir,
+				    issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_fixed_index_get);
+
+int io_uring_cmd_fixed_index_put(struct io_uring_cmd *ioucmd, u16 buf_index,
+				 unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_reg_buf_index_put(req, buf_index, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_fixed_index_put);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.47.3


