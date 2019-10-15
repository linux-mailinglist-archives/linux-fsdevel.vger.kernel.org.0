Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219A1D7E77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbfJOSIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:08:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37876 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:08:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iKRFW-0000B2-Nm; Tue, 15 Oct 2019 18:08:46 +0000
Date:   Tue, 15 Oct 2019 19:08:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191015180846.GA31707@ZenIV.linux.org.uk>
References: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk>
 <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
 <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013195949.GM26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[futex folks and linux-arch Cc'd]

On Sun, Oct 13, 2019 at 08:59:49PM +0100, Al Viro wrote:

> Re plotting: how strongly would you object against passing the range to
> user_access_end()?  Powerpc folks have a very close analogue of stac/clac,
> currently buried inside their __get_user()/__put_user()/etc. - the same
> places where x86 does, including futex.h and friends.
> 
> And there it's even costlier than on x86.  It would obviously be nice
> to lift it at least out of unsafe_get_user()/unsafe_put_user() and
> move into user_access_begin()/user_access_end(); unfortunately, in
> one subarchitecture they really want it the range on the user_access_end()
> side as well.  That's obviously not fatal (they can bloody well save those
> into thread_info at user_access_begin()), but right now we have relatively
> few user_access_end() callers, so the interface changes are still possible.
> 
> Other architectures with similar stuff are riscv (no arguments, same
> as for stac/clac), arm (uaccess_save_and_enable() on the way in,
> return value passed to uaccess_restore() on the way out) and s390
> (similar to arm, but there it's needed only to deal with nesting,
> and I'm not sure it actually can happen).
> 
> It would be nice to settle the API while there are not too many users
> outside of arch/x86; changing it later will be a PITA and we definitely
> have architectures that do potentially costly things around the userland
> memory access; user_access_begin()/user_access_end() is in the right
> place to try and see if they fit there...

Another question: right now we have
        if (!access_ok(uaddr, sizeof(u32)))
                return -EFAULT;

        ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
        if (ret)
                return ret;
in kernel/futex.c.  Would there be any objections to moving access_ok()
inside the instances and moving pagefault_disable()/pagefault_enable() outside?

Reasons:
	* on x86 that would allow folding access_ok() with STAC into
user_access_begin().  The same would be doable on other usual suspects
(arm, arm64, ppc, riscv, s390), bringing access_ok() next to their
STAC counterparts.
	* pagefault_disable()/pagefault_enable() pair is universal on
all architectures, really meant to by the nature of the beast and
lifting it into kernel/futex.c would get the same situation as with
futex_atomic_cmpxchg_inatomic().  Which also does access_ok() inside
the primitive (also foldable into user_access_begin(), at that).
	* access_ok() would be closer to actual memory access (and
out of the generic code).

Comments?
