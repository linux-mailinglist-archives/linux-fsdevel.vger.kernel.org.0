Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF3296372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902434AbgJVRMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902445AbgJVRMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:12:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E4C0613CE;
        Thu, 22 Oct 2020 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HuLFfKCiL+7vaRCur/wWQWK6xvpLJsr5bSM5cuDLJto=; b=N1wmpof0oY1B9VcE0NiPkP5PYs
        Vb+1DJXwCpWZpQxrWFmlc702rqpjKzM0+ch1HuJPkoiVTgLZyMDmf5I7JtHTDzkuSyoeCICE6joMN
        9RRuOD1i43hu5o8/xsUlzjF8GKWxUqWuL6/LXkRZCuc5yyz/dYS+OX2+lgtCjD11WPdfaNINad527
        P5ztfx35J7IjGogchCHa5nu89JrCvZdw707IJT6qfw8O/bKw0ENmCQcB5Uanbp0C3aNg/0gfoFv3w
        mCA+ndHQPNmpHNdZtX7y40hCKMmspJYObnpDGgFSvQ+AxDLsFIMLmRPDclj51Nrt+ny8J+yv1L+fo
        mTciSItw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVe8p-0005GB-Ip; Thu, 22 Oct 2020 17:12:43 +0000
Date:   Thu, 22 Oct 2020 18:12:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
Message-ID: <20201022171243.GX20115@casper.infradead.org>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
 <20201022004906.GQ20115@casper.infradead.org>
 <7ec15e2710db02be81a6c47afc57abed4bf8016c.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec15e2710db02be81a6c47afc57abed4bf8016c.camel@lca.pw>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 11:35:26AM -0400, Qian Cai wrote:
> On Thu, 2020-10-22 at 01:49 +0100, Matthew Wilcox wrote:
> > On Wed, Oct 21, 2020 at 08:30:18PM -0400, Qian Cai wrote:
> > > Today's linux-next starts to trigger this wondering if anyone has any clue.
> > 
> > I've seen that occasionally too.  I changed that BUG_ON to VM_BUG_ON_PAGE
> > to try to get a clue about it.  Good to know it's not the THP patches
> > since they aren't in linux-next.
> > 
> > I don't understand how it can happen.  We have the page locked, and then we
> > do:
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
> It happened again on today's linux-next:
> 
> [ 7613.579890][T55770] page:00000000a4b35e02 refcount:3 mapcount:0 mapping:00000000457ceb87 index:0x3e pfn:0x1cef4e
> [ 7613.590594][T55770] aops:xfs_address_space_operations ino:805d85a dentry name:"doio.f1.55762"
> [ 7613.599192][T55770] flags: 0xbfffc0000000bf(locked|waiters|referenced|uptodate|dirty|lru|active)
> [ 7613.608596][T55770] raw: 00bfffc0000000bf ffffea0005027d48 ffff88810eaec030 ffff888231f3a6a8
> [ 7613.617101][T55770] raw: 000000000000003e 0000000000000000 00000003ffffffff ffff888143724000
> [ 7613.625590][T55770] page dumped because: VM_BUG_ON_PAGE(PageWriteback(page))
> [ 7613.632695][T55770] page->mem_cgroup:ffff888143724000

Seems like it reproduces for you pretty quickly.  I have no luck ;-(

Can you add this?

+++ b/mm/page-writeback.c
@@ -2774,6 +2774,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
        struct address_space *mapping = page_mapping(page);
        int ret, access_ret;
 
+       VM_BUG_ON_PAGE(!PageLocked(page), page);
        lock_page_memcg(page);
        if (mapping && mapping_use_writeback_tags(mapping)) {
                XA_STATE(xas, &mapping->i_pages, page_index(page));

This is the only place (afaict) that sets PageWriteback, so that will
tell us whether someone is setting Writeback without holding the lock,
or whether we're suffering from a spurious wakeup.

