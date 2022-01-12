Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF35B48C931
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355536AbiALRTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 12:19:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59540 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348434AbiALRTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:19:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E4ECB81F47
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 17:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80A8C36AEA;
        Wed, 12 Jan 2022 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642007977;
        bh=o4t9U0eYLfqHTIBmy++CHkJ+gEPvd4uI1Gekf+xhCng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P83jDWg9wPnwg99E7rOT8E5xfPyQK2mStynhV57nj3IMZQwgaHQw0Ea0Q0EGetGIK
         pC4J6e+oG57m928hhTCTAUbEVzwjFnlAQM4j+BVymLHRPzg+K0wLTjY6VAUJ+abEjs
         sFlo0sgbPnZOYw9nu9DfIXmS7kcU3bzjVLcx6gTVZKlEfl2bXSISzTAVQsrN6Q981W
         0GcsvPdnykc697cOu5VIwVNEFKINNgcj0YHiYmvHkiQJHODsLITaRYjV472fviVmk+
         Hs5kTNyoKAmiwfGsMO3dF63b79Wyp2yrNQWdw/4/JIWwDtHJ4Y7CpomiICUuNSczsv
         pW7q+dViBJGHQ==
Date:   Wed, 12 Jan 2022 09:19:37 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: unusual behavior of loop dev with backing file in tmpfs
Message-ID: <20220112171937.GA19154@magnolia>
References: <20211126075100.gd64odg2bcptiqeb@work>
 <5e66a9-4739-80d9-5bb5-cbe2c8fef36@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e66a9-4739-80d9-5bb5-cbe2c8fef36@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 08:28:02PM -0800, Hugh Dickins wrote:
> On Fri, 26 Nov 2021, Lukas Czerner wrote:
> > 
> > I've noticed unusual test failure in e2fsprogs testsuite
> > (m_assume_storage_prezeroed) where we use mke2fs to create a file system
> > on loop device backed in file on tmpfs. For some reason sometimes the
> > resulting file number of allocated blocks (stat -c '%b' /tmp/file) differs,
> > but it really should not.
> > 
> > I was trying to create a simplified reproducer and noticed the following
> > behavior on mainline kernel (v5.16-rc2-54-g5d9f4cf36721)
> > 
> > # truncate -s16M /tmp/file
> > # stat -c '%b' /tmp/file
> > 0
> > 
> > # losetup -f /tmp/file
> > # stat -c '%b' /tmp/file
> > 672
> > 
> > That alone is a little unexpected since the file is really supposed to
> > be empty and when copied out of the tmpfs, it really is empty. But the
> > following is even more weird.
> > 
> > We have a loop setup from above, so let's assume it's /dev/loop0. The
> > following should be executed in quick succession, like in a script.
> > 
> > # dd if=/dev/zero of=/dev/loop0 bs=4k
> > # blkdiscard -f /dev/loop0
> > # stat -c '%b' /tmp/file
> > 0
> > # sleep 1
> > # stat -c '%b' /tmp/file
> > 672
> > 
> > Is that expected behavior ? From what I've seen when I use mkfs instead
> > of this simplified example the number of blocks allocated as reported by
> > stat can vary a quite a lot given more complex operations. The file itself
> > does not seem to be corrupted in any way, so it is likely just an
> > accounting problem.
> > 
> > Any idea what is going on there ?
> 
> I have half an answer; but maybe you worked it all out meanwhile anyway.
> 
> Yes, it happens like that for me too: 672 (but 216 on an old installation).
> 
> Half the answer is that funny code at the head of shmem_file_read_iter():
> 	/*
> 	 * Might this read be for a stacking filesystem?  Then when reading
> 	 * holes of a sparse file, we actually need to allocate those pages,
> 	 * and even mark them dirty, so it cannot exceed the max_blocks limit.
> 	 */
> 	if (!iter_is_iovec(to))
> 		sgp = SGP_CACHE;
> which allocates pages to the tmpfs for reads from /dev/loop0; whereas
> normally a read of a sparse tmpfs file would just give zeroes without
> allocating.
> 
> [Do we still need that code? Mikulas asked 18 months ago, and I never
> responded (sorry) because I failed to arrive at an informed answer.
> It comes from a time while unionfs on tmpfs was actively developing,
> and solved a real problem then; but by the time it went into tmpfs,
> unionfs had already been persuaded to proceed differently, and no
> longer needed it. I kept it in for indeterminate other stacking FSs,
> but it's probably just culted cargo, doing more harm than good. I
> suspect the best thing to do is, after the 5.17 merge window closes,
> revive Mikulas's patch to delete it and see if anyone complains.]

I for one wouldn't mind if tmpfs no longer instantiated cache pages for
a read from a hole -- it's a little strange, since most disk filesystems
(well ok xfs and ext4, haven't checked the others) don't do that.
Anyone who really wants a preallocated page should probably be using
fallocate or something...

--D

> But what is asynchronously reading /dev/loop0 (instantiating pages
> initially, and reinstantiating them after blkdiscard)? I assume it's
> some block device tracker, trying to read capacity and/or partition
> table; whether from inside or outside the kernel, I expect you'll
> guess much better than I can.
> 
> Hugh
