Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4326764D2FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 00:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLNXGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 18:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLNXGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:06:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4C29814
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 15:06:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n4so1343204plp.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 15:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo+tShyeYOSb4TMPbZlPrflwRazEiE7fEZhuw1NYlFQ=;
        b=kxfOUpIL6u90JuaFTN6zHl8mfTaXY/h51Eal38XQY2mN/b6gcjyi14DvYFn9DdRVhm
         Hkp6pvGrhnUiKXUTAfu3IMaYTwoA6z3vXCEn1Ivw8O7Osg/70KcjRlhF2OFeyEcnBjLk
         zcpTtsPep+8CzYBE0pTVj57WwL5tH8DbY3JDI/OW0p0p0TvRKZ1e2WKjimOJeNq7VbYx
         msu7zT3cO0Mwv4HxtgvdFTRN/IAqBw2x3nUjzfbKgYRAXexwY6U8403NRqxg3s8QmYha
         Ma5kzLul2qeeuIoHRYXYwlAR8/istDQz8DmsRXxz/kRI5X4oByWNPRgOM6J2s5qiaCFb
         mMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo+tShyeYOSb4TMPbZlPrflwRazEiE7fEZhuw1NYlFQ=;
        b=cm22t1xQCVFWRwh5QuOlNKpfPnoJSDogr1HyXo67qI1NBqYBzO/BegyX2eFjiFdZbr
         ELRc71RV/v2uqHMrzVUkH/G2iT//khkkj4P1pusQ8IKpAr/xoQHprWiyA/RaWc5RMmO/
         MMUglDTeYGLVCdAK9za9c73O8ZF/CYoTgx7TjpP4MBXm9yESObrqngM8EHVMlgk9nPAE
         lblWHM0sg8Tz2ZktUZwbao0BcgVZ44t924XQVDL4LFQ6EAQslxJJ6m1G//XRqNtRKaCW
         kxnz1NKYy/32LlPq6BNkMkOKtB/tczeo2DNyEE+UnPeuPOnI416oQ4fF9xYBZ0G/6U4L
         Mxkg==
X-Gm-Message-State: ANoB5pljIy0F3mlFXeGF/7xIhRaLtHEhCNJpMnJFzntUrgR6JaP8EWyz
        Zf5a0vJ5c/j7LukT493MnGx0ag==
X-Google-Smtp-Source: AA0mqf5ssTDKtyM8pGGP1bkAJ7YbdwMQ2Gad5d2kvkXsNlbceqljut0uue/0Zhx66eI/PUWOPs1AyQ==
X-Received: by 2002:a05:6a20:a694:b0:ad:eaea:e07 with SMTP id ba20-20020a056a20a69400b000adeaea0e07mr9160352pzb.10.1671059197357;
        Wed, 14 Dec 2022 15:06:37 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id h25-20020a63f919000000b0047681fa88d1sm332918pgi.53.2022.12.14.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:06:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5apc-008W55-N9; Thu, 15 Dec 2022 10:06:32 +1100
Date:   Thu, 15 Dec 2022 10:06:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] fs-verity support for XFS
Message-ID: <20221214230632.GA1971568@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <Y5jllLwXlfB7BzTz@sol.localdomain>
 <20221213221139.GZ3600936@dread.disaster.area>
 <Y5ltzp6yeMo1oDSk@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ltzp6yeMo1oDSk@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:31:42PM -0800, Eric Biggers wrote:
> On Wed, Dec 14, 2022 at 09:11:39AM +1100, Dave Chinner wrote:
> > On Tue, Dec 13, 2022 at 12:50:28PM -0800, Eric Biggers wrote:
> > > On Tue, Dec 13, 2022 at 06:29:24PM +0100, Andrey Albershteyn wrote:
> > > > Not yet implemented:
> > > > - No pre-fetching of Merkle tree pages in the
> > > >   read_merkle_tree_page()
> > > 
> > > This would be helpful, but not essential.
> > > 
> > > > - No marking of already verified Merkle tree pages (each read, the
> > > >   whole tree is verified).
> > 
> > Ah, I wasn't aware that this was missing.
> > 
> > > 
> > > This is essential to have, IMO.
> > > 
> > > You *could* do what btrfs does, where it caches the Merkle tree pages in the
> > > inode's page cache past i_size, even though btrfs stores the Merkle tree
> > > separately from the file data on-disk.
> > >
> > > However, I'd guess that the other XFS developers would have an adversion to that
> > > approach, even though it would not affect the on-disk storage.
> > 
> > Yup, on an architectural level it just seems wrong to cache secure
> > verification metadata in the same user accessible address space as
> > the data it verifies.
> > 
> > > The alternatives would be to create a separate in-memory-only inode for the
> > > cache, or to build a custom cache with its own shrinker.
> > 
> > The merkel tree blocks are cached in the XFS buffer cache.
> > 
> > Andrey, could we just add a new flag to the xfs_buf->b_flags to
> > indicate that the buffer contains verified merkle tree records?
> > i.e. if it's not set after we've read the buffer, we need to verify
> > the buffer and set th verified buffer in cache and we can skip the
> > verification?
> 
> Well, my proposal at
> https://lore.kernel.org/r/20221028224539.171818-2-ebiggers@kernel.org is to keep
> tracking the "verified" status at the individual Merkle tree block level, by
> adding a bitmap fsverity_info::hash_block_verified.  That is part of the
> fs/verity/ infrastructure, and all filesystems would be able to use it.

Yeah, i had a look at that rewrite of the verification code last
night - I get the gist of what it is doing, but a single patch of
that complexity is largely impossible to sanely review...

Correct me if I'm wrong, but won't using a bitmap with 1 bit per
verified block cause problems with contiguous memory allocation
pretty quickly? i.e. a 64kB bitmap only tracks 512k blocks, which is
only 2GB of merkle tree data. Hence at file sizes of 100+GB, the
bitmap would have to be kvmalloc()d to guarantee allocation will
succeed.

I'm not really worried about the bitmap memory usage, just that it
handles large contiguous allocations sanely. I suspect we may
eventually need a sparse bitmap (e.g. the old btrfs bit-radix
implementation) to track verification in really large files
efficiently.

> However, since it's necessary to re-verify blocks that have been evicted and
> then re-instantiated, my patch also repurposes PG_checked as an indicator for
> whether the Merkle tree pages are newly instantiated.  For a "non-page-cache
> cache", that part would need to be replaced with something equivalent.

Which we could get as a boolean state from the XFS buffer cache
fairly easily - did we find the buffer in cache, or was it read from
disk...

> A different aproach would be to make it so that every time a page (or "cache
> buffer", to call it something more generic) of N Merkle tree blocks is read,
> then all N of those blocks are verified immediately.  Then there would be no
> need to track the "verified" status of individual blocks.

That won't work with XFS - merkle tree blocks are not contiguous in
the attribute b-tree so there is no efficient "sequential bulk read"
option available. The xattr structure is largely chosen because it
allows for fast, deterministic single merkle tree block
operations....

> My concerns with that approach are:
> 
>   * Most data reads only need a single Merkle tree block at the deepest level.

Yup, see above. :)

>     If at least N tree blocks were verified any time that any were verified at
>     all, that would make the worst-case read latency worse.

*nod*

>   * It's possible that the parents of N tree blocks are split across a cache
>     buffer.  Thus, while N blocks can't have more than N parents, and in
>     practice would just have 1-2, those 2 parents could be split into two
>     separate cache buffers, with a total length of 2*N.  Verifying all of those
>     would really increase the worst-case latency as well.
> 
> So I'm thinking that tracking the "verified" status of tree blocks individually
> is the right way to go.  But I'd appreciate any other thoughts on this.

I think that having the fsverity code track verified indexes itself
is a much more felxible and self contained and the right way to go
about it.

The other issue is that verify_page() assumes that it can drop the
reference to the cached object itself - the caller actually owns the
reference to the object, not the verify_page() code. Hence if we are
passing opaque buffers to verify_page() rather page cache pages, we
need a ->drop_block method that gets called instead of put_page().
This will allow the filesystem to hold a reference to the merkle
tree block data while the verification occurs, ensuring that they
don't get reclaimed by memory pressure whilst still in use...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
