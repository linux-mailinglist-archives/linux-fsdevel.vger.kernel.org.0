Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A056E804C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 19:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjDSR0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDSR0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:26:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDEA659B;
        Wed, 19 Apr 2023 10:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B6A64122;
        Wed, 19 Apr 2023 17:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6ABC433EF;
        Wed, 19 Apr 2023 17:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681925162;
        bh=VFRws15p+q59RSTrU0VATjC0LQ6eFGIpuOjxTTSlgZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UycFIy4d7bCijEj9Km8Xjqeq9Y7EDL81kXO55cTmYZWaCoWU32Dc670Zrnc7oLZIE
         zohoopB6vvjwHWAIgZi2HjslXGgNOIJNhWwyycPnyOYwJZEXyC3u+30gOvOxZSPYmz
         UoBxqtx/hq9Yb4HYkTl/ePo7blbSjZczejMiqCwIcKJRmGoEgpFxw635kJIa5LL6cK
         fj7fBUFeirx+lzm/NNEwcg+rYsJHgsDOwXoE9yDM1+xQ7Vq0YueKHyzojjw0y6iVIo
         MzRSXQLJPb3cF4Xqo1ry0NuHAPTGe48TEIN9UMSK0LxFIaOB2wSFR2bO9Zr4jBxkZj
         6EldBf3ubjw1Q==
Date:   Wed, 19 Apr 2023 10:26:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 1/4] block: Introduce provisioning primitives
Message-ID: <20230419172602.GE360881@frogsfrogsfrogs>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-2-sarthakkukreti@chromium.org>
 <20230419153611.GE360885@frogsfrogsfrogs>
 <ZEAUHnWqt9cIiJRb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEAUHnWqt9cIiJRb@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 12:17:34PM -0400, Mike Snitzer wrote:
> On Wed, Apr 19 2023 at 11:36P -0400,
> Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > On Tue, Apr 18, 2023 at 03:12:04PM -0700, Sarthak Kukreti wrote:
> > > Introduce block request REQ_OP_PROVISION. The intent of this request
> > > is to request underlying storage to preallocate disk space for the given
> > > block range. Block devices that support this capability will export
> > > a provision limit within their request queues.
> > > 
> > > This patch also adds the capability to call fallocate() in mode 0
> > > on block devices, which will send REQ_OP_PROVISION to the block
> > > device for the specified range,
> > > 
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  block/blk-core.c          |  5 ++++
> > >  block/blk-lib.c           | 53 +++++++++++++++++++++++++++++++++++++++
> > >  block/blk-merge.c         | 18 +++++++++++++
> > >  block/blk-settings.c      | 19 ++++++++++++++
> > >  block/blk-sysfs.c         |  8 ++++++
> > >  block/bounce.c            |  1 +
> > >  block/fops.c              | 25 +++++++++++++-----
> > >  include/linux/bio.h       |  6 +++--
> > >  include/linux/blk_types.h |  5 +++-
> > >  include/linux/blkdev.h    | 16 ++++++++++++
> > >  10 files changed, 147 insertions(+), 9 deletions(-)
> > > 
> > 
> > <cut to the fallocate part; the block/ changes look fine to /me/ at
> > first glance, but what do I know... ;)>
> > 
> > > diff --git a/block/fops.c b/block/fops.c
> > > index d2e6be4e3d1c..e1775269654a 100644
> > > --- a/block/fops.c
> > > +++ b/block/fops.c
> > > @@ -611,9 +611,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > >  	return ret;
> > >  }
> > >  
> > > +#define	BLKDEV_FALLOC_FL_TRUNCATE				\
> > 
> > At first I thought from this name that you were defining a new truncate
> > mode for fallocate, then I realized that this is mask for deciding if we
> > /want/ to truncate the pagecache.
> > 
> > #define		BLKDEV_FALLOC_TRUNCATE_MASK ?
> > 
> > > +		(FALLOC_FL_PUNCH_HOLE |	FALLOC_FL_ZERO_RANGE |	\
> > 
> > Ok, so discarding and writing zeroes truncates the page cache, makes
> > sense since we're "writing" directly to the block device.
> > 
> > > +		 FALLOC_FL_NO_HIDE_STALE)
> > 
> > Here things get tricky -- some of the FALLOC_FL mode bits are really an
> > opcode and cannot be specified together, whereas others select optional
> > behavior for certain opcodes.
> > 
> > IIRC, the mutually exclusive opcodes are:
> > 
> > 	PUNCH_HOLE
> > 	ZERO_RANGE
> > 	COLLAPSE_RANGE
> > 	INSERT_RANGE
> > 	(none of the above, for allocation)
> > 
> > and the "variants on a theme are":
> > 
> > 	KEEP_SIZE
> > 	NO_HIDE_STALE
> > 	UNSHARE_RANGE
> > 
> > not all of which are supported by all the opcodes.
> > 
> > Does it make sense to truncate the page cache if userspace passes in
> > mode == NO_HIDE_STALE?  There's currently no defined meaning for this
> > combination, but I think this means we'll truncate the pagecache before
> > deciding if we're actually going to issue any commands.
> > 
> > I think that's just a bug in the existing code -- it should be
> > validating that @mode is any of the supported combinations *before*
> > truncating the pagecache.
> > 
> > Otherwise you could have a mkfs program that starts writing new fs
> > metadata, decides to provision the storage (say for a logging region),
> > doesn't realize it's running on an old kernel, and then oops the
> > provision attempt fails but have we now shredded the pagecache and lost
> > all the writes?
> 
> While that just caused me to have an "oh shit, that's crazy" (in a
> scary way) belly laugh...

I just tried this and:

# xfs_io -c 'pwrite -S 0x58 1m 1m' -c fsync -c 'pwrite -S 0x59 1m 4096' -c 'pread -v 1m 64' -c 'falloc 1m 4096' -c 'pread -v 1m 64' /dev/sda
wrote 1048576/1048576 bytes at offset 1048576
1 MiB, 256 ops; 0.0013 sec (723.589 MiB/sec and 185238.7844 ops/sec)
wrote 4096/4096 bytes at offset 1048576
4 KiB, 1 ops; 0.0000 sec (355.114 MiB/sec and 90909.0909 ops/sec)
00100000:  59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  YYYYYYYYYYYYYYYY
00100010:  59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  YYYYYYYYYYYYYYYY
00100020:  59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  YYYYYYYYYYYYYYYY
00100030:  59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  YYYYYYYYYYYYYYYY
read 64/64 bytes at offset 1048576
64.000000 bytes, 1 ops; 0.0000 sec (1.565 MiB/sec and 25641.0256 ops/sec)
fallocate: Operation not supported
00100000:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
00100010:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
00100020:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
00100030:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
read 64/64 bytes at offset 1048576
64.000000 bytes, 1 ops; 0.0003 sec (176.554 KiB/sec and 2824.8588 ops/sec)

(Write 1MB of Xs, flush it to disk, write 4k of Ys, confirm the Y's are
in the page cache, fail to fallocate, reread and spot the Xs that we
supposedly overwrote.)

oops.

> (And obviously needs fixing independent of this patchset)
> 
> Shouldn't mkfs first check that the underlying storage supports
> REQ_OP_PROVISION by verifying
> /sys/block/<dev>/queue/provision_max_bytes exists and is not 0?
> (Just saying, we need to add new features more defensively.. you just
> made the case based on this scenario's implications alone)

Not for fallocate -- for regular files, there's no way to check if the
filesystem actually supports the operation requested other than to try
it and see if it succeeds.  We probably should've defined a DRY_RUN flag
for that purpose back when it was introduced.

For fallocate calls to block devices, yes, the program can check the
queue limits in sysfs if fstat says the supplied path is a block device,
but I don't know that most programs are that thorough.  The fallocate(1)
CLI program does not check.

Then I moved on to fs utilities:

ext4: For discard, mke2fs calls BLKDISCARD if it detects a block device
via fstat, and falloc(PUNCH|KEEP_SIZE) for anything else.  For zeroing,
it only uses falloc(ZERO) or falloc(PUNCH|KEEP_SIZE) and does not try to
use BLKZEROOUT.  It does not check sysfs queue limits at all.

XFS: mkfs.xfs issues BLKDISCARD before writing anything to the device,
so that's fine.  It uses falloc(ZERO) to erase the log, but since
xfsprogs provides its own buffer cache and uses O_DIRECT, pagecache
coherency problems aren't an issue.

btrfs: mkfs.btrfs only issues BLKDISCARD, and only before it starts
writing the new fs, so no problems there.

--D

> Sarthak, please note I said "provision_max_bytes": all other ops
> (e.g. DISCARD, WRITE_ZEROES, etc) have <op>_max_bytes exported through
> sysfs, not <op>_max_sectors.  Please export provision_max_bytes, e.g.:
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 202aa78f933e..2e5ac7b1ffbd 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -605,12 +605,12 @@ QUEUE_RO_ENTRY(queue_io_min, "minimum_io_size");
>  QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
>  
>  QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
> -QUEUE_RO_ENTRY(queue_max_provision_sectors, "max_provision_sectors");
>  QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
>  QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
>  QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
>  QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
>  
> +QUEUE_RO_ENTRY(queue_provision_max, "provision_max_bytes");
>  QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
>  QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
>  QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
