Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94D28E537
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbgJNRRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgJNRRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:17:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E403C061755;
        Wed, 14 Oct 2020 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JKdSRRpfNq89jLLxix/6a/bIeQwXlNzL7+kPc2YPR8I=; b=kO7907DGs2rDxMdhsiNKzXLEKQ
        oAgh7btZFkwpTBrbb2YuVotH6KkzSqhIDQit0yAlgDaGlEtDqjFQj+rHej8DMeUGzGkG9T2yfxnPL
        EmvG//DB4dEoLxC21g5US6G/PJRaq9UmzQyJrmFDM20z6LukP0hIOms+dJjNFnNlrDTI3YdFIKw6O
        iYMmkXQFfR5KrbXCm8T9m4rBdFVdBsDIWUAHtKJKdJxCsCfmlV2haVJuqrQ8mNbh9BkcpDIfiVB+c
        AuXkQC37FbqDR47edGh/7ncgeP6caYk6jFJsXpMqzRpV7vtvfjtzBpSfAKyGSaU2NiL9tTILB5hbn
        YF6vLcPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSkOY-0004Id-92; Wed, 14 Oct 2020 17:16:58 +0000
Date:   Wed, 14 Oct 2020 18:16:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 01/14] fs: Support THPs in vfs_dedupe_file_range
Message-ID: <20201014171658.GN20115@casper.infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-2-willy@infradead.org>
 <20201014161216.GE9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014161216.GE9832@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:12:16AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 14, 2020 at 04:03:44AM +0100, Matthew Wilcox (Oracle) wrote:
> > We may get tail pages returned from vfs_dedupe_get_page().  If we do,
> > we have to call page_mapping() instead of dereferencing page->mapping
> > directly.  We may also deadlock trying to lock the page twice if they're
> > subpages of the same THP, so compare the head pages instead.

> >  static void vfs_lock_two_pages(struct page *page1, struct page *page2)
> >  {
> > +	page1 = thp_head(page1);
> > +	page2 = thp_head(page2);
> 
> Hmm, is this usage (calling thp_head() to extract the head page from an
> arbitrary page reference) a common enough idiom that it doesn't need a
> comment saying why we need the head page?

It's pretty common.  Lots of times it gets hidden inside macros,
and sometimes it gets spelled as 'compound_head' instead of
thp_head.  The advantage of thp_head() is that it compiles away if
CONFIG_TRANSPARENT_HUGEPAGE is disabled, while compound pages always
exist.

> I'm asking that genuinely-- thp_head() is new to me but maybe it's super
> obvious to everyone else?  Or at least the mm developers?  I suspect
> that might be the case....?

thp_head is indeed new.  It was merged in August this year, partly in
response to Dave Chinner getting annoyed at the mixing of metaphors --
some things were thp_*, some were hpage_* and some were compound_*.
Now everything is in the thp_* namespace if it refers to THPs.

> Also, I was sort of thinking about sending a patch to Linus at the end
> of the merge window moving all the remap/clone/dedupe common code to a
> separate file to declutter fs/read_write.c and mm/filemap.c.  Does that
> sound ok?

I don't think that would bother me at all.
