Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354D4286FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgJHHyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgJHHyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB27C061755;
        Thu,  8 Oct 2020 00:54:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so3319456pff.6;
        Thu, 08 Oct 2020 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WRQTJMxrcLsyspN0RDKoQcsucleEqYhnNKELKvYMNac=;
        b=cL1aVP4nJwGbuLtUrnOpoTsBcxY0Mv6rdVuaVIzpSB40thQVdU92DxjcTJaftqiRpU
         7KW/12W6HcO6rj9IiyjJJlVF0sH0RNtHQASVVOvAviKHL/oU3JmW6Suv5JGsoI79tQAE
         7vUoVVV23lXL74U4s3vem1krYqWnOxU27ijwf9ziMTMn2GaMixmRYJk9sV1cqeK3W8ww
         c4DBCjU0lEB9mh9uiByeLPPPtkoCQQtKYoTERVg0iucEOTlysxxe1HrWYjcvMmXcJn6E
         WTdJDhLWSmNi0LbCsUl4c2X5fBUqsiR+R98LB40+DjihERJ8PKi3sHA+Da/hEIbGMw3w
         zNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WRQTJMxrcLsyspN0RDKoQcsucleEqYhnNKELKvYMNac=;
        b=e8W9p+0LLjXER76Ee3iszlkMrxBkMxy8v8M1RJwxd09qjTvPICKHKDp5C4JYI0ni80
         6cQa5Av3d2pQI/qAywT31L56oLX4A+53hlKR8M7AB+dw1fXbC9gDUnPZAFQGB6yyG3hL
         36TonCm21MQzjGG5XtL3AFMmGGnJvgGj6fnsJOhSnlCgvUc8DdqTNFDRBEc/86quBTAx
         BGsrpFsmrYLQ0wydnBaKMeQA5zTmJrb4oDYgThfuqnVGbOsU3+h83qyYERPLqrJtgKd+
         GSE+VkLBOyYSIuVQqzD1qcaJgHUgmnZns4xGOgRKOmerZ5VW89B9JguwFQKI6jzuIhTj
         LKdQ==
X-Gm-Message-State: AOAM530UPnirEQONRoHuVf/VmIeVXnxzkfrK854oxbFq22REUPLA6iQJ
        vrQGFz6inMmWprFQXvqlm6c=
X-Google-Smtp-Source: ABdhPJzzjN2WTI3Ut/2f1sheJCfE2JopXoUTUzI3IN5DS6ByVHKSAerQSFHW5+XvWm7q+olbv2SJPA==
X-Received: by 2002:a63:77c4:: with SMTP id s187mr6307591pgc.303.1602143654497;
        Thu, 08 Oct 2020 00:54:14 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:13 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 07/35] dmem: trace core functions
Date:   Thu,  8 Oct 2020 15:53:57 +0800
Message-Id: <b4dddcd80e755f8f6df8558f4de14f6d4b2a94cf.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Add tracepoints for alloc_init, alloc and free functions,
that helps us to figure out what is happening inside dmem
allocator

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/Makefile          |  1 +
 fs/dmemfs/inode.c           |  5 +++
 fs/dmemfs/trace.h           | 54 +++++++++++++++++++++++++++++
 include/trace/events/dmem.h | 68 +++++++++++++++++++++++++++++++++++++
 mm/dmem.c                   |  6 ++++
 5 files changed, 134 insertions(+)
 create mode 100644 fs/dmemfs/trace.h
 create mode 100644 include/trace/events/dmem.h

diff --git a/fs/dmemfs/Makefile b/fs/dmemfs/Makefile
index 73bdc9cbc87e..0b36d03f1097 100644
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
index d617494fc633..8b0516d98ee7 100644
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
@@ -339,6 +342,7 @@ radix_get_create_entry(struct vm_area_struct *vma, unsigned long fault_addr,
 			offset += inode->i_sb->s_blocksize;
 			dpages--;
 			mapping->nrexceptional++;
+			trace_dmemfs_radix_tree_insert(index, entry);
 			index++;
 		}
 
@@ -535,6 +539,7 @@ static void inode_drop_dpages(struct inode *inode, loff_t start, loff_t end)
 				break;
 
 			xa_erase(&mapping->i_pages, istart);
+			trace_dmemfs_radix_tree_delete(istart, pvec.pages[i]);
 			mapping->nrexceptional--;
 
 			addr = dmem_entry_to_addr(inode, pvec.pages[i]);
diff --git a/fs/dmemfs/trace.h b/fs/dmemfs/trace.h
new file mode 100644
index 000000000000..cc1165332e60
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
index 000000000000..10d1b90a7783
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
index a77a064c8d59..aa34bf20f830 100644
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
@@ -686,6 +690,7 @@ dmem_alloc_pages_from_nodelist(int *nodelist, nodemask_t *nodemask,
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
2.28.0

