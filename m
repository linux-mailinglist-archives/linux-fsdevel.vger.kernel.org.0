Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63AC1DDDA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 05:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgEVDFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 23:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEVDFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 23:05:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90899C061A0E;
        Thu, 21 May 2020 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ws6mDxugOw83qz5FboXgcXuaCjucqwgfP3Opy1/y+PY=; b=r1TPvPcKm6UjpoPKi+DHen5TkY
        k+zurUJXCvxxY2EgM5d4d9FupeUVTQgwynYkyz8enzjLl/Y41f8GErtba8gKz65bpYWavA93CFNAv
        AQUU7Sh1I/37q0MOaI991ahUqolotpfnTG95vjPMA9u1KB9SGaXdwDctjQ98JqGkE1mrvkrM/mKz/
        kW9JOMO7N99CiJN/mNgDHT828oBacfWCuGU8PtadNymmnhJfWikEy9POSK42Huod1QNl8DkycGvRc
        KaEhdvfsVDYE6GIg7iCEgByW1Oi+CnzlxY4+UwwR7mMdKp9f5goyWIWIDax3vfH4N5ikgs5BO65Tr
        sx524syQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jby0P-0005xG-D0; Fri, 22 May 2020 03:05:53 +0000
Date:   Thu, 21 May 2020 20:05:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] Large pages in the page cache
Message-ID: <20200522030553.GK28818@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200521224906.GU2005@dread.disaster.area>
 <20200522000411.GI28818@bombadil.infradead.org>
 <20200522025751.GX2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522025751.GX2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 12:57:51PM +1000, Dave Chinner wrote:
> On Thu, May 21, 2020 at 05:04:11PM -0700, Matthew Wilcox wrote:
> > On Fri, May 22, 2020 at 08:49:06AM +1000, Dave Chinner wrote:
> > > Ok, so the main issue I have with the filesystem/iomap side of
> > > things is that it appears to be adding "transparent huge page"
> > > awareness to the filesysetm code, not "large page support".
> > > 
> > > For people that aren't aware of the difference between the
> > > transparent huge and and a normal compound page (e.g. I have no idea
> > > what the difference is), this is likely to cause problems,
> > > especially as you haven't explained at all in this description why
> > > transparent huge pages are being used rather than bog standard
> > > compound pages.
> > 
> > The primary reason to use a different name from compound_*
> > is so that it can be compiled out for systems that don't enable
> > CONFIG_TRANSPARENT_HUGEPAGE.  So THPs are compound pages, as they always
> > have been, but for a filesystem, using thp_size() will compile to either
> > page_size() or PAGE_SIZE depending on CONFIG_TRANSPARENT_HUGEPAGE.
> 
> Again, why is this dependent on THP? We can allocate compound pages
> without using THP, so why only allow the page cache to use larger
> pages when THP is configured?

We have too many CONFIG options.  My brain can't cope with adding
CONFIG_LARGE_PAGES because then we might have neither THP nor LP, LP and
not THP, THP and not LP or both THP and LP.  And of course HUGETLBFS,
which has its own special set of issues that one has to think about when
dealing with the page cache.

So, either large pages becomes part of the base kernel and you
always get them, or there's a CONFIG option to enable them and it's
CONFIG_TRANSPARENT_HUGEPAGE.  I chose the latter.

I suppose what I'm saying is that a transparent hugepage can now be any
size [1], not just PMD size.

[1] power of two that isn't 1 because we use the third page for
something-or-other.
