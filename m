Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E113E4909
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 17:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhHIPlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHIPlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:41:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5287BC0613D3;
        Mon,  9 Aug 2021 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C5tc5j1r9B9Lim2QeeQmwl+B6gR1QYx07S9Mr910Nfg=; b=RaEuVIGLD/UzYXuU10S+nuv94P
        TbJyuyTZqiWX7JePYEdXVmezJP0JxUlxFuQ0aB339sb+4kxj4ZJRa6W1ZxlBvs/bTdATReXjQPfpK
        5zMB9GA2wzi6q5p7Bqkm1/41dUQKFxoD2ACuSWv2bNYQJZ+CcckH5IJr2f/hJmSaeVsA+bK6p1FIf
        aBUJarv4te3pYvNZyTgx3RlTT9pr1qSRrct32x0H9rzs9NgHVB8cPW72ilFfhDl2KoQBAXsC61ZHY
        WaPaIp/frQHV71aC3uU+2IxAYuPn2y5hbv0FH4xQY6GZ6vWUaII+F4YRIdvs9fvcRPz/sS/2I7LwZ
        qSbMHV1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD7EF-00B81n-3J; Mon, 09 Aug 2021 15:30:20 +0000
Date:   Mon, 9 Aug 2021 16:30:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuang521@gmail.com>, yukuai3@huawei.com,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>, linux-xfs@vger.kernel.org
Subject: Re: Dirty bits and sync writes
Message-ID: <YRFKB0rBU51O1YpD@casper.infradead.org>
References: <YQlgjh2R8OzJkFoB@casper.infradead.org>
 <YRFAWPdMHp8Wpds/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRFAWPdMHp8Wpds/@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 03:48:56PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 03, 2021 at 04:28:14PM +0100, Matthew Wilcox wrote:
> > Solution 1: Add an array of dirty bits to the iomap_page
> > data structure.  This patch already exists; would need
> > to be adjusted slightly to apply to the current tree.
> > https://lore.kernel.org/linux-xfs/7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com/
> 
> > Solution 2a: Replace the array of uptodate bits with an array of
> > dirty bits.  It is not often useful to know which parts of the page are
> > uptodate; usually the entire page is uptodate.  We can actually use the
> > dirty bits for the same purpose as uptodate bits; if a block is dirty, it
> > is definitely uptodate.  If a block is !dirty, and the page is !uptodate,
> > the block may or may not be uptodate, but it can be safely re-read from
> > storage without losing any data.
> 
> 1 or 2a seems like something we should do once we have lage folio
> support.
> 
> 
> > Solution 2b: Lose the concept of partially uptodate pages.  If we're
> > going to write to a partial page, just bring the entire page uptodate
> > first, then write to it.  It's not clear to me that partially-uptodate
> > pages are really useful.  I don't know of any network filesystems that
> > support partially-uptodate pages, for example.  It seems to have been
> > something we did for buffer_head based filesystems "because we could"
> > rather than finding a workload that actually cares.
> 
> The uptodate bit is important for the use case of a smaller than page
> size buffered write into a page that hasn't been read in already, which
> is fairly common for things like log writes.  So I'd hate to lose this
> optimization.
> 
> > (it occurs to me that solution 3 actually allows us to do IOs at storage
> > block size instead of filesystem block size, potentially reducing write
> > amplification even more, although we will need to be a bit careful if
> > we're doing a CoW.)
> 
> number 3 might be nice optimization.  The even better version would
> be a disk format change to just log those updates in the log and
> otherwise use the normal dirty mechanism.  I once had a crude prototype
> for that.

That's a bit beyond my scope at this point.  I'm currently working on
write-through.  Once I have that working, I think the next step is:

 - Replace the ->uptodate array with a ->dirty array
 - If the entire page is Uptodate, drop the iomap_page.  That means that
   writebacks will write back the entire folio, not just the dirty
   pieces.
 - If doing a partial page write
   - If the write is block-aligned (offset & length), leave the page
     !Uptodate and mark the dirty blocks
   - Otherwise bring the entire page Uptodate first, then mark it dirty

To take an example of a 512-byte block size file accepting a 520 byte
write at offset 500, we currently submit two reads, one for bytes 0-511
and the second for 1024-1535.  We're better off submitting a read for
bytes 0-4095 and then overwriting the entire thing.

But it's still better to do no reads at all if someone submits a write
for bytes 512-1023, or 512-N where N is past EOF.  And I'd preserve
that behaviour.

