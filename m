Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65AA6C68CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 13:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCWMsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCWMsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:48:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059B11168;
        Thu, 23 Mar 2023 05:47:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so85934768edb.12;
        Thu, 23 Mar 2023 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy8coyLpepNHuKEPO1GA817I3E2vGkE9UKdG0deMIVs=;
        b=Fa1lfqKDyJxtYpaA+sxRydW/xXhHbzGCTrYauVRT81ZA20HibY/vMUt3VbGcoU2n2a
         dvyxWYEXaYeP+BiJsr29fzBLvabUK/wrmYcKQbJPjAcPjhKgMGaiq0B5DiZl2jGrFSA+
         lYWmG+Yl7e2yG5JDreMzBBFrlLE4uWkrwaCemdMCdyMLkT3n9XFi91QCO6W1x9jKwktu
         0YDA3JtXIzG6GaUCUHp4OPavm42bj88z6N2RdQnS8oUUbdwgXWOfP5yROIM+KZi+DbZh
         yhqgeL6+t+hJB+j3yc7+LYE/q7VZ5bxXHU/9A6rKWnHcKr5IdiY6TB8iNJjl3nsmdEK+
         bDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy8coyLpepNHuKEPO1GA817I3E2vGkE9UKdG0deMIVs=;
        b=bXqN/majbvNW9CXWF3P4MaebfDJR4d2fekuMcRdT2vklI1Tm5L91ONDhUAvtXg/GhP
         pWXKRr5nhZ+7xmB2aGR+5q/PcaoL7AIfQ3Fq9YShXy8evuTK//067dkesAukm2UrAyTl
         NLb0mU4ELvIA48a42Tvco0IwxC//Vjlzrr+mDs4vcD3oD73e8v4HNM3zFR8z0M4N1sg7
         cqpMJRGmQG0/Fw3rJcCTro6085OMWHVAyk27xWG5uILG8naOvEiZKq0Pp3ktWnXCIFIA
         mzx4TnR4NRapOgSUtGFjfL5e4RPfkBEqM5TxIavTErGV9feuzw48JI8kgizHrYwPwRMX
         0DlA==
X-Gm-Message-State: AO0yUKWetRrYz0UXSKvCD7r4/7SflphroQXiD0R2KmnFfnIOneXZ0hxh
        DW038BQVjxd70zsu/0f2zKc=
X-Google-Smtp-Source: AK7set/2zdTJokXt0aHzwViNhJgBvXG4XSWqgbZnwRHWNaNvmKHknHliFX89JShBh9uygrz8oxOLig==
X-Received: by 2002:a17:906:7cd3:b0:932:c1e2:9983 with SMTP id h19-20020a1709067cd300b00932c1e29983mr9267496ejp.15.1679575677062;
        Thu, 23 Mar 2023 05:47:57 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906044e00b0093204090617sm8351842eja.36.2023.03.23.05.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:47:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 23 Mar 2023 13:47:54 +0100
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBxKeqeBw9xrynRK@pc638.lan>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZBs/MGH+xUAZXNTz@casper.infradead.org>
 <ZBtCl34dolg2YE+3@pc636>
 <ZBtTvdzgAmsGkQzV@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBtTvdzgAmsGkQzV@pc636>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:15:09PM +0100, Uladzislau Rezki wrote:
> On Wed, Mar 22, 2023 at 07:01:59PM +0100, Uladzislau Rezki wrote:
> > On Wed, Mar 22, 2023 at 05:47:28PM +0000, Matthew Wilcox wrote:
> > > On Wed, Mar 22, 2023 at 02:18:19PM +0100, Uladzislau Rezki wrote:
> > > > Hello, Dave.
> > > > 
> > > > > 
> > > > > I'm travelling right now, but give me a few days and I'll test this
> > > > > against the XFS workloads that hammer the global vmalloc spin lock
> > > > > really, really badly. XFS can use vm_map_ram and vmalloc really
> > > > > heavily for metadata buffers and hit the global spin lock from every
> > > > > CPU in the system at the same time (i.e. highly concurrent
> > > > > workloads). vmalloc is also heavily used in the hottest path
> > > > > throught the journal where we process and calculate delta changes to
> > > > > several million items every second, again spread across every CPU in
> > > > > the system at the same time.
> > > > > 
> > > > > We really need the global spinlock to go away completely, but in the
> > > > > mean time a shared read lock should help a little bit....
> > > > > 
> > > > Could you please share some steps how to run your workloads in order to
> > > > touch vmalloc() code. I would like to have a look at it in more detail
> > > > just for understanding the workloads.
> > > > 
> > > > Meanwhile my grep agains xfs shows:
> > > > 
> > > > <snip>
> > > > urezki@pc638:~/data/raid0/coding/linux-rcu.git/fs/xfs$ grep -rn vmalloc ./
> > > 
> > > You're missing:
> > > 
> > > fs/xfs/xfs_buf.c:                       bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
> > > 
> > > which i suspect is the majority of Dave's workload.  That will almost
> > > certainly take the vb_alloc() path.
> > >
> > Then it has nothing to do with vmalloc contention(i mean global KVA allocator), IMHO.
> > Unless:
> > 
> > <snip>
> > void *vm_map_ram(struct page **pages, unsigned int count, int node)
> > {
> > 	unsigned long size = (unsigned long)count << PAGE_SHIFT;
> > 	unsigned long addr;
> > 	void *mem;
> > 
> > 	if (likely(count <= VMAP_MAX_ALLOC)) {
> > 		mem = vb_alloc(size, GFP_KERNEL);
> > 		if (IS_ERR(mem))
> > 			return NULL;
> > 		addr = (unsigned long)mem;
> > 	} else {
> > 		struct vmap_area *va;
> > 		va = alloc_vmap_area(size, PAGE_SIZE,
> > 				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> > 		if (IS_ERR(va))
> > 			return NULL;
> > <snip>
> > 
> > number of pages > VMAP_MAX_ALLOC.
> > 
> > That is why i have asked about workloads because i would like to understand
> > where a "problem" is. A vm_map_ram() access the global vmap space but it happens 
> > when a new vmap block is required and i also think it is not a problem.
> > 
> > But who knows, therefore it makes sense to have a lock at workload.
> > 
> There is a lock-stat statistics for vm_map_ram()/vm_unmap_ram() test.
> I did it on 64 CPUs system with running 64 threads doing mapping/unmapping
> of 1 page. Each thread does 10 000 000 mapping + unmapping in a loop:
> 
> <snip>
> root@pc638:/home/urezki# cat /proc/lock_stat
> lock_stat version 0.4
> -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> vmap_area_lock:       2554079        2554276           0.06         213.61    11719647.67           4.59        2986513        3005712           0.05          67.02     3573323.37           1.19
>   --------------
>   vmap_area_lock        1297948          [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
>   vmap_area_lock        1256330          [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
>   vmap_area_lock              1          [<00000000c95c05a7>] find_vm_area+0x16/0x70
>   --------------
>   vmap_area_lock        1738590          [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
>   vmap_area_lock         815688          [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
>   vmap_area_lock              1          [<00000000c1d619d7>] __get_vm_area_node+0xd2/0x170
> 
> .....................................................................................................................................................................................................
> 
> vmap_blocks.xa_lock:        862689         862698           0.05          77.74      849325.39           0.98        3005156        3005709           0.12          31.11     1920242.82           0.64
>   -------------------
>   vmap_blocks.xa_lock         378418          [<00000000625a5626>] vm_map_ram+0x359/0x4a0
>   vmap_blocks.xa_lock         484280          [<00000000caa2ef03>] xa_erase+0xe/0x30
>   -------------------
>   vmap_blocks.xa_lock         576226          [<00000000caa2ef03>] xa_erase+0xe/0x30
>   vmap_blocks.xa_lock         286472          [<00000000625a5626>] vm_map_ram+0x359/0x4a0
> 
> ....................................................................................................................................................................................................
> 
> free_vmap_area_lock:        394960         394961           0.05         124.78      448241.23           1.13        1514508        1515077           0.12          30.48     1179167.01           0.78
>   -------------------
>   free_vmap_area_lock         385970          [<00000000955bd641>] alloc_vmap_area+0xe5/0x910
>   free_vmap_area_lock           4692          [<00000000230abf7e>] __purge_vmap_area_lazy+0x10a/0x7d0
>   free_vmap_area_lock           4299          [<00000000eed9ff9e>] alloc_vmap_area+0x497/0x910
>   -------------------
>   free_vmap_area_lock         371734          [<00000000955bd641>] alloc_vmap_area+0xe5/0x910
>   free_vmap_area_lock          17007          [<00000000230abf7e>] __purge_vmap_area_lazy+0x10a/0x7d0
>   free_vmap_area_lock           6220          [<00000000eed9ff9e>] alloc_vmap_area+0x497/0x910
> 
> .....................................................................................................................................................................................................
> 
> purge_vmap_area_lock:        169307         169312           0.05          31.08       81655.21           0.48        1514794        1515078           0.05          67.73      912391.12           0.60
>   --------------------
>   purge_vmap_area_lock         166409          [<0000000050938075>] free_vmap_area_noflush+0x65/0x370
>   purge_vmap_area_lock           2903          [<00000000fb8b57f7>] __purge_vmap_area_lazy+0x47/0x7d0
>   --------------------
>   purge_vmap_area_lock         167511          [<0000000050938075>] free_vmap_area_noflush+0x65/0x370
>   purge_vmap_area_lock           1801          [<00000000fb8b57f7>] __purge_vmap_area_lazy+0x47/0x7d0
> <snip>
> 
> alloc_vmap_area is a top and second one is xa_lock. But the test i have
> done is pretty high concurrent scenario.
> 
<snip>
From 32c38d239c6de3f1d3accf97d9d4944ecaa4bccd Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Thu, 23 Mar 2023 13:07:27 +0100
Subject: [PATCH] mm: vmalloc: Remove global vmap_blocks xarray

A global vmap_blocks-xarray array can be contented under
heavy usage of the vm_map_ram()/vm_unmap_ram() APIs. Under
stress test the lock-stat shows that a "vmap_blocks.xa_lock"
lock is a second in a list when it comes to contentions:

<snip>
----------------------------------------
class name con-bounces contentions ...
----------------------------------------
...
vmap_blocks.xa_lock:    862689 862698 ...
  -------------------
  vmap_blocks.xa_lock   378418    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
  vmap_blocks.xa_lock   484280    [<00000000caa2ef03>] xa_erase+0xe/0x30
  -------------------
  vmap_blocks.xa_lock   576226    [<00000000caa2ef03>] xa_erase+0xe/0x30
  vmap_blocks.xa_lock   286472    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
...
<snip>

that is a result of running vm_map_ram()/vm_unmap_ram() in
a loop. The test creates 64(on 64 CPUs system) threads and
each one maps/unmaps 1 page.

After this change the xa_lock is considered as noise in the
same test condition:

<snip>
...
&xa->xa_lock#1:         10333 10394 ...
  --------------
  &xa->xa_lock#1        5349      [<00000000bbbc9751>] xa_erase+0xe/0x30
  &xa->xa_lock#1        5045      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
  --------------
  &xa->xa_lock#1        7326      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
  &xa->xa_lock#1        3068      [<00000000bbbc9751>] xa_erase+0xe/0x30
...
<snip>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 54 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 978194dc2bb8..b1e549d152b2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1911,6 +1911,7 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 struct vmap_block_queue {
 	spinlock_t lock;
 	struct list_head free;
+	struct xarray vmap_blocks;
 };
 
 struct vmap_block {
@@ -1927,25 +1928,22 @@ struct vmap_block {
 /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
 static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 
-/*
- * XArray of vmap blocks, indexed by address, to quickly find a vmap block
- * in the free path. Could get rid of this if we change the API to return a
- * "cookie" from alloc, to be passed to free. But no big deal yet.
- */
-static DEFINE_XARRAY(vmap_blocks);
-
-/*
- * We should probably have a fallback mechanism to allocate virtual memory
- * out of partially filled vmap blocks. However vmap block sizing should be
- * fairly reasonable according to the vmalloc size, so it shouldn't be a
- * big problem.
- */
+static struct vmap_block_queue *
+addr_to_vbq(unsigned long addr)
+{
+	int cpu = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	return &per_cpu(vmap_block_queue, cpu);
+}
 
-static unsigned long addr_to_vb_idx(unsigned long addr)
+static unsigned long
+addr_to_vb_va_start(unsigned long addr)
 {
-	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
-	addr /= VMAP_BLOCK_SIZE;
-	return addr;
+	/* Check if aligned. */
+	if (IS_ALIGNED(addr, VMAP_BLOCK_SIZE))
+		return addr;
+
+	/* A start address of block an address belongs to. */
+	return rounddown(addr, VMAP_BLOCK_SIZE);
 }
 
 static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
@@ -1953,7 +1951,7 @@ static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
 	unsigned long addr;
 
 	addr = va_start + (pages_off << PAGE_SHIFT);
-	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
+	BUG_ON(addr_to_vb_va_start(addr) != addr_to_vb_va_start(va_start));
 	return (void *)addr;
 }
 
@@ -1970,7 +1968,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	struct vmap_block_queue *vbq;
 	struct vmap_block *vb;
 	struct vmap_area *va;
-	unsigned long vb_idx;
 	int node, err;
 	void *vaddr;
 
@@ -2003,8 +2000,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	bitmap_set(vb->used_map, 0, (1UL << order));
 	INIT_LIST_HEAD(&vb->free_list);
 
-	vb_idx = addr_to_vb_idx(va->va_start);
-	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
+	vbq = addr_to_vbq(va->va_start);
+	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
 	if (err) {
 		kfree(vb);
 		free_vmap_area(va);
@@ -2021,9 +2018,11 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 static void free_vmap_block(struct vmap_block *vb)
 {
+	struct vmap_block_queue *vbq;
 	struct vmap_block *tmp;
 
-	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
+	vbq = addr_to_vbq(vb->va->va_start);
+	tmp = xa_erase(&vbq->vmap_blocks, vb->va->va_start);
 	BUG_ON(tmp != vb);
 
 	spin_lock(&vmap_area_lock);
@@ -2135,6 +2134,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	unsigned long offset;
 	unsigned int order;
 	struct vmap_block *vb;
+	struct vmap_block_queue *vbq;
 
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
@@ -2143,7 +2143,10 @@ static void vb_free(unsigned long addr, unsigned long size)
 
 	order = get_order(size);
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
-	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
+
+	vbq = addr_to_vbq(addr);
+	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start(addr));
+
 	spin_lock(&vb->lock);
 	bitmap_clear(vb->used_map, offset, (1UL << order));
 	spin_unlock(&vb->lock);
@@ -3486,6 +3489,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 {
 	char *start;
 	struct vmap_block *vb;
+	struct vmap_block_queue *vbq;
 	unsigned long offset;
 	unsigned int rs, re, n;
 
@@ -3503,7 +3507,8 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	 * Area is split into regions and tracked with vmap_block, read out
 	 * each region and zero fill the hole between regions.
 	 */
-	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
+	vbq = addr_to_vbq((unsigned long) addr);
+	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start((unsigned long) addr));
 	if (!vb)
 		goto finished;
 
@@ -4272,6 +4277,7 @@ void __init vmalloc_init(void)
 		p = &per_cpu(vfree_deferred, i);
 		init_llist_head(&p->list);
 		INIT_WORK(&p->wq, delayed_vfree_work);
+		xa_init(&vbq->vmap_blocks);
 	}
 
 	/* Import existing vmlist entries. */
-- 
2.30.2
<snip>

Any thoughts patch?

I do not consider it as a big improvement in performance. But, it tends
to remove completely a contention on the "xa_lock" + it refactor slightly
the per-cpu allocator. XFS workloads can be improved, though.

--
Uladzislau Rezki
