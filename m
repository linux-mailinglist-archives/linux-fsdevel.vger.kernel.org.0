Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04D0CF13D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 05:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfJHD3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 23:29:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50270 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbfJHD3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:29:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHgBU-0008EB-JK; Tue, 08 Oct 2019 03:29:13 +0000
Date:   Tue, 8 Oct 2019 04:29:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008032912.GQ26530@ZenIV.linux.org.uk>
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

> But on x86, if we move the STAC/CLAC out of the low-level copy
> routines and into the callers, we'll have a _lot_ of churn. I thought
> it would be mostly a "teach objtool" thing, but we have lots of
> different versions of it. Not just the 32-bit vs 64-bit, it's embedded
> in all the low-level asm implementations.
> 
> And we don't want the regular "copy_to/from_user()" to then have to
> add the STAC/CLAC at the call-site. So then we'd want to un-inline
> copy_to_user() entirely.

For x86?  Sure, why not...  Note, BTW, that for short constant-sized
copies we *do* STAC/CLAC at the call site - see those
		__uaccess_begin_nospec();
in raw_copy_{from,to}_user() in the switches...

> Which all sounds like a really good idea, don't get me wrong. I think
> we inline it way too aggressively now. But it'sa  _big_ job.
> 
> So we probably _should_
> 
>  - remove INLINE_COPY_TO/FROM_USER
> 
>  - remove all the "small constant size special cases".
> 
>  - make "raw_copy_to/from_user()" have the "unsafe" semantics and make
> the out-of-line copy in lib/usercopy.c be the only real interface
> 
>  - get rid of a _lot_ of oddities

Not that many, really.  All we need is a temporary cross-architecture
__uaccess_begin_nospec(), so that __copy_{to,from}_user() could have
that used, instead of having it done in (x86) raw_copy_..._...().

Other callers of raw_copy_...() would simply wrap it into user_access_begin()/
user_access_end() pairs; this kludge is needed only in __copy_from_user()
and __copy_to_user(), and only until we kill their callers outside of
arch/*.  Which we can do, in a cycle or two.  _ANY_ use of
that temporary kludge outside of those two functions will be grepped
for and LARTed into the ground.

> I hope you prove me wrong. But I'll look at a smaller change to just
> make x86 use the current special copy loop (as
> "unsafe_copy_to_user()") and have everybody else do the trivial
> wrapper.
> 
> Because we definitely should do that cleanup (it also fixes the whole
> "atomic copy in kernel space" issue that you pointed to that doesn't
> actually want STAC/CLAC at all), but it just looks fairly massive to
> me.

AFAICS, it splits nicely.

1) cross-architecture user_access_begin_dont_use(): on everything
except x86 it's empty, on x86 - __uaccess_begin_nospec().

2) stac/clac lifted into x86 raw_copy_..._user() out of
copy_user_generic_unrolled(), copy_user_generic_string() and
copy_user_enhanced_fast_string().  Similar lift out of
__copy_user_nocache().

3) lifting that thing as user_access_begin_dont_use() into
__copy_..._user...() and as user_access_begin() into other
generic callers, consuming access_ok() in the latter.
__copy_to_user_inatomic() can die at the same stage.

4) possibly uninlining on x86 (and yes, killing the special
size handling off).  We don't need to touch the inlining
decisions for any other architectures.

At that point raw_copy_to_user() is available for e.g.
readdir.c to play with.

And up to that point only x86 sees any kind of code changes,
so we don't have to worry about other architectures.

5) kill the __copy_...() users outside of arch/*, alone with
quite a few other weird shits in there.  A cycle or two,
with the final goal being to kill the damn things off.

6) arch/* users get arch-by-arch treatment - mostly
it's sigframe handling.  Won't affect the generic code
and would be independent for different architectures.
Can happen in parallel with (5), actually.

7) ... at that point user_access_begin_dont_user() gets
removed and thrown into the pile of mangled fingers of
those who'd ignored all warnings and used it somewhere
else.

I don't believe that (5) would be doable entirely in
this cycle, but quite a few bits might be.

On a somewhat related note, do you see any problems with

void *copy_mount_options(const void __user * data)
{
        unsigned offs, size;
        char *copy;

        if (!data)
                return NULL;

        copy = kmalloc(PAGE_SIZE, GFP_KERNEL);
        if (!copy)
                return ERR_PTR(-ENOMEM);

        offs = (unsigned long)untagged_addr(data) & (PAGE_SIZE - 1);

	if (copy_from_user(copy, data, PAGE_SIZE - offs)) {
                kfree(copy);
                return ERR_PTR(-EFAULT);
	}
	if (offs) {
		if (copy_from_user(copy, data + PAGE_SIZE - offs, offs))
			memset(copy + PAGE_SIZE - offs, 0, offs);
	}
        return copy;
}

on the theory that any fault halfway through a page means a race with
munmap/mprotect/etc. and we can just pretend we'd lost the race entirely.
And to hell with exact_copy_from_user(), byte-by-byte copying, etc.
