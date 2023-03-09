Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237866B1A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 04:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCIDnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 22:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCIDnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:43:06 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86C2311D;
        Wed,  8 Mar 2023 19:43:04 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PXFPy47qkz501RG;
        Thu,  9 Mar 2023 11:43:02 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3293gufG096296;
        Thu, 9 Mar 2023 11:42:56 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 9 Mar 2023 11:42:58 +0800 (CST)
Date:   Thu, 9 Mar 2023 11:42:58 +0800 (CST)
X-Zmail-TransId: 2afa640955c2ffffffffd6cb58bb
X-Mailer: Zmail v1.0
Message-ID: <202303091142580726760@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mcgrof@kernel.org>
Cc:     <keescook@chromium.org>, <yzaikin@google.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: =?UTF-8?B?W1BBVENIIFYzIDIvMl0gbW06IGNvbXBhY3Rpb246IGxpbWl0IGlsbGVnYWwgaW5wdXQgcGFyYW1ldGVycyBvZsKgY29tcGFjdF9tZW1vcnkgaW50ZXJmYWNl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3293gufG096296
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 640955C6.000/4PXFPy47qkz501RG
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

Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 mm/compaction.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index acbda28c11f4..39f4c8a6f843 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2762,15 +2762,18 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,

 	return 0;
 }
+static int sysctl_compact_memory;

 #ifdef CONFIG_SYSCTL
 static struct ctl_table vm_compact_memory[] = {
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
 	{ }
 };
@@ -2782,6 +2785,11 @@ static struct ctl_table vm_compact_memory[] = {
 int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (ret)
+		return ret;
 	if (write)
 		compact_nodes();

-- 
2.25.1
