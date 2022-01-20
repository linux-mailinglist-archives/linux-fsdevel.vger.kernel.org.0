Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94023495487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 19:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377377AbiATS7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 13:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346922AbiATS7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:59:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87623C061574;
        Thu, 20 Jan 2022 10:59:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B357E617BE;
        Thu, 20 Jan 2022 18:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEA8C340E0;
        Thu, 20 Jan 2022 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642705161;
        bh=Uz+ErrzCvsPs8XI14OrT140VYUl1+xldNmUfTLio22M=;
        h=Date:From:To:Cc:Subject:From;
        b=ATDC0bEoLEh2/8T7ESqS8zsslSvruR+pnXqkSrY9LpKZ1kD3kMN3rs2G3xleWnGRK
         CeaCh/bGZl7EKxv2IOv/1/w2ZjC8Tqq78K1Da1yP8RaqkVuc9PYSGXHRxAaDcpi4kg
         2iK6AboStWMRHLU+dr5Qq0JW5KZQHact99A2KSnD/HTbyoIcrWDwXiDYj4usILNaiy
         M6c49exdlFi6WKp7Cj3jBLUuIWG89IfhZjib//UINlIHJMe8/KnV+WR+dpaj+MtKaK
         JMDRrRYW9tERQY1Hi06Sksz5uOD3FYkJW0NHHXM49VQL0LFpT24cOw68UqnrDjJ7Ci
         UHX/KB4xrmOvQ==
Date:   Thu, 20 Jan 2022 10:59:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: legacy Irix ioctl housecleaning for 5.17-rc1, part 2
Message-ID: <20220120185920.GP13540@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

This is the third and final of a series of small pull requests that
perform some long overdue housecleaning of XFS ioctls.  This time, we're
withdrawing all variants of the ALLOCSP and FREESP ioctls from XFS'
userspace API.  This might be a little premature since we've only just
removed the functionality, but as I pointed out in the last pull
request, nobody (including fstests) noticed that it was broken for 20
years.

In response to the patch, we received a single comment from someone who
stated that they 'augment' the ioctl for their own purposes, but
otherwise acquiesced to the withdrawal.  I still want to try to clobber
these old ioctl definitions in 5.17, but if you decide that we should
wait longer, I can work with that.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit 4d1b97f9ce7c0d2af2bb85b12d48e6902172a28e:

  xfs: kill the XFS_IOC_{ALLOC,FREE}SP* ioctls (2022-01-17 09:16:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-6

for you to fetch changes up to b3bb9413e717b44e4aea833d07f14e90fb91cf97:

  xfs: remove the XFS_IOC_{ALLOC,FREE}SP* definitions (2022-01-17 09:17:11 -0800)

----------------------------------------------------------------
Withdraw the XFS_IOC_ALLOCSP* and XFS_IOC_FREESP* ioctl definitions.

Remove the header definitions for these ioctls.  The just-removed
implementation has allowed callers to read stale disk contents for more
than **21 years** and nobody noticed or complained, which implies a lack
of users aside from exploit programs.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: remove the XFS_IOC_{ALLOC,FREE}SP* definitions

 fs/xfs/libxfs/xfs_fs.h | 8 ++++----
 fs/xfs/xfs_ioctl.c     | 9 +++++++++
 fs/xfs/xfs_ioctl32.h   | 4 ----
 3 files changed, 13 insertions(+), 8 deletions(-)
