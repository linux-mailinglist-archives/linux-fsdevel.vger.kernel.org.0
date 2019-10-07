Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33740CEABA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfJGRee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 13:34:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43124 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfJGRee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:34:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHWu0-00027U-DO; Mon, 07 Oct 2019 17:34:32 +0000
Date:   Mon, 7 Oct 2019 18:34:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191007173432.GM26530@ZenIV.linux.org.uk>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 06, 2019 at 08:11:42PM -0700, Linus Torvalds wrote:

> > So do we want to bother with separation between raw_copy_to_user() and
> > unsafe_copy_to_user()?  After all, __copy_to_user() also has only few
> > callers, most of them in arch/*
> 
> No, you're right. Just switch over.
> 
> > I'll take a look into that tomorrow - half-asleep right now...
> 
> Thanks. No huge hurry.

Tangentially related: copy_regster_to_user() and copy_regset_from_user().
That's where we do access_ok(), followed by calls of ->get() and
->set() resp.  Those tend to either use user_regset_copy{out,in}(),
or open-code those.  The former variant tends to lead to few calls
of __copy_{to,from}_user(); the latter...  On x86 it ends up doing
this:
static int genregs_get(struct task_struct *target,
                       const struct user_regset *regset,
                       unsigned int pos, unsigned int count,
                       void *kbuf, void __user *ubuf)
{
        if (kbuf) {
                unsigned long *k = kbuf;
                while (count >= sizeof(*k)) {
                        *k++ = getreg(target, pos);
                        count -= sizeof(*k);
                        pos += sizeof(*k);
                }
        } else {
                unsigned long __user *u = ubuf;
                while (count >= sizeof(*u)) {
                        if (__put_user(getreg(target, pos), u++))
                                return -EFAULT;
                        count -= sizeof(*u);
                        pos += sizeof(*u);
                }
        }

        return 0;
}

Potentially doing arseloads of stac/clac as it goes.  OTOH, getreg()
(and setreg()) in there are not entirely trivial, so blanket
user_access_begin()/user_access_end() over the entire loop might be
a bad idea...

How hot is that codepath?  I know that arch/um used to rely on it
(== PTRACE_[GS]ETREGS) quite a bit...
