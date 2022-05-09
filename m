Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13DE51FEC1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiEINwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiEINwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:52:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1D81C3451
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bhw2uQUmiXWbi1ptC/rpNytcc50ILFBaJV2hnsjN9mg=; b=Rw0DEyrt+TOF6VbVaesSiFTn9B
        5+rbJI7YF/tSWDwCUVMFlmnkXK0Lu6essY7tDLooHRfCbGxyavDhZipd0b0rVajY6DHpAv+VFpY7n
        ge3JMjoV+e75WQ2DjDplIH+yFNmf8IF/v21384Dq1kBGSOV42Vtuqlw4wn4Ret2Q/nSSzFjHX9WIQ
        +WjZv4KwxV375KHIE96Ces9ldjcluNr/KFCfryWazEcbZMmLQmxtz/cd9uHk3B1rOvTNDg7D9usYa
        nfIe/0egncE2nyDdyjUppG12G7eKZ1q0wigyhO0y3YGbVHivOtNjtOuWEmJ84lg5qBO9IJoyil8qS
        xE/Kzi7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no3ka-003V3v-Kt; Mon, 09 May 2022 13:48:36 +0000
Date:   Mon, 9 May 2022 14:48:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/26] jbd2: Convert release_buffer_page() to use a folio
Message-ID: <YnkbtLS9cvqtU6vm@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
 <20220508203247.668791-25-willy@infradead.org>
 <YnkVvr6UR2NQLbWi@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnkVvr6UR2NQLbWi@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 09:23:10AM -0400, Theodore Ts'o wrote:
> On Sun, May 08, 2022 at 09:32:45PM +0100, Matthew Wilcox (Oracle) wrote:
> > Saves a few calls to compound_head().
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> 
> ... although I have one question:
> 
> > -	get_page(page);
> > +	folio_get(folio);
> >  	__brelse(bh);
> > -	try_to_free_buffers(page);
> > -	unlock_page(page);
> > -	put_page(page);
> > +	try_to_free_buffers(&folio->page);
> 
> The patches in this series seem to assume that the folio contains only
> a single page.  Or at least, a *lot* more detailed auditing to make
> sure the right thing would happen if a page happens to be a member of
> a folio with more than a single page.
> 
> Should we be adding some kind of WARN_ON to check this particular
> assumption?

You're right, a lot of places assume a single-page folio.  Since
filesystems need to explicitly enable large folios (by calling
mapping_set_large_folios()), I haven't been adding assertions to
aops entry points.  I have been adding them to some common utility
functions in fs/buffer.c eg block_read_full_folio has:
        VM_BUG_ON_FOLIO(folio_test_large(folio), folio);

Other functions in fs/buffer.c look like they should handle large folios
OK, eg buffer_check_dirty_writeback() and block_dirty_folio() and then
others have existing assertions which are going to trigger if you try
to use them with large folios, like __block_write_begin_int() has
        BUG_ON(from > PAGE_SIZE);
and I haven't bothered to add assertions to either of those classes of
function.

JBD2 somewhat straddles a line between being considered "generic utility
functions" and "part of a filesystem".  I could go either way on adding
assertions to document that this hasn't been audited for large folios.
Although seeing '&folio->page' is always a sign that you should probably
audit the function.

By the end of this series, it seems to me that jbd2's
release_buffer_page() is actually large-folio-safe.  There's nothing
in it that relies on the size of the folio, it calls functions that
are large-folio-safe and the only actual use of 'page' in it is to
get bh->b_page ... which should probably be in a union with a new
->b_folio so we don't need to muck around with calling page_folio().
