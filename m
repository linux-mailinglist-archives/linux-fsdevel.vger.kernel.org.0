Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0BCDA1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfJGBYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 21:24:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60000 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfJGBYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 21:24:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHHlN-0004Sd-Dd; Mon, 07 Oct 2019 01:24:37 +0000
Date:   Mon, 7 Oct 2019 02:24:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191007012437.GK26530@ZenIV.linux.org.uk>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 06, 2019 at 06:17:02PM -0700, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 5:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > All my alpha, sparc64, and xtensa tests pass with the attached patch
> > applied on top of v5.4-rc2. I didn't test any others.
> 
> Okay... I really wish my guess had been wrong.
> 
> Because fixing filldir64 isn't the problem. I can come up with
> multiple ways to avoid the unaligned issues if that was the problem.
> 
> But it does look to me like the fundamental problem is that unaligned
> __put_user() calls might just be broken on alpha (and likely sparc
> too). Because that looks to be the only difference between the
> __copy_to_user() approach and using unsafe_put_user() in a loop.
> 
> Now, I should have handled unaligned things differently in the first
> place, and in that sense I think commit 9f79b78ef744 ("Convert
> filldir[64]() from __put_user() to unsafe_put_user()") really is
> non-optimal on architectures with alignment issues.
> 
> And I'll fix it.

Ugh...  I wonder if it would be better to lift STAC/CLAC out of
raw_copy_to_user(), rather than trying to reinvent its guts
in readdir.c...
