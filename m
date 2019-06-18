Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7149628
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 01:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfFQX7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 19:59:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728499AbfFQX7f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:59:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F10CAC40;
        Mon, 17 Jun 2019 23:59:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E9FADA832; Tue, 18 Jun 2019 02:00:20 +0200 (CEST)
Date:   Tue, 18 Jun 2019 02:00:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 11/19] btrfs: introduce submit buffer
Message-ID: <20190618000020.GK19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-12-naohiro.aota@wdc.com>
 <20190613141457.jws5ca63wfgjf7da@MacBook-Pro-91.local>
 <BYAPR04MB5816E9FC012A289CA438E794E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816E9FC012A289CA438E794E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:16:05AM +0000, Damien Le Moal wrote:
> Josef,
> 
> On 2019/06/13 23:15, Josef Bacik wrote:
> > On Fri, Jun 07, 2019 at 10:10:17PM +0900, Naohiro Aota wrote:
> >> Sequential allocation is not enough to maintain sequential delivery of
> >> write IOs to the device. Various features (async compress, async checksum,
> >> ...) of btrfs affect ordering of the IOs. This patch introduces submit
> >> buffer to sort WRITE bios belonging to a block group and sort them out
> >> sequentially in increasing block address to achieve sequential write
> >> sequences with __btrfs_map_bio().
> >>
> >> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > 
> > I hate everything about this.  Can't we just use the plugging infrastructure for
> > this and then make sure it re-orders the bios before submitting them?  Also
> > what's to prevent the block layer scheduler from re-arranging these io's?
> > Thanks,
> 
> The block I/O scheduler reorders requests in LBA order, but that happens for a
> newly inserted request against pending requests. If there are no pending
> requests because all requests were already issued, no ordering happen, and even
> worse, if the drive queue is not full yet (e.g. there are free tags), then the
> newly inserted request will be dispatched almost immediately, preventing
> reordering with subsequent incoming write requests to happen.

This would be good to add to the changelog.
> 
> The other problem is that the mq-deadline scheduler does not track zone WP
> position. Write request issuing is done regardless of the current WP value,
> solely based on LBA ordering. This means that mq-deadline will not prevent
> out-of-order, or rather, unaligned write requests.

This seems to be the key point.

> These will not be detected
> and dispatched whenever possible. The reasons for this are that:
> 1) the disk user (the FS) has to manage zone WP positions anyway. So duplicating
> that management at the block IO scheduler level is inefficient.
> 2) Adding zone WP management at the block IO scheduler level would also need a
> write error processing path to resync the WP value in case of failed writes. But
> the user/FS also needs that anyway. Again duplicated functionalities.
> 3) The block layer will need a timeout to force issue or cancel pending
> unaligned write requests. This is necessary in case the drive user stops issuing
> writes (for whatever reasons) or the scheduler is being switched. This would
> unnecessarily cause write I/O errors or cause deadlocks if the request queue
> quiesce mode is entered at the wrong time (and I do not see a good way to deal
> with that).
> 
> blk-mq is already complicated enough. Adding this to the block IO scheduler will
> unnecessarily complicate things further for no real benefits. I would like to
> point out the dm-zoned device mapper and f2fs which are both already dealing
> with write ordering and write error processing directly. Both are fairly
> straightforward but completely different and each optimized for their own structure.

So the question is where on which layer the decision logic is. The
filesystem(s) or dm-zoned have enough information about the zones and
the writes can be pre-sorted. This is what the patch proposes.

From your explanation I get that the io scheduler can throw the wrench
in the sequential ordering, for various reasons depending on state of
internal structures od device queues. This is my simplified
interpretation as I don't understand all the magic below filesystem
layer.

I assume there are some guarantees about the ordering, eg. within one
plug, that apply to all schedulers (maybe not the noop one). Something
like that should be the least common functionality that the filesystem
layer can rely on.
 
> Naohiro changes to btrfs IO scheduler have the same intent, that is, efficiently
> integrate and handle write ordering "a la btrfs". Would creating a different
> "hmzoned" btrfs IO scheduler help address your concerns ?

IMHO this sounds both the same, all we care about is the sequential
ordering, which in some sense is "scheduling", but I would not call it
that way due to the simplicity.

As implemented, it's a list of bios, but I'd suggest using rb-tree or
xarray, the insertion is fast and submission is start to end traversal.
I'm not sure that the loop in __btrfs_map_bio_zoned after label
send_bios: has reasonable complexity, looks like an O(N^2).
