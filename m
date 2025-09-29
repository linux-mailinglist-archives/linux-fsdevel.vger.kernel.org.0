Return-Path: <linux-fsdevel+bounces-63001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5744ABA899C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92EF7A738B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600212C0F64;
	Mon, 29 Sep 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bIKjmpAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FA29AAF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137790; cv=none; b=dl0dKC1JodntD77dPcxKFJUjUO8xFVDIjnvNlPSc90+o0m642vF2TrpUQTD+tFcIXpxQ6f5xQZ3q/kV+7vwNJ++FfWEipH5UPW4hRbzVfA8FZjXHAIWxgSUNKmh+99Q6yjhfoSxPGKv9JKlibXHj3qJl+xrU3kNOOLSyeHsHrfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137790; c=relaxed/simple;
	bh=1YggO7OihELgT79u9I8E65hdl8AIFfAm07zmQv+aOfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBIK3UwKao93z7B8VfuUabWLOaza+sbA4Ls7MQIH43AKXrUlcXJyPvUzUfV34NlXHxWSepp6TpRZemtyn7C4iuJmTA4S9y6GzjiG6kYx1d4UOp9sl2PYq3pLACjRS4ndY3Ynck8XY4+Pcbptl4JADZvudbvoMspKmAMFdIn8y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bIKjmpAa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b57f361a8fdso1795861a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759137788; x=1759742588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzjPo65cxLYpEK3Hjlxv1zJc8azjHQuUeAyKRYFZOwQ=;
        b=bIKjmpAaNVHu5M+VDBlZ7VMsLiZMF31PX5mYIh724xkjfHbarE4D5XQp56Yb/qqhym
         YwpoYfGbUvDruVFbQMc0/GcXUGNX1Uz4/IPZT2ruayrMmKsSbJuOpBIN+GwgvuCr/5xW
         yc0+XF8Iqba8xFFOpB81Lab85qb8mTcHIub+t3n6lPNbV/LTa7CJg+hKnCXFyaVZ6BcT
         P98LGaPwf23c2vnOErHmj94UNVtGN80xfnlJomxhVcNWUTHsSt0dx9Zi/M9mD20dQ27s
         bmDO9n9FBe1ZsBadaBfQtrRmBOEuq7tW38xKliIy4fZXTVkzOqNJU7tS+9wyfGxIUMv4
         4PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137788; x=1759742588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzjPo65cxLYpEK3Hjlxv1zJc8azjHQuUeAyKRYFZOwQ=;
        b=KXT7dg3yM1o4GtDANUVjT2ESkYW/sa+zkfIWkyuo6jwJueK6k/1QZ3BxxIfDAS96fd
         S6hrP75crCHRNkpiAqCNbenZTD3MbQERSF6vsqSRSSdVi+QGyOXvG11bhXkKrVItT1jO
         1iE7JmAghwIHzzzIrW0Ony4IaTG8SJ/XcehIXdMfsmm/+OMLP+JbauYHtbDfKfs7wBKK
         4lFlqs6aoami1Q3xpIFyx4ZwP3vIugn60eItFQUlPsRQCMPVlXR6Qu1ReazBnLY8hTgj
         Y1E63ophtJXiSXjjF+qiFJjDYdNDwPxJ3HA7vyXTAUYARDJvCoeiS7td1BT+UL5xcT+/
         mLhg==
X-Gm-Message-State: AOJu0Yy17gSL7XAQ4CVtbxz904mnHOiabyaSLCAA/WoLWfJay/d/dTOb
	F3Y4y3/mczOh5gQ2sEo56U6judAjY6mRz2G7tZ/qdQoc/Wbtvr3bcY7mBvDI2+sntYRNkE/b6Tg
	D2gkulY4=
X-Gm-Gg: ASbGncvvwnfE+tBWOY0llyPChbpWBAan7Y0yQxw8goYRMWo3iBWLTAUSB9xMB3KacOx
	+bXRblcokW/tkVwPPJSd0GhOX+nadPo8s2AIMJZZxAq1h/Wn4PvkO2zX2Pl+QXg1WpmRF1YS58L
	k2daZorax0hhOPx4x6PlVoyXgUriK7ghm+TEpqjxrIjALtuLZ6HSstAX70+ygb/khCSAq1LES9L
	iY/voIj8c4NaBV/cM2VJh7glmTmDJHZrkpCRmlxacLaEWhhKY3DaX5UX/40lQ9zAcI8GeUl+D/p
	JtKeXdy24yyRQEFDbCtF1gj0HIu6tvSuLTNzvD57P4YOY4a6HaqYUtJ9F1/W0cuRPF9doXeT3ar
	W8u35hGu3yXvGW2uKpbYa1Kk5SA8Wmt4RbA==
X-Google-Smtp-Source: AGHT+IGjL6zq3nbFqpLCareQ03AHwRmG2eIHWWDcSr2s2oB0pyMmV29XLdTJUX3/q1vwlw6h+lme2Q==
X-Received: by 2002:a17:903:1b63:b0:269:a4ed:13c3 with SMTP id d9443c01a7336-27ed49df688mr212333405ad.5.1759137787723;
        Mon, 29 Sep 2025 02:23:07 -0700 (PDT)
Received: from localhost ([106.38.226.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bd869sm125517025ad.120.2025.09.29.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:23:07 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com
Subject: [PATCH 1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
Date: Mon, 29 Sep 2025 17:23:03 +0800
Message-Id: <20250929092304.245154-1-sunjunchao@bytedance.com>
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
 fs/fs-writeback.c                | 13 +++++++++++--
 include/linux/backing-dev-defs.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..475d52abfb3e 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -14,6 +14,7 @@
  *		Additions for address_space-based writeback
  */
 
+#include <linux/sched/sysctl.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_writeback_work *work)
 		kfree(work);
 	if (done) {
 		wait_queue_head_t *waitq = done->waitq;
+		/* Report progress to inform the hung task detector of the progress. */
+		bool force_wake = (jiffies - done->stamp) >
+				   sysctl_hung_task_timeout_secs * HZ / 2;
 
 		/* @done can't be accessed after the following dec */
-		if (atomic_dec_and_test(&done->cnt))
+		if (atomic_dec_and_test(&done->cnt) || force_wake)
 			wake_up_all(waitq);
 	}
 }
@@ -213,7 +217,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 void wb_wait_for_completion(struct wb_completion *done)
 {
 	atomic_dec(&done->cnt);		/* put down the initial count */
-	wait_event(*done->waitq, !atomic_read(&done->cnt));
+	wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -1975,6 +1979,11 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		__writeback_single_inode(inode, &wbc);
 
+		/* Report progress to inform the hung task detector of the progress. */
+		if (work->done && (jiffies - work->done->stamp) >
+		    HZ * sysctl_hung_task_timeout_secs / 2)
+			wake_up_all(work->done->waitq);
+
 		wbc_detach_inode(&wbc);
 		work->nr_pages -= write_chunk - wbc.nr_to_write;
 		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..c37c6bd5ef5c 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -63,6 +63,7 @@ enum wb_reason {
 struct wb_completion {
 	atomic_t		cnt;
 	wait_queue_head_t	*waitq;
+	unsigned long stamp;
 };
 
 #define __WB_COMPLETION_INIT(_waitq)	\
-- 
2.39.5


