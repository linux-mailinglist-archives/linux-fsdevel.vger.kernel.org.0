Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61FE3ACEAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhFRPXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14903 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235087AbhFRPWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624029615; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=GbdhK0pYr+SV7ujRBPEtOv5KYsxMwa7KTk/9Vpru6QA=; b=Pyk/iERTnfbAlUIera/laRMFxVMZZ8v1WsoYOhk1jejNImuku+e1GVzqUiIQNPwL3n2ux1fp
 jSsLwmax0o4t9PVQx/0A4d1iPUsmYxIrTzTjPOdioE9FKzeIQN//RcIyN0hE7EM5cGpwtple
 dWmIsljyiZp2Y0bMlBz6IYIyRGc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60ccb994b6ccaab7539a15e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 15:19:48
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9F05C4360C; Fri, 18 Jun 2021 15:19:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 838EFC43144;
        Fri, 18 Jun 2021 15:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 838EFC43144
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, rientjes@google.com, mchehab+huawei@kernel.org,
        lokeshgidra@google.com, andrew.a.klychkov@gmail.com,
        xi.fengfei@h3c.com, nigupta@nvidia.com,
        dave.hansen@linux.intel.com, famzheng@amazon.com,
        mateusznosek0@gmail.com, oleksandr@redhat.com, sh_def@163.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V4 1/3] mm: compaction: optimize proactive compaction deferrals
Date:   Fri, 18 Jun 2021 20:48:53 +0530
Message-Id: <ca4956758515acc9ad5d14198ae4022f52187336.1624028025.git.charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1624028025.git.charante@codeaurora.org>
References: <cover.1624028025.git.charante@codeaurora.org>
In-Reply-To: <cover.1624028025.git.charante@codeaurora.org>
References: <cover.1624028025.git.charante@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When fragmentation score didn't go down across the proactive compaction
i.e. when no progress is made, next wake up for proactive compaction is
deferred for 1 << COMPACT_MAX_DEFER_SHIFT(=6) times, with each wakeup
interval of HPAGE_FRAG_CHECK_INTERVAL_MSEC(=500). In each of this
wakeup, it just decrement 'proactive_defer' counter and goes sleep i.e.
it is getting woken to just decrement a counter. The same deferral time
can also achieved by simply doing the HPAGE_FRAG_CHECK_INTERVAL_MSEC <<
COMPACT_MAX_DEFER_SHIFT thus unnecessary wakeup of kcompact thread is
avoided thus also removes the need of 'proactive_defer' thread counter.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 Changes in V4:
  -- Removed the 'proactive_defer' thread counter by optimizing proactive
     compaction deferrals.
  -- Changes from V1 through V3 doesn't exist.

 mm/compaction.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 84fde27..bfbcb97 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2887,7 +2887,8 @@ static int kcompactd(void *p)
 {
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	unsigned int proactive_defer = 0;
+	long default_timeout = msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC);
+	long timeout = default_timeout;
 
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
 
@@ -2904,23 +2905,30 @@ static int kcompactd(void *p)
 
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
 		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
-			kcompactd_work_requested(pgdat),
-			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
+			kcompactd_work_requested(pgdat), timeout)) {
 
 			psi_memstall_enter(&pflags);
 			kcompactd_do_work(pgdat);
 			psi_memstall_leave(&pflags);
+			/*
+			 * Reset the timeout value. The defer timeout by
+			 * proactive compaction can effectively lost
+			 * here but that is fine as the condition of the
+			 * zone changed substantionally and carrying on
+			 * with the previous defer is not useful.
+			 */
+			timeout = default_timeout;
 			continue;
 		}
 
-		/* kcompactd wait timeout */
+		/*
+		 * Start the proactive work with default timeout. Based
+		 * on the fragmentation score, this timeout is updated.
+		 */
+		timeout = default_timeout;
 		if (should_proactive_compact_node(pgdat)) {
 			unsigned int prev_score, score;
 
-			if (proactive_defer) {
-				proactive_defer--;
-				continue;
-			}
 			prev_score = fragmentation_score_node(pgdat);
 			proactive_compact_node(pgdat);
 			score = fragmentation_score_node(pgdat);
@@ -2928,8 +2936,9 @@ static int kcompactd(void *p)
 			 * Defer proactive compaction if the fragmentation
 			 * score did not go down i.e. no progress made.
 			 */
-			proactive_defer = score < prev_score ?
-					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
+			if (unlikely(score >= prev_score))
+				timeout =
+				   default_timeout << COMPACT_MAX_DEFER_SHIFT;
 		}
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

