Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7FD31BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfJJTzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 15:55:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40740 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJTzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:55:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIeWe-00034C-H8; Thu, 10 Oct 2019 19:55:05 +0000
Date:   Thu, 10 Oct 2019 20:55:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191010195504.GI26530@ZenIV.linux.org.uk>
References: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:24:17PM -0700, Linus Torvalds wrote:
> On Mon, Oct 7, 2019 at 9:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Try the attached patch, and then count the number of "rorx"
> > instructions in the kernel. Hint: not many. On my personal config,
> > this triggers 15 times in the whole kernel build (not counting
> > modules).
> 
> .. and four of them are in perf_callchain_user(), and are due to those
> "__copy_from_user_nmi()" with either 4-byte or 8-byte copies.
> 
> It might as well just use __get_user() instead.
> 
> The point being that the silly code in the header files is just
> pointless. We shouldn't do it.

FWIW, the one that looks the most potentiall sensitive in that bunch is
arch/x86/kvm/paging_tmpl.h:388:         if (unlikely(__copy_from_user(&pte, ptep_user, sizeof(pte))))
in the bowels of KVM page fault handling.  I would be very surprised if
the rest would be detectable...

Anyway, another question you way: what do you think of try/catch approaches
to __get_user() blocks, like e.g. restore_sigcontext() is doing?

Should that be available outside of arch/*?  For that matter, would
it be a good idea to convert get_user_ex() users in arch/x86 to
unsafe_get_user()?
