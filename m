Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870B33F5EE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhHXNZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 09:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhHXNZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629811485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UJrfd86tR0Yk7ZIVAdwqtRJBEFVA/ho7C/JF2A2SL3I=;
        b=LuKUq+UlvUbUQ9DUAIJBnbKG58QQaqYET+dcEkn8AJx0ahqeR3y94HNDfJdtzq5uwYO8yL
        H/1gER44KaVcpMeKN+kEWukVDkfWX/jp6Yaadd3u4kIj+9WIZUiGJukxpkCkgvPLH7H9S+
        OSRVC33okqa4A6UWHdBWQIgluDpf6HE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-6xbBUESKNQCq4Y_eoBj7LA-1; Tue, 24 Aug 2021 09:24:44 -0400
X-MC-Unique: 6xbBUESKNQCq4Y_eoBj7LA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A0DD801A92;
        Tue, 24 Aug 2021 13:24:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0C583AA2;
        Tue, 24 Aug 2021 13:24:35 +0000 (UTC)
Subject: [PATCH 0/6] netfs, afs, ceph: Support folios, at least partially
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-afs@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Aug 2021 14:24:34 +0100
Message-ID: <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to convert netfs and afs to use folios and to
provide sufficient conversion for ceph that it can continue to use the
netfs library.  Jeff Layton is working on fully converting ceph.

This based on top of part of Matthew Wilcox's folio changes[1]

David

Link: https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next [1]
Link: https://lore.kernel.org/r/2408234.1628687271@warthog.procyon.org.uk/ # v0
---
David Howells (6):
      afs: Fix afs_launder_page() to set correct start file position
      folio: Add a function to change the private data attached to a folio
      folio: Add a function to get the host inode for a folio
      afs: Sort out symlink reading
      netfs, afs, ceph: Use folios
      afs: Use folios in directory handling


 fs/afs/dir.c               | 229 +++++++++++--------------
 fs/afs/dir_edit.c          | 154 ++++++++---------
 fs/afs/file.c              |  82 +++++----
 fs/afs/inode.c             |   6 +-
 fs/afs/internal.h          |  49 +++---
 fs/afs/write.c             | 333 ++++++++++++++++++-------------------
 fs/ceph/addr.c             |  80 ++++-----
 fs/netfs/read_helper.c     | 165 +++++++++---------
 include/linux/netfs.h      |  12 +-
 include/linux/pagemap.h    |  33 ++++
 include/trace/events/afs.h |  21 +--
 mm/page-writeback.c        |   2 +-
 12 files changed, 584 insertions(+), 582 deletions(-)


