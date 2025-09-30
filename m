Return-Path: <linux-fsdevel+bounces-63090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C9BABB78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD8E189E601
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027982367CF;
	Tue, 30 Sep 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eDq6+kj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA471EBA14
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215740; cv=none; b=Xwptl/PQYGDNxuQ1Ng8IoDNC/WqlA3dCy0tNHY06GyBWb4fdllIKI8XznMGeE0dmCga68M/5jzOtb00F2WLwpmU4NTBrvWonIPxl9OUxanW5+SAF2XwDqmbdjS8c5IbMh4dvoTk/5ZArRvG8tAZUJ7fwNkWDti0J2eKeIZ6WOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215740; c=relaxed/simple;
	bh=vtZqfx5aLNB8FIs5TObu9jAz9+3C8kYeRglc7s2VL/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VY4uj2ynuU5ZNEPdOzQmaJDdPsUKI45rvbPNWqJst7cm3zT7slAADJx9An/bRV8JEEjro8gv99t2hDfFRbs2/UGiCYKpZBYe3BipG2EhSuWb7i1fKgDNuD38PqAqx9Jsumd6qYLhe6nsPjkfabrr7sE+c6VMqfHUakibdII5fJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eDq6+kj8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26e68904f0eso56225255ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759215737; x=1759820537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBwyQ/z4D76upaf9pWlk10o8fDDESc85qDeto4y3UsA=;
        b=eDq6+kj80TVhw1WDaHCKyXbgQKT+h19xAQR634VMHkRMYW5nbZ2h7bCq9TkRF03EcG
         lXrDS2KOC9a4NlVeQAilfxhC+j5Kt76WOqWrO+787hiVfFC8PjbGfd57w+AwvfdM42iK
         hOvl8xTL9+CY02bxsXsHo/vjvnEVZUgEp02EwSXA/UtP1UB/xmez8coH4tfKsbbFwlrL
         RXz1fcreewJjwZT3qlvloEi04FHn4FVE66Oty9pwYLG1BUlAENihmF1BCzldbk5F5q6o
         DM/N8LF4WVrad4Udsm8zqMTf+Zl7gqicPE8GrxLUtaMbdkUmZQegNXa3dd300qzT4x9R
         k0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215737; x=1759820537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBwyQ/z4D76upaf9pWlk10o8fDDESc85qDeto4y3UsA=;
        b=k4dpqSZpNu4Ax3IGgbPSXOO0hAHLwmFGn3mD1QhPD/xBj8GeTyKklQvfAOV9AET+BP
         TgTFx3Qd6nc8vZxrn+T5ZxGHb0gxumiU1g6fFxA+WYZqpNYYxNcAFYlZ8uZswVGxzn+5
         E5rPFCUrDpDtF3SM9Allh56Mcurxbd6GNSmq+TPaze0gEbI9e8XTjpcgTOUxsH9ZhIoy
         i2ix2BjXhA5ccHh8vk4+Xytyld+tnNNSu2tZn6PC7xWY25mhGCBtYi19lH1bB4GhCeTh
         CVMCtrdisrIPxoiD3Cf6k9P8KNEs033tHfHFVB26bL0CjbcZ9Q4CMQc/1Abcp1P+dx7e
         2WCw==
X-Gm-Message-State: AOJu0YyXenidgQuoaCpmeBdzESmmFOY+aoEUxKvwWJZFYPw/rXVH9St8
	17ikIz9xbYKXAyUY3qRnCTk4TsaU3M6HYZxdWnJX2jZpOkKp/+oMdLEdYXLxiQ/jBR3BSvLWVld
	XZpKLIww=
X-Gm-Gg: ASbGncuipzJPKuYEHqjYm+5DbwUAiLZlwsU6drFET4V0qZWwH6aXkJGki3S8J/KrfK9
	zHwlkbdu485ts67DKFUZnAqLe9oYzFU17Fi9+N/v2dJpXueiIzpnViCQ/X0JMgeXZBc4PQ3qk8p
	KqMEKaviL86sNwOhHJFxmlR8q3T5jH7e4StMR/pZjSdHwTOBJANM7XfnDYwjHAPnSURWbvLT6Kf
	CXzQPYueb9Rnqfke4VweCfYjTjEt7q0E9DqbiO6MbeSpdH+EbdKkAoUG8S96Mrn3ke3J1pn7F+9
	65LFkv7liueqlkl0xCnSlnPg5rmJdpv6yzTuSqeT1ebQS5/JGIWTwgu+ZtmhuGFEt6uXNyu9r/P
	mqphXHVnLus30Y6BO1DUuIYQ4bqLgRPI2ItxxntPF9kSUl7fa8fT4dK8ulRsnF+p3Tg==
X-Google-Smtp-Source: AGHT+IHEqC3FH5VudccYGfiiwZUEef4f53nULaclNX1m5iWXOq06gw84MTDIhF9Z8gZ9lbELfdHr3w==
X-Received: by 2002:a17:902:f544:b0:246:7a43:3f66 with SMTP id d9443c01a7336-27ed4a06c04mr215836635ad.7.1759215737009;
        Tue, 30 Sep 2025 00:02:17 -0700 (PDT)
Received: from localhost ([106.38.226.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab640esm150614485ad.128.2025.09.29.23.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:02:16 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v3 1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
Date: Tue, 30 Sep 2025 14:56:36 +0800
Message-Id: <20250930065637.1876707-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing back a large number of pages can take a lots of time.
This issue is exacerbated when the underlying device is slow or
subject to block layer rate limiting, which in turn triggers
unexpected hung task warnings.

We can trigger a wake-up once a chunk has been written back and the
waiting time for writeback exceeds half of
sysctl_hung_task_timeout_secs.
This action allows the hung task detector to be aware of the writeback
progress, thereby eliminating these unexpected hung task warnings.

This patch has passed the xfstests 'check -g quick' test based on ext4,
with no additional failures introduced.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Changes in v2:
  * remove code in finish_writeback_work()
  * rename stamp to progress_stamp
  * only report progress if there's any task waiting


 fs/fs-writeback.c                | 11 ++++++++++-
 include/linux/backing-dev-defs.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..61785a9d6669 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -14,6 +14,7 @@
  *		Additions for address_space-based writeback
  */
 
+#include <linux/sched/sysctl.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -213,7 +214,8 @@ static void wb_queue_work(struct bdi_writeback *wb,
 void wb_wait_for_completion(struct wb_completion *done)
 {
 	atomic_dec(&done->cnt);		/* put down the initial count */
-	wait_event(*done->waitq, !atomic_read(&done->cnt));
+	wait_event(*done->waitq,
+		   ({ done->progress_stamp = jiffies; !atomic_read(&done->cnt); }));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -1893,6 +1895,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 	long write_chunk;
 	long total_wrote = 0;  /* count both pages and inodes */
 	unsigned long dirtied_before = jiffies;
+	unsigned long progress_stamp;
 
 	if (work->for_kupdate)
 		dirtied_before = jiffies -
@@ -1975,6 +1978,12 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		__writeback_single_inode(inode, &wbc);
 
+		/* Report progress to inform the hung task detector of the progress. */
+		progress_stamp = work->done->progress_stamp;
+		if (work->done && progress_stamp && (jiffies - progress_stamp) >
+		    HZ * sysctl_hung_task_timeout_secs / 2)
+			wake_up_all(work->done->waitq);
+
 		wbc_detach_inode(&wbc);
 		work->nr_pages -= write_chunk - wbc.nr_to_write;
 		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..1057060bb2aa 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -63,6 +63,7 @@ enum wb_reason {
 struct wb_completion {
 	atomic_t		cnt;
 	wait_queue_head_t	*waitq;
+	unsigned long progress_stamp;	/* The jiffies when slow progress is detected */
 };
 
 #define __WB_COMPLETION_INIT(_waitq)	\
-- 
2.39.5


