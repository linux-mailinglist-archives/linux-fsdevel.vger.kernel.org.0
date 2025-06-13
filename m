Return-Path: <linux-fsdevel+bounces-51622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F30AD97A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65E14A0908
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081B28DB69;
	Fri, 13 Jun 2025 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPS9Q6aP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177228D8CB;
	Fri, 13 Jun 2025 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851441; cv=none; b=IK1uM/APUoy51McqPdqtcfWYSJyhxuut/Wd84EOBCAAUCYEVO4Qx1T2ZLyRK+pBwBUhiI7ClRLwSJGpWatNsMNTv1xshlMn50fcPl0tHc2uXW+seEC5cIib4hgZzopwipPiBxjKF5kem6KWm6teVO5bD0IdaPvi6H7Svksy8w+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851441; c=relaxed/simple;
	bh=8xr/HwykQ1QhfoGF7UVHKf7YRBa4KOhhVDnpjaQxhzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB0gakEmtvmeoCEbZ6NC0nIKwW+YOQebsW6E7Fhh6ztZpvj4/+FBAGtGvss6aCOoq47GrfDhHjGZwga9cGqwai//7iMgYOEqtZxATZIdxjslNqrCPRAsthuvvu/LJpTtZredVxOiNaZUGC8tS3lV73Dpuelk5ihelBleo/AcycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPS9Q6aP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234c5b57557so26660475ad.3;
        Fri, 13 Jun 2025 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851439; x=1750456239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y73KDzpJBnhwn4xTA1QJE6n3tTq80LDStiXODA35oLM=;
        b=ZPS9Q6aPK9GXuH2LNYL9aNu5Zm4u7jLiNGLsYPOVid8AiN4OfPG9RBqscBdMU37gvi
         dvhx1+2WPohpyeJ+Y1ik7wWh9sdnhOZN8IsjV+8p+qR8y9Y/slYK+GKxNu31TT4oI9xr
         5jsGPWIicSCp9VPczd6VcNEPqvGcdPcdkc+nurWstbA0cXX8XjnNXS1InN1pvcQjTNQm
         t7SkJk/Dtb7Xi/5YBt+P7Chjo8VI6Um2lE1wPHAUijmasGSuMGPLZUoISOp2DdrArk7Y
         BNVAXuwDQu5lN6218gNjfkErKh70jPxmb83xb0k+oCXwNp+0U3lP3uQWzex0jPnxsQPn
         oHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851439; x=1750456239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y73KDzpJBnhwn4xTA1QJE6n3tTq80LDStiXODA35oLM=;
        b=JsUipUZ4aQmSPN9zbzhYBvAjve5HD5E13BJz3NhdVukRR0m8vcseNK+3YuQYwN60Y9
         C4w40JD7M27wofJrrrO7Qu6Q5lkri9cpnEuMetwyuLHpaxj06v/U2eqcmj3T+tGariy/
         JXdqvclhCn9WbQQul5DgwjVl71vnMcoVqXKpYH1xK1TidHTEwyPw+o4vL4JwnLyLK7XF
         xWIP9iIWMr/qFtyjp/YJCjh+D65C9azGvIUMGfjEDI8ZE2/6/PTXphzWUWZ26VmGI/mN
         6T6b4rB2jeqiJwCJxer5EKKj/0k6tu39TxTXP9dO7NxHj/Llu2SNjr/CF68iURuggvM4
         PNYg==
X-Forwarded-Encrypted: i=1; AJvYcCVxMXH4etIq86DFx98GeUKRIJ770jD1bCnQkeQT3s5Rsk5eK/0asSsDL8xFLMxLUv/eNU+Aedz7zKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8wMpQ+8Sbr8SjwNQ/lAg2+UtxhCAZTNwF0e6vS9BdrJo9rSz
	++JzbimxOqVWTJAZT922B5XTlGTvzOZ4skxp4jYUyD19yKn7WHP1aULnsKFBwA==
X-Gm-Gg: ASbGncvyTstDgdMOKSyg0ShaTgAsikTHIJ7YfS3gjGx5JDc3ATliEwb6w6pmG1JRZfZ
	5jGkUFqP749+4EAAo7pT3lFx8mphwsnmkLPRKRvPqEUjoZf9FocNGXTFDAhyia6uSPQB50w0hjF
	3Lz2bSj3YVI5vmHGa9QoQdGxviqZZEXajFuDnSQ95EwrSPh67qzDllaJIYqI4m2WLtfeiv76dOu
	q9KSD8ft7m+KS5MwuqO36Kgyw3I/knCU13j1OU2u6B1NLNPFBAk/0j2Tz9ujWgrhVBksJrEm2k6
	whf8eR5QOl7weX5EK24FysZZQsXOrpHc6IldOTSJjMOuUU4iZn+00zdB
X-Google-Smtp-Source: AGHT+IE6ZhYEuu4rytXx9qI5mna3nF3qd9zBpt5h8q4jmcQ1dj1PyaR3QEOvjGIOBxDtj0+Tsb00lw==
X-Received: by 2002:a17:902:f70d:b0:234:ed31:fc9b with SMTP id d9443c01a7336-2366b3e35b1mr14999465ad.36.1749851439297;
        Fri, 13 Jun 2025 14:50:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78181sm19608955ad.122.2025.06.13.14.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:39 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 02/16] iomap: iomap_read_folio_sync() -> iomap_bio_read_folio_sync()
Date: Fri, 13 Jun 2025 14:46:27 -0700
Message-ID: <20250613214642.2903225-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename from iomap_read_folio_sync() to iomap_bio_read_folio_sync() to
indicate the dependency on the block io layer and add a CONFIG_BLOCK
check to have iomap_bio_read_folio_sync() return -ENOSYS if the caller
calls this in environments where CONFIG_BLOCK is not set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io-bio.c | 2 +-
 fs/iomap/buffered-io.c     | 2 +-
 fs/iomap/internal.h        | 9 +++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index 24f5ede7af3d..c1132ff4a502 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -10,7 +10,7 @@
 
 #include "internal.h"
 
-int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
+int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 		size_t poff, size_t plen, const struct iomap *iomap)
 {
 	struct bio_vec bvec;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 47e27459da4d..227cbd9a3e9e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -702,7 +702,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_read_folio_sync(block_start, folio,
+			status = iomap_bio_read_folio_sync(block_start, folio,
 					poff, plen, srcmap);
 			if (status)
 				return status;
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 2fc1796053da..9efdbf82795e 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -26,10 +26,15 @@ u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
 		size_t off, size_t len);
 int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error);
-int iomap_read_folio_sync(loff_t block_start, struct folio *folio, size_t poff,
-		size_t plen, const struct iomap *iomap);
 int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
 		struct inode *inode, loff_t pos, loff_t end_pos, unsigned len);
 
+#ifdef CONFIG_BLOCK
+int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
+		size_t poff, size_t plen, const struct iomap *iomap);
+#else
+#define iomap_bio_read_folio_sync(...)		(-ENOSYS)
+#endif /* CONFIG_BLOCK */
+
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.1


