Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6537352D818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiESPmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbiESPlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:41:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95AB11165;
        Thu, 19 May 2022 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652974862; x=1684510862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=49mb/GltcH6nA8QEGlkGIdXHf0vHEoxsK6D1ddR+MDc=;
  b=Qlz8yMViL2m7NXNYBIcSYLIREMPWeEYW0+2Ql+QvL4bG5UAKY6mTmDQS
   YaFlL9pQRXa0p3Z16PrkhQyHPHo2J8jDL/aR3y7zPIbIRMG1vwIY1N3Y8
   0MeDCiKJvJxDovjph/5V59WNxUR/RnOL/dhnDCddVxfRpr3srTKP4s0xK
   cV6YA+PkWKtHqZdNdqfx69UmMaKXwKho+/pmGBN0yhMsRw6kbrkXhGYXO
   qopCQ9ToCO+tBA/TgAYuz8YP+d5nDlqrmHcSc8AoJnxgmC2Biw0UrhC0D
   PdgqMkGAWCCiH0UZ1urINBK7COVummZ74WPImHfWLSN9dekSHrqsJkJ+p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="271071667"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="271071667"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598635041"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2022 08:40:51 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: [PATCH v6 1/8] mm: Introduce memfile_notifier
Date:   Thu, 19 May 2022 23:37:06 +0800
Message-Id: <20220519153713.819591-2-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

It consists below components:
 - memfile_backing_store: Each supported memory file subsystem can be
   implemented as a memory backing store which bookmarks memory and
   provides callbacks for other kernel systems (memfile_notifier
   consumers) to interact with.
 - memfile_notifier: memfile_notifier consumers defines callbacks and
   associate them to a file using memfile_register_notifier().
 - memfile_node: A memfile_node is associated with the file (inode) from
   the backing store and includes feature flags and a list of registered
   memfile_notifier for notifying.

Userspace is in charge of guest memory lifecycle: it first allocates
pages in memory backing store and then passes the fd to KVM and lets KVM
register memory slot to memory backing store via memfile_register_notifier.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/memfile_notifier.h |  99 ++++++++++++++++++++++
 mm/Kconfig                       |   4 +
 mm/Makefile                      |   1 +
 mm/memfile_notifier.c            | 137 +++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+)
 create mode 100644 include/linux/memfile_notifier.h
 create mode 100644 mm/memfile_notifier.c

diff --git a/include/linux/memfile_notifier.h b/include/linux/memfile_notifier.h
new file mode 100644
index 000000000000..dcb3ee6ed626
--- /dev/null
+++ b/include/linux/memfile_notifier.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMFILE_NOTIFIER_H
+#define _LINUX_MEMFILE_NOTIFIER_H
+
+#include <linux/pfn_t.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+#include <linux/fs.h>
+
+
+#define MEMFILE_F_USER_INACCESSIBLE	BIT(0)	/* memory allocated in the file is inaccessible from userspace (e.g. read/write/mmap) */
+#define MEMFILE_F_UNMOVABLE		BIT(1)	/* memory allocated in the file is unmovable (e.g. via pagemigration)*/
+#define MEMFILE_F_UNRECLAIMABLE		BIT(2)	/* memory allocated in the file is unreclaimable (e.g. via kswapd) */
+
+#define MEMFILE_F_ALLOWED_MASK		(MEMFILE_F_USER_INACCESSIBLE | \
+					MEMFILE_F_UNMOVABLE | \
+					MEMFILE_F_UNRECLAIMABLE)
+
+struct memfile_node {
+	struct list_head	notifiers;	/* registered memfile_notifier list on the file */
+	unsigned long		flags;		/* MEMFILE_F_* flags */
+};
+
+struct memfile_backing_store {
+	struct list_head list;
+	spinlock_t lock;
+	struct memfile_node* (*lookup_memfile_node)(struct file *file);
+	int (*get_lock_pfn)(struct file *file, pgoff_t offset, pfn_t *pfn,
+			    int *order);
+	void (*put_unlock_pfn)(pfn_t pfn);
+};
+
+struct memfile_notifier;
+struct memfile_notifier_ops {
+	void (*populate)(struct memfile_notifier *notifier,
+			 pgoff_t start, pgoff_t end);
+	void (*invalidate)(struct memfile_notifier *notifier,
+			   pgoff_t start, pgoff_t end);
+};
+
+struct memfile_notifier {
+	struct list_head list;
+	struct memfile_notifier_ops *ops;
+	struct memfile_backing_store *bs;
+};
+
+static inline void memfile_node_init(struct memfile_node *node)
+{
+	INIT_LIST_HEAD(&node->notifiers);
+	node->flags = 0;
+}
+
+#ifdef CONFIG_MEMFILE_NOTIFIER
+/* APIs for backing stores */
+extern void memfile_register_backing_store(struct memfile_backing_store *bs);
+extern int memfile_node_set_flags(struct file *file, unsigned long flags);
+extern void memfile_notifier_populate(struct memfile_node *node,
+				      pgoff_t start, pgoff_t end);
+extern void memfile_notifier_invalidate(struct memfile_node *node,
+					pgoff_t start, pgoff_t end);
+/*APIs for notifier consumers */
+extern int memfile_register_notifier(struct file *file, unsigned long flags,
+				     struct memfile_notifier *notifier);
+extern void memfile_unregister_notifier(struct memfile_notifier *notifier);
+
+#else /* !CONFIG_MEMFILE_NOTIFIER */
+static void memfile_register_backing_store(struct memfile_backing_store *bs)
+{
+}
+
+static int memfile_node_set_flags(struct file *file, unsigned long flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static void memfile_notifier_populate(struct memfile_node *node,
+				      pgoff_t start, pgoff_t end)
+{
+}
+
+static void memfile_notifier_invalidate(struct memfile_node *node,
+					pgoff_t start, pgoff_t end)
+{
+}
+
+static int memfile_register_notifier(struct file *file, flags,
+				     struct memfile_notifier *notifier)
+{
+	return -EOPNOTSUPP;
+}
+
+static void memfile_unregister_notifier(struct memfile_notifier *notifier)
+{
+}
+
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
+#endif /* _LINUX_MEMFILE_NOTIFIER_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..e551e99cd42a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -909,6 +909,10 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config MEMFILE_NOTIFIER
+	bool
+	select SRCU
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 4cc13f3179a5..261a5cb315f9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -133,3 +133,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
+obj-$(CONFIG_MEMFILE_NOTIFIER) += memfile_notifier.o
diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
new file mode 100644
index 000000000000..ab9461cb874e
--- /dev/null
+++ b/mm/memfile_notifier.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  linux/mm/memfile_notifier.c
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *             Chao Peng <chao.p.peng@linux.intel.com>
+ */
+
+#include <linux/memfile_notifier.h>
+#include <linux/pagemap.h>
+#include <linux/srcu.h>
+
+DEFINE_STATIC_SRCU(memfile_srcu);
+static __ro_after_init LIST_HEAD(backing_store_list);
+
+void memfile_notifier_populate(struct memfile_node *node,
+			       pgoff_t start, pgoff_t end)
+{
+	struct memfile_notifier *notifier;
+	int id;
+
+	id = srcu_read_lock(&memfile_srcu);
+	list_for_each_entry_srcu(notifier, &node->notifiers, list,
+				 srcu_read_lock_held(&memfile_srcu)) {
+		if (notifier->ops->populate)
+			notifier->ops->populate(notifier, start, end);
+	}
+	srcu_read_unlock(&memfile_srcu, id);
+}
+
+void memfile_notifier_invalidate(struct memfile_node *node,
+				 pgoff_t start, pgoff_t end)
+{
+	struct memfile_notifier *notifier;
+	int id;
+
+	id = srcu_read_lock(&memfile_srcu);
+	list_for_each_entry_srcu(notifier, &node->notifiers, list,
+				 srcu_read_lock_held(&memfile_srcu)) {
+		if (notifier->ops->invalidate)
+			notifier->ops->invalidate(notifier, start, end);
+	}
+	srcu_read_unlock(&memfile_srcu, id);
+}
+
+void __init memfile_register_backing_store(struct memfile_backing_store *bs)
+{
+	spin_lock_init(&bs->lock);
+	list_add_tail(&bs->list, &backing_store_list);
+}
+
+static void memfile_node_update_flags(struct file *file, unsigned long flags)
+{
+	struct address_space *mapping = file_inode(file)->i_mapping;
+	gfp_t gfp;
+
+	gfp = mapping_gfp_mask(mapping);
+	if (flags & MEMFILE_F_UNMOVABLE)
+		gfp &= ~__GFP_MOVABLE;
+	else
+		gfp |= __GFP_MOVABLE;
+	mapping_set_gfp_mask(mapping, gfp);
+
+	if (flags & MEMFILE_F_UNRECLAIMABLE)
+		mapping_set_unevictable(mapping);
+	else
+		mapping_clear_unevictable(mapping);
+}
+
+int memfile_node_set_flags(struct file *file, unsigned long flags)
+{
+	struct memfile_backing_store *bs;
+	struct memfile_node *node;
+
+	if (flags & ~MEMFILE_F_ALLOWED_MASK)
+		return -EINVAL;
+
+	list_for_each_entry(bs, &backing_store_list, list) {
+		node = bs->lookup_memfile_node(file);
+		if (node) {
+			spin_lock(&bs->lock);
+			node->flags = flags;
+			spin_unlock(&bs->lock);
+			memfile_node_update_flags(file, flags);
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+int memfile_register_notifier(struct file *file, unsigned long flags,
+			      struct memfile_notifier *notifier)
+{
+	struct memfile_backing_store *bs;
+	struct memfile_node *node;
+	struct list_head *list;
+
+	if (!file || !notifier || !notifier->ops)
+		return -EINVAL;
+	if (flags & ~MEMFILE_F_ALLOWED_MASK)
+		return -EINVAL;
+
+	list_for_each_entry(bs, &backing_store_list, list) {
+		node = bs->lookup_memfile_node(file);
+		if (node) {
+			list = &node->notifiers;
+			notifier->bs = bs;
+
+			spin_lock(&bs->lock);
+			if (list_empty(list))
+				node->flags = flags;
+			else if (node->flags ^ flags) {
+				spin_unlock(&bs->lock);
+				return -EINVAL;
+			}
+
+			list_add_rcu(&notifier->list, list);
+			spin_unlock(&bs->lock);
+			memfile_node_update_flags(file, flags);
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(memfile_register_notifier);
+
+void memfile_unregister_notifier(struct memfile_notifier *notifier)
+{
+	spin_lock(&notifier->bs->lock);
+	list_del_rcu(&notifier->list);
+	spin_unlock(&notifier->bs->lock);
+
+	synchronize_srcu(&memfile_srcu);
+}
+EXPORT_SYMBOL_GPL(memfile_unregister_notifier);
-- 
2.25.1

