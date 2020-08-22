Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5024E5C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 08:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgHVGD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 02:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVGD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:03:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10940C061573;
        Fri, 21 Aug 2020 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ZgY/U1iVg+3jisCfQNlmsyKgaxMuNdaR6xO9fxM6gE=; b=YFinHTUTd5c0dUeAhB8oS/o0nb
        Itis78LvLaQxSkFfwPsWiCcXiVlFj9DSfXcNhyakT3bkK3x1gMCAhXAHPLVmhbteQegFfNLnXC/u6
        nKaxul1BmV4yE3QwDdT2shsiKZxIRVLa6bnk0zl7Vdzi05vYeIV11RRrJQ5HDZmUsyrlyp8haFXPZ
        dEwvzXFuw5+GOqRKx+9tfd4TlvW64imhfTBw/moKqXojcy5rwj3ThhP6wr+jw8kt5NA2vEY6oIhez
        dJ0AdmO7NPX90CpbhWiMOhRMmgDtiC/4dNa2SFKW85okoQPWu34EzhYMXT5RVTgtl5dv/SJ4AMq0k
        af+azxig==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9Mcz-0004to-L3; Sat, 22 Aug 2020 06:03:45 +0000
Date:   Sat, 22 Aug 2020 07:03:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>, darrick.wong@oracle.com,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200822060345.GD17129@infradead.org>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
 <20200819125608.GA24051@xiangao.remote.csb>
 <43dc04bf-17bb-9f15-4f1c-dfd6c47c3fb1@huawei.com>
 <20200821061234.GE31091@infradead.org>
 <20200821133657.GU17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821133657.GU17456@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 02:36:57PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 21, 2020 at 07:12:34AM +0100, Christoph Hellwig wrote:
> > iomap sets PagePrivate if a iomap_page structure is allocated.  Right
> > now that means for all pages on a file system with a block size smaller
> > than the page size, although I hope we reduce that scope a little.
> 
> I was thinking about that.  Is there a problem where we initially allocate
> the page with a contiguous extent larger than the page, then later need
> to write the page to a pair of extents?
> 
> If we're doing an unshare operation, then we know our src and dest iomaps
> and can allocate the iop then.  But if we readahead, we don't necessarily
> know our eventual dest.  So the conditions for skipping allocating an
> iop are tricky to be sure we'll never need it.

So with the current codebase (that is without your THP work that I need
to re-review) the decision should be pretty easy:

 - check if block size >= PAGE, and if yes don't allocate
 - check if the extent fully covers the page, and if yes don't allocate

Now with THP we'd just need to check the thp size instead of the page
above and be fine, or do I miss something?
