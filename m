Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528596BFFB0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 08:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCSHJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCSHJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:09:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA011E95;
        Sun, 19 Mar 2023 00:09:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so35381608edb.10;
        Sun, 19 Mar 2023 00:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679209781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8uXWzHaUDgnMR3zVzK4ll6XJwTMNIlCa4zu/w/8SY0=;
        b=kD77EjSANPv5buSsqXEhflSmgfuAbw+3r1lZTfUH2Si4lAQ5F0kzSrIlBMvWxHyGM5
         WrJBoxIFgqN77KaZWfx9jZJpTTd1XtWADAQ8thPxb/RoqM3tMAU4bhfeOHYTD+lZ69tS
         aeuBbNWwY1xB3ARatXkNcEY4ZMYWbQ+oxyk05M6ElH2m8XUnXKVC90AhPutyGx/glQkO
         /gnQf39KUikvmDGyoWmpprZoF+1tCRrknofidgyJ79vExjBPNoHY7nIJWHtw+0Z8Dcuk
         tL4FqjTHjMeftBEJY03uoDecD4TzfQTt7hca9Hln0v9q0JxjgJpoZpLhl/yE4u0zeTt8
         0TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679209781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8uXWzHaUDgnMR3zVzK4ll6XJwTMNIlCa4zu/w/8SY0=;
        b=nT7H7Cdfmmrpoli6i+QQeB8TNNKTOTeveLrT9C0QZXHxniYq9KblWJ0gQkjIgBeRBM
         vsqMDZZYAUsYtUqv+HPlMjUb9x1OaoEXZttGc7kgTdGHnumZiE90m3XydSbah5Juarw1
         MCnaP6wKC8yJbtipQFJZseioG/YZ5vx5D8gu0NUllcsKGgyyyPt/OiyqW65trVtv1MzU
         WboDpKW4Hlp5PCzghT51kOz3AWHA/Eq5l8hwbNi6kHcCz8byCey43KoSOPMO/J3nQnlO
         ihzuhPQL75HavwbBBBmd34yODwnXFEOB9P+P76jLXIqj1eIPTGvZNSImm5DWprtPRoGV
         Qnsg==
X-Gm-Message-State: AO0yUKXZ/ldvijswrPjzWPjXoqiV0V6d4vAUm9wjPAtWfXCTY5G/B0ow
        awBAytFzQ5W9UmzlFAZBNcpoz/unAuk=
X-Google-Smtp-Source: AK7set9mnjoY0F9bvHw0JKzlTE3bCjtuxWNF0T2RwMxpa2FJSHNLFnLdQB7KeDSZJqZzpZJ9Mxvzog==
X-Received: by 2002:a17:906:6886:b0:930:9cec:2fb9 with SMTP id n6-20020a170906688600b009309cec2fb9mr5024214ejr.77.1679209781486;
        Sun, 19 Mar 2023 00:09:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23ee:1938:1bcd:c6e1:42ba:ae87:772e])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170906b10800b008c9b44b7851sm2943920ejy.182.2023.03.19.00.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:09:40 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock and vmap_block->lock
Date:   Sun, 19 Mar 2023 07:09:31 +0000
Message-Id: <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679209395.git.lstoakes@gmail.com>
References: <cover.1679209395.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vmalloc() is, by design, not permitted to be used in atomic context and
already contains components which may sleep, so avoiding spin locks is not
a problem from the perspective of atomic context.

The global vmap_area_lock is held when the red/black tree rooted in
vmap_are_root is accessed and thus is rather long-held and under
potentially high contention. It is likely to be under contention for reads
rather than write, so replace it with a rwsem.

Each individual vmap_block->lock is likely to be held for less time but
under low contention, so a mutex is not an outrageous choice here.

A subset of test_vmalloc.sh performance results:-

fix_size_alloc_test             0.40%
full_fit_alloc_test		2.08%
long_busy_list_alloc_test	0.34%
random_size_alloc_test		-0.25%
random_size_align_alloc_test	0.06%
...
all tests cycles                0.2%

This represents a tiny reduction in performance that sits barely above
noise.

The reason for making this change is to build a basis for vread() to be
usable asynchronously, this eliminating the need for a bounce buffer when
copying data to userland in read_kcore() and allowing that to be converted
to an iterator form.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vmalloc.c | 77 +++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 978194dc2bb8..c24b27664a97 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -40,6 +40,7 @@
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
+#include <linux/rwsem.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -725,7 +726,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
 
-static DEFINE_SPINLOCK(vmap_area_lock);
+static DECLARE_RWSEM(vmap_area_lock);
 static DEFINE_SPINLOCK(free_vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
@@ -1537,9 +1538,9 @@ static void free_vmap_area(struct vmap_area *va)
 	/*
 	 * Remove from the busy tree/list.
 	 */
-	spin_lock(&vmap_area_lock);
+	down_write(&vmap_area_lock);
 	unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	up_write(&vmap_area_lock);
 
 	/*
 	 * Insert/Merge it back to the free tree/list.
@@ -1627,9 +1628,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = va_flags;
 
-	spin_lock(&vmap_area_lock);
+	down_write(&vmap_area_lock);
 	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
-	spin_unlock(&vmap_area_lock);
+	up_write(&vmap_area_lock);
 
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
 	BUG_ON(va->va_start < vstart);
@@ -1854,9 +1855,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
 
-	spin_lock(&vmap_area_lock);
+	down_read(&vmap_area_lock);
 	va = __find_vmap_area(addr, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	up_read(&vmap_area_lock);
 
 	return va;
 }
@@ -1865,11 +1866,11 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
 
-	spin_lock(&vmap_area_lock);
+	down_write(&vmap_area_lock);
 	va = __find_vmap_area(addr, &vmap_area_root);
 	if (va)
 		unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	up_write(&vmap_area_lock);
 
 	return va;
 }
@@ -1914,7 +1915,7 @@ struct vmap_block_queue {
 };
 
 struct vmap_block {
-	spinlock_t lock;
+	struct mutex lock;
 	struct vmap_area *va;
 	unsigned long free, dirty;
 	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
@@ -1991,7 +1992,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	}
 
 	vaddr = vmap_block_vaddr(va->va_start, 0);
-	spin_lock_init(&vb->lock);
+	mutex_init(&vb->lock);
 	vb->va = va;
 	/* At least something should be left free */
 	BUG_ON(VMAP_BBMAP_BITS <= (1UL << order));
@@ -2026,9 +2027,9 @@ static void free_vmap_block(struct vmap_block *vb)
 	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
 	BUG_ON(tmp != vb);
 
-	spin_lock(&vmap_area_lock);
+	down_write(&vmap_area_lock);
 	unlink_va(vb->va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	up_write(&vmap_area_lock);
 
 	free_vmap_area_noflush(vb->va);
 	kfree_rcu(vb, rcu_head);
@@ -2047,7 +2048,7 @@ static void purge_fragmented_blocks(int cpu)
 		if (!(vb->free + vb->dirty == VMAP_BBMAP_BITS && vb->dirty != VMAP_BBMAP_BITS))
 			continue;
 
-		spin_lock(&vb->lock);
+		mutex_lock(&vb->lock);
 		if (vb->free + vb->dirty == VMAP_BBMAP_BITS && vb->dirty != VMAP_BBMAP_BITS) {
 			vb->free = 0; /* prevent further allocs after releasing lock */
 			vb->dirty = VMAP_BBMAP_BITS; /* prevent purging it again */
@@ -2056,10 +2057,10 @@ static void purge_fragmented_blocks(int cpu)
 			spin_lock(&vbq->lock);
 			list_del_rcu(&vb->free_list);
 			spin_unlock(&vbq->lock);
-			spin_unlock(&vb->lock);
+			mutex_unlock(&vb->lock);
 			list_add_tail(&vb->purge, &purge);
 		} else
-			spin_unlock(&vb->lock);
+			mutex_unlock(&vb->lock);
 	}
 	rcu_read_unlock();
 
@@ -2101,9 +2102,9 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
 		unsigned long pages_off;
 
-		spin_lock(&vb->lock);
+		mutex_lock(&vb->lock);
 		if (vb->free < (1UL << order)) {
-			spin_unlock(&vb->lock);
+			mutex_unlock(&vb->lock);
 			continue;
 		}
 
@@ -2117,7 +2118,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 			spin_unlock(&vbq->lock);
 		}
 
-		spin_unlock(&vb->lock);
+		mutex_unlock(&vb->lock);
 		break;
 	}
 
@@ -2144,16 +2145,16 @@ static void vb_free(unsigned long addr, unsigned long size)
 	order = get_order(size);
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
 	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
-	spin_lock(&vb->lock);
+	mutex_lock(&vb->lock);
 	bitmap_clear(vb->used_map, offset, (1UL << order));
-	spin_unlock(&vb->lock);
+	mutex_unlock(&vb->lock);
 
 	vunmap_range_noflush(addr, addr + size);
 
 	if (debug_pagealloc_enabled_static())
 		flush_tlb_kernel_range(addr, addr + size);
 
-	spin_lock(&vb->lock);
+	mutex_lock(&vb->lock);
 
 	/* Expand dirty range */
 	vb->dirty_min = min(vb->dirty_min, offset);
@@ -2162,10 +2163,10 @@ static void vb_free(unsigned long addr, unsigned long size)
 	vb->dirty += 1UL << order;
 	if (vb->dirty == VMAP_BBMAP_BITS) {
 		BUG_ON(vb->free);
-		spin_unlock(&vb->lock);
+		mutex_unlock(&vb->lock);
 		free_vmap_block(vb);
 	} else
-		spin_unlock(&vb->lock);
+		mutex_unlock(&vb->lock);
 }
 
 static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
@@ -2183,7 +2184,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 
 		rcu_read_lock();
 		list_for_each_entry_rcu(vb, &vbq->free, free_list) {
-			spin_lock(&vb->lock);
+			mutex_lock(&vb->lock);
 			if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
 				unsigned long va_start = vb->va->va_start;
 				unsigned long s, e;
@@ -2196,7 +2197,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 
 				flush = 1;
 			}
-			spin_unlock(&vb->lock);
+			mutex_unlock(&vb->lock);
 		}
 		rcu_read_unlock();
 	}
@@ -2451,9 +2452,9 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 			      unsigned long flags, const void *caller)
 {
-	spin_lock(&vmap_area_lock);
+	down_write(&vmap_area_lock);
 	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vmap_area_lock);
+	up_write(&vmap_area_lock);
 }
 
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
@@ -3507,9 +3508,9 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	if (!vb)
 		goto finished;
 
-	spin_lock(&vb->lock);
+	mutex_lock(&vb->lock);
 	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
-		spin_unlock(&vb->lock);
+		mutex_unlock(&vb->lock);
 		goto finished;
 	}
 	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
@@ -3536,7 +3537,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 		count -= n;
 	}
 unlock:
-	spin_unlock(&vb->lock);
+	mutex_unlock(&vb->lock);
 
 finished:
 	/* zero-fill the left dirty or free regions */
@@ -3576,13 +3577,15 @@ long vread(char *buf, char *addr, unsigned long count)
 	unsigned long buflen = count;
 	unsigned long n, size, flags;
 
+	might_sleep();
+
 	addr = kasan_reset_tag(addr);
 
 	/* Don't allow overflow */
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
 
-	spin_lock(&vmap_area_lock);
+	down_read(&vmap_area_lock);
 	va = find_vmap_area_exceed_addr((unsigned long)addr);
 	if (!va)
 		goto finished;
@@ -3639,7 +3642,7 @@ long vread(char *buf, char *addr, unsigned long count)
 		count -= n;
 	}
 finished:
-	spin_unlock(&vmap_area_lock);
+	up_read(&vmap_area_lock);
 
 	if (buf == buf_start)
 		return 0;
@@ -3980,14 +3983,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 
 	/* insert all vm's */
-	spin_lock(&vmap_area_lock);
+	down_write(&vmap_area_lock);
 	for (area = 0; area < nr_vms; area++) {
 		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
 
 		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 	}
-	spin_unlock(&vmap_area_lock);
+	up_write(&vmap_area_lock);
 
 	/*
 	 * Mark allocated areas as accessible. Do it now as a best-effort
@@ -4114,7 +4117,7 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	__acquires(&vmap_area_lock)
 {
 	mutex_lock(&vmap_purge_lock);
-	spin_lock(&vmap_area_lock);
+	down_read(&vmap_area_lock);
 
 	return seq_list_start(&vmap_area_list, *pos);
 }
@@ -4128,7 +4131,7 @@ static void s_stop(struct seq_file *m, void *p)
 	__releases(&vmap_area_lock)
 	__releases(&vmap_purge_lock)
 {
-	spin_unlock(&vmap_area_lock);
+	up_read(&vmap_area_lock);
 	mutex_unlock(&vmap_purge_lock);
 }
 
-- 
2.39.2

