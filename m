Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38F3CEBA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJGSWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 14:22:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43790 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGSWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:22:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHXeQ-0003FE-G8; Mon, 07 Oct 2019 18:22:30 +0000
Date:   Mon, 7 Oct 2019 19:22:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191007182230.GN26530@ZenIV.linux.org.uk>
References: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <20191007173432.GM26530@ZenIV.linux.org.uk>
 <CAHk-=wgSzPwzX0cHgTZ9SQrd8XWQcMnLkBCo_-710pLTEBFGYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSzPwzX0cHgTZ9SQrd8XWQcMnLkBCo_-710pLTEBFGYQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:13:27AM -0700, Linus Torvalds wrote:
> On Mon, Oct 7, 2019 at 10:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Tangentially related: copy_regster_to_user() and copy_regset_from_user().
> 
> Not a worry. It's not performance-critical code, and if it ever is, it
> needs to be rewritten anyway.
> 
> > The former variant tends to lead to few calls
> > of __copy_{to,from}_user(); the latter...  On x86 it ends up doing
> > this:
> 
> Just replace the __put_user() with a put_user() and be done with it.
> That code isn't acceptable, and if somebody ever complains about
> performance it's not the lack of __put_user that is the problem.

I wonder if it would be better off switching to several "copy in bulk"
like e.g. ppc does.  That boilerplate with parallel "to/from kernel"
and "to/from userland" loops is asking for bugs - the calling
conventions like "pass kbuf and ubuf; exactly one must be NULL"
tend to be trouble, IME; I'm not saying we should just pass
struct iov_iter * instead of count+pos+kbuf+ubuf to ->get() and
->set(), but it might clean the things up nicely.

Let me look into that zoo a bit more...
