Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A935AA57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 04:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhDJCo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 22:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:44:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE7CC061762;
        Fri,  9 Apr 2021 19:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kSBfGQGdldHOGZqey2pG91Lm4sBchHdpUdkbO6By1YI=; b=Exz1xebH0z4i/y6qs7XFO141Qk
        eRdSApUIFaSir1NyVFycHEYEbOXEp95qDIa230dForIUOhOrcL8b410X67OZZNpDdPq7jmGPKucr7
        Jm/mNgBVC4BZbhVGO7ZiGnxsB72BAayKt8FYPWcUkpAAo/QYX9jaHmqnmcaOOEaZUAvoCv7+YoC+d
        azojKss4OD+27TdGNupRux2mmMjSbuKCdgisakoI1PTwZoivDI2KZGt9qSU6szreGgStQJ6HXtug+
        4dyr/8D2BnK5laEKba2tcv99gMP977IVwZBCOGjK+KP98CtMI/JYoGJ42Sjy4kn89qoYCE05lmJgV
        2L/4kfhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lV3ab-001Esh-RM; Sat, 10 Apr 2021 02:43:27 +0000
Date:   Sat, 10 Apr 2021 03:43:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Bogus struct page layout on 32-bit
Message-ID: <20210410024313.GX2531743@casper.infradead.org>
References: <20210409185105.188284-3-willy@infradead.org>
 <202104100656.N7EVvkNZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104100656.N7EVvkNZ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 10, 2021 at 06:45:35AM +0800, kernel test robot wrote:
> >> include/linux/mm_types.h:274:1: error: static_assert failed due to requirement '__builtin_offsetof(struct page, lru) == __builtin_offsetof(struct folio, lru)' "offsetof(struct page, lru) == offsetof(struct folio, lru)"
>    FOLIO_MATCH(lru, lru);
>    include/linux/mm_types.h:272:2: note: expanded from macro 'FOLIO_MATCH'
>            static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))

Well, this is interesting.  pahole reports:

struct page {
        long unsigned int          flags;                /*     0     4 */
        /* XXX 4 bytes hole, try to pack */
        union {
                struct {
                        struct list_head lru;            /*     8     8 */
...
struct folio {
        union {
                struct {
                        long unsigned int flags;         /*     0     4 */
                        struct list_head lru;            /*     4     8 */

so this assert has absolutely done its job.

But why has this assert triggered?  Why is struct page layout not what
we thought it was?  Turns out it's the dma_addr added in 2019 by commit
c25fff7171be ("mm: add dma_addr_t to struct page").  On this particular
config, it's 64-bit, and ppc32 requires alignment to 64-bit.  So
the whole union gets moved out by 4 bytes.

Unfortunately, we can't just fix this by putting an 'unsigned long pad'
in front of it.  It still aligns the entire union to 8 bytes, and then
it skips another 4 bytes after the pad.

We can fix it like this ...

+++ b/include/linux/mm_types.h
@@ -96,11 +96,12 @@ struct page {
                        unsigned long private;
                };
                struct {        /* page_pool used by netstack */
+                       unsigned long _page_pool_pad;
                        /**
                         * @dma_addr: might require a 64-bit value even on
                         * 32-bit architectures.
                         */
-                       dma_addr_t dma_addr;
+                       dma_addr_t dma_addr __packed;
                };
                struct {        /* slab, slob and slub */
                        union {

but I don't know if GCC is smart enough to realise that dma_addr is now
on an 8 byte boundary and it can use a normal instruction to access it,
or whether it'll do something daft like use byte loads to access it.

We could also do:

+                       dma_addr_t dma_addr __packed __aligned(sizeof(void *));

and I see pahole, at least sees this correctly:

                struct {
                        long unsigned int _page_pool_pad; /*     4     4 */
                        dma_addr_t dma_addr __attribute__((__aligned__(4))); /*     8     8 */
                } __attribute__((__packed__)) __attribute__((__aligned__(4)));  

This presumably affects any 32-bit architecture with a 64-bit phys_addr_t
/ dma_addr_t.  Advice, please?
