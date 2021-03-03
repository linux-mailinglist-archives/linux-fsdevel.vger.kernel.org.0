Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2432C572
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbhCDAUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388549AbhCCVLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:11:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE128C061765
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 12:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6YnCoO0+G2JF2F+BhHRjoqQWT6hCxoMjV93OHsnj2Pg=; b=nh1cxFtXR32Q1Ey2dAz7CqL1N3
        2CMb5CwfQLoCfYSwEp4o55HGkgT32RAwoFB51aHrjYX2f8b2wouPlavwKDNBimQOQhk8Zzruwmvws
        k+wWjIe0v0RFc3Ghh+sbpaT09iPg4g20XZTCNyPelQC1RAcX9QmZzx9YkpT+/sGTh8FqPOG+02Uva
        AchBiKSDQoJISjse1ynnHR1VCSGv/fthNzwJo9su/fXw/ZM0u2mF0oeqZZbq/ofO8R3pGCO2CzYoK
        gyj0Jd+oBmG4ddh5jLgeqc7kDhgV5EDYbRr7rYt7itWS3M4jhful0lN2BjynzkhpeSvgdYsbB1OdY
        BjbZaPpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHYYq-004Amt-2e; Wed, 03 Mar 2021 20:57:37 +0000
Date:   Wed, 3 Mar 2021 20:57:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/filemap: Use filemap_read_page in filemap_fault
Message-ID: <20210303205736.GG2723601@casper.infradead.org>
References: <20210226140011.2883498-1-willy@infradead.org>
 <20210302173039.4625f403846abd20413f6dad@linux-foundation.org>
 <20210303013313.GZ2723601@casper.infradead.org>
 <20210302220735.1f150f28323f676d2955ab49@linux-foundation.org>
 <20210303132640.GB2723601@casper.infradead.org>
 <20210303121253.9f44d8129f148b1e2e78cc81@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303121253.9f44d8129f148b1e2e78cc81@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 12:12:53PM -0800, Andrew Morton wrote:
> On Wed, 3 Mar 2021 13:26:40 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > But here's the thing ... invalidate_mapping_pages() doesn't
> > ClearPageUptodate.  The only places where we ClearPageUptodate is on an
> > I/O error.
> 
> yup.
> 
> > So ... as far as I can tell, the only way to hit this is:
> > 
> >  - Get an I/O error during the wait
> >  - Have another thread cause the page to be removed from the page cache
> >    (eg do direct I/O to the file) before this thread is run.
> > 
> > and the consequence to this change is that we have another attempt to
> > read the page instead of returning an error immediately.  I'm OK with
> > that unintentional change, although I think the previous behaviour was
> > also perfectly acceptable (after all, there was an I/O error while trying
> > to read this page).
> > 
> > Delving into the linux-fullhistory tree, this code was introduced by ...
> > 
> > commit 56f0d5fe6851037214a041a5cb4fc66199256544
> > Author: Andrew Morton <akpm@osdl.org>
> > Date:   Fri Jan 7 22:03:01 2005 -0800
> > 
> >     [PATCH] readpage-vs-invalidate fix
> > 
> >     A while ago we merged a patch which tried to solve a problem wherein a
> >     concurrent read() and invalidate_inode_pages() would cause the read() to
> >     return -EIO because invalidate cleared PageUptodate() at the wrong time.
> > 
> > We no longer clear PageUptodate, so I think this is stale code?  Perhaps
> > you could check with the original author ...
> 
> Which code do you think might be stale?  We need the !PageUptodate
> check to catch IO errors and we need the !page->mapping check to catch
> invalidates.  Am a bit confused.

I think the check of !page->mapping here:

        if (PageUptodate(page))
                return 0;
        if (!page->mapping)     /* page truncated */
                return AOP_TRUNCATED_PAGE;

is no longer needed.  If we didn't see an error, the page will be Uptodate,
regardless of whether it's been removed from the page cache.  If we did
see an error, it's OK to return -EIO, even if the page has been removed
from the page cache in the interim.
