Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F66267D70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 05:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgIMDSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 23:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIMDSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 23:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B60C061573;
        Sat, 12 Sep 2020 20:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=07Yc9hlOZlK8jaubITpX1W4ZXVuDqM+qxh845euYi0Y=; b=ntMY+xGArjDoNHYicjjvf/9a/3
        +Mru0JqVS8VtG8cAGjzvDRaC2BadQvQlC/tM/4J5vju9X+Dk8ymqPI6t75Tu6nUZkAtJLMHc61zXU
        ECxCzg+28nf0RWdeoX/5o+g49KsyeZ/p0CmFYC15lVCuFRrMKcJWgkZdtHbAzW/E+GXe9yo1cgYn2
        mghdhPbddrJDunMBVVIPZSwadzr6dqYJo917UDO1/NyugOKaDwspRcqs4vF+qU3ilcTZPAwEkme5P
        DtrGtDQ0ISfR3dzGpSXrNT57C9lnchIosTHjl0wa0qMci6X9Vt1503LPR/9yalYlXmGaGLeMn93k5
        ejLehgUA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHIXB-0003pf-9B; Sun, 13 Sep 2020 03:18:33 +0000
Date:   Sun, 13 Sep 2020 04:18:33 +0100
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
Message-ID: <20200913031833.GE6583@casper.infradead.org>
References: <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
 <20200913004057.GR12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913004057.GR12096@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 13, 2020 at 10:40:57AM +1000, Dave Chinner wrote:
> > The reason the apache benchmark regresses is that it basically does a
> > web server test with a single file ("test.html") that gets served by
> > just mmap'ing it, and sending it out that way. Using lots of threads,
> > and using lots of different mappings. So they *all* fault on the read
> > of that page, and they *all* do that "lock page, check that the
> > mapping is valid, insert page" dance.
> 
> Hmmmm. So this is a typically a truncate race check, but this isn't
> sufficient to protect the fault against all page invalidation races
> as the page can be re-inserted into the same mapping at a different
> page->index now within EOF.

No it can't.  find_get_page() returns the page with an elevated refcount.
The page can't be reused until we call put_page().  It can be removed
from the page cache, but can't go back to the page allocator until the
refcount hits zero.

> 5) filesystems will still need to be able to exclude page faults
> over a file range while they directly manipulate file metadata to
> change the user data in the file

Yes, but they can do that with a lock inside ->readpage (and, for that
matter in ->readahead()), so there's no need to take a lock for pages
which are stable in cache.

