Return-Path: <linux-fsdevel+bounces-62732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90271B9F8EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6E44E5898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40BD27E074;
	Thu, 25 Sep 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UB8YPAFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537E23E229
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806569; cv=none; b=Ojr8VCsJGFWhtEZIvXWBX156949g9wc2gNDwNwsSRpUM39j3XM3nBZlKj9dCRjyaxyVFLBJu7kWc72zxF9bREaMmmgYl72S/Zi2IVrh17gSOT6jYmhsaWYdItb7IErWojZXxRd6IMbBC3wGEJgFBWQvJ5cP+la2dvuagVsqNVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806569; c=relaxed/simple;
	bh=Z+WB0ZnZCu69iCmrEvyL29/LatGlWYKUQFrdnpn6ILg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lRk1bTSrhD/0vvZSW4SV9vGCP8APCPXyyDgcMlcT8QTBYvXNKSGh/rluKQ5F/Ftqz+wt87w25fku2L5Jv+2hbirBV+cehTN49sH0k6RNTRu4LdVgcM2qlYMy/d0qaqlJYxmuDZhJliftrM54ySIj8wnCTQOesFXfx1U65Ypurmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UB8YPAFk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698d47e776so7896785ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758806566; x=1759411366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gkQ7W9GP3kTBDbgiFHXC4UUxdEAInumXHbT+0jlmLk=;
        b=UB8YPAFkN3sDdvOxDnNqnLDmOLg+tvOwEkI7yDsFR2lNaNg+iguPyP5QxTDw+KfD+j
         HGHD5+5fyoZv3eEByQJnsUiXW/e/Sl/fj2c0HTZ0bi3gcVkKPk7FPeevg3Y5U03xbE3+
         8CKbEMD1Tfy4xnwTqBoQq5/OI05n+CIhD9hAX5I/TOPgO+zjh/tb9d9gaxSZHfmvcZPm
         5w25MsMuDMg6BIttoJG3uZNtZctM4Q8ibl+usrio+LAUfc568TmL/V5UdGchPbyRbmkC
         Fbsmjol9zfyUYL33AwSVsrLEQlZ1EgeElE4tm6gyAEMRWeue4v7mwwGJsuw7nZiYmTJt
         2GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806566; x=1759411366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gkQ7W9GP3kTBDbgiFHXC4UUxdEAInumXHbT+0jlmLk=;
        b=PmfUO2MPZnD8quZOj8qIGfHaCm5uVg/0FGJsyBKP20kELTRS+m/71xTy+4pgA72AqC
         q1XKUCxv9mequ2qIzkqns7l2d2AZYZlWo7BFyDvfSXi4tgUGizma19ke+kPG49RTq6md
         S2vE0aUMqrbIcnjDpobYRpZV8kiprgdbt+zhntQLXa5aO1xVB7K5IzODKxv+qnUsBmwW
         m83TxL6FYzG/xhJL25AOQdJ5wjQ29PGFocHWA7ym3gPbfaInILMrf+TIsCg9apBTZgBf
         35RLO0MFMzz+TqDSK27sL2yvzRciHXKqQ2hq+48nQwcQHotQUpWkihpY47JJNHr5/3cR
         nElw==
X-Gm-Message-State: AOJu0Yy2fM9hemcu/1w9TcNdlJ1TSdtYh/cMNsmi+3Wg3cP4AJ0E84bZ
	2EehzIdizbDDiQKgDU8OlYRn2BMZsGatpZDMUjbg3vUsGlvv507lqBK+FSaZ6N4uyW6X5+oH8Wo
	FvtnqgJKUUg==
X-Gm-Gg: ASbGnct7AyJqticjl/D1B0tLRYNXvIzmjW/HjS7eXAbwg1RLctAEcvnYlUHhP5wbeIl
	4+EiosaMlaf2h79oYPj16+iFiq3PxCvSxRJp8jnbWKT0SdDJQViKwDtoDQ81MWTBEXurh+ZOua8
	jjl32Z/OupcOGfz3PSMRn5wbkuUIluors4Qq7ZBpvrhzPwSNvlCv51/QLg39nlSVZMvl5xRWpPD
	LODzR3Ayfv4Ij+bYlgHlnq58+NX4HMD1fDT0ztGKnEzkmWnflxWg4HrNCDXqlcEmQ4yP8TucRwH
	fLzhGQf/Yiuv6lG/CqS9DHWdL//UAUNd5Uf32+zWxfkciayO5SfqZ9mlbsRuyQ3PBC26J2dW5rl
	0J3v1k33cEgnw5vuhDgT0yjFKkVaJIa2h31++KqNysTQ=
X-Google-Smtp-Source: AGHT+IFC+axddSGsGdkXFlYQAfB6Ta6IVOJOYKAwDFm2ec1uilzBxRxSsXLEPzGDIgGZIfnlxUVbHw==
X-Received: by 2002:a17:903:110e:b0:266:64b7:6e38 with SMTP id d9443c01a7336-27ed4a47150mr36101165ad.46.1758806565800;
        Thu, 25 Sep 2025 06:22:45 -0700 (PDT)
Received: from localhost ([106.38.226.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf9desm25840855ad.6.2025.09.25.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:22:45 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	peterz@infradead.org
Subject: [PATCH] write-back: Wake up waiting tasks when finishing the writeback of a chunk.
Date: Thu, 25 Sep 2025 21:22:39 +0800
Message-Id: <20250925132239.2145036-1-sunjunchao@bytedance.com>
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


