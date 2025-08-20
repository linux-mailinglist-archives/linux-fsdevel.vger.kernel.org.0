Return-Path: <linux-fsdevel+bounces-58378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EA7B2DAB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479A15C07E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE92E3B16;
	Wed, 20 Aug 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MV0p48cm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9622E11B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688790; cv=none; b=k1dfekad0LuqtPqTDZHLwnsYTioh7n/JsfuCOHsO1cjOy9VfvXGz9ISdoys50wR9SKz6d3Gl/rST0P7rps4uh+9blZAjg8Iohs5tCtTYEEEEMtiqHkoRIJJOyWjEcosZcxBf3suyCsrErTPIKWuzNg/z0CLtU2BOAI801+wGTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688790; c=relaxed/simple;
	bh=hXLqaup/UTK9p2mVp9/xR9s14HjfzRczKFSEI1siwYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOo0OBwT7meYotfRNGKS8O7thS2/ZxSVl9KMGH8IcTQYvUagtFV8CZsEtt1sOQpsOdHhdk0Off5Y7m5EYHZ3egnhurjvIx6zsgavsMvJjj2i0I6IJ/wx+qOAXzaogtQ4gnNLvbpkDgyTZ9z5RUh+iiqIr8OFHTm+X9cKGBU5+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MV0p48cm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4716fa7706so4282685a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755688788; x=1756293588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmUl5kz80SYgDggauq/gcrY9lNJu+BoyJNt4pf6QvUk=;
        b=MV0p48cmBbwH7Sd0duvNterUav5fdWNjI2zkTltPhhGgH+ykfEJcoVsYGS5S3Yx/nT
         Cd+wHknvgZXaLt7oezoOEJzq1oBf8qIZ1mHATFJI5lbVDSZb+AqKdx3G/9YS1m+PlLNE
         KtXQGrbY++XbKMkZvaeLJgyjF1TFAuaprFSqhRoNEee2hMZAaJWkp4XVBqMmG+5GDI9f
         A5OznW85YN2oLou6+XWuQOayh6H0jEwitXGRQTWkxWlEo7kesbpk5UE/mOf/KVh2FXFX
         diOmxNB4GWbiRjXAgJJFMR49uGRtr9yZL9i3/cpBAAbhetmIV9irlPT+IOjlutIEJgYA
         acCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688788; x=1756293588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmUl5kz80SYgDggauq/gcrY9lNJu+BoyJNt4pf6QvUk=;
        b=Zgjn/EdE0HojOxYy8iJtViak9EPIPxgGPedra7Hy7/LHPhppXcTb7ZbNUsv5sQMFV3
         uA31d5c8bRlJIjEMnC5+OeMt7MdXafmvd9aaM+iIZSfURPAgz8+/SLduu7gVs8qdxCsA
         CRPCkd+6ITJawPR/iHF556/4C5nOBVUxLSeXVISo3U5ctA6zZKTvgI/v86ThcyAzeaxg
         XydBzwgEomYC2ecy/RT4NpzXr6oTY+NCbcCCXMHkTwQinMUhJA5HDliDl2zLebXppAbQ
         TnSCWF3vFy2gyDKFuSLAMqTSIqqUdUpQmx7/fqNpYISVhVeVXG7OUtaXdm5Uzg7D+LTC
         JmfA==
X-Gm-Message-State: AOJu0Ywy4wm51G6kxmKz9iNWbMI/y62ai5YyLqMcI2c2DttV2lPKIIdk
	xZKp2YMZel6Z0nOpcM1Jjj0eh4vmkpZPsuQLNMxEN+K5y+hIumNFDsHPy8uaA93y2QHg/1Ng4br
	S4RudpwQ=
X-Gm-Gg: ASbGnctz3DIZCyDbGjdi8JQ6r6zi0vHstRAYwyREwKJ3i0jN8otrcZ8qsMpOCNPqXSL
	3h88CptLh3F/X2uh5Pj1gA3GVxWX8Fyfaghyc8ZVPOTIlsFapWJE+lgHe3RpkJznXWnR/kcJ0Y6
	Ke66ywlfEeIDctKe4MoMLIG+a2PYc6w6MKa1jxPk3eovze2Sv76YG+nUzpwfVgTt1502E8R5uhF
	piaAEdY0hSG/XRDEQ6I7GDbX/0AS/rMtVCGT84KO6N3Kf/ash95eL0UIM6txur964MDVnWyDC20
	KrDG1OmPAwVP8X3IqByfaAgNjiAW0so9GZ+9igCgqq7jLqvEcLseXKjpsVk2Vl0c6G1bNyj/I/2
	AUb/Eb3VUKn5XUKJW7YS9myQtQaS6hIw=
X-Google-Smtp-Source: AGHT+IGXmQtILlfaeO0KNXbpv61Pi7GHyLtGfxlkUeNc5eSE1p9UKZu8WVkmKp1RbNxVnH2+bLRYDQ==
X-Received: by 2002:a17:902:d548:b0:244:6c39:3361 with SMTP id d9443c01a7336-245ef238c60mr29969545ad.44.1755688787898;
        Wed, 20 Aug 2025 04:19:47 -0700 (PDT)
Received: from localhost ([106.38.226.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed359300sm24062325ad.39.2025.08.20.04.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:19:47 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	axboe@kernel.dk,
	tj@kernel.org
Subject: [PATCH 1/3] writeback: Rename wb_writeback_work->auto_free to free_work.
Date: Wed, 20 Aug 2025 19:19:38 +0800
Message-Id: <20250820111940.4105766-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250820111940.4105766-1-sunjunchao@bytedance.com>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is to prepare for subsequent patches. It only does
's/auto_free/free_work' with no functional changes.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..4a6c22df5649 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -48,7 +48,7 @@ struct wb_writeback_work {
 	unsigned int range_cyclic:1;
 	unsigned int for_background:1;
 	unsigned int for_sync:1;	/* sync(2) WB_SYNC_ALL writeback */
-	unsigned int auto_free:1;	/* free on completion */
+	unsigned int free_work:1;	/* free work on completion */
 	enum wb_reason reason;		/* why was writeback initiated? */
 
 	struct list_head list;		/* pending work list */
@@ -170,7 +170,7 @@ static void finish_writeback_work(struct wb_writeback_work *work)
 {
 	struct wb_completion *done = work->done;
 
-	if (work->auto_free)
+	if (work->free_work)
 		kfree(work);
 	if (done) {
 		wait_queue_head_t *waitq = done->waitq;
@@ -1029,7 +1029,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		if (work) {
 			*work = *base_work;
 			work->nr_pages = nr_pages;
-			work->auto_free = 1;
+			work->free_work = 1;
 			wb_queue_work(wb, work);
 			continue;
 		}
@@ -1048,7 +1048,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		work = &fallback_work;
 		*work = *base_work;
 		work->nr_pages = nr_pages;
-		work->auto_free = 0;
+		work->free_work = 0;
 		work->done = &fallback_work_done;
 
 		wb_queue_work(wb, work);
@@ -1130,7 +1130,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 		work->range_cyclic = 1;
 		work->reason = reason;
 		work->done = done;
-		work->auto_free = 1;
+		work->free_work = 1;
 		wb_queue_work(wb, work);
 		ret = 0;
 	} else {
@@ -1237,7 +1237,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 	might_sleep();
 
 	if (!skip_if_busy || !writeback_in_progress(&bdi->wb)) {
-		base_work->auto_free = 0;
+		base_work->free_work = 0;
 		wb_queue_work(&bdi->wb, base_work);
 	}
 }
-- 
2.20.1


