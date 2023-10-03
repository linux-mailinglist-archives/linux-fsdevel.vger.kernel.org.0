Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE37B5FD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 06:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJCEYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 00:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjJCEYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:24:31 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5200DA4
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 21:24:28 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57de6e502fcso269889eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 21:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696307067; x=1696911867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRj24ayrhAkntLHqRcMnTUmDF9ooyeDw7/Fu4VWKcjU=;
        b=tvoonKFXb7FoOfcAkeQ3FTmGqcUtyQUM19R/UF/tgEfrvpvggco/c11JArL7+O/Q2b
         lHJY6lWfd1HUR6mDDT2JmbqXv/vRyrM/r21gzZOH5AwMCXT0eHQsBLRXBtz17gq5J42a
         fOOY4Q83RomolysrvHwqaYKtqk6dE0WNJsjZmdUOJwhQbUSMbsP1qC7w85TqU7vMzwiP
         KfnuX5x8lFxsmmK/xEbZmHIYL0yRhLQmOyU3H0+gIgBbfBYsfVCppPIQHYSiawgZJKhn
         eHNKXRaprlgpHbEW8p00K57S82zT9t05RzOiLF0Wq2q8SlX12VMef38FgfHxErytpY0H
         RGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307067; x=1696911867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRj24ayrhAkntLHqRcMnTUmDF9ooyeDw7/Fu4VWKcjU=;
        b=wCxhEoTNWu6sSJawc8jxcbDt69SomrQkzJwbfkrqdfoasmjZL55XQiqgFeI8w/CfBt
         vBfbiKFLdoO02d9+4PkunMF5GfTenU79c5LwbGrLqUOM6k2qbqIOqDfh7wdQYfHP5Ukm
         oGVuY5mcZpam+wLvLOaXJhXinjKat3r7diigaTktlRYqZVWRLTPTCZY7AVDPpmBu460L
         NJ+GWObuuVGWHA1Zf60b1RBi57g3v1BaHvkz7E9ds77V/myYx5tZMHhFGL5IldFRF4Zc
         V2zh9a2JmIFFT+00ciBNdWCx6NOqGD1sSXvbOOsr4f5qZheFamm8PKaQooUwF+Ht3brL
         jI5g==
X-Gm-Message-State: AOJu0YznqNZjlMyBzsUA1nEn3tSFa6+iLiqDfk7hbSkwu9KF1XI7bNl5
        YBRmn2crLh9VyAD4zi4Q+CpK/A==
X-Google-Smtp-Source: AGHT+IF9/GeW581UAr9N/tYBG4MpUKg3lZZswuTJjzX9kHgNxMQY4rk20R8BKOaIH9/L9F4V8Y44rA==
X-Received: by 2002:a05:6358:7204:b0:133:4ce:4e8c with SMTP id h4-20020a056358720400b0013304ce4e8cmr17340586rwa.29.1696307067412;
        Mon, 02 Oct 2023 21:24:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id r25-20020aa78b99000000b006933f657db3sm320573pfd.21.2023.10.02.21.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:24:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qnWxL-008kjp-29;
        Tue, 03 Oct 2023 15:24:23 +1100
Date:   Tue, 3 Oct 2023 15:24:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 16/21] fs: iomap: Atomic write support
Message-ID: <ZRuXd/iG1kyeFQDh@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-17-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-17-john.g.garry@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:27:21AM +0000, John Garry wrote:
> Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
> bio is being created and all the rules there need to be followed.
> 
> It is the task of the FS iomap iter callbacks to ensure that the mapping
> created adheres to those rules, like size is power-of-2, is at a
> naturally-aligned offset, etc.

The mapping being returned by the filesystem can span a much greater
range than the actual IO needs - the iomap itself is not guaranteed
to be aligned to anything in particular, but the IO location within
that map can still conform to atomic IO constraints. See how
iomap_sector() calculates the actual LBA address of the IO from
the iomap and the current file position the IO is being done at.

hence I think saying "the filesysetm should make sure all IO
alignment adheres to atomic IO rules is probably wrong. The iomap
layer doesn't care what the filesystem does, all it cares about is
whether the IO can be done given the extent map that was returned to
it.

Indeed, iomap_dio_bio_iter() is doing all these alignment checks for
normal DIO reads and writes which must be logical block sized
aligned. i.e. this check:

        if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
            !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
                return -EINVAL;

Hence I think that atomic IO units, which are similarly defined by
the bdev, should be checked at the iomap layer, too. e.g, by
following up with:

	if ((dio->iocb->ki_flags & IOCB_ATOMIC) &&
	    ((pos | length) & (bdev_atomic_unit_min(iomap->bdev) - 1) ||
	     !bdev_iter_is_atomic_aligned(iomap->bdev, dio->submit.iter))
		return -EINVAL;

At this point, filesystems don't really need to know anything about
atomic IO - if they've allocated a large contiguous extent (e.g. via
fallocate()), then RWF_ATOMIC will just work for the cases where the
block device supports it...

This then means that stuff like XFS extent size hints only need to
check when the hint is set that it is aligned to the underlying
device atomic IO constraints. Then when it sees the IOMAP_ATOMIC
modifier, it can fail allocation if it can't get extent size hint
aligned allocation.

IOWs, I'm starting to think this doesn't need any change to the
on-disk format for XFS - it can be driven entirely through two
dynamic mechanisms:

1. (IOMAP_WRITE | IOMAP_ATOMIC) requests from the direct IO layer
which causes mapping/allocation to fail if it can't allocate (or
map) atomic IO compatible extents for the IO.

2. FALLOC_FL_ATOMIC preallocation flag modifier to tell fallocate()
to force alignment of all preallocated extents to atomic IO
constraints.

This doesn't require extent size hints at all. The filesystem can
query the bdev at mount time, store the min/max atomic write sizes,
and then use them for all requests that have _ATOMIC modifiers set
on them.

With iomap doing the same "get the atomic constraints from the bdev"
style lookups for per-IO file offset and size checking, I don't
think we actually need extent size hints or an on-disk flag to force
extent size hint alignment.

That doesn't mean extent size hints can't be used - it just means
that extent size hints have to be constrained to being aligned to
atomic IOs (e.g. extent size hint must be an integer multiple of the
max atomic IO size). This then acts as a modifier for _ATOMIC
context allocations, much like it is a modifier for normal
allocations now.

> In iomap_dio_bio_iter(), ensure that for a non-dsync iocb that the mapping
> is not dirty nor unmapped.
>
> A write should only produce a single bio, so error when it doesn't.

I comment on both these things below.

> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 26 ++++++++++++++++++++++++--
>  fs/iomap/trace.h      |  3 ++-
>  include/linux/iomap.h |  1 +
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..6ef25e26f1a1 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -275,10 +275,11 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		struct iomap_dio *dio)
>  {
> +	bool atomic_write = iter->flags & IOMAP_ATOMIC_WRITE;
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> -	loff_t length = iomap_length(iter);
> +	const loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
> @@ -292,6 +293,13 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
>  
> +	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
> +		if (iomap->flags & IOMAP_F_DIRTY)
> +			return -EIO;
> +		if (iomap->type != IOMAP_MAPPED)
> +			return -EIO;
> +	}

How do we get here without space having been allocated for the
write?

Perhaps what this is trying to do is make RWF_ATOMIC only be valid
into written space? I mean, this will fail with preallocated space
(IOMAP_UNWRITTEN) even though we still have exactly the RWF_ATOMIC
all-or-nothing behaviour guaranteed after a crash because of journal
recovery behaviour. i.e. if the unwritten conversion gets written to
the journal, the data will be there. If it isn't written to the
journal, then the space remains unwritten and there's no data across
that entire range....

So I'm not really sure that either of these checks are valid or why
they are actually needed....

> +
>  	if (iomap->type == IOMAP_UNWRITTEN) {
>  		dio->flags |= IOMAP_DIO_UNWRITTEN;
>  		need_zeroout = true;
> @@ -381,6 +389,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  					  GFP_KERNEL);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  		bio->bi_ioprio = dio->iocb->ki_ioprio;
> +		if (atomic_write)
> +			bio->bi_opf |= REQ_ATOMIC;
> +
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> @@ -397,6 +408,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		}
>  
>  		n = bio->bi_iter.bi_size;
> +		if (atomic_write && n != length) {
> +			/* This bio should have covered the complete length */
> +			ret = -EINVAL;
> +			bio_put(bio);
> +			goto out;

Why? The actual bio can be any length that meets the aligned
criteria between min and max, yes? So it's valid to split a
RWF_ATOMIC write request up into multiple min unit sized bios, is it
not? I mean, that's the whole point of the min/max unit setup, isn't
it? That the max sized write only guarantees that it will tear at
min unit boundaries, not within those min unit boundaries? If
I've understood this correctly, then why does this "single bio for
large atomic write" constraint need to exist?


> +		}
>  		if (dio->flags & IOMAP_DIO_WRITE) {
>  			task_io_account_write(n);
>  		} else {
> @@ -554,6 +571,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  	loff_t ret = 0;
> +	bool is_read = iov_iter_rw(iter) == READ;
> +	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;

This does not need to be done here, because....

>  
>  	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
>  
> @@ -579,7 +598,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> -	if (iov_iter_rw(iter) == READ) {
> +	if (is_read) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
>  
> @@ -605,6 +624,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
>  			dio->flags |= IOMAP_DIO_CALLER_COMP;
>  
> +		if (atomic_write)
> +			iomi.flags |= IOMAP_ATOMIC_WRITE;

.... it is only checked once in the write path, so

		if (iocb->ki_flags & IOCB_ATOMIC)
			iomi.flags |= IOMAP_ATOMIC;

> +
>  		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
>  			ret = -EAGAIN;
>  			if (iomi.pos >= dio->i_size ||
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index c16fd55f5595..f9932733c180 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_REPORT,		"REPORT" }, \
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
> -	{ IOMAP_NOWAIT,		"NOWAIT" }
> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> +	{ IOMAP_ATOMIC_WRITE,	"ATOMIC" }

We already have an IOMAP_WRITE flag, so IOMAP_ATOMIC is the modifier
for the write IO behaviour (like NOWAIT), not a replacement write
flag.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
