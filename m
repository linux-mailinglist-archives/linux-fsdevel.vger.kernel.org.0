Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BF2D0F8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLGLea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgLGLea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:30 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062DFC0613D2;
        Mon,  7 Dec 2020 03:33:50 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 69so803623pgg.8;
        Mon, 07 Dec 2020 03:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMkfGfUr8fj2hO5B5jLMQa5h9UySfQVQPVhyn3NCxd4=;
        b=lqKRhFOEdKV0wC0Ujvy8bkoj7sCr3aw0Z4/HDK77hQNPjJPNnVzFT7Y48IfRoK5fje
         8Z3ax4VrbD+Dn0BhRTbgr8ogTL0zkSdpIuruZQ3+yy6Zr2XBsPy5eyrUcW0mVCr0/3bn
         qx+pBlAKJUjm/UklANHSReU2TCJRzqIA73fT6ogzAbRptOgSwK1+51QW8zzSqVkyvnwA
         lDTHfoho00Iof1lZ3QDDZkSwQBzQVJSl1+9+lTUfJcA7vzOvWze/xtSffZ8kB0THXJWq
         CodT0//aOcvnyDJGfu7Gte5EhdswKxOh89d3sLKX4/56IVsr8+P70YCf92dYnF/ATCXH
         EKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMkfGfUr8fj2hO5B5jLMQa5h9UySfQVQPVhyn3NCxd4=;
        b=PcyO/5yUR9A8cJbmz4Wbd5fm85HSOUe4hi0/lyTKK6114sYBhd1PMGc8mFqiesybvs
         oJUjyHmdIs/SMVVzN5+RIuK7rvJjPt/iHFJTb32HhyIMgI1RdWGcpjz8qrNcy5hk8vlA
         lE+xWrrvdPv82GYjoJlzEPd/hZsKMhSYBPlES/5beSt5b2698ivvtNeGt+Ha38wiiHed
         7dFghRirDVti9C8buzxFOfxMhFEFkEcLKgnLO/eLRFhC4DhAkftSkYYzlTEdHgVc1lSx
         P5HH6AkXmQBo1RbqiR6S4OetUHFFiroqwYgpLaWojCAYdcgmfwLrZ7mJzjL+nAd+XeKI
         /OOg==
X-Gm-Message-State: AOAM531CCL7PzRtrZ6nPk2d1VbkoZ3OdUymnkNVB9gVsZ0eXEIBoh2Fk
        c1hGVAtsuB1l1D8K2iXztkU=
X-Google-Smtp-Source: ABdhPJwqvcI3wGyVmABSaYBJRnwrF2eTs+saCLZYg+lluLMzqvEOWJNH8GFu5PCjSHRlesroiuhjqA==
X-Received: by 2002:a65:558a:: with SMTP id j10mr17960023pgs.370.1607340829629;
        Mon, 07 Dec 2020 03:33:49 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.33.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:33:49 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [RFC V2 07/37] dmem: trace core functions
Date:   Mon,  7 Dec 2020 19:31:00 +0800
Message-Id: <4ee2b130c35367a6a3e7b631c872b824a1f59d23.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Add tracepoints for dmem alloc_init, alloc and free functions,
that helps us to figure out what is happening inside dmem
allocator

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/Makefile          |  1 +
 fs/dmemfs/inode.c           |  5 ++++
 fs/dmemfs/trace.h           | 54 +++++++++++++++++++++++++++++++++++
 include/trace/events/dmem.h | 68 +++++++++++++++++++++++++++++++++++++++++++++
 mm/dmem.c                   |  6 ++++
 5 files changed, 134 insertions(+)
 create mode 100644 fs/dmemfs/trace.h
 create mode 100644 include/trace/events/dmem.h

diff --git a/fs/dmemfs/Makefile b/fs/dmemfs/Makefile
index 73bdc9c..0b36d03 100644
--- a/fs/dmemfs/Makefile
+++ b/fs/dmemfs/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the linux dmem-filesystem routines.
 #
+ccflags-y += -I $(srctree)/$(src)		# needed for trace events
 obj-$(CONFIG_DMEM_FS) += dmemfs.o
 
 dmemfs-y += inode.o
diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 9ec62dc..7723b58 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -31,6 +31,9 @@
 MODULE_AUTHOR("Tencent Corporation");
 MODULE_LICENSE("GPL v2");
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 struct dmemfs_mount_opts {
 	unsigned long dpage_size;
 };
@@ -336,6 +339,7 @@ static void *find_radix_entry_or_next(struct address_space *mapping,
 			offset += inode->i_sb->s_blocksize;
 			dpages--;
 			mapping->nrexceptional++;
+			trace_dmemfs_radix_tree_insert(index, entry);
 			index++;
 		}
 
@@ -532,6 +536,7 @@ static void inode_drop_dpages(struct inode *inode, loff_t start, loff_t end)
 				break;
 
 			xa_erase(&mapping->i_pages, istart);
+			trace_dmemfs_radix_tree_delete(istart, pvec.pages[i]);
 			mapping->nrexceptional--;
 
 			addr = dmem_entry_to_addr(inode, pvec.pages[i]);
diff --git a/fs/dmemfs/trace.h b/fs/dmemfs/trace.h
new file mode 100644
index 00000000..cc11653
--- /dev/null
+++ b/fs/dmemfs/trace.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * trace.h - DesignWare Support
+ *
+ * Copyright (C)
+ *
+ * Author: Xiao Guangrong <xiaoguangrong@tencent.com>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dmemfs
+
+#if !defined(_TRACE_DMEMFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DMEMFS_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(dmemfs_radix_tree_class,
+	TP_PROTO(unsigned long index, void *rentry),
+	TP_ARGS(index, rentry),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	index)
+		__field(void *, rentry)
+	),
+
+	TP_fast_assign(
+		__entry->index = index;
+		__entry->rentry = rentry;
+	),
+
+	TP_printk("index %lu entry %#lx", __entry->index,
+		  (unsigned long)__entry->rentry)
+);
+
+DEFINE_EVENT(dmemfs_radix_tree_class, dmemfs_radix_tree_insert,
+	TP_PROTO(unsigned long index, void *rentry),
+	TP_ARGS(index, rentry)
+);
+
+DEFINE_EVENT(dmemfs_radix_tree_class, dmemfs_radix_tree_delete,
+	TP_PROTO(unsigned long index, void *rentry),
+	TP_ARGS(index, rentry)
+);
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/trace/events/dmem.h b/include/trace/events/dmem.h
new file mode 100644
index 00000000..10d1b90
--- /dev/null
+++ b/include/trace/events/dmem.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dmem
+
+#if !defined(_TRACE_DMEM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DMEM_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(dmem_alloc_init,
+	TP_PROTO(unsigned long dpage_shift),
+	TP_ARGS(dpage_shift),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, dpage_shift)
+	),
+
+	TP_fast_assign(
+		__entry->dpage_shift = dpage_shift;
+	),
+
+	TP_printk("dpage_shift %lu", __entry->dpage_shift)
+);
+
+TRACE_EVENT(dmem_alloc_pages_node,
+	TP_PROTO(phys_addr_t addr, int node, int try_max, int result_nr),
+	TP_ARGS(addr, node, try_max, result_nr),
+
+	TP_STRUCT__entry(
+		__field(phys_addr_t, addr)
+		__field(int, node)
+		__field(int, try_max)
+		__field(int, result_nr)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->node = node;
+		__entry->try_max = try_max;
+		__entry->result_nr = result_nr;
+	),
+
+	TP_printk("addr %#lx node %d try_max %d result_nr %d",
+		  (unsigned long)__entry->addr, __entry->node,
+		  __entry->try_max, __entry->result_nr)
+);
+
+TRACE_EVENT(dmem_free_pages,
+	TP_PROTO(phys_addr_t addr, int dpages_nr),
+	TP_ARGS(addr, dpages_nr),
+
+	TP_STRUCT__entry(
+		__field(phys_addr_t, addr)
+		__field(int, dpages_nr)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->dpages_nr = dpages_nr;
+	),
+
+	TP_printk("addr %#lx dpages_nr %d", (unsigned long)__entry->addr,
+		  __entry->dpages_nr)
+);
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/dmem.c b/mm/dmem.c
index a77a064..aa34bf2 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -18,6 +18,8 @@
 #include <linux/debugfs.h>
 #include <linux/notifier.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dmem.h>
 /*
  * There are two kinds of page in dmem management:
  * - nature page, it's the CPU's page size, i.e, 4K on x86
@@ -559,6 +561,8 @@ int dmem_alloc_init(unsigned long dpage_shift)
 
 	mutex_lock(&dmem_pool.lock);
 
+	trace_dmem_alloc_init(dpage_shift);
+
 	if (dmem_pool.dpage_shift) {
 		/*
 		 * double init on the same page size is okay
@@ -686,6 +690,7 @@ int dmem_alloc_init(unsigned long dpage_shift)
 			}
 		}
 
+		trace_dmem_alloc_pages_node(addr, node, try_max, *result_nr);
 		mutex_unlock(&dmem_pool.lock);
 	}
 	return addr;
@@ -791,6 +796,7 @@ void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr)
 
 	mutex_lock(&dmem_pool.lock);
 
+	trace_dmem_free_pages(addr, dpages_nr);
 	WARN_ON(!dmem_pool.dpage_shift);
 
 	dregion = find_dmem_region(addr, &pdnode);
-- 
1.8.3.1

