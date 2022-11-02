Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FCA615ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKBJE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKBJES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:04:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BC29343;
        Wed,  2 Nov 2022 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RC1G2wyQRnwjxQ7LmWyOKL4toH6YzFwXRb5xKhPM3q0=; b=iBV6EUoRGIFcxtAJY+CRI/wveu
        Ke8HJK3bFYjjGHrLoEMGU0XAX1qpzT6JAxOoIDr0df8cSbl+j6KCHuIKxsGWkBvilNOzZY9yIDHqv
        +PbM7eIFMWCJkgj5z/tV38MVxkanYTMIfQBxw/99Ng+QWHjqFfGR9Ytf6oCj9KgC2OiJlnWF/78YY
        U3ijoEkzaTTwcG/eXNaVWo3U8UgANqqkxIuGVjSRssK52NVNWm/E312mGLL7n8sXHmzheWwAzvYYZ
        1i7tgHCEhGXpsLzfCnGWQUZzm7aFLKXrqLu70WmymP/BL2xTMxssOPE99oxXxm3ERzoXbNJB9D09K
        K3XnaC6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq9eR-009MOI-EI; Wed, 02 Nov 2022 09:03:11 +0000
Date:   Wed, 2 Nov 2022 02:03:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <Y2IyTx0VwXMxzs0G@infradead.org>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y19EXLfn8APg3adO@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 03:43:24AM +0000, Matthew Wilcox wrote:
> I agree that bufferheads do bottom-up dirty tracking, but I don't think
> that what Ritesh is doing here is bottom-up dirty tracking.  Buffer
> heads expose an API to dirty a block, which necessarily goes bottom-up.
> There's no API here to dirty a block.  Instead there's an API to dirty
> a range of a folio, so we're still top-down; we're just keeping track
> of it in a more precise way.

Agreed.

> If there is any dirty region, the folio must be marked dirty (otherwise
> we'll never know that it needs to be written back).  The interesting
> question (as your paragraph below hints) is whether removing the dirty
> part of a folio from a file marks the folio clean.  I believe that's
> optional, but it's probably worth doing.

Also agreed.

> > What happens with direct extent manipulation like fallocate()
> > operations? These invalidate the parts of the page cache over the
> > range we are punching, shifting, etc, without interacting directly
> > with iomap, so do we now have to ensure that the sub-folio dirty
> > regions are also invalidated correctly? i.e. do functions like
> > xfs_flush_unmap_range() need to become iomap infrastructure so that
> > they can update sub-folio dirty ranges correctly?
> 
> I'm slightly confused by this question.  As I understand the various
> fallocate operations, they start by kicking out all the folios affected
> by the operation (generally from the start of the operation to EOF),
> so we'd writeback the (dirty part of) folios which are dirty, then
> invalidate the folios in cache.  I'm not sure there's going to be
> much difference.

Yes.  As far as I can tell all pagecache manipulation for the
fallocate operations is driven by the file system and it is
only done by those the punch/zero/move ranges.  The file system
then goes though the normal pagecache truncate helpers rounded to
the block size, which through the ops should do the right thing.


> Yes.  This is also going to be a performance problem.  Marking a folio as
> dirty is no longer just setting the bit in struct folio and the xarray
> but also setting all the bits in iop->state.  Depending on the size
> of the folio, and the fs blocksize, this could be quite a lot of bits.
> eg a 2MB folio with a 1k block size is 2048 bits (256 bytes, 6 cachelines
> (it dirties the spinlock in cacheline 0, then the bitmap occupies 3 full
> cachelines and 2 partial ones)).

We can always optimize by having a bit for the fairly common all dirty
case and only track and look at the array if that is no the case.

> filesystems right now.  Dave Howells' netfs infrastructure is trying
> to solve the problem for everyone (and he's been looking at iomap as
> inspiration for what he's doing).

Btw, I never understod why the network file systems don't just use
iomap.  There is nothing block specific in the core iomap code.
