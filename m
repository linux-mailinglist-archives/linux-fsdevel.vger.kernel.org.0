Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121C6D140B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 02:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCaA3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 20:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCaA3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:29:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31296EB52
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 17:28:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id er13so42433989edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680222530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uNnTRN46PeW3vDSAc7o+7m0bn0WKvoqFxUhsymmwG0=;
        b=H4D7o2Fd1INZrY4a/CgSvSx1yg4Zua38sdSAfavf9FVTai4fiSZ337flFDfjuIz9/J
         1Kh2/ZhssqbgC4J0wm74O6om8A10fZC4PSx0PsNj8XPqlyjfVl/a4OS4nUavIyzbW69z
         +VgE3LpHLYzsMCG/gouEdMDWWT1ah4/AaAVvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680222530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uNnTRN46PeW3vDSAc7o+7m0bn0WKvoqFxUhsymmwG0=;
        b=QnVP3apZLzE73Pp7rvZd1/ePbgG9a3pwxG3YyM7gHQAQvgLQjYvCaAOO5WSwd8mQ/1
         /Fiza6VDUpekFYEkhb/2mNf46hGmoCHrvhRiS/B/Vt6OiW2QQxo/PCtWbzgXWbuj6+J4
         Q2YK8Aw4NSPYggrMfBpztf/CYQ9ZZjJrStIqBEJwLjwFFgszrP3XW7HwLoa81yIdPdwx
         keyuzVl2vVMQITW9rQjAbgo/ps2jdPjjomUw75bRupMXmzQUdlZPZ6NrgZJ66RhDx1dc
         3QrSW/u4yIed1HcR97qA6NoNmjSzhaP/QY/i+JfKLYaoXO2pderdA+DeRjAMovYEv9T3
         UouQ==
X-Gm-Message-State: AAQBX9cZn80WB1dsVOp/k0yNlVMzB64BN74SIT16v0eRg5LxeghP8DOQ
        ssSE+Da65Aicr7Yfqn+Rb31t+6DbVVa0D7B4oM9slw==
X-Google-Smtp-Source: AKy350Z+isUMbpOmJsYBMQMU0D+zOoZ+cD4P7tUQIB71NQGCezs8pFVLQ4nVawFRmCbDfEPmwO58bPhhB0u29wWlN08=
X-Received: by 2002:a50:d69a:0:b0:4fb:2593:844 with SMTP id
 r26-20020a50d69a000000b004fb25930844mr12350560edi.2.1680222530486; Thu, 30
 Mar 2023 17:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org> <Y7Wr2uadI+82BB6a@magnolia>
 <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
 <Y7biricgMfXxcQBU@bfoster> <Y7cmiIrSVdBf3Opq@magnolia> <Y7wtp+jU67Ae1kW8@bfoster>
In-Reply-To: <Y7wtp+jU67Ae1kW8@bfoster>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 30 Mar 2023 17:28:39 -0700
Message-ID: <CAG9=OMPg8-iqtchwvw3Dv2AEir1p4ettGGKHK8ZRd3i57XMmDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, sarthakkukreti@google.com,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 9, 2023 at 7:06=E2=80=AFAM Brian Foster <bfoster@redhat.com> wr=
ote:
>
> On Thu, Jan 05, 2023 at 11:35:36AM -0800, Darrick J. Wong wrote:
> > On Thu, Jan 05, 2023 at 09:46:06AM -0500, Brian Foster wrote:
> > > On Wed, Jan 04, 2023 at 01:22:06PM -0800, Sarthak Kukreti wrote:
> > > > (Resend; the text flow made the last reply unreadable)
> > > >
> > > > On Wed, Jan 4, 2023 at 8:39 AM Darrick J. Wong <djwong@kernel.org> =
wrote:
> > > > >
> > > > > On Thu, Dec 29, 2022 at 12:12:48AM -0800, Sarthak Kukreti wrote:
> > > > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > > > sends a hint to (supported) thinly provisioned block devices to
> > > > > > allocate space for the given range of sectors via REQ_OP_PROVIS=
ION.
> > > > > >
> > > > > > The man pages for both fallocate(2) and posix_fallocate(3) desc=
ribe
> > > > > > the default allocation mode as:
> > > > > >
> > > > > > ```
> > > > > > The default operation (i.e., mode is zero) of fallocate()
> > > > > > allocates the disk space within the range specified by offset a=
nd len.
> > > > > > ...
> > > > > > subsequent writes to bytes in the specified range are guarantee=
d
> > > > > > not to fail because of lack of disk space.
> > > > > > ```
> > > > > >
> > > > > > For thinly provisioned storage constructs (dm-thin, filesystems=
 on sparse
> > > > > > files), the term 'disk space' is overloaded and can either mean=
 the apparent
> > > > > > disk space in the filesystem/thin logical volume or the true di=
sk
> > > > > > space that will be utilized on the underlying non-sparse alloca=
tion layer.
> > > > > >
> > > > > > The use of a separate mode allows us to cleanly disambiguate wh=
ether fallocate()
> > > > > > causes allocation only at the current layer (default mode) or w=
hether it propagates
> > > > > > allocations to underlying layers (provision mode)
> > > > >
> > > > > Why is it important to make this distinction?  The outcome of fal=
locate
> > > > > is supposed to be that subsequent writes do not fail with ENOSPC.=
  In my
> > > > > (fs developer) mind, REQ_OP_PROVISION simply an extra step to be =
taken
> > > > > after allocating file blocks.
> > > > >
> > > > Some use cases still benefit from keeping the default mode - eg.
> > > > virtual machines running on massive storage pools that don't expect=
 to
> > > > hit the storage limit anytime soon (like most cloud storage
> > > > providers). Essentially, if the 'no ENOSPC' guarantee is maintained
> > > > via other means, then REQ_OP_PROVISION adds latency that isn't need=
ed
> > > > (and cloud storage providers don't need to set aside that extra spa=
ce
> > > > that may or may not be used).
> > > >
> > >
> > > What's the granularity that needs to be managed at? Do you really nee=
d
> > > an fallocate command for this, or would one of the filesystem level
> > > features you've already implemented for ext4 suffice?
> > >
> > > I mostly agree with Darrick in that FALLOC_FL_PROVISION stills feels =
a
> > > bit wonky to me. I can see that there might be some legitimate use ca=
ses
> > > for it, but I'm not convinced that it won't just end up being confusi=
ng
> > > to many users. At the same time, I think the approach of unconditiona=
l
> > > provision on falloc could eventually lead to complaints associated wi=
th
> > > the performance impact or similar sorts of confusion. For example,
> > > should an falloc of an already allocated range in the fs send a
> > > provision or not?
> >
> > For a user-initiated fallocate call, I think that's reasonable.
> >
>
> I think so as well, but that doesn't appear to be what the proposed
> implementation for ext4 does. I'm not intimately familiar with ext4, but
> it looks to me like it only provisions on initial allocation..?
>
That is correct. I think there are two parts/policies to it:

1) provision on first allocation: assuming that the filesystem is
never used on top of a block-level snapshot device, it might be
prudent to limit provision requests to just the first allocation.
2) always provision: for filesystems that are set up on top of a
snapshot device.

Would it make sense to split these behaviors out into mount-based
policies (provision, noprovision, provision_on_alloc)? That way, we
can amortize the cost of provisioning in the non-block snapshot world,
but at the same time ensure correctness.

Best
Sarthak


> > My first thought is to make the XFS allocator issue REQ_OP_PROVISION on
> > every allocation if the device supports it.  The fs has decided that
> > it's going to allocate and presumably write to some space, so the
> > underlying storage really ought to have some space ready.
> >
>
> That makes sense for a purely thin provisioned device, but runs into
> issues with block layer snapshots (re: my comments on the provision
> mount option patch). I wonder if it makes more sense to provision at
> some point before submitting writes or dirtying pagecache. IIRC we had
> prototyped something in XFS a while back that performed an analogous
> dm-thin fallocate at the time an extent is mapped for writes. I'm not
> sure what the performance impact of that would be or if there's a nice
> way to optimize away the obvious side effect of spurious requests.
>
> > But then it occurred to me -- what if the IO fails with ENOSPC?  Do we
> > keep going and hope for the best?  Or maybe we should undo the
> > allocation?  That could be tricky since we'd have to add a transaction
> > to undo the allocation, commit that, and then throw an error to the
> > upper layers.
> >
>
> Yeah, that's a good question. IMO we should be able to use something
> like this to improve the failure handling for fs' over thinly
> provisioned storage with dangerously low free space. There's not much
> point in just submitting writes in response to failed provisions in that
> case, but perhaps there is some more incremental use case or benefit I'm
> not aware of..?
>
> The flipside of more reliably graceful error handling is there may be
> more to the minimal solution than just firing off provisions on initial
> allocation, unless you wanted to just rule out snapshots I guess. That
> said, I think there's still potential opportunity for improvement. For
> example, if a prototype did something like the following:
>
> - Provision the log at opportunistic points (i.e., on mount, first
>   transaction to a covered log, etc.) to guarantee log writes won't
>   fail.
> - Provision extents mapped for data writes before the write is allowed
>   to proceed.
> - Do something similar for metadata in AIL processing or some such,
>   where each item must be provisioned before written back.
> - Shutdown the fs in response to any provision failure.
>
> ... obviously that comes with caveats, possibly bad performance, etc.,
> but it would be interesting to see if that is sufficient to catch most
> scenarios where a write would otherwise get to an out of space volume
> causing it to become inactive. If that could be made to work well
> enough, perhaps the fs shutdown step could be replaced with some kind of
> in-core pause/freeze like mode where the admin has the opportunity to
> either add more storage and continue or explicitly shutdown to save the
> volume.
>
> OTOH if that just doesn't work out, perhaps this can be combined with
> other schemes to reliably prevent inactivation, such as the reservation
> mechanism the dm guys had prototyped in the past. Of course that
> potentially complicates the interface between the fs and dm-layer.
>
> > Should the allocator instead find the space it wants and issue the
> > provisioning IO with the AGF locked, and try again somewhere else if th=
e
> > IO returns ENOSPC?  If the space management IO takes forever, we've
> > pinned the that AG for the duration, which is one of the not very nice
> > aspects of the XFS FITRIM implementation on crappy SSDs.
> >
> > For a directio write, it's simple enough to throw that error back to
> > userspace.  I think the same applies to buffered writeback -- we'll
> > cancel the writeback and set AS_ENOSPC on the mapping.
> >
> > But then, what about *metadata* allocation?  If those fail because the
> > provisioning encounters ENOSPC, we'll shut down the filesystem, which
> > isn't nice.  For XFS I guess we could reuse the existing metadata IO
> > error config knobs to make it retry for some amount of time until
> > (hopefully) the admin buys more storage.
> >
> > Let's go with the simplest implementation (issue it with the free space
> > locked), and iterate from there.
> >
> > > Should filesystems that don't otherwise support UNSHARE_RANGE need to
> > > support it in order to support an unshare request to COW'd blocks on
> > > an underlying block device?
> >
> > Hmm.  Currently, fallocate'ing part of a file that's already mapped to
> > shared blocks is a nop.  That's technically an omission in the
> > implementation, since a subsequent write can fail during COW setup due
> > to insufficient space.  My memory about funshare is a bit murky since
> > it's been years now.
> >
> > As I remember it, originally, I had allocate mode also calling unshare,
> > but Dave or someone pointed out that unsharing generates a flood of
> > dirty pagecache, and it would be a bit surprising that fallocate
> > suddenly takes a long time to run.  There also wasn't much precedent fo=
r
> > fallocate to unshare blocks, since btrfs doesn't do that:
> >
> > # filefrag -v /mnt/[ab]
> > Filesystem type is: 9123683e
> > File size of /mnt/a is 1048576 (256 blocks of 4096 bytes)
> >  ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
> >    0:        0..     255:       3328..      3583:    256:             l=
ast,shared,eof
> > /mnt/a: 1 extent found
> > File size of /mnt/b is 1048576 (256 blocks of 4096 bytes)
> >  ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
> >    0:        0..     255:       3328..      3583:    256:             l=
ast,shared,eof
> > /mnt/b: 1 extent found
> >
> > # xfs_io -c 'falloc 512k 36k' /mnt/b
> >
> > # filefrag -v /mnt/[ab]
> > Filesystem type is: 9123683e
> > File size of /mnt/a is 1048576 (256 blocks of 4096 bytes)
> >  ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
> >    0:        0..     255:       3328..      3583:    256:             l=
ast,shared,eof
> > /mnt/a: 1 extent found
> > File size of /mnt/b is 1048576 (256 blocks of 4096 bytes)
> >  ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
> >    0:        0..     255:       3328..      3583:    256:             l=
ast,shared,eof
> > /mnt/b: 1 extent found
> >
> > I took funshare out of the patchset entirely (minimum viable product,
> > yadda yadda) and a few months later, I think hch or someone asked for a
> > knob for userspace to get a file back to pure overwrite mode.  That's
> > where it's been ever since.
> >
> > So to answer your question: fallocate mode 0 and REQ_OP_PROVISION
> > probably ought to be allocating the holes and unsharing existing shared
> > mappings.  However, we could also wriggle out of that by <cough>
> > claiming that fallocate has been consistent across filesystems in
> > leaving that wart for userspace to trip over. :/
> >
>
> Thanks. That seems reasonable to me, but again isn't what the patches
> appear to implement. ;P
>
> I guess from the standpoint of an I/O command, it probably makes more
> sense to unshare by default. Why else would one send the command
> otherwise? The falloc api is what it is at this point, so the bdev folks
> could always decide if/how to implement a non-unsharing variant if there
> happens to be some reason to do that.
>
> Brian
>
> > > I wonder if the smart thing to do here is separate out the question o=
f a
> > > new fallocate interface from the mechanism entirely. For example,
> > > implement REQ_OP_PROVISION as you've already done, enable block layer
> > > mode =3D 0 fallocate support (i.e. without FL_PROVISION, so whether a
> > > request propagates from a loop device will be up to the backing fs),
> > > implement the various fs features to support REQ_OP_PROVISION (i.e.,
> > > mount option, file attr, etc.), then tack on FL_FALLOC + ext4 support=
 at
> > > the end as an RFC/prototype.
> >
> > Yeah.
> >
> > > Even if we ultimately ended up with FL_PROVISION support, it might
> > > actually make some sense to kick that can down the road a bit regardl=
ess
> > > to give fs' a chance to implement basic REQ_OP_PROVISION support, get=
 a
> > > better understanding of how it works in practice, and then perhaps ma=
ke
> > > more informed decisions on things like sane defaults and/or how best =
to
> > > expose it via fallocate. Thoughts?
> >
> > Agree. :)
> >
> > --D
> >
> > >
> > > Brian
> > >
> > > > > If you *don't* add this API flag and simply bake the REQ_OP_PROVI=
SION
> > > > > call into mode 0 fallocate, then the new functionality can be add=
ed (or
> > > > > even backported) to existing kernels and customers can use it
> > > > > immediately.  If you *do*, then you get to wait a few years for
> > > > > developers to add it to their codebases only after enough enterpr=
ise
> > > > > distros pick up a new kernel to make it worth their while.
> > > > >
> > > > > > for thinly provisioned filesystems/
> > > > > > block devices. For devices that do not support REQ_OP_PROVISION=
, both these
> > > > > > allocation modes will be equivalent. Given the performance cost=
 of sending provision
> > > > > > requests to the underlying layers, keeping the default mode as-=
is allows users to
> > > > > > preserve existing behavior.
> > > > >
> > > > > How expensive is this expected to be?  Is this why you wanted a s=
eparate
> > > > > mode flag?
> > > > >
> > > > Yes, the exact latency will depend on the stacked block devices and
> > > > the fragmentation at the allocation layers.
> > > >
> > > > I did a quick test for benchmarking fallocate() with an:
> > > > A) ext4 filesystem mounted with 'noprovision'
> > > > B) ext4 filesystem mounted with 'provision' on a dm-thin device.
> > > > C) ext4 filesystem mounted with 'provision' on a loop device with a
> > > > sparse backing file on the filesystem in (B).
> > > >
> > > > I tested file sizes from 512M to 8G, time taken for fallocate() in =
(A)
> > > > remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
> > > > 0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the ex=
act
> > > > time distribution in the cover letter
> > > > https://marc.info/?l=3Dlinux-ext4&m=3D167230113520636&w=3D2)
> > > >
> > > > +0.5s for a 8G fallocate doesn't sound a lot but I think fragmentat=
ion
> > > > and how the block device is layered can make this worse...
> > > >
> > > > > --D
> > > > >
> > > > > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > > > > ---
> > > > > >  block/fops.c                | 15 +++++++++++----
> > > > > >  include/linux/falloc.h      |  3 ++-
> > > > > >  include/uapi/linux/falloc.h |  8 ++++++++
> > > > > >  3 files changed, 21 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/block/fops.c b/block/fops.c
> > > > > > index 50d245e8c913..01bde561e1e2 100644
> > > > > > --- a/block/fops.c
> > > > > > +++ b/block/fops.c
> > > > > > @@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kioc=
b *iocb, struct iov_iter *to)
> > > > > >
> > > > > >  #define      BLKDEV_FALLOC_FL_SUPPORTED                       =
               \
> > > > > >               (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |    =
       \
> > > > > > -              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> > > > > > +              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |=
       \
> > > > > > +              FALLOC_FL_PROVISION)
> > > > > >
> > > > > >  static long blkdev_fallocate(struct file *file, int mode, loff=
_t start,
> > > > > >                            loff_t len)
> > > > > > @@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *=
file, int mode, loff_t start,
> > > > > >       filemap_invalidate_lock(inode->i_mapping);
> > > > > >
> > > > > >       /* Invalidate the page cache, including dirty pages. */
> > > > > > -     error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end);
> > > > > > -     if (error)
> > > > > > -             goto fail;
> > > > > > +     if (mode !=3D FALLOC_FL_PROVISION) {
> > > > > > +             error =3D truncate_bdev_range(bdev, file->f_mode,=
 start, end);
> > > > > > +             if (error)
> > > > > > +                     goto fail;
> > > > > > +     }
> > > > > >
> > > > > >       switch (mode) {
> > > > > >       case FALLOC_FL_ZERO_RANGE:
> > > > > > @@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *=
file, int mode, loff_t start,
> > > > > >               error =3D blkdev_issue_discard(bdev, start >> SEC=
TOR_SHIFT,
> > > > > >                                            len >> SECTOR_SHIFT,=
 GFP_KERNEL);
> > > > > >               break;
> > > > > > +     case FALLOC_FL_PROVISION:
> > > > > > +             error =3D blkdev_issue_provision(bdev, start >> S=
ECTOR_SHIFT,
> > > > > > +                                            len >> SECTOR_SHIF=
T, GFP_KERNEL);
> > > > > > +             break;
> > > > > >       default:
> > > > > >               error =3D -EOPNOTSUPP;
> > > > > >       }
> > > > > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > > > > index f3f0b97b1675..b9a40a61a59b 100644
> > > > > > --- a/include/linux/falloc.h
> > > > > > +++ b/include/linux/falloc.h
> > > > > > @@ -30,7 +30,8 @@ struct space_resv {
> > > > > >                                        FALLOC_FL_COLLAPSE_RANGE=
 |     \
> > > > > >                                        FALLOC_FL_ZERO_RANGE |  =
       \
> > > > > >                                        FALLOC_FL_INSERT_RANGE |=
       \
> > > > > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > > > > +                                      FALLOC_FL_UNSHARE_RANGE =
|      \
> > > > > > +                                      FALLOC_FL_PROVISION)
> > > > > >
> > > > > >  /* on ia32 l_start is on a 32-bit boundary */
> > > > > >  #if defined(CONFIG_X86_64)
> > > > > > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/f=
alloc.h
> > > > > > index 51398fa57f6c..2d323d113eed 100644
> > > > > > --- a/include/uapi/linux/falloc.h
> > > > > > +++ b/include/uapi/linux/falloc.h
> > > > > > @@ -77,4 +77,12 @@
> > > > > >   */
> > > > > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > > > > >
> > > > > > +/*
> > > > > > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned d=
evices to allocate
> > > > > > + * blocks for the range/EOF.
> > > > > > + *
> > > > > > + * FALLOC_FL_PROVISION can only be used with allocate-mode fal=
locate.
> > > > > > + */
> > > > > > +#define FALLOC_FL_PROVISION          0x80
> > > > > > +
> > > > > >  #endif /* _UAPI_FALLOC_H_ */
> > > > > > --
> > > > > > 2.37.3
> > > > > >
> > > >
> > >
> >
>
