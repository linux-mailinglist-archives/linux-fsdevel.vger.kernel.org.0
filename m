Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31937705F56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 07:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjEQF2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 01:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjEQF2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 01:28:53 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74608421A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 22:28:49 -0700 (PDT)
Date:   Wed, 17 May 2023 01:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684301327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KNyslM0lZEXgJ7hZQo1yzKrBumFKYxUNbWesTXTXx4=;
        b=EVQYZG1l1zu2njdkSV9dw5lA6LzI1QyDeQVNPFM6HysBsOniCOJVRuKgX8t4mR1JZSQCWh
        3BVEbWkYkW2Ru7Mz+2dC7huKPTCZQbfwov/fvd7FizV9OahNja0OCZ34mqs33uVrDDqg5O
        y2AJZFOxeyt+OVNFwJlqZd9nO3r6dfE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZGRmC2Qhe6oAHPIm@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <ZGP54T0d89TMySsf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGP54T0d89TMySsf@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 10:47:13PM +0100, Matthew Wilcox wrote:
> On Tue, May 16, 2023 at 05:20:33PM -0400, Kent Overstreet wrote:
> > On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
> > > For something that small, why not use the text_poke API?
> > 
> > This looks like it's meant for patching existing kernel text, which
> > isn't what I want - I'm generating new functions on the fly, one per
> > btree node.
> > 
> > I'm working up a new allocator - a (very simple) slab allocator where
> > you pass a buffer, and it gives you a copy of that buffer mapped
> > executable, but not writeable.
> > 
> > It looks like we'll be able to convert bpf, kprobes, and ftrace
> > trampolines to it; it'll consolidate a fair amount of code (particularly
> > in bpf), and they won't have to burn a full page per allocation anymore.
> > 
> > bpf has a neat trick where it maps the same page in two different
> > locations, one is the executable location and the other is the writeable
> > location - I'm stealing that.
> 
> How does that avoid the problem of being able to construct an arbitrary
> gadget that somebody else will then execute?  IOW, what bpf has done
> seems like it's working around & undoing the security improvements.
> 
> I suppose it's an improvement that only the executable address is
> passed back to the caller, and not the writable address.

Ok, here's what I came up with. Have not tested all corner cases, still
need to write docs - but I think this gives us a nicer interface than
what bpf/kprobes/etc. have been doing, and it does the sub-page sized
allocations I need.

With an additional tweak to module_alloc() (not done in this patch yet)
we avoid ever mapping in pages both writeable and executable:

-->--

From 6eeb6b8ef4271ea1a8d9cac7fbaeeb7704951976 Mon Sep 17 00:00:00 2001
From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Wed, 17 May 2023 01:22:06 -0400
Subject: [PATCH] mm: jit/text allocator

This provides a new, very simple slab allocator for jit/text, i.e. bpf,
ftrace trampolines, or bcachefs unpack functions.

With this API we can avoid ever mapping pages both writeable and
executable (not implemented in this patch: need to tweak
module_alloc()), and it also supports sub-page sized allocations.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/include/linux/jitalloc.h b/include/linux/jitalloc.h
new file mode 100644
index 0000000000..f1549d60e8
--- /dev/null
+++ b/include/linux/jitalloc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_JITALLOC_H
+#define _LINUX_JITALLOC_H
+
+void jit_update(void *buf, void *new_buf, size_t len);
+void jit_free(void *buf);
+void *jit_alloc(void *buf, size_t len);
+
+#endif /* _LINUX_JITALLOC_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f..ff26a4f0c9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1202,6 +1202,9 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config JITALLOC
+	bool
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index c03e1e5859..25e82db9e8 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_JITALLOC) += jitalloc.o
diff --git a/mm/jitalloc.c b/mm/jitalloc.c
new file mode 100644
index 0000000000..7c4d621802
--- /dev/null
+++ b/mm/jitalloc.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/jitalloc.h>
+#include <linux/mm.h>
+#include <linux/moduleloader.h>
+#include <linux/mutex.h>
+#include <linux/set_memory.h>
+#include <linux/vmalloc.h>
+
+#include <asm/text-patching.h>
+
+static DEFINE_MUTEX(jit_alloc_lock);
+
+struct jit_cache {
+	unsigned		obj_size_bits;
+	unsigned		objs_per_slab;
+	struct list_head	partial;
+};
+
+#define JITALLOC_MIN_SIZE	16
+#define NR_JIT_CACHES		ilog2(PAGE_SIZE / JITALLOC_MIN_SIZE)
+
+static struct jit_cache jit_caches[NR_JIT_CACHES];
+
+struct jit_slab {
+	unsigned long		__page_flags;
+
+	struct jit_cache	*cache;
+	void			*executably_mapped;;
+	unsigned long		*objs_allocated; /* bitmap of free objects */
+	struct list_head	list;
+};
+
+#define folio_jit_slab(folio)		(_Generic((folio),			\
+	const struct folio *:		(const struct jit_slab *)(folio),	\
+	struct folio *:			(struct jit_slab *)(folio)))
+
+#define jit_slab_folio(s)		(_Generic((s),				\
+	const struct jit_slab *:	(const struct folio *)s,		\
+	struct jit_slab *:		(struct folio *)s))
+
+static struct jit_slab *jit_slab_alloc(struct jit_cache *cache)
+{
+	void *executably_mapped = module_alloc(PAGE_SIZE);
+	struct page *page;
+	struct folio *folio;
+	struct jit_slab *slab;
+	unsigned long *objs_allocated;
+
+	if (!executably_mapped)
+		return NULL;
+
+	objs_allocated = kcalloc(BITS_TO_LONGS(cache->objs_per_slab), sizeof(unsigned long), GFP_KERNEL);
+	if (!objs_allocated ) {
+		vfree(executably_mapped);
+		return NULL;
+	}
+
+	set_vm_flush_reset_perms(executably_mapped);
+	set_memory_rox((unsigned long) executably_mapped, 1);
+
+	page = vmalloc_to_page(executably_mapped);
+	folio = page_folio(page);
+
+	__folio_set_slab(folio);
+	slab			= folio_jit_slab(folio);
+	slab->cache		= cache;
+	slab->executably_mapped	= executably_mapped;
+	slab->objs_allocated = objs_allocated;
+	INIT_LIST_HEAD(&slab->list);
+
+	return slab;
+}
+
+static void *jit_cache_alloc(void *buf, size_t len, struct jit_cache *cache)
+{
+	struct jit_slab *s =
+		list_first_entry_or_null(&cache->partial, struct jit_slab, list) ?:
+		jit_slab_alloc(cache);
+	unsigned obj_idx, nr_allocated;
+
+	if (!s)
+		return NULL;
+
+	obj_idx = find_first_zero_bit(s->objs_allocated, cache->objs_per_slab);
+
+	BUG_ON(obj_idx >= cache->objs_per_slab);
+	__set_bit(obj_idx, s->objs_allocated);
+
+	nr_allocated = bitmap_weight(s->objs_allocated, s->cache->objs_per_slab);
+
+	if (nr_allocated == s->cache->objs_per_slab) {
+		list_del_init(&s->list);
+	} else if (nr_allocated == 1) {
+		list_del(&s->list);
+		list_add(&s->list, &s->cache->partial);
+	}
+
+	return s->executably_mapped + (obj_idx << cache->obj_size_bits);
+}
+
+void jit_update(void *buf, void *new_buf, size_t len)
+{
+	text_poke_copy(buf, new_buf, len);
+}
+EXPORT_SYMBOL_GPL(jit_update);
+
+void jit_free(void *buf)
+{
+	struct page *page;
+	struct folio *folio;
+	struct jit_slab *s;
+	unsigned obj_idx, nr_allocated;
+	size_t offset;
+
+	if (!buf)
+		return;
+
+	page	= vmalloc_to_page(buf);
+	folio	= page_folio(page);
+	offset	= offset_in_folio(folio, buf);
+
+	if (!folio_test_slab(folio)) {
+		vfree(buf);
+		return;
+	}
+
+	s = folio_jit_slab(folio);
+
+	mutex_lock(&jit_alloc_lock);
+	obj_idx = offset >> s->cache->obj_size_bits;
+
+	__clear_bit(obj_idx, s->objs_allocated);
+
+	nr_allocated = bitmap_weight(s->objs_allocated, s->cache->objs_per_slab);
+
+	if (nr_allocated == 0) {
+		list_del(&s->list);
+		kfree(s->objs_allocated);
+		folio_put(folio);
+	} else if (nr_allocated + 1 == s->cache->objs_per_slab) {
+		list_del(&s->list);
+		list_add(&s->list, &s->cache->partial);
+	}
+
+	mutex_unlock(&jit_alloc_lock);
+}
+EXPORT_SYMBOL_GPL(jit_free);
+
+void *jit_alloc(void *buf, size_t len)
+{
+	unsigned jit_cache_idx = ilog2(roundup_pow_of_two(len) / 16);
+	void *p;
+
+	if (jit_cache_idx < NR_JIT_CACHES) {
+		mutex_lock(&jit_alloc_lock);
+		p = jit_cache_alloc(buf, len, &jit_caches[jit_cache_idx]);
+		mutex_unlock(&jit_alloc_lock);
+	} else {
+		p = module_alloc(len);
+		if (p) {
+			set_vm_flush_reset_perms(p);
+			set_memory_rox((unsigned long) p, DIV_ROUND_UP(len, PAGE_SIZE));
+		}
+	}
+
+	if (p && buf)
+		jit_update(p, buf, len);
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(jit_alloc);
+
+static int __init jit_alloc_init(void)
+{
+	for (unsigned i = 0; i < ARRAY_SIZE(jit_caches); i++) {
+		jit_caches[i].obj_size_bits	= ilog2(JITALLOC_MIN_SIZE) + i;
+		jit_caches[i].objs_per_slab	= PAGE_SIZE >> jit_caches[i].obj_size_bits;
+
+		INIT_LIST_HEAD(&jit_caches[i].partial);
+	}
+
+	return 0;
+}
+core_initcall(jit_alloc_init);
