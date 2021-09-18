Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B44102A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhIRBcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 21:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235000AbhIRBcH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 21:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2268360FBF;
        Sat, 18 Sep 2021 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631928645;
        bh=R6m5npTjvfktMoNOyMoN0n4CEWwEAqpk6VbtJBEyFuY=;
        h=Subject:From:To:Cc:Date:From;
        b=B2HCVdY2BxXj0vcUqtWEM42DYx9M7jjjBUVo48deLUPzkqtxgEDY2WjnHZcC5EaNo
         TvhWP0XCdkF0uTnZz/cDOb5fpGthU6zzt8TIzru+GnVYKzoXkdfkRRI5EcwMLJVSy5
         lz9VoxP6uVS8hHKKOs+xlircuSXkQvAmS5KtgisNFE95QwxfII5e/mQZGMcqJGxKe4
         kQlgbaJu50u968LLj/RyZGmpilwIO3usZ13ptvKBLlcg/PpYqaeXfB4RM27JfUfEtZ
         VnwPXy12ZfsezHo20RNwhh9DAHl3Jniimtt/kNHLEZknVKBT4iiXAkEmRUIjn3PIpL
         WAsI0jMSHt9zw==
Subject: [PATCHSET RFC v2 jane 0/5] vfs: enable userspace to reset damaged
 file storage
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, jane.chu@oracle.com
Cc:     linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Sep 2021 18:30:44 -0700
Message-ID: <163192864476.417973.143014658064006895.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Jane Chu has taken an interest in trying to fix the pmem poison recovery
story on Linux.  Since I sort of had a half-baked patchset that seems to
contain some elements of what the reviewers of her patchset wanted, I'm
releasing this reworked version to see if it has any traction.

Our current "advice" to people using persistent memory and FSDAX who
wish to recover upon receipt of a media error (aka 'hwpoison') event
from ACPI is to punch-hole that part of the file and then pwrite it,
which will magically cause the pmem to be reinitialized and the poison
to be cleared.

Punching doesn't make any sense at all -- the (re)allocation on pwrite
does not permit the caller to specify where to find blocks, which means
that we might not get the same pmem back.  This pushes the user farther
away from the goal of reinitializing poisoned memory and leads to
complaints about unnecessary file fragmentation.

AFAICT, the only reason why the "punch and write" dance works at all is
that the XFS and ext4 currently call blkdev_issue_zeroout when
allocating pmem ahead of a write call.  Even a regular overwrite won't
clear the poison, because dax_direct_access is smart enough to bail out
on poisoned pmem, but not smart enough to clear it.  To be fair, that
function maps pages and has no idea what kinds of reads and writes the
caller might want to perform.

Therefore, clean up this whole mess by creating a dax_zeroinit_range
function that callers can use on poisoned persistent memory to reset the
contents of the persistent memory to a known state (all zeroes) and
clear any lingering poison state that might be lingering in the memory
controllers.  Create a new fallocate mode to trigger this functionality,
then wire up XFS and ext4 to use it.  For good measure, wire it up to
traditional storage if the storage has a fast way to zero LBA contents,
since we assume that those LBAs won't hit old media errors.

v2: change the name to zeroinit, add an explicit fallocate mode, and
    support regular block devices for non-dax files

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=zero-initialize-pmem-5.16
---
 fs/dax.c                    |   93 +++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c           |   93 +++++++++++++++++++++++++++++++++++++++++++
 fs/iomap/direct-io.c        |   75 +++++++++++++++++++++++++++++++++++
 fs/open.c                   |    5 ++
 fs/xfs/xfs_bmap_util.c      |   22 ++++++++++
 fs/xfs/xfs_bmap_util.h      |    2 +
 fs/xfs/xfs_file.c           |   11 ++++-
 fs/xfs/xfs_trace.h          |    1 
 include/linux/dax.h         |    7 +++
 include/linux/falloc.h      |    1 
 include/linux/iomap.h       |    3 +
 include/trace/events/ext4.h |    7 +++
 include/uapi/linux/falloc.h |    9 ++++
 13 files changed, 325 insertions(+), 4 deletions(-)

