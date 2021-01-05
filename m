Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F142EA5B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 08:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbhAEHGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 02:06:55 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:15684 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbhAEHGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:06:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609830395; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=PSD4T8ASrr1pfYU48t/ftAURhWN9+rkwMmpAWedYLBE=; b=Gb/qk8dZYWERcy++PbwzGHx6gIOeNfvkFGNCaKyVjINS0C6niLYjr8XtcLi8pWeKQQSoYTnX
 EPipze5C6y4664txVDl9V2KdRgHlsP0cscB5zjEPhps+H7ZpYSk8PCmKoA4DMEo1w12FOTKk
 Cl8bcgmzrJv0qeA0jWiOCzQWYk0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ff40fcab73be0303d19c447 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Jan 2021 07:05:46
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F75DC43462; Tue,  5 Jan 2021 07:05:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89BFBC433C6;
        Tue,  5 Jan 2021 07:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89BFBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Laura Abbott <lauraa@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v2] fs/buffer.c: Revoke LRU when trying to drop buffers
Date:   Mon,  4 Jan 2021 23:05:33 -0800
Message-Id: <f97956626c8ddecdc5938c38b58dab5fc24b366a.1609829465.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1609829465.git.cgoldswo@codeaurora.org>
References: <cover.1609829465.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1609829465.git.cgoldswo@codeaurora.org>
References: <cover.1609829465.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Laura Abbott <lauraa@codeaurora.org>

When a buffer is added to the LRU list, a reference is taken which is
not dropped until the buffer is evicted from the LRU list. This is the
correct behavior, however this LRU reference will prevent the buffer
from being dropped. This means that the buffer can't actually be dropped
until it is selected for eviction. There's no bound on the time spent
on the LRU list, which means that the buffer may be undroppable for
very long periods of time. Given that migration involves dropping
buffers, the associated page is now unmigratible for long periods of
time as well. CMA relies on being able to migrate a specific range
of pages, so these types of failures make CMA significantly
less reliable, especially under high filesystem usage.

Rather than waiting for the LRU algorithm to eventually kick out
the buffer, explicitly remove the buffer from the LRU list when trying
to drop it. There is still the possibility that the buffer
could be added back on the list, but that indicates the buffer is
still in use and would probably have other 'in use' indicates to
prevent dropping.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 fs/buffer.c   | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/internal.h |  5 ++++
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604..536fb5b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
+#include <linux/xarray.h>
 
 #include "internal.h"
 
@@ -1471,12 +1472,63 @@ static bool has_bh_in_lru(int cpu, void *dummy)
 	return false;
 }
 
+static void __evict_bhs_lru(void *arg)
+{
+	struct bh_lru *b = &get_cpu_var(bh_lrus);
+	struct busy_bhs_container *busy_bhs = arg;
+	struct buffer_head *bh;
+	int i;
+
+	XA_STATE(xas, &busy_bhs->xarray, 0);
+
+	xas_for_each(&xas, bh, busy_bhs->size) {
+		for (i = 0; i < BH_LRU_SIZE; i++) {
+			if (b->bhs[i] == bh) {
+				brelse(b->bhs[i]);
+				b->bhs[i] = NULL;
+				break;
+			}
+		}
+
+		bh = bh->b_this_page;
+	}
+
+	put_cpu_var(bh_lrus);
+}
+
+static bool page_has_bhs_in_lru(int cpu, void *arg)
+{
+	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
+	struct busy_bhs_container *busy_bhs = arg;
+	struct buffer_head *bh;
+	int i;
+
+	XA_STATE(xas, &busy_bhs->xarray, 0);
+
+	xas_for_each(&xas, bh, busy_bhs->size) {
+		for (i = 0; i < BH_LRU_SIZE; i++) {
+			if (b->bhs[i] == bh)
+				return true;
+		}
+
+		bh = bh->b_this_page;
+	}
+
+	return false;
+
+}
 void invalidate_bh_lrus(void)
 {
 	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
+static void evict_bh_lrus(struct busy_bhs_container *busy_bhs)
+{
+	on_each_cpu_cond(page_has_bhs_in_lru, __evict_bhs_lru,
+			 busy_bhs, 1);
+}
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
@@ -3242,14 +3294,36 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 {
 	struct buffer_head *head = page_buffers(page);
 	struct buffer_head *bh;
+	struct busy_bhs_container busy_bhs;
+	int xa_ret, ret = 0;
+
+	xa_init(&busy_bhs.xarray);
+	busy_bhs.size = 0;
 
 	bh = head;
 	do {
-		if (buffer_busy(bh))
-			goto failed;
+		if (buffer_busy(bh)) {
+			xa_ret = xa_err(xa_store(&busy_bhs.xarray, busy_bhs.size++,
+						 bh, GFP_ATOMIC));
+			if (xa_ret)
+				goto out;
+		}
 		bh = bh->b_this_page;
 	} while (bh != head);
 
+	if (busy_bhs.size) {
+		/*
+		 * Check if the busy failure was due to an outstanding
+		 * LRU reference
+		 */
+		evict_bh_lrus(&busy_bhs);
+		do {
+			if (buffer_busy(bh))
+				goto out;
+		} while (bh != head);
+	}
+
+	ret = 1;
 	do {
 		struct buffer_head *next = bh->b_this_page;
 
@@ -3259,9 +3333,10 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 	} while (bh != head);
 	*buffers_to_free = head;
 	detach_page_private(page);
-	return 1;
-failed:
-	return 0;
+out:
+	xa_destroy(&busy_bhs.xarray);
+
+	return ret;
 }
 
 int try_to_free_buffers(struct page *page)
diff --git a/fs/internal.h b/fs/internal.h
index 77c50be..00f17c4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -15,6 +15,7 @@ struct mount;
 struct shrink_control;
 struct fs_context;
 struct user_namespace;
+struct xarray;
 
 /*
  * block_dev.c
@@ -49,6 +50,10 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
  */
 extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block, struct iomap *iomap);
+struct busy_bhs_container {
+	struct xarray xarray;
+	int size;
+};
 
 /*
  * char_dev.c
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

