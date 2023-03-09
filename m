Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39416B238A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjCIMAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjCIL7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:59:39 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C783C643E;
        Thu,  9 Mar 2023 03:59:37 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PXSQl5b4qzKmb9;
        Thu,  9 Mar 2023 19:59:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 19:59:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
Date:   Thu, 9 Mar 2023 20:20:11 +0800
Message-ID: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves all hugetlb sysctls to its own file, also kill an
useless hugetlb_treat_movable_handler() defination.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/hugetlb.h |  8 -------
 kernel/sysctl.c         | 32 --------------------------
 mm/hugetlb.c            | 51 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7c977d234aba..4056b05d81ed 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -124,14 +124,6 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
 
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
-int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
-int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     struct vm_area_struct *new_vma,
 			     unsigned long old_addr, unsigned long new_addr,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c14552a662ae..ce0297acf97c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2140,38 +2140,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-#endif
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
-	 {
-		.procname	= "hugetlb_shm_group",
-		.data		= &sysctl_hugetlb_shm_group,
-		.maxlen		= sizeof(gid_t),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	 },
-	{
-		.procname	= "nr_overcommit_hugepages",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= hugetlb_overcommit_handler,
-	},
 #endif
 	{
 		.procname	= "lowmem_reserve_ratio",
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 712e32b38295..c44958a0f586 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4202,6 +4202,12 @@ static void __init hugetlb_sysfs_init(void)
 	hugetlb_register_all_nodes();
 }
 
+#ifdef CONFIG_SYSCTL
+static void hugetlb_sysctl_init(void);
+#else
+static inline void hugetlb_sysctl_init(void) { }
+#endif
+
 static int __init hugetlb_init(void)
 {
 	int i;
@@ -4257,6 +4263,7 @@ static int __init hugetlb_init(void)
 
 	hugetlb_sysfs_init();
 	hugetlb_cgroup_file_init();
+	hugetlb_sysctl_init();
 
 #ifdef CONFIG_SMP
 	num_fault_mutexes = roundup_pow_of_two(8 * num_possible_cpus());
@@ -4588,7 +4595,7 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	return ret;
 }
 
-int hugetlb_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 
@@ -4597,7 +4604,7 @@ int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_NUMA
-int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 	return hugetlb_sysctl_handler_common(true, table, write,
@@ -4605,7 +4612,7 @@ int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_NUMA */
 
-int hugetlb_overcommit_handler(struct ctl_table *table, int write,
+static int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;
@@ -4634,6 +4641,44 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
+static struct ctl_table hugetlb_table[] = {
+	{
+		.procname	= "nr_hugepages",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= hugetlb_sysctl_handler,
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
+		.procname	= "hugetlb_shm_group",
+		.data		= &sysctl_hugetlb_shm_group,
+		.maxlen		= sizeof(gid_t),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "nr_overcommit_hugepages",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= hugetlb_overcommit_handler,
+	},
+	{ }
+};
+
+static void hugetlb_sysctl_init(void)
+{
+	register_sysctl_init("vm", hugetlb_table);
+}
 #endif /* CONFIG_SYSCTL */
 
 void hugetlb_report_meminfo(struct seq_file *m)
-- 
2.35.3

