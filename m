Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1734B492789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243216AbiARNxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243188AbiARNxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642513982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pXij1A1UndEUt7HP7zwNeasuXhEJIKez5EOEb9nfLFg=;
        b=B5SIMdt/QaDk0WHIN46fU8/XinYP7/iC+bjQ6VW1Q00gQgYz0p0D93fNrOYYlVdjbHF5OU
        AhGZzC3pJDR9QUgQQF/d/kRv7ULefUjx5FsBvyggWEap+5RGko1LB+eo4875JjkogqTokB
        8nt1P+s4vSbvm4OjvTjjd9BvhDYbsm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-JlXrDARYNMW5NYWotQtA7w-1; Tue, 18 Jan 2022 08:52:59 -0500
X-MC-Unique: JlXrDARYNMW5NYWotQtA7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2FCD64097;
        Tue, 18 Jan 2022 13:52:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54B1F8049C;
        Tue, 18 Jan 2022 13:52:50 +0000 (UTC)
Subject: [PATCH 00/11] fscache, cachefiles: Rewrite fixes/updates
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        Steve French <smfrench@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jan 2022 13:52:49 +0000
Message-ID: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of fixes and minor updates for the fscache rewrite[1]:

 (1) Fix mishandling of volume collisions (the wait condition is inverted
     and so it was only waiting if the volume collision was already
     resolved).

And for cachefiles, including addressing some of Jeff Layton's review
comments:

 (2) Fix miscalculation of whether there's space available.

 (3) Make sure a default cache name is set on a cache if the user hasn't
     set one by the time they bind the cache.

 (4) Adjust the way the backing inode is presented in tracepoints, add a
     tracepoint for mkdir and trace directory lookup.

 (5) Trace failure to set the active file mark.

 (6) Add explanation of the checks made on the backing filesystem.

 (7) Check that the backing filesystem supports tmpfile.

 (8) Document how the page-release cancellation of the read-skip
     optimisation works.

 (9) Add an IS_KERNEL_FILE() check macro for the S_KERNEL_FILE inode flag.

And I've included a change for netfslib:

(10) Make ops->init_rreq() optional.

I've also added the patch to rewrite cifs's fscache indexing.


Link: https://lore.kernel.org/r/164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk/ [1]

---
David Howells (9):
      fscache: Fix the volume collision wait condition
      cachefiles: Calculate the blockshift in terms of bytes, not pages
      cachefiles: Make some tracepoint adjustments
      cachefiles: Trace active-mark failure
      cachefiles: Explain checks in a comment
      cachefiles: Check that the backing filesystem supports tmpfiles
      fscache: Add a comment explaining how page-release optimisation works
      vfs, fscache: Add an IS_KERNEL_FILE() macro for the S_KERNEL_FILE flag
      cifs: Support fscache indexing rewrite

Jeffle Xu (2):
      cachefiles: set default tag name if it's unspecified
      netfs: Make ops->init_rreq() optional


 fs/cachefiles/cache.c             |  17 +-
 fs/cachefiles/daemon.c            |  11 +
 fs/cachefiles/internal.h          |   2 +-
 fs/cachefiles/io.c                |   2 +-
 fs/cachefiles/namei.c             |  18 +-
 fs/ceph/addr.c                    |   5 -
 fs/cifs/Kconfig                   |   2 +-
 fs/cifs/Makefile                  |   2 +-
 fs/cifs/cache.c                   | 105 ----------
 fs/cifs/cifsfs.c                  |  19 +-
 fs/cifs/cifsglob.h                |   5 +-
 fs/cifs/connect.c                 |  15 +-
 fs/cifs/dir.c                     |   5 +
 fs/cifs/file.c                    |  70 ++++---
 fs/cifs/fscache.c                 | 333 +++++++-----------------------
 fs/cifs/fscache.h                 | 126 ++++-------
 fs/cifs/inode.c                   |  19 +-
 fs/namei.c                        |   2 +-
 fs/netfs/read_helper.c            |   3 +-
 include/linux/fs.h                |   1 +
 include/linux/fscache.h           |   5 +
 include/trace/events/cachefiles.h | 103 ++++++---
 22 files changed, 313 insertions(+), 557 deletions(-)
 delete mode 100644 fs/cifs/cache.c


