Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD5D01FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfJHUQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 16:16:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34422 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfJHUQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:16:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHvu4-0001qR-Ey; Tue, 08 Oct 2019 20:16:17 +0000
Date:   Tue, 8 Oct 2019 21:16:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008201616.GW26530@ZenIV.linux.org.uk>
References: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008195858.GV26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008195858.GV26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:58:58PM +0100, Al Viro wrote:

> That's powerpc.  And while the constant-sized bits are probably pretty
> useless there as well, note the allow_read_from_user()/prevent_read_from_user()
> part.  Looks suspiciously similar to user_access_begin()/user_access_end()...
> 
> The difference is, they have separate "for read" and "for write" primitives
> and they want the range in their user_access_end() analogue.  Separating
> the read and write isn't a problem for callers (we want them close to
> the actual memory accesses).  Passing the range to user_access_end() just
> might be tolerable, unless it makes you throw up...

	BTW, another related cleanup is futex_atomic_op_inuser() and
arch_futex_atomic_op_inuser().  In the former we have
        if (!access_ok(uaddr, sizeof(u32)))
                return -EFAULT;

        ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
        if (ret)
                return ret;
and in the latter we've got STAC/CLAC pairs stuck into inlined bits
on x86.  As well as allow_write_to_user(uaddr, sizeof(*uaddr)) on
ppc...

I don't see anything in x86 one objtool would've barfed if we pulled
STAC/CLAC out and turned access_ok() into user_access_begin(),
with matching user_access_end() right after the call of 
arch_futex_atomic_op_inuser().  Everything is inlined there and
no scary memory accesses would get into the scope (well, we do
have
        if (!ret)
                *oval = oldval;
in the very end of arch_futex_atomic_op_inuser() there, but oval
is the address of a local variable in the sole caller; if we run
with kernel stack on ring 3 page, we are deeply fucked *and*
wouldn't have survived that far into futex_atomic_op_inuser() anyway ;-)
