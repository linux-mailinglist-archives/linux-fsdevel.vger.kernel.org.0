Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014DE3FCF39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbhHaVjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 17:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232580AbhHaVjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630445924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jF9rwEM7cmKziqpDUf57DgLJOh4uDfmAVb6WTLHCRQc=;
        b=dtBhnEepaX+y5PjIVpeB4fG7JlkgnqbDaSVxrk0x8k5OXb3CZojB6HeN3OD6WHbMsrmK/I
        Iw88+xNrXSix5MqDfjU1xCSap4NfMOYRdblju7AyOeHKtPHC0MWWoxvciutqPdRrRdgIEg
        dvPQOqVUbn6iVLwTK4HSMQSL2U9Ahm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-etE7GrocP62B622SZDpz4g-1; Tue, 31 Aug 2021 17:38:43 -0400
X-MC-Unique: etE7GrocP62B622SZDpz4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1928D8CC784;
        Tue, 31 Aug 2021 21:38:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB1D60843;
        Tue, 31 Aug 2021 21:38:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache: Fixes and rewrite preparation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3282507.1630445914.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 31 Aug 2021 22:38:34 +0100
Message-ID: <3282508.1630445914@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull these changes please?  They perform some preparatory work for=
 the
fscache rewrite that's being worked on and fix some bugs.  These include:

 (1) Always select netfs stats when enabling fscache stats since they're
     displayed through the same procfile.

 (2) Add a cookie debug ID that can be used in tracepoints instead of a
     pointer and cache it in the netfs_cache_resources struct rather than
     in the netfs_read_request struct to make it more available.

 (3) Use file_inode() in cachefiles rather than dereferencing file->f_inod=
e
     directly.

 (4) Provide a procfile to display fscache cookies.

 (5) Remove the fscache and cachefiles histogram procfiles.

 (6) Remove the fscache object list procfile.

 (7) Avoid using %p in fscache and cachefiles as the value is hashed and
     not comparable to the register dump in an oops trace.

 (8) Fix the cookie hash function to actually achieve useful dispersion.

 (9) Fix fscache_cookie_put() so that it doesn't dereference the cookie
     pointer in the tracepoint after the refcount has been decremented
     (we're only allowed to do that if we decremented it to zero).

(10) Use refcount_t rather than atomic_t for the fscache_cookie refcount.

Some of these patches have been posted before as part of a larger patchset
that effected almost the whole rewrite[1].

Changes
=3D=3D=3D=3D=3D=3D=3D
ver #2:
 - Fix a NULL pointer ref in a tracepoint (that patch reposted here [2]).

David

Link: https://lore.kernel.org/r/162431188431.2908479.14031376932042135080.=
stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/160588455242.3465195.3214733858273019178.s=
tgit@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/2512396.1630067489@warthog.procyon.org.uk/=
 [2]

---
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d=
3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/fscache-next-20210829

for you to fetch changes up to 20ec197bfa13c5b799fc9527790ea7b5374fc8f2:

  fscache: Use refcount_t for the cookie refcount instead of atomic_t (202=
1-08-27 13:34:03 +0100)

----------------------------------------------------------------
fscache changes and fixes

----------------------------------------------------------------
David Howells (12):
      fscache: Select netfs stats if fscache stats are enabled
      netfs: Move cookie debug ID to struct netfs_cache_resources
      cachefiles: Use file_inode() rather than accessing ->f_inode
      fscache: Add a cookie debug ID and use that in traces
      fscache: Procfile to display cookies
      fscache, cachefiles: Remove the histogram stuff
      fscache: Remove the object list procfile
      fscache: Change %p in format strings to something else
      cachefiles: Change %p in format strings to something else
      fscache: Fix cookie key hashing
      fscache: Fix fscache_cookie_put() to not deref after dec
      fscache: Use refcount_t for the cookie refcount instead of atomic_t

 fs/cachefiles/Kconfig             |  19 --
 fs/cachefiles/Makefile            |   2 -
 fs/cachefiles/bind.c              |   2 -
 fs/cachefiles/interface.c         |   6 +-
 fs/cachefiles/internal.h          |  25 ---
 fs/cachefiles/io.c                |   6 +-
 fs/cachefiles/key.c               |   2 +-
 fs/cachefiles/main.c              |   7 -
 fs/cachefiles/namei.c             |  61 ++----
 fs/cachefiles/proc.c              | 114 -----------
 fs/cachefiles/xattr.c             |   4 +-
 fs/fscache/Kconfig                |  25 +--
 fs/fscache/Makefile               |   2 -
 fs/fscache/cache.c                |  11 +-
 fs/fscache/cookie.c               | 201 +++++++++++++-----
 fs/fscache/fsdef.c                |   3 +-
 fs/fscache/histogram.c            |  87 --------
 fs/fscache/internal.h             |  57 ++----
 fs/fscache/main.c                 |  39 ++++
 fs/fscache/netfs.c                |   2 +-
 fs/fscache/object-list.c          | 414 ---------------------------------=
-----
 fs/fscache/object.c               |   8 -
 fs/fscache/operation.c            |   3 -
 fs/fscache/page.c                 |   6 -
 fs/fscache/proc.c                 |  20 +-
 include/linux/fscache-cache.h     |   4 -
 include/linux/fscache.h           |   4 +-
 include/linux/netfs.h             |   2 +-
 include/trace/events/cachefiles.h |  68 +++----
 include/trace/events/fscache.h    | 160 +++++++--------
 include/trace/events/netfs.h      |   2 +-
 31 files changed, 368 insertions(+), 998 deletions(-)
 delete mode 100644 fs/cachefiles/proc.c
 delete mode 100644 fs/fscache/histogram.c
 delete mode 100644 fs/fscache/object-list.c

