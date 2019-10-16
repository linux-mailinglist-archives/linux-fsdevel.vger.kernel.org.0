Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9385D9BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437137AbfJPUZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 16:25:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55826 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437132AbfJPUZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:25:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iKprY-0001x2-7E; Wed, 16 Oct 2019 20:25:40 +0000
Date:   Wed, 16 Oct 2019 21:25:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191016202540.GQ26530@ZenIV.linux.org.uk>
References: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk>
 <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
 <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 13, 2019 at 12:22:38PM -0700, Linus Torvalds wrote:
> On Sun, Oct 13, 2019 at 12:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > No arguments re put_user_ex side of things...  Below is a completely
> > untested patch for get_user_ex elimination (it seems to build, but that's
> > it); in any case, I would really like to see comments from x86 folks
> > before it goes anywhere.
> 
> Please don't do this:
> 
> > +       if (unlikely(__copy_from_user(&sc, usc, sizeof(sc))))
> > +               goto Efault;
> 
> Why would you use __copy_from_user()? Just don't.
> 
> > +       if (unlikely(__copy_from_user(&v, user_vm86,
> > +                       offsetof(struct vm86_struct, int_revectored))))
> 
> Same here.
> 
> There's no excuse for __copy_from_user().

FWIW, callers of __copy_from_user() remaining in the generic code:

1) regset.h:user_regset_copyin().  Switch to copy_from_user(); the calling
conventions of regset ->set() (as well as the method name) are atrocious,
but there are too many instances to mix any work in that direction into
this series.  Yes, nominally it's an inline, but IRL it's too large and
has many callers in the same file(s), so any optimizations of inlining
__copy_from_user() will be lost and there's more than enough work done
there to make access_ok() a noise.  And in this case it doesn't pay
to try and lift user_access_begin() into the callers - the work done
between the calls is often too non-trivial to be done in such area.
The same goes for other regset.h stuff; eventually we might want to
try and come up with saner API, but that's a separate story.

2) default csum_partial_copy_from_user().  What we need to do is
turn it into default csum_and_copy_from_user().  This
#ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
static inline
__wsum csum_and_copy_from_user (const void __user *src, void *dst,
                                      int len, __wsum sum, int *err_ptr)
{
        if (access_ok(src, len))
                return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);

        if (len)
                *err_ptr = -EFAULT;

        return sum;
}
#endif
in checksum.h is the only thing that calls that sucker and we can bloody
well combine them and make the users of lib/checksum.h define
_HAVE_ARCH_COPY_AND_CSUM_FROM_USER.  That puts us reasonably close
to having _HAVE_ARCH_COPY_AND_CSUM_FROM_USER unconditional and in any
case, __copy_from_user() in lib/checksum.h turns into copy_from_user().

3) firewire ioctl_queue_iso().  Convert to copy_from_user(), lose the
access_ok() before the loop.  Definitely not an unsafe_... situation
(we call fw_iso_context_queue() after each chunk; _not_ something
we want under user_access_begin()/user_access_end()) and it's really
not worth trying to save on access_ok() checks there.

4) pstore persistent_ram_update_user().  Obvious copy_from_user(); definitely
lose access_ok() in the caller (persistent_ram_write_user()), along with
the one in write_pmsg() (several calls back by the callchain).

5) test_kasan: lose the function, lose the tests...

6) drivers/scsi/sg.c nest: sg_read() ones are memdup_user() in disguise
(i.e. fold with immediately preceding kmalloc()s).  sg_new_write() -
fold with access_ok() into copy_from_user() (for both call sites).
sg_write() - lose access_ok(), use copy_from_user() (both call sites)
and get_user() (instead of the solitary __get_user() there).

7) i915 ones are, frankly, terrifying.  Consider e.g. this one:
                relocs = kvmalloc_array(size, 1, GFP_KERNEL);
                if (!relocs) {
                        err = -ENOMEM;
                        goto err;
                }

                /* copy_from_user is limited to < 4GiB */
                copied = 0;
                do {
                        unsigned int len =
                                min_t(u64, BIT_ULL(31), size - copied);

                        if (__copy_from_user((char *)relocs + copied,
                                             (char __user *)urelocs + copied,
                                             len))
                                goto end;

                        copied += len;
                } while (copied < size);
Is that for real?  Are they *really* trying to allocate and copy >2Gb of
userland data?  That's eb_copy_relocations() and that crap is itself in
a loop.  Sizes come from user-supplied data.  WTF?  It's some weird
kmemdup lookalike and I'd rather heard from maintainers of that thing
before doing anything with it.

8) vhost_copy_from_user().  Need comments from mst - it's been a while since I crawled
through that code and I'd need his ACK anyway.  The logics with positioning of
access_ok() in there is non-trivial and I'm not sure how much of that serves
as early input validation and how much can be taken out and replaced by use of
place copy_from_user() and friends.

9) KVM.  There I'm not sure that access_ok() would be the right thing to
do.  kvm_is_error_hva() tends to serve as the range check in that and similar
places; it's not the same situation as with NMI, but...

And that's it - everything else is in arch/*.  Looking at arch/x86, we have
	* insanity in math_emu (unchecked return value, for example)
	* a bunch sigframe-related code.  Some want to use unsafe_...
(or raw_...) variant, some should probably go for copy_from_user().
FPU-related stuff is particularly interesting in that respect - there
we have several inline functions nearby that contain nothing but
stac + instruction + clac + exception handling.  And in quite a few
cases it would've been cleaner to lift stac/clac into the callers, since
they combine nicely.
	* regset_tls_set(): use copy_from_user().
	* one in kvm walk_addr_generic stuff.  If nothing else,
that one smells like __get_user() - we seem to be copying a single
PTE.  And again, it's using kvm_is_error_hva().
