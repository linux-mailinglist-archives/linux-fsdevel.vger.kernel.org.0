Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD99D5ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbfHZSkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 14:40:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfHZSkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TlbGGRimIFoER4Eoe8SUJFAjtoU3fH+8C5wgGkgKTdw=; b=Eu2OwW0gMcAlJpcyiOiLAVAtB
        V0pHfL2R1/VkV0VqpkeNwzr7alqEzwLxaEgpcnK52dUj3Vebv/ZvrMVJ5ThNyPxqv7IF0oU8SakBh
        R9em8SXLkW7bvHFtfqDjU5klSJaMLS5vaS7Q7xgHWMgmCKWsn0n4BeCKY9o+tpzPrAlRAB8OysNdO
        P8BabzHViAuY3RJdHX38u27ilCT218FDi0niw/0/FsNoc2hPF2ZL/PKZnAMc6VKFVUq6SF0jkLHuI
        +40feB4E7LQvl2vF7HtQQZwkQiT8Ns7+8cAMYBUgpWosmxkv8oOcCv/7ZgxOJbG6+45C0nqRPdHui
        lCuuq2B/Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2JuH-0007kj-0w; Mon, 26 Aug 2019 18:39:57 +0000
Date:   Mon, 26 Aug 2019 11:39:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Denis Efremov <efremov@ispras.ru>
Cc:     akpm@linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <matthew@wil.cx>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        Erdem Tumurov <erdemus@gmail.com>,
        Vladimir Shelekhov <vshel@iis.nsk.su>
Subject: Re: [PATCH v2] lib/memweight.c: open codes bitmap_weight()
Message-ID: <20190826183956.GF15933@bombadil.infradead.org>
References: <20190821074200.2203-1-efremov@ispras.ru>
 <20190824100102.1167-1-efremov@ispras.ru>
 <20190825061158.GC28002@bombadil.infradead.org>
 <ba051566-0343-ea75-0484-8852f65a15da@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba051566-0343-ea75-0484-8852f65a15da@ispras.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 25, 2019 at 02:39:47PM +0300, Denis Efremov wrote:
> On 25.08.2019 09:11, Matthew Wilcox wrote:
> > On Sat, Aug 24, 2019 at 01:01:02PM +0300, Denis Efremov wrote:
> >> This patch open codes the bitmap_weight() call. The direct
> >> invocation of hweight_long() allows to remove the BUG_ON and
> >> excessive "longs to bits, bits to longs" conversion.
> > 
> > Honestly, that's not the problem with this function.  Take a look
> > at https://danluu.com/assembly-intrinsics/ for a _benchmarked_
> > set of problems with popcnt.
> > 
> >> BUG_ON was required to check that bitmap_weight() will return
> >> a correct value, i.e. the computed weight will fit the int type
> >> of the return value.
> > 
> > What?  No.  Look at the _arguments_ of bitmap_weight():
> > 
> > static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
> 
> I'm not sure why it is INT_MAX then? I would expect in case we care only about arguments
> something like:
>  
> BUG_ON(longs >= UINT_MAX / BITS_PER_LONG);

People aren't always terribly consistent with INT_MAX vs UINT_MAX.
Also, bitmap_weight() should arguably return an unisnged int (it can't
legitimately return a negative value).

> >> With this patch memweight() controls the
> >> computation directly with size_t type everywhere. Thus, the BUG_ON
> >> becomes unnecessary.
> > 
> > Why are you bothering?  How are you allocating half a gigabyte of memory?
> > Why are you calling memweight() on half a gigabyte of memory?
> > 
> 
> No, we don't use such big arrays. However, it's possible to remove BUG_ON and make
> the code more "straight". Why do we need to "artificially" limit this function
> to arrays of a particular size if we can relatively simple omit this restriction?

You're not making a great case for changing the implementation of
memweight() here ...

> I don't know how the implementation of this optimization will look like in it's
> final shape, because of different hardware/compiler issues. It looks there are
> a number of different ways to do it https://arxiv.org/pdf/1611.07612.pdf, 
> http://0x80.pl/articles/sse-popcount.html.

The problem with using XMM registers is that they have to be saved/restored.
Not to mention the thermal issues caused by heavy usage of AVX instructions.

> However, if it will be based on popcnt instruction I would expect that
> hweight_long will also contain this intrinsics. Since version 4.9.2
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=62011#c13 GCC knows of the
> false-dependency in popcnt and generates code to handle it

Ah!  Glad to see GCC knows about this problem and has worked around it.

> (e.g. xor https://godbolt.org/z/Q7AW_d) Thus, I would expect that it's
> possible to use popcnt intrinsics in hweight_long that would be natively
> optimized in all loops like "for (...) { res += hweight_long() }" without
> requiring manual unrolling like in builtin_popcnt_unrolled_errata_manual
> example of Dan Luu's optimization.

That might be expecting rather more from our compiler than is reasonable ...

> > 
> > Also, why does the trailer do this:
> > 
> >         for (; bytes > 0; bytes--, bitmap++)
> >                 ret += hweight8(*bitmap);
> > 
> > instead of calling hweight_long on *bitmap & mask?
> > 
> 
> Do you mean something like this?
> 
>         longs = bytes;
>         bytes = do_div(longs, sizeof(long));
>         bitmap_long = (const unsigned long *)bitmap;
>         if (longs) {
>                 for (; longs > 0; longs--, bitmap_long++)
>                         ret += hweight_long(*bitmap_long);
>         }
>         if (bytes) {
>                 ret += hweight_long(*bitmap_long &
>                                    ((0x1 << bytes * BITS_PER_BYTE) - 1));
>         }
> 
> The *bitmap_long will lead to buffer overflow here.

No it won't.  The CPU will access more bytes than the `bytes' argument
would seem to imply -- but it's going to have fetched that entire
cacheline anyway.  It might confuse a very strict bounds checking library,
but usually those just check you're not accessing outside your object,
which is going to be a multiple of 'sizeof(long)' anyway.

If we do something like this, we'll need to use an 'inverse' of that mask
on big-endian machines.  ie something more like:

	if (bytes) {
		unsigned long mask;
		if (_BIG_ENDIAN)
			mask = ~0UL >> (bytes * 8);
		else
			mask = ~0UL << (bytes * 8);
		ret += hweight_long(*bitmap_long & ~mask);
	}

Also we need a memweight() test to be sure we didn't get that wrong.
