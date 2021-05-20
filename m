Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078A138AE26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhETM2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 08:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234742AbhETM1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 08:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621513546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bm4G0D5fPgHkFz6Tq2cMmRepmQ5JO/RLPWPnNdJIAWg=;
        b=YCCegr/MM0DAlA2ABqj1sAUhoxvAZPWRrRLN1PPCATMw0HvdIaexNTp40erHM49dgSPDLn
        CnIV1tEf4EH8qb/k0lrjfHP+g2xJmvMwl8nByz8wpF6GG3p9iGCqyaUD22HOOl8YFuVWOS
        W+R2gPV08bMxgXvjybWGsfO4NPELF6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-hCFDT2MfPwCZMqbCLIY1hQ-1; Thu, 20 May 2021 08:25:44 -0400
X-MC-Unique: hCFDT2MfPwCZMqbCLIY1hQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FD981A8A68;
        Thu, 20 May 2021 12:25:43 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 343FA60C4A;
        Thu, 20 May 2021 12:25:37 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, cluster-devel@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/6] gfs2: Handle page faults during read and write
Date:   Thu, 20 May 2021 14:25:30 +0200
Message-Id: <20210520122536.1596602-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this is an update to my previous posting [1] on how to deal with
potential mmap + page fault deadlocks in gfs2.

What's happening is that a page fault triggers during a read or write
operation, while we're holding a glock (the cluster-wide gfs2 inode
lock), and the page fault requires another glock.  We can recognize and
handle the case when both glocks are the same, but when the page fault
requires another glock, there is a chance that taking that other glock
will deadlock.

The solution I've come up with for this is to turn locking requests into
locking attempts when we're in a potential recursive locking situation,
and to actively fault in pages and retry at the outer level when a
locking attempt fails.  Those kinds of conflicts should be relatively
rare.

Note that we need to fault in pages writable in ->read_iter, so this
patch set adds a new iov_iter_fault_in_writeable() helper hat mirrors
iov_iter_fault_in_readable().

In the initial prototype [1], I've added a restart_hack flag to struct
task_struct; this has now been moved to the lower two bits of
current->journal_info.

I've posted a new fstest [2] that triggers the self-recursion case so
that those kind of bugs will be caught early next time, with no feedback
in the last two weeks.

Those patches are currently on the gfs2 for-next branch [3].  If there
are no objections, I'll ask Linus to pull them from there.

Thanks,
Andreas

[1] [RFC] Trigger retry from fault vm operation,
https://lore.kernel.org/linux-fsdevel/20210511140113.1225981-1-agruenba@redhat.com/

[2] https://lore.kernel.org/fstests/20210520114218.1595735-1-agruenba@redhat.com/T/#u

[3] https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next

Andreas Gruenbacher (6):
  gfs2: Fix mmap + page fault deadlocks (part 1)
  iov_iter: Add iov_iter_fault_in_writeable()
  gfs2: Add wrappers for accessing journal_info
  gfs2: Encode glock holding and retry flags in journal_info
  gfs2: Add LM_FLAG_OUTER glock holder flag
  gfs2: Fix mmap + page fault deadlocks (part 2)

 fs/gfs2/aops.c      |   6 +--
 fs/gfs2/bmap.c      |  31 +++++++-------
 fs/gfs2/file.c      | 102 +++++++++++++++++++++++++++++++++++++-------
 fs/gfs2/glock.c     |  12 ++++++
 fs/gfs2/glock.h     |  13 ++++--
 fs/gfs2/incore.h    |  41 ++++++++++++++++++
 fs/gfs2/inode.c     |   2 +-
 fs/gfs2/log.c       |   4 +-
 fs/gfs2/lops.c      |   2 +-
 fs/gfs2/meta_io.c   |   6 +--
 fs/gfs2/super.c     |   2 +-
 fs/gfs2/trans.c     |  16 +++----
 include/linux/uio.h |   1 +
 lib/iov_iter.c      |  20 ++++++++-
 14 files changed, 204 insertions(+), 54 deletions(-)

-- 
2.26.3

