Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619BF19AAB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgDALXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 07:23:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgDALXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cPYHA5h55sUofdLyOc+e5uMRth/wMXd5HGy9c8ItIRM=; b=keVMiPYBTfEx+ZcmKlCwq1sq0l
        rNBQL7NCGJazCRXmSZHSnxddJzUtqbhY2tm+LkFzILeSkLoSr5Or8iR9/wx+nReA1qZG3aYwTb+3B
        zyLbKF9aRIfJfPzKU7MjhMa1CUaUgzb6JKR3S+NRYpx3SwLIz0kLp6lK6CxwPkmlJBkww0Pe9RCNh
        FLF50hH9kcdKMFX4SXu48CAosCQEkzoS9m0ah0ZDUQxXXICpFVkFzZQLIXiXIQCDJSNsA5jhSH0fI
        Xf9SBnkkC9m3ZBs7EjUDIL59+5Ar+7q3Evlr0v0kzBsMiKsNWGqizsK4gWO6+kdAaH1IIXShcOnvO
        QdZIHQCw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJbSr-0004oA-D8; Wed, 01 Apr 2020 11:23:21 +0000
Date:   Wed, 1 Apr 2020 04:23:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle memory allocation failure in readahead
Message-ID: <20200401112321.GF21484@bombadil.infradead.org>
References: <20200401030421.17195-1-willy@infradead.org>
 <20200401043125.GD56958@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401043125.GD56958@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:31:25PM -0700, Darrick J. Wong wrote:
> On Tue, Mar 31, 2020 at 08:04:21PM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > bio_alloc() can fail when we use GFP_NORETRY.  If it does, allocate
> > a bio large enough for a single page like mpage_readpages() does.
> 
> Why does mpage_readpages() do that?
> 
> Is this a means to guarantee some kind of forward (readahead?) progress?
> Forgive my ignorance, but if memory is so tight we can't allocate a bio
> for readahead then why not exit having accomplished nothing?

As far as I can tell, it's just a general fallback in mpage_readpages().

 * If anything unusual happens, such as:
 *
 * - encountering a page which has buffers
 * - encountering a page which has a non-hole after a hole
 * - encountering a page with non-contiguous blocks
 *
 * then this code just gives up and calls the buffer_head-based read function.

The actual code for that is:

                args->bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
                                        min_t(int, args->nr_pages,
                                              BIO_MAX_PAGES),
                                        gfp);
                if (args->bio == NULL)
                        goto confused;
...
confused:
        if (args->bio)
                args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
        if (!PageUptodate(page))
                block_read_full_page(page, args->get_block);
        else
                unlock_page(page);

As the comment implies, there are a lot of 'goto confused' cases in
do_mpage_readpage().

Ideally, yes, we'd just give up on reading this page because it's
only readahead, and we shouldn't stall actual work in order to reclaim
memory so we can finish doing readahead.  However, handling a partial
page read is painful.  Allocating a bio big enough for a single page is
much easier on the mm than allocating a larger bio (for a start, it's a
single allocation, not a pair of allocations), so this is a reasonable
compromise between simplicity of code and quality of implementation.
