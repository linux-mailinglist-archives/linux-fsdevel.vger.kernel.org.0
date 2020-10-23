Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0B297928
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 23:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756992AbgJWVzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 17:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756951AbgJWVzv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:55:51 -0400
Received: from localhost (unknown [148.87.23.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B65A208E4;
        Fri, 23 Oct 2020 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603490150;
        bh=fr3ruBddVg9TlYCp+CZnRfHx6VcGZUDFahrT/xtZW+U=;
        h=Date:From:To:Cc:Subject:From;
        b=BOxKeBFpabXA4pwnuplRivXSyq1MHzNvEoaJst5oSUzrBz361816qRxhRI9iV4A16
         iSHdTVd/53EEKAKBl6Wm5cwv82bgt0eS5XZQ4mWC5/Nedtw/qq0YMWW7Qwwg0SRR54
         qF56ZddI6GavOw4KQar009mKnoCaAgnbwrqrfZ0Q=
Date:   Fri, 23 Oct 2020 14:55:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.10-rc1
Message-ID: <20201023215546.GU9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this nice short branch, which integrates two bug fixes that
trickled in during the merge window.

The branch merges cleanly with upstream as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit 894645546bb12ce008dcba0f68834d270fcd1dde:

  xfs: fix Kconfig asking about XFS_SUPPORT_V4 when XFS_FS=n (2020-10-16 15:34:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-merge-7

for you to fetch changes up to 2e76f188fd90d9ac29adbb82c30345f84d04bfa4:

  xfs: cancel intents immediately if process_intents fails (2020-10-21 16:28:46 -0700)

----------------------------------------------------------------
Fixes for 5.10-rc1:
- Make fallocate check the alignment of its arguments against the
fundamental allocation unit of the volume the file lives on, so that we
don't trigger the fs' alignment checks.
- Cancel unprocessed log intents immediately when log recovery fails, to
avoid a log deadlock.

----------------------------------------------------------------
Darrick J. Wong (2):
      xfs: fix fallocate functions when rtextsize is larger than 1
      xfs: cancel intents immediately if process_intents fails

 fs/xfs/xfs_bmap_util.c   | 18 +++++-------------
 fs/xfs/xfs_file.c        | 40 +++++++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_linux.h       |  6 ++++++
 fs/xfs/xfs_log_recover.c |  8 ++++++++
 4 files changed, 54 insertions(+), 18 deletions(-)
