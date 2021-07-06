Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8103BD4A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhGFMPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 08:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245147AbhGFMM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:12:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840FDC061574;
        Tue,  6 Jul 2021 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fz8nF0VvqASVf4DbdzvDOafrQ9TSRbCa0m4+JXcIrn0=; b=SBM+5pSXppWogXeoTfoIyFNkHB
        XKLpcFUeu4QHdxqUQYpq5/S6lr25MvHybzFvvfwTkwSKIdDzAgOHZfnr2KlLz/2/zR3Lwzb/ikYVx
        Bdt10jcYODzGKXZQljrIxfTlBPYXB36oZnNwD5Kuvai4a9t3Qoi9bLjrbmTuIJk3I+yAVeX+UO6d7
        Hbo/86Qsn04ajnJbmi1md9nkse6oxQNQGt+RP9hR3QVEuT5zNkqYDacL1yFi7LCHzn0IPji2lxh51
        Z7AlbJrtqx9fEpsV8T9Et8TGJKzVqRmMjzituz/jXXLXasiP+QpGt7SSlbE0SyVL+vIGKqstMq967
        wHIzxW9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0jjE-00BHHR-Io; Tue, 06 Jul 2021 11:59:08 +0000
Date:   Tue, 6 Jul 2021 12:59:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
Message-ID: <YORFiMS+HD3dg2Su@casper.infradead.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN9vZfo+84gizjtf@casper.infradead.org>
 <492c7a7b-6f2e-de45-c733-51c80422305e@huawei.com>
 <YOQ5nuuoBVHABK1C@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOQ5nuuoBVHABK1C@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 06, 2021 at 12:08:14PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 05, 2021 at 11:35:08AM +0800, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2021/7/3 3:56, Matthew Wilcox wrote:
> > > On Fri, Jul 02, 2021 at 05:21:09PM +0800, Zhen Lei wrote:
> > >> Move the evaluation expression "size - offset" after the "if (offset < 0)"
> > >> judgment statement to eliminate a false positive produced by the UBSAN.
> > >>
> > >> No functional changes.
> > >>
> > >> ==========================================================================
> > >> UBSAN: Undefined behaviour in fs/iomap.c:1435:9
> > >> signed integer overflow:
> > >> 0 - -9223372036854775808 cannot be represented in type 'long long int'
> > > 
> > > I don't understand.  I thought we defined the behaviour of signed
> > > integer overflow in the kernel with whatever-the-gcc-flag-is?
> > 
> > -9223372036854775808 ==> 0x8000000000000000 ==> -0

(actually, this is incorrect.  think about how twos-complement
arithmetic works.  first you negate every bit, so 8000..000 turns into
7fff..fff, then you add one, returning to 8000..000, so -LLONG_MIN ==
LLONG_MIN)

> > I don't fully understand what you mean. This is triggered by explicit error
> > injection '-0' at runtime, which should not be detected by compilation options.
> 
> We use -fwrapv on the gcc command line:
> 
> '-fwrapv'
>      This option instructs the compiler to assume that signed arithmetic
>      overflow of addition, subtraction and multiplication wraps around
>      using twos-complement representation.  This flag enables some
>      optimizations and disables others.
> 
> > lseek(r1, 0x8000000000000000, 0x3)
> 
> I'll see about adding this to xfstests ...

I have and it doesn't produce the problem.  My config:

CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
CONFIG_UBSAN_DIV_ZERO=y
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set

I even went as far as adding printks to be sure I'm hitting it:

hole length 0x8000000000000000
data length 0x8000000000000000

Are you compiling with:
KBUILD_CFLAGS   += -fno-strict-overflow

Or have you done something weird?  What compiler version are you using?
