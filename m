Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1D153B34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBEWnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 17:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbgBEWnF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:43:05 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D72214AF;
        Wed,  5 Feb 2020 22:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580942584;
        bh=nn5r09JSEA69HqCVsbRn5ZRAKkatyDwlsdVsj6TXSvg=;
        h=Date:From:To:Cc:Subject:From;
        b=v+bTsd3SYSOG83+82drqx4QCsD7STR7LWPil9yz8osY3LqRWEK7Xn4uw3r87HI2ib
         JC7qWCSMlB6+ZxzIkB79R3eGP4IZ+MSSpijveIabqAbwd3sbBy+ODSLE8R3q4sxdjo
         BhB3Wreljh++Fzh07OMNhpp5qn9InM8a999FMkYs=
Date:   Wed, 5 Feb 2020 14:43:04 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: moar new code for 5.6
Message-ID: <20200205224303.GF6870@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second batch of new changes for 5.6-rc1.  This contains
the buffer error code refactoring I mentioned last week, now that it has
had extra time to complete the full xfs fuzz testing suite to make sure
there aren't any obvious new bugs.

This merges cleanly against upstream as of about 15 minutes ago.  Note
that the -merge-7 and -merge-8 tags both point to the same ten day old
commit; the message attached to -8 reflects only the changes since last
week's pull.  Please let me know if anything odd happens during the
merge, though it should be clean.

--D

The following changes since commit b3531f5fc16d4df2b12567bce48cd9f3ab5f9131:

  xfs: remove unused variable 'done' (2020-01-23 21:24:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.6-merge-8

for you to fetch changes up to cdbcf82b86ea24aa942991b4233cd8ddf13f590c:

  xfs: fix xfs_buf_ioerror_alert location reporting (2020-01-26 14:32:27 -0800)

----------------------------------------------------------------
(More) new code for 5.6:
- Refactor the metadata buffer functions to return the usual int error
value instead of the open coded error checking mess we have now.

----------------------------------------------------------------
Darrick J. Wong (12):
      xfs: make xfs_buf_alloc return an error code
      xfs: make xfs_buf_get_map return an error code
      xfs: make xfs_buf_read_map return an error code
      xfs: make xfs_buf_get return an error code
      xfs: make xfs_buf_get_uncached return an error code
      xfs: make xfs_buf_read return an error code
      xfs: make xfs_trans_get_buf_map return an error code
      xfs: make xfs_trans_get_buf return an error code
      xfs: remove the xfs_btree_get_buf[ls] functions
      xfs: make xfs_*read_agf return EAGAIN to ALLOC_FLAG_TRYLOCK callers
      xfs: remove unnecessary null pointer checks from _read_agf callers
      xfs: fix xfs_buf_ioerror_alert location reporting

 fs/xfs/libxfs/xfs_ag.c          |  21 +++---
 fs/xfs/libxfs/xfs_alloc.c       |  51 ++++++-------
 fs/xfs/libxfs/xfs_attr_remote.c |  22 ++----
 fs/xfs/libxfs/xfs_bmap.c        |  25 ++++---
 fs/xfs/libxfs/xfs_btree.c       |  45 +----------
 fs/xfs/libxfs/xfs_btree.h       |  21 ------
 fs/xfs/libxfs/xfs_da_btree.c    |   8 +-
 fs/xfs/libxfs/xfs_ialloc.c      |  12 +--
 fs/xfs/libxfs/xfs_refcount.c    |   6 --
 fs/xfs/libxfs/xfs_sb.c          |  17 +++--
 fs/xfs/scrub/agheader_repair.c  |   4 -
 fs/xfs/scrub/fscounters.c       |   3 -
 fs/xfs/scrub/repair.c           |  10 ++-
 fs/xfs/xfs_attr_inactive.c      |  17 +++--
 fs/xfs/xfs_buf.c                | 161 ++++++++++++++++++++++++----------------
 fs/xfs/xfs_buf.h                |  33 ++++----
 fs/xfs/xfs_buf_item.c           |   2 +-
 fs/xfs/xfs_discard.c            |   2 +-
 fs/xfs/xfs_dquot.c              |   8 +-
 fs/xfs/xfs_filestream.c         |  11 ++-
 fs/xfs/xfs_inode.c              |  12 +--
 fs/xfs/xfs_log_recover.c        |  30 +++-----
 fs/xfs/xfs_reflink.c            |   2 -
 fs/xfs/xfs_rtalloc.c            |   8 +-
 fs/xfs/xfs_symlink.c            |  37 +++------
 fs/xfs/xfs_trans.h              |  14 ++--
 fs/xfs/xfs_trans_buf.c          |  61 ++++++---------
 27 files changed, 278 insertions(+), 365 deletions(-)
