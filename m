Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591DC3D4988
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGXSyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhGXSyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627155303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wcLLNDQSOBcbp/tt+rpcsxdrkB5OSjz/1oBaIfc7jQM=;
        b=Q9RXdZC4BsbVY4i5POkUumAuilsMaK40nB6SZ6j1IZDkgXR3Pshx3wipEgSXX8vKhS6AuV
        s1c669fWczIDSCrE9ajkNcrMKXVOmJwR4YqkzsG0A7gO4EzXIfF5kVwp2am7Elq7SDb9fH
        cpWNr3zlvGD25pqjNkLxl974h8dLh2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-_t-M8WgmNK62S0TI-r2TPw-1; Sat, 24 Jul 2021 15:35:00 -0400
X-MC-Unique: _t-M8WgmNK62S0TI-r2TPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 356758042E2;
        Sat, 24 Jul 2021 19:34:58 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCE7418432;
        Sat, 24 Jul 2021 19:34:51 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 0/8] gfs2: Fix mmap + page fault deadlocks
Date:   Sat, 24 Jul 2021 21:34:41 +0200
Message-Id: <20210724193449.361667-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus et al.,

here's another update of this patch queue:

 * Finally fix the typos Linus has pointed out twice already.

 * Turn the previous fault_in_iov_iter helper that was used for reads
   and writes into iov_iter_fault_in_writeable per Al's suggestion.
   Use the existing iov_iter_fault_in_readable for writes.

 * Add a done_before argument and an IOMAP_DIO_FAULT_RETRY flag to
   iomap_dio_rw to allow iomap_dio_rw to return partial results and
   resume with the rest of a request.  This allows iomap_dio_rw to be
   used with page faults disabled without having to repeat any I/O.

 * Adjust the gfs2 patches accordingly.

With that, the two iov_ter patches and the three iomap patches should
hopefully be ready for mainline.

There's one remaining issue on the gfs2 side: during read requests, when
a writer now comes in in the middle of a read request, the read request
can currently return a result that never existed on disk.  So we need
to ensure that we only resume read requests when we know that no writer
got in the way, and retry the entire request otherwise.  It should be
relatively easy to add a mechanism to detect when a glock is "lost";
this won't affect the vfs or iomap patches.

Thanks a lot,
Andreas

Andreas Gruenbacher (8):
  iov_iter: Introduce iov_iter_fault_in_writeable helper
  gfs2: Add wrapper for iomap_file_buffered_write
  gfs2: Fix mmap + page fault deadlocks for buffered I/O
  iomap: Fix iomap_dio_rw return value for user copies
  iomap: Add done_before argument to iomap_dio_rw
  iomap: Support restarting direct I/O requests after user copy failures
  iov_iter: Introduce noio flag to disable page faults
  gfs2: Fix mmap + page fault deadlocks for direct I/O

 fs/btrfs/file.c       |  5 ++-
 fs/ext4/file.c        |  5 ++-
 fs/gfs2/file.c        | 95 +++++++++++++++++++++++++++++++++++++++----
 fs/iomap/direct-io.c  | 29 ++++++++++---
 fs/xfs/xfs_file.c     |  6 +--
 fs/zonefs/super.c     |  4 +-
 include/linux/iomap.h | 11 ++++-
 include/linux/mm.h    |  3 ++
 include/linux/uio.h   |  2 +
 lib/iov_iter.c        | 60 ++++++++++++++++++++++++---
 mm/gup.c              | 57 ++++++++++++++++++++++++++
 11 files changed, 246 insertions(+), 31 deletions(-)

-- 
2.26.3

