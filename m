Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7434D48A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiCJOK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242722AbiCJOKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:10:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E467084C;
        Thu, 10 Mar 2022 06:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921392; x=1678457392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GbR4wRPHIwdHjPFQakoEmpS8z2SMsND5ZXVQtQDRCQY=;
  b=hA3tdBhcGqi8ytuzhUBoRTMFeCQy5ZvXGDVcvVklFx9Mzoc0k7SvrL4j
   Amy+XPJ16/730KNr35FxgRBC4QC3oxZFXOm+ghs4KrywbbziPrLHW6DMP
   zUSm2WQoqqfiAVMMczYRNM1eJxMQnFEwUSUL9X81XJb6kD9hUM+FT5o4S
   cdYVBy0MwfEkzu2EaH0ctcBTxBE55ZEj491jibFFeKvyjUZJlwyzsvrwZ
   sw0xTnelQ/GaTkCU5JwvlgkPec3taTovVJMffZR5dVP6VJc6Mm/nliTQT
   zcLFstjuxtCqJ1yWExzNYrB/JF5ubpMxyCcQ7VOQ9DE92UVCaoHkneRKP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235205942"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="235205942"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554654831"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:09:44 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 02/13] mm: Introduce memfile_notifier
Date:   Thu, 10 Mar 2022 22:09:00 +0800
Message-Id: <20220310140911.50924-3-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces memfile_notifier facility so existing memory file
subsystems (e.g. tmpfs/hugetlbfs) can provide memory pages to allow a
third kernel component to make use of memory bookmarked in the memory
file and gets notified when the pages in the memory file become
allocated/invalidated.

It will be used for KVM to use a file descriptor as the guest memory
backing store and KVM will use this memfile_notifier interface to
interact with memory file subsystems. In the future there might be other
consumers (e.g. VFIO with encrypted device memory).

It consists two sets of callbacks:
  - memfile_notifier_ops: callbacks for memory backing store to notify
    KVM when memory gets allocated/invalidated.
  - memfile_pfn_ops: callbacks for KVM to call into memory backing store
    to request memory pages for guest private memory.

Userspace is in charge of guest memory lifecycle: it first allocates
pages in memory backing store and then passes the fd to KVM and lets KVM
register each memory slot to memory backing store via
memfile_register_notifier.

The supported memory backing store should maintain a memfile_notifier list
and provide routine for memfile_notifier to get the list head address and
memfile_pfn_ops callbacks for memfile_register_notifier. It also should call
memfile_notifier_fallocate/memfile_notifier_invalidate when the bookmarked
memory gets allocated/invalidated.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/memfile_notifier.h |  64 +++++++++++++++++
 mm/Kconfig                       |   4 ++
 mm/Makefile                      |   1 +
 mm/memfile_notifier.c            | 114 +++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 include/linux/memfile_notifier.h
 create mode 100644 mm/memfile_notifier.c

diff --git a/include/linux/memfile_notifier.h b/include/linux/memfile_notifier.h
new file mode 100644
index 000000000000..e8d400558adb
--- /dev/null
+++ b/include/linux/memfile_notifier.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMFILE_NOTIFIER_H
+#define _LINUX_MEMFILE_NOTIFIER_H
+
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+#include <linux/fs.h>
+
+struct memfile_notifier;
+
+struct memfile_notifier_ops {
+	void (*invalidate)(struct memfile_notifier *notifier,
+			   pgoff_t start, pgoff_t end);
+	void (*fallocate)(struct memfile_notifier *notifier,
+			  pgoff_t start, pgoff_t end);
+};
+
+struct memfile_pfn_ops {
+	long (*get_lock_pfn)(struct inode *inode, pgoff_t offset, int *order);
+	void (*put_unlock_pfn)(unsigned long pfn);
+};
+
+struct memfile_notifier {
+	struct list_head list;
+	struct memfile_notifier_ops *ops;
+};
+
+struct memfile_notifier_list {
+	struct list_head head;
+	spinlock_t lock;
+};
+
+struct memfile_backing_store {
+	struct list_head list;
+	struct memfile_pfn_ops pfn_ops;
+	struct memfile_notifier_list* (*get_notifier_list)(struct inode *inode);
+};
+
+#ifdef CONFIG_MEMFILE_NOTIFIER
+/* APIs for backing stores */
+static inline void memfile_notifier_list_init(struct memfile_notifier_list *list)
+{
+	INIT_LIST_HEAD(&list->head);
+	spin_lock_init(&list->lock);
+}
+
+extern void memfile_notifier_invalidate(struct memfile_notifier_list *list,
+					pgoff_t start, pgoff_t end);
+extern void memfile_notifier_fallocate(struct memfile_notifier_list *list,
+				       pgoff_t start, pgoff_t end);
+extern void memfile_register_backing_store(struct memfile_backing_store *bs);
+extern void memfile_unregister_backing_store(struct memfile_backing_store *bs);
+
+/*APIs for notifier consumers */
+extern int memfile_register_notifier(struct inode *inode,
+				     struct memfile_notifier *notifier,
+				     struct memfile_pfn_ops **pfn_ops);
+extern void memfile_unregister_notifier(struct inode *inode,
+					struct memfile_notifier *notifier);
+
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
+#endif /* _LINUX_MEMFILE_NOTIFIER_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f3..7c6b1ad3dade 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -892,6 +892,10 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config MEMFILE_NOTIFIER
+	bool
+	select SRCU
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 70d4309c9ce3..f628256dce0d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -132,3 +132,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
+obj-$(CONFIG_MEMFILE_NOTIFIER) += memfile_notifier.o
diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
new file mode 100644
index 000000000000..a405db56fde2
--- /dev/null
+++ b/mm/memfile_notifier.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  linux/mm/memfile_notifier.c
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *             Chao Peng <chao.p.peng@linux.intel.com>
+ */
+
+#include <linux/memfile_notifier.h>
+#include <linux/srcu.h>
+
+DEFINE_STATIC_SRCU(srcu);
+static LIST_HEAD(backing_store_list);
+
+void memfile_notifier_invalidate(struct memfile_notifier_list *list,
+				 pgoff_t start, pgoff_t end)
+{
+	struct memfile_notifier *notifier;
+	int id;
+
+	id = srcu_read_lock(&srcu);
+	list_for_each_entry_srcu(notifier, &list->head, list,
+				 srcu_read_lock_held(&srcu)) {
+		if (notifier->ops && notifier->ops->invalidate)
+			notifier->ops->invalidate(notifier, start, end);
+	}
+	srcu_read_unlock(&srcu, id);
+}
+
+void memfile_notifier_fallocate(struct memfile_notifier_list *list,
+				pgoff_t start, pgoff_t end)
+{
+	struct memfile_notifier *notifier;
+	int id;
+
+	id = srcu_read_lock(&srcu);
+	list_for_each_entry_srcu(notifier, &list->head, list,
+				 srcu_read_lock_held(&srcu)) {
+		if (notifier->ops && notifier->ops->fallocate)
+			notifier->ops->fallocate(notifier, start, end);
+	}
+	srcu_read_unlock(&srcu, id);
+}
+
+void memfile_register_backing_store(struct memfile_backing_store *bs)
+{
+	BUG_ON(!bs || !bs->get_notifier_list);
+
+	list_add_tail(&bs->list, &backing_store_list);
+}
+
+void memfile_unregister_backing_store(struct memfile_backing_store *bs)
+{
+	list_del(&bs->list);
+}
+
+static int memfile_get_notifier_info(struct inode *inode,
+				     struct memfile_notifier_list **list,
+				     struct memfile_pfn_ops **ops)
+{
+	struct memfile_backing_store *bs, *iter;
+	struct memfile_notifier_list *tmp;
+
+	list_for_each_entry_safe(bs, iter, &backing_store_list, list) {
+		tmp = bs->get_notifier_list(inode);
+		if (tmp) {
+			*list = tmp;
+			if (ops)
+				*ops = &bs->pfn_ops;
+			return 0;
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
+int memfile_register_notifier(struct inode *inode,
+			      struct memfile_notifier *notifier,
+			      struct memfile_pfn_ops **pfn_ops)
+{
+	struct memfile_notifier_list *list;
+	int ret;
+
+	if (!inode || !notifier | !pfn_ops)
+		return -EINVAL;
+
+	ret = memfile_get_notifier_info(inode, &list, pfn_ops);
+	if (ret)
+		return ret;
+
+	spin_lock(&list->lock);
+	list_add_rcu(&notifier->list, &list->head);
+	spin_unlock(&list->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(memfile_register_notifier);
+
+void memfile_unregister_notifier(struct inode *inode,
+				 struct memfile_notifier *notifier)
+{
+	struct memfile_notifier_list *list;
+
+	if (!inode || !notifier)
+		return;
+
+	BUG_ON(memfile_get_notifier_info(inode, &list, NULL));
+
+	spin_lock(&list->lock);
+	list_del_rcu(&notifier->list);
+	spin_unlock(&list->lock);
+
+	synchronize_srcu(&srcu);
+}
+EXPORT_SYMBOL_GPL(memfile_unregister_notifier);
-- 
2.17.1

