Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33F368193
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhDVNi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 09:38:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49074 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236359AbhDVNiz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:38:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619098700; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Z55UTxpXyLr3rTUJNaY6VLLVuJYlMNUJ66KfV5/0zQU=; b=VawrGXjvyePrwl4LWRPNlg6rEK9rPi1gq6JGQK3LgaoAgBMPn+xO7FZBrVEK0T37suR+f4y9
 peG52iDmeJC7V6jwAhsf4e0QRpQL3yxYmaPHtAs1rPWqng7ZuNUHQkKnei8u5PossdbWlIGG
 +n5RzJ5YF9O18aQFJs/JGVEOuyg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60817c4603cfff34527c920a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Apr 2021 13:38:14
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E1ABC43144; Thu, 22 Apr 2021 13:38:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4537CC433F1;
        Thu, 22 Apr 2021 13:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4537CC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, bhe@redhat.com,
        nigupta@nvidia.com, khalid.aziz@oracle.com,
        mateusznosek0@gmail.com, sh_def@163.com, iamjoonsoo.kim@lge.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        mhocko@suse.com, rientjes@google.com, mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm: compaction: improve /proc trigger for full node memory compaction
Date:   Thu, 22 Apr 2021 19:07:58 +0530
Message-Id: <1619098678-8501-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The existing /proc/sys/vm/compact_memory interface do the full node
compaction when user writes an arbitrary value to it and is targeted for
the usecases like an app launcher prepares the system before the target
application runs. The downside of it is that even if there are
sufficient higher order pages left in the system for the targeted
application to run, full node compaction will still be triggered thus
wasting few CPU cycles. This problem can be solved if it is known when
the sufficient higher order pages are available in the system thus full
node compaction can be stopped in the middle. The proactive
compaction[1] can give these details about the availability of higher
order pages in the system(it checks for COMPACTION_HPAGE_ORDER pages,
which usually be order-9) thus can be used to trigger for full node
compaction.

This patch adds a new /proc interface,
/proc/sys/vm/proactive_compact_memory, and on write of an arbitrary
value triggers the full node compaction but can be stopped in the middle
if sufficient higher order(COMPACTION_HPAGE_ORDER) pages available in
the system. The availability of pages that a user looking for can be
given as input through /proc/sys/vm/compaction_proactiveness.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=facdaa917c4d5a376d09d25865f5a863f906234a

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 include/linux/compaction.h |  3 +++
 kernel/sysctl.c            |  7 +++++++
 mm/compaction.c            | 25 ++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index ed4070e..af8f6c5 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -82,9 +82,12 @@ static inline unsigned long compact_gap(unsigned int order)
 
 #ifdef CONFIG_COMPACTION
 extern int sysctl_compact_memory;
+extern int sysctl_proactive_compact_memory;
 extern unsigned int sysctl_compaction_proactiveness;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos);
+extern int sysctl_proactive_compaction_handler(struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_extfrag_threshold;
 extern int sysctl_compact_unevictable_allowed;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09..ceb5c61 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2862,6 +2862,13 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= sysctl_compaction_handler,
 	},
 	{
+		.procname       = "proactive_compact_memory",
+		.data           = &sysctl_proactive_compact_memory,
+		.maxlen         = sizeof(int),
+		.mode           = 0200,
+		.proc_handler   = sysctl_proactive_compaction_handler,
+	},
+	{
 		.procname	= "compaction_proactiveness",
 		.data		= &sysctl_compaction_proactiveness,
 		.maxlen		= sizeof(sysctl_compaction_proactiveness),
diff --git a/mm/compaction.c b/mm/compaction.c
index e04f447..2b40b03 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2588,13 +2588,13 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
  * due to various back-off conditions, such as, contention on per-node or
  * per-zone locks.
  */
-static void proactive_compact_node(pg_data_t *pgdat)
+static void proactive_compact_node(pg_data_t *pgdat, enum migrate_mode mode)
 {
 	int zoneid;
 	struct zone *zone;
 	struct compact_control cc = {
 		.order = -1,
-		.mode = MIGRATE_SYNC_LIGHT,
+		.mode = mode,
 		.ignore_skip_hint = true,
 		.whole_zone = true,
 		.gfp_mask = GFP_KERNEL,
@@ -2657,6 +2657,17 @@ static void compact_nodes(void)
 		compact_node(nid);
 }
 
+static void proactive_compact_nodes(void)
+{
+	int nid;
+
+	/* Flush pending updates to the LRU lists */
+	lru_add_drain_all();
+	for_each_online_node(nid)
+		proactive_compact_node(NODE_DATA(nid), MIGRATE_SYNC);
+}
+
+int sysctl_proactive_compact_memory;
 /* The written value is actually unused, all memory is compacted */
 int sysctl_compact_memory;
 
@@ -2680,6 +2691,14 @@ int sysctl_compaction_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+int sysctl_proactive_compaction_handler(struct ctl_table *table, int write,
+			void *buffer, size_t *length, loff_t *ppos)
+{
+	if (write)
+		proactive_compact_nodes();
+
+	return 0;
+}
 #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
 static ssize_t sysfs_compact_node(struct device *dev,
 			struct device_attribute *attr,
@@ -2881,7 +2900,7 @@ static int kcompactd(void *p)
 				continue;
 			}
 			prev_score = fragmentation_score_node(pgdat);
-			proactive_compact_node(pgdat);
+			proactive_compact_node(pgdat, MIGRATE_SYNC_LIGHT);
 			score = fragmentation_score_node(pgdat);
 			/*
 			 * Defer proactive compaction if the fragmentation
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

