Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4349F1EE8FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 18:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgFDQ63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 12:58:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729115AbgFDQ62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591289905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ErqaEYtQq+8H+ACe+CCYKF90Lhb/HNJTuhEz/C6gzAU=;
        b=hu9sfJKM77DaG/YR4xH0s/YwSgA8tmB5NN7oQEFUhC8048/P3rnIwZKTLsvmEIdTh3ckET
        NHVZ3w6p+nHp895jn5pqjNjAcX2Dqj/77nP9+KXsWBOPVp1LswPAtkBi8msUexQwFHaGun
        Nrm4/+qL9JfJO7pKM0TcwAR3Y0qpw3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-7SWia1yiMD-_yMrw-eLbKA-1; Thu, 04 Jun 2020 12:58:23 -0400
X-MC-Unique: 7SWia1yiMD-_yMrw-eLbKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37CBD1005510;
        Thu,  4 Jun 2020 16:58:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFCAF7CCD2;
        Thu,  4 Jun 2020 16:58:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Improvements for v5.8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2240659.1591289899.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 04 Jun 2020 17:58:19 +0100
Message-ID: <2240660.1591289899@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Is it too late to put in a pull request for AFS changes?  Apologies - I wa=
s
holding off and hoping that I could get Al to review the changes I made to
the core VFS change commit (first in the series) in response to his earlie=
r
review comments.  I have an ack for the Ext4 changes made, though.  If you
would prefer it to be held off at this point, fair enough.

Note that the series also got rebased to -rc7 to remove the dependency on
fix patches that got merged through the net tree.

---

There's one core VFS change which affects a couple of filesystems:

 (1) Make the inode hash table RCU safe and providing some RCU-safe
     accessor functions.  The search can then be done without taking the
     inode_hash_lock.  Care must be taken because the object may be being
     deleted and no wait is made.

 (2) Allow iunique() to avoid taking the inode_hash_lock.

 (3) Allow AFS's callback processing to avoid taking the inode_hash_lock
     when using the inode table to find an inode to notify.

 (4) Improve Ext4's time updating.  Konstantin Khlebnikov said "For now,
     I've plugged this issue with try-lock in ext4 lazy time update.  This
     solution is much better."

Then there's a set of changes to make a number of improvements to the AFS
driver:

 (1) Improve callback (ie. third party change notification) processing by:

     (a) Relying more on the fact we're doing this under RCU and by using
     	 fewer locks.  This makes use of the RCU-based inode searching
     	 outlined above.

     (b) Moving to keeping volumes in a tree indexed by volume ID rather
     	 than a flat list.

     (c) Making the server and volume records logically part of the cell.
     	 This means that a server record now points directly at the cell
     	 and the tree of volumes is there.  This removes an N:M mapping
     	 table, simplifying things.

 (2) Improve keeping NAT or firewall channels open for the server callback=
s
     to reach the client by actively polling the fileserver on a timed
     basis, instead of only doing it when we have an operation to process.

 (3) Improving detection of delayed or lost callbacks by including the
     parent directory in the list of file IDs to be queried when doing a
     bulk status fetch from lookup.  We can then check to see if our copy
     of the directory has changed under us without us getting notified.

 (4) Determine aliasing of cells (such as a cell that is pointed to be a
     DNS alias).  This allows us to avoid having ambiguity due to
     apparently different cells using the same volume and file servers.

 (5) Improve the fileserver rotation to do more probing when it detects
     that all of the addresses to a server are listed as non-responsive.
     It's possible that an address that previously stopped responding has
     become responsive again.

Beyond that, lay some foundations for making some calls asynchronous:

 (1) Turn the fileserver cursor struct into a general operation struct and
     hang the parameters off of that rather than keeping them in local
     variables and hang results off of that rather than the call struct.

 (2) Implement some general operation handling code and simplify the
     callers of operations that affect a volume or a volume component (suc=
h
     as a file).  Most of the operation is now done by core code.

 (3) Operations are supplied with a table of operations to issue different
     variants of RPCs and to manage the completion, where all the required
     data is held in the operation object, thereby allowing these to be
     called from a workqueue.

 (4) Put the standard "if (begin), while(select), call op, end" sequence
     into a canned function that just emulates the current behaviour for
     now.

There are also some fixes interspersed:

 (1) Don't let the EACCES from ICMP6 mapping reach the user as such, since
     it's confusing as to whether it's a filesystem error.  Convert it to
     EHOSTUNREACH.

 (2) Don't use the epoch value acquired through probing a server.  If we
     have two servers with the same UUID but in different cells, it's hard
     to draw conclusions from them having different epoch values.

 (3) Don't interpret the argument to the CB.ProbeUuid RPC as a fileserver
     UUID and look up a fileserver from it.

 (4) Deal with servers in different cells having the same UUIDs.  In the
     event that a CB.InitCallBackState3 RPC is received, we have to break
     the callback promises for every server record matching that UUID.

 (5) Don't let afs_statfs return values that go below 0.

 (6) Don't use running fileserver probe state to make server selection and
     address selection decisions on.  Only make decisions on final state a=
s
     the running state is cleared at the start of probing.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

Thanks,
David
---
The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a14=
5:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-next-20200604

for you to fetch changes up to 8409f67b6437c4b327ee95a71081b9c7bfee0b00:

  afs: Adjust the fileserver rotation algorithm to reprobe/retry more quic=
kly (2020-06-04 15:37:58 +0100)

----------------------------------------------------------------
AFS Changes

----------------------------------------------------------------
David Howells (27):
      vfs, afs, ext4: Make the inode hash table RCU searchable
      rxrpc: Map the EACCES error produced by some ICMP6 to EHOSTUNREACH
      rxrpc: Adjust /proc/net/rxrpc/calls to display call->debug_id not us=
er_ID
      afs: Always include dir in bulk status fetch from afs_do_lookup()
      afs: Use the serverUnique field in the UVLDB record to reduce rpc op=
s
      afs: Split the usage count on struct afs_server
      afs: Actively poll fileservers to maintain NAT or firewall openings
      afs: Show more information in /proc/net/afs/servers
      afs: Make callback processing more efficient.
      afs: Set error flag rather than return error from file status decode
      afs: Remove the error argument from afs_protocol_error()
      afs: Rename struct afs_fs_cursor to afs_operation
      afs: Build an abstraction around an "operation" concept
      afs: Don't get epoch from a server because it may be ambiguous
      afs: Fix handling of CB.ProbeUuid cache manager op
      afs: Retain more of the VLDB record for alias detection
      afs: Implement client support for the YFSVL.GetCellName RPC op
      afs: Detect cell aliases 1 - Cells with root volumes
      afs: Detect cell aliases 2 - Cells with no root volumes
      afs: Detect cell aliases 3 - YFS Cells with a canonical cell name op
      afs: Add a tracepoint to track the lifetime of the afs_volume struct
      afs: Reorganise volume and server trees to be rooted on the cell
      afs: Fix the by-UUID server tree to allow servers with the same UUID
      afs: Fix afs_statfs() to not let the values go below zero
      afs: Don't use probe running state to make decisions outside probe c=
ode
      afs: Show more a bit more server state in /proc/net/afs/servers
      afs: Adjust the fileserver rotation algorithm to reprobe/retry more =
quickly

 fs/afs/Makefile            |    2 +
 fs/afs/afs.h               |    3 +-
 fs/afs/afs_vl.h            |    1 +
 fs/afs/callback.c          |  345 ++++--------
 fs/afs/cell.c              |   10 +-
 fs/afs/cmservice.c         |   67 +--
 fs/afs/dir.c               | 1253 ++++++++++++++++++++-------------------=
---
 fs/afs/dir_silly.c         |  190 ++++---
 fs/afs/dynroot.c           |   93 ++++
 fs/afs/file.c              |   62 ++-
 fs/afs/flock.c             |  114 ++--
 fs/afs/fs_operation.c      |  239 ++++++++
 fs/afs/fs_probe.c          |  339 +++++++++---
 fs/afs/fsclient.c          | 1305 +++++++++++++++++----------------------=
-----
 fs/afs/inode.c             |  491 ++++++++---------
 fs/afs/internal.h          |  523 ++++++++++--------
 fs/afs/main.c              |    6 +-
 fs/afs/proc.c              |   42 +-
 fs/afs/protocol_yfs.h      |    2 +-
 fs/afs/rotate.c            |  447 ++++++---------
 fs/afs/rxrpc.c             |   45 +-
 fs/afs/security.c          |    8 +-
 fs/afs/server.c            |  299 ++++++----
 fs/afs/server_list.c       |   40 +-
 fs/afs/super.c             |  107 ++--
 fs/afs/vl_alias.c          |  382 +++++++++++++
 fs/afs/vl_rotate.c         |    4 +
 fs/afs/vlclient.c          |  146 ++++-
 fs/afs/volume.c            |  154 ++++--
 fs/afs/write.c             |  148 +++--
 fs/afs/xattr.c             |  300 +++++-----
 fs/afs/yfsclient.c         |  914 +++++++++++++------------------
 fs/ext4/inode.c            |   44 +-
 fs/inode.c                 |  112 +++-
 include/linux/fs.h         |    3 +
 include/trace/events/afs.h |  111 +++-
 net/rxrpc/peer_event.c     |    3 +
 net/rxrpc/proc.c           |    6 +-
 38 files changed, 4437 insertions(+), 3923 deletions(-)
 create mode 100644 fs/afs/fs_operation.c
 create mode 100644 fs/afs/vl_alias.c

