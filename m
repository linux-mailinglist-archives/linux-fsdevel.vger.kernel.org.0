Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28996D8077
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfJOTkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 15:40:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39076 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfJOTkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:40:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iKSg0-0002Pi-T2; Tue, 15 Oct 2019 19:40:12 +0000
Date:   Tue, 15 Oct 2019 20:40:12 +0100
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
Message-ID: <20191015194012.GO26530@ZenIV.linux.org.uk>
References: <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
 <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk>
 <20191015180846.GA31707@ZenIV.linux.org.uk>
 <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:00:34PM -0700, Linus Torvalds wrote:
> On Tue, Oct 15, 2019 at 11:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Another question: right now we have
> >         if (!access_ok(uaddr, sizeof(u32)))
> >                 return -EFAULT;
> >
> >         ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
> >         if (ret)
> >                 return ret;
> > in kernel/futex.c.  Would there be any objections to moving access_ok()
> > inside the instances and moving pagefault_disable()/pagefault_enable() outside?
> 
> I think we should remove all the "atomic" versions, and just make the
> rule be that if you want atomic, you surround it with
> pagefault_disable()/pagefault_enable().

Umm...  I thought about that, but ended up with "it documents the intent" -
pagefault_disable() might be implicit (e.g. done by kmap_atomic()) or
several levels up the call chain.  Not sure.

> That covers not just the futex ops (where "atomic" is actually
> somewhat ambiguous - the ops themselves are atomic too, so the naming
> might stay, although arguably the "futex" part makes that pointless
> too), but also copy_to_user_inatomic() and the powerpc version of
> __get_user_inatomic().

Eh?  copy_to_user_inatomic() doesn't exist; __copy_to_user_inatomic()
does, but...

arch/mips/kernel/unaligned.c:1307:                      res = __copy_to_user_inatomic(addr, fpr, sizeof(*fpr));
drivers/gpu/drm/i915/i915_gem.c:313:    unwritten = __copy_to_user_inatomic(user_data,
lib/test_kasan.c:510:   unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
mm/maccess.c:98:        ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);

these are all callers it has left anywhere and I'm certainly going to kill it.
Now, __copy_from_user_inatomic() has a lot more callers left...  Frankly,
the messier part of API is the nocache side of things.  Consider e.g. this:
/* platform specific: cacheless copy */
static void cacheless_memcpy(void *dst, void *src, size_t n)
{
        /* 
         * Use the only available X64 cacheless copy.  Add a __user cast
         * to quiet sparse.  The src agument is already in the kernel so
         * there are no security issues.  The extra fault recovery machinery
         * is not invoked.
         */
        __copy_user_nocache(dst, (void __user *)src, n, 0);
}
or this
static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
{
#ifdef ARCH_HAS_NOCACHE_UACCESS
        /*
         * Using non-temporal mov to improve performance on non-cached
         * writes, even though we aren't actually copying from user space.
         */
        __copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
#else   
        memcpy_toio(offset, entry->buf, entry->len);
#endif

        /* Ensure that the data is fully copied out before setting the flags */
        wmb();

        ntb_tx_copy_callback(entry, NULL);
}
"user" part is bollocks in both cases; moreover, I really wonder about that
ifdef in ntb one - ARCH_HAS_NOCACHE_UACCESS is x86-only *at* *the* *moment*
and it just so happens that ..._toio() doesn't require anything special on
x86.  Have e.g. arm grow nocache stuff and the things will suddenly break,
won't they?
