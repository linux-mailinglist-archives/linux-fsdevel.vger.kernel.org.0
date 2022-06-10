Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2850B546DDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 21:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350529AbiFJT5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350515AbiFJT46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3B3311C00
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654891015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=irp9I7bg5aP2EcRerJx9k5cqapFEVHVDaAOauS4ZbRQ=;
        b=W13vQjgo8f9GO64Keid/uOeRE1Bphu+FhJVjVCf1iecZaAPQhaENDgGZVhbm5aiM6VtCIX
        pwv6uOmvvjTkXeQIXNWaTuGC/2XLmrUzkBeLpPTKy4UtWTxJsULM9amkw8FtL3ccznwzAg
        ZSoFxnDTy4Wjskag3Ylhqbj7z0B8R3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121----5JlC7Nga4prmah_EWXw-1; Fri, 10 Jun 2022 15:56:49 -0400
X-MC-Unique: ---5JlC7Nga4prmah_EWXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B090801756;
        Fri, 10 Jun 2022 19:56:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1B6F40CF8EF;
        Fri, 10 Jun 2022 19:56:46 +0000 (UTC)
Subject: [RFC][PATCH 0/3] netfs, afs: Cleanups
From:   David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 10 Jun 2022 20:56:45 +0100
Message-ID: <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus,

Here are some cleanups, one for afs and a couple for netfs:

 (1) The afs patch cleans up a checker complaint.

 (2) The first netfs patch is your netfs_inode changes plus the requisite
     documentation changes.

 (3) The second netfs patch replaces the ->cleanup op with a ->free_request
     op.  This is possible as the I/O request is now always available at
     the cleanup point as the stuff to be cleaned up is no longer passed
     into the API functions, but rather obtained by ->init_request.

I've run the patches through xfstests with -g quick on afs.

The patches are on a branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-fixes

David

---
David Howells (2):
      afs: Fix some checker issues
      netfs: Rename the netfs_io_request cleanup op and give it an op pointer

Linus Torvalds (1):
      netfs: Further cleanups after struct netfs_inode wrapper introduced


 Documentation/filesystems/netfs_library.rst | 33 +++++++++++----------
 fs/9p/v9fs.h                                |  2 +-
 fs/9p/vfs_addr.c                            | 13 ++++----
 fs/9p/vfs_inode.c                           |  3 +-
 fs/afs/dynroot.c                            |  2 +-
 fs/afs/file.c                               |  6 ++--
 fs/afs/inode.c                              |  2 +-
 fs/afs/internal.h                           |  2 +-
 fs/afs/volume.c                             |  3 +-
 fs/afs/write.c                              |  2 +-
 fs/ceph/addr.c                              | 12 ++++----
 fs/ceph/cache.h                             |  2 +-
 fs/ceph/inode.c                             |  2 +-
 fs/cifs/fscache.h                           |  2 +-
 fs/netfs/buffered_read.c                    |  5 ++--
 fs/netfs/objects.c                          |  6 ++--
 include/linux/netfs.h                       | 25 +++++++---------
 17 files changed, 60 insertions(+), 62 deletions(-)


