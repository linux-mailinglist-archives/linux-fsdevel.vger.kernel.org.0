Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82994410FDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhITHKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 03:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230151AbhITHKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632121759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f8Su88cSUt3cWFAxv1X533at/dJ+/eptY58lpzCVadk=;
        b=S/u2VKSkTY/B2OwkmAmHpLtbh56rmDbh9n/oiCsT8CIMJJLU+3y0e7pwcbVcKrTEQImdBr
        sFlrfJNu9sDy1iEGgJJlpYzk8n+iwNAwWiIk0SKsYbZvju4ZE1bD3FPFESHcp7sgPgzdxi
        lNvWZOg03t+bb7UAiZ/RB3+07Y0cNiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-IjhP14GGP6mmvqkXZ7XAvw-1; Mon, 20 Sep 2021 03:09:16 -0400
X-MC-Unique: IjhP14GGP6mmvqkXZ7XAvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F305E802C98;
        Mon, 20 Sep 2021 07:09:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 813F6101E87D;
        Mon, 20 Sep 2021 07:09:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Markus Suvanto <markus.suvanto@gmail.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes for 3rd party-induced data corruption
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2718619.1632121752.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 20 Sep 2021 08:09:12 +0100
Message-ID: <2718620.1632121752@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull these fixes for AFS that can cause data corruption due to
interaction with another client modifying data cached locally please[1]?

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
     tries to access the mmapped address range again - and at that point w=
e
     can query the server and, if we need to, zap the page cache.

     Ideally, I would check each file at the point of notification, but
     that involves poking the server[*] - which is holding an exclusive
     lock on the vnode it is changing, waiting for all the clients it
     notified to reply.  This could then deadlock against the server.
     Further, invalidating the pagecache might call ->launder_page(), whic=
h
     would try to write to the file, which would definitely deadlock.  (AF=
S
     doesn't lease file access).

     [*] Checking to see if the file content has changed is a matter of
     	 comparing the current data version number, but we have to ask the
     	 server for that.  We also need to get a new callback promise and
     	 we need to poke the server for that too.

 (3) Add some more points at which the inode is validated, since we're
     doing it lazily, notably in ->read_iter() and ->page_mkwrite(), but
     also when performing some directory operations.

     Ideally, checking in ->read_iter() would be done in some derivation o=
f
     filemap_read().  If we're going to call the server to read the file,
     then we get the file status fetch as part of that.

 (4) The above is now causing us to make a lot more calls to afs_validate(=
)
     to check the inode - and afs_validate() takes the RCU read lock each
     time to make a quick check (ie. afs_check_validity()).  This is
     entirely for the purpose of checking cb_s_break to see if the server
     we're using reinitialised its list of callbacks - however this isn't =
a
     very common event, so most of the time we're taking this needlessly.

     Add a new cell-wide counter to count the number of reinitialisations
     done by any server and check that - and only if that changes, take th=
e
     RCU read lock and check the server list (the server list may change,
     but the cell a file is part of won't).

 (5) Don't update vnode->cb_s_break and ->cb_v_break inside the validity
     checking loop.  The cb_lock is done with read_seqretry, so we might g=
o
     round the loop a second time after resetting those values - and that
     could cause someone else checking validity to miss something (I
     think).

Also included are patches for fixes for some bugs encountered whilst
debugging this.

 (6) Fix a leak of afs_read objects and fix a leak of keys hidden by that.

 (7) Fix a leak of pages that couldn't be added to extend a writeback.

 (8) Fix the maintenance of i_blocks when i_size is changed by a local
     write or a local dir edit[**].

     [**] Would you prefer this patch separately to the other patches?

David

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214217 [1]
Link: https://lore.kernel.org/r/163111665183.283156.17200205573146438918.s=
tgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163113612442.352844.11162345591911691150.s=
tgit@warthog.procyon.org.uk/ # i_blocks patch
---

The following changes since commit b91db6a0b52e019b6bdabea3f1dbe36d85c7e52=
c:

  Merge tag 'for-5.15/io_uring-vfs-2021-08-30' of git://git.kernel.dk/linu=
x-block (2021-08-30 19:39:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20210913

for you to fetch changes up to 9d37e1cab2a9d2cee2737973fa455e6f89eee46a:

  afs: Fix updating of i_blocks on file/dir extension (2021-09-13 09:14:21=
 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (8):
      afs: Fix missing put on afs_read objects and missing get on the key =
therein
      afs: Fix page leak
      afs: Add missing vnode validation checks
      afs: Fix incorrect triggering of sillyrename on 3rd-party invalidati=
on
      afs: Fix mmap coherency vs 3rd-party changes
      afs: Try to avoid taking RCU read lock when checking vnode validity
      afs: Fix corruption in reads at fpos 2G-4G from an OpenAFS server
      afs: Fix updating of i_blocks on file/dir extension

 fs/afs/callback.c          | 44 ++++++++++++++++++++-
 fs/afs/cell.c              |  2 +
 fs/afs/dir.c               | 57 +++++++++------------------
 fs/afs/dir_edit.c          |  4 +-
 fs/afs/file.c              | 86 ++++++++++++++++++++++++++++++++++++++--
 fs/afs/fs_probe.c          |  8 +++-
 fs/afs/fsclient.c          | 31 +++++++++------
 fs/afs/inode.c             | 98 ++++++++++++++++++++---------------------=
-----
 fs/afs/internal.h          | 21 ++++++++++
 fs/afs/protocol_afs.h      | 15 +++++++
 fs/afs/protocol_yfs.h      |  6 +++
 fs/afs/rotate.c            |  1 +
 fs/afs/server.c            |  2 +
 fs/afs/super.c             |  1 +
 fs/afs/write.c             | 29 +++++++++++---
 include/trace/events/afs.h |  8 +++-
 mm/memory.c                |  1 +
 17 files changed, 294 insertions(+), 120 deletions(-)
 create mode 100644 fs/afs/protocol_afs.h

