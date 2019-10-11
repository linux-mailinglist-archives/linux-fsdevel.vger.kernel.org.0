Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11599D354F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 02:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfJKALI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 20:11:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43330 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfJKALI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:11:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIiWO-0000GI-J7; Fri, 11 Oct 2019 00:11:04 +0000
Date:   Fri, 11 Oct 2019 01:11:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191011001104.GJ26530@ZenIV.linux.org.uk>
References: <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk>
 <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:12:49PM -0700, Linus Torvalds wrote:
> On Thu, Oct 10, 2019 at 12:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Anyway, another question you way: what do you think of try/catch approaches
> > to __get_user() blocks, like e.g. restore_sigcontext() is doing?
> 
> I'd rather have them converted to our unsafe_get/put_user() instead.
> 
> We don't generate great code for the "get" case (because of how gcc
> doesn't allow us to mix "asm goto" and outputs), but I really despise
> the x86-specific "{get,put}_user_ex()" machinery. It's not actually
> doing a real try/catch at all, and will just keep taking faults if one
> happens.
> 
> But I've not gotten around to rewriting those disgusting sequences to
> the unsafe_get/put_user() model. I did look at it, and it requires
> some changes exactly *because* the _ex() functions are broken and
> continue, but also because the current code ends up also doing other
> things inside the try/catch region that you're not supposed to do in a
> user_access_begin/end() region .

Hmm...  Which one was that?  AFAICS, we have
	do_sys_vm86: only get_user_ex()
	restore_sigcontext(): get_user_ex(), set_user_gs()
	ia32_restore_sigcontext(): get_user_ex()

So at least get_user_try/get_user_ex/get_user_catch should be killable.
The other side...
	save_v86_state(): put_user_ex()
	setup_sigcontext(): put_user_ex()
	__setup_rt_frame(): put_user_ex(), static_cpu_has()
	another one in __setup_rt_frame(): put_user_ex()
	x32_setup_rt_frame(): put_user_ex()
	ia32_setup_sigcontext(): put_user_ex()
	ia32_setup_frame(): put_user_ex()
	another one in ia32_setup_frame(): put_user_ex(), static_cpu_has()

IDGI...  Is static_cpu_has() not allowed in there?  Looks like it's all inlines
and doesn't do any potentially risky memory accesses...  What am I missing?

As for the try/catch model...  How about
	if (!user_access_begin())
		sod off
	...
	unsafe_get_user(..., l);
	...
	unsafe_get_user_nojump();
	...
	unsafe_get_user_nojump();
	...
	if (user_access_did_fail())
		goto l;

	user_access_end()
	...
	return 0;
l:
	...
	user_access_end()
	return -EFAULT;

making it clear that we are delaying the check for failures until it's
more convenient.  And *not* trying to trick C parser into enforcing
anything - let objtool do it and to hell with do { and } while (0) in
magic macros.  Could be mixed with the normal unsafe_..._user() without
any problems, AFAICS...
