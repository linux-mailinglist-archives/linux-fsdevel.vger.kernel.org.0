Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4B3B0CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhFVS0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhFVS0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:26:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33532C061756;
        Tue, 22 Jun 2021 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1i+51cszTri2Pv6HZYmqCBAao6nBfImeLdZrjWVU9oI=; b=OvqyJ5NT5aiJLaAtcuhODvVx8r
        2CU8kI2Vq62ueK5dcTXUbqE/rsz+6aovjex2JX/YcAGwyHWKkMbf+eN+AAtPAwKtVms9jefILxXPX
        9AITgSGMMeXOir+xGZF7Zyz20TzMD+gZ7N4/yvD2wVdAsuo5IgrLsMpBeKzdRTItGNs6LYVSE9qcC
        F5eM9uw7klgR1l/aBEKY9ufwyqeyqa1hnPDStxhgxAoMEC5meh9Nrc0SCmZJCV9N9Lxzdm54K2/vY
        jVIgq4huUBENpA7JC6/DLw9CaAhoqhUdJgCGIrwTYzFseT/82ruPWDtAZB49Mrjky7xi6N2sSWrGf
        oSHaKPtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvl3H-00EcNm-0Z; Tue, 22 Jun 2021 18:23:17 +0000
Date:   Tue, 22 Jun 2021 19:23:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <YNIqjhsvEms6+vk9@casper.infradead.org>
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk>
 <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk>
 <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk>
 <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:07:56AM -0700, Linus Torvalds wrote:
> On Tue, Jun 22, 2021 at 11:05 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Huh?  Last I checked, the fault_in_readable actually read a byte from
> > the page.  It has to wait for the read to complete before that can
> > happen.
> 
> Yeah, we don't have any kind of async fault-in model.
> 
> I'm not sure how that would even look. I don't think it would
> necessarily be *impossible* (special marker in the exception table to
> let the fault code know that this is a "prepare" fault), but it would
> be pretty challenging.

It wouldn't be _that_ bad necessarily.  filemap_fault:

        page = find_get_page(mapping, offset);
...
        } else if (!page) {
                fpin = do_sync_mmap_readahead(vmf);

... and we could return at that point if the flag was set.  There'd be
some more details to fill in (if there's a !uptodate page in the page
cache, don't wait for it), but it might not be too bad.
