Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F52C3F9CC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhH0Qud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhH0Qud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630082983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qzk7xHxXOvrpJjyOc9WnxUmMVaQgghawUTASMZZwVjA=;
        b=KPmuECRTfbCTbbodPP3ntTmszzPF1BPKqMbtwIRi5jRcJSUE4gjIRAYe1hAchYckjIdlCQ
        YiOcQRmDlCs7EuvEHyhW4+V8THmORlX/PipO2+ZH1+/T6BqR0wg0JFgKFNat9Ed6YdgAlB
        LgH9xl5RD3mkub0ssa5v4djC1tnV4gI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-3bkppAoeN961tOw7yiok3A-1; Fri, 27 Aug 2021 12:49:40 -0400
X-MC-Unique: 3bkppAoeN961tOw7yiok3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F093190A7A3;
        Fri, 27 Aug 2021 16:49:38 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 285BF60C81;
        Fri, 27 Aug 2021 16:49:27 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kvm-ppc@vger.kernel.org
Subject: [PATCH v7 00/19] gfs2: Fix mmap + page fault deadlocks
Date:   Fri, 27 Aug 2021 18:49:07 +0200
Message-Id: <20210827164926.1726765-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

here's another update on top of v5.14-rc7.  Changes:

 * Some of the patch descriptions have been improved.

 * Patch "gfs2: Eliminate ip->i_gh" has been moved further to the front.

At this point, I'm not aware of anything that still needs fixing, 


The first two patches are independent of the core of this patch queue
and I've asked the respective maintainers to have a look, but I've not
heard back from them.  The first patch should just go into Al's tree;
it's a relatively straight-forward fix.  The second patch really needs
to be looked at; it might break things:

  iov_iter: Fix iov_iter_get_pages{,_alloc} page fault return value
  powerpc/kvm: Fix kvm_use_magic_page


Al and Linus seem to have a disagreement about the error reporting
semantics that functions fault_in_{readable,writeable} and
fault_in_iov_iter_{readable,writeable} should have.  I've implemented
Linus's suggestion of returning the number of bytes not faulted in and I
think that being able to tell if "nothing", "something" or "everything"
could be faulted in does help, but I'll live with anything that allows
us to make progress.


The iomap changes should ideally be reviewed by Christoph; I've not
heard from him about those.


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

Bob Peterson (3):
  gfs2: Eliminate vestigial HIF_FIRST
  gfs2: Remove redundant check from gfs2_glock_dq
  gfs2: Introduce flag for glock holder auto-demotion

 arch/powerpc/kernel/kvm.c           |   3 +-
 arch/powerpc/kernel/signal_32.c     |   4 +-
 arch/powerpc/kernel/signal_64.c     |   2 +-
 arch/x86/kernel/fpu/signal.c        |   7 +-
 drivers/gpu/drm/armada/armada_gem.c |   7 +-
 fs/btrfs/file.c                     |   7 +-
 fs/btrfs/ioctl.c                    |   5 +-
 fs/ext4/file.c                      |   5 +-
 fs/f2fs/file.c                      |   2 +-
 fs/fuse/file.c                      |   2 +-
 fs/gfs2/bmap.c                      |  60 +----
 fs/gfs2/file.c                      | 245 ++++++++++++++++++--
 fs/gfs2/glock.c                     | 340 +++++++++++++++++++++-------
 fs/gfs2/glock.h                     |  20 ++
 fs/gfs2/incore.h                    |   5 +-
 fs/iomap/buffered-io.c              |   2 +-
 fs/iomap/direct-io.c                |  21 +-
 fs/ntfs/file.c                      |   2 +-
 fs/xfs/xfs_file.c                   |   6 +-
 fs/zonefs/super.c                   |   4 +-
 include/linux/iomap.h               |  11 +-
 include/linux/mm.h                  |   3 +-
 include/linux/pagemap.h             |  58 +----
 include/linux/uio.h                 |   4 +-
 lib/iov_iter.c                      | 103 +++++++--
 mm/filemap.c                        |   4 +-
 mm/gup.c                            | 139 +++++++++++-
 27 files changed, 785 insertions(+), 286 deletions(-)

-- 
2.26.3

