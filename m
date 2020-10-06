Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AC9284D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 16:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgJFOHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgJFOHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:07:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD1C061755;
        Tue,  6 Oct 2020 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IleYZyF5Ir/ZDhCRg7zB0cdpd4ApTbAF/++Iy+fWTy4=; b=VXRTSrS6/tJHYjphWFj2B5dxiL
        /OZ420EZNgmrV3oA+UijYNbjrgcbMfhxj/tH3uaiYjqN579z08MREzFtZZwjrwBXfxbHERs8eW7lW
        uMs5FIFZaU3Oj6/g1JmgIe/Bye/iSXy7YQOUslvusr0/P0v9jfnfMdPPlVRzHW+HKDkeU0DZA2PTm
        kxfg+WDiZidvXqLWgxkZ5SRstqZu3COnnzjFp527NNE29UKmIojoBQ0+S4WsPXu15KsEKok10vPHN
        h7o3XX1d+4oJ+uSX4cb0mu4+78OK/hKthyehlMEaE/ajT7JXPRMFkySr/ICirmWeXIz5SlZhL83L6
        cEfWqFRg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPncf-0004P7-2J; Tue, 06 Oct 2020 14:07:21 +0000
Date:   Tue, 6 Oct 2020 15:07:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <20201006140720.GQ20115@casper.infradead.org>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
 <20201006035537.GD49524@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006035537.GD49524@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 05, 2020 at 08:55:37PM -0700, Darrick J. Wong wrote:
> On Mon, Oct 05, 2020 at 11:21:02AM -0400, Brian Foster wrote:
> > We've had reports of soft lockup warnings in the iomap ioend
> > completion path due to very large bios and/or bio chains. Divert any
> > ioends with 256k or more pages to process to the workqueue so
> > completion occurs in non-atomic context and can reschedule to avoid
> > soft lockup warnings.
> 
> Hmmmm... is there any way we can just make end_page_writeback faster?

There are ways to make it faster.  I don't know if they're a "just"
solution ...

1. We can use THPs.  That will reduce the number of pages being operated
on.  I hear somebody might have a patch set for that.  Incidentally,
this patch set will clash with the THP patchset, so one of us is going to
have to rebase on the other's work.  Not a complaint, just acknowledging
that some coordination will be needed for the 5.11 merge window.

2. We could create end_writeback_pages(struct pagevec *pvec) which
calls a new test_clear_writeback_pages(pvec).  That could amortise
taking the memcg lock and finding the lruvec and taking the mapping
lock -- assuming these pages are sufficiently virtually contiguous.
It can definitely amortise all the statistics updates.

3. We can make wake_up_page(page, PG_writeback); more efficient.  If
you can produce this situation on demand, I had a patch for that which
languished due to lack of interest.

https://lore.kernel.org/linux-fsdevel/20200416220130.13343-1-willy@infradead.org/

