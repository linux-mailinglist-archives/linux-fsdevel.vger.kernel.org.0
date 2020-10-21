Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638AC294600
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 02:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439571AbgJUAX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410924AbgJUAX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:23:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F723C0613CE;
        Tue, 20 Oct 2020 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OoXf9TqR/9/W/P0B/M4Uc8ZYoy2jtrMpXmMCh3pYwWI=; b=c7ZEl1enCdl4YFjo0BhLoBsdFa
        jn0npm4ZPMRIDhFYA8aJujKppTuN6Osom8GI+op55ZQ9O766MjXH3wolGlnJnfelIJ7iicDUecO44
        ljL9SUQiIOPabKFWGPB3SYR7uP0dXDOc2EoUDV6b55jdOqe/MTWZErvQ19ZMnqnIzWF/PBgTglHKe
        S3HLxURDeBexVNk4RRlVcf1OfkcSlZijv8TXpqkBBFg+iIq7aoh0gnvPvbnivy607McQ48zA8YGRl
        9h/MreNvdGDcpTvgRGvRl7uoVY5/CGeW3ujE6+aNRKXBTXb2HwBqWAEhQTcqaLbbbv0hhg7mwjhDX
        3bsaVa8w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kV1uy-00018W-H9; Wed, 21 Oct 2020 00:23:52 +0000
Date:   Wed, 21 Oct 2020 01:23:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201021002352.GF20115@casper.infradead.org>
References: <20201020014357.GW20115@casper.infradead.org>
 <AD1D4324-F072-4E8F-9594-BC450A215ED3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AD1D4324-F072-4E8F-9594-BC450A215ED3@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:32:59AM -0400, Chris Mason wrote:
> On 19 Oct 2020, at 21:43, Matthew Wilcox wrote:
> > This is a weird one ... which is good because it means the obvious
> > ones have been fixed and now I'm just tripping over the weird cases.
> > And fortunately, xfstests exercises the weird cases.
> > 
> > 1. The file is 0x3d000 bytes long.
> > 2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
> > 3. We simulate a read error for 0x3c000-0x3cfff
> > 4. Userspace writes to 0x3d697 to 0x3dfaa
> > 5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
> >    so it calls iomap_split_page() (passing page 0x3d)
> > 6. iomap_split_page() calls split_huge_page()
> > 7. split_huge_page() sees that page 0x3d is beyond EOF, so it removes it
> >    from i_pages
> > 8. iomap_write_actor() copies the data into page 0x3d
> 
> I’m guessing that iomap_write_begin() is still in charge of locking the
> pages, and that iomap_split_page()->split_huge_page() is just reusing that
> lock?

That's right -- iomap_write_begin() calls grab_cache_page_write_begin()
which acquires the page lock.

> It sounds like you’re missing a flag to iomap_split_page() that says: I care
> about range A->B, even if its beyond EOF.  IOW, iomap_write_begin()’s path
> should be in charge of doing the right thing for the write, without relying
> on the rest of the kernel to avoid upsetting it.

Yeah, the problem is that split_huge_page() doesn't have that
functionality.  I'd like to add it, but Kirill's not particularly keen.
I'm also looking for a quick fix more than an intrusive change like
that ...  fortunately, I found one.  And it's even something that was
on my long-term todo list; I don't think we should be allocating THPs
to cache beyond the end of the file.  I mean, I could see the point in
allocating a 2MB THP to cache a 1.9MB file tail, but allocating a 64kB
page to cache a 3kB file tail is definitely wrong.

> > Changing split_huge_page() to disregard i_size() is something I kind
> > of want to be able to do long-term in order to make hole-punch more
> > efficient, but that seems like a lot of work right now.
> > 
> 
> The problem with trusting i_size is that it changes at surprising times.
> For this code inside split_huge_page(), end == i_size_read()
> 
>         for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>                 __split_huge_page_tail(head, i, lruvec, list);
>                 /* Some pages can be beyond i_size: drop them from page
> cache */
>                 if (head[i].index >= end) {
>                         ClearPageDirty(head + i);
> 
> But, we actually change i_size after dropping all the page locks.  In xfs
> this is xfs_setattr_size()->truncate_setsize(), all of which means that
> dropping PageDirty seems unwise if this code is running concurrently with an
> expanding truncate.  If i_size jumps past the page where you’re clearing
> dirty, it probably won’t be good.  Ignore me if this is already handled
> differently, it just seems error prone in current Linus.

Oh, but the next line is __delete_from_page_cache().  So a concurrent
expanding truncate will never find this page, it's about to go back to
the page allocator.
