Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA35403D12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352214AbhIHP6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349773AbhIHP6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ZOJvbxzO8BUjr09tA/fWWBxB+TgiUoA1TeVch1z3+g=;
        b=ELaF+Ac+QuKmoYkLiSUfzPk+FEX4Qq5yrdTGQ7ovUpvQjIKJoDyD5UMTrc4tcGZy7WoBB6
        O4F3Q1EEKtk8ItZWDeK82/qEaiDC/FNQ4MlxaP+j3qrz1tVakv7fU3jxjJacKYF0Oy9Wxn
        Qe9kxzJ3RxcbwgTpDSeUj0UmZehiefw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-r85xmPL7NxWt5Og6R6_qbA-1; Wed, 08 Sep 2021 11:57:35 -0400
X-MC-Unique: r85xmPL7NxWt5Og6R6_qbA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3DD18414A1;
        Wed,  8 Sep 2021 15:57:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99D0E5C1BB;
        Wed,  8 Sep 2021 15:57:32 +0000 (UTC)
Subject: [PATCH 0/6] afs: Fixes for 3rd party-induced data corruption
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Markus Suvanto <markus.suvanto@gmail.com>, dhowells@redhat.com,
        markus.suvanto@gmail.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:57:31 +0100
Message-ID: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some fixes for AFS that can cause data corruption due to
interaction with another client modifying data cached locally[1].

 (1) When d_revalidating a dentry, don't look at the inode to which it
     points.  Only check the directory to which the dentry belongs.  This
     was confusing things and causing the silly-rename cleanup code to
     remove the file now at the dentry of a file that got deleted.

 (2) Fix mmap data coherency.  When a callback break is received that
     relates to a file that we have cached, the data content may have been
     changed (there are other reasons, such as the user's rights having
     been changed).  However, we're checking it lazily, only on entry to
     the kernel, which doesn't happen if we have a writeable shared mapped
     page on that file.

     We make the kernel keep track of mmapped files and clear all PTEs
     mapping to that file as soon as the callback comes in by calling
     unmap_mapping_pages() (we don't necessarily want to zap the
     pagecache).  This causes the kernel to be reentered when userspace
     tries to access the mmapped address range again - and at that point we
     can query the server and, if we need to, zap the page cache.

     Ideally, I would check each file at the point of notification, but
     that involves poking the server[*] - which is holding up final closure
     of the change it is making, waiting for all the clients it notified to
     reply.  This could then deadlock against the server.  Further,
     invalidating the pagecache might call ->launder_page(), which would
     try to write to the file, which would definitely deadlock.  (AFS
     doesn't lease file access).

     [*] Checking to see if the file content has changed is a matter of
     	 comparing the current data version number, but we have to ask the
     	 server for that.  We also need to get a new callback promise and
     	 we need to poke the server for that too.

 (3) Add some more points at which the inode is validated, since we're
     doing it lazily, notably in ->read_iter() and ->page_mkwrite(), but
     also when performing some directory operations.

     Ideally, checking in ->read_iter() would be done in some derivation of
     filemap_read().  If we're going to call the server to read the file,
     then we get the file status fetch as part of that.

 (4) The above is now causing us to make a lot more calls to afs_validate()
     to check the inode - and afs_validate() takes the RCU read lock each
     time to make a quick check (ie. afs_check_validity()).  This is
     entirely for the purpose of checking cb_s_break to see if the server
     we're using reinitialised its list of callbacks - however this isn't a
     very common operation, so most of the time we're taking this
     needlessly.

     Add a new cell-wide counter to count the number of reinitialisations
     done by any server and check that - and only if that changes, take the
     RCU read lock and check the server list (the server list may change,
     but the cell a file is part of won't).

 (5) Don't update vnode->cb_s_break and ->cb_v_break inside the validity
     checking loop.  The cb_lock is done with read_seqretry, so we might go
     round the loop a second time after resetting those values - and that
     could cause someone else checking validity to miss something (I
     think).

Also included are patches for fixes for some bugs encountered whilst
debugging this.

 (6) Fix a leak of afs_read objects and fix a leak of keys hidden by that.

 (7) Fix a leak of pages that couldn't be added to extend a writeback.


The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214217 [1]

---
David Howells (6):
      afs: Fix missing put on afs_read objects and missing get on the key therein
      afs: Fix page leak
      afs: Add missing vnode validation checks
      afs: Fix incorrect triggering of sillyrename on 3rd-party invalidation
      afs: Fix mmap coherency vs 3rd-party changes
      afs: Try to avoid taking RCU read lock when checking vnode validity


 fs/afs/callback.c          | 44 ++++++++++++++++++-
 fs/afs/cell.c              |  2 +
 fs/afs/dir.c               | 57 ++++++++----------------
 fs/afs/file.c              | 83 ++++++++++++++++++++++++++++++++++-
 fs/afs/inode.c             | 88 +++++++++++++++++++-------------------
 fs/afs/internal.h          | 10 +++++
 fs/afs/rotate.c            |  1 +
 fs/afs/server.c            |  2 +
 fs/afs/super.c             |  1 +
 fs/afs/write.c             | 27 ++++++++++--
 include/trace/events/afs.h |  8 +++-
 mm/memory.c                |  1 +
 12 files changed, 230 insertions(+), 94 deletions(-)


