Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30847268320
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 05:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgINDbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 23:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgINDbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:31:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636FC06174A;
        Sun, 13 Sep 2020 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WjUhwYlKFGpv1E2RXeh7apY8MOcSZihoHlo6zguJAJ8=; b=EusotLEa27QCZY8ZxXBo8RFloX
        CJNoof8xaQfKzWcs3E6CKfka3/ODsU32sIAPK0eizkChNu7kROvwcoy8ayz0RLqXmWHRUmQayksbU
        b2vg3pGxuITIGhLelsLFVdFPkkq6AhtA7g4tiQEIKScYRJfAcNzISzRX/TebkYeONw2rBQs6H7wJn
        nMbgJKtHTJxzciOWj64cn5cldmd9OCwMsIB4fMZ9jzHGTSbbdxtpXeIjinxkeDxIr+0156Q9+0ZO7
        z7jQEQVb2ilrF+xEuiOZbmN7/CxfIiKIJEqsh28J2ywKwjwRvI7R0jw+1vboW0vOedUSv37llSAvV
        pLblfJ4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHfDH-0002fK-F7; Mon, 14 Sep 2020 03:31:31 +0000
Date:   Mon, 14 Sep 2020 04:31:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200914033131.GK6583@casper.infradead.org>
References: <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
 <20200913004057.GR12096@dread.disaster.area>
 <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
 <20200913234503.GS12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913234503.GS12096@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:45:03AM +1000, Dave Chinner wrote:
> I have my doubts that complex page cache manipulation operations
> like ->migrate_page that rely exclusively on page and internal mm
> serialisation are really safe against ->fallocate based invalidation
> races.  I think they probably also need to be wrapped in the
> MMAPLOCK, but I don't understand all the locking and constraints
> that ->migrate_page has and there's been no evidence yet that it's a
> problem so I've kinda left that alone. I suspect that "no evidence"
> thing comes from "filesystem people are largely unable to induce
> page migrations in regression testing" so it has pretty much zero
> test coverage....

Maybe we can get someone who knows the page migration code to give
us a hack to induce pretty much constant migration?

> Stuff like THP splitting hasn't been an issue for us because the
> file-backed page cache does not support THP (yet!). That's
> something I'll be looking closely at in Willy's upcoming patchset.

One of the things I did was fail every tenth I/O to a THP.  That causes
us to split the THP when we come to try to make use of it.  Far more
effective than using dm-flakey because I know that failing a readahead
I/O should not cause any test to fail, so any newly-failing test is
caused by the THP code.

I've probably spent more time looking at the page splitting and
truncate/hole-punch/invalidate/invalidate2 paths than anything else.
It's definitely an area where more eyes are welcome, and just having
more people understand it would be good.  split_huge_page_to_list and
its various helper functions are about 400 lines of code and, IMO,
a little too complex.

> The other issue here is that serialisation via individual cache
> object locking just doesn't scale in any way to the sizes of
> operations that fallocate() can run. fallocate() has 64 bit
> operands, so a user could ask us to lock down a full 8EB range of
> file. Locking that page by page, even using 1GB huge page Xarray
> slot entries, is just not practical... :/

FWIW, there's not currently a "lock down this range" mechanism in
the page cache.  If there were, it wouldn't be restricted to 4k/2M/1G
sizes -- with the XArray today, it's fairly straightforward to
lock ranges which are m * 64^n entries in size (for 1 <= m <= 63, n >=0).
In the next year or two, I hope to be able to offer a "lock arbitrary
page range" feature which is as cheap to lock 8EiB as it is 128KiB.

It would still be page-ranges, not byte-ranges, so I don't know how well
that fits your needs.  It doesn't solve the DIO vs page cache problems
at all, since we want DIO to ranges which happen to be within the same
pages as each other to not conflict.
