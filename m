Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791F22939C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392424AbgJTLVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406058AbgJTLVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:21:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDFC061755;
        Tue, 20 Oct 2020 04:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tSS1MuZ8AFbkW+ypKAMNnv6YlEacISP3BShZ3dh/KFQ=; b=UrYIw+UoNzUIduQWr+Vr0lA53w
        +Cic3Xur8MBbfGAFjra5xdsoOviIc1j3gA/WUG5RUFHxFVo0sRUHNHhk1+w46kip7KYZy8q216ogu
        Lrd6UmvNEcWmQ2vxAZwRnLi2ZlSEExY+eNkAR942XEQ6ZXgVrrViPyS2TGhT7EYKK4KMg90QTj/ud
        ER2FY5jiFgtlaATtoiuhSUTPGLw+Axd1ZG6seTYpp70FCzkOMKE7UR4VtE8gvKx11BCnI7K8DmBax
        XHDjIYzpZaMmw6AUQ2RWw9qL2qxEf35fdGMi/UU+e+QxUHG4F7H0CXg4sGWHmHsqq9juPpeVq5eJK
        U/CMYL1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUphy-0001Fq-Ny; Tue, 20 Oct 2020 11:21:38 +0000
Date:   Tue, 20 Oct 2020 12:21:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting a THP beyond EOF
Message-ID: <20201020112138.GZ20115@casper.infradead.org>
References: <20201020014357.GW20115@casper.infradead.org>
 <20201020045928.GO7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020045928.GO7391@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 03:59:28PM +1100, Dave Chinner wrote:
> On Tue, Oct 20, 2020 at 02:43:57AM +0100, Matthew Wilcox wrote:
> > This is a weird one ... which is good because it means the obvious
> > ones have been fixed and now I'm just tripping over the weird cases.
> > And fortunately, xfstests exercises the weird cases.
> > 
> > 1. The file is 0x3d000 bytes long.
> > 2. A readahead allocates an order-2 THP for 0x3c000-0x3ffff
> > 3. We simulate a read error for 0x3c000-0x3cfff
> > 4. Userspace writes to 0x3d697 to 0x3dfaa
> 
> So this is a write() beyond EOF, yes?
> 
> If yes, then we first go through this path:
> 
> 	xfs_file_buffered_aio_write()
> 	  xfs_file_aio_write_checks()
> 	    iomap_zero_range(isize, pos - isize)
> 
> To zero the region between the current EOF and where the new write
> starts. i.e. from 0x3d000 to 0x3d696.

Yes.  That calls iomap_write_begin() which calls iomap_split_page()
which is where we run into trouble.  I elided the exact path from the
description of the problem.

> > 5. iomap_write_begin() gets the 0x3c page, sees it's THP and !Uptodate
> >    so it calls iomap_split_page() (passing page 0x3d)
> 
> Splitting the page because it's !Uptodate seems rather drastic to
> me.  Why does it need to split the page here?

Because we can't handle Dirty, !Uptodate THPs in the truncate path.
Previous discussion:
https://lore.kernel.org/linux-mm/20200821144021.GV17456@casper.infradead.org/

The current assumption is that a !Uptodate THP is due to a read error,
and so the sensible thing to do is split it and handle read errors at
a single-page level.

I've been playing around with creating THPs in the write path, and that
offers a different pathway to creating Dirty, !Uptodate THPs, so this
may also change at some point.  I'd like to get what I have merged and
then figure out how to make this better.

> Also, this concerns me: if we are exposing the cached EOF page via
> mmap, it needs to contain only zeroes in the region beyond EOF so
> that we don't expose stale data to userspace. Hence when a THP that
> contains EOF is instantiated, we have to ensure that the region
> beyond EOF is compeltely zeroed. It then follows that if we read all
> the data in that THP up to EOF, then the page is actually up to
> date...

We do that in iomap_readpage_actor().  Had the readahead I/O not "failed",
we'd've had an Uptodate THP which straddled EOF.  I dumped the page and
its uptodate bits are 0xfff0 (1kB block size filesystem, the three pages
0x3d-0x3f are uptodate because they were zeroed and 0x3c is !uptodate
because the I/O failed).

