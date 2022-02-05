Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4BC4AA60E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 03:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379083AbiBEC4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 21:56:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51952 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379035AbiBEC4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:56:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96EE60C70;
        Sat,  5 Feb 2022 02:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFC5C004E1;
        Sat,  5 Feb 2022 02:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644029767;
        bh=1kwLlus0RUIgFuM2NI6vWhUET3KiaxzWHY1yxoCTDOs=;
        h=Date:From:To:Cc:Subject:From;
        b=NQspIjBpnnUYRM4FR71/pvVZT/rzLYQziy6h4lJMP7357m4gQD7xhRlkJ+J+gKsCo
         tIHUBH1EEfNtMWO7W9vw5tairZuLLkaxzFzIPVxHbtzcPLncG/b+MYDHfTlGoXNnea
         K1kALJo6y6DOCXyq8wDQYsF1xXcRz8dWEwAYHfN/EEtJn8BbVZ79AZOB42hYHuWWgG
         /B0zzQhAnIskWJo4QluA2bAW2+6uBnNmfACmOXALhZvNnr5OfnpkhUPNKaysLwCqtn
         hXSc5LKFL/vsStwtVk32cAls8J6SzzD4rd9wLmvJFpbv5ZNSvayR6+YhoVpaRqetDT
         wyxr+Nb0mpIsw==
Date:   Fri, 4 Feb 2022 18:56:06 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.17-rc3
Message-ID: <20220205025606.GX8313@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing bug fixes for XFS for 5.17-rc3.
I was auditing operations in XFS that clear file privileges, and
realized that XFS' fallocate implementation drops suid/sgid but doesn't
clear file capabilities the same way that file writes and reflink do.
There are VFS helpers that do it correctly, so refactor XFS to use them.
I also noticed that we weren't flushing the log at the correct point in
the fallocate operation, so that's fixed too.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-fixes-1

for you to fetch changes up to cea267c235e1b1ec3bfc415f6bd420289bcb3bc9:

  xfs: ensure log flush at the end of a synchronous fallocate call (2022-02-01 14:14:48 -0800)

----------------------------------------------------------------
Fixes for 5.17-rc3:
 - Fix fallocate so that it drops all file privileges when files are
   modified instead of open-coding that incompletely.
 - Fix fallocate to flush the log if the caller wanted synchronous file
   updates.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: reject crazy array sizes being fed to XFS_IOC_GETBMAP*

Dave Chinner (5):
      xfs: remove XFS_PREALLOC_SYNC
      xfs: fallocate() should call file_modified()
      xfs: set prealloc flag in xfs_alloc_file_space()
      xfs: move xfs_update_prealloc_flags() to xfs_pnfs.c
      xfs: ensure log flush at the end of a synchronous fallocate call

 fs/xfs/xfs_bmap_util.c |  9 ++----
 fs/xfs/xfs_file.c      | 86 +++++++++++++++-----------------------------------
 fs/xfs/xfs_inode.h     |  9 ------
 fs/xfs/xfs_ioctl.c     |  2 +-
 fs/xfs/xfs_pnfs.c      | 42 ++++++++++++++++++++++--
 5 files changed, 69 insertions(+), 79 deletions(-)
