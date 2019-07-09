Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 196C0638B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGIPe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 11:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfGIPez (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:34:55 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9261720656;
        Tue,  9 Jul 2019 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562686494;
        bh=gub/vrZ1KsSeLFGrO8xgrbIV84kVgeYFagd2MwkIbC0=;
        h=Date:From:To:Cc:Subject:From;
        b=MFWFdmqLBKqQWc5mPJMkSKEKKpzKlpA5PttUb1dRkUc1UAl85uBBky1+d91jh2qXT
         /9pHxlnwkkcjuVPf92gQxe2YFoU2u9iKR0hHQKGilDVg033Lrn/AUS7lQDtfr+DQKc
         R/LJNaQVe/NrP+67khS/FgOwGoP9ClBOFoKBlWm8=
Date:   Tue, 9 Jul 2019 08:34:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [GIT PULL] iomap: new code for 5.3, part 1
Message-ID: <20190709153454.GQ1404256@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here's the first part of the iomap merge for 5.3.  There are a few fixes
for gfs2 but otherwise it's pretty quiet so far. The branch merges
cleanly against this morning's HEAD and survived an overnight run of
xfstests.  The merge was completely straightforward, so please let me
know if you run into anything weird.

For the second part of the merge window I would like to break up iomap.c
into smaller files grouped by functional area so that it'll be easier in
the long run to keep the pieces separate and to review incoming patches.
There won't be any functional changes, as the file can still be split
very cleanly.

I prefer to get this done quickly before 5.3-rc1 because I anticipate
that there will be rather more iomap development work coming for 5.4, so
my plan is to rebase my splitting series after the mm and block merges
land and come back in a week or so having let it soak in for-next for
several days.  Let me know if you'd pefer a different timeline.

--D

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.3-merge-1

for you to fetch changes up to 36a7347de097edf9c4d7203d09fa223c86479674:

  iomap: fix page_done callback for short writes (2019-06-27 17:28:41 -0700)

----------------------------------------------------------------
New for 5.3:
- Only mark inode dirty at the end of writing to a file (instead of once
  for every page written).
- Fix for an accounting error in the page_done callback.

----------------------------------------------------------------
Andreas Gruenbacher (2):
      iomap: don't mark the inode dirty in iomap_write_end
      iomap: fix page_done callback for short writes

Christoph Hellwig (1):
      fs: fold __generic_write_end back into generic_write_end

 fs/buffer.c           | 62 ++++++++++++++++++++++++---------------------------
 fs/gfs2/bmap.c        |  2 ++
 fs/internal.h         |  2 --
 fs/iomap.c            | 17 ++++++++++++--
 include/linux/iomap.h |  1 +
 5 files changed, 47 insertions(+), 37 deletions(-)
