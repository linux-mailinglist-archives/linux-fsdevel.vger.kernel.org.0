Return-Path: <linux-fsdevel+bounces-62443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADECB93B56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46ADD7AF831
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B71A23A9;
	Tue, 23 Sep 2025 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN7ChBlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E931922DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587642; cv=none; b=pPrjA7A7JWbsw3dFLed561dr91PCk6s+VQWoJI7Ykju26Uo6dt7DX/z3x+vsasHa5FH+K/vbqy9UGWvDPZVM8AQGJ4RnBv+I6JOeteeDNNl74ZtKo8igOnR1VP05KWg7/f0CBtxNYXhj8LJLpdcG0D2fpVACqYJyAMUrtUXDDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587642; c=relaxed/simple;
	bh=s6mhJfy1wLr9wwae+98XWped88EO8RR6Rj9hVh2fPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt2Y2rKFuNNrPVRZgDcRpD125UisLCCBkYW/7qH46/8ea20IGfMyzsDwm2hRfXHC8gNKjyrAIjwybRgI7NbAjVa96hICcg7QYMSDt+TCefBFrgiOX9Xr2bTzWgqo8YF/8HlRcNJ4WV6+qorEV0DVrhbFuCxnEvAJpxjouM3hmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN7ChBlc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b54dd647edcso4945959a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587640; x=1759192440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=WN7ChBlcUcvD/CuQRoDxSCYlalJJ0DWmeKGqx3nWwxcEPN5o0l1AokBao54AosjfRq
         pUxz5TGfwIjDQR5z79NA+rf78aoBYW413W1trtClWZhZQ1NS4JlZfjwPApjo1O49Mc0f
         3ppRXqdrRYAbwGRA8o6qUrou+9LK7Wj9jhPGqpCnkR/JWtl4HKr5mjkix6upWxacvkL+
         jiXjX1INuAlVoF4l8F9moRa+uALWv4UnUeFjSMdSl09YyyQgQuuH9V8x+8VVt3/JC3Mi
         wdWinT1jC+EKoPCy+/x22/H6yNDU19r+sGI81Of9LeqsLuEmJrT1zFyDY2BVd7uhHFNS
         9pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587640; x=1759192440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=c/KhyjKxj8vLzOn3R919Fo85AtHLOXYQyS7Yi6u2gVQNA8SKqRDGGq8198OtEkbfqm
         v8iZedjjRrKcMaMc77iw2zmtZYItE/5rHu8y5WA+79Db0dApVbXJhTh2WWolTpUo47Bk
         qE5gSY4kR5SqQHcVRqaG+pi79CDYJuJc8OtT82/xcGWHqJg8CxtkebZI/qydiL0ht7Uu
         LbhekcZ7TZSKzpyyRWJVsfrFf2v/TDLOL6XaLbh3h+7WyFsrj0N7M4XCdn0ro0e9mObE
         CNcZpzvBgQn3EHkrVa7kYyd7IhFCjVPLHzVoYIBw/S+9vEgz/coYB4Qp4w1zQihCskQn
         hWEw==
X-Forwarded-Encrypted: i=1; AJvYcCX7q+XuNGf2EGBClLOpmTqERbFuxLHU40orgaADGmi0QPWjW9/UqS1NwId0DUD16gk6qBqwRKQ0TXVh6OYq@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4VoifLMbji8Kf0l0voek6BT56ZGH9pu65IAUWWLs2vQGg0de
	6E6P3FJkzr3qiZeh3O0o6+pyxR1kmNSTSiEhzOSiKt06pTZbNPW15pupVSmvxA==
X-Gm-Gg: ASbGnctsRz5Kq5wYQOYQ06Myq+HHqLgUQ8v1YPd1SyktuTj7eir/eZrCmD/JPZl8qN1
	JAZIVlP0OYubSfxABKaK8ltSWcLSWR2hPY52Kfkz2YVkCpatXgefWjbIQPLaKcPoL70of3/Tk9a
	1kgVLk56eOzsq0GWax6hs6XBA8b7bovO2SchRKktxEZjFE3e2PUZv63gojDK0V87DsbNV+/tDc5
	/9Yzm/W+FPmMP1JNOgWoYNmrd5h5BVbbaOHYXgurcwczH9ioQqFZrzA6Sxx7RpOh4hD0BX/QNTE
	Jalr8RPQWd64J3VLR/zszTs0Gk/1mtAlDOqJ0xS3M4KV46HeRDVtNyQeLGXOLGlI77VeZLWgQnB
	3cEfKJbj99TDXNAMdDRet8O8CJL2/F1g5YSJNvmyS7XmQbjbR
X-Google-Smtp-Source: AGHT+IE09TVUGqvhRnJ0j5/kebD7MODetqdlA1rNkjmRk63jDyjVyF8TO49tFsaKOOBbleAow9Cquw==
X-Received: by 2002:a17:903:1209:b0:24f:dbe7:73a2 with SMTP id d9443c01a7336-27cc580deebmr7891545ad.31.1758587639758;
        Mon, 22 Sep 2025 17:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980180bdesm143588125ad.56.2025.09.22.17.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 05/15] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Mon, 22 Sep 2025 17:23:43 -0700
Message-ID: <20250923002353.2961514-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dbe5783ee68c..23601373573e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -422,7 +422,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -487,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -521,7 +521,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3


