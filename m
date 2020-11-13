Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9CD2B2940
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 00:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgKMXiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 18:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMXis (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:38:48 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0865C20665;
        Fri, 13 Nov 2020 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605310728;
        bh=ImJZDRE2/iC26RD/9JTqda4/DenXUv4Bh5qUAQQ/R8g=;
        h=Date:From:To:Cc:Subject:From;
        b=mj868wRJwsPk28F1052pVjeCEJwCWgTEvWYkj4IUeusk9sbY8qa3qYW9fnwA2kST1
         BEh1QU68AncyU4RDSA7nuZTxy91VowidHFqdVL6+UlkmfYCNM1WQGr82MNxEjx4wDO
         dfMXT3HGZyCVe0FctIdslD48bd5vzDBQiuUhDhQs=
Date:   Fri, 13 Nov 2020 15:38:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        david@fromorbit.com, fdmanana@kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        djwong@kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] vfs: fs freeze fix for 5.10-rc4
Message-ID: <20201113233847.GG9685@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a single vfs fix for 5.10-rc4.  A
very long time ago, a hack was added to the vfs fs freeze protection
code to work around lockdep complaints about XFS, which would try to run
a transaction (which requires intwrite protection) to finalize an xfs
freeze (by which time the vfs had already taken intwrite).

Fast forward a few years, and XFS fixed the recursive intwrite problem
on its own, and the hack became unnecessary.  Fast forward almost a
decade, and latent bugs in the code converting this hack from freeze
flags to freeze locks combine with lockdep bugs to make this reproduce
frequently enough to notice page faults racing with freeze.

Since the hack is unnecessary and causes thread race errors, just get
rid of it completely.  Pushing this kind of vfs change midway through a
cycle makes me nervous, but a large enough number of the usual
VFS/ext4/XFS/btrfs suspects have said this looks good and solves a real
problem vector, so I'm sending this for your consideration instead of
holding off until 5.11.

The branch merges cleanly with upstream as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.10-fixes-1

for you to fetch changes up to 22843291efc986ce7722610073fcf85a39b4cb13:

  vfs: remove lockdep bogosity in __sb_start_write (2020-11-10 16:49:29 -0800)

----------------------------------------------------------------
VFS fixes for 5.10-rc4:
- Finally remove the "convert to trylock" weirdness in the fs freezer
  code.  It was necessary 10 years ago to deal with nested transactions
  in XFS, but we've long since removed that; and now this is causing
  subtle race conditions when lockdep goes offline and sb_start_* aren't
  prepared to retry a trylock failure.

----------------------------------------------------------------
Darrick J. Wong (1):
      vfs: remove lockdep bogosity in __sb_start_write

 fs/super.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)
