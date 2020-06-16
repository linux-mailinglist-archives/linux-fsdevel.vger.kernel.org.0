Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D981FC12F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFPVvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 17:51:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgFPVvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592344312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pa26AneX0j3DPUjeJdvfIiB6K0FofWmkV9YrdZxZmQs=;
        b=a55P7Mb3q4p4wgansmTh5VoQXMTNEK0CdutfOOBHSuAvTX/Nm/NvFkMe/8p8Wk3sYxS5Rl
        47F7HisAYwlLL1rkJtb8b+IwyvDhtlW/xQdZQL1jkpO5y+bSsVLMtSgNuvnpbqzKeiyBMl
        wmUoDnOta+tInw+mR1JXfvG9dlBzzUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-ShKAFPiiPxSqZyoOOcsMPg-1; Tue, 16 Jun 2020 17:51:50 -0400
X-MC-Unique: ShKAFPiiPxSqZyoOOcsMPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D324C10059B4;
        Tue, 16 Jun 2020 21:51:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A59DA60C80;
        Tue, 16 Jun 2020 21:51:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes for bugs found by xfstests
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <930957.1592344306.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 16 Jun 2020 22:51:46 +0100
Message-ID: <930958.1592344306@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

I've managed to get xfstests kind of working with afs.  Here are a set of
patches that fix most of the bugs found.

There are a number of primary issues:

 (1) Incorrect handling of mtime and non-handling of ctime.  It might be
     argued, that the latter isn't a bug since the AFS protocol doesn't
     support ctime, but I should probably still update it locally.

 (2) Shared-write mmap, truncate and writeback bugs.  This includes not
     changing i_size under the callback lock, overwriting local i_size wit=
h
     the reply from the server after a partial writeback, not limiting the
     writeback from an mmapped page to EOF.

 (3) Checks for an abort code indicating that the primary vnode in an
     operation was deleted by a third-party are done in the wrong place.

 (4) Silly rename bugs.  This includes an incomplete conversion to the new
     operation handling, duplicate nlink handling, nlink changing not bein=
g
     done inside the callback lock and insufficient handling of third-part=
y
     conflicting directory changes.

And some secondary ones:

 (1) The UAEOVERFLOW abort code should map to EOVERFLOW not EREMOTEIO.

 (2) Remove a couple of unused or incompletely used bits.

 (3) Remove a couple of redundant success checks.

These seem to fix all the data-corruption bugs found by "./check -afs -g
quick", along with the obvious silly rename bugs and time bugs.

There are still some test failures, but they seem to fall into two classes=
:
firstly, the authentication/security model is different to the standard
UNIX model and permission is arbitrated by the server and cached locally;
and secondly, there are a number of features that AFS does not support
(such as mknod).  But in these cases, the tests themselves need to be
adapted or skipped.

Using the in-kernel afs client with xfstests also found a bug in the
AuriStor AFS server that has been fixed for a future release.

David
---
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c740=
7:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20200616

for you to fetch changes up to b6489a49f7b71964e37978d6f89bbdbdb263f6f5:

  afs: Fix silly rename (2020-06-16 22:00:28 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (12):
      afs: Fix non-setting of mtime when writing into mmap
      afs: afs_write_end() should change i_size under the right lock
      afs: Fix EOF corruption
      afs: Concoct ctimes
      afs: Fix truncation issues and mmap writeback size
      afs: Fix the mapping of the UAEOVERFLOW abort code
      afs: Remove yfs_fs_fetch_file_status() as it's not used
      afs: Fix yfs_fs_fetch_status() to honour vnode selector
      afs: Remove afs_operation::abort_code
      afs: Fix use of afs_check_for_remote_deletion()
      afs: afs_vnode_commit_status() doesn't need to check the RPC error
      afs: Fix silly rename

 fs/afs/dir.c          | 62 ++++++++++++++++++++++++++++++----
 fs/afs/dir_silly.c    | 38 +++++++++++++++------
 fs/afs/file.c         |  2 +-
 fs/afs/flock.c        |  4 +--
 fs/afs/fs_operation.c | 10 +++++-
 fs/afs/inode.c        | 91 ++++++++++++++++++++++++++++++++++++++--------=
---
 fs/afs/internal.h     | 36 +++++++++++++-------
 fs/afs/misc.c         |  1 +
 fs/afs/write.c        | 12 +++++--
 fs/afs/yfsclient.c    | 93 ++++++++++++++--------------------------------=
-----
 10 files changed, 225 insertions(+), 124 deletions(-)

