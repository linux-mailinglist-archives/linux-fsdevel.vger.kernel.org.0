Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634EF65F4AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjAETh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 14:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjAEThA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:37:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED02DC0;
        Thu,  5 Jan 2023 11:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14880B81BAA;
        Thu,  5 Jan 2023 19:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB39DC433EF;
        Thu,  5 Jan 2023 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672947336;
        bh=nFGpKpW6tDDQSOOuq+1aSPLX1ITq5654htNBZzrAvMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrPvL2Hw5IvdbTSa/AT4yYnZB5S2m/nTOC3WOXRVFQh2HbvfL3V9j4eSE8s9t3oDM
         iMAFPBFcenFNf5f5OpdqTH412tmFogU5LJb1A1YhWzI2wpqFDppCj4GNZ9tXpBJqGo
         mx/SL9bdCU6qfUAGQTxHZ+2QByAt9YHbHKveURWNonJ2iKW4V/C3tMYyOOWcJCVOr4
         NW5dnApa7CnpsrKBqnyonPMEjDUe0t9D1w5Xsw1EovBM9bQ1TMMnkjNHBgEfccm45e
         uJmEVafjuJHjFw0SG2ztPKJJ7loXDeME5B1yCKsH1yZWrV5oCk8SAdUukUe62W3o7e
         eb/5LZghsG38A==
Date:   Thu, 5 Jan 2023 11:35:36 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <Y7cmiIrSVdBf3Opq@magnolia>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org>
 <Y7Wr2uadI+82BB6a@magnolia>
 <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
 <Y7biricgMfXxcQBU@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7biricgMfXxcQBU@bfoster>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:46:06AM -0500, Brian Foster wrote:
> On Wed, Jan 04, 2023 at 01:22:06PM -0800, Sarthak Kukreti wrote:
> > (Resend; the text flow made the last reply unreadable)
> > 
> > On Wed, Jan 4, 2023 at 8:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Thu, Dec 29, 2022 at 12:12:48AM -0800, Sarthak Kukreti wrote:
> > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > sends a hint to (supported) thinly provisioned block devices to
> > > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > > >
> > > > The man pages for both fallocate(2) and posix_fallocate(3) describe
> > > > the default allocation mode as:
> > > >
> > > > ```
> > > > The default operation (i.e., mode is zero) of fallocate()
> > > > allocates the disk space within the range specified by offset and len.
> > > > ...
> > > > subsequent writes to bytes in the specified range are guaranteed
> > > > not to fail because of lack of disk space.
> > > > ```
> > > >
> > > > For thinly provisioned storage constructs (dm-thin, filesystems on sparse
> > > > files), the term 'disk space' is overloaded and can either mean the apparent
> > > > disk space in the filesystem/thin logical volume or the true disk
> > > > space that will be utilized on the underlying non-sparse allocation layer.
> > > >
> > > > The use of a separate mode allows us to cleanly disambiguate whether fallocate()
> > > > causes allocation only at the current layer (default mode) or whether it propagates
> > > > allocations to underlying layers (provision mode)
> > >
> > > Why is it important to make this distinction?  The outcome of fallocate
> > > is supposed to be that subsequent writes do not fail with ENOSPC.  In my
> > > (fs developer) mind, REQ_OP_PROVISION simply an extra step to be taken
> > > after allocating file blocks.
> > >
> > Some use cases still benefit from keeping the default mode - eg.
> > virtual machines running on massive storage pools that don't expect to
> > hit the storage limit anytime soon (like most cloud storage
> > providers). Essentially, if the 'no ENOSPC' guarantee is maintained
> > via other means, then REQ_OP_PROVISION adds latency that isn't needed
> > (and cloud storage providers don't need to set aside that extra space
> > that may or may not be used).
> > 
> 
> What's the granularity that needs to be managed at? Do you really need
> an fallocate command for this, or would one of the filesystem level
> features you've already implemented for ext4 suffice?
> 
> I mostly agree with Darrick in that FALLOC_FL_PROVISION stills feels a
> bit wonky to me. I can see that there might be some legitimate use cases
> for it, but I'm not convinced that it won't just end up being confusing
> to many users. At the same time, I think the approach of unconditional
> provision on falloc could eventually lead to complaints associated with
> the performance impact or similar sorts of confusion. For example,
> should an falloc of an already allocated range in the fs send a
> provision or not?

For a user-initiated fallocate call, I think that's reasonable.

My first thought is to make the XFS allocator issue REQ_OP_PROVISION on
every allocation if the device supports it.  The fs has decided that
it's going to allocate and presumably write to some space, so the
underlying storage really ought to have some space ready.

But then it occurred to me -- what if the IO fails with ENOSPC?  Do we
keep going and hope for the best?  Or maybe we should undo the
allocation?  That could be tricky since we'd have to add a transaction
to undo the allocation, commit that, and then throw an error to the
upper layers.

Should the allocator instead find the space it wants and issue the
provisioning IO with the AGF locked, and try again somewhere else if the
IO returns ENOSPC?  If the space management IO takes forever, we've
pinned the that AG for the duration, which is one of the not very nice
aspects of the XFS FITRIM implementation on crappy SSDs.

For a directio write, it's simple enough to throw that error back to
userspace.  I think the same applies to buffered writeback -- we'll
cancel the writeback and set AS_ENOSPC on the mapping.

But then, what about *metadata* allocation?  If those fail because the
provisioning encounters ENOSPC, we'll shut down the filesystem, which
isn't nice.  For XFS I guess we could reuse the existing metadata IO
error config knobs to make it retry for some amount of time until
(hopefully) the admin buys more storage.

Let's go with the simplest implementation (issue it with the free space
locked), and iterate from there.

> Should filesystems that don't otherwise support UNSHARE_RANGE need to
> support it in order to support an unshare request to COW'd blocks on
> an underlying block device?

Hmm.  Currently, fallocate'ing part of a file that's already mapped to
shared blocks is a nop.  That's technically an omission in the
implementation, since a subsequent write can fail during COW setup due
to insufficient space.  My memory about funshare is a bit murky since
it's been years now.

As I remember it, originally, I had allocate mode also calling unshare,
but Dave or someone pointed out that unsharing generates a flood of
dirty pagecache, and it would be a bit surprising that fallocate
suddenly takes a long time to run.  There also wasn't much precedent for
fallocate to unshare blocks, since btrfs doesn't do that:

# filefrag -v /mnt/[ab]
Filesystem type is: 9123683e
File size of /mnt/a is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     255:       3328..      3583:    256:             last,shared,eof
/mnt/a: 1 extent found
File size of /mnt/b is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     255:       3328..      3583:    256:             last,shared,eof
/mnt/b: 1 extent found

# xfs_io -c 'falloc 512k 36k' /mnt/b

# filefrag -v /mnt/[ab]
Filesystem type is: 9123683e
File size of /mnt/a is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     255:       3328..      3583:    256:             last,shared,eof
/mnt/a: 1 extent found
File size of /mnt/b is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     255:       3328..      3583:    256:             last,shared,eof
/mnt/b: 1 extent found

I took funshare out of the patchset entirely (minimum viable product,
yadda yadda) and a few months later, I think hch or someone asked for a
knob for userspace to get a file back to pure overwrite mode.  That's
where it's been ever since.

So to answer your question: fallocate mode 0 and REQ_OP_PROVISION
probably ought to be allocating the holes and unsharing existing shared
mappings.  However, we could also wriggle out of that by <cough>
claiming that fallocate has been consistent across filesystems in
leaving that wart for userspace to trip over. :/

> I wonder if the smart thing to do here is separate out the question of a
> new fallocate interface from the mechanism entirely. For example,
> implement REQ_OP_PROVISION as you've already done, enable block layer
> mode = 0 fallocate support (i.e. without FL_PROVISION, so whether a
> request propagates from a loop device will be up to the backing fs),
> implement the various fs features to support REQ_OP_PROVISION (i.e.,
> mount option, file attr, etc.), then tack on FL_FALLOC + ext4 support at
> the end as an RFC/prototype.

Yeah.

> Even if we ultimately ended up with FL_PROVISION support, it might
> actually make some sense to kick that can down the road a bit regardless
> to give fs' a chance to implement basic REQ_OP_PROVISION support, get a
> better understanding of how it works in practice, and then perhaps make
> more informed decisions on things like sane defaults and/or how best to
> expose it via fallocate. Thoughts?

Agree. :)

--D

> 
> Brian
> 
> > > If you *don't* add this API flag and simply bake the REQ_OP_PROVISION
> > > call into mode 0 fallocate, then the new functionality can be added (or
> > > even backported) to existing kernels and customers can use it
> > > immediately.  If you *do*, then you get to wait a few years for
> > > developers to add it to their codebases only after enough enterprise
> > > distros pick up a new kernel to make it worth their while.
> > >
> > > > for thinly provisioned filesystems/
> > > > block devices. For devices that do not support REQ_OP_PROVISION, both these
> > > > allocation modes will be equivalent. Given the performance cost of sending provision
> > > > requests to the underlying layers, keeping the default mode as-is allows users to
> > > > preserve existing behavior.
> > >
> > > How expensive is this expected to be?  Is this why you wanted a separate
> > > mode flag?
> > >
> > Yes, the exact latency will depend on the stacked block devices and
> > the fragmentation at the allocation layers.
> > 
> > I did a quick test for benchmarking fallocate() with an:
> > A) ext4 filesystem mounted with 'noprovision'
> > B) ext4 filesystem mounted with 'provision' on a dm-thin device.
> > C) ext4 filesystem mounted with 'provision' on a loop device with a
> > sparse backing file on the filesystem in (B).
> > 
> > I tested file sizes from 512M to 8G, time taken for fallocate() in (A)
> > remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
> > 0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the exact
> > time distribution in the cover letter
> > https://marc.info/?l=linux-ext4&m=167230113520636&w=2)
> > 
> > +0.5s for a 8G fallocate doesn't sound a lot but I think fragmentation
> > and how the block device is layered can make this worse...
> > 
> > > --D
> > >
> > > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > ---
> > > >  block/fops.c                | 15 +++++++++++----
> > > >  include/linux/falloc.h      |  3 ++-
> > > >  include/uapi/linux/falloc.h |  8 ++++++++
> > > >  3 files changed, 21 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/block/fops.c b/block/fops.c
> > > > index 50d245e8c913..01bde561e1e2 100644
> > > > --- a/block/fops.c
> > > > +++ b/block/fops.c
> > > > @@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > > >
> > > >  #define      BLKDEV_FALLOC_FL_SUPPORTED                                      \
> > > >               (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |           \
> > > > -              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> > > > +              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |       \
> > > > +              FALLOC_FL_PROVISION)
> > > >
> > > >  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > >                            loff_t len)
> > > > @@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > >       filemap_invalidate_lock(inode->i_mapping);
> > > >
> > > >       /* Invalidate the page cache, including dirty pages. */
> > > > -     error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > > -     if (error)
> > > > -             goto fail;
> > > > +     if (mode != FALLOC_FL_PROVISION) {
> > > > +             error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > > +             if (error)
> > > > +                     goto fail;
> > > > +     }
> > > >
> > > >       switch (mode) {
> > > >       case FALLOC_FL_ZERO_RANGE:
> > > > @@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > >               error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> > > >                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > >               break;
> > > > +     case FALLOC_FL_PROVISION:
> > > > +             error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> > > > +                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > > +             break;
> > > >       default:
> > > >               error = -EOPNOTSUPP;
> > > >       }
> > > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > > index f3f0b97b1675..b9a40a61a59b 100644
> > > > --- a/include/linux/falloc.h
> > > > +++ b/include/linux/falloc.h
> > > > @@ -30,7 +30,8 @@ struct space_resv {
> > > >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> > > >                                        FALLOC_FL_ZERO_RANGE |         \
> > > >                                        FALLOC_FL_INSERT_RANGE |       \
> > > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > > +                                      FALLOC_FL_UNSHARE_RANGE |      \
> > > > +                                      FALLOC_FL_PROVISION)
> > > >
> > > >  /* on ia32 l_start is on a 32-bit boundary */
> > > >  #if defined(CONFIG_X86_64)
> > > > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > > > index 51398fa57f6c..2d323d113eed 100644
> > > > --- a/include/uapi/linux/falloc.h
> > > > +++ b/include/uapi/linux/falloc.h
> > > > @@ -77,4 +77,12 @@
> > > >   */
> > > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > > >
> > > > +/*
> > > > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> > > > + * blocks for the range/EOF.
> > > > + *
> > > > + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> > > > + */
> > > > +#define FALLOC_FL_PROVISION          0x80
> > > > +
> > > >  #endif /* _UAPI_FALLOC_H_ */
> > > > --
> > > > 2.37.3
> > > >
> > 
> 
