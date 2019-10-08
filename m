Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2432D0230
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 22:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfJHUey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 16:34:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34624 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJHUey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:34:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHwC4-0002Mx-0p; Tue, 08 Oct 2019 20:34:52 +0000
Date:   Tue, 8 Oct 2019 21:34:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008203451.GX26530@ZenIV.linux.org.uk>
References: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008195858.GV26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008195858.GV26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:58:58PM +0100, Al Viro wrote:

> The difference is, they have separate "for read" and "for write" primitives
> and they want the range in their user_access_end() analogue.  Separating
> the read and write isn't a problem for callers (we want them close to
> the actual memory accesses).  Passing the range to user_access_end() just
> might be tolerable, unless it makes you throw up...

NOTE: I'm *NOT* suggesting to bring back the VERIFY_READ/VERIFY_WRITE
argument to access_ok().  We'd gotten rid of it, and for a very good
reason (and decades overdue).

The main difference between access_ok() and user_access_begin() is that
the latter is right next to actual memory access, with user_access_end()
on the other side, also very close.  And most of those guys would be
concentrated in a few functions, where we bloody well know which
direction we are copying.

Even if we try and map ppc allow_..._to_user() on user_access_begin(),
access_ok() remains as it is (and I hope we'll get rid of the majority
of its caller in process).
