Return-Path: <linux-fsdevel+bounces-63003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89FCBA89A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231C67A755F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596EC2D77E0;
	Mon, 29 Sep 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E5wgB79O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280932C11C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137795; cv=none; b=KQm9euyk7bW6mxNOwu9kILsBYs3txn+neHM95inr4PIOmTR1s5FXUJnwCi8ItBHp+TJXQCDdTa//mOP9SlMGczHpafguY3f2B1zjSAnvrLv49HIMuQjZwJVws49XAfiM1Bi8aRLvWYYAxH8kXrZdmC6m4C76J1MbmyQGnvM1PrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137795; c=relaxed/simple;
	bh=EU7ZPURwV3fdbMpWXNXf8lLTtLw+mVzxuL8UG3bM4Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMdWPAKKND2TrkB6xrMr69iAWifVIXld3PuRP3xNWqxfdIJYGWJoAlZhwNIW6qyRpN3Kb3RcBxKU2YhNoJeVVuhkZTEoh5fvTCCr6mCRheRatc+wjQtCOQx0DgJXyQllOfxEf9ghKF6iAWolCc1r37z55oWqotol55Ye4GUvGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E5wgB79O; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781206cce18so2475025b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759137791; x=1759742591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzLWReN1BAvBg9FhVm3Mn/+KCG9pvGE6BUKxnFNbvcM=;
        b=E5wgB79OOjBr9drb2sguqb204GteHKLSBMrw6pmOPmIWfh4Dz/MuqGI8x9h7eVVR5l
         EU34L9jOJYqjbnEZ7vyb4QHnnmN5aaa6iZHcJ9N3FXUA2EZZlHRh+1DkCf6FHGqWNT9T
         9fyb2bsge5TMSiXN/shnKVQVZjElW76n/uebbYtGnIQPTScR98tqaT6KpcAczCuUGcGl
         CiUbcg9xsQOGD8Amzxx3GdqugkV8IixKggir/xj8QZjS6BwvOYPfjZBiaVzrXMi99ojq
         uxGBHwuYU92K2upESeg0oWuBHmpiWIxHGYuKSjdbiDQHYn0jJ6Qz0/xdFQ311fkgDZ0j
         +tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137791; x=1759742591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzLWReN1BAvBg9FhVm3Mn/+KCG9pvGE6BUKxnFNbvcM=;
        b=LWO+1fEosA55/4P0+G+pmsyMDsBEl2+25b1QmRQ5tUdNuA0YvghbSR4rKl5cSqBoJ3
         JIitiZBR8D9oGgppi58nrLhspeOpgbHIaqvS21XNn9+AxdghVVvsQWLofzEcp8gJMB1H
         fjq5CcZdwk4BQPiuVPBQdVjhAZfNUXd0ObT4v6dElytWN3MlvKjPsOjHqTpy6/zY+ZCO
         WCOVAKSFYHGyZ5czuy78nv/VUporcI1EJCqoi7qx3U9KNffRC4REdYMdtZEVbd+5EFxM
         YErW2Oh7Nmqr3KMcXsQRR4WfJ6ZtNGVID5bGyYuy07eVkvlx/kMML21U2/ozny+i8k7Y
         PEKA==
X-Gm-Message-State: AOJu0Yx6nkTldt2YrowQQLXTgAgdBmv+aFdprJo3Fx1ADDzi3nUXuOPm
	ZwQDxp7gpOO1GnHvs2BrPOUOe8OCYtCVxrfZACqbj5Pgq2EHLXLzTtEKfgEkCTOoN5hPtGCYxgC
	oJS0udQg=
X-Gm-Gg: ASbGncvZEtXWp3CNO3e5DgUoWUHDrQB1YhpaSe1n8mGRw+ZHottYSu4JA9SN56Tor7P
	roIJgPs+5u8UgWdQBquW0Ug5OJvdV8J0oeD1Sgq/TZ3N4jXSJnR1VrCQCI88efoDGlHZCdGFrQR
	Kg1RZV7cibRgj31RTdorGiJPDdMBgRUGN9QduLYNi8JFpgWOtRJxTiTuMOFG5gv8tZurjNntnHW
	ZH1hVA6cCxFSAlljrSnRnThnjYcC94c2Ank0NyVhBud/7J0on6+uORmwwiqtti6lBsEwLdVKXwy
	9GyQSZNcW9aufFRqGfm+Wi7sc8oWZhPv7XTT+DNii4BNFN0bWPuEIzWeBkCiUTTPdA3IZiZiorh
	OHvVkwXfgBYqWafWPLAtmA6LSSRLBB9HRzq4Z0q2ZoKQ=
X-Google-Smtp-Source: AGHT+IEtBeHuZdkBxHva0w5U52VSyvlFLQmqm5QkJhBxE2HUdQNDUNJp/OOJEmsI27tZYrTNXlR0yg==
X-Received: by 2002:a05:6a20:431b:b0:2c9:6c3e:b123 with SMTP id adf61e73a8af0-2fda3b15479mr11962302637.31.1759137791088;
        Mon, 29 Sep 2025 02:23:11 -0700 (PDT)
Received: from localhost ([106.38.226.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53b9615sm10925402a12.2.2025.09.29.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:23:10 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com
Subject: [PATCH 2/2] writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)
Date: Mon, 29 Sep 2025 17:23:04 +0800
Message-Id: <20250929092304.245154-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929092304.245154-1-sunjunchao@bytedance.com>
References: <20250929092304.245154-1-sunjunchao@bytedance.com>
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
 fs/fs-writeback.c                | 11 ++++++++++-
 include/linux/backing-dev-defs.h |  4 +++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 475d52abfb3e..3686b4981deb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1981,8 +1981,17 @@ static long writeback_sb_inodes(struct super_block *sb,
 
 		/* Report progress to inform the hung task detector of the progress. */
 		if (work->done && (jiffies - work->done->stamp) >
-		    HZ * sysctl_hung_task_timeout_secs / 2)
+		    HZ * sysctl_hung_task_timeout_secs / 2) {
+			unsigned long lasted_secs = (jiffies - work->done->start) / HZ;
+
+			if (lasted_secs >= sysctl_hung_task_timeout_secs)
+				pr_info("The writeback work for bdi(%s) has lasted "
+					"for more than %lu seconds with agv_bw %ld\n",
+					wb->bdi->dev_name, lasted_secs,
+					READ_ONCE(wb->avg_write_bandwidth));
+
 			wake_up_all(work->done->waitq);
+		}
 
 		wbc_detach_inode(&wbc);
 		work->nr_pages -= write_chunk - wbc.nr_to_write;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index c37c6bd5ef5c..4c2013caee2b 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -64,10 +64,12 @@ struct wb_completion {
 	atomic_t		cnt;
 	wait_queue_head_t	*waitq;
 	unsigned long stamp;
+	unsigned long start; /* jiffies when writeback work is issued */
 };
 
 #define __WB_COMPLETION_INIT(_waitq)	\
-	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
+	(struct wb_completion)		\
+	{ .cnt = ATOMIC_INIT(1), .waitq = (_waitq), .start = jiffies }
 
 /*
  * If one wants to wait for one or more wb_writeback_works, each work's
-- 
2.39.5


