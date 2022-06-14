Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144D54A8B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 07:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiFNFZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 01:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiFNFZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:25:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDDB26AC4;
        Mon, 13 Jun 2022 22:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15EF6CE181B;
        Tue, 14 Jun 2022 05:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9603C3411B;
        Tue, 14 Jun 2022 05:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655184315;
        bh=yVv5NBSoS8jRKy5ozRnvXgCu1M0fCe/nJRys6szNJx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3vMc4a/nCEXDbFNP/4wKJ/IRtOdNoppRm3KT6glab4LkOZA75EmhzGbtaA1xJ+t3
         zvkLdo81p05dnXKT+qKQuo6DrZwA4lYN2s4XqyUV53L250GdKda6QGguEubwN+2Tiu
         d4A9dR7WcBIqi94WqvepH+Mo3dRm4pzTy62UhK2d0tWAEz0EaNQA/qG3VSjqGh/ZGP
         BfUQkMRf8IKtoMh07F+Bm4ksrN2SWxyqmzziAxnkoynG7uOflh+qdDkUkyMvYFq2EJ
         VUGOVK9SwNY9c0UT3JGvInxETeshxNeq+5qJGUa9Q4x+rKmPDCLKDNxg8c1GJk61r1
         KqP5kl72VRMGw==
Date:   Mon, 13 Jun 2022 22:25:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <YqgbuDbdH2OLcbC7@sol.localdomain>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520032739.GB1098723@dread.disaster.area>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 01:27:39PM +1000, Dave Chinner wrote:
> > > * stx_offset_align_optimal: the alignment (in bytes) suggested for file
> > >   offsets and I/O segment lengths to get optimal performance.  This
> > >   applies to both DIO and buffered I/O.  It differs from stx_blocksize
> > >   in that stx_offset_align_optimal will contain the real optimum I/O
> > >   size, which may be a large value.  In contrast, for compatibility
> > >   reasons stx_blocksize is the minimum size needed to avoid page cache
> > >   read/write/modify cycles, which may be much smaller than the optimum
> > >   I/O size.  For more details about the motivation for this field, see
> > >   https://lore.kernel.org/r/20220210040304.GM59729@dread.disaster.area
> > 
> > Hmm.  So I guess this is supposed to be the filesystem's best guess at
> > the IO size that will minimize RMW cycles in the entire stack?  i.e. if
> > the user does not want RMW of pagecache pages, of file allocation units
> > (if COW is enabled), of RAID stripes, or in the storage itself, then it
> > should ensure that all IOs are aligned to this value?
> > 
> > I guess that means for XFS it's effectively max(pagesize, i_blocksize,
> > bdev io_opt, sb_width, and (pretend XFS can reflink the realtime volume)
> > the rt extent size)?  I didn't see a manpage update for statx(2) but
> > that's mostly what I'm interested in. :)
> 
> Yup, xfs_stat_blksize() should give a good idea of what we should
> do. It will end up being pretty much that, except without the need
> to a mount option to turn on the sunit/swidth return, and always
> taking into consideration extent size hints rather than just doing
> that for RT inodes...

While working on the man-pages update, I'm having second thoughts about the
stx_offset_align_optimal field.  Does any filesystem other than XFS actually
want stx_offset_align_optimal, when st[x]_blksize already exists?  Many network
filesystems, as well as tmpfs when hugepages are enabled, already report large
(megabytes) sizes in st[x]_blksize.  And all documentation I looked at (man
pages for Linux, POSIX, FreeBSD, NetBSD, macOS) documents st_blksize as
something like "the preferred blocksize for efficient I/O".  It's never
documented as being limited to PAGE_SIZE, which makes sense because it's not.

So stx_offset_align_optimal seems redundant, and it is going to confuse
application developers who will have to decide when to use st[x]_blksize and
when to use stx_offset_align_optimal.

Also, applications that don't work well with huge reported optimal I/O sizes
would still continue to exist, as it will remain possible for applications to
only be tested on filesystems that report a small optimal I/O size.

Perhaps for now we should just add STATX_DIOALIGN instead of STATX_IOALIGN,
leaving out the stx_offset_align_optimal field?  What do people think?

- Eric
