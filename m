Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63B735AE0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhDJORX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Apr 2021 10:17:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:54359 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234668AbhDJORX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:17:23 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-84-kCKo1-18OZuYsleNdk-yPA-1; Sat, 10 Apr 2021 15:17:06 +0100
X-MC-Unique: kCKo1-18OZuYsleNdk-yPA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 10 Apr 2021 15:17:05 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Sat, 10 Apr 2021 15:17:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        kernel test robot <lkp@intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: Bogus struct page layout on 32-bit
Thread-Topic: Bogus struct page layout on 32-bit
Thread-Index: AQHXLbNopyewSd0HZEaZbqB5fscTXqqtw2Cg
Date:   Sat, 10 Apr 2021 14:17:04 +0000
Message-ID: <b9d5b09eaec44334b29241e16b8605d5@AcuMS.aculab.com>
References: <20210409185105.188284-3-willy@infradead.org>
 <202104100656.N7EVvkNZ-lkp@intel.com>
 <20210410024313.GX2531743@casper.infradead.org>
In-Reply-To: <20210410024313.GX2531743@casper.infradead.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox
> Sent: 10 April 2021 03:43
> On Sat, Apr 10, 2021 at 06:45:35AM +0800, kernel test robot wrote:
> > >> include/linux/mm_types.h:274:1: error: static_assert failed due to requirement
> '__builtin_offsetof(struct page, lru) == __builtin_offsetof(struct folio, lru)' "offsetof(struct page,
> lru) == offsetof(struct folio, lru)"
> >    FOLIO_MATCH(lru, lru);
> >    include/linux/mm_types.h:272:2: note: expanded from macro 'FOLIO_MATCH'
> >            static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
> 
> Well, this is interesting.  pahole reports:
> 
> struct page {
>         long unsigned int          flags;                /*     0     4 */
>         /* XXX 4 bytes hole, try to pack */
>         union {
>                 struct {
>                         struct list_head lru;            /*     8     8 */
> ...
> struct folio {
>         union {
>                 struct {
>                         long unsigned int flags;         /*     0     4 */
>                         struct list_head lru;            /*     4     8 */
> 
> so this assert has absolutely done its job.
> 
> But why has this assert triggered?  Why is struct page layout not what
> we thought it was?  Turns out it's the dma_addr added in 2019 by commit
> c25fff7171be ("mm: add dma_addr_t to struct page").  On this particular
> config, it's 64-bit, and ppc32 requires alignment to 64-bit.  So
> the whole union gets moved out by 4 bytes.
> 
> Unfortunately, we can't just fix this by putting an 'unsigned long pad'
> in front of it.  It still aligns the entire union to 8 bytes, and then
> it skips another 4 bytes after the pad.
> 
> We can fix it like this ...
> 
> +++ b/include/linux/mm_types.h
> @@ -96,11 +96,12 @@ struct page {
>                         unsigned long private;
>                 };
>                 struct {        /* page_pool used by netstack */
> +                       unsigned long _page_pool_pad;
>                         /**
>                          * @dma_addr: might require a 64-bit value even on
>                          * 32-bit architectures.
>                          */
> -                       dma_addr_t dma_addr;
> +                       dma_addr_t dma_addr __packed;
>                 };
>                 struct {        /* slab, slob and slub */
>                         union {
> 
> but I don't know if GCC is smart enough to realise that dma_addr is now
> on an 8 byte boundary and it can use a normal instruction to access it,
> or whether it'll do something daft like use byte loads to access it.

I'm betting it will use byte accesses.
Checked - it does seem to use 4-byte accesses.
(godbolt is rather short of 32 bit compilers...)

> 
> We could also do:
> 
> +                       dma_addr_t dma_addr __packed __aligned(sizeof(void *));

I wonder if __aligned(n) should be defined as
	__attribute__((packed,aligned(n))
I don't think you ever want the 'unpacked' variant.

But explicitly reducing the alignment of single member is much
better than the habit of marking the structure 'packed'.

(Never mind the habit of adding __packed 'because we don't want
the compiler to add random padding.)

> 
> and I see pahole, at least sees this correctly:
> 
>                 struct {
>                         long unsigned int _page_pool_pad; /*     4     4 */
>                         dma_addr_t dma_addr __attribute__((__aligned__(4))); /*     8     8 */
>                 } __attribute__((__packed__)) __attribute__((__aligned__(4)));

Is the attribute on the struct an artifact of pahole?
It should just have an alignment of 4 without anything special.

> 
> This presumably affects any 32-bit architecture with a 64-bit phys_addr_t
> / dma_addr_t.  Advice, please?

Only those where a 64-bit value is 64-bit aligned.
So that excludes x86 (which can have 64-bit dma) but includes sparc32
(which probably doesn't).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

