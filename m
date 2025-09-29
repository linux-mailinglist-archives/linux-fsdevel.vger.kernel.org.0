Return-Path: <linux-fsdevel+bounces-63029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E288BA9343
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 14:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56FA189EDA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E176305E2B;
	Mon, 29 Sep 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YXG1iHvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAB305E28
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148940; cv=none; b=gtAlSBrG77TN2Hi13rGxxYvAszjZI5jknuX2SoHJrbdy21qqlexCkkSGFd2FcMPG7HSIjl73KQ3IjENYpwFiJOOFOLQHFTRC6i/Czt5yRLucZDZtOwqlA5Y+hFgVRSdaOkmwp8Fobnydj+0W8aPQw+Go1Arg5Oj9qxhxMd+xEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148940; c=relaxed/simple;
	bh=g2XmJxwDQzQdK+NxrOrzd+vK6OTBrFPRTsRdOEKhjyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hf0Ouwt75/KY5OYbo1lwywNAEk3Wtj6UR2VHcGw17D1ujfQqXN/es4zEbeAjBIOjMat7uvsvv1Fsa4k+V3CMHiTFQwpQwKAXi2LHcYMztHO5MQRJ4Iww+U7hf+S+M7Zh43apKCoWcYFlpGWv/ygRWyB7QUcb/nedYw/DFjRAwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YXG1iHvQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so5422587a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759148937; x=1759753737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJHIlLfZ4lwxh1W2ixFXNzEsFB4/AFiJvopm4eoQZTk=;
        b=YXG1iHvQLZRzhOEb7TJBj71PEgzCzxKufi7Geq3KhNeBrOGOTntR3BsI04ieezIM60
         +hnfdk6OV+JT3S4DNmAWvf/35VH60KDw3XjRVGpJEJay28Dhg36Kw9ddTqxwxjNNHQ+p
         UL1sxgNlZsVVxOpDaHVC16wWvHbGqrzHIHhu1e5JpEcygRFHjSp3AqXn+6FapS+XtcEi
         QObwHN/qmIVX6ayun+Iyae5pVkWvQE/1q3EH+bkKbggZTgoQfswtqzfX9sy+sZnGDrg8
         LGKWYeP8au3GYIPUnNBDdBk48CY/kLqtRG016fivnsGtCStBcomkduGgjuNgeR6sjcF0
         t78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148937; x=1759753737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJHIlLfZ4lwxh1W2ixFXNzEsFB4/AFiJvopm4eoQZTk=;
        b=FL19fIS/1k2YsztYx0yA73QbzpnK/cUtQHMaZG/G4Rh4ne56VwVPK5isONL9ECMD3K
         t+MevcYd/zLpd9w4y4QS6nDpJOHQck8hHwUjMOOyXflZ394+7MWdkwGwNusJ6sC9N1xr
         s6pOT2WwM9xV8AZxG6JWOYGE7jB0KbvXEwAe7pOGZNt/yg258k4yICevyQ+FTiEj3D5K
         1pghsOOYtcWQTmNkB1iaPkdKKUA93nbuCC0cLSWLp8gKLrHp/paGcvS8rHI9yR4E8AQx
         x4VzmQOOWyg8itHFU+YEJBNS+BPHFdCFsNnuiIhxBHR/jF582eccqdAnihfk6L+KHF9v
         8k9w==
X-Gm-Message-State: AOJu0YzRShPHUqAK7pWlL1KHKYhF0qrHPfSFwMrc6S6AhTNfEmfBUAcu
	FFP/6bwcGbfzQMGDC4VSKk9s8bhJCOXsF2Z6Jim1JFvJh9pjsCuhZ/vLtJ3W1ePBm6sTFH/OxaI
	BnEMMmZk=
X-Gm-Gg: ASbGnctWrbzSOfLi9IBPbjiRmt6eIZn54/z/DA6I4ZX9mCWNQQFm8y9V0SH9k/kiGVZ
	AlbBeONWpPAjAPhB+ipAEQzUDpJvu8b6pMOPE6uwUvOJU/mxY8DHob9XkOLPZFUlmvfdXj2SViP
	b9AtL3ZqxW7ttQzsUZVMxEVjWEbFSKAEpPNtNmCVql+hwH9kgtb8KHvGqqyNVCm2A01elyyfX8r
	/kMiQJ8IxkZK1DjwVdus4FhibIsFpir6qiRforoPDNlMbyaoV8tQRBZGygNGYDKSOyTpw6d0VlK
	nrh9c1t9E5eI59u/1al4nJ2AxcCzb27j5GGtXdcOkiqHAGQP88KluaWTfGkfR3lk4bSRcEfhvvT
	YAxIxPOjRCITWPsSSPVyAtucYWAIZ5AWH1Pn6/fO1I/0=
X-Google-Smtp-Source: AGHT+IEPcReEV36//OwVgGr+uXKogV03Xobps045ZwOuEW/UoUIm1CK5bd6a8fyNk+seVBVUIB4F7w==
X-Received: by 2002:a17:90b:4c86:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-3342a79339cmr17434154a91.27.1759148937354;
        Mon, 29 Sep 2025 05:28:57 -0700 (PDT)
Received: from localhost ([106.38.226.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33838712bc2sm1138435a91.13.2025.09.29.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:28:57 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com
Subject: [PATCH v2 2/2] writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)
Date: Mon, 29 Sep 2025 20:28:50 +0800
Message-Id: <20250929122850.586278-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929122850.586278-1-sunjunchao@bytedance.com>
References: <20250929122850.586278-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a writeback work lasts for sysctl_hung_task_timeout_secs, we want
to identify that it's slow-this helps us pinpoint potential issues.

Additionally, recording the starting jiffies is useful when debugging a
crashed vmcore.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 Changes in v2:
  * rename start to wait_stamp
  * init wait_stamp in wb_wait_for_completion()

 fs/fs-writeback.c                | 11 ++++++++++-
 include/linux/backing-dev-defs.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 61785a9d6669..131d0d11672b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -213,6 +213,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
  */
 void wb_wait_for_completion(struct wb_completion *done)
 {
+	done->wait_stamp = jiffies;
 	atomic_dec(&done->cnt);		/* put down the initial count */
 	wait_event(*done->waitq,
 		   ({ done->progress_stamp = jiffies; !atomic_read(&done->cnt); }));
@@ -1981,8 +1982,16 @@ static long writeback_sb_inodes(struct super_block *sb,
 		/* Report progress to inform the hung task detector of the progress. */
 		progress_stamp = work->done->progress_stamp;
 		if (work->done && progress_stamp && (jiffies - progress_stamp) >
-		    HZ * sysctl_hung_task_timeout_secs / 2)
+		    HZ * sysctl_hung_task_timeout_secs / 2) {
+			unsigned long wait_secs = (jiffies - work->done->wait_stamp) / HZ;
+
+			if (wait_secs >= sysctl_hung_task_timeout_secs)
+				pr_info("The writeback work for bdi(%s) has lasted "
+					"for more than %lu seconds with agv_bw %ld\n",
+					wb->bdi->dev_name, wait_secs,
+					READ_ONCE(wb->avg_write_bandwidth));
 			wake_up_all(work->done->waitq);
+		}
 
 		wbc_detach_inode(&wbc);
 		work->nr_pages -= write_chunk - wbc.nr_to_write;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 1057060bb2aa..a92a223bdf3d 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -64,6 +64,7 @@ struct wb_completion {
 	atomic_t		cnt;
 	wait_queue_head_t	*waitq;
 	unsigned long progress_stamp;	/* The jiffies when slow progress is detected */
+	unsigned long wait_stamp; /* The jiffies when waiting for the writeback work to finish */
 };
 
 #define __WB_COMPLETION_INIT(_waitq)	\
-- 
2.39.5


