Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7523D41CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhGWUST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 16:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhGWUST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627073931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/nhpAW6DhddRuT8w8zINHZDUaJ16Ga0NWcS3sD7FPLI=;
        b=XD+C4w3vcJE1UHwvuy6Ja31Dff+r8pMV0Xh3Rt76or19nhVSuV5h84mOXNOWoY0qfGFuk9
        VE8uCa30fbrjPTYAt8NsR0jwgf5SPU5AGTOYAFQWR/FJzqe6Oht0KcRlWxHhodOg5EvoEs
        vjm4ewmm+IA7Ce1Y7NP0Fz05wqVCL+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-_DZBFc4uPuKedgN0ZWTt4w-1; Fri, 23 Jul 2021 16:58:50 -0400
X-MC-Unique: _DZBFc4uPuKedgN0ZWTt4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C62CA3639F;
        Fri, 23 Jul 2021 20:58:48 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FB8C100238C;
        Fri, 23 Jul 2021 20:58:42 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 0/7] gfs2: Fix mmap + page fault deadlocks
Date:   Fri, 23 Jul 2021 22:58:33 +0200
Message-Id: <20210723205840.299280-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus et al.,

here's an update of my gfs2 mmap + page fault fixes (against -rc2).
From my point of view,

  * these two are ready and need to be looked at by Al:

    iov_iter: Introduce fault_in_iov_iter helper
    iov_iter: Introduce noio flag to disable page faults

  * these two need to be reviewed by Christoph at least:

    iomap: Fix iomap_dio_rw return value for user copies
    iomap: Support restarting direct I/O requests after user copy failures

Thanks a lot,
Andreas

Andreas Gruenbacher (7):
  iov_iter: Introduce fault_in_iov_iter helper
  gfs2: Add wrapper for iomap_file_buffered_write
  gfs2: Fix mmap + page fault deadlocks for buffered I/O
  iomap: Fix iomap_dio_rw return value for user copies
  iomap: Support restarting direct I/O requests after user copy failures
  iov_iter: Introduce noio flag to disable page faults
  gfs2: Fix mmap + page fault deadlocks for direct I/O

 fs/gfs2/file.c       | 77 ++++++++++++++++++++++++++++++++++++++++----
 fs/iomap/direct-io.c | 13 ++++++--
 include/linux/mm.h   |  3 ++
 include/linux/uio.h  |  2 ++
 lib/iov_iter.c       | 62 ++++++++++++++++++++++++++++++++---
 mm/gup.c             | 68 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 211 insertions(+), 14 deletions(-)

-- 
2.26.3

