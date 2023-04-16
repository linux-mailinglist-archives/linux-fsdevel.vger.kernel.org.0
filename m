Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188A26E390E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDPOHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDPOHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:07:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41701BEE;
        Sun, 16 Apr 2023 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2lY/TOEU604shlpMp7GNPTJiVI9cBfonl1OqK24KXgQ=; b=cf8NXC6uIy4cX5ndKCLS66cBL8
        EaY8AcPjKM3d2zszKLlIFCW7iB8O7jyMYrVZSkVMWLDdlG0ZglUpYWwzqHWHeIWY6QAWEUHBOA/e/
        xDiySoypXs7+aiOdz5u9bubV3usewS9TWfeg/JgHj1qwjDTQlSBNQnNqKW/xpxcDBEdLp+JiWV4oq
        nfw5Tv2B9oGHYis+Aes4PNrQ6k43qtVv7BIsjvo+w8fExz35U0x06WpdT4wWtYKNIrM9k8zdYwTk8
        TV95eAcLZLCqDGq/Jze6CJex5C0225bj+6bnkwf7rbTUc+bdv8vR5l1tqHGTJmXAECE4NUlR/4PNA
        gwS8qH+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1po32T-00AQai-Jl; Sun, 16 Apr 2023 14:07:33 +0000
Date:   Sun, 16 Apr 2023 15:07:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDwBJVmIN3tLFhXI@casper.infradead.org>
References: <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
 <ZDodlnm2nvYxbvR4@casper.infradead.org>
 <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
 <ZDraOHQHqeabyCvN@casper.infradead.org>
 <ZDtPK5Qdts19bKY2@bombadil.infradead.org>
 <ZDtuFux7FGlCMkC3@casper.infradead.org>
 <ZDuHEolre/saj8iZ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDuHEolre/saj8iZ@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 10:26:42PM -0700, Luis Chamberlain wrote:
> On Sun, Apr 16, 2023 at 04:40:06AM +0100, Matthew Wilcox wrote:
> > I don't think we
> > should be overriding the aops, and if we narrow the scope of large folio
> > support in blockdev t only supporting folio_size == LBA size, it becomes
> > much more feasible.
> 
> I'm trying to think of the possible use cases where folio_size != LBA size
> and I cannot immediately think of some. Yes there are cases where a
> filesystem may use a different block for say meta data than data, but that
> I believe is side issue, ie, read/writes for small metadata would have
> to be accepted. At least for NVMe we have metadata size as part of the
> LBA format, but from what I understand no Linux filesystem yet uses that.

NVMe metadata is per-block metadata -- a CRC or similar.  Filesystem
metadata is things like directories, inode tables, free space bitmaps,
etc.

> struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,   
>                 bool retry)                                                     
> { 
[...]
>         head = NULL;  
>         offset = PAGE_SIZE;                                                     
>         while ((offset -= size) >= 0) {                                         
> 
> I see now what you say about the buffer head being of the block size
> bh->b_size = size above.

Yes, just changing that to 'offset = page_size(page);' will do the trick.

> > sb_bread() is used by most filesystems, and the buffer cache aliases
> > into the page cache.
> 
> I see thanks. I checked what xfs does and its xfs_readsb() uses its own
> xfs_buf_read_uncached(). It ends up calling xfs_buf_submit() and
> xfs_buf_ioapply_map() does it's own submit_bio(). So I'm curious why
> they did that.

IRIX didn't have an sb_bread() ;-)

> > In userspace, if I run 'dd if=blah of=/dev/sda1 bs=512 count=1 seek=N',
> > I can overwrite the superblock.  Do we want filesystems to see that
> > kind of vandalism, or do we want the mounted filesystem to have its
> > own copy of the data and overwrite what userspace wrote the next time it
> > updates the superblock?
> 
> Oh, what happens today?

Depends on the filesystem, I think?  Not really sure, to be honest.

