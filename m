Return-Path: <linux-fsdevel+bounces-63102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01398BAC226
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE2A3B878D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE72F3C2D;
	Tue, 30 Sep 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S0GnEO4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC991D5AC6
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222402; cv=none; b=skqgg04kX/OM6EEXz7rv8najUpIkXwO4rgj3sj0pHUNhG/kdWpkspEN7wHmm+8t2/BJ+yT5XiGSnW1Fy/AdoGb4obsf2snlNQyTvduSYu+z0WNDv9OBM3rMtBA7b36QAVWPegwfjwXjK6voMzIENk+dRisMPInU63qkfGqNl/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222402; c=relaxed/simple;
	bh=sZDob3vWh+jop0knTkusaN6A2zdaiXsjxBW1umO0yTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kr6rLWmi4NW/AuVR4lKUh6xcasgFzRdbx6n9Ry9g3LizwUVKUIiK8OBQBg5iZ2Q1vNs+Clfp0Hzu+/CvHK34kPSQ5/X451EduADZGORFiUBYYr4dQJBfS0OoXKzXN4xd1nwt4b1XOdHRGx/ld+vRJgOsTB2lyaD61NiIKflrHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S0GnEO4Q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-28832ad6f64so25704515ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759222399; x=1759827199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7GS2Dslu74Y6O3sSZ4T6xHpLOfCppUUkahr66vSZyM=;
        b=S0GnEO4QJoaTQzpKm47vV6JI9m37cWVA4FjWxQoniJj5teLs9cRlNMnax9DxfGpSO0
         gOMExKlVMpB8Tp7gA3eRz9fMO5mtogi7xjJM1gFM86WlCfKfQsQ0f76Wwpr6KSX84I+H
         KwmVs5nFGj/b0ZJjoBxnVQ/OcmS36/6Jcre7CWzd6dJ/bSpbSCrr1yWDhZNgX0IxnYs+
         3HWTbaU4gS0DNwB1+sbgdYSXmj42OSVInB32V+LAeqNN3YJM57FQ3xUTaGjSb8eMda9c
         IB2tYbsoLYVGfc+VolAJOF0U3H3yZW7O9wMA/ECWYdbQP1fpf0/+3q9i9678+arJVJ+m
         hR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222399; x=1759827199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7GS2Dslu74Y6O3sSZ4T6xHpLOfCppUUkahr66vSZyM=;
        b=RnOzgXZeH7x9TMWBrY81Zbkle5NuJnHOZPSjLYLTbhiEQU0fXCREfm00KnlGFo2hPR
         u9ahJvGHa1WFN9EKKCbXM8x5cCGt3Rw5Hb1ihZgmfVT69ivS4heCCsMJVhDnC/cq2SJt
         TF5ILa5qwBDZI/cNstgYQFQQ7GLlMwqk8e3cPqJcVA2zOOQnqCDQ99SnM0AGXWRTmW8F
         Ilg5w4bG93Jy6aamPS6GYW5rENWCFTpGDVpspHZcudAv11W8Phlc9BcI59JVrOwhbrav
         bkI8Ozlot8MgWoxUT/0ZaGHfwsV1N0ryBjv0u+BfoZn4ysUThPHcc1UgC19yF4XNiM8N
         f4rA==
X-Forwarded-Encrypted: i=1; AJvYcCWJAC0/eCWixc5yECJWojnsI11rDuOo63LYvQiZb8LzIbEegazjQjokLBR5ORb7dkoHfQuUu4rd9SuIel+i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iIYX2C2Z38ir8P6Tiyh2RshLIw336jwTy1TXSH3fuRlLue8h
	GNWBuTBRxfWtWt21/rGxgrmXVHzW5msoVCLCUcM7rjkRFXeZKSkp818hufNTxIQBePo=
X-Gm-Gg: ASbGncvifeJxe1Er1ZUVinxuhT5Ae8y/BdnGYK+oIDsjob7jdbkjNWZh1UWJDM+KFbw
	YFAPGnllx3CUTQN3gdl0ON8wUmjBcTqJnHuPjbCLTMfMAIkSDWZ4hlfiQmVnq8XxlofJPnZKAjz
	8ZxsKLzCCNaYvSvgh6zl1aPtK/wdZshzHuYNhd2poOCUqm1MaF0I4EZwbgg8xcgRkHeTg6uK+kw
	/do1Ji+njewr9qfEhGPslxXz48YHjQCI3hk/akwueS2gNAMy02kRlxnsOwY/EVejnXK+mku1BdD
	eOAB9sXZbOlWGa1jyuc3iGw6SKB4m8NwQQLHE+n3GF00kM0w/o4k/w4SeRI03yteLPRxD64e4Bf
	5mTwqoL1gT5Uos8+mXLdLalrWgNxGl9PAKR3E5b3Kvtxix8qR/tt7maxoMRicquSdQlrW
X-Google-Smtp-Source: AGHT+IHFd1cdCLciI0565+p5aem94H033pFEtfvFQAouv6zxMqatMLyWLxK255hiApByIAqvEBa5Xg==
X-Received: by 2002:a17:902:d607:b0:269:b6c4:1005 with SMTP id d9443c01a7336-27ed4ab09admr197534695ad.55.1759222399264;
        Tue, 30 Sep 2025 01:53:19 -0700 (PDT)
Received: from localhost ([106.38.226.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac94ffsm151734825ad.136.2025.09.30.01.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:53:18 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: sunjunchao@bytedance.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v3 1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
Date: Tue, 30 Sep 2025 16:53:15 +0800
Message-Id: <20250930085315.2039852-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930065637.1876707-1-sunjunchao@bytedance.com>
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
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
 Hi, the previous patch sent unupdated code due to an mistake; 
 this version is the genuine v3.

 Changes in v3:
  * Fix null-ptr-deref issue.

 Changes in v2:
  * remove code in finish_writeback_work()
  * rename stamp to progress_stamp
  * only report progress if there's any task waiting


 fs/fs-writeback.c                | 10 +++++++++-
 include/linux/backing-dev-defs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..40954040fd69 100644
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
@@ -1975,6 +1977,12 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		__writeback_single_inode(inode, &wbc);
 
+		/* Report progress to inform the hung task detector of the progress. */
+		if (work->done && work->done->progress_stamp &&
+		   (jiffies - work->done->progress_stamp) > HZ *
+		   sysctl_hung_task_timeout_secs / 2)
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


