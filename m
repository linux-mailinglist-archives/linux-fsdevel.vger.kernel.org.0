Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A170A492710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbiARNWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:22:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:39173 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242770AbiARNWZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512145; x=1674048145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2dspJZW+Fb695a/O+SFc/x1OjrhtU2wFDKh4IAY6Z+0=;
  b=Ur9EbbS9kRJk3v/TllxHENI9vfURgz3Avs/eDlnVR0r2RXOKEbYxWMmu
   48n/YIFEEgEda8WDrF/S49UrXP/oHYHvcbo3mTRG/4IpDzrvRk/ANH0Tk
   IRpxw8nrMmyKGflB1wYvpCqs7rgILSPkdr3k8wt7rWrNpoYYnbhDHI1pK
   pN19u58VVxPcwJkwJQL6Y7Bdd/sHo/H8otp5fzSQxGj29Tzewoom3PNxL
   lpJ7l+IaNVQPESv4mSD2g57xZrz+/sZ8qzVHOur6ErScKDEyZCWysUF9E
   LlO8YWnW9PEnOtkxyeTqyGC8IE55Ivqa8Idbb45TEBZni8dFMrCSwboOt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244609329"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="244609329"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791700"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:22:13 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v4 03/12] mm: Introduce memfile_notifier
Date:   Tue, 18 Jan 2022 21:21:12 +0800
Message-Id: <20220118132121.31388-4-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/memfile_notifier.h | 53 +++++++++++++++++++
 mm/Kconfig                       |  4 ++
 mm/Makefile                      |  1 +
 mm/memfile_notifier.c            | 89 ++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 include/linux/memfile_notifier.h
 create mode 100644 mm/memfile_notifier.c

diff --git a/include/linux/memfile_notifier.h b/include/linux/memfile_notifier.h
new file mode 100644
index 000000000000..a03bebdd1322
--- /dev/null
+++ b/include/linux/memfile_notifier.h
@@ -0,0 +1,53 @@
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
+#ifdef CONFIG_MEMFILE_NOTIFIER
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
index 28edafc820ad..fa31eda3c895 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -900,6 +900,10 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+config MEMFILE_NOTIFIER
+	bool
+	select SRCU
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0..80588f7c3bc2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
+obj-$(CONFIG_MEMFILE_NOTIFIER) += memfile_notifier.o
diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
new file mode 100644
index 000000000000..8171d4601a04
--- /dev/null
+++ b/mm/memfile_notifier.c
@@ -0,0 +1,89 @@
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
+static int memfile_get_notifier_info(struct inode *inode,
+				     struct memfile_notifier_list **list,
+				     struct memfile_pfn_ops **ops)
+{
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

