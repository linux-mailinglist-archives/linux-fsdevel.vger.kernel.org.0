Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAE64D69B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 07:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLOGro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 01:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOGrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:47:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DAD3E0BF;
        Wed, 14 Dec 2022 22:47:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E6B8B81A26;
        Thu, 15 Dec 2022 06:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0423AC433EF;
        Thu, 15 Dec 2022 06:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671086859;
        bh=tY1pH6u316sgaqlU1fqZ7NzWxeOJOnB62LOoW3a5ljE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgzBkdCF2tSJ3KQgbq9KSDciEMgwfOLZ2fQ+fuuyx/eIdduS7mAAiXANh4uAMg1DE
         huO/dZdVrsBGjvQpM1Q1hL+C5VMRTUiJ9JyJvGcNaAziD/UlisTi9SFz8rz/5Dj7YI
         0irU9qmnLRhwgYd9HQpqydhbsfDHPtz6p0p8gudcYk86LKbTFjq2Qg8qYwBQoG7oLA
         k/KFeK7xfoqri64UFCqjTIE5rwzChBpM+/Kt4/qeEKiT3BggXxwDHHVUyhzln2EQtY
         AKaLiJiV/9BwpNdg3ua2Sie/F8PbDKxO1g3OcnYxCmWrk/sb/XXci4NzvPk9gKPLLu
         aHmDnqpts+TUw==
Date:   Wed, 14 Dec 2022 22:47:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] fs-verity support for XFS
Message-ID: <Y5rDCcYGgH72Wn/e@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <Y5jllLwXlfB7BzTz@sol.localdomain>
 <20221213221139.GZ3600936@dread.disaster.area>
 <Y5ltzp6yeMo1oDSk@sol.localdomain>
 <20221214230632.GA1971568@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214230632.GA1971568@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:06:32AM +1100, Dave Chinner wrote:
> > Well, my proposal at
> > https://lore.kernel.org/r/20221028224539.171818-2-ebiggers@kernel.org is to keep
> > tracking the "verified" status at the individual Merkle tree block level, by
> > adding a bitmap fsverity_info::hash_block_verified.  That is part of the
> > fs/verity/ infrastructure, and all filesystems would be able to use it.
> 
> Yeah, i had a look at that rewrite of the verification code last
> night - I get the gist of what it is doing, but a single patch of
> that complexity is largely impossible to sanely review...

Thanks for taking a look at it.  It doesn't really lend itself to being split
up, unfortunately, but I'll see what I can do.

> Correct me if I'm wrong, but won't using a bitmap with 1 bit per
> verified block cause problems with contiguous memory allocation
> pretty quickly? i.e. a 64kB bitmap only tracks 512k blocks, which is
> only 2GB of merkle tree data. Hence at file sizes of 100+GB, the
> bitmap would have to be kvmalloc()d to guarantee allocation will
> succeed.
> 
> I'm not really worried about the bitmap memory usage, just that it
> handles large contiguous allocations sanely. I suspect we may
> eventually need a sparse bitmap (e.g. the old btrfs bit-radix
> implementation) to track verification in really large files
> efficiently.

Well, that's why my patch uses kvmalloc() to allocate the bitmap.

I did originally think it was going to have to be a sparse bitmap that ties into
the shrinker so that pages of it can be evicted.  But if you do the math, the
required bitmap size is only 1 / 2^22 the size of the file, assuming the Merkle
tree uses SHA-256 and 4K blocks.  So a 100MB file only needs a 24-byte bitmap,
and the bitmap for any file under 17GB fits in a 4K page.

My patch puts an arbitrary limit at a 1 MiB bitmap, which would be a 4.4TB file.

It's not ideal to say "4 TB Ought To Be Enough For Anybody".  But it does feel
that it's not currently worth the extra complexity and runtime overhead of
implementing a full-blown sparse bitmap with cache eviction support, when no one
currently has a use case for fsverity on files anywhere near that large.

> The other issue is that verify_page() assumes that it can drop the
> reference to the cached object itself - the caller actually owns the
> reference to the object, not the verify_page() code. Hence if we are
> passing opaque buffers to verify_page() rather page cache pages, we
> need a ->drop_block method that gets called instead of put_page().
> This will allow the filesystem to hold a reference to the merkle
> tree block data while the verification occurs, ensuring that they
> don't get reclaimed by memory pressure whilst still in use...

Yes, probably the prototype of ->read_merkle_tree_page will need to change too.

- Eric
