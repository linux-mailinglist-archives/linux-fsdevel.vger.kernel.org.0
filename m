Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EAB2989C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768627AbgJZJtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 05:49:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:47962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768620AbgJZJtu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:49:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E924B2CB;
        Mon, 26 Oct 2020 09:49:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E72A81E10F5; Mon, 26 Oct 2020 10:49:48 +0100 (CET)
Date:   Mon, 26 Oct 2020 10:49:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
Message-ID: <20201026094948.GA29758@quack2.suse.cz>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
 <20201022004906.GQ20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022004906.GQ20115@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-10-20 01:49:06, Matthew Wilcox wrote:
> On Wed, Oct 21, 2020 at 08:30:18PM -0400, Qian Cai wrote:
> > Today's linux-next starts to trigger this wondering if anyone has any clue.
> 
> I've seen that occasionally too.  I changed that BUG_ON to VM_BUG_ON_PAGE
> to try to get a clue about it.  Good to know it's not the THP patches
> since they aren't in linux-next.
> 
> I don't understand how it can happen.  We have the page locked, and then we do:
> 
>                         if (PageWriteback(page)) {
>                                 if (wbc->sync_mode != WB_SYNC_NONE)
>                                         wait_on_page_writeback(page);
>                                 else
>                                         goto continue_unlock;
>                         }
> 
>                         VM_BUG_ON_PAGE(PageWriteback(page), page);
> 
> Nobody should be able to put this page under writeback while we have it
> locked ... right?  The page can be redirtied by the code that's supposed
> to be writing it back, but I don't see how anyone can make PageWriteback
> true while we're holding the page lock.

FWIW here's very similar report for ext4 [1] and I strongly suspect this
started happening after Linus' rewrite of the page bit waiting logic. Linus
thinks it's preexisting bug which just got exposed by his changes (which is
possible). I've been searching a culprit for some time but so far I failed.
It's good to know it isn't ext4 specific so we should be searching in the
generic code ;). So far I was concentrating more on ext4 bits...

								Honza

[1] https://lore.kernel.org/lkml/000000000000d3a33205add2f7b2@google.com/

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
