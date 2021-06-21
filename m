Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEDC3AF7A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhFUVrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 17:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231715AbhFUVrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624311896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XKLiDuUsmC1WPdGyRvFLYwM86yQUshQp3xSKfy6+l3A=;
        b=gzNcW1f8m8u1F5vCbb3NcISFvSTNgANhUnJh/iaVREY5cYztEpbPRBLuVbTwvLvGQ+QUc0
        LT2BR2CUsVNfFwuW1WP9Ks5M/GGE+uEkuziqbWe4G6wTmJas9+wVNN0aHUuowQI5ITxMSA
        USKUUAGdNL52ebKI5n3nfp8fM+q2gzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-BaiXqo66MB-HZt-EMIdxbw-1; Mon, 21 Jun 2021 17:44:52 -0400
X-MC-Unique: BaiXqo66MB-HZt-EMIdxbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11073804141;
        Mon, 21 Jun 2021 21:44:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34A51608BA;
        Mon, 21 Jun 2021 21:44:45 +0000 (UTC)
Subject: [PATCH 00/12] fscache: Some prep work for fscache rewrite
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 22:44:44 +0100
Message-ID: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some patches that perform some preparatory work for the fscache
rewrite that's being worked on.  These include:

 (1) Always select netfs stats when enabling fscache stats since they're
     displayed through the same procfile.

 (2) Add a cookie debug ID that can be used in tracepoints instead of a
     pointer and cache it in the netfs_cache_resources struct rather than
     in the netfs_read_request struct to make it more available.

 (3) Use file_inode() in cachefiles rather than dereferencing file->f_inode
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

The patches can be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-next

David
---
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
 fs/cachefiles/internal.h          |  25 --
 fs/cachefiles/io.c                |   6 +-
 fs/cachefiles/key.c               |   2 +-
 fs/cachefiles/main.c              |   7 -
 fs/cachefiles/namei.c             |  61 ++---
 fs/cachefiles/proc.c              | 114 --------
 fs/cachefiles/xattr.c             |   4 +-
 fs/fscache/Kconfig                |  24 --
 fs/fscache/Makefile               |   2 -
 fs/fscache/cache.c                |  11 +-
 fs/fscache/cookie.c               | 201 +++++++++++----
 fs/fscache/fsdef.c                |   3 +-
 fs/fscache/histogram.c            |  87 -------
 fs/fscache/internal.h             |  57 +---
 fs/fscache/main.c                 |  39 +++
 fs/fscache/netfs.c                |   2 +-
 fs/fscache/object-list.c          | 414 ------------------------------
 fs/fscache/object.c               |   8 -
 fs/fscache/operation.c            |   3 -
 fs/fscache/page.c                 |   6 -
 fs/fscache/proc.c                 |  20 +-
 include/linux/fscache-cache.h     |   4 -
 include/linux/fscache.h           |   4 +-
 include/linux/netfs.h             |   2 +-
 include/trace/events/cachefiles.h |  68 ++---
 include/trace/events/fscache.h    | 160 ++++++------
 include/trace/events/netfs.h      |   2 +-
 31 files changed, 367 insertions(+), 998 deletions(-)
 delete mode 100644 fs/cachefiles/proc.c
 delete mode 100644 fs/fscache/histogram.c
 delete mode 100644 fs/fscache/object-list.c


