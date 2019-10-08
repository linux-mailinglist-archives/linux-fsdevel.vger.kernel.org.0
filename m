Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A152CF216
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 07:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfJHFCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 01:02:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51206 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfJHFCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 01:02:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHhdu-0002fc-EL; Tue, 08 Oct 2019 05:02:38 +0000
Date:   Tue, 8 Oct 2019 06:02:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008050238.GS26530@ZenIV.linux.org.uk>
References: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wjE_9x02o=6Kgu9XWD7RTaRMKOXXYc0CPwAx87i-FZ70w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjE_9x02o=6Kgu9XWD7RTaRMKOXXYc0CPwAx87i-FZ70w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:14:51PM -0700, Linus Torvalds wrote:
> On Mon, Oct 7, 2019 at 9:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Try the attached patch, and then count the number of "rorx"
> > instructions in the kernel. Hint: not many. On my personal config,
> > this triggers 15 times in the whole kernel build (not counting
> > modules).
> 
> So here's a serious patch that doesn't just mark things for counting -
> it just removes the cases entirely.
> 
> Doesn't this look nice:
> 
>   2 files changed, 2 insertions(+), 133 deletions(-)
> 
> and it is one less thing to worry about when doing further cleanup.
> 
> Seriously, if any of those __copy_{to,from}_user() constant cases were
> a big deal, we can turn them into get_user/put_user calls. But only
> after they show up as an actual performance issue.

Makes sense.  I'm not arguing against doing that.  Moreover, I suspect
that other architectures will be similar, at least once the
sigframe-related code for given architecture is dealt with.  But that's
more of a "let's look at that later" thing (hopefully with maintainers
of architectures getting involved).
