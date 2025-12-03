Return-Path: <linux-fsdevel+bounces-70506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966CC9D6B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 588F534B033
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382821CC60;
	Wed,  3 Dec 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbnNp1lZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F452417C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722211; cv=none; b=nMiFGMqx/1XDjVSuqNjaeslxmrURatgf+r54Essn8dWHpnHUgaylFCXphADiCF2bG/k/fDVFkHOjFIXWaNImQSX0W92TGn0X1TffEUPJmnf6ab3sQC9HeeCYXPTPFLOloTOiZNOnnIDEFxEs1VoJvHqg6IlEmWYXJNUhbdytMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722211; c=relaxed/simple;
	bh=afoyDzoiPk8LpuqO1S+0owVvKfZJf7DjSxtapBSXLJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVVaU5wZmj2U73GsjNrMSA7+f+19kg3vKsXs1hWFDcYuByd8eaH5SgQD3GN9EU/N+AGltQG3KWPMbtNkBh7OmP24sz6xelB9DQHDkPtwzDt9X/kzZa1WgDo+yBdsM3f2Phr4m1GDhqvAxhY0ydvqBlsrR/u14aemSzzf/JgIIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbnNp1lZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so7575346b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722209; x=1765327009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIn+I9DWZGks0gL0wMu6vEBklTa1TvdGkH3R5xpUwHU=;
        b=nbnNp1lZL9tZy4CmZ/iWHEi9eTqt3B91uDVF5MUWo5pWrk4A/RMqyT8GGgMyEEqmfI
         RIayu1FCYWKLtRCf+A93cQxmTUP1w5SgZtrPh1reDPzRrXgMXB86dSq3yHGDc6W0kpNy
         9FUD10Qn/0CGz8y4DYG2FGZooxHCbce1vJTvh/UICafarvHZlrll4tcAGIilPqkNNn9C
         7FnVZ+7IdI7JgWodYMl33hrRxtoXN4QuiVC3itQOWR7YBixyVregl/2HXa0yWWrcSUKG
         mb+MPWuTea+ZawN6HTZlDbDYRmUILUTIqdxmIPZLDzRAeUySgUop6lR/ChVh6Gg/7C/L
         7Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722209; x=1765327009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIn+I9DWZGks0gL0wMu6vEBklTa1TvdGkH3R5xpUwHU=;
        b=KpbrUdd6kmayfT3Bv8VRZ7bb3lhTyQDcKenBQ3UIFGSnzvqEaQXkkpU9iKNyJzHRXJ
         sPaqlN9TgCGvdgs10X9MKo9woH6M+yImYHp5cv0bI7I8BGOmskqsrOCcltSCoz43pGFb
         uchB4IAV+Lq3i56E4TV6hZIBSOwuED0FkVKqHYxePWQm6WkP+SmepA+RO4M4p1LowSYp
         cchFTEurvoOnTrtLnw8oPwGZL3wRDeQWN9m22BAYPwk2RRsCI1d9ybCv8YKqybRmhqN2
         fJ7b2Wus+MzmKywSrhBKyCVMRU6oBeUVGEA8W+uGjAMHfZBbVt+Vpn/CiRM1m8jmIKCV
         6v8g==
X-Forwarded-Encrypted: i=1; AJvYcCVdVjHIYB93Jp8Mikcn5i1LGgtc20fF1fDSFaT+NdBQaeGINGtt+0Hg6RhMZl+TE9YaGq0YKgT62b6FeWjz@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPoAaFLMeqp2QZobYrXb7hblJSupvleLkkitNF+objn2yrxJ8
	z8DcnSXHF3P5jZf9Uewb+xcop6PKfdEGX9ZbzX4DtFubIxAN3csEHQ59
X-Gm-Gg: ASbGncvgPCoLaG0UCbUkK1OP9jA8C+Zln991KaNXl1+o3FOLO76E6BksBNvMfx6ivRc
	j3LfajGfKJcCoxPwVrP3kmj0g7yf6u5eSfmnFVlnaKHljvZBv1Vsu/oYJElX7cDnF4y7ItDMA8c
	hd55yR/3uz6A5g7YoUpP3piQtD//Ub2zcN11Dw2WSpa1wbmW7VOemVv4CBcTVl+aJgkbAPBRrFx
	t3obsdfN1WgFurmgB9EGB1mjJjbHABORahI/sy/7lMvl1+E8CGpfB1HPbMuDmYib3M+xlE7bo+M
	PnahklLxunz32lR6amEdWqkZvu66SzMsWvidPIB9KdJ7Q8iumH5m9buTty6AbnGCAKU2KpflgiE
	vxVcNEjqG79UnPQGJCG4e3ARRsUo8bhDcc8KM10Nz0LD7BnL5MjH5SS5kP3B+29p9J2CZmI4pCv
	xhDqo7dqhrYha+VKCF
X-Google-Smtp-Source: AGHT+IERKuXG4e7N06PKcTxod714QF67phubaFnfJTjNtHhlJZnatgwWOnZQ6YIUfoV+7JgMlRp2hA==
X-Received: by 2002:a05:6a00:2e20:b0:7ad:e4c5:2d5f with SMTP id d2e1a72fcca58-7e009830ba8mr505675b3a.3.1764722209114;
        Tue, 02 Dec 2025 16:36:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fcfe28csm18106859b3a.67.2025.12.02.16.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:48 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 12/30] io_uring/kbuf: export io_ring_buffer_select()
Date: Tue,  2 Dec 2025 16:35:07 -0800
Message-ID: <20251203003526.2889477-13-joannelkoong@gmail.com>
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

Export io_ring_buffer_select() so that it may be used by callers who
pass in a pinned bufring without needing to grab the io_uring mutex.

This is a preparatory patch that will be needed by fuse io-uring, which
will need to select a buffer from a kernel-managed bufring while the
uring mutex may already be held by in-progress commits, and may need to
select a buffer in atomic contexts.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h | 15 +++++++++++++++
 io_uring/kbuf.c              |  7 ++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
index 90ab5cde7d11..2b49c01fe2f5 100644
--- a/include/linux/io_uring/buf.h
+++ b/include/linux/io_uring/buf.h
@@ -19,6 +19,10 @@ int io_uring_kmbuf_recycle_pinned(struct io_kiocb *req,
 
 bool io_uring_is_kmbuf_ring(struct io_ring_ctx *ctx, unsigned int buf_group,
 			    unsigned int issue_flags);
+
+struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
+				       struct io_buffer_list *bl,
+				       unsigned int issue_flags);
 #else
 static inline int io_uring_buf_ring_pin(struct io_ring_ctx *ctx,
 					unsigned buf_group,
@@ -55,6 +59,17 @@ static inline bool io_uring_is_kmbuf_ring(struct io_ring_ctx *ctx,
 {
 	return false;
 }
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
 #endif /* CONFIG_IO_URING */
 
 #endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 3ecb6494adea..74804bf631e9 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -215,9 +215,9 @@ static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
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
@@ -251,6 +251,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	}
 	return sel;
 }
+EXPORT_SYMBOL_GPL(io_ring_buffer_select);
 
 struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 				  unsigned buf_group, unsigned int issue_flags)
-- 
2.47.3


