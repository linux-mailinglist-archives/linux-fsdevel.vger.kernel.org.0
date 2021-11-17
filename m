Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801DD45488F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 15:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhKQOYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 09:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbhKQOXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:23:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA6C061202;
        Wed, 17 Nov 2021 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QxDXKUsIeeQXsGJtxCK0ye+WBei0gFIht+c8mPpLNOo=; b=l6dxzR9cDj6QFjwoGMhRQ/U0Z4
        Qe0rySRzKDd/K0ZR0eOeUvPK/3zwakcv4THeVD4DG+2t4KDRgxXsrXdvHOAkCDGdICcsDIh9t9x1q
        2kmePETjUPgHH15X8puTNr+0qJ8w4K06ZQkiXxnq2IlfSg6SVyCLR5uVudXU1/X/CPa/wJXKmJFHv
        o8LONHFdQk6HJxSuEiflfjUW48zYwvp5YeD8FMiMqUWQR70yiOohKLA4zRFIoFK8PyzLbx8zZT9X4
        oX5htLNvZjB/z0hLPUnbC8KfHWDpTt8htYVZ3F5eqsPJl015nD2ryaoDBXmvBJ9dklCZgOs0bIG3m
        8MjZS6aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnLn6-007fSa-8K; Wed, 17 Nov 2021 14:20:00 +0000
Date:   Wed, 17 Nov 2021 14:20:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <YZUPkCMO6NbGYLjG@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
 <20211117022424.GJ24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117022424.GJ24307@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 06:24:24PM -0800, Darrick J. Wong wrote:
> On Mon, Nov 08, 2021 at 04:05:42AM +0000, Matthew Wilcox (Oracle) wrote:
> > The zero iterator can work in folio-sized chunks instead of page-sized
> > chunks.  This will save a lot of page cache lookups if the file is cached
> > in multi-page folios.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> hch's dax decoupling series notwithstanding,
> 
> Though TBH I am kinda wondering how the two of you plan to resolve those
> kinds of differences -- I haven't looked at that series, though I think
> this one's been waiting in the wings for longer?

I haven't looked at that series either

> Heck, I wonder how Matthew plans to merge all this given that it touches
> mm, fs, block, and iomap...?

I'm planning on sending a pull request to Linus on Monday for the first
few patches in this series:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next

Then I was hoping you'd take the block + fs/buffer + iomap pieces for
the next merge window.

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks!  Going through and collecting all these now ...
