Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B788F64B83F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 16:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiLMPTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 10:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiLMPTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3255DF9D
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 07:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670944726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1ntaThQV1vrlsYkFdp61j4SoO2vy5wkj3XY/vEMOo0=;
        b=M8JRp+iJ1QdCRdaFGmZPR/n7mS3T8/cl7tcK/FEJbCQuwbymOtJ8SCOxMc7khNDVOvoGlK
        KI371m0VnX5teDfSXHKN/m1n7w3pekNapUfJ1KzRjSJ6y9lUCD87Bg2g0qFkZWlhM/wQ3/
        xFdwYpl4lOe4YzeTmh3JqSmJ0dTnIZ0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-B-G1OBI7M2meK_UOer1n7A-1; Tue, 13 Dec 2022 10:18:44 -0500
X-MC-Unique: B-G1OBI7M2meK_UOer1n7A-1
Received: by mail-qv1-f70.google.com with SMTP id y11-20020ad457cb000000b004c6fafdde42so14665232qvx.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 07:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1ntaThQV1vrlsYkFdp61j4SoO2vy5wkj3XY/vEMOo0=;
        b=oAVREU8o3XnzGpRGzRJtFn7PEApUiVipOIa7saEHm9V1hcMwQgti+ZfA2MancSgR67
         zGu3EQHcq3vp7xiHZYemWAwOPVvuTfGp27v5kv/l7ErKPbJE/TVxbI5GkhHqWx+jeRJm
         zR8vGPjoBjK3XxmonFbHgAEAcTeXYKSQ4MZ07gmrIgluFYD0k7zIXOkUcn0QO4Y/0J5E
         7CYjktmNwIXf8lQrPrPaD+pSlbtrB526u+kAOz8FdixEOqjai2nX23pztXSzYZJfVMZo
         oi0L//JZCgcijnKeVqguko/Fm3ifJ5z/yvDzrBPpjJmJ/oggAU2C3Aj5BnFmQlBMMP9s
         k67Q==
X-Gm-Message-State: ANoB5pkpWTMvXHYO5VcM7j3zi7Rt1jB25F/fNoorSGne4YyhFuUWHsUo
        D6PmNaegFeTtcqVY3XyCoZxTGwNnSxysntNsuEoBN3CaPkcOge5rEdfR8bwFpTF4hXcQmuoZLcT
        vqAAIHeNtdd3P74zl6trA0VusJQ==
X-Received: by 2002:a05:622a:4114:b0:3a5:2031:f22a with SMTP id cc20-20020a05622a411400b003a52031f22amr24236037qtb.25.1670944723865;
        Tue, 13 Dec 2022 07:18:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4G2+5Lr74P4zNKtxpd6ek0F6IjDvnj6h1yOn1FGFZCcDrWL7cGghlNNJnF+cq8rE/cXCU9BQ==
X-Received: by 2002:a05:622a:4114:b0:3a5:2031:f22a with SMTP id cc20-20020a05622a411400b003a52031f22amr24236015qtb.25.1670944723434;
        Tue, 13 Dec 2022 07:18:43 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id t16-20020a05622a01d000b0039cb59f00fcsm33621qtw.30.2022.12.13.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:18:42 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:18:48 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [RFC] iomap: zeroing needs to be pagecache aware
Message-ID: <Y5iX2Ilw1JrUU47z@bfoster>
References: <20221201005214.3836105-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201005214.3836105-1-david@fromorbit.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:52:14AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Unwritten extents can have page cache data over the range being
> zeroed so we can't just skip them entirely. Fix this by checking for
> an existing dirty folio over the unwritten range we are zeroing
> and only performing zeroing if the folio is already dirty.
> 
> XXX: how do we detect a iomap containing a cow mapping over a hole
> in iomap_zero_iter()? The XFS code implies this case also needs to
> zero the page cache if there is data present, so trigger for page
> cache lookup only in iomap_zero_iter() needs to handle this case as
> well.
> 

I think iomap generally would report the COW mapping in srcmap for that
case. The problem I suspect is that if XFS sees a hole in the data fork
for an IOMAP_ZERO operation, it doesn't bother checking the COW fork at
all and just returns the data fork hole. That probably needs to be
reworked to perform IOMAP_ZERO lookups similar to those for a normal
buffered write, otherwise iomap_zero_range() would fail to zero in the
particular case where a COW prealloc might overlap a hole.

Either way, I agree with the followon point that the iomap map
naming/reporting wrt to COW is far too confusing to keep straight.

> Before:
> 
> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> 
> real    0m14.103s
> user    0m0.015s
> sys     0m0.020s
> 
> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  85.90    0.847616          16     50000           ftruncate
>  14.01    0.138229           2     50000           pwrite64
> ....
> 
> After:
> 
> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> 
> real    0m0.144s
> user    0m0.021s
> sys     0m0.012s
> 
> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  53.86    0.505964          10     50000           ftruncate
>  46.12    0.433251           8     50000           pwrite64
> ....
> 
> Yup, we get back all the performance.
> 
> As for the "mmap write beyond EOF" data exposure aspect
> documented here:
> 
> https://lore.kernel.org/linux-xfs/20221104182358.2007475-1-bfoster@redhat.com/
> 
> With this command:
> 
> $ sudo xfs_io -tfc "falloc 0 1k" -c "pwrite 0 1k" \
>   -c "mmap 0 4k" -c "mwrite 3k 1k" -c "pwrite 32k 4k" \
>   -c fsync -c "pread -v 3k 32" /mnt/scratch/foo
> 
> Before:
> 
> wrote 1024/1024 bytes at offset 0
> 1 KiB, 1 ops; 0.0000 sec (34.877 MiB/sec and 35714.2857 ops/sec)
> wrote 4096/4096 bytes at offset 32768
> 4 KiB, 1 ops; 0.0000 sec (229.779 MiB/sec and 58823.5294 ops/sec)
> 00000c00:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
> 00000c10:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
> read 32/32 bytes at offset 3072
> 32.000000 bytes, 1 ops; 0.0000 sec (568.182 KiB/sec and 18181.8182 ops/sec
> 
> After:
> 
> wrote 1024/1024 bytes at offset 0
> 1 KiB, 1 ops; 0.0000 sec (40.690 MiB/sec and 41666.6667 ops/sec)
> wrote 4096/4096 bytes at offset 32768
> 4 KiB, 1 ops; 0.0000 sec (150.240 MiB/sec and 38461.5385 ops/sec)
> 00000c00:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000c10:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> read 32/32 bytes at offset 3072
> 32.000000 bytes, 1 ops; 0.0000 sec (558.036 KiB/sec and 17857.1429 ops/sec)
> 
> We see that this post-eof unwritten extent dirty page zeroing is
> working correctly.
> 
> This has passed through most of fstests on a couple of test VMs
> without issues at the moment, so I think this approach to fixing the
> issue is going to be solid once we've worked out how to detect the
> COW-hole mapping case.
> 

Does fstests currently have any coverage for zero range operations over
multiple folios? I'm not sure that it does. I suspect the reason this
problem went undetected for so long is that the primary uses of zero
range (i.e. falloc) always flush and invalidate the range. The only
exceptions that I'm aware of are the eof boundary handling scenarios in
XFS (i.e. write past eof, truncate), and those typically only expect to
handle a single folio at the eof block.

Given there's also no test cases for the historical and subtle stale
data exposure problems with this code, I suspect we'd want to come up
with at least one test case that has the ability to effectively stress
new zero range logic. Perhaps fallocate zero range could elide the cache
flush/inval? Even if that were just an occasional/random debug mode
thing, that would add some fsx coverage from the various associated
tests, which would be better than what we have now.

> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 50 +++++++++++++++++++++++++++++++++++-------
>  fs/xfs/xfs_iops.c      | 12 +---------
>  2 files changed, 43 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 356193e44cf0..0969e4525507 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
...
> @@ -791,7 +796,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter, pos, bytes, &folio);
> +		status = iomap_write_begin(iter, pos, bytes, &folio, FGP_CREAT);
>  		if (unlikely(status))
>  			break;
>  		if (iter->iomap.flags & IOMAP_F_STALE)

Not necessarily related to this patch, but this looks like it creates a
bit of a negative feedback loop for buffered writes. I.e., a streaming
buffered write workload performs delayed allocation, XFS converts
delalloc to unwritten extents, writeback comes in behind and converts
unwritten extents in ioend batch size chunks, each extent conversion
updates the data fork sequence number and leads to spurious
invalidations on subsequent writes. I don't know if that will ever lead
to enough of a hit that it might be observable on a real workload, or
otherwise if it can just be chalked up to being like any other
background work that comes as a side effect of user operations (i.e.
balance dirty pages, writeback, etc.).

Just out of curiosity and to explore potential worst case
characteristics, I ran a quick test to spin up a bunch of background
flushers of a file while doing a larger streaming write. This seems able
to trigger a 40-50% drop in buffered write throughput compared to the
same workload without stale iomap detection, fwiw. Obviously that is not
testing a sane workload, but probably something to keep in mind if
somebody happens to observe/report that sort of behavior in the near
future.

...
> @@ -1158,9 +1167,20 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		size_t offset;
>  		size_t bytes = min_t(u64, SIZE_MAX, length);
>  
> -		status = iomap_write_begin(iter, pos, bytes, &folio);
> -		if (status)
> +		status = iomap_write_begin(iter, pos, bytes, &folio, fgp);
> +		if (status) {
> +			if (status == -ENODATA) {
> +				/*
> +				 * No folio was found, so skip to the start of
> +				 * the next potential entry in the page cache
> +				 * and continue from there.
> +				 */
> +				if (bytes > PAGE_SIZE - offset_in_page(pos))
> +					bytes = PAGE_SIZE - offset_in_page(pos);
> +				goto loop_continue;
> +			}

I don't think this logic is safe because nothing prevents folio eviction
between the mapping lookup and folio lookup. So if there's a dirty folio
over an unwritten extent, iomap looks up the unwritten extent, and the
folio writes back and is evicted before this lookup, we skip zeroing
data on disk when we shouldn't. That reintroduces a variant of the stale
data exposure vector the flush in xfs_setattr_size() is intended to
prevent.

If we wanted to use stale iomap detection for this purpose, one possible
approach might be to try and support a revalidation check outside of
locked folio context (because there's no guarantee one will exist for a
mapping that might have become stale). With something like that
available, uncached ranges would just have to be revalidated before they
can be tracked as processed by the iter. That might not be too much
trouble to do here since I think the existing stale check (if a folio is
found) would indirectly validate any preceding uncached range. The iter
function would just have to process the 'written' count appropriately
and handle the added scenario where an uncached range must be directly
revalidated.

Brian

>  			return status;
> +		}
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> @@ -1168,6 +1188,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (bytes > folio_size(folio) - offset)
>  			bytes = folio_size(folio) - offset;
>  
> +		/*
> +		 * If the folio over an unwritten extent is clean, then we
> +		 * aren't going to touch the data in it at all. We don't want to
> +		 * mark it dirty or change the uptodate state of data in the
> +		 * page, so we just unlock it and skip to the next range over
> +		 * the unwritten extent we need to check.
> +		 */
> +		if (srcmap->type == IOMAP_UNWRITTEN &&
> +		    !folio_test_dirty(folio)) {
> +			folio_unlock(folio);
> +			goto loop_continue;
> +		}
> +
>  		folio_zero_range(folio, offset, bytes);
>  		folio_mark_accessed(folio);
>  
> @@ -1175,6 +1208,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
> +loop_continue:
>  		pos += bytes;
>  		length -= bytes;
>  		written += bytes;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 2e10e1c66ad6..d7c2f8c49f94 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -839,17 +839,7 @@ xfs_setattr_size(
>  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
>  		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>  				&did_zeroing);
> -	} else {
> -		/*
> -		 * iomap won't detect a dirty page over an unwritten block (or a
> -		 * cow block over a hole) and subsequently skips zeroing the
> -		 * newly post-EOF portion of the page. Flush the new EOF to
> -		 * convert the block before the pagecache truncate.
> -		 */
> -		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
> -						     newsize);
> -		if (error)
> -			return error;
> +	} else if (newsize != oldsize) {
>  		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>  	}
>  
> -- 
> 2.38.1
> 

