Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44763CCB55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 00:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhGRWmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 18:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhGRWmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 18:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626647985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xw04fnowKtYXTdFS14xZoGGNfz6dHcqSTKXhXZyTGCQ=;
        b=TNNL4X0WojSlKlZSeTM22tzPO5jt0Nbwf8FMVLgj1OOsO3HkBBlaGAqTl4qhd0B3+igFwH
        vQ6Vh31k/1WsN98XzjqKKJSfMs7SrWKWcYMvJLc8s0Z0bdGH5NNYHP3q/+QXWyjtHf8OrI
        OQkiGjsRis9/sB3UIUlzXvlwfFUQs2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-IWr29uZINSe0b-sNmwXLkw-1; Sun, 18 Jul 2021 18:39:42 -0400
X-MC-Unique: IWr29uZINSe0b-sNmwXLkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D984100C609;
        Sun, 18 Jul 2021 22:39:40 +0000 (UTC)
Received: from max.com (unknown [10.40.195.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8BC460C0F;
        Sun, 18 Jul 2021 22:39:34 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 0/6] gfs2: Fix mmap + page fault deadlocks
Date:   Mon, 19 Jul 2021 00:39:26 +0200
Message-Id: <20210718223932.2703330-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus et al.,

here's an update to the gfs2 mmap + page faults fix that implements
Linus's suggestion of disabling page faults while we're holding the
inode glock.

This passes fstests except for test generic/095, which fails due to an
independent bug in the iov_iter code.  I'm currently trying to get
initial feedback from Al and Christoph on that.

Any feedback would be welcome.

Thanks a lot,
Andreas

Andreas Gruenbacher (6):
  iov_iter: Introduce fault_in_iov_iter helper
  iomap: Fix iomap_dio_rw return value for page faults
  gfs2: Add wrapper for iomap_file_buffered_write
  gfs2: Fix mmap + page fault deadlocks for buffered I/O
  iov_iter: Introduce ITER_FLAG_FAST_ONLY flag
  gfs2: Fix mmap + page fault deadlocks for direct I/O

 fs/gfs2/file.c       | 79 ++++++++++++++++++++++++++++++++++++++++----
 fs/iomap/direct-io.c |  2 ++
 include/linux/mm.h   |  3 ++
 include/linux/uio.h  | 16 +++++++--
 lib/iov_iter.c       | 62 +++++++++++++++++++++++++++++++---
 mm/gup.c             | 68 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 215 insertions(+), 15 deletions(-)

-- 
2.26.3

