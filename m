Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD22416BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEGULT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 7 May 2019 16:11:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfEGULT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 16:11:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E1B083F3C;
        Tue,  7 May 2019 20:11:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D73B717B90;
        Tue,  7 May 2019 20:11:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFS fixes and development
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28467.1557259876.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 07 May 2019 21:11:17 +0100
Message-ID: <28470.1557259877@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 07 May 2019 20:11:19 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

The following are a set of fix and development patches for AFS for 5.2.  To
summarise:

 (1) Fix the AFS file locking so that sqlite can run on an AFS mount and
     also so that firefox and gnome can use a homedir that's mounted
     through AFS.

     This required emulation of fine-grained locking when the server will
     only support whole-file locks and no upgrade/downgrade.  Four modes
     are provided, settable by mount parameter:

     "flock=local" - No reference to the server

     "flock=openafs" - Fine-grained locks are local-only, whole-file locks
     require sufficient server locks

     "flock=strict" - All locks require sufficient server locks

     "flock=write" - Always get an exclusive server lock

     If the volume is a read-only or backup volume, then flock=local for
     that volume.

 (2) Log extra information for a couple of cases where the client mucks up
     somehow: AFS vnode with undefined type and dir check failure - in both
     cases we seem to end up with unfilled data, but the issues happen
     infrequently and are difficult to reproduce at will.

 (3) Implement silly rename for unlink() and rename().

 (4) Set i_blocks so that du can get some information about usage.

 (5) Fix xattr handlers to return the right amount of data and to not
     overflow buffers.

 (6) Implement getting/setting raw AFS and YFS ACLs as xattrs.

Tested-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---
The following changes since commit cd8dead0c39457e58ec1d36db93aedca811d48f1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-04-24 16:18:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20190507

for you to fetch changes up to f5e4546347bc847be30b3cf904db5fc874b3c5dc:

  afs: Implement YFS ACL setting (2019-05-07 16:48:44 +0100)

----------------------------------------------------------------
AFS Development

----------------------------------------------------------------
David Howells (17):
      afs: Split wait from afs_make_call()
      afs: Calculate lock extend timer from set/extend reply reception
      afs: Fix AFS file locking to allow fine grained locks
      afs: Further fix file locking
      afs: Add file locking tracepoints
      afs: Improve dir check failure reports
      afs: Handle lock rpc ops failing on a file that got deleted
      afs: Add directory reload tracepoint
      afs: Implement sillyrename for unlink and rename
      afs: Add more tracepoints
      afs: Provide mount-time configurable byte-range file locking emulation
      afs: Log more information for "kAFS: AFS vnode with undefined type\n"
      afs: Fix the afs.cell and afs.volume xattr handlers
      afs: Fix getting the afs.fid xattr
      afs: Get an AFS3 ACL as an xattr
      afs: Get YFS ACLs and information through xattrs
      afs: Implement YFS ACL setting

Joe Gorse (1):
      afs: implement acl setting

Marc Dionne (1):
      afs: Calculate i_blocks based on file size

 fs/afs/Makefile            |   1 +
 fs/afs/afs_fs.h            |   2 +
 fs/afs/dir.c               | 167 ++++++++++--
 fs/afs/dir_silly.c         | 239 ++++++++++++++++++
 fs/afs/flock.c             | 616 ++++++++++++++++++++++++++++-----------------
 fs/afs/fs_probe.c          |  13 +-
 fs/afs/fsclient.c          | 277 +++++++++++++++++---
 fs/afs/inode.c             |  43 +++-
 fs/afs/internal.h          |  64 ++++-
 fs/afs/protocol_yfs.h      |   6 +-
 fs/afs/rxrpc.c             |  33 ++-
 fs/afs/super.c             |  34 ++-
 fs/afs/vl_probe.c          |  14 +-
 fs/afs/vlclient.c          |  26 +-
 fs/afs/xattr.c             | 270 +++++++++++++++++++-
 fs/afs/yfsclient.c         | 329 +++++++++++++++++++++---
 include/linux/fs.h         |   1 +
 include/trace/events/afs.h | 385 +++++++++++++++++++++++++++-
 18 files changed, 2142 insertions(+), 378 deletions(-)
 create mode 100644 fs/afs/dir_silly.c
