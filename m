Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3162D80DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 22:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfJOUSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 16:18:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39488 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfJOUSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:18:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iKTHJ-0003KI-98; Tue, 15 Oct 2019 20:18:45 +0000
Date:   Tue, 15 Oct 2019 21:18:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191015201845.GP26530@ZenIV.linux.org.uk>
References: <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
 <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk>
 <20191015180846.GA31707@ZenIV.linux.org.uk>
 <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
 <20191015194012.GO26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191015194012.GO26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 08:40:12PM +0100, Al Viro wrote:
> or this
> static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> {
> #ifdef ARCH_HAS_NOCACHE_UACCESS
>         /*
>          * Using non-temporal mov to improve performance on non-cached
>          * writes, even though we aren't actually copying from user space.
>          */
>         __copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
> #else   
>         memcpy_toio(offset, entry->buf, entry->len);
> #endif
> 
>         /* Ensure that the data is fully copied out before setting the flags */
>         wmb();
> 
>         ntb_tx_copy_callback(entry, NULL);
> }
> "user" part is bollocks in both cases; moreover, I really wonder about that
> ifdef in ntb one - ARCH_HAS_NOCACHE_UACCESS is x86-only *at* *the* *moment*
> and it just so happens that ..._toio() doesn't require anything special on
> x86.  Have e.g. arm grow nocache stuff and the things will suddenly break,
> won't they?

Incidentally, there are two callers of __copy_from_user_inatomic_nocache() in
generic code:
lib/iov_iter.c:792:             __copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,
lib/iov_iter.c:849:             if (__copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,

Neither is done under under pagefault_disable(), AFAICS.  This one
drivers/gpu/drm/qxl/qxl_ioctl.c:189:    unwritten = __copy_from_user_inatomic_nocache
probably is - it has something called qxl_bo_kmap_atomic_page() called just prior,
which would seem to imply kmap_atomic() somewhere in it.
The same goes for
drivers/gpu/drm/i915/i915_gem.c:500:    unwritten = __copy_from_user_inatomic_nocache((void __force *)vaddr + offset,

So we have 5 callers anywhere.  Two are not "inatomic" in any sense; source is
in userspace and we want nocache behaviour.  Two _are_ done into a page that
had been fed through kmap_atomic(); the source is, again, in userland.  And
the last one is complete BS - it wants memcpy_toio_nocache() and abuses this
thing.

Incidentally, in case of fault i915 caller ends up unmapping the page,
mapping it non-atomic (with kmap?) and doing plain copy_from_user(),
nocache be damned.  qxl, OTOH, whines and fails all the way to userland...
