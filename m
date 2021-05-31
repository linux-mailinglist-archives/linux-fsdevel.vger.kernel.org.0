Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC139594C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhEaK6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 06:58:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41565 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhEaK6A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 06:58:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622458581; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=QlYc3u3TuNAPivVce1iIXZSsOE1D8aMMOWtQav1jEe4=; b=Ng3BztxGg/LDEzHzGrfxhSE1GU4GRxrtAc/H4gMS/eQGAWBjoX5u7lvkR4AnADCJZVa5DRY2
 U5BLVhjYXz+s3yxa+7jB2AxYGzmjHSLjGEEwmVnOBPesbmD6Zo3fWnUXhViY3o61AuQYv2ZB
 LpQZSb0xtMdnoesovcc9BvC03L8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60b4c0d2f726fa41881b499d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 10:56:18
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EFC0AC43147; Mon, 31 May 2021 10:56:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75601C4338A;
        Mon, 31 May 2021 10:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75601C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        hannes@cmpxchg.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, aarcange@redhat.com,
        cl@linux.com, xi.fengfei@h3c.com, mchehab+huawei@kernel.org,
        andrew.a.klychkov@gmail.com, dave.hansen@linux.intel.com,
        bhe@redhat.com, iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com,
        sh_def@163.com, vinmenon@codeaurora.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH v3 2/2] mm: compaction: fix wakeup logic of proactive compaction
Date:   Mon, 31 May 2021 16:24:52 +0530
Message-Id: <ad2600f3d8d7c0d44b35d9fad0031d82c5a3c285.1622454385.git.charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1622454385.git.charante@codeaurora.org>
References: <cover.1622454385.git.charante@codeaurora.org>
In-Reply-To: <cover.1622454385.git.charante@codeaurora.org>
References: <cover.1622454385.git.charante@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, proactive compaction tries to get triggered for every
HPAGE_FRAG_CHECK_INTERVAL_MSEC(=500msec) even when proactive compaction
is disabled with sysctl.compaction_proactiveness = 0. This results in
kcompactd thread wakes up and goes to sleep for every 500msec with out
the need of doing proactive compaction. Though this doesn't have any
overhead, few cpu cycles can be saved by avoid of waking up kcompactd
thread for proactive compaction when it is disabled.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---

 - This patch is newly raised in V3, thus no changes exist in V1 and V2 

 mm/compaction.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 197e203..0edcd0f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2926,11 +2926,14 @@ static int kcompactd(void *p)
 
 	while (!kthread_should_stop()) {
 		unsigned long pflags;
+		long timeout;
 
+		timeout = sysctl_compaction_proactiveness ?
+			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC) :
+			MAX_SCHEDULE_TIMEOUT;
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
 		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
-			kcompactd_work_requested(pgdat),
-			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC)) &&
+			kcompactd_work_requested(pgdat), timeout) &&
 			!pgdat->proactive_compact_trigger) {
 
 			psi_memstall_enter(&pflags);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

