Return-Path: <linux-fsdevel+bounces-70520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88CC9D712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D471234B11E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4040231A41;
	Wed,  3 Dec 2025 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1kfGTwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128E264627
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722235; cv=none; b=lSqgIbXgF7LurqrG2jz2dGDyi7fXtDmmjMoSwDEYods3aZPzV5a5pPcjMjlFkKysqS/3J2qSO0aVQFyS7EYM3zEknJMVlvXumK1a7IiFUAK9XbbvmivcIdIm3g2C4BGf7KqnL4bBLjvY3pIatwi4Mbr/hRiWOggphsaknEmq4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722235; c=relaxed/simple;
	bh=NteECKVIVVgYKooISthTyycJwAldk9Y3xjnTi0eeAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJsve8ZB1TC90T4blACqvDMqeu33Jq7WlUH+KKQxgoClDJV9P4bK/IGgq2UgAcRak5wV5ZUqx0t0GxGC+QGxyiOAAbnPcRrSFqt5HoJz/webgVIMSuyhLs2YOp1r4kGkm7fYTifK1MCYla3mRugh7Rjawd/+AhAutZTvltUQi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1kfGTwL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so5799747a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722233; x=1765327033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hOnndXDYjC07Cd5bj8P769YKU3lF3tazToIcpHTmgw=;
        b=Y1kfGTwLnk0D6Ie4U3TyJlJqvZeUmxvyD1tpEJ3C0GQRl6NX/KahZdJ122XWt7CJas
         CpJ3IuhaQ5kSMtjT/9ipaFQHuHg2g77mTnjYrMo+NWz+B+MyhGCSEudlfIMSvWrYIiFf
         vavccI/h/sbcEBVoJwKBSUPACjuIkIqo5Y6Po9pki8SfIOTwBgXMFXlsTjus3nvFLHYm
         ebgHhXuI6zURK3eNH5geJ9CM2esvARgoor2MOGJagf/oUA4SbU4q/YAwSzPoA5oJoVVH
         Qnq33x+Eb2M+Kt6UJwG8Vah1GmK8Jy55jTjKE0Tz+Dxl6sGLi3zM0XGrhpfbHg0plAZb
         e4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722233; x=1765327033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hOnndXDYjC07Cd5bj8P769YKU3lF3tazToIcpHTmgw=;
        b=onGP7F5u+3TXIyEs4PlRcmiwbh/yGlVlx5l6On035POclk9VSCLijcifsX9xlBfXcf
         ajE3ohtl7zjpEkyfpoT+llyOVp5Im0Ox+AYemxScYxf7PHWnbbAHZZZE4I/9B9pWQij9
         JjtGVo94i9VZxfOChwsefEFMEhnd5ybQK9Euk+t/uO4Z7bPi1LhBPXZxr7OKu0fGis/E
         3RVq5ySaNNEliEfsFC4owyUPNrUYlOR39Y9PZLQt07R9koLFABaGIpV+cxLUEGmOjcD/
         9Zv6FfMQs0LDBr2dvTWN+lTRl/tBb0kWsodc000LerJzO6j8SSj5Od7zHXv0JufTOLPx
         zYAA==
X-Forwarded-Encrypted: i=1; AJvYcCX4NnoIhnqLf/ZMseqiejzZYbqtTd3Ckri5Tg7fl8u5i2k39MyGFRYOOwkwMEzd2hO5/g6eD2AeOVtOuYzT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5wR1s2kQycK2bmrSSS49Ls+gJjmXmBn0ydXzoc/Hv0OG/fNS
	cIArGgnAyVYhwThG579qbgGc7RNe/wsJ+ENu83HvKlzNVCTg03kQ1UCO
X-Gm-Gg: ASbGnct+maINYzkLQPWqLVcQaF9UaBplcIykUPT44Vcax4grTMuyFrwPNlZDEk/0kn9
	PFOF72d4jxgfobEIsR6rz19uxm3TQlOkweZI5IMznC1DkX80MTQ82zBOjivK4lO9sxQtJ4PxUEG
	n/WYmLDlufAavKYjtzejkf19+MGH4O/uzJtEe+TB91pm5s8LspIhVoNYae+06FC1+Y5moNTFP3s
	XrfyYrUFqAt1IHbpVZ8JcX6lcjpYqkcg9JwzlSeDEuZrCRw5sckl8JcPyeEkaSdrAAlCjhIvDGB
	o4awN3d0DhUQ5SyT0qkPYEi9ZjJ6+39X2iNHhIytAki83xY3i9s6/1EWP1/rWGECFUzutgk6alU
	s1NpTW+PtPIRf0NPz3tGJdixXJUtrgzO8hS2AuxaIqHen7qZISViy2EqREBeoLBfAE0DOiD+sjR
	jv/3kgS9BGvQHhWEukow==
X-Google-Smtp-Source: AGHT+IEBZ9bJnnKX7zklgfezY86cmHLETX/f0CSmcbvnnK2PAAoNq/3+pM5i3ocWedTdgBWDmIGkXA==
X-Received: by 2002:a17:90b:5445:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-3491284b104mr571398a91.35.1764722233222;
        Tue, 02 Dec 2025 16:37:13 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34910eca7easm596212a91.17.2025.12.02.16.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:37:12 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 26/30] io_uring/rsrc: export io_buffer_unregister
Date: Tue,  2 Dec 2025 16:35:21 -0800
Message-ID: <20251203003526.2889477-27-joannelkoong@gmail.com>
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

This is a preparatory patch for fuse-over-io-uring zero-copy.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h | 9 +++++++++
 io_uring/rsrc.c              | 1 +
 io_uring/rsrc.h              | 3 ---
 io_uring/uring_cmd.c         | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
index ff6b81bb95e5..078e48b63bff 100644
--- a/include/linux/io_uring/buf.h
+++ b/include/linux/io_uring/buf.h
@@ -28,6 +28,8 @@ int io_buffer_register_bvec(struct io_ring_ctx *ctx, struct bio_vec *bvs,
 			    unsigned int nr_bvecs, unsigned int total_bytes,
 			    u8 dir, unsigned int index,
 			    unsigned int issue_flags);
+int io_buffer_unregister(struct io_ring_ctx *ctx, unsigned int index,
+			 unsigned int issue_flags);
 #else
 static inline int io_uring_buf_ring_pin(struct io_ring_ctx *ctx,
 					unsigned buf_group,
@@ -84,6 +86,13 @@ static inline int io_buffer_register_bvec(struct io_ring_ctx *ctx,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int io_buffer_unregister(struct io_ring_ctx *ctx,
+				       unsigned int index,
+				       unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IO_URING */
 
 #endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 7358f153d136..08634254ab7c 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1075,6 +1075,7 @@ int io_buffer_unregister(struct io_ring_ctx *ctx, unsigned int index,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(io_buffer_unregister);
 
 static int validate_fixed_range(u64 buf_addr, size_t len,
 				const struct io_mapped_ubuf *imu)
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index d1ca33f3319a..c3b21aaaf984 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -95,9 +95,6 @@ int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *rq,
 			       void (*release)(void *), unsigned int index,
 			       unsigned int issue_flags);
 
-int io_buffer_unregister(struct io_ring_ctx *ctx, unsigned int index,
-			 unsigned int issue_flags);
-
 static inline struct io_rsrc_node *io_rsrc_node_lookup(struct io_rsrc_data *data,
 						       int index)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 3922ac86b481..dfceec36f101 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/file.h>
+#include <linux/io_uring/buf.h>
 #include <linux/io_uring/cmd.h>
 #include <linux/security.h>
 #include <linux/nospec.h>
-- 
2.47.3


