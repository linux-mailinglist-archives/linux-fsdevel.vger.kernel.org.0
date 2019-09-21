Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0748B9F26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfIURTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Sep 2019 13:19:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57240 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfIURTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:19:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBj2A-0008W4-GE; Sat, 21 Sep 2019 17:18:58 +0000
Date:   Sat, 21 Sep 2019 18:18:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190921171858.GA29065@ZenIV.linux.org.uk>
References: <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <CAHk-=wgrfvGOdgCQARA5Jwt7TbdM7MG8AUMyz_+GCdBZ7_x21w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrfvGOdgCQARA5Jwt7TbdM7MG8AUMyz_+GCdBZ7_x21w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 21, 2019 at 09:21:46AM -0700, Linus Torvalds wrote:
> On Sat, Sep 21, 2019 at 7:07 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > FWIW, #next.dcache has the straight conversion to hlist.  It definitely
> > wants at least nfsd, er... misconception dealt with, though: list_head
> > or hlist, this
> 
> Well, yeah. But is there really any downside except for the warning?
> 
> Looks like the code should just do
> 
>                 if (!simple_positive(dentry))
>                         continue;
> 
> and just ignore non-positive dentries - whether cursors or negative
> ones (which may not happen, but still).

FWIW, I really want to do a unified helper for "rm -rf from kernel"
kind of thing.  We have too many places trying to do that and buggering
it up in all kinds of ways.  This is one of those places; I agree
that the first step is to get rid of that WARN_ONCE, and it's the
right thing to do so that two series would be independent, but it
will need attention afterwards.

> > No "take cursors out of the list" parts yet.
> 
> Looking at the commits, that "take it off the list" one seems very
> nice on its own. It actually seems to simplify the logic regardless of
> the whole "don't need to add it to the end"..
> 
> Only this:
> 
>     if (next)
>         list_move_tail(&cursor->d_child, &next->d_child);
>     else
>         list_del_init(&cursor->d_child);
> 
> is a slight complication, and honestly, I think that should just have
> its own helper function there ("dcache_update_cursor(cursor, next)" or
> something).

I want to see what will fall out of switching cursors to separate
type - the set of primitives, calling conventions for those, etc.
will become more clear once I have something to tweak.  And I would
rather use here the calling conventions identical to the final ones...
 
> That helper function would end up meaning one less change in the hlist
> conversion too.
> 
> The hlist conversion looks straightforward except for the list_move()
> conversions that I didn't then look at more to make sure that they are
> identical, but the ones I looked at looked sane.

BTW, how much is the cost of smp_store_release() affected by a recent
smp_store_release() on the same CPU?  IOW, if we have
	smp_store_release(p, v1);
	<some assignments into the same cacheline>
	r = *q;			// different cacheline
	smp_store_release(q, v2);
how much overhead will the second smp_store_release() give?
