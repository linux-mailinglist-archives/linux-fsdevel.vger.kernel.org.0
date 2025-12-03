Return-Path: <linux-fsdevel+bounces-70505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E3C9D6B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FCD3A681F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3221ADA7;
	Wed,  3 Dec 2025 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwixbHac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19123F431
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722209; cv=none; b=uV3ZAg4ploxDjwNrfYIafo241wOABQ7KDJzjkojJFdz4tOwyAqnFmSEvJkYzvdMbHSj5zfh0bfaeNjIRZ3sKdxYAKXy0hsqZom6/T/U5rwTG7v2RAah4q/nCaysIE/71TULIZuB7wy9QkRZESKVcdyLI7ssMg8SEWz5Iv8FR570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722209; c=relaxed/simple;
	bh=ShsPwaa79sbU4M2ZNWao+BTPNiaoXLHlnrWxkhIxQFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZog1zWekoaDu88HFt/VRk3w4O5wAI/kO4i9lJFGiVioELQ4fDdDRRnX7LGWlALaRJ6C9jstyK70oK37a/tIPOFs+XQotyGF6sG8YGtQY7Xlr2yTaHyuZnYjF0wUDQFmq3BZ2bbtfmdmZXH8KmBNUz10/aNHdXxHL1TS6Qlb4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwixbHac; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so5451725b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722207; x=1765327007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+lXe1UbyArO+9gy/07dcLXREZ7CEHk9KPUjbt5UeiI=;
        b=GwixbHaczrqBr0yPINal+Bn689mfuoxgjvYxHKexoO7Cypi27CvOUZHIYkZy5EkOoF
         e4Jz3+pPxZi/VOLYMz0eJKjw135SRuqNul9GMEfdHl0bJx1y+mch3m5WiCC/a7z99Mtz
         QRWBMYQ0GUMT/cznoedeqbTKYW+jlj3xxQ6I4qdSt9kQaMEwSBdkjJDiGM9RnC+BhpdP
         mJHwTcVQzRlMA7Ql/8xyTDE7UIFJROxO1JXFOHw8Fq6hOVVVZW6Jg4rhxQvD9cuy9FQC
         6CtHZvXH0gXABr5nO1B70Erjpe+bLrzvMfnqPWGbYy1Mc84+7d+fTmdQ6PP8nwZSLt/4
         J9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722207; x=1765327007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+lXe1UbyArO+9gy/07dcLXREZ7CEHk9KPUjbt5UeiI=;
        b=QkR940Veo2IeDQvRyyZcDJFd6Fu4H8ZIg5eJA21K5quZAzf/kB6hwBsLz+X56Pnuy+
         tkY/Lg9mzJcBkBgVrY+kk84P6HD2ItAi4L10RguD0ntQsnnAM94XU/AtHT3y4/vuLKGC
         U0YRGElbT1szEOnUA0+Soh9wuMfWCE7vfcmWCuKh5+TRw5336JeU7eHhaTd6SIgNkYXw
         gzm1KeWwWs0gbHMYgb61UYT8pn+oMpxGeWK+zjAeXGDaPEyGm27xKHyuDkMBrmfKM3kG
         OcYbT8ezRcolsRoR9PsZ3gmSz/v5ivVffymx6c4eVQcoNuYdYwR5Zm/Jb7+xp8Yz1V0m
         +8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuu+jOZ5e/a5l/YjhS/dzIcs4yiKvUOVEglp9GoCx93OMBloxvNRQZqSnT5p5eBK61nJZ3dO+N3eqDQXDw@vger.kernel.org
X-Gm-Message-State: AOJu0YycZVmB3YzDbFCb30enCVa1y59Z6CjkMMTDCQDuQyL/UdO3+euD
	zFt9OIU6AbwenvGZNyGi9asrf1obkSaZb9IioS1cax9jEvOeDw3Kf1Y/
X-Gm-Gg: ASbGncuRIE59b62ievNwR2B58mfOQ1ObaJufV5lDfLLiqvJsqzeyyLYmJQosFSbryxS
	1Ea+7eQ3rgcv/xPRW9jagO+Vj2Un3GelIUKSPuayRU6hC5udxEy7XnzpmBhMBIT3RwL8VWDHbSM
	d502EjLoalo8aI4cL7MUl1ao2YdAQMz9TtuVQdI+A07BRAm7FTB8Fv7QymVSPF63JQjyo6khXaO
	fojPCyhnP1IroHDVKWmo7caYaC24s0Ia9I4wvcutCTpBNWIrwht98h+gX7zhiHpe6KwH6CzzEA2
	nTASGtVhuC9D+xULe0TaRtvDuQPoSnkwFHHxmDCxIwAiy1isb78VVhFHjmCsI/qxfFIoaOr3FMT
	iUHLQQ6thnJb+imx1z9D9T/OSOaOgIwqhcihWmAxahxTc0Zt3Z16IaaTq4qECJNJOVfm59LY538
	MIs1q6h7Yhl5NmcCd1eg==
X-Google-Smtp-Source: AGHT+IHGmXFRYmNYu4mG5FEegRAmBVj6PM5FVTftWbC9NdYNznU0I8s5pAIlTgPC5Uk/by9n4hlm/A==
X-Received: by 2002:a05:6a00:10d3:b0:7b7:631a:2444 with SMTP id d2e1a72fcca58-7e00eb72335mr387471b3a.22.1764722207504;
        Tue, 02 Dec 2025 16:36:47 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db416sm17921048b3a.41.2025.12.02.16.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:47 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 11/30] io_uring/kbuf: return buffer id in buffer selection
Date: Tue,  2 Dec 2025 16:35:06 -0800
Message-ID: <20251203003526.2889477-12-joannelkoong@gmail.com>
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

Return the id of the selected buffer in io_buffer_select(). This is
needed for kernel-managed buffer rings to later recycle the selected
buffer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h   | 2 +-
 include/linux/io_uring_types.h | 2 ++
 io_uring/kbuf.c                | 7 +++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index a4b5eae2e5d1..795b846d1e11 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -74,7 +74,7 @@ void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
 /*
  * Select a buffer from the provided buffer group for multishot uring_cmd.
- * Returns the selected buffer address and size.
+ * Returns the selected buffer address, size, and id.
  */
 struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
 					    unsigned buf_group, size_t *len,
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index e1a75cfe57d9..dcc95e73f12f 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -109,6 +109,8 @@ struct io_br_sel {
 		void *kaddr;
 	};
 	ssize_t val;
+	/* id of the selected buffer */
+	unsigned buf_id;
 };
 
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 8a94de6e530f..3ecb6494adea 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -239,6 +239,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->flags |= REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
 	req->buf_index = buf->bid;
 	sel.buf_list = bl;
+	sel.buf_id = buf->bid;
 	if (bl->flags & IOBL_KERNEL_MANAGED)
 		sel.kaddr = (void *)buf->addr;
 	else
@@ -262,10 +263,12 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 
 	bl = io_buffer_get_list(ctx, buf_group);
 	if (likely(bl)) {
-		if (bl->flags & IOBL_BUF_RING)
+		if (bl->flags & IOBL_BUF_RING) {
 			sel = io_ring_buffer_select(req, len, bl, issue_flags);
-		else
+		} else {
 			sel.addr = io_provided_buffer_select(req, len, bl);
+			sel.buf_id = req->buf_index;
+		}
 	}
 	io_ring_submit_unlock(req->ctx, issue_flags);
 	return sel;
-- 
2.47.3


