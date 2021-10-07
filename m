Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91328425DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbhJGUse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 16:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241333AbhJGUsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633639598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mfxOOkEEb/0qA7n4G7hFNntJkpHztcxLklLLeD9aUmY=;
        b=DSkLN8Ff5O7qshqgbLXJ3vevXZTm5e+pZ1SGYN5K8GgZjL09EL3FBqrh1L6kd806WuUu9Q
        8ush0kJOEub2/0XyYmIIGExaT2GCZE66XXVmJ944KWyydStMsreGVYGRIspO8Eo7Tr6Rkm
        mQCVwH8NwSL3/yD2RMCHErv+MlKfnGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-p4J-I3HJP9OC5M_f0BJMbA-1; Thu, 07 Oct 2021 16:46:37 -0400
X-MC-Unique: p4J-I3HJP9OC5M_f0BJMbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248BB109FE51;
        Thu,  7 Oct 2021 20:43:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E72EA57CA1;
        Thu,  7 Oct 2021 20:42:30 +0000 (UTC)
Subject: [PATCH v3 00/10] fscache: Replace and remove old I/O API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, Dave Wysochanski <dwysocha@redhat.com>,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Oct 2021 21:42:30 +0100
Message-ID: <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches that removes the old fscache I/O API by the following
means:

 (1) A simple fallback API is added that can read or write a single page
     synchronously.  The functions for this have "fallback" in their names
     as they have to be removed at some point.

 (2) An implementation of this is provided in cachefiles.  It creates a kiocb
     to use DIO to the backing file rather than calling readpage on the
     backing filesystem page and then snooping the page wait queue.

 (3) NFS is switched to use the fallback API.

 (4) CIFS is switched to use the fallback API also for the moment.

 (5) 9P is switched to using netfslib.

 (6) The old I/O API is removed from fscache and the page snooping
     implementation is removed from cachefiles.

The reasons for doing this are:

 (A) Using a kiocb to do asynchronous DIO from/to the pages of the backing
     file is now a possibility that didn't exist when cachefiles was created.
     This is much simpler than the snooping mechanism with a proper callback
     path and it also requires fewer copies and less memory.

 (B) We have to stop using bmap() or SEEK_DATA/SEEK_HOLE to work out what
     blocks are present in the backing file is dangerous and can lead to data
     corruption if the backing filesystem can insert or remove blocks of zeros
     arbitrarily in order to optimise its extent list[1].

     Whilst this patchset doesn't fix that yet, it does simplify the code and
     the fix for that can be made in a subsequent patchset.

 (C) In order to fix (B), the cache will need to keep track itself of what
     data is present.  To make this easier to manage, the intention is to
     increase the cache block granularity to, say, 256KiB - importantly, a
     size that will span multiple pages - which means the single-page
     interface will have to go away.  netfslib is designed to deal with
     that on behalf of a filesystem, though a filesystem could use raw
     cache calls instead and manage things itself.

These patches can be found also on:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-remove-old-io

David

Changes
=======
ver #3:
  - Added a patch to make fscache_cookie_enabled() handle a NULL cookie.
  - Added a patch to make cachefiles_prepare_read() indicate that the
    caller should fill a block with zeros if it's beyond EOF rather than
    risking the read get marked invalid and trigger a warning.
  - Merged fixes from Dave Wysochanski for the NFS patch[4].

ver #2:
  - Changed "deprecated" to "fallback" in the new function names[2].
  - Cleaned up some kernel test robot warnings[3].
  - Made the netfs read helpers use NETFS_READ_HOLE_* flags.


References
==========

Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
Link: https://lore.kernel.org/r/CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com/ [2]
Link: https://lore.kernel.org/r/202109150420.QX7dDzSE-lkp@intel.com/ [3]
Link: https://listman.redhat.com/archives/linux-cachefs/2021-October/msg00011.html [4]

Older postings
==============

Link: https://lore.kernel.org/r/163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk/ # rfc v1
Link: https://lore.kernel.org/r/163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk/ # rfc v2

Note that some of this was seen in previous patchsets too:

# [RFC PATCH 00/61] fscache, cachefiles: Rewrite the I/O interface in terms of kiocb/iov_iter
Link: https://lore.kernel.org/r/158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk/
# [PATCH 00/14] fscache: Rewrite 1: Disable and clean in preparation for rewrite
Link: https://lore.kernel.org/r/159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk/
# [RFC PATCH 00/76] fscache: Modernisation
Link: https://lore.kernel.org/r/160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk/

---
David Howells (10):
      fscache: Generalise the ->begin_read_operation method
      fscache: Fix fscache_cookie_enabled() to handle NULL cookie
      cachefiles: Always indicate we should fill a post-EOF page with zeros
      fscache: Implement a fallback I/O interface to replace the old API
      nfs: Move to using the alternate fallback fscache I/O API
      9p: Convert to using the netfs helper lib to do reads and caching
      cifs: (untested) Move to using the alternate fallback fscache I/O API
      fscache: Remove the old I/O API
      fscache: Remove stats that are no longer used
      fscache: Update the documentation to reflect I/O API changes


 .../filesystems/caching/backend-api.rst       |  138 +--
 .../filesystems/caching/netfs-api.rst         |  385 +-----
 fs/9p/Kconfig                                 |    1 +
 fs/9p/cache.c                                 |  137 ---
 fs/9p/cache.h                                 |   98 +-
 fs/9p/v9fs.h                                  |    9 +
 fs/9p/vfs_addr.c                              |  195 ++-
 fs/9p/vfs_file.c                              |   21 +-
 fs/cachefiles/Makefile                        |    1 -
 fs/cachefiles/interface.c                     |   15 -
 fs/cachefiles/internal.h                      |   38 -
 fs/cachefiles/io.c                            |   57 +-
 fs/cachefiles/main.c                          |    1 -
 fs/cachefiles/rdwr.c                          |  972 ---------------
 fs/cifs/file.c                                |   64 +-
 fs/cifs/fscache.c                             |  105 +-
 fs/cifs/fscache.h                             |   74 +-
 fs/fscache/cache.c                            |    6 -
 fs/fscache/cookie.c                           |   10 -
 fs/fscache/internal.h                         |   58 +-
 fs/fscache/io.c                               |  137 ++-
 fs/fscache/object.c                           |    2 -
 fs/fscache/page.c                             | 1066 -----------------
 fs/fscache/stats.c                            |   73 +-
 fs/netfs/read_helper.c                        |    8 +-
 fs/nfs/file.c                                 |   14 +-
 fs/nfs/fscache-index.c                        |   26 -
 fs/nfs/fscache.c                              |  170 +--
 fs/nfs/fscache.h                              |   84 +-
 fs/nfs/read.c                                 |   25 +-
 fs/nfs/write.c                                |    7 +-
 include/linux/fscache-cache.h                 |  131 --
 include/linux/fscache.h                       |  445 ++-----
 include/linux/netfs.h                         |   17 +-
 34 files changed, 568 insertions(+), 4022 deletions(-)
 delete mode 100644 fs/cachefiles/rdwr.c


