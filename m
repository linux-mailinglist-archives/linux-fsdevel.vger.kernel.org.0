Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81164C3CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 07:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiLNGbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 01:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbiLNGbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:31:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928F22532;
        Tue, 13 Dec 2022 22:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9326B61806;
        Wed, 14 Dec 2022 06:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC50DC433D2;
        Wed, 14 Dec 2022 06:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670999504;
        bh=G/q5FNGbWxlaFIHROgk6HyoBAPt60p+Fbemkeg9vHLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYhzUhCaU73n2OtTVpMW5d4Hs4PZ/iN9S+Mgrp0xYYJ20iPMKDt55NLnoVfGy6jSw
         lsi18sj8zhz3igG7piz10Bn9RBEd+Wjxmc7FysMnQJaxEsFoG8d6Z9FqWNOC38NSkB
         xHH8cBxUssjKf7qm20WBiTaGpJ4G3YtQYXlHghsIkb4NKbWosmFfRJ6N3xeP2inZkD
         XbPYkl1ajGz+usYXhUeVKZhQja8xsE3wYdWXul4GGVMIoUg/qNL66S/AfI6awpdken
         XftBqUF4WUdtQDhDkno0Mel2Sg5o1JdBXVYYpIXgqeL+TN4lKcjVnoqi3uKPThG5BN
         OiXlJIYJEAh/Q==
Date:   Tue, 13 Dec 2022 22:31:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] fs-verity support for XFS
Message-ID: <Y5ltzp6yeMo1oDSk@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <Y5jllLwXlfB7BzTz@sol.localdomain>
 <20221213221139.GZ3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213221139.GZ3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 09:11:39AM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 12:50:28PM -0800, Eric Biggers wrote:
> > On Tue, Dec 13, 2022 at 06:29:24PM +0100, Andrey Albershteyn wrote:
> > > Not yet implemented:
> > > - No pre-fetching of Merkle tree pages in the
> > >   read_merkle_tree_page()
> > 
> > This would be helpful, but not essential.
> > 
> > > - No marking of already verified Merkle tree pages (each read, the
> > >   whole tree is verified).
> 
> Ah, I wasn't aware that this was missing.
> 
> > 
> > This is essential to have, IMO.
> > 
> > You *could* do what btrfs does, where it caches the Merkle tree pages in the
> > inode's page cache past i_size, even though btrfs stores the Merkle tree
> > separately from the file data on-disk.
> >
> > However, I'd guess that the other XFS developers would have an adversion to that
> > approach, even though it would not affect the on-disk storage.
> 
> Yup, on an architectural level it just seems wrong to cache secure
> verification metadata in the same user accessible address space as
> the data it verifies.
> 
> > The alternatives would be to create a separate in-memory-only inode for the
> > cache, or to build a custom cache with its own shrinker.
> 
> The merkel tree blocks are cached in the XFS buffer cache.
> 
> Andrey, could we just add a new flag to the xfs_buf->b_flags to
> indicate that the buffer contains verified merkle tree records?
> i.e. if it's not set after we've read the buffer, we need to verify
> the buffer and set th verified buffer in cache and we can skip the
> verification?

Well, my proposal at
https://lore.kernel.org/r/20221028224539.171818-2-ebiggers@kernel.org is to keep
tracking the "verified" status at the individual Merkle tree block level, by
adding a bitmap fsverity_info::hash_block_verified.  That is part of the
fs/verity/ infrastructure, and all filesystems would be able to use it.

However, since it's necessary to re-verify blocks that have been evicted and
then re-instantiated, my patch also repurposes PG_checked as an indicator for
whether the Merkle tree pages are newly instantiated.  For a "non-page-cache
cache", that part would need to be replaced with something equivalent.

A different aproach would be to make it so that every time a page (or "cache
buffer", to call it something more generic) of N Merkle tree blocks is read,
then all N of those blocks are verified immediately.  Then there would be no
need to track the "verified" status of individual blocks.

My concerns with that approach are:

  * Most data reads only need a single Merkle tree block at the deepest level.
    If at least N tree blocks were verified any time that any were verified at
    all, that would make the worst-case read latency worse.

  * It's possible that the parents of N tree blocks are split across a cache
    buffer.  Thus, while N blocks can't have more than N parents, and in
    practice would just have 1-2, those 2 parents could be split into two
    separate cache buffers, with a total length of 2*N.  Verifying all of those
    would really increase the worst-case latency as well.

So I'm thinking that tracking the "verified" status of tree blocks individually
is the right way to go.  But I'd appreciate any other thoughts on this.

- Eric
