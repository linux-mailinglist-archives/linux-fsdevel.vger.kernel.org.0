Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604802C1E80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgKXGtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:49:50 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:45374 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgKXGtu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:49:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606200589; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=UDO+Y8s0zbY40OPyGLj6G8krTvl3bn+bwk439waak+c=; b=W4kM7fykYA8KS2VSxiKtwCM3oRyKZKh9Bmkk3iDJd7xuZvwgWr4C6uoJpKA1Qa2XHu114G1q
 7oC+bbZWc1eqj6l28I/UyyMlAtUE/qMqPhYhKl0gubryoizk/6+pZ+QhEgxVFnMSGAYThHZQ
 7c94ASp0KVkrN/tzixRL06eYGMc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fbcad0d1b731a5d9c07b84f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 06:49:49
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C2DBC43463; Tue, 24 Nov 2020 06:49:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DEE4C43460;
        Tue, 24 Nov 2020 06:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DEE4C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@redhat.com, Laura Abbott <lauraa@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH] fs/buffer.c: Revoke LRU when trying to drop buffers
Date:   Mon, 23 Nov 2020 22:49:38 -0800
Message-Id: <1fe5d53722407a2651eeeada3a422c117041bf1d.1606194703.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1606194703.git.cgoldswo@codeaurora.org>
References: <cover.1606194703.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1606194703.git.cgoldswo@codeaurora.org>
References: <cover.1606194703.git.cgoldswo@codeaurora.org>
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
---
 fs/buffer.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 64564ac..1751f0b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1471,12 +1471,48 @@ static bool has_bh_in_lru(int cpu, void *dummy)
 	return false;
 }
 
+static void __evict_bh_lru(void *arg)
+{
+	struct bh_lru *b = &get_cpu_var(bh_lrus);
+	struct buffer_head *bh = arg;
+	int i;
+
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		if (b->bhs[i] == bh) {
+			brelse(b->bhs[i]);
+			b->bhs[i] = NULL;
+			goto out;
+		}
+	}
+out:
+	put_cpu_var(bh_lrus);
+}
+
+static bool bh_exists_in_lru(int cpu, void *arg)
+{
+	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
+	struct buffer_head *bh = arg;
+	int i;
+
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		if (b->bhs[i] == bh)
+			return true;
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
 
+static void evict_bh_lrus(struct buffer_head *bh)
+{
+	on_each_cpu_cond(bh_exists_in_lru, __evict_bh_lru, bh, 1);
+}
+
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
@@ -3245,8 +3281,15 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 
 	bh = head;
 	do {
-		if (buffer_busy(bh))
-			goto failed;
+		if (buffer_busy(bh)) {
+			/*
+			 * Check if the busy failure was due to an
+			 * outstanding LRU reference
+			 */
+			evict_bh_lrus(bh);
+			if (buffer_busy(bh))
+				goto failed;
+		}
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

