Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5FCF212
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 06:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfJHE5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 00:57:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51122 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbfJHE5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:57:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHhYe-0002VL-Cy; Tue, 08 Oct 2019 04:57:12 +0000
Date:   Tue, 8 Oct 2019 05:57:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008045712.GR26530@ZenIV.linux.org.uk>
References: <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:09:14PM -0700, Linus Torvalds wrote:

> > 1) cross-architecture user_access_begin_dont_use(): on everything
> > except x86 it's empty, on x86 - __uaccess_begin_nospec().
> 
> No, just do a proper range check, and use user_access_begin()
> 
> Stop trying to optimize that range check away. It's a couple of fast
> instructions.
> 
> The only ones who don't want the range check are the actual kernel
> copy ones, but they don't want the user_access_begin() either.

Not at the first step.  Sure, in the end we want exactly that, and
we want it ASAP.  However, the main reason it grows into a tangled
mess that would be over the top for this cycle is the impacts in
arseload of places all over arch/*.

That way we can untangle those.  The initial segment that would
allow to use raw_copy_to_user() cleanly in readdir.c et.al.
could be done with provably zero impact on anything in arch/*
outside of arch/x86 usercopy-related code.

Moreover, it will be fairly small.  And after that the rest can
be done in any order, independent from each other.  I want to
kill __copy_... completely, and I believe we'll be able to do
just that in a cycle or two.

Once that is done, the helper disappears along with __copy_...().
And it will be documented as a temporary kludge, don't use
anywhere else, no matter what from the very beginning.  For
all the couple of cycles it'll take.

I'm serious about getting rid of __copy_...() in that timeframe.
There's not that much left.

The reason I don't want to do a blanket search-and-replace turning
them all into copy_...() is simply that their use is a good indicator
of code in need of serious beating^Wamount of careful review.

And hell, we might end up doing just that on case-by-case basis.
Often enough we will, by what I'd seen there...

Again, this kluge is only a splitup aid - by the end of the series
it's gone.  All it allows is to keep it easier to review.

Note, BTW, that bits and pieces converting a given pointless use
of __copy_...() to copy_...() can be reordered freely at any point
of the sequence - I've already got several.  _Some_ of (5) will
be conversions a-la readdir.c one and that has to follow (4), but
most of it won't be like that.

> > void *copy_mount_options(const void __user * data)
> > {
> >         unsigned offs, size;
> >         char *copy;
> >
> >         if (!data)
> >                 return NULL;
> >
> >         copy = kmalloc(PAGE_SIZE, GFP_KERNEL);
> >         if (!copy)
> >                 return ERR_PTR(-ENOMEM);
> >
> >         offs = (unsigned long)untagged_addr(data) & (PAGE_SIZE - 1);
> >
> >         if (copy_from_user(copy, data, PAGE_SIZE - offs)) {
> >                 kfree(copy);
> >                 return ERR_PTR(-EFAULT);
> >         }
> >         if (offs) {
> >                 if (copy_from_user(copy, data + PAGE_SIZE - offs, offs))
> >                         memset(copy + PAGE_SIZE - offs, 0, offs);
> >         }
> >         return copy;
> > }
> >
> > on the theory that any fault halfway through a page means a race with
> > munmap/mprotect/etc. and we can just pretend we'd lost the race entirely.
> > And to hell with exact_copy_from_user(), byte-by-byte copying, etc.
> 
> Looks reasonable.

	OK...  BTW, do you agree that the use of access_ok() in
drivers/tty/n_hdlc.c:n_hdlc_tty_read() is wrong?  It's used as an early
cutoff, so we don't bother waiting if user has passed an obviously bogus
address.  copy_to_user() is used for actual copying there...

	There are other places following that pattern and IMO they are all
wrong.  Another variety is a half-arsed filter trying to prevent warnings
from too large (and user-controllable) kmalloc() of buffer we'll be
copying to.  Which is worth very little, since kmalloc() will scream and
fail well before access_ok() limits will trip.  Those need explicit capping
of the size, IMO...
