Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8620F433742
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhJSNob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 09:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231478AbhJSNoa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634650937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5+3kGgE0lTZGMIPayeWz4h9i84UBZjNZfTbObIc8GHY=;
        b=Styz4+ODKeTn8AuBc6KCXj8MV8gcnEDgdxczLreQOX2NnXoFgxZYa/kpFm4ds3FyzmcrTo
        DEIj5iBRLjPmjyKwVFaGKSENsmsBIga7Yzjbf5zsAw+jNhECSlnRwe+zIcINHu6EhjgqxT
        4x0zFvM/2HPvGNWnJxLo2mdfnJ4lAQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-9parn03HN2axklQyFOfcfw-1; Tue, 19 Oct 2021 09:42:12 -0400
X-MC-Unique: 9parn03HN2axklQyFOfcfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 432968735C3;
        Tue, 19 Oct 2021 13:42:10 +0000 (UTC)
Received: from max.com (unknown [10.40.193.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7C4310016FC;
        Tue, 19 Oct 2021 13:42:06 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
Date:   Tue, 19 Oct 2021 15:41:47 +0200
Message-Id: <20211019134204.3382645-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus and all,

here's another update of this patch queue on top of v5.15-rc5.  Changes:

 * Rebase on top of v5.15-rc5.

 * Bump iocb->ki_pos in gfs2_file_buffered_write to make sure
   partial writes go to the correct file offset.

 * Some comment and commit message improvements.


I've pushed this here:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next.mmap-fault
  28ea41433945ed1d442d2a131d1bcbfa24646c6f


From my point of view, the following questions remain:

 * I hope these patches will be merged for v5.16, but what process
   should I follow for that?  The patch queue contains mm and iomap
   changes, so a pull request from the gfs2 tree would be unusual.

 * Will Catalin Marinas's work for supporting arm64 sub-page faults
   be queued behind these patches?  We have an overlap in
   fault_in_[pages_]readable fault_in_[pages_]writeable, so one of
   the two patch queues will need some adjustments.


Thanks,
Andreas


Andreas Gruenbacher (16):
  iov_iter: Fix iov_iter_get_pages{,_alloc} page fault return value
  powerpc/kvm: Fix kvm_use_magic_page
  gup: Turn fault_in_pages_{readable,writeable} into
    fault_in_{readable,writeable}
  iov_iter: Turn iov_iter_fault_in_readable into
    fault_in_iov_iter_readable
  iov_iter: Introduce fault_in_iov_iter_writeable
  gfs2: Add wrapper for iomap_file_buffered_write
  gfs2: Clean up function may_grant
  gfs2: Move the inode glock locking to gfs2_file_buffered_write
  gfs2: Eliminate ip->i_gh
  gfs2: Fix mmap + page fault deadlocks for buffered I/O
  iomap: Fix iomap_dio_rw return value for user copies
  iomap: Support partial direct I/O on user copy failures
  iomap: Add done_before argument to iomap_dio_rw
  gup: Introduce FOLL_NOFAULT flag to disable page faults
  iov_iter: Introduce nofault flag to disable page faults
  gfs2: Fix mmap + page fault deadlocks for direct I/O

Bob Peterson (1):
  gfs2: Introduce flag for glock holder auto-demotion

 arch/powerpc/kernel/kvm.c           |   3 +-
 arch/powerpc/kernel/signal_32.c     |   4 +-
 arch/powerpc/kernel/signal_64.c     |   2 +-
 arch/x86/kernel/fpu/signal.c        |   7 +-
 drivers/gpu/drm/armada/armada_gem.c |   7 +-
 fs/btrfs/file.c                     |   7 +-
 fs/btrfs/ioctl.c                    |   5 +-
 fs/erofs/data.c                     |   2 +-
 fs/ext4/file.c                      |   5 +-
 fs/f2fs/file.c                      |   2 +-
 fs/fuse/file.c                      |   2 +-
 fs/gfs2/bmap.c                      |  60 +----
 fs/gfs2/file.c                      | 256 +++++++++++++++++++--
 fs/gfs2/glock.c                     | 331 +++++++++++++++++++++-------
 fs/gfs2/glock.h                     |  20 ++
 fs/gfs2/incore.h                    |   4 +-
 fs/iomap/buffered-io.c              |   2 +-
 fs/iomap/direct-io.c                |  21 +-
 fs/ntfs/file.c                      |   2 +-
 fs/ntfs3/file.c                     |   2 +-
 fs/xfs/xfs_file.c                   |   6 +-
 fs/zonefs/super.c                   |   4 +-
 include/linux/iomap.h               |  11 +-
 include/linux/mm.h                  |   3 +-
 include/linux/pagemap.h             |  58 +----
 include/linux/uio.h                 |   4 +-
 lib/iov_iter.c                      | 103 +++++++--
 mm/filemap.c                        |   4 +-
 mm/gup.c                            | 139 +++++++++++-
 29 files changed, 790 insertions(+), 286 deletions(-)

-- 
2.26.3

