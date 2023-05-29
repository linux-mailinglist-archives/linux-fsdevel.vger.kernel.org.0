Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857F0715202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjE2Wo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 18:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjE2Woz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 18:44:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24275C7;
        Mon, 29 May 2023 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5FI/wzhm+Y8jftauZUC1bbB7aZylMU+DZ8dqguf4HHw=; b=lVCx+EOOgR8EUHWnMJUUnMizmb
        qpeRIrMaaJmw3gWTcXROdxD4ejrRR6haLCiqopJoZHAaSjGlshBbG0rlor55uno2GZqbIuvuMrw3i
        A6N/mG0w43572Vm6flIajE2XNsfH2dOKpLm5/+bUGAVpFDsZjLpt3Ep/ANZ+E+rV2fQYMnFUrgvsY
        i8jhUcKZDtT6dcfO+Pw0aSaAg3JG2maxP7tLHxcIGmTz0aOq1Ua9QWYSSwZa09QgOOX+VCSiBE76r
        L1b40/UO1RnyUadIMxhy0r4L7KLJnR6fh+ZzE01Bk4jcmAdgdTTn5Si/O+sgtG56jphR7lIt1A3pk
        ZQmUdIBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3lbd-005kpR-Kh; Mon, 29 May 2023 22:44:49 +0000
Date:   Mon, 29 May 2023 23:44:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Splitting dirty fs folios
Message-ID: <ZHUq4UrM7+wM0lYu@casper.infradead.org>
References: <ZHUEH849ff09pVpf@casper.infradead.org>
 <ZHUppPtjIjXVsacC@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHUppPtjIjXVsacC@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 08:39:32AM +1000, Dave Chinner wrote:
> > Option 5: If the folio is both dirty and !uptodate, just refuse to split
> > it, like if somebody else had a reference on it.  A less extreme version
> > of #4.
> 
> Also seems like a reasonable first step.
> 
> > I may have missed some other option.  Option 5 seems like the least
> > amount of work.
> 
> *nod*
> 
> Overall, I think the best way to approach it is to do the simplest,
> most obviously correct thing first. If/when we observe performance
> problems from the simple approach, then we can decide how to solve
> that via one of the more complex approaches...

So the good news is that Option 5 seems to have no regressions and
the functional part of the patch looks like ...

+++ b/fs/iomap/buffered-io.c
@@ -510,11 +510,6 @@ void iomap_invalidate_folio(struct folio *folio, size_t off
set, size_t len)
                WARN_ON_ONCE(folio_test_writeback(folio));
                folio_cancel_dirty(folio);
                iomap_page_release(folio);
-       } else if (folio_test_large(folio)) {
-               /* Must release the iop so the page can be split */
-               VM_WARN_ON_ONCE_FOLIO(!folio_test_uptodate(folio) &&
-                               folio_test_dirty(folio), folio);
-               iomap_page_release(folio);
        }
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);

I need to modify a few comments and document exactly why this works,
but it seems like a good next step.
