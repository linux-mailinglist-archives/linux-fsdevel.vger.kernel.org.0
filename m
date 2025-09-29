Return-Path: <linux-fsdevel+bounces-63028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD56BA9340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 14:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E632B3AAB91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C8305E19;
	Mon, 29 Sep 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GilWMrLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF130595F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148937; cv=none; b=X9CSZuV8+VGzF2xhh2104s1G1LHrhCEBRQRSiQFpKIgJMCMO168U5aUqHFaQ7SkWkUQzkpNmQYkHp7LLPFzzgfeP4BfEPI7+qx36h38cpno5y/lX2kX0s56o+FI1HGdmMtIrRnfboKcURtk6Jp/2cDrtiU0Gp4UzOv6pSNwniAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148937; c=relaxed/simple;
	bh=4w7hURAgfa6khnlQyJKLIZHjBrB6f+z8WwPxrkKcFgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YP/4z0kWfavQzHXPFjQ8vMl057gUoA1jBvbWLFum89sCmEekpmz3fnr7jQig/QF5vdN+NSbE5M866b4L6xRFBUpLM+ReHEoMBmwuvdBW4hX/Uf+WIsjjlfvUiQLRuQ5kRV7wOSuKAnw/LAnBsHfAXCDhWzl283+z7ydM7RY7so8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GilWMrLs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2680cf68265so38923515ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759148934; x=1759753734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zpXMwycwdf22evh/sN1ctk3Fg5PkEy1xM8qPjYeLD8=;
        b=GilWMrLsK1LfiGeo0hANvTqgYcAGjvrNnM2V2jzpib50+wxDmdnBQL/stHWq+U5IfX
         qXQxgmHfZ8qcqZMhz3qMtzdkd30l3eUlhZrinErTIHMteFYxZxxgLxSe+nvCu0D7GpWZ
         ILkdSkj8wVtsOJvVP2UDVW+MOiJpyeiNeDfjxWLLxmbm+ZKlH9xUandjle0hFxN8KTCl
         8RmTkjTbLeFifk3XMRpQGcrDP0TyTuUurdxcn+L8n5krp1lHqTa8GApSkMQZKfkNV6Z/
         geE3WVQZm4XtWbxvW9O5h2E4u+5of1fLj+kwOPntFv5VSNOdxwioPFFOd6DQSe4hZh62
         +RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148934; x=1759753734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zpXMwycwdf22evh/sN1ctk3Fg5PkEy1xM8qPjYeLD8=;
        b=OSbHEnnAPsR7B0sRZykl23uO1l+OoCW8ASKoeTr+HDL7hhLh9tygCJZ19+1fx8bdI+
         XAAsCYu9dJyD06wEXdqE/8BQaG9fvXgfHZePPAeThmseIve4iaKjbi6DifYUfxBzIDjH
         3oyy5szSP2b+oXOHkDjnDqo8PZnHcE0fydAwMG21qzxit7/Fc946gLpPqLaICN3Wod8B
         jzPs6K9x2VEsQfCM/VJRlo8+W3kePjfIYTvxzHeOpfF1j0HdIOmdKdY4R31dp2TLSWQ5
         q5yXj7VkGnM/x+ftIORyfPe3VCf9Zw3HGWQ6ukII7doJI45yWA0wJAtPvSiErXBfQKUA
         32nw==
X-Gm-Message-State: AOJu0YxQyr6uJp51SdyvKawHQkRlPcXLgHW8EH8TGQZd0pBdI4PuX0Tv
	O5VmTsW2VAgzfB5cPuKIQZ6LP6G77J/8UlU4fdkJ+LPnFS3cZTmo4Iu1s/+wHGv04kjaF6EMago
	eaxR4WCg=
X-Gm-Gg: ASbGncuwT+a6sT+yd/CgmPSGRVw68O/YHsEYSFFI6ZQbijtcCUHyL5+VE36On/DuQSb
	olzBh+FrHyQRMCKx2C0KGgZlPOK9a7Lvxnqa4qJZHXgVCbVYmjfAPf81cPlnJCkkGt9ewcsDQ/C
	7BViE8utOEHXQC4WwwsBCdM+CcJyX1v5/baj2i7OYm/DtpN9rVqevC+kqaDi38H0WPzSctyAhX6
	4N07DWDlfJyBV+MC3wHXRtFUecCRg7JHi56iVUlfKZhoJjUZJT/NuQttGhYWPvjdwROT4jVlSbd
	NT7Mj4Irj58dZZfCEOLgOwDwLArkbugnSO9J+w9f4gjLl4ftt1LBxmkFxdRrgpZjqMHIan/Mem4
	IRgN+b3N02AbE0aefA9nFzYRQyLyDhEU0b+IPJ0KpqJJ5
X-Google-Smtp-Source: AGHT+IEaqc0uxukSaaD98604VU3GBYfSXjD4RiHQ58aaMKj7R98IgNgPBA85oHmP4bcu6wfc1XTe8A==
X-Received: by 2002:a17:902:d586:b0:249:3efa:3c99 with SMTP id d9443c01a7336-27ed4acb4f6mr170447185ad.61.1759148933744;
        Mon, 29 Sep 2025 05:28:53 -0700 (PDT)
Received: from localhost ([106.38.226.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6712214sm131400445ad.41.2025.09.29.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:28:53 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com
Subject: [PATCH v2 1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
Date: Mon, 29 Sep 2025 20:28:49 +0800
Message-Id: <20250929122850.586278-1-sunjunchao@bytedance.com>
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


