Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF515442DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 13:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhKBMc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBMcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:32:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E1DC061714;
        Tue,  2 Nov 2021 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TKqWgfpw5AGxV0aXDmIN4fp1Id+pK1uozWw0xKtDRVU=; b=o3CXWrfh6eqE/lwsca02rozqZi
        OKidFQjXbtIZCsmOTMW6lm0UZf4jV+/3UzKD5e2BRyjbi0/0OTBwZhxKMLqEikCYo5IknqCcBY4FZ
        8tDZWe8odIIUSQvYZA99b7ad2EaM18IKKCj6hc4+hl6xAjdmRil/Vv2tSSgF0+vGrOiKRLpc84cEd
        s40c1JwJvOlFAdQRRqzsMgQqCsGsWUywtkapp54VRZB5DKQhlhyvp/brpw1s+Kde1Kv1JjNcQLaZY
        VBNS7+gt5Dv4idlPr/falDKw8o4yF554w+cRiqLW11HkNrPn4D0mK11mGQ+nqrJR7pnAzORfmr06c
        39usDeAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhsta-004UJp-MJ; Tue, 02 Nov 2021 12:29:01 +0000
Date:   Tue, 2 Nov 2021 12:28:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 13/21] iomap: Convert readahead and readpage to use a
 folio
Message-ID: <YYEu1qj3yxF968HR@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-14-willy@infradead.org>
 <YYDmz8olTe/Qr2ch@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYDmz8olTe/Qr2ch@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 12:20:47AM -0700, Christoph Hellwig wrote:
> On Mon, Nov 01, 2021 at 08:39:21PM +0000, Matthew Wilcox (Oracle) wrote:
> >  	for (done = 0; done < length; done += ret) {
> > -		if (ctx->cur_page && offset_in_page(iter->pos + done) == 0) {
> > -			if (!ctx->cur_page_in_bio)
> > -				unlock_page(ctx->cur_page);
> > -			put_page(ctx->cur_page);
> > -			ctx->cur_page = NULL;
> > +		if (ctx->cur_folio &&
> > +		    offset_in_folio(ctx->cur_folio, iter->pos + done) == 0) {
> > +			if (!ctx->cur_folio_in_bio)
> > +				folio_unlock(ctx->cur_folio);
> > +			ctx->cur_folio = NULL;
> 
> Where did the put_page here disappear to?

I'll put that explanation in the changelog:

Handle folios of arbitrary size instead of working in PAGE_SIZE units.
readahead_folio() puts the page for you, so this is not quite a mechanical
change.

---

The reason for making that change is that I messed up when introducing the
readahead() operation.  I followed the refcounting rule of ->readpages()
instead of the rule of ->readpage().  For a successful readahead, we have
two more atomic operations than necessary.  I want to fix that, and
this seems like a good opportunity to do it.  Once all filesystems are
converted to call readahead_folio(), we can remove the extra get_page()
and put_page().

I did put an explanation of that in commit 9bf70167e3c6, but it's not
reasonable to expect reviewers to remember that when reviewing changes
to their filesystem's readahead, so I'll be sure to mention it in any
future conversion's changelogs.

    mm/filemap: Add readahead_folio()

    The pointers stored in the page cache are folios, by definition.
    This change comes with a behaviour change -- callers of readahead_folio()
    are no longer required to put the page reference themselves.  This matches
    how readpage works, rather than matching how readpages used to work.

