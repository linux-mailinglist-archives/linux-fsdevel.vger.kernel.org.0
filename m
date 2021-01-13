Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B22F5835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbhANCPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 21:15:45 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:64602 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbhAMVRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:17:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610572686; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=jC6g89gEKfijNaQ/kr8NWtlMPcI3v4LRrcbb5ecBEJ4=; b=a5McztpK+aIreKcTanGL91lBrKNE9JDpJfIaf++oZZu/QrN1/jz/5grwEk0EIn2lZa9n2B9W
 d2nKjNWyYFfPTxTKfOxOzemm3VqzVpAE9Zq61ur9qaeLZ2BZFOtkE/wb36vrquh+C1H/NckN
 J26TpIBf/3t92DqpRYDsD/fBUBk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fff6373af68fb3b064438ab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Jan 2021 21:17:39
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1734C433ED; Wed, 13 Jan 2021 21:17:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80F9AC433CA;
        Wed, 13 Jan 2021 21:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80F9AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laura Abbott <lauraa@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v3] fs/buffer.c: Revoke LRU when trying to drop buffers
Date:   Wed, 13 Jan 2021 13:17:30 -0800
Message-Id: <2f13c006ad12b047e9e4d5de008e5d5c41322754.1610572007.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1610572007.git.cgoldswo@codeaurora.org>
References: <cover.1610572007.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1610572007.git.cgoldswo@codeaurora.org>
References: <cover.1610572007.git.cgoldswo@codeaurora.org>
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

Note: a bug reported by "kernel test robot" lead to a switch from
using xas_for_each() to xa_for_each().

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Matthew Wilcox <willy@infradead.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 fs/buffer.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604..d2d1237 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
+#include <linux/xarray.h>
 
 #include "internal.h"
 
@@ -1471,12 +1472,59 @@ static bool has_bh_in_lru(int cpu, void *dummy)
 	return false;
 }
 
+static void __evict_bhs_lru(void *arg)
+{
+	struct bh_lru *b = &get_cpu_var(bh_lrus);
+	struct xarray *busy_bhs = arg;
+	struct buffer_head *bh;
+	unsigned long i, xarray_index;
+
+	xa_for_each(busy_bhs, xarray_index, bh) {
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
+	struct xarray *busy_bhs = arg;
+	struct buffer_head *bh;
+	unsigned long i, xarray_index;
+
+	xa_for_each(busy_bhs, xarray_index, bh) {
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
 
+static void evict_bh_lrus(struct xarray *busy_bhs)
+{
+	on_each_cpu_cond(page_has_bhs_in_lru, __evict_bhs_lru,
+			 busy_bhs, 1);
+}
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
@@ -3242,14 +3290,36 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 {
 	struct buffer_head *head = page_buffers(page);
 	struct buffer_head *bh;
+	struct xarray busy_bhs;
+	int bh_count = 0;
+	int xa_ret, ret = 0;
+
+	xa_init(&busy_bhs);
 
 	bh = head;
 	do {
-		if (buffer_busy(bh))
-			goto failed;
+		if (buffer_busy(bh)) {
+			xa_ret = xa_err(xa_store(&busy_bhs, bh_count++,
+						 bh, GFP_ATOMIC));
+			if (xa_ret)
+				goto out;
+		}
 		bh = bh->b_this_page;
 	} while (bh != head);
 
+	if (bh_count) {
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
 
@@ -3259,9 +3329,10 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 	} while (bh != head);
 	*buffers_to_free = head;
 	detach_page_private(page);
-	return 1;
-failed:
-	return 0;
+out:
+	xa_destroy(&busy_bhs);
+
+	return ret;
 }
 
 int try_to_free_buffers(struct page *page)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

