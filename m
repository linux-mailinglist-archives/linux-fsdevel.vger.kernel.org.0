Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3DB50FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfIQPGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 11:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfIQPGK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:06:10 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA7D20665;
        Tue, 17 Sep 2019 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568732769;
        bh=SDG5YpF85LDl7cxtILkzcLro5V+SIvuaeeWO/xetNPc=;
        h=Date:From:To:Cc:Subject:From;
        b=L4MGQ8vdegQAMJWZvefCan9LNmZ58YKbkSOalMHxvO0HWyV0pmFh1Ux7JqwFOW68O
         mCGBhYjjy1+ryMK52xSHfJQua12b18hMCxbKZNbPuOyslbAj0VL4Avpn+vFS73QMQF
         zChusAZY9pyCaARcI1IJL6QMmjaAJ3A8JgTG6/KI=
Date:   Tue, 17 Sep 2019 08:06:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] vfs: prohibit writes to active swap devices
Message-ID: <20190917150608.GT2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this short series that prevents writes to active swap files
and swap devices.  There's no non-malicious use case for allowing
userspace to scribble on storage that the kernel thinks it owns.

The branch merges cleanly against this morning's HEAD and survived an
overnight run of xfstests.  The merge was completely straightforward, so
please let me know if you run into anything weird.

--D

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.4-merge-1

for you to fetch changes up to dc617f29dbe5ef0c8ced65ce62c464af1daaab3d:

  vfs: don't allow writes to swap files (2019-08-20 07:55:16 -0700)

----------------------------------------------------------------
Changes for 5.4:
- Prohibit writing to active swap files and swap partitions.

----------------------------------------------------------------
Darrick J. Wong (2):
      mm: set S_SWAPFILE on blockdev swap devices
      vfs: don't allow writes to swap files

 fs/block_dev.c     |  3 +++
 include/linux/fs.h | 11 +++++++++++
 mm/filemap.c       |  3 +++
 mm/memory.c        |  4 ++++
 mm/mmap.c          |  8 ++++++--
 mm/swapfile.c      | 41 +++++++++++++++++++++++++----------------
 6 files changed, 52 insertions(+), 18 deletions(-)
