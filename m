Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6246E34A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDPB2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 21:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDPB2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 21:28:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691F530E2;
        Sat, 15 Apr 2023 18:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jpr/1hfA1+CQ4OE9WfcWuw1RbtzV/xxCUMuoyczMGIE=; b=BM5jN2kBYiy+gXfi7FKfd8Kvwb
        TF+FAqt5WPN0YlZOZiPUQ0M677GN0PfIay0s698bBuogHwvb0Jn7qfJijsqgZE1VbY1el15Kd1J+F
        MKPCvdw/uegQNlgXjB5+Ggcv1bkRvHSw/6cUydBDET4D9Qr8b/sZwjv5ol1hi2qZy70dREJ25K9R+
        7dDiBirHl4/63DEfRMAngeoHN+T06awR9y9JNX13bdMGxvXjhkmFBiqfjuy7fVrbirhe8QrM3wsnI
        PTtDslEpxjefjU5OEF87E+rhXAoLNNMkeyzCtu11kC9Wui4AgmV46J+rGJ08UvvAtyLlX6MDUGteb
        RMrdXN+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnrBb-00CxGY-13;
        Sun, 16 Apr 2023 01:28:11 +0000
Date:   Sat, 15 Apr 2023 18:28:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDtPK5Qdts19bKY2@bombadil.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
 <ZDodlnm2nvYxbvR4@casper.infradead.org>
 <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
 <ZDraOHQHqeabyCvN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDraOHQHqeabyCvN@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 06:09:12PM +0100, Matthew Wilcox wrote:
> On Sat, Apr 15, 2023 at 03:14:33PM +0200, Hannes Reinecke wrote:
> > On 4/15/23 05:44, Matthew Wilcox wrote:
> > We _could_ upgrade to always do full page I/O; there's a good
> > chance we'll be using the entire page anyway eventually.

*Iff* doing away with buffer head 512 granularity could help block sizes
greater than page size where physical and logical block size > PAGE_SIZE
we whould also be able to see it on 4kn drives (logical and physical
block size == 4k). A projection could be made after.

In so far as experimenting with this, if you already have some
effort on IOMAP for bdev aops one possibility for pure experimentation
for now would be to peg a new set of aops could be set in the path
of __alloc_disk_node() --> bdev_alloc() but that's a wee-bit too early
for us to know if the device is has (lbs = pbs) > 512. For NVMe for
instance this would be nvme_alloc_ns() --> blk_mq_alloc_disk(). We
put together and set the logical and phyiscal block size on NVMe on
nvme_update_ns_info() --> nvme_update_disk_info(), right before we
call device_add_disk(). The only way to override the aops then would
be right before device_add_disk(), or as part of a new device_add_disk_aops()
or whatever.

> > And with storage bandwidth getting larger and larger we might even
> > get a performance boost there.
> 
> I think we need to look at this from the filesystem side.

Before that let's recap the bdev cache current issues.

Today by just adding the disk we move on to partition scanning
immediately unless your block driver has a flag that says otherwise. The
current crash we're evaluating with brd and that we also hit with NVMe
is due to this part.

device_add_disk() -->
  disk_scan_partitions() -->
    blkdev_get_whole() -->
      bdev_disk_changed() -->
        filemap_read_folio() --> filler()

The filler is from aops.

We don't even have a filesystem yet on these devices at this point. The entire
partition core does this partition scanning. Refer to:

disk_scan_partitions() --> block/partitions/core.c : bdev_disk_changed()

And all of that stuff is also under a 512-byte atomic operation assumption,
we could do better if wanted to.

> What do filesystems actually want to do?

So you are suggesting that the early reads of the block device by the
block cache and its use of the page cache cache should be aligned /
perhaps redesigned to assist more clearly with what modern filesystems
might actually would want today?

> The first thing is they want to read
> the superblock.  That's either going to be immediately freed ("Oh,
> this isn't a JFS filesystem after all") or it's going to hang around
> indefinitely.  There's no particular need to keep it in any kind of
> cache (buffer or page). 

And the bdev cache would not be able to know before hand that's the case.

> Except ... we want to probe a dozen different
> filesystems, and half of them keep their superblock at the same offset
> from the start of the block device.  So we do want to keep it cached.
> That's arguing for using the page cache, at least to read it.

Do we currently share anything from the bdev cache with the fs for this?
Let's say that first block device blocksize in memory.

> Now, do we want userspace to be able to dd a new superblock into place
> and have the mounted filesystem see it? 

Not sure I follow this. dd a new super block?

> I suspect that confuses just
> about every filesystem out there.  So I think the right answer is to read
> the page into the bdev's page cache and then copy it into a kmalloc'ed
> buffer which the filesystem is then responsible for freeing.  It's also
> responsible for writing it back (so that's another API we need), and for
> a journalled filesystem, it needs to fit into the journalling scheme.
> Also, we may need to write back multiple copies of the superblock,
> possibly with slight modifications.

Are you considering these as extentions to the bdev cache?

  Luis
