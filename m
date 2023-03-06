Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D139E6AB632
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 07:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCFGFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 01:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFGFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:05:34 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023CD501;
        Sun,  5 Mar 2023 22:05:32 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PVSjf5xhbz8R039;
        Mon,  6 Mar 2023 14:05:26 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 32665MLc022828;
        Mon, 6 Mar 2023 14:05:22 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 6 Mar 2023 14:05:24 +0800 (CST)
Date:   Mon, 6 Mar 2023 14:05:24 +0800 (CST)
X-Zmail-TransId: 2af9640582a423e10981
X-Mailer: Zmail v1.0
Message-ID: <202303061405242788477@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mcgrof@kernel.org>
Cc:     <keescook@chromium.org>, <yzaikin@google.com>,
        <akpm@linux-foundation.org>, <linmiaohe@huawei.com>,
        <chi.minghao@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: =?UTF-8?B?W1BBVENIIFYyIDIvMl0gbW06IGNvbXBhY3Rpb246IExpbWl0IHRoZSB2YWx1ZSBvZiBpbnRlcmZhY2UgY29tcGFjdF9tZW1vcnk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 32665MLc022828
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 640582A6.000 by FangMail milter!
X-FangMail-Envelope: 1678082726/4PVSjf5xhbz8R039/640582A6.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 640582A6.000/4PVSjf5xhbz8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 mm/compaction.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

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
