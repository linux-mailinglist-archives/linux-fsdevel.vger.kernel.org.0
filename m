Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D331C3B6E04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 07:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhF2FrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 01:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhF2FrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 01:47:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B5DC061574;
        Mon, 28 Jun 2021 22:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nh4bp17vHoHz0rY3D1EcVzw0MUXFiwPtG2xgIgB1mwg=; b=FEnvSzYgRAHSgr5RP800zeV1cT
        aQQ8my7c//PZ6i6gFS2ts+avB1X9XQDjZruIdVgBUqIGzIYH3Kt0WDB8bjsLSIMvNSzDo9R59YClq
        LngPNu4idZDLOtz4OVzTZCIT/dt08YPd/Nj6elzo5RKxVztJnSou8V0SjSvTQUXbdA//yjUb1lpDC
        Sr4eTh1U7idh85188YeoT8JwrujA9/TQ/bPfk7N+b9y92sB6IyfqNHOE0z74Kx4/m+hFhrWBhXUIt
        mAoD9AJdDM4r5mIhgAod8+MmXdb9qycHk229+yqqWg3xKYCRfQe/oOjxSFVkQZz8403mzeaRtfNP5
        WkJgYYVg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ly6W8-003nYz-Ut; Tue, 29 Jun 2021 05:43:00 +0000
Date:   Tue, 29 Jun 2021 06:42:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 0/2] iomap: small block problems
Message-ID: <YNqy0E4xFwHDhK32@infradead.org>
References: <20210628172727.1894503-1-agruenba@redhat.com>
 <YNoJPZ4NWiqok/by@casper.infradead.org>
 <YNoLTl602RrckQND@infradead.org>
 <YNpGW2KNMF9f77bk@casper.infradead.org>
 <YNqvzNd+7+YtXfQj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNqvzNd+7+YtXfQj@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 06:29:48AM +0100, Christoph Hellwig wrote:
> Hmm.  Actually ->page_mkwrite is always is always called on an uptodate
> page and we even assert that.  I should have remembered the whole page
> fault path better.
> 
> So yeah, I think we should take patch 1 from Andreas, then a non-folio
> version of your patch as a start.  The next steps then would be in
> approximate order:
> 
>  1. remove the iomap_page_create in iomap_page_mkwrite_actor as it
>     clearly is not needed at that point
>  2. don't bother to create an iomap_page in iomap_readpage_actor when
>     the iomap spans the whole page
>  3. don't create the iomap_page in __iomap_write_begin when the
>     page is marked uptodate or the write covers the whole page 

Further thoughts for a better series:

 1. create iomap_page if needed in iomap_writepage_map
 2. do not create the iomap_page at all in iomap_readpage_actor.
    ->readahead is always called on newly allocated pages, and
    ->readpage either on a clean !uptodate page or on one that
    has seen a write leading to a partial uptodate state.  That
    is for the case that cares about the iomap_page it is present
    already
 3. don't create the iomap_page in iomap_page_mkwrite_actor

I think this is the simple initial series that should solve Andreas'
problem.  Then we can look into optimizing __iomap_write_begin
and iomap_writepage_map further as needed.
