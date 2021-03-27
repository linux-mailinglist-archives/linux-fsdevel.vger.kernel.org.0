Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1D34B80F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhC0P4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0P4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 11:56:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0255FC0613B1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k62a7JBi4IKU3V+Sgc3RyDAhnGCy97aEm4KPW9g+I44=; b=LXkVo076OKduVDq1YtLn5Y2OVt
        uK/WSt3Gb+X40rJkVwxaJsyx5a8lJu4gDFWndDCVdqa4+WsSpTCOVXcRtZcVL0mX0Qh+UKLp6Xyxm
        0iHBbg9ujgddVNHfYYO1eUmkjq7OT5aqt8IE1A+pRxBmxAuPP2k0xTBDJLeuhR6rzpVo6RoXgBqMa
        I3X0UEsUqdr4qtYmtOLoGOBPE5TS8RoW1NaKf7I4zlWGPOAB3vgMKeqdnwGsiFKI0mu35emawxSpL
        f/t0wdman/psYvYnWqNZ0zgEmjyYDNSwzz4I/FI8f43/23DycOTR0QsZjUg9k7Yo//cL+knUBgaiw
        k/i+DOCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQBIc-00GXOo-Or; Sat, 27 Mar 2021 15:56:33 +0000
Date:   Sat, 27 Mar 2021 15:56:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
Message-ID: <20210327155630.GJ1719932@casper.infradead.org>
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org>
 <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk>
 <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk>
 <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 27, 2021 at 11:40:08AM -0400, Mike Marshall wrote:
> int ret;
> 
> loff_t new_start = readahead_index(rac) * PAGE_SIZE;

That looks like readahead_pos() to me.

> size_t new_len = 524288;
> readahead_expand(rac, new_start, new_len);
> 
> npages = readahead_count(rac);
> offset = readahead_pos(rac);
> i_pages = &file->f_mapping->i_pages;
> 
> iov_iter_xarray(&iter, READ, i_pages, offset, npages * PAGE_SIZE);

readahead_length()?

> /* read in the pages. */
> ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
> npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);
> 
> /* clean up. */
> while ((page = readahead_page(rac))) {
> page_endio(page, false, 0);
> put_page(page);
> }
> }

What if wait_for_direct_io() returns an error?  Shouldn't you be calling

page_endio(page, false, ret)

?

> On Sat, Mar 27, 2021 at 9:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Mar 27, 2021 at 08:31:38AM +0000, David Howells wrote:
> > > However, in Mike's orangefs_readahead_cleanup(), he could replace:
> > >
> > >       rcu_read_lock();
> > >       xas_for_each(&xas, page, last) {
> > >               page_endio(page, false, 0);
> > >               put_page(page);
> > >       }
> > >       rcu_read_unlock();
> > >
> > > with:
> > >
> > >       while ((page = readahead_page(ractl))) {
> > >               page_endio(page, false, 0);
> > >               put_page(page);
> > >       }
> > >
> > > maybe?
> >
> > I'd rather see that than open-coded use of the XArray.  It's mildly
> > slower, but given that we're talking about doing I/O, probably not enough
> > to care about.
