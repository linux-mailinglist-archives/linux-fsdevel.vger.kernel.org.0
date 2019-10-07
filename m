Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CEFCDA7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 04:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfJGCut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 22:50:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60916 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfJGCut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 22:50:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHJ6k-0006NC-GN; Mon, 07 Oct 2019 02:50:46 +0000
Date:   Mon, 7 Oct 2019 03:50:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191007025046.GL26530@ZenIV.linux.org.uk>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 06, 2019 at 07:06:19PM -0700, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 6:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Ugh...  I wonder if it would be better to lift STAC/CLAC out of
> > raw_copy_to_user(), rather than trying to reinvent its guts
> > in readdir.c...
> 
> Yeah, I suspect that's the best option.
> 
> Do something like
> 
>  - lift STAC/CLAC out of raw_copy_to_user
> 
>  - rename it to unsafe_copy_to_user
> 
>  - create a new raw_copy_to_user that is just unsafe_copy_to_user()
> with the STAC/CLAC around it.
> 
> and the end result would actually be cleanert than what we have now
> (which duplicates that STAC/CLAC for each size case etc).
> 
> And then for the "architecture doesn't have user_access_begin/end()"
> fallback case, we just do
> 
>    #define unsafe_copy_to_user raw_copy_to_user

Callers of raw_copy_to_user():
arch/hexagon/mm/uaccess.c:27:           uncleared = raw_copy_to_user(dest, &empty_zero_page, PAGE_SIZE);
arch/hexagon/mm/uaccess.c:34:           count = raw_copy_to_user(dest, &empty_zero_page, count);
arch/powerpc/kvm/book3s_64_mmu_radix.c:68:              ret = raw_copy_to_user(to, from, n);
arch/s390/include/asm/uaccess.h:150:    size = raw_copy_to_user(ptr, x, size);
include/asm-generic/uaccess.h:145:      return unlikely(raw_copy_to_user(ptr, x, size)) ? -EFAULT : 0;
include/linux/uaccess.h:93:     return raw_copy_to_user(to, from, n);
include/linux/uaccess.h:102:    return raw_copy_to_user(to, from, n);
include/linux/uaccess.h:131:            n = raw_copy_to_user(to, from, n);
lib/iov_iter.c:142:             n = raw_copy_to_user(to, from, n);
lib/usercopy.c:28:              n = raw_copy_to_user(to, from, n);


Out of those, only __copy_to_user_inatomic(), __copy_to_user(),
_copy_to_user() and iov_iter.c:copyout() can be called on
any architecture.

The last two should just do user_access_begin()/user_access_end()
instead of access_ok().  __copy_to_user_inatomic() has very few callers as well:

arch/mips/kernel/unaligned.c:1307:                      res = __copy_to_user_inatomic(addr, fpr, sizeof(*fpr));
drivers/gpu/drm/i915/i915_gem.c:345:    unwritten = __copy_to_user_inatomic(user_data,
lib/test_kasan.c:471:   unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
mm/maccess.c:98:        ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);

So few, in fact, that I wonder if we want to keep it at all; the only
thing stopping me from "let's remove it" is that I don't understand
the i915 side of things.  Where does it do an equivalent of access_ok()?

And mm/maccess.c one is __probe_kernel_write(), so presumably we don't
want stac/clac there at all...

So do we want to bother with separation between raw_copy_to_user() and
unsafe_copy_to_user()?  After all, __copy_to_user() also has only few
callers, most of them in arch/*

I'll take a look into that tomorrow - half-asleep right now...
