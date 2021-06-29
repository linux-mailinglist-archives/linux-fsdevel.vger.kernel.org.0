Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32183B6DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 07:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhF2Fd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 01:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhF2FdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 01:33:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF01C061574;
        Mon, 28 Jun 2021 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cmynA9A822fLrD7UtdkS3IWPldsRV8lA/D07DeYfc5U=; b=Ufxz9d2ZOAlmZ8x0+E8MVKFXXb
        DyC1ImCCf65waP7HkLZ/SlwLT4GFUqwM4RhJZ1U3kDRtvbr7fQoPLemPvaOsSeL7lVEqCRlrvmMGN
        PUvxxM3Dvi9RDRiOGp0EkbvfLAkNTLcycHyUmNLNk/SSQnp9GJiJ8zgoLDd79QI3Od/clKlzzdUSW
        PdFJFPK9jCV6PSwoDw+VtyYcEwPeWP6cgI5TprjeHGOcMs6vlzz53KBzTbA3OOHZZDiP+eGwXCJB2
        G7R8YT2ouNIeMg0mEABAU2P7MmHNcADjqNNjU1hFZM963lgvecy7DGEv9H39yFkNXwRMErGeQYi7u
        vLVJmumw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ly6Jg-003n4a-1T; Tue, 29 Jun 2021 05:29:59 +0000
Date:   Tue, 29 Jun 2021 06:29:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 0/2] iomap: small block problems
Message-ID: <YNqvzNd+7+YtXfQj@infradead.org>
References: <20210628172727.1894503-1-agruenba@redhat.com>
 <YNoJPZ4NWiqok/by@casper.infradead.org>
 <YNoLTl602RrckQND@infradead.org>
 <YNpGW2KNMF9f77bk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNpGW2KNMF9f77bk@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:59:55PM +0100, Matthew Wilcox wrote:
> > > so permit pages without an iop to enter writeback and create an iop
> > > *then*.  Would that solve your problem?
> > 
> > It is the right thing to do, especially when combined with a feature
> > patch to not bother to create the iomap_page structure on small
> > block size file systems when the extent covers the whole page.
> 
> We don't know the extent layout at the point where *this* patch creates
> iomap_pages during writeback.  I imagine we can delay creating one until
> we find out what our destination layout will be?

Hmm.  Actually ->page_mkwrite is always is always called on an uptodate
page and we even assert that.  I should have remembered the whole page
fault path better.

So yeah, I think we should take patch 1 from Andreas, then a non-folio
version of your patch as a start.  The next steps then would be in
approximate order:

 1. remove the iomap_page_create in iomap_page_mkwrite_actor as it
    clearly is not needed at that point
 2. don't bother to create an iomap_page in iomap_readpage_actor when
    the iomap spans the whole page
 3. don't create the iomap_page in __iomap_write_begin when the
    page is marked uptodate or the write covers the whole page 

delaying the creation further in iomap_writepage_map will be harder
as the loop around iomap_add_to_ioend is still fundamentally block
based.
