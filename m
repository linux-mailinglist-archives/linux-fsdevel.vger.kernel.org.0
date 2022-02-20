Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249BF4BCCDA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242121AbiBTGC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:02:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241890AbiBTGCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:02:23 -0500
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F22F1B
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:02:02 -0800 (PST)
X-QQ-mid: bizesmtp79t1645336906taxdyayp
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:01:40 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: F3yR32iATbgAptDoI3vmu8Pc5GgqoUhffNL6Adxaif3ZyUAw/CPtH+G9srbBJ
        w9hjWWP8XIyr1+M+HNwMJYFh0vBx/e58dqRnDdtWoEmYGz93YRrJpmqqg8rO6ODwNGYgQLo
        k27/YHfZ963q4G4gUn5SpB7Ngo/i3arw6Cgm9PSIFvPjHimr+rkhn8ARu/fMKBjJHJQVCqs
        ONnGnrfcOO40PxF1Ip83my/8cz01L9L/mdH4jHdfEQudKDBRDJL0QmxJT3xWjZGQJ7XyZ5I
        dBmdRt9Ul/ZpxzksMqdFEu/0/WegvObicpc3+dn7Cp5UY5Vb8GzQbH2sTLJKFBmLXFlsjd8
        rTBAaWFrQg9lky10nKQVvbQbxA6qfLGsssylv/wQK7mkHquf0A=
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 08/11] mm/hugetlb: move hugetlib sysctls to its own file
Date:   Sun, 20 Feb 2022 14:01:36 +0800
Message-Id: <20220220060136.14001-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
follows the commit of fs, move the hugetlb sysctls to its own file,
mm/hugetlb.c.

'hugetlb_treat_movable_handler' is not currently used, so only delete
it from the linux/hugetlb.h.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/hugetlb.h |  8 --------
 kernel/sysctl.c         | 26 ------------------------
 mm/hugetlb.c            | 44 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f307e1963851..bf807418828a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -13,7 +13,6 @@
 #include <linux/gfp.h>
 #include <linux/userfaultfd_k.h>
 
-struct ctl_table;
 struct user_struct;
 struct mmu_gather;
 
@@ -125,13 +124,6 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
 
 void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
-int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
-int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
 
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     struct vm_area_struct *new_vma,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index dc5e313c9e6b..1a1504862f4f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -43,7 +43,6 @@
 #include <linux/writeback.h>
 #include <linux/ratelimit.h>
 #include <linux/compaction.h>
-#include <linux/hugetlb.h>
 #include <linux/initrd.h>
 #include <linux/key.h>
 #include <linux/times.h>
@@ -2176,31 +2175,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO_HUNDRED,
 	},
-#ifdef CONFIG_HUGETLB_PAGE
-	{
-		.procname	= "nr_hugepages",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= hugetlb_sysctl_handler,
-	},
-#ifdef CONFIG_NUMA
-	{
-		.procname       = "nr_hugepages_mempolicy",
-		.data           = NULL,
-		.maxlen         = sizeof(unsigned long),
-		.mode           = 0644,
-		.proc_handler   = &hugetlb_mempolicy_sysctl_handler,
-	},
-#endif
-	{
-		.procname	= "nr_overcommit_hugepages",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= hugetlb_overcommit_handler,
-	},
-#endif
 	{
 		.procname	= "lowmem_reserve_ratio",
 		.data		= &sysctl_lowmem_reserve_ratio,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61895cc01d09..2b1da0c0871b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4359,7 +4359,7 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	return ret;
 }
 
-int hugetlb_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 
@@ -4368,7 +4368,7 @@ int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_NUMA
-int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 	return hugetlb_sysctl_handler_common(true, table, write,
@@ -4376,7 +4376,7 @@ int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_NUMA */
 
-int hugetlb_overcommit_handler(struct ctl_table *table, int write,
+static int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;
@@ -7028,3 +7028,41 @@ void __init hugetlb_cma_check(void)
 }
 
 #endif /* CONFIG_CMA */
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_mm_hugetlb_table[] = {
+#ifdef CONFIG_HUGETLB_PAGE
+	{
+		.procname       = "nr_hugepages",
+		.data           = NULL,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = hugetlb_sysctl_handler,
+	},
+#ifdef CONFIG_NUMA
+	{
+		.procname       = "nr_hugepages_mempolicy",
+		.data           = NULL,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = &hugetlb_mempolicy_sysctl_handler,
+	},
+#endif
+	{
+		.procname       = "nr_overcommit_hugepages",
+		.data           = NULL,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = hugetlb_overcommit_handler,
+	},
+#endif
+	{ }
+};
+
+static __init int vm_mm_hugetlb_sysctls_init(void)
+{
+	register_sysctl_init("vm", vm_mm_hugetlb_table);
+	return 0;
+}
+late_initcall(vm_mm_hugetlb_sysctls_init);
+#endif
-- 
2.20.1



