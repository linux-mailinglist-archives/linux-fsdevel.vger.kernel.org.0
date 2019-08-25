Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B39C314
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2019 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfHYLjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 07:39:51 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58050 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfHYLjv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 07:39:51 -0400
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru [188.32.48.208])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6026D54006B;
        Sun, 25 Aug 2019 14:39:47 +0300 (MSK)
Subject: Re: [PATCH v2] lib/memweight.c: open codes bitmap_weight()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <matthew@wil.cx>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        Erdem Tumurov <erdemus@gmail.com>,
        Vladimir Shelekhov <vshel@iis.nsk.su>
References: <20190821074200.2203-1-efremov@ispras.ru>
 <20190824100102.1167-1-efremov@ispras.ru>
 <20190825061158.GC28002@bombadil.infradead.org>
From:   Denis Efremov <efremov@ispras.ru>
Message-ID: <ba051566-0343-ea75-0484-8852f65a15da@ispras.ru>
Date:   Sun, 25 Aug 2019 14:39:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825061158.GC28002@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 25.08.2019 09:11, Matthew Wilcox wrote:
> On Sat, Aug 24, 2019 at 01:01:02PM +0300, Denis Efremov wrote:
>> This patch open codes the bitmap_weight() call. The direct
>> invocation of hweight_long() allows to remove the BUG_ON and
>> excessive "longs to bits, bits to longs" conversion.
> 
> Honestly, that's not the problem with this function.  Take a look
> at https://danluu.com/assembly-intrinsics/ for a _benchmarked_
> set of problems with popcnt.
> 
>> BUG_ON was required to check that bitmap_weight() will return
>> a correct value, i.e. the computed weight will fit the int type
>> of the return value.
> 
> What?  No.  Look at the _arguments_ of bitmap_weight():
> 
> static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)

I'm not sure why it is INT_MAX then? I would expect in case we care only about arguments
something like:
 
BUG_ON(longs >= UINT_MAX / BITS_PER_LONG);

> 
>> With this patch memweight() controls the
>> computation directly with size_t type everywhere. Thus, the BUG_ON
>> becomes unnecessary.
> 
> Why are you bothering?  How are you allocating half a gigabyte of memory?
> Why are you calling memweight() on half a gigabyte of memory?
> 

No, we don't use such big arrays. However, it's possible to remove BUG_ON and make
the code more "straight". Why do we need to "artificially" limit this function
to arrays of a particular size if we can relatively simple omit this restriction?

> 
> If you really must change anything, I'd rather see this turned into a
> loop:
> 
> 	while (longs) {
> 		unsigned int nbits;
> 
> 		if (longs >= INT_MAX / BITS_PER_LONG)
> 			nbits = INT_MAX + 1;
> 		else
> 			nbits = longs * BITS_PER_LONG;
> 
> 		ret += bitmap_weight((unsigned long *)bitmap, sz);
> 		bytes -= nbits / 8;
> 		bitmap += nbits / 8;
> 		longs -= nbits / BITS_PER_LONG;
> 	}
> 
> then we only have to use Dan Luu's optimisation in bitmap_weight()
> and not in memweight() as well.

I don't know how the implementation of this optimization will look like in it's
final shape, because of different hardware/compiler issues. It looks there are
a number of different ways to do it https://arxiv.org/pdf/1611.07612.pdf, 
http://0x80.pl/articles/sse-popcount.html.

However, if it will be based on popcnt instruction I would expect that
hweight_long will also contain this intrinsics. Since version 4.9.2
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=62011#c13 GCC knows of the
false-dependency in popcnt and generates code to handle it
(e.g. xor https://godbolt.org/z/Q7AW_d) Thus, I would expect that it's
possible to use popcnt intrinsics in hweight_long that would be natively
optimized in all loops like "for (...) { res += hweight_long() }" without
requiring manual unrolling like in builtin_popcnt_unrolled_errata_manual
example of Dan Luu's optimization.

> 
> Also, why does the trailer do this:
> 
>         for (; bytes > 0; bytes--, bitmap++)
>                 ret += hweight8(*bitmap);
> 
> instead of calling hweight_long on *bitmap & mask?
> 

Do you mean something like this?

        longs = bytes;
        bytes = do_div(longs, sizeof(long));
        bitmap_long = (const unsigned long *)bitmap;
        if (longs) {
                for (; longs > 0; longs--, bitmap_long++)
                        ret += hweight_long(*bitmap_long);
        }
        if (bytes) {
                ret += hweight_long(*bitmap_long &
                                   ((0x1 << bytes * BITS_PER_BYTE) - 1));
        }

The *bitmap_long will lead to buffer overflow here.

Thanks,
Denis
