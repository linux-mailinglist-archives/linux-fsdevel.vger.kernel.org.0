Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9241BB30CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfIOQCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 12:02:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43834 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfIOQCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:02:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9Wyy-0002Mj-Nl; Sun, 15 Sep 2019 16:02:36 +0000
Date:   Sun, 15 Sep 2019 17:02:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190915160236.GW1131@ZenIV.linux.org.uk>
References: <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 06:41:41PM -0700, Linus Torvalds wrote:
> On Sat, Sep 14, 2019 at 5:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > d_subdirs/d_child become an hlist_head/hlist_node list; no cursors
> > in there at any time.
> 
> Hmm. I like this.
> 
> I wonder if we could do that change independently first, and actually
> shrink the dentry (or, more likely, just make the inline name longer).
> 
> I don't think that dcache_readdir() is actually stopping us from doing
> that right now. Yes, we do that
> 
>     list_add_tail(&cursor->d_child, &parent->d_subdirs);
> 
> for the end case, but as mentioned, we could replace that with an EOF
> flag, couldn't we?

Could be done, AFAICS.  I'm not even sure we need a flag per se - we
have two cases when the damn thing is not in the list and "before
everything" case doesn't really need to be distinguished from post-EOF
one.  dcache_dir_lseek() doesn't care where the cursor had been -
it goes by ->f_pos and recalculates the position from scratch.  And
dcache_readdir() is doing
        if (!dir_emit_dots(file, ctx))
                return 0;

        if (ctx->pos == 2)
                p = anchor;
        else
                p = &cursor->d_child;
IOW, if we used to be pre-list, we'll try to spit . and .. out and
either bugger off, or get ctx->pos == 2.  I.e. we only look at the
cursor's position in the list for ctx->pos > 2 case.

So for the variant that has cursors still represented by dentries we can
replace "post-EOF" with "not in hlist" and be done with that.  For
"cursors are separate data structures" variant... I think pretty much
the same applies (i.e. "not refering to any dentry" both for post-EOF
and before-everything cases, with readdir and lseek logics taking care
of small-offset case by ->f_pos), but I'll need to try and see how
well does that work.

> Btw, if you do this change, we should take the opportunity to rename
> those confusingly named things. "d_subdirs" are our children - which
> aren't necessarily directories, and "d_child" are the nodes in there.
> 
> Your change would make that clearer wrt typing (good), but we could
> make the naming clearer too (better).
> 
> So maybe rename "d_subdirs -> d_children" and "d_child -> d_sibling"
> or something at the same time?
> 
> Wouldn't that clarify usage, particularly together with the
> hlist_head/hlist_node typing?
>
> Most of the users would have to change due to the type change anyway,
> so changing the names shouldn't make the diff any worse, and might
> make the diff easier to generate (simply because you can *grep* for
> the places that need changing).

Makes sense...

> I wonder why we have that naming to begin with, but it's so old that I
> can't remember the reason for that confusing naming. If there ever was
> any, outside of "bad thinking".

->d_subdirs/->d_child introduction was what, 2.1.63?  November 1997...
I'd been otherwise occupied, to put it mildly (first semester in
PennState grad program, complete with the move from spb.ru to US in
August).  I don't think I'd been following any lists at the time,
sorry.  And the only thing google finds is
http://lkml.iu.edu/hypermail/linux/kernel/9711.0/0250.html
with nothing public prior to that.  What has happened to Bill Hawes, BTW?
