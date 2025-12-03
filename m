Return-Path: <linux-fsdevel+bounces-70503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF3C9D6A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88D434E4B3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34323C4FA;
	Wed,  3 Dec 2025 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGUXdJyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E322B5A5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722205; cv=none; b=j/2VTqWERLAFSuGPzU/lbZPhYvfWFcP4AhHAXWMLJTFbn2qFY8kfSiUj+12u98zdUIxGG8xEzBTw2yWf+YSkvp67H1yBaqisJ2h33Gk8f0JL43Z2du5cY321AB5cL0blgX9HrELEivK8NFHKWthh+zEsg/Vrmpltb5ZVOha0UbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722205; c=relaxed/simple;
	bh=l8OfGZ+ZuhyqJEg+pGHrAWYSbfp9jx2EVw3z0b+noWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4Co74aaUUqkOts8K6MlUrCWHpl3QRYZQYszlVi4mv0seFXDjJ9dIeun7bCz2r3gQeEBsemY3jkLILbYW1BE/86qI9WSLk7ajU1sPR1VxQ2mKmLj6fqcqgx3CD/GrxmPVDJFbTQMjjWcc9cXRRdjtWyQN19oeRoLx1Mc0UaLIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGUXdJyi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2984dfae043so53047895ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722203; x=1765327003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abgU8eXy2UGHu3I1rTvvJ2cLDoZHFsXc9Y3NuDMCzsQ=;
        b=dGUXdJyiAVjy8pkKras47Vt4bmYC/knhSrwt8Ica+bcnbkJmUFnFuz7UNBmNEYKuDU
         JRNsQwQXymPoUpXgn4eE4ELiifOVsaK6H9IIN3rdzJ8ntNaxm86OTCIgbQCMDZEdM/EX
         mEZYIfBrRNUT2E1AANKgDa3FG5krVDyLBXRQVgg1Y+6qjN2cTW4Noj0iK9TZTR6KmODS
         XdACee0iPOZT2A8OK8qUhokzG/Lp/ShVexjZp9JxPIsx7OEBPP3EFzuh9wJV4EMg0Tpb
         XO29QrDYeXJ4T7OU94bAOLHIBI+ipMoJvKsdnAEJv2zqGjNGNqOx6Y23jIiJmHh4Bwc0
         /Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722204; x=1765327004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=abgU8eXy2UGHu3I1rTvvJ2cLDoZHFsXc9Y3NuDMCzsQ=;
        b=gfzjbADI1+9GShZJFb7NlyQZThNN0Bo4LXK/0ZIN873PMPzFkqd6zFQUR7ZIqgEZ5x
         EUk8TkLmKXJSFhjeg5n6u0KwT3puRlz8LQ9andql7x7+K7mSH0nYcyGED/AUrDon25Q4
         +TCpszPPAeJa9JEVc+ZjdiBnF8qJABkm3mfqQVOxPgGPsjiyG3rusbwPyv5v2pj3bulT
         0yfk5uPtCjw+PgunjTQKvy3Xn7ZDM/+b2FZEwnnAznTOqS4nEa97i/m9jZQl82JyZJRB
         sZosZfmY7rR3cLuPu1tgGNcnR/A/SwdaphZwdw0fH3chnIXjmYT+C+aw3BCGvT5UEA2z
         zg+g==
X-Forwarded-Encrypted: i=1; AJvYcCXc2HX8+HYQlqy+JICH3EeJAiDtA526je+T42y0ElWjtWacw00kNNT6OXpaJaUhySBBHnPUbZYIQ3JGGdFu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4CgYgwN3fnbG5nUhrcJafz0Q4ojsMiwVOuUE6i1n6TaJlhcW
	NeQ2f407QkXp4gSm39DrCqGl/WiEdZoOFcm6qqJNk+evxaTdsVV6xZfh
X-Gm-Gg: ASbGncuP3itabOwlHcicLlGIX9al1zt1PJllSzkVhuJg9ymmIDvcQbA9mJGoxw3Ryfa
	9aQxHY0IvSY8yW5PmOmvh47Kbk6QqUUfCsynlRbzDEWfhPn1/D5z7naAuyUccL24YRf58LHxMG+
	61FBCV7AH/WUaG0HeaNPG9glkmiETefv6o+zT62nl23516UzCD0YjyrCSQVka05L1m6/2IULi4a
	abUwdAhJHfNQxXSy0CdVJ5jH4fdVNHWm/dWYHdILqJyTxkzWeRz2IDZKi+aFr1tNay9tpV5tqL1
	qIyXQinUcxC5Qz4aQ5YJOxel1rE268TtsLMb5fPu7rJdTm1PUMf9ilQREqJsKaTFFYDz1p2WeC/
	yYpu7cB6hXlNdhpZaQET0bWjQ9xYIu6RoUccr2dZ6vczXixyxW9i6CE6FkRPq9oQj6htOuM75uR
	8CDj2D30ua8s2kuw7NQg==
X-Google-Smtp-Source: AGHT+IET1+7HqlrAt0XI+41UEiTuQnkd1mg2GkVbGorWDyZzRf32PjTJkSnkezsWod7FGGwyZ2PuSw==
X-Received: by 2002:a17:903:458d:b0:295:6e0:7b0d with SMTP id d9443c01a7336-29d683e9b80mr4872945ad.56.1764722203596;
        Tue, 02 Dec 2025 16:36:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb40281sm164966475ad.70.2025.12.02.16.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:43 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 09/30] io_uring: add io_uring_cmd_import_fixed_index()
Date: Tue,  2 Dec 2025 16:35:04 -0800
Message-ID: <20251203003526.2889477-10-joannelkoong@gmail.com>
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

Add a new helper, io_uring_cmd_import_fixed_index(). This takes in a
buffer index. This requires the buffer table to have been pinned
beforehand. The caller is responsible for ensuring it does not use the
returned iter after the buffer table has been unpinned.

This is a preparatory patch needed for fuse-over-io-uring support, as
the metadata for fuse requests will be stored at the last index, which
will be different from the sqe's buffer index.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 10 ++++++++++
 io_uring/rsrc.c              | 31 +++++++++++++++++++++++++++++++
 io_uring/rsrc.h              |  2 ++
 io_uring/uring_cmd.c         | 11 +++++++++++
 4 files changed, 54 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 375fd048c4cb..a4b5eae2e5d1 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,9 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  size_t uvec_segs,
 				  int ddir, struct iov_iter *iter,
 				  unsigned issue_flags);
+int io_uring_cmd_import_fixed_index(struct io_uring_cmd *ioucmd, u16 buf_index,
+				    int ddir, struct iov_iter *iter,
+				    unsigned int issue_flags);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
@@ -100,6 +103,13 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_uring_cmd_import_fixed_index(struct io_uring_cmd *ioucmd,
+						  u16 buf_index, int ddir,
+						  struct iov_iter *iter,
+						  unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
 		u64 ret2, unsigned issue_flags, bool is_cqe32)
 {
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 67331cae0a5a..b6dd62118311 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1156,6 +1156,37 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
 }
 
+int io_import_reg_buf_index(struct io_kiocb *req, struct iov_iter *iter,
+			    u16 buf_index, int ddir, unsigned issue_flags)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_rsrc_node *node;
+	struct io_mapped_ubuf *imu;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	if (buf_index >= req->ctx->buf_table.nr ||
+	    !(ctx->buf_table.flags & IO_RSRC_DATA_PINNED)) {
+		io_ring_submit_unlock(ctx, issue_flags);
+		return -EINVAL;
+	}
+
+	/*
+	 * We don't have to grab the reference on the node because the buffer
+	 * table is pinned. The caller is responsible for ensuring the iter
+	 * isn't used after the buffer table has been unpinned.
+	 */
+	node = io_rsrc_node_lookup(&ctx->buf_table, buf_index);
+	io_ring_submit_unlock(ctx, issue_flags);
+
+	if (!node || !node->buf)
+		return -EFAULT;
+
+	imu = node->buf;
+
+	return io_import_fixed(ddir, iter, imu, imu->ubuf, imu->len);
+}
+
 /* Lock two rings at once. The rings must be different! */
 static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
 {
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index d603f6a47f5e..658934f4d3ff 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -64,6 +64,8 @@ struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
 			unsigned issue_flags);
+int io_import_reg_buf_index(struct io_kiocb *req, struct iov_iter *iter,
+			    u16 buf_index, int ddir, unsigned issue_flags);
 int io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 197474911f04..e077eba00efe 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -314,6 +314,17 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
 
+int io_uring_cmd_import_fixed_index(struct io_uring_cmd *ioucmd, u16 buf_index,
+				    int ddir, struct iov_iter *iter,
+				    unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_import_reg_buf_index(req, iter, buf_index, ddir,
+				       issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_index);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.47.3


