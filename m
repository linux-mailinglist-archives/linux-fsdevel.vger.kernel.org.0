Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9541D01D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfJHT7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 15:59:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34206 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfJHT7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:59:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHvdK-0001OS-Ea; Tue, 08 Oct 2019 19:58:58 +0000
Date:   Tue, 8 Oct 2019 20:58:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008195858.GV26530@ZenIV.linux.org.uk>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:26:35AM -0700, Linus Torvalds wrote:

> The good news is that right now x86 is the only architecture that does
> that user_access_begin(), so we don't need to worry about anything
> else. Apparently the ARM people haven't had enough performance
> problems with the PAN bit for them to care.

Take a look at this:
static inline unsigned long raw_copy_from_user(void *to,
                const void __user *from, unsigned long n)
{
        unsigned long ret;
        if (__builtin_constant_p(n) && (n <= 8)) {
                ret = 1;

                switch (n) {
                case 1:
                        barrier_nospec();
                        __get_user_size(*(u8 *)to, from, 1, ret);
                        break;
                case 2:
                        barrier_nospec();
                        __get_user_size(*(u16 *)to, from, 2, ret);
                        break;
                case 4:
                        barrier_nospec();
                        __get_user_size(*(u32 *)to, from, 4, ret);
                        break;
                case 8:
                        barrier_nospec();
                        __get_user_size(*(u64 *)to, from, 8, ret);
                        break;
                }
                if (ret == 0)
                        return 0;
        }

        barrier_nospec();
        allow_read_from_user(from, n);
        ret = __copy_tofrom_user((__force void __user *)to, from, n);
        prevent_read_from_user(from, n);
        return ret;
}

That's powerpc.  And while the constant-sized bits are probably pretty
useless there as well, note the allow_read_from_user()/prevent_read_from_user()
part.  Looks suspiciously similar to user_access_begin()/user_access_end()...

The difference is, they have separate "for read" and "for write" primitives
and they want the range in their user_access_end() analogue.  Separating
the read and write isn't a problem for callers (we want them close to
the actual memory accesses).  Passing the range to user_access_end() just
might be tolerable, unless it makes you throw up...
