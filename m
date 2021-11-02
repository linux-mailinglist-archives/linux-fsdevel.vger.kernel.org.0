Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8E442DDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 13:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhKBMcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 08:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhKBMcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635856196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YIWSYr6pevhH0DFmIUBGhtKz62Z+yCMPTeYNulCoh7Q=;
        b=BRgz6mEA6VBekcIP133a8K/gE8ZC+Ce3/IAtLbPCJQiBCCGsI08aQhgrdeK3cHtBXcl1+9
        UglrZSHLZPPBTUFboywVby9LYvGDI2EQWQL8L1KNhq9+61ZWjaLCY0W9NfIzCkWmDfRP1s
        YO8kwZsRA0za87iDBR4v1e3p/jphH3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-4lkyoLcKPhWDNw1v_9nNSA-1; Tue, 02 Nov 2021 08:29:53 -0400
X-MC-Unique: 4lkyoLcKPhWDNw1v_9nNSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD56B80A5C1;
        Tue,  2 Nov 2021 12:29:50 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 172A357CB9;
        Tue,  2 Nov 2021 12:29:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v9 00/17] gfs2: Fix mmap + page fault deadlocks
Date:   Tue,  2 Nov 2021 13:29:28 +0100
Message-Id: <20211102122945.117744-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's another update of this patch queue on top of v5.15-rc5.  Changes:

 * Fix a bug in the do_promote changes of "gfs2: Clean up function
   may_grant" (find_first_holder needs to be called inside the restart
   loop).

 * Add a comment explaining __iomap_dio_rw's new done_before argument
   per request of Darrick J. Wong.

 * Use untagged_addr() in fault_in_safe_writeable as per comment from
   Catalin Marinas.


I've pushed is patch set here:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next.mmap-fault
  b01b2d72da25c000aeb124bc78daf3fb998be2b6


These changes are from October 25, so they've had some exposure in
for-next.  As Stephen Rothwell points out, there's a minor merge
conflict between commit:

  bb523b406c84 ("gup: Turn fault_in_pages_{readable,writeable} into fault_in_{readable,writeable}")

from this patch set and the following two commits in mainline:

  fcfb7163329c ("x86/fpu/signal: Move xstate clearing out of copy_fpregs_to_sigframe()")
  a2a8fd9a3efd ("x86/fpu/signal: Change return code of restore_fpregs_from_user() to boolean")


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
 fs/gfs2/file.c                      | 252 +++++++++++++++++++--
 fs/gfs2/glock.c                     | 330 +++++++++++++++++++++-------
 fs/gfs2/glock.h                     |  20 ++
 fs/gfs2/incore.h                    |   4 +-
 fs/iomap/buffered-io.c              |   2 +-
 fs/iomap/direct-io.c                |  29 ++-
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
 29 files changed, 793 insertions(+), 286 deletions(-)

-- 
2.31.1

