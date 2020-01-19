Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E569141CE8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 08:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgASH6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 02:58:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgASH6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 02:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N+YdFKhWavAVlRXTIVt/VMOYgs6+bw78jRCCgHPX49U=; b=cnpOgTxq6/Xz/M9FKSsXmVlV9
        9zFCg83sM54zdtEz2Y58AHRa35UmzHkHnhBqaPr8CXR/O5hjWKMlGzLxG8RU1YbtTGQZ+udBVj6JO
        0PJ6n64TQIyp2NpZ3duUtFWMQW10V9B51+EJCQw6D832tbnv9TUoXgAdWOYvvvMuPlfK1pl55OGcT
        Bs4ODrDJ8hmz6Fltuc3w/xO9+cTUmtIGp1aqqmh1gawiikfXhU4IZK+4DpuB3nCzf+dOXcIVImvM2
        BxHjTDdDk22xQKeFg1xqTlqhaIki3RTnsILGLSxvKZHof1cHGoe2C7bzlLZmzd84OMtjfSfMfF/DM
        PMzpnfhBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it5TY-0007CL-Hv; Sun, 19 Jan 2020 07:58:28 +0000
Date:   Sat, 18 Jan 2020 23:58:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200119075828.GA4147@bombadil.infradead.org>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200118230826.GA5583@bombadil.infradead.org>
 <f5328338-1a2d-38b4-283f-3fb97ad37133@huawei.com>
 <20200119014213.GA16943@bombadil.infradead.org>
 <64d617cc-e7fe-6848-03bb-aab3498c9a07@huawei.com>
 <20200119061402.GA7301@bombadil.infradead.org>
 <fafa0550-184c-e59c-9b79-bd5d716a20cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fafa0550-184c-e59c-9b79-bd5d716a20cc@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 02:55:14PM +0800, yukuai (C) wrote:
> On 2020/1/19 14:14, Matthew Wilcox wrote:
> > I don't understand your reasoning here.  If another process wants to
> > access a page of the file which isn't currently in cache, it would have
> > to first read the page in from storage.  If it's under readahead, it
> > has to wait for the read to finish.  Why is the second case worse than
> > the second?  It seems better to me.
> 
> Thanks for your response! My worries is that, for example:
> 
> We read page 0, and trigger readahead to read n pages(0 - n-1). While in
> another thread, we read page n-1.
> 
> In the current implementation, if readahead is in the process of reading
> page 0 - n-2,  later operation doesn't need to wait the former one to
> finish. However, later operation will have to wait if we add all pages
> to page cache first. And that is why I said it might cause problem for
> performance overhead.

OK, but let's put some numbers on that.  Imagine that we're using high
performance spinning rust so we have an access latency of 5ms (200
IOPS), we're accessing 20 consecutive pages which happen to have their
data contiguous on disk.  Our CPU is running at 2GHz and takes about
100,000 cycles to submit an I/O, plus 1,000 cycles to add an extra page
to the I/O.

Current implementation: Allocate 20 pages, place 19 of them in the cache,
fail to place the last one in the cache.  The later thread actually gets
to jump the queue and submit its bio first.  Its latency will be 100,000
cycles (20us) plus the 5ms access time.  But it only has 20,000 cycles
(4us) to hit this race, or it will end up behaving the same way as below.

New implementation: Allocate 20 pages, place them all in the cache,
then takes 120,000 cycles to build & submit the I/O, and wait 5ms for
the I/O to complete.

But look how much more likely it is that it'll hit during the window
where we're waiting for the I/O to complete -- 5ms is 1250 times longer
than 4us.

If it _does_ get the latency benefit of jumping the queue, the readahead
will create one or two I/Os.  If it hit page 18 instead of page 19, we'd
end up doing three I/Os; the first for page 18, then one for pages 0-17,
and one for page 19.  And that means the disk is going to be busy for
15ms, delaying the next I/O for up to 10ms.  It's actually beneficial in
the long term for the second thread to wait for the readahead to finish.

Oh, and the current ->readpages code has a race where if the page tagged
with PageReadahead ends up not being inserted, we'll lose that bit,
which means the readahead will just stop and have to restart (because
it will look to the readahead code like it's not being effective).
That's a far worse performance problem.
