Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9A230677
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgG1JXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgG1JXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:23:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2565BC061794;
        Tue, 28 Jul 2020 02:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4UCo16YZAgo21iB1/5TNNcfQzePmrfQa/TCIlwmqQMw=; b=FlKygivAItuT2wHUokA1ITYibF
        wDLTCx3Jy8n1jR9eiAu1S8KOcJaTue2PCQRreXwNhzbUZ+xz1y3Js2FwQ6fJOF/g5WhKk3g8QUe1p
        QAt5WHGjP7xvK/S9gvVOHHeIKRQcL3bjMNBMuTNL+uDloOxJUyz9h+RV5xkhdEChPnzs8UvuNBEr6
        OIs4BLl1kzrSi8ETKyjIc32l4MSpwvEm8CU3Qkn8GO7Czgg4pH7/Yabc5psLJsQtL8NO/gqvuY76s
        Y9BuaM0RR/TFpRMLES6Sjwmh/2P+rzsNdy8Yy3BtH/OR4P1eAMiDdsKoNIW4aEbp/hwThxIrBSoBo
        FOIeZmmA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0Lp7-0000ER-2w; Tue, 28 Jul 2020 09:23:01 +0000
Date:   Tue, 28 Jul 2020 10:23:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Ensure iop->uptodate matches PageUptodate
Message-ID: <20200728092301.GA32142@infradead.org>
References: <20200726091052.30576-1-willy@infradead.org>
 <20200726230657.GT2005@dread.disaster.area>
 <20200726232022.GH23808@casper.infradead.org>
 <20200726235335.GU2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726235335.GU2005@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:53:35AM +1000, Dave Chinner wrote:
> Yes, I understand the code accepts it can happen; what I dislike is
> code that asserts subtle behaviour can happen, then doesn't describe
> that exactly why/how that condition can occur. And then, because we
> don't know exactly how something happens, we add work arounds to
> hide issues we can't reason through fully. That's .... suboptimal.
> 
> Christoph might know off the top of his head how we get into this
> state. Once we work it out, then we need to add comments...

Unfortunately I don't know offhand.  I'll need to spend some more
quality time with this code first.

> > Way ahead of you
> > http://git.infradead.org/users/willy/pagecache.git/commitdiff/5a1de6fc4f815797caa4a2f37c208c67afd7c20b
> 
> *nod*
> 
> I would suggest breaking that out as a separate cleanup patch and
> not hide is in a patch that contains both THP modifications and bug
> fixes. It stands alone as a valid cleanup.

I'm pretty sure I already suggested that when it first showed up.

That being said I have another somewhat related thing in this area
that I really want to get done before THP support, and maybe I can
offload it to willy:

Currently we always allocate the iomap_page structure for blocksize
< PAGE_SIZE.  While this was easy to implement and a major improvement
over the buffer heads it actually is quite silly, as we only actually
need it if we either have sub-page uptodate state, or have extents
boundaries in the page.  So what I'd like to do is to only actually
allocate it in that case.  By doing the allocation lazy it should also
help to never allocate one that is marked all uptodate from the start.
