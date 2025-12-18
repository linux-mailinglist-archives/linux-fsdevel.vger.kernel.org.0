Return-Path: <linux-fsdevel+bounces-71637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55799CCAF6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA9F30EC2C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD93331A5C;
	Thu, 18 Dec 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWqUwnsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1032ED59
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046892; cv=none; b=osXI+J1bJSRmIfrfbpC2tGUlGOO09Tvg+6Y7YTQc6DChfWFDvPURm8U3+qIJNKxH9NFYfylBLHPyh1RAu/m6XjYld45rfwbUnrzegT+3fIdquneloMiUeTJOYFkUbdfTwOr2TP/D0TmhbZA/IZXoaUo+QsyiEH2hxSvu78p/MhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046892; c=relaxed/simple;
	bh=DCNKP3+49vhsf4cR8h81Amd4timhDqQ6YrmPdGVutew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RShCux+nQMK8MKz80Xb7bLiqRAlM8dwoQy/N6aHDqzFTVAmk/KCIo983lvj5Hbx2mLXVkal7TmB+bA+AZlScEIZ9CGhLXLCthS40qY0LInQI8xH4S0oloMilACnZSKRNkAq+0P+XWYIQCQY+FqH8xLdWTfCMifJiwpa0YXtxVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWqUwnsF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso445602b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046890; x=1766651690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKprIPw7Nh5cga4NDcCgZlBnpUXee2i1WiaSjB0Z+Io=;
        b=KWqUwnsF2yn/EWrBIRam4taQP0nea95NeG0UgMEweU1MPRrO3wZL8E6Qckme2tV5al
         LUCBR2XYLUQcb0NznW/B7C2Beauw5avDtbqOuSOyPGuH9hSpPwKh6a5/RrRkKLZi5ll0
         bR8uEehr7W3BsA8YlO8hjeyb41fhrJbbJGuQ1EAM5u+ZACB8M6R2r0lOuXP7e/ExLjum
         rEGDxwqB83ka4j3neo9xCN0gPhxzddwg225r9jRBtUQTf7HcXSpfIidSpU18dwlEuou/
         1jDFItn6xB3X0Jm8HshX5NmfO2T6G1G2vUnrC9B7R6vkN14uVDdFaarcKgHWZd3Krr5I
         fGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046890; x=1766651690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKprIPw7Nh5cga4NDcCgZlBnpUXee2i1WiaSjB0Z+Io=;
        b=um8nC5BS4UaM/LL9K8U/lc5ub+FWeOEfAFobjpekNQyos4AXtx+Gclp29YidYlBv5S
         GEp7Envm2t9Ap1snnecCv75MTVt62isjd2ZEMvvW0Hb8jxUABXwjEX3I3bDbwZOpvg1i
         TwCMTs/Y3DDRFNvLyRKYwgo/FMDx93r+HcXznMSSUHN7S9gS2fPF2GF5KhG/y4vjzG/B
         Kv8e2I/qQQA+AgDMuKW2WgrJIaVi3tO8AX4tvDCNzQbPfrKtVnHhMTlBEQzvQblQSdv5
         OuxCTaE/1W43tT17p/y85PQWXoMFgz4KLuAL3lHPNcFlpl56fce+ODxSF2VxA1Uj3BL8
         zXSg==
X-Forwarded-Encrypted: i=1; AJvYcCV0S8aae1+dg++moPXAiMjuxozdRIZnGGVFKhOZgkJRdaGgIl7Ev9+3EdC+xPLLm4KhFXLa0fnJj3wjF8Lj@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIryuZXiSP2d2JFMa9izKI2Cl8LJbGC0bISRTnBKJldaQmwna
	LYy1yWwWXu75fjR0YqKPvIdrwGsFomJqw5qMiO2/KppBhZGEUkLbtg0N
X-Gm-Gg: AY/fxX4RrKcE4djIOLQZlPY+nuBipuQ2LaORCc8p4pGIrl5WDJ650u3U3j4ndVEG3L+
	JpqWL5HPRKkG507e/00aJ9Vs3OatnLBAtQlp9DJti+L+gRJC726N11QZ9Kb74kXIntCl4zIZQ0f
	tkFx+HmDjsfsDFAHDD4gBRKE87xuA7iHLjArgNyxYw6FJ4A0VohwiCgui/ocXdeQuLx1YeFbTKn
	po64/EG/Om+1wLG+t9v5vaFG+3h2xb9zfmN5PAs76fLum0M90GolwANDF6dOdO/qa/k2K7n75AX
	sAiCksHkkc++twxF9fIRiz06CNN/ZRJwgsAh+t/O90algIpDfoOrSVBIxgZw34Hu5IUJz7s04oN
	1r5UYxQGiHgBEf3YAIJc7rY6AADa94b/xCXbATTj0FmqJ8AbCEgendz8TZ0av5rACvqmtrTYBZQ
	DopwLwiSGujJFlPBxiDw==
X-Google-Smtp-Source: AGHT+IHte06w8cL1HeOcpUCOZlyCXvbS/uuDeFFFjpbIG+jyu3TxHkiTYZ/vWxynMjKc7Fc8r0nbSQ==
X-Received: by 2002:a05:6a20:728b:b0:364:14f3:22a7 with SMTP id adf61e73a8af0-369b6ab05aemr20561282637.42.1766046890234;
        Thu, 18 Dec 2025 00:34:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d301e592csm1595484a12.28.2025.12.18.00.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:34:50 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/25] io_uring/kbuf: export io_ring_buffer_select()
Date: Thu, 18 Dec 2025 00:33:04 -0800
Message-ID: <20251218083319.3485503-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export io_ring_buffer_select() so that it may be used by callers who
pass in a pinned bufring without needing to grab the io_uring mutex.

This is a preparatory patch that will be needed by fuse io-uring, which
will need to select a buffer from a kernel-managed bufring while the
uring mutex may already be held by in-progress commits, and may need to
select a buffer in atomic contexts.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h | 25 +++++++++++++++++++++++++
 io_uring/kbuf.c              |  8 +++++---
 2 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/io_uring/buf.h

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
new file mode 100644
index 000000000000..3f7426ced3eb
--- /dev/null
+++ b/include/linux/io_uring/buf.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_IO_URING_BUF_H
+#define _LINUX_IO_URING_BUF_H
+
+#include <linux/io_uring_types.h>
+
+#if defined(CONFIG_IO_URING)
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags);
+#else
+static inline struct io_br_sel io_ring_buffer_select(struct io_kiocb *req,
+						     size_t *len,
+						     struct io_buffer_list *bl,
+						     unsigned int issue_flags)
+{
+	struct io_br_sel sel = {
+		.val = -EOPNOTSUPP,
+	};
+
+	return sel;
+}
+#endif /* CONFIG_IO_URING */
+
+#endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index b16f6a6aa872..3b1f6296f581 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -9,6 +9,7 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/io_uring/buf.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -223,9 +224,9 @@ static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
 	return false;
 }
 
-static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
-					      struct io_buffer_list *bl,
-					      unsigned int issue_flags)
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags)
 {
 	struct io_uring_buf_ring *br = bl->buf_ring;
 	__u16 tail, head = bl->head;
@@ -259,6 +260,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	}
 	return sel;
 }
+EXPORT_SYMBOL_GPL(io_ring_buffer_select);
 
 struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 				  unsigned buf_group, unsigned int issue_flags)
-- 
2.47.3


