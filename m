Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA335AC01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhDJIxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Apr 2021 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDJIxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:53:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D5C061762
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Apr 2021 01:53:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z1so9234088ybf.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Apr 2021 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yHuiMf2mbQHC9INRUFE4f0Q8iL2DCKJY335xtgKT+M=;
        b=s0sXCo3dvECgpdJR7whscVJ1iWTqthnxVLYQ+cWKngNry1eueNvN2t1KtSQvyAKpin
         13En8yn6d+Yw7fzHTql9MiHET60pC0eR48G0sg4Y0BJt25ufPVNEf0X34Jx1xzMIG4Hy
         Y7EKWXgnYUH4e5mY/YU8c2uHjr8njpZ3dTzJt0iYL4TJPYPHOv7FAshptX+jC9Tzkz3z
         hfvu7Qt1gZ4d5Qsr3NTxYjx2QW7Fdl/cbwNiQ02u18593AOU/WV8l+R+9uqhoWnAmXr9
         /+iF2mseThA+yNVXeIr6fq/WlwKArwfqxhv/83FA2rfwSlB5wOfyw2hsXxWSVYF6fqRM
         JrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yHuiMf2mbQHC9INRUFE4f0Q8iL2DCKJY335xtgKT+M=;
        b=rsDCfj4HzJX2FsLZHq6mSIC+inP8RORvchV0BO9CEfWLnAkPFunLoU8NO5bFNz3dQ9
         CRTwGGHMyiLzGmxLXOd24Byd1o03jDX+/2876G6tt/I2uRbbrK261tp8lXKY20xhdzmS
         m5Kf03ZKvizQISBpJa73D+o2ZxqA2xcojGUr32Kb4WxLifkObLmDUUg1P16yg8Pm3kRW
         cBSX5ncP5wCGf/VnlUSfrqkLkEm6vhIiVmnL6rbHPWBbUShnJoO2Vkt9XvjRa4lThBbr
         x7n9192Iw0HRdrQSN8eVPPYPqpoTfz6+1QmqVMBo/nabZUtAYwicqf2q2zaydTLHyLhz
         5LYQ==
X-Gm-Message-State: AOAM533Sp0XmB2p283lC7tK0LqNVwDPFXV3SfkHahpk1WJb1ksMuw7NK
        XP9M5luxbs2KuYBhX40zwKOxoeMz/sb/mRxua0sJXw==
X-Google-Smtp-Source: ABdhPJy5dr9lQOxU6kvADPui00Fq+MldBcPrkITVyRf0//k/8cK2iDR0U0j3GM3hEL13gRzjdmouFNrBWiWVxuk2Mok=
X-Received: by 2002:a25:2bc1:: with SMTP id r184mr25473310ybr.51.1618044782263;
 Sat, 10 Apr 2021 01:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210409185105.188284-3-willy@infradead.org> <202104100656.N7EVvkNZ-lkp@intel.com>
 <20210410024313.GX2531743@casper.infradead.org> <20210410082158.79ad09a6@carbon>
In-Reply-To: <20210410082158.79ad09a6@carbon>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Sat, 10 Apr 2021 11:52:26 +0300
Message-ID: <CAC_iWjLXZ6-hhvmvee6r4R_N64u-hrnLqE_CSS1nQk+YaMQQnA@mail.gmail.com>
Subject: Re: Bogus struct page layout on 32-bit
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Linux-MM <linux-mm@kvack.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC Grygorii for the cpsw part as Ivan's email is not valid anymore

Thanks for catching this. Interesting indeed...

On Sat, 10 Apr 2021 at 09:22, Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> On Sat, 10 Apr 2021 03:43:13 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
>
> > On Sat, Apr 10, 2021 at 06:45:35AM +0800, kernel test robot wrote:
> > > >> include/linux/mm_types.h:274:1: error: static_assert failed due to requirement '__builtin_offsetof(struct page, lru) == __builtin_offsetof(struct folio, lru)' "offsetof(struct page, lru) == offsetof(struct folio, lru)"
> > >    FOLIO_MATCH(lru, lru);
> > >    include/linux/mm_types.h:272:2: note: expanded from macro 'FOLIO_MATCH'
> > >            static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
> >
> > Well, this is interesting.  pahole reports:
> >
> > struct page {
> >         long unsigned int          flags;                /*     0     4 */
> >         /* XXX 4 bytes hole, try to pack */
> >         union {
> >                 struct {
> >                         struct list_head lru;            /*     8     8 */
> > ...
> > struct folio {
> >         union {
> >                 struct {
> >                         long unsigned int flags;         /*     0     4 */
> >                         struct list_head lru;            /*     4     8 */
> >
> > so this assert has absolutely done its job.
> >
> > But why has this assert triggered?  Why is struct page layout not what
> > we thought it was?  Turns out it's the dma_addr added in 2019 by commit
> > c25fff7171be ("mm: add dma_addr_t to struct page").  On this particular
> > config, it's 64-bit, and ppc32 requires alignment to 64-bit.  So
> > the whole union gets moved out by 4 bytes.
>
> Argh, good that you are catching this!
>
> > Unfortunately, we can't just fix this by putting an 'unsigned long pad'
> > in front of it.  It still aligns the entire union to 8 bytes, and then
> > it skips another 4 bytes after the pad.
> >
> > We can fix it like this ...
> >
> > +++ b/include/linux/mm_types.h
> > @@ -96,11 +96,12 @@ struct page {
> >                         unsigned long private;
> >                 };
> >                 struct {        /* page_pool used by netstack */
> > +                       unsigned long _page_pool_pad;
>
> I'm fine with this pad.  Matteo is currently proposing[1] to add a 32-bit
> value after @dma_addr, and he could use this area instead.
>
> [1] https://lore.kernel.org/netdev/20210409223801.104657-3-mcroce@linux.microsoft.com/
>
> When adding/changing this, we need to make sure that it doesn't overlap
> member @index, because network stack use/check page_is_pfmemalloc().
> As far as my calculations this is safe to add.  I always try to keep an
> eye out for this, but I wonder if we could have a build check like yours.
>
>
> >                         /**
> >                          * @dma_addr: might require a 64-bit value even on
> >                          * 32-bit architectures.
> >                          */
> > -                       dma_addr_t dma_addr;
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
> I'm not sure that the 32-bit behavior is with 64-bit (dma) addrs.
>
> I don't have any 32-bit boards with 64-bit DMA.  Cc. Ivan, wasn't your
> board (572x ?) 32-bit with driver 'cpsw' this case (where Ivan added
> XDP+page_pool) ?
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
