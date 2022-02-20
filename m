Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC454BCCE2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiBTGH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:07:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiBTGHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:07:25 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC591004
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:07:04 -0800 (PST)
X-QQ-mid: bizesmtp88t1645337208t7nkhfkg
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:06:33 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: d3XYZ9avhmAtY8bKX2/d7LpBuqdLrdgaVpVdorzRFP1KIykOsY0uqX7+VH2MI
        6bcYkZM/2LQgM1uL/YpI8EvW8EoP2rWGqRlW/+agsMpI4yEY6x64pIBGOf0F0iMnbGsDVeg
        4mVODKp39iheZu9YCLOWvbhtTSX5JBGxDg9vlgAkY1sOsKL2qtPUT53Of791wLzTsKGrBTA
        U+Z0SkLJqznMM6JR0jmH0OKKi73aq0+U3Z6OQeU7wwU5kkgtmF71wUQHg92QPVDOaZ0jbbU
        gwRhd4t74rsPTE1IrA2bzHonEcAR+UU0Z4jPni66V9hZboyC00ffLqD5B1ydYTkiKvKGQ48
        j540cPL1Re4R5MigM6JXDuzvzrUHc4JcGOLAZVD
X-QQ-GoodBg: 1
From:   tangmeng <tangmeng@uniontech.com>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 10/11] fs/drop_caches: move drop_caches sysctls to its own file
Date:   Sun, 20 Feb 2022 14:06:26 +0800
Message-Id: <20220220060626.15885-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

All filesystem syctls now get reviewed by fs folks. This commit
follows the commit of fs, move the drop_caches sysctls to its own file,
fs/drop_caches.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 fs/drop_caches.c   | 26 ++++++++++++++++++++++++--
 include/linux/mm.h |  6 ------
 kernel/sysctl.c    |  9 ---------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..5e044a2d75ef 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -13,7 +13,7 @@
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
-int sysctl_drop_caches;
+static int sysctl_drop_caches;
 
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
@@ -47,7 +47,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	iput(toput_inode);
 }
 
-int drop_caches_sysctl_handler(struct ctl_table *table, int write,
+static int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret;
@@ -75,3 +75,25 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 	}
 	return 0;
 }
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_drop_caches_table[] = {
+	{
+		.procname       = "drop_caches",
+		.data           = &sysctl_drop_caches,
+		.maxlen         = sizeof(int),
+		.mode           = 0200,
+		.proc_handler   = drop_caches_sysctl_handler,
+		.extra1         = SYSCTL_ONE,
+		.extra2         = SYSCTL_FOUR,
+	},
+	{ }
+};
+
+static __init int vm_drop_caches_sysctls_init(void)
+{
+	register_sysctl_init("vm", vm_drop_caches_table);
+	return 0;
+}
+late_initcall(vm_drop_caches_sysctls_init);
+#endif /* CONFIG_SYSCTL */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c3c7cb58c847..775befb2786b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3126,12 +3126,6 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 
 extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
 
-#ifdef CONFIG_SYSCTL
-extern int sysctl_drop_caches;
-int drop_caches_sysctl_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-#endif
-
 void drop_slab(void);
 
 #ifndef CONFIG_MMU
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b51b0b92fdc1..657b7bfe38f6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2182,15 +2182,6 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= lowmem_reserve_ratio_sysctl_handler,
 	},
-	{
-		.procname	= "drop_caches",
-		.data		= &sysctl_drop_caches,
-		.maxlen		= sizeof(int),
-		.mode		= 0200,
-		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_FOUR,
-	},
 #ifdef CONFIG_COMPACTION
 	{
 		.procname	= "compact_memory",
-- 
2.20.1



