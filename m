Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7DD57EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfJMT7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 15:59:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35148 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfJMT7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:59:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iJk1t-0000Qd-LD; Sun, 13 Oct 2019 19:59:49 +0000
Date:   Sun, 13 Oct 2019 20:59:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191013195949.GM26530@ZenIV.linux.org.uk>
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

Probably...  Said that, vm86 one is preceded by
        if (!access_ok(user_vm86, plus ?
                       sizeof(struct vm86_struct) :
                       sizeof(struct vm86plus_struct)))
                return -EFAULT;
so I didn't want to bother.  We'll need to eliminate most of
access_ok() anyway, and I figured that conversion to plain copy_from_user()
would go there as well.

Again, this is not a patch submission - just an illustration of what I meant
re getting rid of get_user_ex().  IOW, the whole thing is still in the
plotting stage.

Re plotting: how strongly would you object against passing the range to
user_access_end()?  Powerpc folks have a very close analogue of stac/clac,
currently buried inside their __get_user()/__put_user()/etc. - the same
places where x86 does, including futex.h and friends.

And there it's even costlier than on x86.  It would obviously be nice
to lift it at least out of unsafe_get_user()/unsafe_put_user() and
move into user_access_begin()/user_access_end(); unfortunately, in
one subarchitecture they really want it the range on the user_access_end()
side as well.  That's obviously not fatal (they can bloody well save those
into thread_info at user_access_begin()), but right now we have relatively
few user_access_end() callers, so the interface changes are still possible.

Other architectures with similar stuff are riscv (no arguments, same
as for stac/clac), arm (uaccess_save_and_enable() on the way in,
return value passed to uaccess_restore() on the way out) and s390
(similar to arm, but there it's needed only to deal with nesting,
and I'm not sure it actually can happen).

It would be nice to settle the API while there are not too many users
outside of arch/x86; changing it later will be a PITA and we definitely
have architectures that do potentially costly things around the userland
memory access; user_access_begin()/user_access_end() is in the right
place to try and see if they fit there...
