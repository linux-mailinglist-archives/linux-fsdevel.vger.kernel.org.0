Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD3568131
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiGFIYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiGFIYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:24:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751502317C;
        Wed,  6 Jul 2022 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095859; x=1688631859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4RqYsqOgMgPs4JDgf0SUKlW6JB5EWiu8UDnwronwhT8=;
  b=Fp6nN8p46kB/kFuRh3LhdQL+ikFtUaqnd7wgLeyZc4jRRwQIhK0jrhgQ
   GOk/qXDMDyOqRnTkO8snt/j3AdHD2qSJr3da+AFfLCOLr/71b+ysABvpy
   EPqaWiyNAl2mfPGufH52Ufnd0/GPf/eSRyibIxmcc5z1OYIvL2hY3cpcg
   fUwRiVCr+M3ik96XH5WzZJ6lh/iZXiLJ5Fbte1VRlhzmIjTHjc9yMQf0f
   IZGPlCgZpo0fw2DnoPenSCd+kQefFcP6+puQZIQrh2I1e1Ci57vl7xiC8
   6che/8V4HAy5yt6oHI5dF1mskXnS4ezVg9ZYM0kBqiTZa4c/yognJgSJb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266709759"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="266709759"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567967876"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:24:08 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 03/14] mm: Introduce memfile_notifier
Date:   Wed,  6 Jul 2022 16:20:05 +0800
Message-Id: <20220706082016.2603916-4-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces memfile_notifier facility so existing memory file
subsystems (e.g. tmpfs/hugetlbfs) can provide memory pages to allow a
third kernel component to make use of memory bookmarked in the memory
file and gets notified when the pages in the memory file become
invalidated.

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

In KVM usages, userspace is in charge of guest memory lifecycle: it first
allocates pages in memory backing store and then passes the fd to KVM and
lets KVM register memory slot to memory backing store via
memfile_register_notifier.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/memfile_notifier.h |  93 ++++++++++++++++++++++++
 mm/Kconfig                       |   4 +
 mm/Makefile                      |   1 +
 mm/memfile_notifier.c            | 121 +++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 include/linux/memfile_notifier.h
 create mode 100644 mm/memfile_notifier.c

diff --git a/include/linux/memfile_notifier.h b/include/linux/memfile_notifier.h
new file mode 100644
index 000000000000..c5d66fd8ba53
--- /dev/null
+++ b/include/linux/memfile_notifier.h
@@ -0,0 +1,93 @@
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
+/* memory in the file is inaccessible from userspace (e.g. read/write/mmap) */
+#define MEMFILE_F_USER_INACCESSIBLE	BIT(0)
+/* memory in the file is unmovable (e.g. via pagemigration)*/
+#define MEMFILE_F_UNMOVABLE		BIT(1)
+/* memory in the file is unreclaimable (e.g. via kswapd) */
+#define MEMFILE_F_UNRECLAIMABLE		BIT(2)
+
+#define MEMFILE_F_ALLOWED_MASK		(MEMFILE_F_USER_INACCESSIBLE | \
+					MEMFILE_F_UNMOVABLE | \
+					MEMFILE_F_UNRECLAIMABLE)
+
+struct memfile_node {
+	struct list_head	notifiers;	/* registered notifiers */
+	unsigned long		flags;		/* MEMFILE_F_* flags */
+};
+
+struct memfile_backing_store {
+	struct list_head list;
+	spinlock_t lock;
+	struct memfile_node* (*lookup_memfile_node)(struct file *file);
+	int (*get_pfn)(struct file *file, pgoff_t offset, pfn_t *pfn,
+		       int *order);
+	void (*put_pfn)(pfn_t pfn);
+};
+
+struct memfile_notifier;
+struct memfile_notifier_ops {
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
+extern void memfile_notifier_invalidate(struct memfile_node *node,
+					pgoff_t start, pgoff_t end);
+/*APIs for notifier consumers */
+extern int memfile_register_notifier(struct file *file, unsigned long flags,
+				     struct memfile_notifier *notifier);
+extern void memfile_unregister_notifier(struct memfile_notifier *notifier);
+
+#else /* !CONFIG_MEMFILE_NOTIFIER */
+static inline void memfile_register_backing_store(struct memfile_backing_store *bs)
+{
+}
+
+static inline int memfile_node_set_flags(struct file *file, unsigned long flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void memfile_notifier_invalidate(struct memfile_node *node,
+					       pgoff_t start, pgoff_t end)
+{
+}
+
+static inline int memfile_register_notifier(struct file *file,
+					    unsigned long flags,
+					    struct memfile_notifier *notifier)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void memfile_unregister_notifier(struct memfile_notifier *notifier)
+{
+}
+
+#endif /* CONFIG_MEMFILE_NOTIFIER */
+
+#endif /* _LINUX_MEMFILE_NOTIFIER_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..19ab9350f5cb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1130,6 +1130,10 @@ config PTE_MARKER_UFFD_WP
 	  purposes.  It is required to enable userfaultfd write protection on
 	  file-backed memory types like shmem and hugetlbfs.
 
+config MEMFILE_NOTIFIER
+	bool
+	select SRCU
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 6f9ffa968a1a..b7e3fb5fa85b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -133,3 +133,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
+obj-$(CONFIG_MEMFILE_NOTIFIER) += memfile_notifier.o
diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
new file mode 100644
index 000000000000..799d3197903e
--- /dev/null
+++ b/mm/memfile_notifier.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
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

