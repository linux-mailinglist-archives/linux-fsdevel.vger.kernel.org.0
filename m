Return-Path: <linux-fsdevel+bounces-60252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65682B43268
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5711C21037
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA2244685;
	Thu,  4 Sep 2025 06:31:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DE7080D;
	Thu,  4 Sep 2025 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967515; cv=none; b=X6aWOBu9c0+7S6BOLz7Ngp1b5dhK8/FHS1pxnhI5PhYLUVu459lfbUHUsFwPnWXHAYQK4vTZB1YdEoErTmfoGoyetd1b7qFe2hYjwXhSZ94nDq3AYRR1VN0ueVYCVnVB/lWkdCZQE6cfeuYdKvaugwk6U9QZJmphjJLyUxHg//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967515; c=relaxed/simple;
	bh=EoS5Vmk3YATdSi+LSx3WrFBo8LBeomC1Zgz8zqwF6x8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fepPGgeIc6kG4Go/PWKbquYXuuZXZvBwyZR01VwxmXCPF5GCdJIavgCJgdtIHtrnaaDIo5sdYn+xFRrT5pEF7zQvzTFfYv1YY8aN0WwPZOj6oEn5ai9raB9mprvKjUmArwCqChMOuAxlyLRZnAtc+YKRpT11mIFn1N6+aVnd+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cHV5z3SB2z2wBDt;
	Thu,  4 Sep 2025 14:32:55 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 72CCF140118;
	Thu,  4 Sep 2025 14:31:47 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Sep 2025 14:31:47 +0800
Received: from huawei.com (10.173.125.236) by kwepemq500010.china.huawei.com
 (7.202.194.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 14:31:46 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>
CC: <mhocko@suse.com>, <david@redhat.com>, <nao.horiguchi@gmail.com>,
	<linmiaohe@huawei.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: [PATCH] mm/hwpoison: decouple hwpoison_filter from mm/memory-failure.c
Date: Thu, 4 Sep 2025 14:22:58 +0800
Message-ID: <20250904062258.3336092-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

mm/memory-failure.c defines and uses hwpoison_filter_* parameters but the
values of those parameters can only be modified via mm/hwpoison-inject.c
from userspace. They have a potentially different life time. Decouple
those parameters from mm/memory-failure.c to fix this broken layering.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/proc/page.c       |   1 +
 mm/hwpoison-inject.c |  91 +++++++++++++++++++++++++++++++++++++
 mm/internal.h        |  12 ++---
 mm/memcontrol.c      |   1 +
 mm/memory-failure.c  | 106 +++++++------------------------------------
 5 files changed, 114 insertions(+), 97 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 46be207c5a02..8a3280810397 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -257,6 +257,7 @@ u64 stable_page_flags(const struct page *page)
 
 	return u;
 }
+EXPORT_SYMBOL_GPL(stable_page_flags);
 
 /* /proc/kpageflags - an array exposing page flags
  *
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 7ecaa1900137..a11222572f97 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -7,8 +7,96 @@
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
+#include <linux/page-flags.h>
+#include <linux/memcontrol.h>
 #include "internal.h"
 
+static u32 hwpoison_filter_enable;
+static u32 hwpoison_filter_dev_major = ~0U;
+static u32 hwpoison_filter_dev_minor = ~0U;
+static u64 hwpoison_filter_flags_mask;
+static u64 hwpoison_filter_flags_value;
+
+static int hwpoison_filter_dev(struct page *p)
+{
+	struct folio *folio = page_folio(p);
+	struct address_space *mapping;
+	dev_t dev;
+
+	if (hwpoison_filter_dev_major == ~0U &&
+	    hwpoison_filter_dev_minor == ~0U)
+		return 0;
+
+	mapping = folio_mapping(folio);
+	if (mapping == NULL || mapping->host == NULL)
+		return -EINVAL;
+
+	dev = mapping->host->i_sb->s_dev;
+	if (hwpoison_filter_dev_major != ~0U &&
+	    hwpoison_filter_dev_major != MAJOR(dev))
+		return -EINVAL;
+	if (hwpoison_filter_dev_minor != ~0U &&
+	    hwpoison_filter_dev_minor != MINOR(dev))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int hwpoison_filter_flags(struct page *p)
+{
+	if (!hwpoison_filter_flags_mask)
+		return 0;
+
+	if ((stable_page_flags(p) & hwpoison_filter_flags_mask) ==
+				    hwpoison_filter_flags_value)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+/*
+ * This allows stress tests to limit test scope to a collection of tasks
+ * by putting them under some memcg. This prevents killing unrelated/important
+ * processes such as /sbin/init. Note that the target task may share clean
+ * pages with init (eg. libc text), which is harmless. If the target task
+ * share _dirty_ pages with another task B, the test scheme must make sure B
+ * is also included in the memcg. At last, due to race conditions this filter
+ * can only guarantee that the page either belongs to the memcg tasks, or is
+ * a freed page.
+ */
+#ifdef CONFIG_MEMCG
+static u64 hwpoison_filter_memcg;
+static int hwpoison_filter_task(struct page *p)
+{
+	if (!hwpoison_filter_memcg)
+		return 0;
+
+	if (page_cgroup_ino(p) != hwpoison_filter_memcg)
+		return -EINVAL;
+
+	return 0;
+}
+#else
+static int hwpoison_filter_task(struct page *p) { return 0; }
+#endif
+
+static int hwpoison_filter(struct page *p)
+{
+	if (!hwpoison_filter_enable)
+		return 0;
+
+	if (hwpoison_filter_dev(p))
+		return -EINVAL;
+
+	if (hwpoison_filter_flags(p))
+		return -EINVAL;
+
+	if (hwpoison_filter_task(p))
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct dentry *hwpoison_dir;
 
 static int hwpoison_inject(void *data, u64 val)
@@ -67,6 +155,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
 static void __exit pfn_inject_exit(void)
 {
 	hwpoison_filter_enable = 0;
+	hwpoison_filter_unregister();
 	debugfs_remove_recursive(hwpoison_dir);
 }
 
@@ -105,6 +194,8 @@ static int __init pfn_inject_init(void)
 			   &hwpoison_filter_memcg);
 #endif
 
+	hwpoison_filter_register(hwpoison_filter);
+
 	return 0;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 45da9ff5694f..0bb0f4471673 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1227,14 +1227,10 @@ static inline bool node_reclaim_enabled(void)
 #ifdef CONFIG_MEMORY_FAILURE
 int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
 void shake_folio(struct folio *folio);
-extern int hwpoison_filter(struct page *p);
-
-extern u32 hwpoison_filter_dev_major;
-extern u32 hwpoison_filter_dev_minor;
-extern u64 hwpoison_filter_flags_mask;
-extern u64 hwpoison_filter_flags_value;
-extern u64 hwpoison_filter_memcg;
-extern u32 hwpoison_filter_enable;
+typedef int hwpoison_filter_func_t(struct page *p);
+void hwpoison_filter_register(hwpoison_filter_func_t *filter);
+void hwpoison_filter_unregister(void);
+
 #define MAGIC_HWPOISON	0x48575053U	/* HWPS */
 void SetPageHWPoisonTakenOff(struct page *page);
 void ClearPageHWPoisonTakenOff(struct page *page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9712a751690f..8dc470aa6c3c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -287,6 +287,7 @@ ino_t page_cgroup_ino(struct page *page)
 	rcu_read_unlock();
 	return ino;
 }
+EXPORT_SYMBOL_GPL(page_cgroup_ino);
 
 /* Subset of node_stat_item for memcg stats */
 static const unsigned int memcg_node_stat_items[] = {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4af8875b07b6..cebec87d9fa3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -212,106 +212,34 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 	return true;
 }
 
-#if IS_ENABLED(CONFIG_HWPOISON_INJECT)
+static hwpoison_filter_func_t __rcu *hwpoison_filter_func __read_mostly;
 
-u32 hwpoison_filter_enable = 0;
-u32 hwpoison_filter_dev_major = ~0U;
-u32 hwpoison_filter_dev_minor = ~0U;
-u64 hwpoison_filter_flags_mask;
-u64 hwpoison_filter_flags_value;
-EXPORT_SYMBOL_GPL(hwpoison_filter_enable);
-EXPORT_SYMBOL_GPL(hwpoison_filter_dev_major);
-EXPORT_SYMBOL_GPL(hwpoison_filter_dev_minor);
-EXPORT_SYMBOL_GPL(hwpoison_filter_flags_mask);
-EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
-
-static int hwpoison_filter_dev(struct page *p)
+void hwpoison_filter_register(hwpoison_filter_func_t *filter)
 {
-	struct folio *folio = page_folio(p);
-	struct address_space *mapping;
-	dev_t dev;
-
-	if (hwpoison_filter_dev_major == ~0U &&
-	    hwpoison_filter_dev_minor == ~0U)
-		return 0;
-
-	mapping = folio_mapping(folio);
-	if (mapping == NULL || mapping->host == NULL)
-		return -EINVAL;
-
-	dev = mapping->host->i_sb->s_dev;
-	if (hwpoison_filter_dev_major != ~0U &&
-	    hwpoison_filter_dev_major != MAJOR(dev))
-		return -EINVAL;
-	if (hwpoison_filter_dev_minor != ~0U &&
-	    hwpoison_filter_dev_minor != MINOR(dev))
-		return -EINVAL;
-
-	return 0;
+	rcu_assign_pointer(hwpoison_filter_func, filter);
 }
+EXPORT_SYMBOL_GPL(hwpoison_filter_register);
 
-static int hwpoison_filter_flags(struct page *p)
-{
-	if (!hwpoison_filter_flags_mask)
-		return 0;
-
-	if ((stable_page_flags(p) & hwpoison_filter_flags_mask) ==
-				    hwpoison_filter_flags_value)
-		return 0;
-	else
-		return -EINVAL;
-}
-
-/*
- * This allows stress tests to limit test scope to a collection of tasks
- * by putting them under some memcg. This prevents killing unrelated/important
- * processes such as /sbin/init. Note that the target task may share clean
- * pages with init (eg. libc text), which is harmless. If the target task
- * share _dirty_ pages with another task B, the test scheme must make sure B
- * is also included in the memcg. At last, due to race conditions this filter
- * can only guarantee that the page either belongs to the memcg tasks, or is
- * a freed page.
- */
-#ifdef CONFIG_MEMCG
-u64 hwpoison_filter_memcg;
-EXPORT_SYMBOL_GPL(hwpoison_filter_memcg);
-static int hwpoison_filter_task(struct page *p)
+void hwpoison_filter_unregister(void)
 {
-	if (!hwpoison_filter_memcg)
-		return 0;
-
-	if (page_cgroup_ino(p) != hwpoison_filter_memcg)
-		return -EINVAL;
-
-	return 0;
+	RCU_INIT_POINTER(hwpoison_filter_func, NULL);
+	synchronize_rcu();
 }
-#else
-static int hwpoison_filter_task(struct page *p) { return 0; }
-#endif
+EXPORT_SYMBOL_GPL(hwpoison_filter_unregister);
 
-int hwpoison_filter(struct page *p)
+static int hwpoison_filter(struct page *p)
 {
-	if (!hwpoison_filter_enable)
-		return 0;
-
-	if (hwpoison_filter_dev(p))
-		return -EINVAL;
-
-	if (hwpoison_filter_flags(p))
-		return -EINVAL;
+	int ret = 0;
+	hwpoison_filter_func_t *filter;
 
-	if (hwpoison_filter_task(p))
-		return -EINVAL;
+	rcu_read_lock();
+	filter = rcu_dereference(hwpoison_filter_func);
+	if (filter)
+		ret = filter(p);
+	rcu_read_unlock();
 
-	return 0;
-}
-EXPORT_SYMBOL_GPL(hwpoison_filter);
-#else
-int hwpoison_filter(struct page *p)
-{
-	return 0;
+	return ret;
 }
-#endif
 
 /*
  * Kill all processes that have a poisoned page mapped and then isolate
-- 
2.33.0


