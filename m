Return-Path: <linux-fsdevel+bounces-32645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578519AC73D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18104280FEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25331990D3;
	Wed, 23 Oct 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEh/vWY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86A1487D6;
	Wed, 23 Oct 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677641; cv=none; b=j9tZKX8Qie/pi8eas5Z3KbYmsDyjsiPHmeGaX5pr9X0lgMCUV8CE3KZZ+e5YW8AW9uSubp+5wJUYv/5sH6zIzjeF9tkhrm5fSvfcBSkezP5C4xF80XCezedKB/j6r5mB0zox3wwMLHMkBGcM/KZYKLdqpK/JCNxL7+MPXaBT72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677641; c=relaxed/simple;
	bh=EWIifRhFr+QZl2BXrNNgIcv45sargA9oNnK7MjVJf/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orWCetW0kLhWNw++9KwmpuSvbzC7cdteH0Qdj8LXmAOxPQEgXmzzlCo+sgCBl+0D1adCxo0M657bglVnAnQW5xfrJUUJSMriMhsOYV9e16uvhVNx+JevbK4xgbPUrz1T+LxHRxei/6y8VSZxSqFsEf8qH7CjaZO7AzPP56c/kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEh/vWY3; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e983487a1so4760294b3a.2;
        Wed, 23 Oct 2024 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729677639; x=1730282439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KSQE6SQbrKXZnPv2r6mQCXvpZn+sFkfLG+STLAgtJ1s=;
        b=ZEh/vWY3eOXQGsVOYIlCetKmsVJYgPC9eimrcLT4Z1me1fdBHz7FQdrPWppgWJL+zA
         e/yuSC738K0FEA1LyYwSBKCO4zJ25S1tp9P8zZWOY1b3cY54YV3RWktqXZtdko9YOTI2
         Li4ovNhT6srRJYd/jz7WqW54mSYiWVkCeVgOqJqlufjxbAEZYoS7XuUuHXIkI5OsNu2p
         gL/9pZYVP0oquHRhcHmy0/JnpOvPPluZcovbyfUUZqmAS3dRp3cuHW4BV8FD/UhFiAwU
         SnjOg7TB4Ghz8AH/40GFlmlBdcad+GZZVUydpWJCaBFRy96B8/GU1WTQeA1c7okFuXJU
         z9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677639; x=1730282439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSQE6SQbrKXZnPv2r6mQCXvpZn+sFkfLG+STLAgtJ1s=;
        b=DlejbB46pz3SplbyMlG6kHO16L/8U7lC92WkTVa+myMY6dyrsMINjK4tYfQYZGVSLL
         TX4YTFJEfN+BdPDqwzlAZWWjZuMW9KDxci0ZZ1vqQDEZn+4dVOALayEcl5yehmGZWOLG
         5Y7SQdJLupditQ9OXubJZ1kKbVMni3OfKIgbQnzxiaZ8tPomp8gjLCE8iYtN4lY8NSTM
         WAR6ZcZ1prgZlJslfY2bNP+bia2Ze/bqhqw5pXOMFKKU/jS3GO+KQy5TEu6YAVXvivfb
         Pya+5jn06+lYIMyyzRIXdKuhpmLJnx1Te5EKIP7+QMF2ohrI464CVsE+WAZnJX89RUuf
         DU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXiv09hfgjgIUnEGl2chirNOwE/jsjrzyQoj2IawK262CMfupS+x/ZAtFJXqRycPZpc1xmbl1aZ0w9zhHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMQU9PSVwFLmHugL2Qw8WD1jrBgOBTrGZ/VRtJFRdqJGCqWZg
	kRobJDOP+0H9lEUysBXAIFMLi6yBjWi7jl4Bjgi/mC0zZkNVZEV0
X-Google-Smtp-Source: AGHT+IFPcgWD0iVBg1dYapMOvCPbQ1/TT72U4Wjg4YR+NdcpBagP3VTSghprJ92B59k4x8IJ9+x8gA==
X-Received: by 2002:a05:6a00:1390:b0:71e:6f4d:1fa4 with SMTP id d2e1a72fcca58-72030a4b659mr3027019b3a.10.1729677638895;
        Wed, 23 Oct 2024 03:00:38 -0700 (PDT)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d74cbsm6033316b3a.138.2024.10.23.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:38 -0700 (PDT)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jim Zhao <jimzhao.ai@gmail.com>
Subject: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Wed, 23 Oct 2024 18:00:32 +0800
Message-Id: <20241023100032.62952-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the strictlimit flag, wb_thresh acts as a hard limit in
balance_dirty_pages() and wb_position_ratio(). When device write
operations are inactive, wb_thresh can drop to 0, causing writes to
be blocked. The issue occasionally occurs in fuse fs, particularly
with network backends, the write thread is blocked frequently during
a period. To address it, this patch raises the minimum wb_thresh to a
controllable level, similar to the non-strictlimit case.

Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
---
 mm/page-writeback.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 72a5d8836425..f21d856c408b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -917,7 +917,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 				      unsigned long thresh)
 {
 	struct wb_domain *dom = dtc_dom(dtc);
+	struct bdi_writeback *wb = dtc->wb;
 	u64 wb_thresh;
+	u64 wb_max_thresh;
 	unsigned long numerator, denominator;
 	unsigned long wb_min_ratio, wb_max_ratio;
 
@@ -931,11 +933,28 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
-	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
+	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
 	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
-	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
-		wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	if (wb_thresh > wb_max_thresh)
+		wb_thresh = wb_max_thresh;
+
+	/*
+	 * With strictlimit flag, the wb_thresh is treated as
+	 * a hard limit in balance_dirty_pages() and wb_position_ratio().
+	 * It's possible that wb_thresh is close to zero, not because
+	 * the device is slow, but because it has been inactive.
+	 * To prevent occasional writes from being blocked, we raise wb_thresh.
+	 */
+	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
+		unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
+		u64 wb_scale_thresh = 0;
+
+		if (limit > dtc->dirty)
+			wb_scale_thresh = (limit - dtc->dirty) / 100;
+		wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh / 4));
+	}
 
 	return wb_thresh;
 }
-- 
2.34.1


