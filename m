Return-Path: <linux-fsdevel+bounces-71890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15275CD77F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB0E5302BA8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576DD20010C;
	Tue, 23 Dec 2025 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncADrOi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38B1F4613
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450190; cv=none; b=seJWzrpn3ja1TOgRopifvQWHIlyLlyS76mAar/MPiSQGG89E2Gr0pjsFu762GhIVPtxkjmh5qSOn64+Vbc1PqmSo+b8IfjslujIJPn75RdJWGajApQeRsPDoQ3NHvw2HH9byzmai/JmbZ9OOjqPrAsOmZTZR2q0CaqY7vzRCXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450190; c=relaxed/simple;
	bh=4BAaGievTtvkLoNgL0ZTdQZ2RPDEbM53T+cmtPTo8so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD+XYqZgNKg0txkLdIfnBF3KtpyLSpUT4NgqSjHaqEl4WBb9Wkp6K1/QV3AV6mlc6T2Hf+s+kKWnklu5DeIZsoYJ3HtSlMAine+mXCybb7vCfp1d+a0Va3THSXYDorr2jmg4oMr0KdbYTy8d+Ke5K3/sfbMzROxMfHIHEWjetVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncADrOi+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aab7623f42so5167157b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450189; x=1767054989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+ENtiB+VRiuAX55mhgrey4moIu9hfBSn8/uNmk3lgI=;
        b=ncADrOi+Z8x8/QbNsnA1Fo8zoAvxHw55F9Feqi4XTzbjdSdt58Xb2lPhksRN/2z/2N
         FPp5WNguEKNJvrLgxy1G5UV4AYBw73X15JarUgb7QVsxuBn/vTH5R0lyE/z2MxDezNXT
         9fU/nmMEOd+Hg3kNkjStx8Dz1om8coVKZF0tOGA1lvS6NV/vT3x77GfFyXoqu1rxomx9
         0Kz85Y7q5Vdn+GRkOWshnp9uy/5pIz1axmkfubd3uWCRLBeKj/L+SBJXAKf5tIDZ9oeX
         idRk442anFSVO2dEAEr3pdr4zuV+htwyRaLdg4lwU0aHGWkzfaXcZDaJLP4ASpKuLbUJ
         EMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450189; x=1767054989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+ENtiB+VRiuAX55mhgrey4moIu9hfBSn8/uNmk3lgI=;
        b=EdRv8uq2ogrDnktI3Q5gOoUmp43rCOYI2U3cVe98HbreCbgyjyeu5ZIu6BiRKkQUz1
         JyOy0IWlLPlE7Byam6tHgIc+pa6rRp7Bq6BDFWyVxCDi2/Cr+vQ3+Rj5oorYvT2HQzaa
         NCslFzZQWyKlsSxG+O50NNVidIE/SHnf2baSAUytLJIORANPXXfOXb8PngO6A2NgaLz1
         bMCNNo+w5IS+qsWIB2OxB93CaoG5t1dhGh/eiy56ptUNUn2+pxTuANo6aSRpAgOiuyWo
         a5PsGP1rQy6RhygecsctLuTaIRTg/TyA9OWfAPrOjs+nyIWvQgQD2yuhPAXd/zEgLqJu
         dhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+owI75dk8wYh//ipIkx5LoiG7EZv3/oSZ/y+/h2E9ZgbeXtbRoxvxDEC23F1FCOfNr2tn5+UX9mUvYR+@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/ULmMRLRJyUR3nUF65C2gn8LITVX8aQiF82QTc4X7tt+ukZ4
	lH4FOXccuE56Z/sZi/khVoAssx85KMz9vgGvZUUPLIHbbnDBG+WocWAN
X-Gm-Gg: AY/fxX5G35cyDda48AMPrX57emzCyGPWR0s59tDRdO4OnVFe3D5Fr8LgVryXqWWBwW2
	NRI1Xl8vSOHeiBOJKaDFXEAGNZb43qYwWoLrSEjJFSsYpWpllDpALtcSNUxzJmc2N5JtkJ74J1F
	QleHs8wlz+6SkFU4+QIsDmMCbabzBTaxBgX1b37+q79kgF/nicpEI2WEVJSaWBNp3b3gu+Sjtu9
	baz9gZnX2FsAynzQJGos6HzxE42vlwYtuGRAVCmqsCQEj0yapO7Jr+FWDyjtXHNH85xvjvdXrXY
	aE/u+jvpAv1TLKZOkHU5F3jAKKrBEuE4AWnlBMVsCnEme3WyDY+clGAtDn180/jZTPF9EhRfKF4
	qCTk4IEKtFH35L0m/TBdYXa44Y3oNMOr1g+NUrR3HHiY0LgoouK1EXp8P37bYV1+96Gj8LQZE8R
	/OSPq6NiZ0HWMqJL9l/w==
X-Google-Smtp-Source: AGHT+IHgUi6j/vR98IfxIAMRLvGFafv4XiQ2mXaRJzZ2yxwA6p6KyPV9EoArZQE91ncYnPKtNT+S7Q==
X-Received: by 2002:a05:6a21:3288:b0:35d:d477:a7d7 with SMTP id adf61e73a8af0-376a75ef3f1mr12678919637.7.1766450188602;
        Mon, 22 Dec 2025 16:36:28 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c6a80esm106804295ad.8.2025.12.22.16.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:28 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/25] io_uring/kbuf: rename io_unregister_pbuf_ring() to io_unregister_buf_ring()
Date: Mon, 22 Dec 2025 16:34:59 -0800
Message-ID: <20251223003522.3055912-3-joannelkoong@gmail.com>
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

Use the more generic name io_unregister_buf_ring() as this function will
be used for unregistering both provided buffer rings and kernel-managed
buffer rings.

This is a preparatory change for upcoming kernel-managed buffer ring
support.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/kbuf.c     | 2 +-
 io_uring/kbuf.h     | 2 +-
 io_uring/register.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 100367bb510b..cbe477db7b86 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -718,7 +718,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	return 0;
 }
 
-int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
+int io_unregister_buf_ring(struct io_ring_ctx *ctx, void __user *arg)
 {
 	struct io_uring_buf_reg reg;
 	struct io_buffer_list *bl;
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index bf15e26520d3..40b44f4fdb15 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -74,7 +74,7 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 int io_manage_buffers_legacy(struct io_kiocb *req, unsigned int issue_flags);
 
 int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
-int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
+int io_unregister_buf_ring(struct io_ring_ctx *ctx, void __user *arg);
 int io_register_pbuf_status(struct io_ring_ctx *ctx, void __user *arg);
 
 bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags);
diff --git a/io_uring/register.c b/io_uring/register.c
index 62d39b3ff317..4c6879698844 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -750,7 +750,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 		ret = -EINVAL;
 		if (!arg || nr_args != 1)
 			break;
-		ret = io_unregister_pbuf_ring(ctx, arg);
+		ret = io_unregister_buf_ring(ctx, arg);
 		break;
 	case IORING_REGISTER_SYNC_CANCEL:
 		ret = -EINVAL;
-- 
2.47.3


