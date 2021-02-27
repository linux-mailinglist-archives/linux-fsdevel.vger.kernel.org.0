Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46734326E72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhB0Rkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 12:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhB0Rim (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 12:38:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6971964E45;
        Sat, 27 Feb 2021 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614447445;
        bh=tG4egkDj8OlEjNI6bUEakV8M22h7xiFwPQoSna2hUmI=;
        h=Date:From:To:Cc:Subject:From;
        b=FmHldItd3RW4Jl/TWZLl8pa77IkF35XD4Cvb9Vf6A9kmAVczJ5sXfigJJWk/dQ8Yf
         9dO912Ggf3TgFlN1+9u67BiaEc6K7ygkIkKhC3Pjk6jKZdbnROCrkyTb8C0hEdUNcv
         nc/Vq1ttwO7BWvQCqPY8lYLZFPOi7IJ3+GAqa+co598JofLD1lt6luUAjQLbqbSRVf
         5JFDeS0VL1E3hIAJvvRv8iHBDNfSU/PYlRzM+6rUq9cbh6fSGpKg/XBA4FQqv6CDzu
         f9L3+OTFs5emAtkVwlF7v7z7KRLn8osFA2Io2kETRWH+CvmC2oo8ObwMwtimyyp5n6
         Xouv9645GGqyA==
Date:   Sat, 27 Feb 2021 09:37:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, djwong@kernel.org
Subject: [GIT PULL] xfs: fixes for 5.12-rc1
Message-ID: <20210227173725.GE7272@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull the following branch containing some fixes to the xfs code
for 5.12-rc1.  The most notable fix here prevents premature reuse of
freed metadata blocks, and adding the ability to detect accidental
nested transactions, which are not allowed here.

This branch merges cleanly with upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit 1cd738b13ae9b29e03d6149f0246c61f76e81fcf:

  xfs: consider shutdown in bmapbt cursor delete assert (2021-02-11 08:46:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.12-merge-6

for you to fetch changes up to 756b1c343333a5aefcc26b0409f3fd16f72281bf:

  xfs: use current->journal_info for detecting transaction recursion (2021-02-25 08:07:04 -0800)

----------------------------------------------------------------
More new code for 5.12:
- Restore a disused sysctl control knob that was inadvertently dropped
  during the merge window to avoid fstests regressions.
- Don't speculatively release freed blocks from the busy list until
  we're actually allocating them, which fixes a rare log recovery
  regression.
- Don't nest transactions when scanning for free space.
- Add an idiot^Wmaintainer light to detect nested transactions. ;)

----------------------------------------------------------------
Brian Foster (1):
      xfs: don't reuse busy extents on extent trim

Darrick J. Wong (2):
      xfs: restore speculative_cow_prealloc_lifetime sysctl
      xfs: don't nest transactions when scanning for eofblocks

Dave Chinner (1):
      xfs: use current->journal_info for detecting transaction recursion

 Documentation/admin-guide/xfs.rst | 16 ++++++++++------
 fs/iomap/buffered-io.c            |  7 -------
 fs/xfs/libxfs/xfs_btree.c         | 12 ++++++++++--
 fs/xfs/xfs_aops.c                 | 17 +++++++++++++++--
 fs/xfs/xfs_extent_busy.c          | 14 --------------
 fs/xfs/xfs_sysctl.c               | 35 ++++++++++++++---------------------
 fs/xfs/xfs_trans.c                | 33 +++++++++++++++------------------
 fs/xfs/xfs_trans.h                | 30 ++++++++++++++++++++++++++++++
 8 files changed, 94 insertions(+), 70 deletions(-)
