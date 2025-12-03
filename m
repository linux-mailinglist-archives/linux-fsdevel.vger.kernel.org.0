Return-Path: <linux-fsdevel+bounces-70508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD316C9D6C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34F2334AF3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A72459E5;
	Wed,  3 Dec 2025 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjG3RjsJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362524677B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722215; cv=none; b=bfI7GVWxSU37J8vXBUMNZz43Stb4/rwCcT7Xlc326s/XtkcVD9MknVTMQLuANMA6EKMsjhlHUTB+nezR7DJ9/zTh6my9ZtIY6DJn7NoMsTyJ3SpSLORSq2NmFBDhFBEK9pafLJhZUwjw96e812J4MWLosZmiRXbQmCOxZQYdxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722215; c=relaxed/simple;
	bh=420DP0SfhweqJJU1QlR8Dz7eC9yXdvGbOgsdr0MHyU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN3hyjwTBSgLmq4xY97t32XPDP+roLcuWd8oqBCPwbuxXDumA5jAGY62kolxOOfoOG2ct4JOMzWsrDQIemhqIuM5Z13gGqkSdxWLbHkCsZxxuE4y/SJf6IcglLK4Y6zcuU2uSWm5W4uv2wjFu1SZUwa/nDddwW3KsT+h5A+zF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjG3RjsJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso4839063b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722213; x=1765327013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxmsapv35qufObfaLgjqvPmOfqDC04zQvOtEgbQTRLA=;
        b=GjG3RjsJdgxio7SUbsYrs73wp5g8FrUWOAcOmFc48xKBhfqcEUPCsLHpyQMlo87Dr2
         /09hYaQX+3khuXTXlzm2A8xOVSfuouM0pUTrZP0mA47eOIHHu9kfjf9SJvOQjlf0QhdQ
         m7py4Hyli1wnuiVPepzKM/RH69BUiPsS4bNreVBTDG4LVvl8YyopKSGorKLrwgd72Ewd
         vWYNGy5VOtH6YwMAiRxBo7Oj1D6cIOXU0OPMz/fNkd508MxIN1bnz1bwr9teDBwdoPDa
         /1IFAGgyWSrz+r/C/+6z+pmMfuaqF2uoU4RQP6LDxw04QjUk19TxY+VrVtfNcp8XO+vt
         lwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722213; x=1765327013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxmsapv35qufObfaLgjqvPmOfqDC04zQvOtEgbQTRLA=;
        b=aN7fQPh4LaBcrYxv8gUh6ORuuZpN/m+4zWDhUdryFgigRNFrORAMGJd1nN0itxX+fX
         6Qw7MSPSxRRglYTL2PjMT68INOBF9M0qBqs1kufv1vWnB19iTRcpF8aX2ERjy1tlagm8
         TZSgCQJcKP9A59KxI3YGDM+Z9VEUIOWHddEUeNaH1Cs23RYFrQcmpdLhYhImjSxLl1Fs
         AQGQjKrjRKTUKwIOsmXZ9r1q9zte147SmvE+uaTGLa5lZyaXJST6aQGzKrk4my49Tpc4
         +jR+BJNLkGTrLBO2u+sbzXEKG3xN/cHU4VIB1txXFSuOY4EM/qtcuOj493Jzpv/cMDhh
         /0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUhPp30UgeGG/NAnM/cxDW0KRRPI9AAr7vjMdKOrmQt0cN1Ew5AmHtGAyDvMprK8o4Ya2wLuYn6qBYrJV7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLrocIpdUGkYjRovX90KfwQRZb6T64iP3OC4UjRUnfI0cMMc1
	5QYZP9BkPOuA1zAt25hFt03qtheybBdRi8DbBVos+LQ1LkZFeei1yNvf
X-Gm-Gg: ASbGncsph1SgmKkNEZb3h2rmgD4c6paGWsT12c7dZRXKHgB96l8VQZvSlvWybM9tf40
	wojvFNiX80OPL9Jvz4nmFARFCKsm226zq3cYhTvfVhv4MJ6a2uAgbVpkAsMx53u9XAsVQMUlhYT
	W6TTEUmkhKxJvkGKdroZ/GtgWenGNk4I/Yx8H57DLM0O53779+48848M98TLKTf7rUccJKckdn+
	7WP7VSLIP9K9Do/Z7UIHfCwvGohjXdVAZwhVhGROgXXPDJiofjagrmdjan6oo5JO2v54WejT/Jt
	qq/PWrB7M8zuaSp0jgMJ8VhiZgbhrjNVw7IP91CC8qfgbVMUY3CAWKpkEH5l8cDXUi2ilwB4HYY
	YESnooWAlvVtVHlrprsV77peyA83jcX1oJVDsYHW9RL67Q2IuFs6xCm7apOc355KM7DRXGKP/oW
	eXLiokHXmNfqALtS4e
X-Google-Smtp-Source: AGHT+IGPkZMvuxYZd9NIH1098itDzU9NViIsXW4cPW5vwMcksYpqL+XIx7P92nj1pycsz3+KLQ80Yw==
X-Received: by 2002:a05:6a00:3d53:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7e0038b5437mr486026b3a.0.1764722213204;
        Tue, 02 Dec 2025 16:36:53 -0800 (PST)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b684d7sm18188615b3a.7.2025.12.02.16.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:52 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 14/30] io_uring: add release callback for ring death
Date: Tue,  2 Dec 2025 16:35:09 -0800
Message-ID: <20251203003526.2889477-15-joannelkoong@gmail.com>
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

Allow registering a release callback on a ring context that will be
called when the ring is about to be destroyed.

This is a preparatory patch for fuse. Fuse will be pinning buffers and
registering bvecs, which requires cleanup whenever a server
disconnects. It needs to know if the ring is alive when the server has
disconnected, to avoid double-freeing or accessing invalid memory.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring.h       |  9 +++++++++
 include/linux/io_uring_types.h |  2 ++
 io_uring/io_uring.c            | 15 +++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 85fe4e6b275c..327fd8ac6e42 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_IO_URING_H
 #define _LINUX_IO_URING_H
 
+#include <linux/io_uring_types.h>
 #include <linux/sched.h>
 #include <linux/xarray.h>
 #include <uapi/linux/io_uring.h>
@@ -28,6 +29,9 @@ static inline void io_uring_free(struct task_struct *tsk)
 	if (tsk->io_uring)
 		__io_uring_free(tsk);
 }
+void io_uring_set_release_callback(struct io_ring_ctx *ctx,
+				   void (*release)(void *), void *priv,
+				   unsigned int issue_flags);
 #else
 static inline void io_uring_task_cancel(void)
 {
@@ -46,6 +50,11 @@ static inline bool io_is_uring_fops(struct file *file)
 {
 	return false;
 }
+static inline void
+io_uring_set_release_callback(struct io_ring_ctx *ctx, void (*release)(void *),
+			      void *priv, unsigned int issue_flags)
+{
+}
 #endif
 
 #endif
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index dcc95e73f12f..67c66658e3ec 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -441,6 +441,8 @@ struct io_ring_ctx {
 	struct work_struct		exit_work;
 	struct list_head		tctx_list;
 	struct completion		ref_comp;
+	void				(*release)(void *);
+	void				*priv;
 
 	/* io-wq management, e.g. thread count */
 	u32				iowq_limits[2];
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1e58fc1d5667..04ffcfa6f2d6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2952,6 +2952,19 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+void io_uring_set_release_callback(struct io_ring_ctx *ctx,
+				   void (*release)(void *), void *priv,
+				   unsigned int issue_flags)
+{
+	io_ring_submit_lock(ctx, issue_flags);
+
+	ctx->release = release;
+	ctx->priv = priv;
+
+	io_ring_submit_unlock(ctx, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_set_release_callback);
+
 struct io_tctx_exit {
 	struct callback_head		task_work;
 	struct completion		completion;
@@ -3099,6 +3112,8 @@ static int io_uring_release(struct inode *inode, struct file *file)
 	struct io_ring_ctx *ctx = file->private_data;
 
 	file->private_data = NULL;
+	if (ctx->release)
+		ctx->release(ctx->priv);
 	io_ring_ctx_wait_and_kill(ctx);
 	return 0;
 }
-- 
2.47.3


