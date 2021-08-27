Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DE43F9779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbhH0Jov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 05:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244878AbhH0Jos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630057439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Db4J9qqzVtQ4nd+3HQst+edgAm4oaZrD+OaQmGzLIq8=;
        b=duN+2oGVL9Q9rQewV8OfwzxIo1mIywSpVp5AEiVGabq/9Ey0OAHrSQ/RFy91K5GGRCj9JZ
        nojxXQ0noZPn93HLQbjuIv7cVFWww/zhgdehKENhGMBSGSMFpjZb1uUL2up3498v06IbJ7
        JBdn/4Okgt/Xh5FeiNfjmMKccEFHOJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-9Sg_JrpyPwC_i1p3yT2gAQ-1; Fri, 27 Aug 2021 05:43:57 -0400
X-MC-Unique: 9Sg_JrpyPwC_i1p3yT2gAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D8191015193;
        Fri, 27 Aug 2021 09:43:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07ED9752A0;
        Fri, 27 Aug 2021 09:43:27 +0000 (UTC)
Subject: [PATCH v2 0/6] netfs, afs, ceph: Support folios, at least partially
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        ceph-devel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 10:43:27 +0100
Message-ID: <163005740700.2472992.12365214290752300378.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to convert netfs and afs to use folios and to
provide sufficient conversion for ceph that it can continue to use the
netfs library.  Jeff Layton is working on fully converting ceph.

This based on top of part of Matthew Wilcox's folio changes[1]

Changes:

ver #2:
 - Reorder the patches to put both non-folio afs patches to the front.
 - Use page_offset() rather than manual calculation[2].
 - Fix folio_inode() to directly access the inode[3].

David

Link: https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next [1]
Link: https://lore.kernel.org/r/YST/0e92OdSH0zjg@casper.infradead.org/ [2]
Link: https://lore.kernel.org/r/YST8OcVNy02Rivbm@casper.infradead.org/ [3]
Link: https://lore.kernel.org/r/2408234.1628687271@warthog.procyon.org.uk/ # v0
Link: https://lore.kernel.org/r/162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk/ # v1
---
David Howells (6):
      afs: Fix afs_launder_page() to set correct start file position
      afs: Sort out symlink reading
      folio: Add a function to change the private data attached to a folio
      folio: Add a function to get the host inode for a folio
      netfs, afs, ceph: Use folios
      afs: Use folios in directory handling


 fs/afs/dir.c               | 229 +++++++++++--------------
 fs/afs/dir_edit.c          | 154 ++++++++---------
 fs/afs/file.c              |  82 +++++----
 fs/afs/inode.c             |   6 +-
 fs/afs/internal.h          |  49 +++---
 fs/afs/write.c             | 332 ++++++++++++++++++-------------------
 fs/ceph/addr.c             |  80 ++++-----
 fs/netfs/read_helper.c     | 165 +++++++++---------
 include/linux/netfs.h      |  12 +-
 include/linux/pagemap.h    |  33 ++++
 include/trace/events/afs.h |  21 +--
 mm/page-writeback.c        |   2 +-
 12 files changed, 584 insertions(+), 581 deletions(-)


