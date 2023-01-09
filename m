Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C563662956
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAIPHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjAIPHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA7C7A
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 07:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673276781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFbKNKQ2g/VHh77vfbre1DKedasd16128f+ksLeeeHc=;
        b=dNtwNCXMDVQ9RPQASMxVCmzOdw6Oao6pALqtdaEa35TplhVmFP45GisNadg7ARaP1FP9HY
        ZwAGaF2sq1ufcuh/VWOA+5Hz31GRs1VQyaQMArDBtocAhRBIqazkM0PgnJ1Ba4ja/bzWfg
        PD6o6UmiXMU3VpJCuTuD0nXi+M+q1To=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-262-MY0b-hCnPQyZ9euQqPgkMw-1; Mon, 09 Jan 2023 10:06:19 -0500
X-MC-Unique: MY0b-hCnPQyZ9euQqPgkMw-1
Received: by mail-qv1-f72.google.com with SMTP id c10-20020a05621401ea00b004c72d0e92bcso5289097qvu.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 07:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFbKNKQ2g/VHh77vfbre1DKedasd16128f+ksLeeeHc=;
        b=Ayak86q7ppojLdogqomDVcRlRUO8ITbXNHwk6VoLIeIY7acG+ARKyKnuLMVgXFa0cB
         miEh0hxmAOJRvjHf1ETr60SlnZz+GgNpiD3rcOLt8l9IKcDzbHMHslmsCNeogRlmigHK
         j83yoFmwj6HmEpMh5/Pu7ES2R8mnghc0sZVlJrYJVcXC4yYtNnyPD1s2KQdwcPW8khZn
         v8zQzmvx17w889yb38rlgJihOXPEDYpareorKi89geKOWsQ3YlquZ0eFfEeTSY1KzKRY
         INbt3/JykQQL4HaN+gQ1a53aFCDoG4aJ2TlsIOkjtlGHKHYwOV6cuJZlbqERLb3Zr834
         yLZg==
X-Gm-Message-State: AFqh2kqKiOj6+1gvmGQL/8U840D3rQGxFtRiklYklx4ubU6xgGeGzb/F
        grDmtabCuH8mj4zbmXyUzodZ7PO/2zRXPTTdFKRMTGR+pFehC63OzbLNm6pNc/8A7kFWI0WZQev
        Y58NhjPtAdByMBykJMEsBupetcg==
X-Received: by 2002:a05:622a:229f:b0:3a7:f552:fd5f with SMTP id ay31-20020a05622a229f00b003a7f552fd5fmr88265755qtb.50.1673276778763;
        Mon, 09 Jan 2023 07:06:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtwaUxsnmZ85TM3q+nOwUJaFYORudsTgAYMhbUOi5osI7Iwk0X8xJoS3W5XmEsTcLkUbrMgIQ==
X-Received: by 2002:a05:622a:229f:b0:3a7:f552:fd5f with SMTP id ay31-20020a05622a229f00b003a7f552fd5fmr88265716qtb.50.1673276778336;
        Mon, 09 Jan 2023 07:06:18 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id dt9-20020a05620a478900b006fbf88667bcsm809298qkb.77.2023.01.09.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:06:17 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:07:19 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
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
Message-ID: <Y7wtp+jU67Ae1kW8@bfoster>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org>
 <Y7Wr2uadI+82BB6a@magnolia>
 <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
 <Y7biricgMfXxcQBU@bfoster>
 <Y7cmiIrSVdBf3Opq@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7cmiIrSVdBf3Opq@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:35:36AM -0800, Darrick J. Wong wrote:
> On Thu, Jan 05, 2023 at 09:46:06AM -0500, Brian Foster wrote:
> > On Wed, Jan 04, 2023 at 01:22:06PM -0800, Sarthak Kukreti wrote:
> > > (Resend; the text flow made the last reply unreadable)
> > > 
> > > On Wed, Jan 4, 2023 at 8:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Thu, Dec 29, 2022 at 12:12:48AM -0800, Sarthak Kukreti wrote:
> > > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > > sends a hint to (supported) thinly provisioned block devices to
> > > > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > > > >
> > > > > The man pages for both fallocate(2) and posix_fallocate(3) describe
> > > > > the default allocation mode as:
> > > > >
> > > > > ```
> > > > > The default operation (i.e., mode is zero) of fallocate()
> > > > > allocates the disk space within the range specified by offset and len.
> > > > > ...
> > > > > subsequent writes to bytes in the specified range are guaranteed
> > > > > not to fail because of lack of disk space.
> > > > > ```
> > > > >
> > > > > For thinly provisioned storage constructs (dm-thin, filesystems on sparse
> > > > > files), the term 'disk space' is overloaded and can either mean the apparent
> > > > > disk space in the filesystem/thin logical volume or the true disk
> > > > > space that will be utilized on the underlying non-sparse allocation layer.
> > > > >
> > > > > The use of a separate mode allows us to cleanly disambiguate whether fallocate()
> > > > > causes allocation only at the current layer (default mode) or whether it propagates
> > > > > allocations to underlying layers (provision mode)
> > > >
> > > > Why is it important to make this distinction?  The outcome of fallocate
> > > > is supposed to be that subsequent writes do not fail with ENOSPC.  In my
> > > > (fs developer) mind, REQ_OP_PROVISION simply an extra step to be taken
> > > > after allocating file blocks.
> > > >
> > > Some use cases still benefit from keeping the default mode - eg.
> > > virtual machines running on massive storage pools that don't expect to
> > > hit the storage limit anytime soon (like most cloud storage
> > > providers). Essentially, if the 'no ENOSPC' guarantee is maintained
> > > via other means, then REQ_OP_PROVISION adds latency that isn't needed
> > > (and cloud storage providers don't need to set aside that extra space
> > > that may or may not be used).
> > > 
> > 
> > What's the granularity that needs to be managed at? Do you really need
> > an fallocate command for this, or would one of the filesystem level
> > features you've already implemented for ext4 suffice?
> > 
> > I mostly agree with Darrick in that FALLOC_FL_PROVISION stills feels a
> > bit wonky to me. I can see that there might be some legitimate use cases
> > for it, but I'm not convinced that it won't just end up being confusing
> > to many users. At the same time, I think the approach of unconditional
> > provision on falloc could eventually lead to complaints associated with
> > the performance impact or similar sorts of confusion. For example,
> > should an falloc of an already allocated range in the fs send a
> > provision or not?
> 
> For a user-initiated fallocate call, I think that's reasonable.
> 

I think so as well, but that doesn't appear to be what the proposed
implementation for ext4 does. I'm not intimately familiar with ext4, but
it looks to me like it only provisions on initial allocation..?

> My first thought is to make the XFS allocator issue REQ_OP_PROVISION on
> every allocation if the device supports it.  The fs has decided that
> it's going to allocate and presumably write to some space, so the
> underlying storage really ought to have some space ready.
> 

That makes sense for a purely thin provisioned device, but runs into
issues with block layer snapshots (re: my comments on the provision
mount option patch). I wonder if it makes more sense to provision at
some point before submitting writes or dirtying pagecache. IIRC we had
prototyped something in XFS a while back that performed an analogous
dm-thin fallocate at the time an extent is mapped for writes. I'm not
sure what the performance impact of that would be or if there's a nice
way to optimize away the obvious side effect of spurious requests.

> But then it occurred to me -- what if the IO fails with ENOSPC?  Do we
> keep going and hope for the best?  Or maybe we should undo the
> allocation?  That could be tricky since we'd have to add a transaction
> to undo the allocation, commit that, and then throw an error to the
> upper layers.
> 

Yeah, that's a good question. IMO we should be able to use something
like this to improve the failure handling for fs' over thinly
provisioned storage with dangerously low free space. There's not much
point in just submitting writes in response to failed provisions in that
case, but perhaps there is some more incremental use case or benefit I'm
not aware of..?

The flipside of more reliably graceful error handling is there may be
more to the minimal solution than just firing off provisions on initial
allocation, unless you wanted to just rule out snapshots I guess. That
said, I think there's still potential opportunity for improvement. For
example, if a prototype did something like the following:

- Provision the log at opportunistic points (i.e., on mount, first
  transaction to a covered log, etc.) to guarantee log writes won't
  fail.
- Provision extents mapped for data writes before the write is allowed
  to proceed.
- Do something similar for metadata in AIL processing or some such,
  where each item must be provisioned before written back.
- Shutdown the fs in response to any provision failure.

... obviously that comes with caveats, possibly bad performance, etc.,
but it would be interesting to see if that is sufficient to catch most
scenarios where a write would otherwise get to an out of space volume
causing it to become inactive. If that could be made to work well
enough, perhaps the fs shutdown step could be replaced with some kind of
in-core pause/freeze like mode where the admin has the opportunity to
either add more storage and continue or explicitly shutdown to save the
volume.

OTOH if that just doesn't work out, perhaps this can be combined with
other schemes to reliably prevent inactivation, such as the reservation
mechanism the dm guys had prototyped in the past. Of course that
potentially complicates the interface between the fs and dm-layer.

> Should the allocator instead find the space it wants and issue the
> provisioning IO with the AGF locked, and try again somewhere else if the
> IO returns ENOSPC?  If the space management IO takes forever, we've
> pinned the that AG for the duration, which is one of the not very nice
> aspects of the XFS FITRIM implementation on crappy SSDs.
> 
> For a directio write, it's simple enough to throw that error back to
> userspace.  I think the same applies to buffered writeback -- we'll
> cancel the writeback and set AS_ENOSPC on the mapping.
> 
> But then, what about *metadata* allocation?  If those fail because the
> provisioning encounters ENOSPC, we'll shut down the filesystem, which
> isn't nice.  For XFS I guess we could reuse the existing metadata IO
> error config knobs to make it retry for some amount of time until
> (hopefully) the admin buys more storage.
> 
> Let's go with the simplest implementation (issue it with the free space
> locked), and iterate from there.
> 
> > Should filesystems that don't otherwise support UNSHARE_RANGE need to
> > support it in order to support an unshare request to COW'd blocks on
> > an underlying block device?
> 
> Hmm.  Currently, fallocate'ing part of a file that's already mapped to
> shared blocks is a nop.  That's technically an omission in the
> implementation, since a subsequent write can fail during COW setup due
> to insufficient space.  My memory about funshare is a bit murky since
> it's been years now.
> 
> As I remember it, originally, I had allocate mode also calling unshare,
> but Dave or someone pointed out that unsharing generates a flood of
> dirty pagecache, and it would be a bit surprising that fallocate
> suddenly takes a long time to run.  There also wasn't much precedent for
> fallocate to unshare blocks, since btrfs doesn't do that:
> 
> # filefrag -v /mnt/[ab]
> Filesystem type is: 9123683e
> File size of /mnt/a is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..     255:       3328..      3583:    256:             last,shared,eof
> /mnt/a: 1 extent found
> File size of /mnt/b is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..     255:       3328..      3583:    256:             last,shared,eof
> /mnt/b: 1 extent found
> 
> # xfs_io -c 'falloc 512k 36k' /mnt/b
> 
> # filefrag -v /mnt/[ab]
> Filesystem type is: 9123683e
> File size of /mnt/a is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..     255:       3328..      3583:    256:             last,shared,eof
> /mnt/a: 1 extent found
> File size of /mnt/b is 1048576 (256 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..     255:       3328..      3583:    256:             last,shared,eof
> /mnt/b: 1 extent found
> 
> I took funshare out of the patchset entirely (minimum viable product,
> yadda yadda) and a few months later, I think hch or someone asked for a
> knob for userspace to get a file back to pure overwrite mode.  That's
> where it's been ever since.
> 
> So to answer your question: fallocate mode 0 and REQ_OP_PROVISION
> probably ought to be allocating the holes and unsharing existing shared
> mappings.  However, we could also wriggle out of that by <cough>
> claiming that fallocate has been consistent across filesystems in
> leaving that wart for userspace to trip over. :/
> 

Thanks. That seems reasonable to me, but again isn't what the patches
appear to implement. ;P

I guess from the standpoint of an I/O command, it probably makes more
sense to unshare by default. Why else would one send the command
otherwise? The falloc api is what it is at this point, so the bdev folks
could always decide if/how to implement a non-unsharing variant if there
happens to be some reason to do that.

Brian

> > I wonder if the smart thing to do here is separate out the question of a
> > new fallocate interface from the mechanism entirely. For example,
> > implement REQ_OP_PROVISION as you've already done, enable block layer
> > mode = 0 fallocate support (i.e. without FL_PROVISION, so whether a
> > request propagates from a loop device will be up to the backing fs),
> > implement the various fs features to support REQ_OP_PROVISION (i.e.,
> > mount option, file attr, etc.), then tack on FL_FALLOC + ext4 support at
> > the end as an RFC/prototype.
> 
> Yeah.
> 
> > Even if we ultimately ended up with FL_PROVISION support, it might
> > actually make some sense to kick that can down the road a bit regardless
> > to give fs' a chance to implement basic REQ_OP_PROVISION support, get a
> > better understanding of how it works in practice, and then perhaps make
> > more informed decisions on things like sane defaults and/or how best to
> > expose it via fallocate. Thoughts?
> 
> Agree. :)
> 
> --D
> 
> > 
> > Brian
> > 
> > > > If you *don't* add this API flag and simply bake the REQ_OP_PROVISION
> > > > call into mode 0 fallocate, then the new functionality can be added (or
> > > > even backported) to existing kernels and customers can use it
> > > > immediately.  If you *do*, then you get to wait a few years for
> > > > developers to add it to their codebases only after enough enterprise
> > > > distros pick up a new kernel to make it worth their while.
> > > >
> > > > > for thinly provisioned filesystems/
> > > > > block devices. For devices that do not support REQ_OP_PROVISION, both these
> > > > > allocation modes will be equivalent. Given the performance cost of sending provision
> > > > > requests to the underlying layers, keeping the default mode as-is allows users to
> > > > > preserve existing behavior.
> > > >
> > > > How expensive is this expected to be?  Is this why you wanted a separate
> > > > mode flag?
> > > >
> > > Yes, the exact latency will depend on the stacked block devices and
> > > the fragmentation at the allocation layers.
> > > 
> > > I did a quick test for benchmarking fallocate() with an:
> > > A) ext4 filesystem mounted with 'noprovision'
> > > B) ext4 filesystem mounted with 'provision' on a dm-thin device.
> > > C) ext4 filesystem mounted with 'provision' on a loop device with a
> > > sparse backing file on the filesystem in (B).
> > > 
> > > I tested file sizes from 512M to 8G, time taken for fallocate() in (A)
> > > remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
> > > 0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the exact
> > > time distribution in the cover letter
> > > https://marc.info/?l=linux-ext4&m=167230113520636&w=2)
> > > 
> > > +0.5s for a 8G fallocate doesn't sound a lot but I think fragmentation
> > > and how the block device is layered can make this worse...
> > > 
> > > > --D
> > > >
> > > > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > > ---
> > > > >  block/fops.c                | 15 +++++++++++----
> > > > >  include/linux/falloc.h      |  3 ++-
> > > > >  include/uapi/linux/falloc.h |  8 ++++++++
> > > > >  3 files changed, 21 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/block/fops.c b/block/fops.c
> > > > > index 50d245e8c913..01bde561e1e2 100644
> > > > > --- a/block/fops.c
> > > > > +++ b/block/fops.c
> > > > > @@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > > > >
> > > > >  #define      BLKDEV_FALLOC_FL_SUPPORTED                                      \
> > > > >               (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |           \
> > > > > -              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> > > > > +              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |       \
> > > > > +              FALLOC_FL_PROVISION)
> > > > >
> > > > >  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > > >                            loff_t len)
> > > > > @@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > > >       filemap_invalidate_lock(inode->i_mapping);
> > > > >
> > > > >       /* Invalidate the page cache, including dirty pages. */
> > > > > -     error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > > > -     if (error)
> > > > > -             goto fail;
> > > > > +     if (mode != FALLOC_FL_PROVISION) {
> > > > > +             error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > > > > +             if (error)
> > > > > +                     goto fail;
> > > > > +     }
> > > > >
> > > > >       switch (mode) {
> > > > >       case FALLOC_FL_ZERO_RANGE:
> > > > > @@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > > > >               error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> > > > >                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > > >               break;
> > > > > +     case FALLOC_FL_PROVISION:
> > > > > +             error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> > > > > +                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > > > +             break;
> > > > >       default:
> > > > >               error = -EOPNOTSUPP;
> > > > >       }
> > > > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > > > index f3f0b97b1675..b9a40a61a59b 100644
> > > > > --- a/include/linux/falloc.h
> > > > > +++ b/include/linux/falloc.h
> > > > > @@ -30,7 +30,8 @@ struct space_resv {
> > > > >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> > > > >                                        FALLOC_FL_ZERO_RANGE |         \
> > > > >                                        FALLOC_FL_INSERT_RANGE |       \
> > > > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > > > +                                      FALLOC_FL_UNSHARE_RANGE |      \
> > > > > +                                      FALLOC_FL_PROVISION)
> > > > >
> > > > >  /* on ia32 l_start is on a 32-bit boundary */
> > > > >  #if defined(CONFIG_X86_64)
> > > > > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > > > > index 51398fa57f6c..2d323d113eed 100644
> > > > > --- a/include/uapi/linux/falloc.h
> > > > > +++ b/include/uapi/linux/falloc.h
> > > > > @@ -77,4 +77,12 @@
> > > > >   */
> > > > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > > > >
> > > > > +/*
> > > > > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> > > > > + * blocks for the range/EOF.
> > > > > + *
> > > > > + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> > > > > + */
> > > > > +#define FALLOC_FL_PROVISION          0x80
> > > > > +
> > > > >  #endif /* _UAPI_FALLOC_H_ */
> > > > > --
> > > > > 2.37.3
> > > > >
> > > 
> > 
> 

