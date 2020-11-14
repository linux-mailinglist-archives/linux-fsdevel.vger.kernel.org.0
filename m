Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D52B2970
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 01:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKNABb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 19:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgKNABa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:01:30 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E482078B;
        Sat, 14 Nov 2020 00:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605312090;
        bh=EjqbvPtBYQV9DDkqjO57xOYixIqB5yYPohHvrWLav/w=;
        h=Date:From:To:Cc:Subject:From;
        b=xwLHDddunMelO06WApHfTGDTPpzifjkU5k7o17/1xDPG3e0HwcnqUHJOG3SQDUkCd
         MbZFUuiHvOhJYRIC4Hb/4ZEoRJW4cfcvRlCN+lT6LBrHbZvONUIb8+Qm340K+Rs6iY
         VgeZKzDTq9YspoNLUr06ruXdY4lN4lQQRcjhVyS8=
Date:   Fri, 13 Nov 2020 16:01:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        david@fromorbit.com, fdmanana@kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] vfs: fs freeze fix for 5.10-rc4 (part 2)
Message-ID: <20201114000129.GY9695@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

The bug fix in the vfs pull request that I just sent you makes
__sb_start_write simple enough that it becomes possible to refactor the
function into smaller, simpler static inline helpers in linux/fs.h.  The
cleanup is straightforward, but as we're well into the stabilization
phase for 5.10, I'm perfectly happy to defer this to 5.11.

These changes also merge cleanly with upstream as of a few minutes ago,
so please let me know if anything strange happens.

--D

The following changes since commit 22843291efc986ce7722610073fcf85a39b4cb13:

  vfs: remove lockdep bogosity in __sb_start_write (2020-11-10 16:49:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.10-fixes-2

for you to fetch changes up to 9b8523423b23ee3dfd88e32f5b7207be56a4e782:

  vfs: move __sb_{start,end}_write* to fs.h (2020-11-10 16:53:11 -0800)

----------------------------------------------------------------
More VFS fixes for 5.10-rc4:
- Minor cleanups of the sb_start_* fs freeze helpers.

----------------------------------------------------------------
Darrick J. Wong (2):
      vfs: separate __sb_start_write into blocking and non-blocking helpers
      vfs: move __sb_{start,end}_write* to fs.h

 fs/aio.c           |  2 +-
 fs/io_uring.c      |  3 +--
 fs/super.c         | 24 ------------------------
 include/linux/fs.h | 38 +++++++++++++++++++++++++++-----------
 4 files changed, 29 insertions(+), 38 deletions(-)
