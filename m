Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50B90641
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfHPQ5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 12:57:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfHPQ5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Byk+Z7fbnw+hJ1A3SXtpTv1x5R988Tvo9jglZrJEceo=; b=nh4nbtZQHdQyyXyIZ8CCXW9B/
        Q6+zu6EJF1Xcn2mr2x72Atv+5kyKcdBI/cQxIlXqO08bN0XW2egrk7fH6vSHBn3lhwVqWZD1lX5gZ
        kAuVdmlTDHvWxAhYd49msq4tZtygFrf1K33cYSMo5o+UxWyufnldWB4yGSe9jgRpoUaE0XY3lJAOV
        lDl9hEMplWHuTax+CfUKDZqJ+uv/mJmL6JDSorK2vF/U7Q5ySksfd9GeyxtwzBFkmwdEL5256bNHH
        nDTraS8sQ+MkuD3csxYuOFrErbyxU15Tg3ZDjYNqMk6Cc4inid54cX9uvP9/ucJETGxCMPMmjkCK8
        OPN4XfqZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyfXL-0005vL-Vi; Fri, 16 Aug 2019 16:57:11 +0000
Date:   Fri, 16 Aug 2019 09:57:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fdmanana@gmail.com, gaoxiang25@huawei.com
Subject: Re: [PATCH v4] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190816165711.GC18474@bombadil.infradead.org>
References: <20190815164940.GA15198@magnolia>
 <20190815181804.GB18474@bombadil.infradead.org>
 <20190816064753.GD2024@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816064753.GD2024@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:47:53PM -0700, Christoph Hellwig wrote:
> On Thu, Aug 15, 2019 at 11:18:04AM -0700, Matthew Wilcox wrote:
> > But I don't think read_mapping_page() can return a page which doesn't have
> > PageUptodate set.  Follow the path down through read_cache_page() into
> > do_read_cache_page().
> 
> read_mapping_page() can't, but I think we need the check after the 
> lock_page still.

The current code checks before locking the page:

        if (!PageUptodate(page)) {
                put_page(page);
                return ERR_PTR(-EIO);
        }
        lock_page(page);

so the race with clearing Uptodate already existed.

XFS can ClearPageUptodate if it gets an error while doing writeback of
a dirty page.  But we shouldn't be able to get a dirty page.  Before we
get to this point, we call filemap_write_and_wait_range() while holding
the inode's modification lock.

So I think we can't see a !Uptodate page, but of course I'd be happy to
see a sequence of events that breaks this reasoning.
