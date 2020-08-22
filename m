Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548E424E7DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgHVOYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgHVOYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 10:24:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D399C061573;
        Sat, 22 Aug 2020 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ziVrtHuskBWF9ypal/1WBcVweEFCA3J4y+bn9Uri5QU=; b=dxPZCYC3vPECjpySRlVCFu9lj9
        6KpchwFE5B+EPezXNGoPG+DjRa/cqSS1VIeiz+lPML/ow41KUDczTOTKL1ZJCXna2bqGSpLWD5qx1
        fDRorEOrmoFY5XuqDObl9m7puFKnkzFgnieTCVAzHtoqVXXo8zZ1hAn4QJRxmP0JwDltahGcQUfho
        Pquo0gCPdRm4qkascWIH7i9YSrXNgj8KC9SNftxZJpW7ZSoxfZqp+sB86OaMcLgkofQV/kV5CCMgz
        0X81sf2z82HQQu8zV4z38yjdWKgadChBZz277Vav+mPlRSYkmNVdMpfDeaP7cPsRQqbMjJSoKi+So
        3RHBs8Jg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9URK-0000V1-Kl; Sat, 22 Aug 2020 14:24:14 +0000
Date:   Sat, 22 Aug 2020 15:24:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "yukuai (C)" <yukuai3@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>, darrick.wong@oracle.com,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200822142414.GY17456@casper.infradead.org>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
 <20200819125608.GA24051@xiangao.remote.csb>
 <43dc04bf-17bb-9f15-4f1c-dfd6c47c3fb1@huawei.com>
 <20200821061234.GE31091@infradead.org>
 <20200821133657.GU17456@casper.infradead.org>
 <20200822060345.GD17129@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822060345.GD17129@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 22, 2020 at 07:03:45AM +0100, Christoph Hellwig wrote:
> On Fri, Aug 21, 2020 at 02:36:57PM +0100, Matthew Wilcox wrote:
> > On Fri, Aug 21, 2020 at 07:12:34AM +0100, Christoph Hellwig wrote:
> > > iomap sets PagePrivate if a iomap_page structure is allocated.  Right
> > > now that means for all pages on a file system with a block size smaller
> > > than the page size, although I hope we reduce that scope a little.
> > 
> > I was thinking about that.  Is there a problem where we initially allocate
> > the page with a contiguous extent larger than the page, then later need
> > to write the page to a pair of extents?
> > 
> > If we're doing an unshare operation, then we know our src and dest iomaps
> > and can allocate the iop then.  But if we readahead, we don't necessarily
> > know our eventual dest.  So the conditions for skipping allocating an
> > iop are tricky to be sure we'll never need it.
> 
> So with the current codebase (that is without your THP work that I need
> to re-review) the decision should be pretty easy:
> 
>  - check if block size >= PAGE, and if yes don't allocate
>  - check if the extent fully covers the page, and if yes don't allocate
> 
> Now with THP we'd just need to check the thp size instead of the page
> above and be fine, or do I miss something?

The case I was worrying about:

fill a filesystem so that free space is very fragmented
readahead into a hole
hole is large, don't allocate an iop
writeback the page
don't have an iop, can't track the write count

I'd be fine with choosing to allocate an iop later (and indeed I do that
as part of the THP work).  But does this scenario make you think of any
other corner cases?
