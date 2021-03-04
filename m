Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2232D061
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhCDKFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:05:51 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:63676 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhCDKFV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:05:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614852321; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kcRoAX9wKUGCY2tUhMsy4I/AJ378Sfygc6B2YBdp//M=; b=AUM8q0JIAOqTm1pt5Vd83/YhT215ohXaSHtJyy9FhojDu1DkjYQdm3JkiJ7cfRpeLVW3QZZb
 r9T/PWG+Ja4GFAymv7s/CJ1FCvgnt7Wjm2WmCLlXa8szRZHCntIvoNzzSsZeb5i4D9iuiB5z
 9DWPv4n4Jy/s+zul93dfFqDyWx4=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6040b0927b648e2436afaaea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Mar 2021 10:04:02
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61E50C433C6; Thu,  4 Mar 2021 10:04:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-498.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6324FC433CA;
        Thu,  4 Mar 2021 10:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6324FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pintu@codeaurora.org
From:   Pintu Kumar <pintu@codeaurora.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        pintu@codeaurora.org, iamjoonsoo.kim@lge.com, sh_def@163.com,
        mateusznosek0@gmail.com, bhe@redhat.com, nigupta@nvidia.com,
        vbabka@suse.cz, yzaikin@google.com, keescook@chromium.org,
        mcgrof@kernel.org, mgorman@techsingularity.net
Cc:     pintu.ping@gmail.com
Subject: [PATCH v2] mm/compaction: remove unused variable sysctl_compact_memory
Date:   Thu,  4 Mar 2021 15:33:44 +0530
Message-Id: <1614852224-14671-1-git-send-email-pintu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <c99eb67f67e4e24b4df1a78a583837b1@codeaurora.org>
References: <c99eb67f67e4e24b4df1a78a583837b1@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sysctl_compact_memory is mostly unused in mm/compaction.c
It just acts as a place holder for sysctl to store .data.

But the .data itself is not needed here.
So we can get ride of this variable completely and make .data as NULL.
This will also eliminate the extern declaration from header file.
No functionality is broken or changed this way.

Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
---
v2: completely get rid of this variable and set .data to NULL
    Suggested-by: Vlastimil Babka <vbabka@suse.cz>

 include/linux/compaction.h | 1 -
 kernel/sysctl.c            | 2 +-
 mm/compaction.c            | 3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index ed4070e..4221888 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -81,7 +81,6 @@ static inline unsigned long compact_gap(unsigned int order)
 }
 
 #ifdef CONFIG_COMPACTION
-extern int sysctl_compact_memory;
 extern unsigned int sysctl_compaction_proactiveness;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9fbdd8..07ef240 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2856,7 +2856,7 @@ static struct ctl_table vm_table[] = {
 #ifdef CONFIG_COMPACTION
 	{
 		.procname	= "compact_memory",
-		.data		= &sysctl_compact_memory,
+		.data		= NULL,
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= sysctl_compaction_handler,
diff --git a/mm/compaction.c b/mm/compaction.c
index 190ccda..ede2886 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2650,9 +2650,6 @@ static void compact_nodes(void)
 		compact_node(nid);
 }
 
-/* The written value is actually unused, all memory is compacted */
-int sysctl_compact_memory;
-
 /*
  * Tunable for proactive compaction. It determines how
  * aggressively the kernel should compact memory in the
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

