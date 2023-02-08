Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E068F410
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjBHRMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 12:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjBHRMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:12:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB611F4AA;
        Wed,  8 Feb 2023 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XvevmZ7eJPj41qZI25XXutQP9fxV7mY1igR43Fu3cQg=; b=KxWK1Ny4cSM7QoJ4hUOeMaPjYo
        BBFpA0mvKw5hnhRDLu+ii6DQjrTk+cVbsl8wsSdELGDixoTy8DcOCYvNVKLlM2bGIhLyiz+L4R+kY
        oWnpe1xMJuEfDNV9NpjF+68dnX884yNws82VILo5fYDed/KoY0/EqtMlO33wR5kaG150XrefhpnyX
        EL3GDPTu+cw58MKKbc5IIO8MXOEKKw1nF1p2JajsLRYbKvDuQ8f+S7PrjYk6H9SsFH6/91Y0wkivC
        8W/CmSC2y+mv+wyK5IkTTNgCrmGVprhJEyHFjaCs878IltQ8HJCL8hj+90s+ROjHgav0Kag5KrwLq
        UN1VUXbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPnzK-001OGL-VM; Wed, 08 Feb 2023 17:12:07 +0000
Date:   Wed, 8 Feb 2023 17:12:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Message-ID: <Y+PX5tPyOP2KQqoD@casper.infradead.org>
References: <20230208145335.307287-1-willy@infradead.org>
 <20230208145335.307287-2-willy@infradead.org>
 <Y+PQN8cLdOXST20D@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PQN8cLdOXST20D@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:39:19AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 08, 2023 at 02:53:33PM +0000, Matthew Wilcox (Oracle) wrote:
> > XFS doesn't actually need to be holding the XFS_MMAPLOCK_SHARED
> > to do this, any more than it needs the XFS_MMAPLOCK_SHARED for a
> > read() that hits in the page cache.
> 
> Hmm.  From commit cd647d5651c0 ("xfs: use MMAPLOCK around
> filemap_map_pages()"):
> 
>     The page faultround path ->map_pages is implemented in XFS via
>     filemap_map_pages(). This function checks that pages found in page
>     cache lookups have not raced with truncate based invalidation by
>     checking page->mapping is correct and page->index is within EOF.
> 
>     However, we've known for a long time that this is not sufficient to
>     protect against races with invalidations done by operations that do
>     not change EOF. e.g. hole punching and other fallocate() based
>     direct extent manipulations. The way we protect against these
>     races is we wrap the page fault operations in a XFS_MMAPLOCK_SHARED
>     lock so they serialise against fallocate and truncate before calling
>     into the filemap function that processes the fault.
> 
>     Do the same for XFS's ->map_pages implementation to close this
>     potential data corruption issue.
> 
> How do we prevent faultaround from racing with fallocate and reflink
> calls that operate below EOF?

I don't understand the commit message.  It'd be nice to have an example
of what's insufficient about the protection.  If XFS really needs it,
it can trylock the semaphore and return 0 if it fails, falling back to
the ->fault path.  But I don't think XFS actually needs it.

The ->map_pages path trylocks the folio, checks the folio->mapping,
checks uptodate, then checks beyond EOF (not relevant to hole punch).
Then it takes the page table lock and puts the page(s) into the page
tables, unlocks the folio and moves on to the next folio.

The hole-punch path, like the truncate path, takes the folio lock,
unmaps the folio (which will take the page table lock) and removes
it from the page cache.

So what's the race?
