Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F60293427
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbgJTE7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 00:59:33 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38349 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391508AbgJTE7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 00:59:33 -0400
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 70A1E58C48F;
        Tue, 20 Oct 2020 15:59:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kUjk8-002NtY-7G; Tue, 20 Oct 2020 15:59:28 +1100
Date:   Tue, 20 Oct 2020 15:59:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201020045928.GO7391@dread.disaster.area>
References: <20201020014357.GW20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020014357.GW20115@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=7-415B0cAAAA:8
        a=cF7yNN9iwmUEYZxmMYcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:43:57AM +0100, Matthew Wilcox wrote:
> This is a weird one ... which is good because it means the obvious
> ones have been fixed and now I'm just tripping over the weird cases.
> And fortunately, xfstests exercises the weird cases.
> 
> 1. The file is 0x3d000 bytes long.
> 2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
> 3. We simulate a read error for 0x3c000-0x3cfff
> 4. Userspace writes to 0x3d697 to 0x3dfaa

So this is a write() beyond EOF, yes?

If yes, then we first go through this path:

	xfs_file_buffered_aio_write()
	  xfs_file_aio_write_checks()
	    iomap_zero_range(isize, pos - isize)

To zero the region between the current EOF and where the new write
starts. i.e. from 0x3d000 to 0x3d696.

> 5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
>    so it calls iomap_split_page() (passing page 0x3d)

Splitting the page because it's !Uptodate seems rather drastic to
me.  Why does it need to split the page here?

Also, this concerns me: if we are exposing the cached EOF page via
mmap, it needs to contain only zeroes in the region beyond EOF so
that we don't expose stale data to userspace. Hence when a THP that
contains EOF is instantiated, we have to ensure that the region
beyond EOF is compeltely zeroed. It then follows that if we read all
the data in that THP up to EOF, then the page is actually up to
date...

And hence, I don't see why we'd need to split it just because we
got a small, unaligned write beyond EOF....

> 6. iomap_split_page() calls split_huge_page()
> 7. split_huge_page() sees that page 0x3d is beyond EOF, so it removes it
>    from i_pages
> 8. iomap_write_actor() copies the data into page 0x3d
> 9. The write is lost.
> 
> Trying to persuade XFS to update i_size before calling
> iomap_file_buffered_write() seems like a bad idea.

Agreed, I can't see anything good coming from doing that...

> Changing split_huge_page() to disregard i_size() is something I kind
> of want to be able to do long-term in order to make hole-punch more
> efficient, but that seems like a lot of work right now.
> 
> I think the easiest way to fix this is to decline to allocate readahead
> pages beyond EOF.  That is, if we have a file which is, say, 61 pages
> long, read the last 5 pages into an order-2 THP and an order-0 THP
> instead of allocating an order-3 THP and zeroing the last three pages.

I think you need to consider zeroing the THP range beyond EOF when
doing readahead....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
