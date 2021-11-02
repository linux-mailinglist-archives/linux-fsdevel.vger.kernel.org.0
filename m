Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFF0442959
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKBIcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 04:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhKBIcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635841772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AGQfQE+y23DXMjkdSWV0LFVA0+D/0EvWkXC0q0Pk3Q4=;
        b=O8aNkAg2edHIAGY2Lh+YB/iM17V6S1YnUKMfUmISpe5TnC6aVg/ruIVEO7xUfrnASRZSg+
        cnDCRfOS42dRmMxkYYW5K6DkQlEHhwjtr36xm58TK6Dup9CiHbyaVJTy5G0m/FrL4MPyzr
        oM7roBbPyGW5hidoJtPUY5Pc0uTpjIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Yh_WrSB2Pha7tYZorf2u2A-1; Tue, 02 Nov 2021 04:29:31 -0400
X-MC-Unique: Yh_WrSB2Pha7tYZorf2u2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D23CE8066EF;
        Tue,  2 Nov 2021 08:29:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29A371017CE3;
        Tue,  2 Nov 2021 08:29:10 +0000 (UTC)
Subject: [PATCH v3 0/6] netfs, 9p, afs, ceph: Support folios,
 at least partially
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Nov 2021 08:29:09 +0000
Message-ID: <163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to convert netfs, 9p and afs to use folios and to
provide sufficient conversion for ceph that it can continue to use the
netfs library.  Jeff Layton is working on fully converting ceph.

This also contains a patch to split afs symlink readpage from afs file
readpage to aid with foliation and a patch to convert 9p to netfslib to
reduce the amount of foliation needed there.

Changes
=======
ver #3:
 - Rebased on upstream as folios have been pulled.
 - Imported a patch to convert 9p to netfslib from my
   fscache-remove-old-api branch[3].
 - Foliated netfslib.

ver #2:
 - Reorder the patches to put both non-folio afs patches to the front.
 - Use page_offset() rather than manual calculation[1].
 - Fix folio_inode() to directly access the inode[2].

David

Link: https://lore.kernel.org/r/YST/0e92OdSH0zjg@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/YST8OcVNy02Rivbm@casper.infradead.org/ [2]
Link: https://lore.kernel.org/r/163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk/ [3]
Link: https://lore.kernel.org/r/2408234.1628687271@warthog.procyon.org.uk/ # v0
Link: https://lore.kernel.org/r/162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163005740700.2472992.12365214290752300378.stgit@warthog.procyon.org.uk/ # v2
---
David Howells (6):
      afs: Sort out symlink reading
      9p: Convert to using the netfs helper lib to do reads and caching
      folio: Add a function to change the private data attached to a folio
      folio: Add a function to get the host inode for a folio
      netfs, 9p, afs, ceph: Use folios
      afs: Use folios in directory handling


 fs/9p/Kconfig              |   1 +
 fs/9p/cache.c              | 137 ---------------
 fs/9p/cache.h              |  97 +----------
 fs/9p/v9fs.h               |   9 +
 fs/9p/vfs_addr.c           | 253 +++++++++++++--------------
 fs/9p/vfs_file.c           |  29 ++--
 fs/afs/dir.c               | 229 ++++++++++--------------
 fs/afs/dir_edit.c          | 154 +++++++++--------
 fs/afs/file.c              |  70 ++++----
 fs/afs/internal.h          |  46 ++---
 fs/afs/write.c             | 346 ++++++++++++++++++-------------------
 fs/ceph/addr.c             |  80 +++++----
 fs/netfs/read_helper.c     | 165 +++++++++---------
 include/linux/netfs.h      |  12 +-
 include/linux/pagemap.h    |  33 ++++
 include/trace/events/afs.h |  21 +--
 mm/page-writeback.c        |   2 +-
 17 files changed, 738 insertions(+), 946 deletions(-)


