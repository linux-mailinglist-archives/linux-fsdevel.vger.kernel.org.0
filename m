Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4128F1B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfHORNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 13:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730932AbfHORNs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:13:48 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7249205F4;
        Thu, 15 Aug 2019 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565889227;
        bh=OKnNdaFflk01RelsesjLPMicKWo1UdpFSgHbeCLxf00=;
        h=Date:From:To:Cc:Subject:From;
        b=s1NtQV4QDwfCIanOxEY6gJfURskShQ6M/q1if21UG/eHis2DblrJwMwSd6PzILckR
         Fi7SD5Fswtg62p6PaWtXYs3bN54YA6idXgjrw4EKXof2HwPcZl/ESqJHyF3ZOhDJxs
         Flkp1XUVtJ+edDIni5EjmwJ8bdac7XHT6Q3x9cOM=
Date:   Thu, 15 Aug 2019 10:13:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.3-rc5
Message-ID: <20190815171347.GD15186@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here are a few more bug fixes that trickled in since -rc3.  It's
survived the usual xfstests runs and merges cleanly with this morning's
master.  Please let me know if anything strange happens.

--D

The following changes since commit afa1d96d1430c2138c545fb76e6dcb21222098d4:

  xfs: Fix possible null-pointer dereferences in xchk_da_btree_block_check_sibling() (2019-07-30 11:28:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-fixes-2

for you to fetch changes up to 8612de3f7ba6e900465e340516b8313806d27b2d:

  xfs: don't crash on null attr fork xfs_bmapi_read (2019-08-12 09:32:44 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix crashes when the attr fork isn't present due to errors but inode
  inactivation tries to zap the attr data anyway.
- Convert more directory corruption debugging asserts to actual
  EFSCORRUPTED returns instead of blowing up later on.
- Don't fail writeback just because we ran out of memory allocating
  metadata log data.

----------------------------------------------------------------
Darrick J. Wong (2):
      xfs: remove more ondisk directory corruption asserts
      xfs: don't crash on null attr fork xfs_bmapi_read

Tetsuo Handa (1):
      fs: xfs: xfs_log: Don't use KM_MAYFAIL at xfs_log_reserve().

 fs/xfs/libxfs/xfs_bmap.c      | 29 +++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_da_btree.c  | 19 ++++++++++++-------
 fs/xfs/libxfs/xfs_dir2_node.c |  3 ++-
 fs/xfs/xfs_log.c              |  5 +----
 4 files changed, 36 insertions(+), 20 deletions(-)
