Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056AE32B4C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354213AbhCCF2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:28:39 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:56908 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243570AbhCBS1w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:27:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614709548; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sQlYOY3q+jwKIF/p4KAZwYdxXwoIWL9zgjlvvo6D0x0=; b=VFdtZEQTT+kmCAyCpT2fZUFpRFEcmQJi2kAqtKMAC5op7OtPwahkxuSXLyRn3AfnKewAqSGi
 dhuG3HEBVuY53AzFm25n2u9FSK/LW869OR7hFifn+gcsuLEOGYuZ0BuA4XUPrqduskLjrHGU
 3opcdMnEMjGDOeuxk4Nh18LtBzQ=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 603e7c4f2a53a9538a3e6f97 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 17:56:31
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 777ABC43461; Tue,  2 Mar 2021 17:56:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-498.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9F57C433C6;
        Tue,  2 Mar 2021 17:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9F57C433C6
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
Subject: [PATCH] mm/compaction: remove unused variable sysctl_compact_memory
Date:   Tue,  2 Mar 2021 23:26:13 +0530
Message-Id: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sysctl_compact_memory is mostly unsed in mm/compaction.c
It just acts as a place holder for sysctl.

Thus we can remove it from here and move the declaration directly
in kernel/sysctl.c itself.
This will also eliminate the extern declaration from header file.
No functionality is broken or changed this way.

Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
---
 include/linux/compaction.h | 1 -
 kernel/sysctl.c            | 1 +
 mm/compaction.c            | 3 ---
 3 files changed, 1 insertion(+), 4 deletions(-)

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
index c9fbdd8..66aff21 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -198,6 +198,7 @@ static int max_sched_tunable_scaling = SCHED_TUNABLESCALING_END-1;
 #ifdef CONFIG_COMPACTION
 static int min_extfrag_threshold;
 static int max_extfrag_threshold = 1000;
+static int sysctl_compact_memory;
 #endif
 
 #endif /* CONFIG_SYSCTL */
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

