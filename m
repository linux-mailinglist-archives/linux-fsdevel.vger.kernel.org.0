Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36466C924B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 05:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCZDyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 23:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCZDyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:54:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3CEB463
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Mar 2023 20:54:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32Q3s3vZ023021
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 23:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679802845; bh=WWo2bF3fYztcOcL8hQceNWz6QQ5YZudqVE2VOlWqgwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Kz9fEgd+mA6LU16FY2vXdTzZPJrKnDCPwVvL25XwvPcV8SF3jETqwCP7xcPZNDoRH
         3yTeH91J1u/Bj44ae5Ipp1ebiqBnsaHLDiyUVcmJmuzammXRKqryFxuSS6uYUUTgL8
         5qAI81lL/4ypY8I/K31ORNEN0SEjgQDnT4r0wq/GHSlYODg3go86SJcDV7EakYovw9
         uWjpKyIDxy8tW4OVwNxOeDlksdNVWoFgqMIx8BW2oS+kHmeLP0aXmCXJgXZTVwKOvw
         CCuFig14CMO+K+TmVYCGQnjeMc5n9k7LO3g1e9gRtTELPsONo5URXkPfbqZ254U0Bi
         MKmV8BV5QmU0w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F1EBD15C46FF; Sat, 25 Mar 2023 23:54:02 -0400 (EDT)
Date:   Sat, 25 Mar 2023 23:54:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [RFC 08/11] ext4: Don't skip prefetching BLOCK_UNINIT groups
Message-ID: <20230326035402.GA323408@mit.edu>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <4881693a4f5ba1fed367310b27c793e4e78520d3.1674822311.git.ojaswin@linux.ibm.com>
 <20230309141422.b2nbl554ngna327k@quack3>
 <ZBRHCHySeQ0KC/f7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBRHCHySeQ0KC/f7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 17, 2023 at 04:25:04PM +0530, Ojaswin Mujoo wrote:
> > > This improves the accuracy of CR0/1 allocation as earlier, we could have
> > > essentially empty BLOCK_UNINIT groups being ignored by CR0/1 due to their buddy
> > > not being initialized, leading to slower CR2 allocations. With this patch CR0/1
> > > will be able to discover these groups as well, thus improving performance.
> >
> > The patch looks good. I just somewhat wonder - this change may result in
> > uninitialized groups being initialized and used earlier (previously we'd
> > rather search in other already initialized groups) which may spread
> > allocations more. But I suppose that's fine and uninit groups are not
> > really a feature meant to limit fragmentation and as the filesystem ages
> > the differences should be minimal. So feel free to add:
> 
> Another point I wanted to discuss wrt this patch series was why were the
> BLOCK_UNINIT groups not being prefetched earlier. One point I can think
> of is that this might lead to memory pressure when we have too many
> empty BGs in a very large (say terabytes) disk.

Originally the prefetch logic was simply something to optimize I/O ---
that is, normally, all of the block bitmaps for a flex_bg are
contiguous, so why not just read them all in a single I/O which is
issued all at once, instead of doing them as separate 4k reads.

Skipping block groups that hadn't yet been prefetched was something
which was added later, in order to improve performance of the
allocator for freshly mounted file systems where the prefetch hadn't
yet had a chance to pull in block bitmaps; the problem was that if the
block groups hadn't been prefetch yet, then the cr0 scan would fetch
them, and if you have a storage device where blocks with monotonically
increasing LBA numbers aren't necessarily stored adjacently on disk
(for example, on a dm-thin volume, but if one were to do an experiment
on certain emulated block devices on certain hyperscalar cloud
environments, one might find a similar performance profile), resulting
in a cr0 scan potentially issuing a series of 16 sequential 4k I/O's,
that could be substantially worse from a performance standpoint than
doing a single squential 64k I/O.

When this change was made, the focus was on *initialized* bitmaps
taking a long time if they were issued as individual sequential 4k
I/O's; the fix was to skip scanning them initially, since the hope was
that the prefetch would pull them in fairly quickly, and a few bad
allocations when the file system was freshly mounted was an acceptable
tradeoff.

But prefetching prefetching BLOCK_UNINIT groups makes sense, that
should fix the problem that you've identified (at least for
BLOCK_UNINIT groups; for initialized block bitmaps, we'll still have
less optimal allocation patterns until we've managed to prefetch those
block groups).

Cheers,

					0 Ted
