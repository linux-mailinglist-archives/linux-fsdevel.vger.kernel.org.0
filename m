Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04152298D95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1737268AbgJZNON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 09:14:13 -0400
Received: from casper.infradead.org ([90.155.50.34]:39424 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406990AbgJZNOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lta2H3+0F6XrQvumNGK2SyvRq8bs5VV2UbSLAwhlWGE=; b=p3vct6D2uTGzWeM0J29gXSW59P
        Z6fYSCZYhXh0jmldeAg2pwv82tIHgQj8ajZl5XmjJRSfxawBd6GKMI0wqaI08FmgIoie/EojZTMEx
        uABPSw22X3nZcq+0buG1zj0qm42j28oyNBAmWEHCd1lR29iqRsYcm4DkaskFSETEDMNIDRHFpX2bA
        m32PRa9MPYqUMrkjsw0m0m+c+3KQ0ErG0bhBM8q0cGUtP0P1CITvKJmkUGeGSEJ7dEyl1SIH4w2ye
        SOyw39zOAAnEpj8qYS7HmLsuVxKxps235DF6V/0Gu03ETPRaEunyWlc1oRdrTSTeORAjJp/Ay4awP
        wF9ysFdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX2Jt-00066K-9f; Mon, 26 Oct 2020 13:13:53 +0000
Date:   Mon, 26 Oct 2020 13:13:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Qian Cai <cai@lca.pw>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
Message-ID: <20201026131353.GP20115@casper.infradead.org>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
 <20201022004906.GQ20115@casper.infradead.org>
 <20201026094948.GA29758@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026094948.GA29758@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:49:48AM +0100, Jan Kara wrote:
> On Thu 22-10-20 01:49:06, Matthew Wilcox wrote:
> > On Wed, Oct 21, 2020 at 08:30:18PM -0400, Qian Cai wrote:
> > > Today's linux-next starts to trigger this wondering if anyone has any clue.
> > 
> > I've seen that occasionally too.  I changed that BUG_ON to VM_BUG_ON_PAGE
> > to try to get a clue about it.  Good to know it's not the THP patches
> > since they aren't in linux-next.
> > 
> > I don't understand how it can happen.  We have the page locked, and then we do:
> > 
> >                         if (PageWriteback(page)) {
> >                                 if (wbc->sync_mode != WB_SYNC_NONE)
> >                                         wait_on_page_writeback(page);
> >                                 else
> >                                         goto continue_unlock;
> >                         }
> > 
> >                         VM_BUG_ON_PAGE(PageWriteback(page), page);
> > 
> > Nobody should be able to put this page under writeback while we have it
> > locked ... right?  The page can be redirtied by the code that's supposed
> > to be writing it back, but I don't see how anyone can make PageWriteback
> > true while we're holding the page lock.
> 
> FWIW here's very similar report for ext4 [1] and I strongly suspect this
> started happening after Linus' rewrite of the page bit waiting logic. Linus
> thinks it's preexisting bug which just got exposed by his changes (which is
> possible). I've been searching a culprit for some time but so far I failed.
> It's good to know it isn't ext4 specific so we should be searching in the
> generic code ;). So far I was concentrating more on ext4 bits...
> 
> 								Honza
> 
> [1] https://lore.kernel.org/lkml/000000000000d3a33205add2f7b2@google.com/

Oh good, I was wondering if it was an XFS bug ;-)

I hope Qian gets it to reproduce soon with the assert because that will
tell us whether it's a spurious wakeup or someone calling SetPageWriteback
without holding the page lock.
