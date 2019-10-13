Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B073D5737
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfJMSNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 14:13:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34088 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfJMSNi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:13:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iJiN3-0006Hg-Cd; Sun, 13 Oct 2019 18:13:33 +0000
Date:   Sun, 13 Oct 2019 19:13:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191013181333.GK26530@ZenIV.linux.org.uk>
References: <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk>
 <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 05:31:13PM -0700, Linus Torvalds wrote:

> So the code actually needs to properly return the error early, or
> initialize the segments that didn't get loaded to 0, or something.
> 
> And when I posted that, Luto said "just get rid of the get_user_ex()
> entirely, instead of changing semantics of the existing ones to be
> sane.
> 
> Which is probably right. There aren't that many.
> 
> I *thought* there were also cases of us doing some questionably things
> inside the get_user_try sections, but those seem to have gotten fixed
> already independently, so it's really just the "make try/catch really
> try/catch" change that needs some editing of our current broken stuff
> that depends on it not actually *catching* exceptions, but on just
> continuing on to the next one.

Umm...  TBH, I wonder if we would be better off if restore_sigcontext()
(i.e. sigreturn()/rt_sigreturn()) would flat-out copy_from_user() the
entire[*] struct sigcontext into a local variable and then copied fields
to pt_regs...  The thing is small enough for not blowing the stack (256
bytes max. and it's on a shallow stack) and big enough to make "fancy
memcpy + let the compiler think how to combine in-kernel copies"
potentially better than hardwired sequence of 64bit loads/stores...

[*] OK, sans ->reserved part in the very end on 64bit.  192 bytes to
copy.

Same for do_sys_vm86(), perhaps - we want regs/flags/cpu_type and
screen_bitmap there, i.e. the beginning of struct vm86plus_struct
and of struct vm86_struct...  24*32bit.  IOW, 96-byte memcpy +
gcc-visible field-by-field copying vs. hardwired sequence of
32bit loads (with some 16bit ones thrown in, for extra fun) and
compiler told not to reorder anything.

And these (32bit and 64bit restore_sigcontext() and do_sys_vm86())
are the only get_user_ex() users anywhere...
