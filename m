Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9416B960C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 14:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCNN0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 09:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjCNNZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:25:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90996616;
        Tue, 14 Mar 2023 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CyA6aX3LWF3S0LPq2B7KDIy9+tGtAg2Aqm4KsZBo8Hk=; b=IjN16Nr/j4WtYjF4MKbc6hAh/E
        r1bkPgb4/YGLPSO+ZHwaIHrCj6AYOllQjfgCiURKiKyBq/kCQXyJstxnIGpP0Vp2YeHco2JAHOzMx
        fSXXBplsiWXjS1M9T8XQcAljcKIllA2fXBIzNlruoPlmC8WzJ+VS9zhbX79ayTGui8Q4CwDm0kTmu
        Jhcre75eo3MY1gtiyS20cX/f7Sdv32876LgD2fKZ45TJf/GjH/ZYl4xy5PxXk9sg9M46M1hQWZq7B
        X+GRLXQN4L6C2qX9h4igSgw7kW9G0VopqYa1C22FUfitHAIXtVRczeFUkUdA8DPHR+A9X2P7rg78c
        pS15A3pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc4MQ-00CvDN-HJ; Tue, 14 Mar 2023 13:06:38 +0000
Date:   Tue, 14 Mar 2023 13:06:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
Message-ID: <ZBBxXhvL/oS3uu5/@casper.infradead.org>
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:05:13AM +0100, Vlastimil Babka wrote:
> The immediate benefit of that is that we can allow kfree() (and kfree_rcu())
> to free objects from kmem_cache_alloc() - something that IIRC at least xfs
> people wanted in the past, and SLOB was incompatible with that.
> 
> For SLAB removal I haven't yet heard any objections (but also didn't
> deprecate it yet) but if there are any users due to particular workloads
> doing better with SLAB than SLUB, we can discuss why those would regress and
> what can be done about that in SLUB.
> 
> Once we have just one slab allocator in the kernel, we can take a closer
> look at what the users are missing from it that forces them to create own
> allocators (e.g. BPF), and could be considered to be added as a generic
> implementation to SLUB.

With kfree() now working on kmem_cache_alloc(), I'd like to re-propose
the introduction of a generic free() function which can free any
allocated object.  It starts out looking a lot like kvfree(), but
can be enhanced to cover other things ... here's a version I did from
2018 before giving up on it when I realised slob made it impossible:

+/**
+ * free() - Free memory
+ * @ptr: Pointer to memory
+ *
+ * This function can free almost any type of memory.  It can safely be
+ * called on:
+ * * NULL pointers.
+ * * Pointers to read-only data (will do nothing).
+ * * Pointers to memory allocated from kmalloc().
+ * * Pointers to memory allocated from kmem_cache_alloc().
+ * * Pointers to memory allocated from vmalloc().
+ * * Pointers to memory allocated from alloc_percpu().
+ * * Pointers to memory allocated from __get_free_pages().
+ * * Pointers to memory allocated from page_frag_alloc().
+ *
+ * It cannot free memory allocated by dma_pool_alloc() or dma_alloc_coherent().
+ */
+void free(const void *ptr)
+{
+       struct page *page;
+
+       if (unlikely(ZERO_OR_NULL_PTR(ptr)))
+               return;
+       if (is_kernel_rodata((unsigned long)ptr))
+               return;
+
+       page = virt_to_head_page(ptr);
+       if (likely(PageSlab(page)))
+               return kmem_cache_free(page->slab_cache, (void *)ptr);
+
+       if (is_vmalloc_addr(ptr))
+               return vfree(ptr);
+       if (is_kernel_percpu_address((unsigned long)ptr))
+               free_percpu((void __percpu *)ptr);
+       if (put_page_testzero(page))
+               __put_page(page);
+}
+EXPORT_SYMBOL(free);

Looking at it now, I'd also include a test for stack memory (and do
nothing if it is)

There are some prep patches that I'm not including here to clear out
the use of 'free' as a function name (some conflicting identifiers named
'free') and a fun one to set a SLAB_PAGE_DTOR on compound pages.
