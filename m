Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A8DBACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 02:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfJRA1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 20:27:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48372 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfJRA1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:27:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLG7R-0004bl-Gg; Fri, 18 Oct 2019 00:27:49 +0000
Date:   Fri, 18 Oct 2019 01:27:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anton Blanchard <anton@ozlabs.org>
Subject: [RFC] csum_and_copy_from_user() semantics
Message-ID: <20191018002749.GA13188@ZenIV.linux.org.uk>
References: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk>
 <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
 <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191016202540.GQ26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016202540.GQ26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:25:40PM +0100, Al Viro wrote:

> 2) default csum_partial_copy_from_user().  What we need to do is
> turn it into default csum_and_copy_from_user().  This
> #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
> static inline
> __wsum csum_and_copy_from_user (const void __user *src, void *dst,
>                                       int len, __wsum sum, int *err_ptr)
> {
>         if (access_ok(src, len))
>                 return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
> 
>         if (len)
>                 *err_ptr = -EFAULT;
> 
>         return sum;
> }
> #endif
> in checksum.h is the only thing that calls that sucker and we can bloody
> well combine them and make the users of lib/checksum.h define
> _HAVE_ARCH_COPY_AND_CSUM_FROM_USER.  That puts us reasonably close
> to having _HAVE_ARCH_COPY_AND_CSUM_FROM_USER unconditional and in any
> case, __copy_from_user() in lib/checksum.h turns into copy_from_user().

Actually, that gets interesting.  First of all, csum_partial_copy_from_user()
has almost no callers other than csum_and_copy_from_user() - the only
exceptions are alpha and itanic, where csum_partial_copy_nocheck() instances
are using it.

Everything else goes through csum_and_copy_from_user().  And _that_ has
only two callers -  csum_and_copy_from_iter() and csum_and_copy_from_iter_full().
Both treat any failures as "discard the thing", for a good reason.  Namely,
neither csum_and_copy_from_user() nor csum_partial_copy_from_user() have any
means to tell the caller *where* has the fault happened.  So anything
that calls them has to treat a fault as "nothing copied".  That, of course,
goes both for data and csum.

Moreover, behaviour of instances on different architectures differs -
some zero the uncopied-over part of destination, some do not, some
just keep going treating every failed fetch as "got zero" (and returning
the error in the end).

We could, in theory, teach that thing to report the exact amount
copied, so that new users (when and if such appear) could make use
of that.  However, it means a lot of unpleasant work on e.g. sparc.
For raw_copy_from_user() we had to do that, but here I don't see
the point.

As it is, it's only suitable for "discard if anything fails, treat
the entire destination area as garbage in such case" uses.  Which is
all we have for it at the moment.

IOW, it might make sense to get rid of all the "memset the tail to
zero on failure" logics in there - it's not consistently done and
the callers have no way to make use of it anyway.

In any case, there's no point keeping csum_and_copy_from_user()
separate from csum_partial_copy_from_user().  As it is, the
only real difference is that the former does access_ok(), while
the latter might not (some instances do, in which case there's
no difference at all).

Questions from reviewing the instances:
	* mips csum_and_partial_copy_from_user() tries to check
if we are under KERNEL_DS, in which case it goes for kernel-to-kernel
copy.  That's pointless - the callers are reading from an
iovec-backed iov_iter, which can't be created under KERNEL_DS.
So we would have to have set iovec-backed iov_iter while under
USER_DS, then do set_fs(KERNEL_DS), then pass that iov_iter to
->sendmsg().  Which doesn't happen.  IOW, the calls of
__csum_partial_copy_kernel() never happen - neither for
csum_and_copy_from_kernel() for csum_and_copy_to_kernel().

	* ppc does something odd:
        csum = csum_partial_copy_generic((void __force *)src, dst,
                                         len, sum, err_ptr, NULL);

        if (unlikely(*err_ptr)) {
                int missing = __copy_from_user(dst, src, len);

                if (missing) {
                        memset(dst + len - missing, 0, missing);
                        *err_ptr = -EFAULT;
                } else {
                        *err_ptr = 0;
                }

                csum = csum_partial(dst, len, sum);
        }
and since that happens under their stac equivalent, we get it nested -
__copy_from_user() takes and drops it.  I would've said "don't bother
trying to be smart on failures", if I'd been certain that it's not
a fallback for e.g. csum_and_partial_copy_from_user() in misaligned
case.  Could ppc folks clarify that?
