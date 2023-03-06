Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CF6AB63A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 07:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCFGHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 01:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFGHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:07:42 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E54D53A;
        Sun,  5 Mar 2023 22:07:41 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PVSmB5TSFz8R045;
        Mon,  6 Mar 2023 14:07:38 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 32667VdM030718;
        Mon, 6 Mar 2023 14:07:31 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 6 Mar 2023 14:07:33 +0800 (CST)
Date:   Mon, 6 Mar 2023 14:07:33 +0800 (CST)
X-Zmail-TransId: 2af9640583252cc16a09
X-Mailer: Zmail v1.0
Message-ID: <202303061407332798543@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mcgrof@kernel.org>
Cc:     <keescook@chromium.org>, <yzaikin@google.com>,
        <akpm@linux-foundation.org>, <linmiaohe@huawei.com>,
        <chi.minghao@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: =?UTF-8?B?W1BBVENIIFYyIDEvMl0gc3lzY3RsOiBMaW1pdCB0aGUgdmFsdWUgb2YgaW50ZXJmYWNlIGNvbXBhY3RfbWVtb3J5?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32667VdM030718
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6405832A.001 by FangMail milter!
X-FangMail-Envelope: 1678082858/4PVSmB5TSFz8R045/6405832A.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6405832A.001/4PVSmB5TSFz8R045
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

In Documentation/admin-guide/sysctl/vm.rst:109 say: when 1 is written
to the file, all zones are compacted such that free memory is available
in contiguous blocks where possible.
So limit the value of interface compact_memory to 1.

Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

---
 include/linux/compaction.h | 1 +
 kernel/sysctl.c            | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index c14552a662ae..67f70952f71a 100644
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
-- 
2.25.1
