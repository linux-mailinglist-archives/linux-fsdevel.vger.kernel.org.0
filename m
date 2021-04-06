Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF78355924
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhDFQ00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbhDFQ00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:26:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E89BC06174A;
        Tue,  6 Apr 2021 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ReC1A8LEcNA74MnXWjE1S8Le2jL7zE3sYBVCRscMRCs=; b=fx834GXHLWrbKbI/6uLgpgctFM
        Q5KyQ0MFtvxJh6NlhE3d0eXK6x3CQugCROk+IFxmFqPLGA2qPvseVy/ls2tuS7hPms11iObLBCauI
        OV7uHRQf7Ib9zGKIXKGbsYFT6Ra8bxC+RnIadJehDso2FLs/+cWo6UZ9vbgFuu/m62nepdJ2+qqM3
        hWDUhYWehUlmEjiVsKsv0dKjn/3ibDjp1xFxH4zc3PQRHwRvr5J/AJqdmwa4RcUfllWWy/ilBGw4s
        shHJ58BfrKh2KiEek2rfcG+9LJdKhTVSQASLZo5bcWwqYFXTXwm9vvMRLjbkaogq15yeyrkIABQ1/
        E/r4rZwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lToWA-00D5BK-1j; Tue, 06 Apr 2021 16:25:40 +0000
Date:   Tue, 6 Apr 2021 17:25:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 01/27] mm: Introduce struct folio
Message-ID: <20210406162530.GT2531743@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-2-willy@infradead.org>
 <20210406122918.h5dsnbjhmwpfasf4@box.shutemov.name>
 <20210406124807.GO2531743@casper.infradead.org>
 <20210406143150.GA3082513@infradead.org>
 <20210406144022.GR2531743@casper.infradead.org>
 <20210406144712.GA3087660@infradead.org>
 <20210406145511.GS2531743@casper.infradead.org>
 <20210406150550.GA3094215@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406150550.GA3094215@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 04:05:50PM +0100, Christoph Hellwig wrote:
> On Tue, Apr 06, 2021 at 03:55:11PM +0100, Matthew Wilcox wrote:
> > Assuming we're getting rid of them all though, we have to include:
> > 
> > $ git grep 'page->mapping' fs |wc -l
> > 358
> > $ git grep 'page->index' fs |wc -l
> > 355
> 
> Are they all going to stay?  Or are we going to clean up some of that
> mess.  A lot of ->index should be page_offet, and on the mapping side
> the page_mapping and page_file_mapping mess is also waiting to be
> sorted..

About a third of ->index can be folio_offset(), based on a crude:

$ git grep 'page->index.*PAGE_' |wc -l
101

and I absolutely don't mind cleaning that up as part of the folio work,
but that still leaves 200-250 instances that would need to be changed
later.

I don't want to change the page->mapping to calls to folio_mapping().
That's a lot of extra work for a page which the filesystem knows belongs
to it.  folio_mapping() only needs to be used for pages which might not
belong to a filesystem.

page_file_mapping() absolutely needs to go away.  The way to do that
is to change swap-over-nfs to use direct IO, and then NFS can use
folio->mapping like all other filesystems.  f2fs is just terminally
confused and shouldn't be using page_file_mapping at all.  I'll fix
that as part of the folio work.
