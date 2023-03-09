Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85D96B1A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 04:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCIDo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 22:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCIDow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:44:52 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520AAB0BD;
        Wed,  8 Mar 2023 19:44:51 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PXFS23Pzlz501SW;
        Thu,  9 Mar 2023 11:44:50 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3293il2t098221;
        Thu, 9 Mar 2023 11:44:47 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 9 Mar 2023 11:44:48 +0800 (CST)
Date:   Thu, 9 Mar 2023 11:44:48 +0800 (CST)
X-Zmail-TransId: 2afa64095630232b9d7c
X-Mailer: Zmail v1.0
Message-ID: <202303091144483856804@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mcgrof@kernel.org>
Cc:     <keescook@chromium.org>, <yzaikin@google.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIFYzIDEvMl0gbW06IGNvbXBhY3Rpb246IG1vdmUgY29tcGFjdF9tZW1vcnkgc3lzY3RsIHRvIGl0cyBvd24gZmlsZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3293il2t098221
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64095632.000/4PXFS23Pzlz501SW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The compact_memory is part of compaction, move it to its own file.

Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 kernel/sysctl.c |  7 -------
 mm/compaction.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c14552a662ae..f574f9985df4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2190,13 +2190,6 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_FOUR,
 	},
 #ifdef CONFIG_COMPACTION
-	{
-		.procname	= "compact_memory",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0200,
-		.proc_handler	= sysctl_compaction_handler,
-	},
 	{
 		.procname	= "compaction_proactiveness",
 		.data		= &sysctl_compaction_proactiveness,
diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..acbda28c11f4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2763,6 +2763,18 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }

+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_compact_memory[] = {
+	{
+		.procname	= "compact_memory",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0200,
+		.proc_handler	= sysctl_compaction_handler,
+	},
+	{ }
+};
+#endif
 /*
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
@@ -3078,6 +3090,9 @@ static int __init kcompactd_init(void)

 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", vm_compact_memory);
+#endif
 	return 0;
 }
 subsys_initcall(kcompactd_init)
-- 
2.25.1
