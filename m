Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874FB6A8E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 01:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCCAoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 19:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCAoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:44:54 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD52C196B4;
        Thu,  2 Mar 2023 16:44:51 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PSTl56ww5z501RW;
        Fri,  3 Mar 2023 08:44:49 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3230ieH1020865;
        Fri, 3 Mar 2023 08:44:40 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 3 Mar 2023 08:44:41 +0800 (CST)
Date:   Fri, 3 Mar 2023 08:44:41 +0800 (CST)
X-Zmail-TransId: 2af9640142f9ffffffffc6ce87c4
X-Mailer: Zmail v1.0
Message-ID: <202303030844412743985@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mcgrof@kernel.org>
Cc:     <keescook@chromium.org>, <yzaikin@google.com>,
        <akpm@linux-foundation.org>, <linmiaohe@huawei.com>,
        <chi.minghao@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbTogY29tcGFjdGlvbjogbGltaXQgaWxsZWdhbCBpbnB1dCBwYXJhbWV0ZXJzIG9mwqBjb21wYWN0X21lbW9yeSBpbnRlcmZhY2U=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3230ieH1020865
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64014301.001/4PSTl56ww5z501RW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Available only when CONFIG_COMPACTION is set. When 1 is written to
the file, all zones are compacted such that free memory is available
in contiguous blocks where possible.
But echo others-parameter > compact_memory, this function will be
triggered by writing parameters to the interface.

Applied this patch,
sh/$ echo 1.1 > /proc/sys/vm/compact_memory
sh/$ sh: write error: Invalid argument
The start and end time of printing triggering compact_memory.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 include/linux/compaction.h |  1 +
 kernel/sysctl.c            |  4 +++-
 mm/compaction.c            | 12 +++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 52a9ff65faee..caa24e33eeb1 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -81,6 +81,7 @@ static inline unsigned long compact_gap(unsigned int order)
 }

 #ifdef CONFIG_COMPACTION
+extern int sysctl_compact_memory;
 extern unsigned int sysctl_compaction_proactiveness;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1c240d2c99bc..39eff48ada08 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2192,10 +2192,12 @@ static struct ctl_table vm_table[] = {
 #ifdef CONFIG_COMPACTION
 	{
 		.procname	= "compact_memory",
-		.data		= NULL,
+		.data		= &sysctl_compact_memory,
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= sysctl_compaction_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "compaction_proactiveness",
diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..2c9ecc4b9d23 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2763,6 +2763,8 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }

+/* The written value is actually unused, all memory is compacted */
+int sysctl_compact_memory;
 /*
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
@@ -2770,8 +2772,16 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
 int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
-	if (write)
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (ret)
+		return ret;
+	if (write) {
+		pr_info("compact_nodes start\n");
 		compact_nodes();
+		pr_info("compact_nodes end\n");
+	}

 	return 0;
 }
-- 
2.25.1
