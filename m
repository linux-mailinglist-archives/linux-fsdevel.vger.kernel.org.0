Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208BA2955CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894470AbgJVAtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 20:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436950AbgJVAtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 20:49:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E56DC0613CE;
        Wed, 21 Oct 2020 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QrzozL6sqW5vYMZtN3K+R9LE+6kDlJD77dyJBYxqbOI=; b=gAQr0wgYZsNoYp/Jxj6agcvDTx
        515wMKDVLaZCnGYu1SuKbzHmqql9n3YgNNC05Hq053Ckz8OPZOOIuRYKTYzNz1bBa0XKHFVzBo06v
        BY+auv7WQdwFyc8/rR956Mb7tOflxn3F25od2XoCfxwYapp7OVEL5StjOLgOHgHMhBT3AWRv8oG1k
        pclENd55pZOwFHRzR3dueqwqHv6xVCO9jQAl2pkShBMGkO+cK15NpsZ1crZSzJGtbvsoBKC/EbNqa
        qe6wlh9cfBemaS/EMMK5qAmrUcwv1Wma502bIzvp7ctSSucnvbiVfIdxlO0Emlbn1L7YVWAUjQQWJ
        6jZXS/xA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVOmw-0007BB-RS; Thu, 22 Oct 2020 00:49:06 +0000
Date:   Thu, 22 Oct 2020 01:49:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
Message-ID: <20201022004906.GQ20115@casper.infradead.org>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 08:30:18PM -0400, Qian Cai wrote:
> Today's linux-next starts to trigger this wondering if anyone has any clue.

I've seen that occasionally too.  I changed that BUG_ON to VM_BUG_ON_PAGE
to try to get a clue about it.  Good to know it's not the THP patches
since they aren't in linux-next.

I don't understand how it can happen.  We have the page locked, and then we do:

                        if (PageWriteback(page)) {
                                if (wbc->sync_mode != WB_SYNC_NONE)
                                        wait_on_page_writeback(page);
                                else
                                        goto continue_unlock;
                        }

                        VM_BUG_ON_PAGE(PageWriteback(page), page);

Nobody should be able to put this page under writeback while we have it
locked ... right?  The page can be redirtied by the code that's supposed
to be writing it back, but I don't see how anyone can make PageWriteback
true while we're holding the page lock.

