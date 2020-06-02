Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C561EC0E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 19:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgFBRZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 13:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgFBRZv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:25:51 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F452068D;
        Tue,  2 Jun 2020 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591118751;
        bh=BKGcxnycRsYmacJ65+dG6H2NfGLKvm6eXJrUb+JxQ2c=;
        h=Date:From:To:Cc:Subject:From;
        b=R8pKIgFFzaZ4XegA/75oYHzQgfiFDiZKWkM5JxZatAKxpQljeGCaxMEQpCkdoMhNu
         j0pBTqby+DIpaYEFNRzm6sWUSpCKqYpzmv4Xars+qzUVErycCNXiyMhGC9pywI2ML3
         spck6YBUuZdetclcx5MIkJo2eb2rlEnfoIk8cBuc=
Date:   Tue, 2 Jun 2020 10:25:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, ira.weiny@intel.com
Subject: [GIT PULL] vfs: improve DAX behavior for 5.8, part 2
Message-ID: <20200602172550.GF8204@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second part of the 5.8 DAX changes.  This time around,
we're hoisting the DONTCACHE flag from XFS into the VFS so that we can
make the incore DAX mode changes become effective sooner.

We can't change the file data access mode on a live inode because we
don't have a safe way to change the file ops pointers.  The incore state
change becomes effective at inode loading time, which can happen if the
inode is evicted.  Therefore, we're making it so that filesystems can
ask the VFS to evict the inode as soon as the last holder drops.  The
per-fs changes to make this call this will be in subsequent pull
requests from Ted and myself.

I did a test merge of this branch against upstream this morning and
there weren't any conflicts.  Please let us know if you have any
complaints about pulling this.

--D

The following changes since commit 83d9088659e8f113741bb197324bd9554d159657:

  Documentation/dax: Update Usage section (2020-05-04 08:49:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.8-merge-2

for you to fetch changes up to 2c567af418e3f9380c2051aada58b4e5a4b5c2ad:

  fs: Introduce DCACHE_DONTCACHE (2020-05-13 08:44:35 -0700)

----------------------------------------------------------------
(More) new code for 5.8:
- Introduce DONTCACHE flags for dentries and inodes.  This hint will
  cause the VFS to drop the associated objects immediately after the
  last put, so that we can change the file access mode (DAX or page
  cache) on the fly.

----------------------------------------------------------------
Ira Weiny (2):
      fs: Lift XFS_IDONTCACHE to the VFS layer
      fs: Introduce DCACHE_DONTCACHE

 fs/dcache.c            | 19 +++++++++++++++++++
 fs/xfs/xfs_icache.c    |  4 ++--
 fs/xfs/xfs_inode.h     |  3 +--
 fs/xfs/xfs_super.c     |  2 +-
 include/linux/dcache.h |  2 ++
 include/linux/fs.h     |  7 ++++++-
 6 files changed, 31 insertions(+), 6 deletions(-)
