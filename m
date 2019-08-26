Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D309D187
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfHZOUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 10:20:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfHZOUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V0uigkUycCucrURUgv+bF+EAlDBoS2rtv7+iIe1QC+E=; b=dQW90a63hi9O4V1MFUl1FSkAk
        fgLxiEC2IxHLK5Pf1bcQi+VBmksAKxSiBB32zDMxp7Bg9QcmYp2Rj7FH4a14kCs7Mn5Afs1VXSMaA
        2aXEMH/C97023nhZapdJYwSb6DWGGD+PIHYm29LFZm9RxRdX6ZMiOiZK4EUJah0B7PYjgr7+amroW
        0W5cMKO3VC5gMvXwGLo4q9UUv3jcMbHZLBMS9QP6Lf2ZkZcFL2/yLG5NCgUfVpdbzpVAwT6ZKxlzc
        N1SedO9jTrnVMTpb36CRvNY4AHcEYX8JZKEpPs3xqEzsJ5hGDfsrHQHE2F3kE8ad9YYnYlAeARxqu
        qT7vMNoDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Fqw-0004rT-KL; Mon, 26 Aug 2019 14:20:14 +0000
Date:   Mon, 26 Aug 2019 07:20:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] fs/proc/page: Skip uninitialized page when iterating
 page structures
Message-ID: <20190826142014.GD15933@bombadil.infradead.org>
References: <20190826124336.8742-1-longman@redhat.com>
 <20190826132529.GC15933@bombadil.infradead.org>
 <60464cac-6319-c3c1-47b8-d9b5cf586754@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60464cac-6319-c3c1-47b8-d9b5cf586754@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:43:24AM -0400, Waiman Long wrote:
> On 8/26/19 9:25 AM, Matthew Wilcox wrote:
> > On Mon, Aug 26, 2019 at 08:43:36AM -0400, Waiman Long wrote:
> >> It was found that on a dual-socket x86-64 system with nvdimm, reading
> >> /proc/kpagecount may cause the system to panic:
> >>
> >> ===================
> >> [   79.917682] BUG: unable to handle page fault for address: fffffffffffffffe
> >> [   79.924558] #PF: supervisor read access in kernel mode
> >> [   79.929696] #PF: error_code(0x0000) - not-present page
> >> [   79.934834] PGD 87b60d067 P4D 87b60d067 PUD 87b60f067 PMD 0
> >> [   79.940494] Oops: 0000 [#1] SMP NOPTI
> >> [   79.944157] CPU: 89 PID: 3455 Comm: cp Not tainted 5.3.0-rc5-test+ #14
> >> [   79.950682] Hardware name: Dell Inc. PowerEdge R740/07X9K0, BIOS 2.2.11 06/13/2019
> >> [   79.958246] RIP: 0010:kpagecount_read+0xdb/0x1a0
> >> [   79.962859] Code: e8 09 83 e0 3f 48 0f a3 02 73 2d 4c 89 f7 48 c1 e7 06 48 03 3d fe da de 00 74 1d 48 8b 57 08 48 8d 42 ff 83 e2 01 48 0f 44 c7 <48> 8b 00 f6 c4 02 75 06 83 7f 30 80 7d 62 31 c0 4c 89 f9 e8 5d c9
> >> [   79.981603] RSP: 0018:ffffb0d9c950fe70 EFLAGS: 00010202
> >> [   79.986830] RAX: fffffffffffffffe RBX: ffff8beebe5383c0 RCX: ffffb0d9c950ff00
> >> [   79.993963] RDX: 0000000000000001 RSI: 00007fd85b29e000 RDI: ffffe77a22000000
> >> [   80.001095] RBP: 0000000000020000 R08: 0000000000000001 R09: 0000000000000000
> >> [   80.008226] R10: 0000000000000000 R11: 0000000000000001 R12: 00007fd85b29e000
> >> [   80.015358] R13: ffffffff893f0480 R14: 0000000000880000 R15: 00007fd85b29e000
> >> [   80.022491] FS:  00007fd85b312800(0000) GS:ffff8c359fb00000(0000) knlGS:0000000000000000
> >> [   80.030576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   80.036321] CR2: fffffffffffffffe CR3: 0000004f54a38001 CR4: 00000000007606e0
> >> [   80.043455] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> [   80.050586] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> [   80.057718] PKRU: 55555554
> >> [   80.060428] Call Trace:
> >> [   80.062877]  proc_reg_read+0x39/0x60
> >> [   80.066459]  vfs_read+0x91/0x140
> >> [   80.069686]  ksys_read+0x59/0xd0
> >> [   80.072922]  do_syscall_64+0x59/0x1e0
> >> [   80.076588]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> [   80.081637] RIP: 0033:0x7fd85a7f5d75
> >> ===================
> >>
> >> It turns out the panic was caused by the kpagecount_read() function
> >> hitting an uninitialized page structure at PFN 0x880000 where all its
> >> fields were set to -1. The compound_head value of -1 will mislead the
> >> kernel to treat -2 as a pointer to the head page of the compound page
> >> leading to the crash.
> >>
> >> The system have 12 GB of nvdimm ranging from PFN 0x880000-0xb7ffff.
> >> However, only PFN 0x88c200-0xb7ffff are released by the nvdimm
> >> driver to the kernel and initialized. IOW, PFN 0x880000-0x88c1ff
> >> remain uninitialized. Perhaps these 196 MB of nvdimm are reserved for
> >> internal use.
> >>
> >> To fix the panic, we need to find out if a page structure has been
> >> initialized. This is done now by checking if the PFN is in the range
> >> of a memory zone assuming that pages in a zone is either correctly
> >> marked as not present in the mem_section structure or have their page
> >> structures initialized.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>  fs/proc/page.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 65 insertions(+), 3 deletions(-)
> > Would this not work equally well?
> >
> > +++ b/fs/proc/page.c
> > @@ -46,7 +46,8 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
> >                         ppage = pfn_to_page(pfn);
> >                 else
> >                         ppage = NULL;
> > -               if (!ppage || PageSlab(ppage) || page_has_type(ppage))
> > +               if (!ppage || PageSlab(ppage) || page_has_type(ppage) ||
> > +                               PagePoisoned(ppage))
> >                         pcount = 0;
> >                 else
> >                         pcount = page_mapcount(ppage);
> >
> That is my initial thought too. However, I couldn't find out where the
> memory of the uninitialized page structures may have been initialized
> somehow. The only thing I found is when vm_debug is on that the page
> structures are indeed poisoned. Without that it is probably just
> whatever the content that the memory have when booting up the kernel.
> 
> It just happens on the test system that I used the memory of those page
> structures turned out to be -1. It may be different in other systems
> that can still crash the kernel, but not detected by the PagePoisoned()
> check. That is why I settle on the current scheme which is more general
> and don't rely on the memory get initialized in a certain way.

page_init_poison().

Since you have a system which really experiences page poisoning, I've been
considering a patch like this:

The poison check comes too late -- we're checking a value after dereferencing
a value in a poisoned struct page.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f91cb8898ff0..dd412aeb4bdc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -167,12 +167,17 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
-struct page;	/* forward declaration */
+#define	PAGE_POISON_PATTERN	-1l
+static inline int PagePoisoned(const struct page *page)
+{
+	return page->flags == PAGE_POISON_PATTERN;
+}
 
 static inline struct page *compound_head(struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
+	VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);
 	if (unlikely(head & 1))
 		return (struct page *) (head - 1);
 	return page;
@@ -180,20 +185,16 @@ static inline struct page *compound_head(struct page *page)
 
 static __always_inline int PageTail(struct page *page)
 {
+	VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);
 	return READ_ONCE(page->compound_head) & 1;
 }
 
 static __always_inline int PageCompound(struct page *page)
 {
+	VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);
 	return test_bit(PG_head, &page->flags) || PageTail(page);
 }
 
-#define	PAGE_POISON_PATTERN	-1l
-static inline int PagePoisoned(const struct page *page)
-{
-	return page->flags == PAGE_POISON_PATTERN;
-}
-
 #ifdef CONFIG_DEBUG_VM
 void page_init_poison(struct page *page, size_t size);
 #else
@@ -229,13 +230,13 @@ static inline void page_init_poison(struct page *page, size_t size)
 		VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);		\
 		page; })
 #define PF_ANY(page, enforce)	PF_POISONED_CHECK(page)
-#define PF_HEAD(page, enforce)	PF_POISONED_CHECK(compound_head(page))
+#define PF_HEAD(page, enforce)	compound_head(page)
 #define PF_ONLY_HEAD(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(PageTail(page), page);		\
-		PF_POISONED_CHECK(page); })
+		page; })
 #define PF_NO_TAIL(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
-		PF_POISONED_CHECK(compound_head(page)); })
+		compound_head(page); })
 #define PF_NO_COMPOUND(page, enforce) ({				\
 		VM_BUG_ON_PGFLAGS(enforce && PageCompound(page), page);	\
 		PF_POISONED_CHECK(page); })
