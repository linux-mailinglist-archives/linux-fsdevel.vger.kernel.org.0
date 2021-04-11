Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5958D35B73F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 00:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhDKWgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 18:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKWgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 18:36:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B8C061574;
        Sun, 11 Apr 2021 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lvW0/1imLWgxPdvw89GQU7hXjnk5amCWvOf6j0ZGMxs=; b=ciV9TA9sI2hcmMk+5mvn6+GMnQ
        NVm1V6dO3xEncplJkkDlPA7TgOj6ULsrH2ZS8g/+oRMVmxes2/l/PJUJomi09t748PLbrirAblFzt
        9+iYMHD4kchH5/T/s2uhJzpGrDIP0bzFwXjxq8K7Inz0QPgN16EnsQlshWENlti99ULd0pPPgC9Vj
        MRC1FJZvgC1UEgNB5/X3wMh72XySjbvejFh2JgxyYnO2+gc/910Fy1f/DUK/AnFxSRP2HkYKAi5Ay
        A1nkFFPlVvLZHDJQxw4PZDVM6/IWhLdR10szkk3VpbK2rFhz+VFvaptbayoyArEpMhzHHNLX4tSok
        49f9Ab7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVig5-003WFx-6L; Sun, 11 Apr 2021 22:35:44 +0000
Date:   Sun, 11 Apr 2021 23:35:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Linux-MM <linux-mm@kvack.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Bogus struct page layout on 32-bit
Message-ID: <20210411223537.GF2531743@casper.infradead.org>
References: <20210409185105.188284-3-willy@infradead.org>
 <202104100656.N7EVvkNZ-lkp@intel.com>
 <20210410024313.GX2531743@casper.infradead.org>
 <CAK8P3a3uEGaEN-p06vFP+jwbFt3P=Bx4=aRN+kUyB4PcFPxLRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3uEGaEN-p06vFP+jwbFt3P=Bx4=aRN+kUyB4PcFPxLRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 10, 2021 at 09:10:47PM +0200, Arnd Bergmann wrote:
> On Sat, Apr 10, 2021 at 4:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > +                       dma_addr_t dma_addr __packed;
> >                 };
> >                 struct {        /* slab, slob and slub */
> >                         union {
> >
> > but I don't know if GCC is smart enough to realise that dma_addr is now
> > on an 8 byte boundary and it can use a normal instruction to access it,
> > or whether it'll do something daft like use byte loads to access it.
> >
> > We could also do:
> >
> > +                       dma_addr_t dma_addr __packed __aligned(sizeof(void *));
> >
> > and I see pahole, at least sees this correctly:
> >
> >                 struct {
> >                         long unsigned int _page_pool_pad; /*     4     4 */
> >                         dma_addr_t dma_addr __attribute__((__aligned__(4))); /*     8     8 */
> >                 } __attribute__((__packed__)) __attribute__((__aligned__(4)));
> >
> > This presumably affects any 32-bit architecture with a 64-bit phys_addr_t
> > / dma_addr_t.  Advice, please?
> 
> I've tried out what gcc would make of this:  https://godbolt.org/z/aTEbxxbG3
> 
> struct page {
>     short a;
>     struct {
>         short b;
>         long long c __attribute__((packed, aligned(2)));
>     } __attribute__((packed));
> } __attribute__((aligned(8)));
> 
> In this structure, 'c' is clearly aligned to eight bytes, and gcc does
> realize that
> it is safe to use the 'ldrd' instruction for 32-bit arm, which is forbidden on
> struct members with less than 4 byte alignment. However, it also complains
> that passing a pointer to 'c' into a function that expects a 'long long' is not
> allowed because alignof(c) is only '2' here.
> 
> (I used 'short' here because I having a 64-bit member misaligned by four
> bytes wouldn't make a difference to the instructions on Arm, or any other
> 32-bit architecture I can think of, regardless of the ABI requirements).

So ... we could do this:

+++ b/include/linux/types.h
@@ -140,7 +140,7 @@ typedef u64 blkcnt_t;
  * so they don't care about the size of the actual bus addresses.
  */
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-typedef u64 dma_addr_t;
+typedef u64 __attribute__((aligned(sizeof(void *)))) dma_addr_t;
 #else
 typedef u32 dma_addr_t;
 #endif

but I'm a little scared that this might have unintended consequences.
And Jesper points out that a big-endian 64-bit dma_addr_t can impersonate
a PageTail page, and we should solve that problem while we're at it.
So I don't think we should do this, but thought I should mention it as
a possibility.
