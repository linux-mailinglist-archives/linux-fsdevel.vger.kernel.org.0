Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EF38D358
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 06:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhEVEMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 00:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhEVEMk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 00:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B9C96115C;
        Sat, 22 May 2021 04:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621656676;
        bh=EwurkRanMlH0D1hRURsdewfO3RD1xnl6lFwwsjKwGuY=;
        h=Date:From:To:Cc:Subject:From;
        b=HkhGPb9uLCNqcTzr83qZvZ8Uu58HghBav4WXrUlodQua52Ylyr1vSAa5DphFC8fsp
         JH5YNTBWudB/othv+fWwLhFUpgLtQOtLsQtHFNcM+cFS0En9XnFWgotcdrVka1o/FF
         zbK3h0/HIOZsYEw4B6Nco9t1OzxnSGJ2AM1XcUKH/E14EFEwLYFMF5N00tg55HC8ZR
         xLhpzhXXkEBMfaiwX8r1SdWqT2siglUdroWAP3Bzt8tb0AiM5KJH+kx2XrBgLfscFQ
         K9BYKDd0YR98ZB6PfsGmGrcSNsKBjLA25CfbNFGdGqDVzmlBZqW7gQweAo5F7zyNDr
         xAKTh790tpIlA==
Date:   Fri, 21 May 2021 21:11:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.13-rc3
Message-ID: <20210522041115.GB15971@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this short branch containing bug fixes for 5.13-rc3.  It's a
bunch of fixes for realtime files, crasher bugs, and fixing a minor
userspace abi regression.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-fixes-1

for you to fetch changes up to e3c2b047475b52739bcf178a9e95176c42bbcf8f:

  xfs: restore old ioctl definitions (2021-05-20 08:31:22 -0700)

----------------------------------------------------------------
Fixes for 5.13-rc3:
- Fix some math errors in the realtime allocator when extent size hints
  are applied.
- Fix unnecessary short writes to realtime files when free space is
  fragmented.
- Fix a crash when using scrub tracepoints.
- Restore ioctl uapi definitions that were accidentally removed in
  5.13-rc1.

----------------------------------------------------------------
Darrick J. Wong (4):
      xfs: adjust rt allocation minlen when extszhint > rtextsize
      xfs: retry allocations when locality-based search fails
      xfs: fix deadlock retry tracepoint arguments
      xfs: restore old ioctl definitions

 fs/xfs/libxfs/xfs_fs.h |  4 +++
 fs/xfs/scrub/common.c  |  4 ++-
 fs/xfs/xfs_bmap_util.c | 96 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 77 insertions(+), 27 deletions(-)
