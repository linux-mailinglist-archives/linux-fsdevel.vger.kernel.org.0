Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDE412B82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 04:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbhIUCTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 22:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbhIUBt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:49:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E653C0A0E12;
        Mon, 20 Sep 2021 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=et0MvhdhrmyngXfH1Tl0dRGqqe2AQSXkxnodtir63lE=; b=KHowFi1hYx9+25v21zaYvXfc9F
        Ba5gKPkLatl6F/9QVuf0aG9yLx8MRLHha+g85sD1HNUMMrLzCaquMLgQaywwi3K++u0QUld4AXn1C
        TDc5y0sUw+Tvhisa9wwA22jkxntuDLQcPux0BKJWNsATr5iNiGdOGJn89M3+l2XKBZQ0pTwy6QnUv
        LCwQmMNVCJ3+OegsxGPjN8ItWMCd0uGq3zN+1YXtk36K7cUfKad9CRVBFBGzAyC78FSVCuLm4wqPo
        bfch3wYh8ko6sWzghaKMKmS80jtaiGAYb9CRV31XLNDv+dLs0KYYZPUi9boqtUzlwORVHtg717a8P
        zWTwti6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSRBD-003Htc-8W; Mon, 20 Sep 2021 21:50:34 +0000
Date:   Mon, 20 Sep 2021 22:50:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, cfijalkovich@google.com,
        song@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
Message-ID: <YUkCI2I085Sos/64@casper.infradead.org>
References: <20210917205731.262693-1-shy828301@gmail.com>
 <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org>
 <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:23:41PM -0700, Yang Shi wrote:
> On Sun, Sep 19, 2021 at 7:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Sep 17, 2021 at 05:07:03PM -0700, Yang Shi wrote:
> > > > The debugging showed the page passed to invalidatepage is a huge page
> > > > and the length is the size of huge page instead of single page due to
> > > > read only FS THP support.  But block_invalidatepage() would throw BUG if
> > > > the size is greater than single page.
> >
> > Things have already gone wrong before we get to this point.  See
> > do_dentry_open().  You aren't supposed to be able to get a writable file
> > descriptor on a file which has had huge pages added to the page cache
> > without the filesystem's knowledge.  That's the problem that needs to
> > be fixed.
> 
> I don't quite understand your point here. Do you mean do_dentry_open()
> should fail for such cases instead of truncating the page cache?

No, do_dentry_open() should have truncated the page cache when it was
called and found that there were THPs in the cache.  Then khugepaged
should see that someone has the file open for write and decline to create
new THPs.  So it shouldn't be possible to get here with THPs in the cache.
