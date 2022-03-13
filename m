Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22354D7755
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiCMRpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 13:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiCMRpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:45:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960AC6A;
        Sun, 13 Mar 2022 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8WaLUxEMAmKD1PyvGvzEfiMzsa7oG2hzz2C4QO1OOmM=; b=ZsuLdm9LdWzxx1j36OnlYpQ9Im
        QICWy6sxm1DecdXa56e/3I6nWwylyYvp5MrVRDSVbMFkgRRwioFWu8kf5DcjVZQWT8rCcVZ8gcobh
        AtgwgrLCifo45OV8+0Q2yzG0z0uzNwN7FglbFXXaG7EL8FFipD9nm+BCvz6fEPv7MaaucWLoOiKZe
        b5Q2CZmYyN86KMnsUggzS/RRxHdz4MNSLYTLqHng76n9HuLTYWHzN773OVPjNHqUSLWzOjZ9jEyz8
        vRJj0Bxe6ZFkSPNY1Js/2W7oYUMxHOB/irWU2J5grrQA3tLVfnXMDQHR1YzlB3jVs/CJCxgzwnYuS
        ++U05xHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTSGq-003NAF-9z; Sun, 13 Mar 2022 17:44:44 +0000
Date:   Sun, 13 Mar 2022 17:44:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: Better read bio error granularity?
Message-ID: <Yi4tjPfXd6ZkRmbW@casper.infradead.org>
References: <88a5d138-68b0-da5f-8b08-5ddf02fff244@gmx.com>
 <Yi3NkBf0EUiG2Ys2@casper.infradead.org>
 <d8ea4246-8271-d3c4-2e4d-70d2c1369a05@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ea4246-8271-d3c4-2e4d-70d2c1369a05@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 13, 2022 at 07:03:39PM +0800, Qu Wenruo wrote:
> > Specifically for the page cache (which I hope is what you meant by
> > "page error status", because we definitely can't use that for DIO),
> 
> Although what I exactly mean is PageError flag.
> 
> For DIO the pages are not mapping to any inode, but it shouldn't prevent
> us from using PageError flag I guess?

For DIO, *it is not your page*.  It belongs to somebody else, and you
can't even look at the flags, or the ->mapping, or anything, really.
You have a refcount on the page to prevent it from going away, but the
only thing you can do to the page is use its address and put your refcount
when you're done with it.  It might be an anonymous page, the ZERO_PAGE,
a pagecache page for another filesystem, a pagecache page for your own
filesystem, or even a pagecache page for the same file you're writing to.
The DIO might only be 512-byte aligned, so different parts of the page can
be being written to by different DIOs, or parts or the entire page might
be being read by multiple DIOs.  It might be registered to an RDMA device.
I haven't been keeping up, but I think it's even possible that the page
of memory might be on a graphics card.

> > the intent is that ->readahead can just fail and not set any of the
> > pages Uptodate.  Then we come along later, notice there's a page in
> > the cache and call ->readpage on it and get the error for that one
> > page.  The other 31 pages should read successfully.
> 
> This comes a small question, what is prevent the fs to submit a large
> bio containing the 32 pages again, other than reading them page by page?
> 
> Just because of that page is there, but not Uptodate?

This would be a bad idea.  Pages can be !Uptodate and Dirty, if they've
been partially written by a block-aligned write.  So mindlessly
expanding a read of a single page to be a read of multiple pages will
result in data loss.  Also we might not have pages in
the page cache for the surrounding pages, and we might be low enough on
memory that we can't allocate them.  And pages have to be locked before
we do I/O.  They have to be locked in order of file index, so you would
need to cope with trylocking the pages before this one and those
trylocks maybe failing.

In short, this would be prohibitively complex.

> > 
> > (There's an awkward queston to ask about large folios here, and what
> > we might be able to do around sub-folio or even sub-page or sub-block
> > reads that happen to not touch the bytes which are in an error region,
> > but let's keep the conversation about pages for now).
> > 
> Yeah, that can go crazy pretty soon.
> 
> Like iomap or btrfs, they all use page::private to store extra bitmaps
> for those cases, thus it really impossible to use PageError flag.
> Thus I intentionally skip them here.

I'm actually looking to get rid of PageError, but I think the other
points stand by themselves even without that intention ;-)

> Thank you very much for the quick and helpful reply,

You're welcome!  Thanks for starting the discussion rather than rushing
off to implement it ;-)
