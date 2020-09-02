Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEFF25AA76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIBLog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIBLoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:44:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A37C061244;
        Wed,  2 Sep 2020 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qfUausPRVQ29BP7WmCGntZ/IR0ySDov7mnmZz+JD9z8=; b=csGgh/Ld7k3AsF1N4a3NFa5Cj1
        cBRLQuwvEP195o/73w6+mibiYmUSXV5EjvYpQ6SJZf69cGZRrqKoOtAoCib1GHNAemzY8WD12elBe
        0ql+n6jhRUU9hQsklQctWJCb+BFvDgoHGTyvFPxG7Q9da6axtT8eIsUnPiw2WiWjMlyAfCTknA7rh
        LJEONt4QfkkoESYiJelNpm0WCm/aSI+l2MiFGzbTOa7+O/AfuOE9NZ6uJNus+RsKitdeGx396V6do
        bowRAWA6lIQ8jDcZzLr2zozu5Xxu0wmrVG3W89PrWl2W1QW1ToDHc7AnoUtAJXFXBIzBqhXiZXozi
        xC4oN8pQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDRBW-0005cP-LV; Wed, 02 Sep 2020 11:44:14 +0000
Date:   Wed, 2 Sep 2020 12:44:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200902114414.GX14765@casper.infradead.org>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901235830.GI12096@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 09:58:30AM +1000, Dave Chinner wrote:
> Put simply: converting a filesystem to use iomap is not a "change
> the filesystem interfacing code and it will work" modification.  We
> ask that filesystems are modified to conform to the iomap IO
> exclusion model; adding special cases for every potential
> locking and mapping quirk every different filesystem has is part of
> what turned the old direct IO code into an unmaintainable nightmare.
> 
> > That's fine, but this is kind of a bad way to find
> > out.  We really shouldn't have generic helper's that have different generic
> > locking rules based on which file system uses them.
> 
> We certainly can change the rules for new infrastructure. Indeed, we
> had to change the rules to support DAX.  The whole point of the
> iomap infrastructure was that it enabled us to use code that already
> worked for DAX (the XFS code) in multiple filesystems. And as people
> have realised that the DIO via iomap is much faster than the old DIO
> code and is a much more efficient way of doing large buffered IO,
> other filesystems have started to use it.
> 
> However....
> 
> > Because then we end up
> > with situations like this, where suddenly we're having to come up with some
> > weird solution because the generic thing only works for a subset of file
> > systems.  Thanks,
> 
> .... we've always said "you need to change the filesystem code to
> use iomap". This is simply a reflection on the fact that iomap has
> different rules and constraints to the old code and so it's not a
> direct plug in replacement. There are no short cuts here...

Can you point me (and I suspect Josef!) towards the documentation of the
locking model?  I was hoping to find Documentation/filesystems/iomap.rst
but all the 'iomap' strings in Documentation/ refer to pci_iomap and
similar, except for this in the DAX documentation:

: - implementing ->read_iter and ->write_iter operations which use dax_iomap_rw()
:   when inode has S_DAX flag set
: - implementing an mmap file operation for DAX files which sets the
:   VM_MIXEDMAP and VM_HUGEPAGE flags on the VMA, and setting the vm_ops to
:   include handlers for fault, pmd_fault, page_mkwrite, pfn_mkwrite. These
:   handlers should probably call dax_iomap_fault() passing the appropriate
:   fault size and iomap operations.
: - calling iomap_zero_range() passing appropriate iomap operations instead of
:   block_truncate_page() for DAX files
: - ensuring that there is sufficient locking between reads, writes,
:   truncates and page faults
: 
: The iomap handlers for allocating blocks must make sure that allocated blocks
: are zeroed out and converted to written extents before being returned to avoid
: exposure of uninitialized data through mmap.

which doesn't bear on this situation.
