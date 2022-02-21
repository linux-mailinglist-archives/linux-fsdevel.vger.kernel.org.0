Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC64BD5FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbiBUGLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 01:11:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243297AbiBUGLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:11:18 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972AEB90
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Feb 2022 22:10:55 -0800 (PST)
X-QQ-mid: bizesmtp73t1645423837tkkosvs0
Received: from localhost.localdomain (unknown [49.93.178.145])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 21 Feb 2022 14:10:30 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: Mzskoac49Oga6mWqGP2ryQuTJrcG2WY/Vo+No46qhrSPLWn5pnT1993SsPCFO
        QnjoRdKt2DZGlAjKy2PSvP5JqgfAeJHiKheX+i05yD4tdRmh0yZB4dDqGRFW//K1dy6MKx1
        9t12PQcqQggf8FBeDUDwC3s+IbNRY4h42QBdY/GBpUkZIJH66DMAmiBAWnGb9n8vOXE6NbL
        TZPj+mttyBksu16hLRgUSJ1+TUXabDIJ6h6ZHquzayPfaRBITd892SgmcypLFwWJBGpZK+S
        if5SF50Qr3hlD1NMWZHsauoPMZ6eKYPs2k9B6QlhNcwpqH8SN5c9jtnl+xipzXUnadLroSt
        3vCZzSbnnyjp7UeiImi3PpqFcqtQKpK286yWcex
X-QQ-GoodBg: 1
From:   tangmeng <tangmeng@uniontech.com>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v2 10/11] fs/drop_caches: move drop_caches sysctls to its own file
Date:   Mon, 21 Feb 2022 14:10:18 +0800
Message-Id: <20220221061018.10472-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
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
 fs/drop_caches.c   | 24 ++++++++++++++++++++++--
 include/linux/mm.h |  6 ------
 kernel/sysctl.c    |  9 ---------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..44f5539dd217 100644
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
@@ -75,3 +75,23 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 	}
 	return 0;
 }
+
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



