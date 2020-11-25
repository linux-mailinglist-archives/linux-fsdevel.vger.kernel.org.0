Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5202C4517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 17:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbgKYQZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbgKYQZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:46 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0EC061A53
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:25:44 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x13so1889809wmj.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5C08Hy1XMQFC0buOh9jSFHuZ0iwVVw80p1E5iRWSvg=;
        b=jVHAscAYlfUZpaUDcWeAN+ImydgMtSo0J4j+H0r2qtoN4JmJx9Vve4jifNb53zuGqi
         Ho1AFwAoWORedY91OsjnrVbKw6hwQJ2Kv5B8EMyK5Y7KSllnc5Cw2fu9iTZNFFbiKE7V
         xTc7fqCfuiYJbUWlEUEfD8UXGnYqpwS8fW1sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5C08Hy1XMQFC0buOh9jSFHuZ0iwVVw80p1E5iRWSvg=;
        b=dub6tbaAHVWj3Lo4E+T25sD+pBTf6MkCOJCiiRg5iM4YYjMiozdojo70ppY0giUfmn
         +CAJ1NzFoITccVHY+ShXEeJC+BeA4Roo7x1pu1O0Nxm5XMP9cs3cm26gXl6KeE7r26hl
         Mj0JobldGL4ZFI/sd/5tjQA1gkYvuHD43GPg+HWmoIQsQnk+FPmaizNY2mL3fULj3PKf
         khpNlGm6tdr6JFo5H/Wzkz+TT0J0LUhO2r1uxpvJGKlnufTIMxlGKau1jPOJgh1tiKFh
         ehwCP0DYawKsGjAXdsMt6Goc/xPnqY4XQ7FzD9i7W+OdE/6xg1VPnouO2qLAcetlcWHC
         IWvg==
X-Gm-Message-State: AOAM532LfWKX0Rlki/oPXyEmTTdwzFcu4VhnPlR595Rry3HpPE9j9FYP
        93rLIie1qJ07YPU0m/IZkdhqrg==
X-Google-Smtp-Source: ABdhPJxvYwNleTXWY/S3WavDz5/k2r0sp2h9zjamdvz+WUc8Vx3B5vSrofONxe4Fcqlg5PcbCQYGaQ==
X-Received: by 2002:a7b:c3ce:: with SMTP id t14mr4768131wmj.170.1606321543202;
        Wed, 25 Nov 2020 08:25:43 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a21sm4855187wmb.38.2020.11.25.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:42 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 3/3] locking/selftests: Add testcases for fs_reclaim
Date:   Wed, 25 Nov 2020 17:25:31 +0100
Message-Id: <20201125162532.1299794-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
References: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since I butchered this I figured better to make sure we have testcases
for this now. Since we only have a locking context for __GFP_FS that's
the only thing we're testing right now.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Cc: Qian Cai <cai@lca.pw>
Cc: linux-xfs@vger.kernel.org
Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-mm@kvack.org
Cc: linux-rdma@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 lib/locking-selftest.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index a899b3f0e2e5..ad47c3358e30 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/ww_mutex.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/delay.h>
 #include <linux/lockdep.h>
 #include <linux/spinlock.h>
@@ -2357,6 +2358,50 @@ static void queued_read_lock_tests(void)
 	pr_cont("\n");
 }
 
+static void fs_reclaim_correct_nesting(void)
+{
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_alloc(GFP_NOFS);
+	fs_reclaim_release(GFP_KERNEL);
+}
+
+static void fs_reclaim_wrong_nesting(void)
+{
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_alloc(GFP_KERNEL);
+	fs_reclaim_release(GFP_KERNEL);
+}
+
+static void fs_reclaim_protected_nesting(void)
+{
+	unsigned int flags;
+
+	fs_reclaim_acquire(GFP_KERNEL);
+	flags = memalloc_nofs_save();
+	might_alloc(GFP_KERNEL);
+	memalloc_nofs_restore(flags);
+	fs_reclaim_release(GFP_KERNEL);
+}
+
+static void fs_reclaim_tests(void)
+{
+	printk("  --------------------\n");
+	printk("  | fs_reclaim tests |\n");
+	printk("  --------------------\n");
+
+	print_testname("correct nesting");
+	dotest(fs_reclaim_correct_nesting, SUCCESS, 0);
+	pr_cont("\n");
+
+	print_testname("wrong nesting");
+	dotest(fs_reclaim_wrong_nesting, FAILURE, 0);
+	pr_cont("\n");
+
+	print_testname("protected nesting");
+	dotest(fs_reclaim_protected_nesting, SUCCESS, 0);
+	pr_cont("\n");
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2478,6 +2523,8 @@ void locking_selftest(void)
 	if (IS_ENABLED(CONFIG_QUEUED_RWLOCKS))
 		queued_read_lock_tests();
 
+	fs_reclaim_tests();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.29.2

