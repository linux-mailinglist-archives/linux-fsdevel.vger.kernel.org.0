Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4673586E11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiHAPuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiHAPum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:50:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2737FB5
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 08:50:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 130so3165686pfv.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDVffGBJScwkOd+9hsMyXStFZyBJcuy4eeJPA0O+mYE=;
        b=jMmbhYHIQdhHEsYbYCTMWkE+N1oR2+4UIsO935pssDIUKV24yYBYURTemf+naJm91J
         +9BPjXvfoOiYx9oigoCYE3NmVM8Jcdx+neZJCJkl+xHlmLz7Cw3EWQ11Q2GLWVxga4Hq
         c0kegNzqCTkBQDxScnsZzfUCJB29phKYzgaYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDVffGBJScwkOd+9hsMyXStFZyBJcuy4eeJPA0O+mYE=;
        b=LUgkf5kQwSiSgEzCacWI4JtjQEPFbNEhS4dtfC1j3HiuXCm41yEH4cbAOlbwCBYzxs
         PjGWX52LvFzPZhkprj01a5OUlxcuXAa3Wz/Z3KqjMaociEC7H9xusXRMIBNzS8i10Pd8
         Wfow0vpos7oY178c+JJMbJAz0MOrNlksoQ6YDEe1W3mqKsO01yd12Rk1xrM1sZ5QXMaD
         SCPbI9u/24Jurc91JsbgseSOTvZTr+2xqGmrFONA+3JGdTZ5wsjdDhNzsfgmrWZBMhV0
         zzBgwEvArw9QGz6iBjK4xI8D8gNSctKp6RGgTQui4Cpx+5WF4UT1aZH0whSsxNisMOBy
         qkZw==
X-Gm-Message-State: AJIora/HAy7HTQ0Zj2HJPjwdTGIhziGogJ1i3rezB5+hAXuTDCG49XsO
        HBbcTCm/XTS3mDMU14eIyOaE9A==
X-Google-Smtp-Source: AGRyM1u2007IRXIHyLfdUffsTUR4Bx46Z3b0fr1ICpvciP22E+MaQbIIln+XTvg0vFD0yi4DQA4iGQ==
X-Received: by 2002:a65:6b8a:0:b0:3db:7dc5:fec2 with SMTP id d10-20020a656b8a000000b003db7dc5fec2mr13491063pgw.223.1659369039877;
        Mon, 01 Aug 2022 08:50:39 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:8277:7816:dd6b:eadc])
        by smtp.gmail.com with ESMTPSA id lx7-20020a17090b4b0700b001f4dd3b7d7fsm5132323pjb.9.2022.08.01.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:50:39 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v2] writeback: avoid use-after-free after removing device
Date:   Mon,  1 Aug 2022 08:50:34 -0700
Message-Id: <20220801155034.3772543-1-khazhy@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220729215123.1998585-1-khazhy@google.com>
References: <20220729215123.1998585-1-khazhy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a disk is removed, bdi_unregister gets called to stop further
writeback and wait for associated delayed work to complete. However,
wb_inode_writeback_end() may schedule bandwidth estimation dwork after
this has completed, which can result in the timer attempting to access
the just freed bdi_writeback.

Fix this by checking if the bdi_writeback is alive, similar to when
scheduling writeback work.

Since this requires wb->work_lock, and wb_inode_writeback_end() may get
called from interrupt, switch wb->work_lock to an irqsafe lock.

Fixes: 45a2966fd641 ("writeback: fix bandwidth estimate for spiky workload")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fs-writeback.c   | 12 ++++++------
 mm/backing-dev.c    | 10 +++++-----
 mm/page-writeback.c |  6 +++++-
 3 files changed, 16 insertions(+), 12 deletions(-)

v2: made changelog a bit more verbose

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 05221366a16d..08a1993ab7fd 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -134,10 +134,10 @@ static bool inode_io_list_move_locked(struct inode *inode,
 
 static void wb_wakeup(struct bdi_writeback *wb)
 {
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
 		mod_delayed_work(bdi_wq, &wb->dwork, 0);
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 }
 
 static void finish_writeback_work(struct bdi_writeback *wb,
@@ -164,7 +164,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 	if (work->done)
 		atomic_inc(&work->done->cnt);
 
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 
 	if (test_bit(WB_registered, &wb->state)) {
 		list_add_tail(&work->list, &wb->work_list);
@@ -172,7 +172,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 	} else
 		finish_writeback_work(wb, work);
 
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 }
 
 /**
@@ -2082,13 +2082,13 @@ static struct wb_writeback_work *get_next_work_item(struct bdi_writeback *wb)
 {
 	struct wb_writeback_work *work = NULL;
 
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (!list_empty(&wb->work_list)) {
 		work = list_entry(wb->work_list.next,
 				  struct wb_writeback_work, list);
 		list_del_init(&work->list);
 	}
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 	return work;
 }
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 95550b8fa7fe..de65cb1e5f76 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -260,10 +260,10 @@ void wb_wakeup_delayed(struct bdi_writeback *wb)
 	unsigned long timeout;
 
 	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
 		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 }
 
 static void wb_update_bandwidth_workfn(struct work_struct *work)
@@ -334,12 +334,12 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb);
 static void wb_shutdown(struct bdi_writeback *wb)
 {
 	/* Make sure nobody queues further work */
-	spin_lock_bh(&wb->work_lock);
+	spin_lock_irq(&wb->work_lock);
 	if (!test_and_clear_bit(WB_registered, &wb->state)) {
-		spin_unlock_bh(&wb->work_lock);
+		spin_unlock_irq(&wb->work_lock);
 		return;
 	}
-	spin_unlock_bh(&wb->work_lock);
+	spin_unlock_irq(&wb->work_lock);
 
 	cgwb_remove_from_bdi_list(wb);
 	/*
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 55c2776ae699..3c34db15cf70 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2867,6 +2867,7 @@ static void wb_inode_writeback_start(struct bdi_writeback *wb)
 
 static void wb_inode_writeback_end(struct bdi_writeback *wb)
 {
+	unsigned long flags;
 	atomic_dec(&wb->writeback_inodes);
 	/*
 	 * Make sure estimate of writeback throughput gets updated after
@@ -2875,7 +2876,10 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
 	 * that if multiple inodes end writeback at a similar time, they get
 	 * batched into one bandwidth update.
 	 */
-	queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
+	spin_lock_irqsave(&wb->work_lock, flags);
+	if (test_bit(WB_registered, &wb->state))
+		queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
+	spin_unlock_irqrestore(&wb->work_lock, flags);
 }
 
 bool __folio_end_writeback(struct folio *folio)
-- 
2.37.1.455.g008518b4e5-goog

