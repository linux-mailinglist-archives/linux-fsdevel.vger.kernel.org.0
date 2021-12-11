Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA24714E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhLKRWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 12:22:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59644 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhLKRWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:22:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 300BCB807E7;
        Sat, 11 Dec 2021 17:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC295C004DD;
        Sat, 11 Dec 2021 17:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639243363;
        bh=El6ouO7d2qFEnbF2ztCBnEVpl9HgaAVXZ8f7fX/HH84=;
        h=Date:From:To:Cc:Subject:From;
        b=daXfTlTI/6JF1AFFjVl66cGwweFx3XW3o5ScqTwPfuAtWRwQ3hCZ9f+zPuWcDpkMU
         GIEzoF2k6xK0uO+3NHJ6FHBS+BwId1qQ6o7BozKkXM08KNKKxXbv/8WawxLrHHm7+k
         0BnAcOkt0wmPmROwx468stzs1PLu2CyQ6qRpHMqC1sAObzDuXZiAqpIKkjvG0AIO7m
         JmK9oJnSDP/eeNIAwaSlfHLgjAYMMP8VnZ/flNnGve5ZsKk+PmA+0zrAKJmZv+9KaQ
         BQh4z3hLVzh5wS8UHYGLnm+eO7zE9CY2Pd52Qi0a93A+kxgmoiSOL5EgulZN0vMRzd
         KQ4iFfmSaKhFQ==
Date:   Sat, 11 Dec 2021 09:22:42 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: bug fixes for 5.16-rc4
Message-ID: <20211211172242.GH1218082@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch for 5.16-rc4 that fixes a race between a
readonly remount process and other processes that hold a file IOLOCK on
files that previously experienced copy on write, that could result in
severe filesystem corruption if the filesystem is then remounted rw.  I
think this is fairly rare (since the only reliable reproducer I have
that fits the second criteria is the experimental xfs_scrub program),
but the race is clear, so we still need to fix this.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit e445976537ad139162980bee015b7364e5b64fff:

  xfs: remove incorrect ASSERT in xfs_rename (2021-12-01 17:27:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-3

for you to fetch changes up to 089558bc7ba785c03815a49c89e28ad9b8de51f9:

  xfs: remove all COW fork extents when remounting readonly (2021-12-07 10:17:29 -0800)

----------------------------------------------------------------
Fixes for 5.16-rc4:
 - Fix a data corruption vector that can result from the ro remount
   process failing to clear all speculative preallocations from files
   and the rw remount process not noticing the incomplete cleanup.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: remove all COW fork extents when remounting readonly

 fs/xfs/xfs_super.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)
