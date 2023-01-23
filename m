Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE393678409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjAWSEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjAWSEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:04:32 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC430B17
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 10:04:28 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 5D2035616BDF; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 07/20] mm: add tracepoints to ksm
Date:   Mon, 23 Jan 2023 09:37:35 -0800
Message-Id: <20230123173748.1734238-8-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,SUSPICIOUS_RECIPS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the following tracepoints to ksm:
- start / stop scan
- ksm enter / exit
- merge a page
- merge a page with ksm
- remove a page
- remove a rmap item

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 MAINTAINERS                |   1 +
 include/trace/events/ksm.h | 257 +++++++++++++++++++++++++++++++++++++
 mm/ksm.c                   |  20 ++-
 3 files changed, 276 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/ksm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 123216b76534..990a28bdc263 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13482,6 +13482,7 @@ F:	include/linux/memory_hotplug.h
 F:	include/linux/mm.h
 F:	include/linux/mmzone.h
 F:	include/linux/pagewalk.h
+F:	include/trace/events/ksm.h
 F:	mm/
 F:	tools/testing/selftests/vm/
=20
diff --git a/include/trace/events/ksm.h b/include/trace/events/ksm.h
new file mode 100644
index 000000000000..727d8f6dbc3f
--- /dev/null
+++ b/include/trace/events/ksm.h
@@ -0,0 +1,257 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ksm
+
+#if !defined(_TRACE_KSM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KSM_H
+
+#include <linux/tracepoint.h>
+
+/**
+ * ksm_scan_template - called for start / stop scan
+ *
+ * @seq:		sequence number of scan
+ * @rmap_entries:	actual number of rmap entries
+ *
+ * Allows to trace the start / stop of a ksm scan.
+ */
+DECLARE_EVENT_CLASS(ksm_scan_template,
+
+	TP_PROTO(int seq, u32 rmap_entries),
+
+	TP_ARGS(seq, rmap_entries),
+
+	TP_STRUCT__entry(
+		__field(int,	seq)
+		__field(u32,	rmap_entries)
+	),
+
+	TP_fast_assign(
+		__entry->seq		=3D seq;
+		__entry->rmap_entries	=3D rmap_entries;
+	),
+
+	TP_printk("seq %d rmap size %d",
+			__entry->seq, __entry->rmap_entries)
+);
+
+/**
+ * ksm_start_scan - called after a new ksm scan is started
+ *
+ * @seq:		sequence number of scan
+ * @rmap_entries:	actual number of rmap entries
+ *
+ * Allows to trace the start of a ksm scan.
+ */
+DEFINE_EVENT(ksm_scan_template, ksm_start_scan,
+
+	TP_PROTO(int seq, u32 rmap_entries),
+
+	TP_ARGS(seq, rmap_entries)
+);
+
+/**
+ * ksm_stop_scan - called after a new ksm scan has completed
+ *
+ * @seq:		sequence number of scan
+ * @rmap_entries:	actual number of rmap entries
+ *
+ * Allows to trace the completion of a ksm scan.
+ */
+DEFINE_EVENT(ksm_scan_template, ksm_stop_scan,
+
+	TP_PROTO(int seq, u32 rmap_entries),
+
+	TP_ARGS(seq, rmap_entries)
+);
+
+/**
+ * ksm_enter - called after a new process has been added / removed from =
ksm
+ *
+ * @mm:			address of the mm object of the process
+ * @flag:		specified flags
+ *
+ * Allows to trace the when a process has been added or removed from ksm=
.
+ */
+DECLARE_EVENT_CLASS(ksm_enter_exit_template,
+
+	TP_PROTO(void *mm, unsigned int flag),
+
+	TP_ARGS(mm, flag),
+
+	TP_STRUCT__entry(
+		__field(void *,		mm)
+		__field(unsigned int,	flag)
+	),
+
+	TP_fast_assign(
+		__entry->mm	=3D mm;
+		__entry->flag	=3D flag;
+	),
+
+	TP_printk("mm %p flag %u",
+		__entry->mm, __entry->flag)
+);
+
+/**
+ * ksm_enter - called after a new process has been added to ksm
+ *
+ * @mm:			address of the mm object of the process
+ * @flag:		specified flags
+ *
+ * Allows to trace the when a process has been added to ksm.
+ */
+DEFINE_EVENT(ksm_enter_exit_template, ksm_enter,
+
+	TP_PROTO(void *mm, unsigned int flag),
+
+	TP_ARGS(mm, flag)
+);
+
+/**
+ * ksm_exit - called after a new process has been removed from ksm
+ *
+ * @mm:			address of the mm object of the process
+ * @flag:		specified flags
+ *
+ * Allows to trace the when a process has been removed from ksm.
+ */
+DEFINE_EVENT(ksm_enter_exit_template, ksm_exit,
+
+	TP_PROTO(void *mm, unsigned int flag),
+
+	TP_ARGS(mm, flag)
+);
+
+/**
+ * ksm_merge_one_page - called after a page has been merged
+ *
+ * @pfn:		page frame number of ksm page
+ * @rmap_item:		address of rmap_item  object
+ * @mm:			address of the process mm struct
+ * @err:		success
+ *
+ * Allows to trace the ksm merging of individual pages.
+ */
+TRACE_EVENT(ksm_merge_one_page,
+
+	TP_PROTO(unsigned long pfn, void *rmap_item, void *mm, int err),
+
+	TP_ARGS(pfn, rmap_item, mm, err),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	pfn)
+		__field(void *,		rmap_item)
+		__field(void *,		mm)
+		__field(int,		err)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		=3D pfn;
+		__entry->rmap_item	=3D rmap_item;
+		__entry->mm		=3D mm;
+		__entry->err		=3D err;
+	),
+
+	TP_printk("ksm pfn %lu rmap_item %p mm %p error %d",
+			__entry->pfn, __entry->rmap_item, __entry->mm, __entry->err)
+);
+
+/**
+ * ksm_merge_with_ksm_page - called after a page has been merged with a =
ksm page
+ *
+ * @ksm_page:		address ksm page
+ * @pfn:		page frame number of ksm page
+ * @rmap_item:		address of rmap_item  object
+ * @mm:			address of the mm object of the process
+ * @err:		success
+ *
+ * Allows to trace the merging of a page with a ksm page.
+ */
+TRACE_EVENT(ksm_merge_with_ksm_page,
+
+	TP_PROTO(void *ksm_page, unsigned long pfn, void *rmap_item, void *mm, =
int err),
+
+	TP_ARGS(ksm_page, pfn, rmap_item, mm, err),
+
+	TP_STRUCT__entry(
+		__field(void *,		ksm_page)
+		__field(unsigned long,	pfn)
+		__field(void *,		rmap_item)
+		__field(void *,		mm)
+		__field(int,		err)
+	),
+
+	TP_fast_assign(
+		__entry->ksm_page	=3D ksm_page;
+		__entry->pfn		=3D pfn;
+		__entry->rmap_item	=3D rmap_item;
+		__entry->mm		=3D mm;
+		__entry->err		=3D err;
+	),
+
+	TP_printk("%spfn %lu rmap_item %p mm %p error %d",
+		  (__entry->ksm_page ? "ksm " : ""),
+		  __entry->pfn, __entry->rmap_item, __entry->mm, __entry->err)
+);
+
+/**
+ * ksm_remove_ksm_page - called after a ksm page has been removed
+ *
+ * @pfn:		page frame number of ksm page
+ *
+ * Allows to trace the removing of stable ksm pages.
+ */
+TRACE_EVENT(ksm_remove_ksm_page,
+
+	TP_PROTO(unsigned long pfn),
+
+	TP_ARGS(pfn),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+	),
+
+	TP_fast_assign(
+		__entry->pfn =3D pfn;
+	),
+
+	TP_printk("pfn %lu", __entry->pfn)
+);
+
+/**
+ * ksm_remove_rmap_item - called after a rmap_item has been removed from=
 the
+ *                        stable tree
+ *
+ * @pfn:		page frame number of ksm page
+ * @rmap_item:		address of rmap_item  object
+ * @mm:			address of the process mm struct
+ *
+ * Allows to trace the removal of pages from the stable tree list.
+ */
+TRACE_EVENT(ksm_remove_rmap_item,
+
+	TP_PROTO(unsigned long pfn, void *rmap_item, void *mm),
+
+	TP_ARGS(pfn, rmap_item, mm),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	pfn)
+		__field(void *,		rmap_item)
+		__field(void *,		mm)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		=3D pfn;
+		__entry->rmap_item	=3D rmap_item;
+		__entry->mm		=3D mm;
+	),
+
+	TP_printk("pfn %lu rmap_item %p mm %p",
+			__entry->pfn, __entry->rmap_item, __entry->mm)
+);
+
+#endif /* _TRACE_KSM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/ksm.c b/mm/ksm.c
index 5fa6b46dfa3b..88a969849955 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -45,6 +45,9 @@
 #include "internal.h"
 #include "mm_slot.h"
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/ksm.h>
+
 #ifdef CONFIG_NUMA
 #define NUMA(x)		(x)
 #define DO_NUMA(x)	do { (x); } while (0)
@@ -633,10 +636,12 @@ static void remove_node_from_stable_tree(struct ksm=
_stable_node *stable_node)
 	BUG_ON(stable_node->rmap_hlist_len < 0);
=20
 	hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
-		if (rmap_item->hlist.next)
+		if (rmap_item->hlist.next) {
+			trace_ksm_remove_rmap_item(stable_node->kpfn, rmap_item, rmap_item->m=
m);
 			ksm_pages_sharing--;
-		else
+		} else {
 			ksm_pages_shared--;
+		}
=20
 		rmap_item->mm->ksm_merging_pages--;
=20
@@ -657,6 +662,7 @@ static void remove_node_from_stable_tree(struct ksm_s=
table_node *stable_node)
 	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD <=3D &migrate_nodes);
 	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD >=3D &migrate_nodes + 1);
=20
+	trace_ksm_remove_ksm_page(stable_node->kpfn);
 	if (stable_node->head =3D=3D &migrate_nodes)
 		list_del(&stable_node->list);
 	else
@@ -1319,6 +1325,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rm=
ap_item *rmap_item,
 	get_anon_vma(vma->anon_vma);
 out:
 	mmap_read_unlock(mm);
+	trace_ksm_merge_with_ksm_page(kpage, page_to_pfn(kpage ? kpage : page),
+				rmap_item, mm, err);
 	return err;
 }
=20
@@ -2137,6 +2145,8 @@ static void cmp_and_merge_page(struct page *page, s=
truct ksm_rmap_item *rmap_ite
 		if (vma) {
 			err =3D try_to_merge_one_page(vma, page,
 					ZERO_PAGE(rmap_item->address));
+			trace_ksm_merge_one_page(page_to_pfn(ZERO_PAGE(rmap_item->address)),
+							rmap_item, mm, err);
 		} else {
 			/*
 			 * If the vma is out of date, we do not need to
@@ -2270,6 +2280,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
=20
 	mm_slot =3D ksm_scan.mm_slot;
 	if (mm_slot =3D=3D &ksm_mm_head) {
+		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
+
 		/*
 		 * A number of pages can hang around indefinitely on per-cpu
 		 * pagevecs, raised page count preventing write_protect_page
@@ -2433,6 +2445,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
 	if (mm_slot !=3D &ksm_mm_head)
 		goto next_mm;
=20
+	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
 	ksm_scan.seqnr++;
 	return NULL;
 }
@@ -2585,6 +2598,7 @@ int __ksm_enter(struct mm_struct *mm, int flag)
 	if (needs_wakeup)
 		wake_up_interruptible(&ksm_thread_wait);
=20
+	trace_ksm_enter(mm, flag);
 	return 0;
 }
=20
@@ -2653,6 +2667,8 @@ void __ksm_exit(struct mm_struct *mm, int flag)
 		mmap_write_lock(mm);
 		mmap_write_unlock(mm);
 	}
+
+	trace_ksm_exit(mm, flag);
 }
=20
 struct page *ksm_might_need_to_copy(struct page *page,
--=20
2.30.2

