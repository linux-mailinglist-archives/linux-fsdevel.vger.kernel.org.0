Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6DA1E8A89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgE2WAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:00:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728267AbgE2WAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pxbvmVbl9lsruKM4AA1eWb8CAia0DHVSFuL5O/ctfrI=;
        b=jLjMt1LJhEx9OvLHOhXgYJjnEIpLGkdhNgi9jZz9QviJ8wYjju0huk4u9NUrLPmEJxOIyf
        uvLbpZoIPDhqzlF7H1DAANAmeRWAzERw9I5A3zBjKR1EJG98DP8zcUKUReGYCN/e5PriBB
        rLsPiFeAXOF4HLSiYSf4xu7yciJq3iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-ufnsmF08M5m8DCBHuapQYg-1; Fri, 29 May 2020 18:00:04 -0400
X-MC-Unique: ufnsmF08M5m8DCBHuapQYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 806BD18A8220;
        Fri, 29 May 2020 22:00:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968BB5C1B5;
        Fri, 29 May 2020 22:00:00 +0000 (UTC)
Subject: [PATCH 00/27] afs: Improvements
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     linux-ext4@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jeffrey Altman <jaltman@auristor.com>,
        Dave Botsch <botsch@cnf.cornell.edu>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 22:59:59 +0100
Message-ID: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to make a number of improvements to the AFS driver:

 (1) Improve callback (ie. third party change notification) processing by:

     (a) Relying more on the fact we're doing this under RCU and by using
     	 fewer locks.

     	 This involves making the inode hash table RCU safe and providing
     	 some RCU-safe accessor functions.  The search can then be done
     	 without taking the inode_hash_lock.  Care must be taken because
     	 the object may be being deleted and no wait is made.

 	 This is also used to improve Ext4's time updating.  Konstantin
     	 Khlebnikov said "For now, I've plugged this issue with try-lock in
     	 ext4 lazy time update.  This solution is much better."

     (b) Moving to keeping volumes in a tree indexed by volume ID rather
     	 than a flat list.

     (c) Making the server and volume records logically part of the cell.
     	 This means that a server record now points directly at the cell
     	 and the tree of volumes is there.  This removes an N:M mapping
     	 table, simplifying things.

 (2) Improve keeping NAT or firewall channels open for the server callbacks
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
     callers of operations that affect a volume or a volume component (such
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
     address selection decisions on.  Only make decisions on final state as
     the running state is cleared at the start of probing.

The patches are here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

David
---
David Howells (1):
      afs: Adjust the fileserver rotation algorithm to reprobe/retry more quickly


 fs/afs/Makefile            |    2 +
 fs/afs/afs.h               |    3 +-
 fs/afs/afs_vl.h            |    1 +
 fs/afs/callback.c          |  345 ++++--------
 fs/afs/cell.c              |   10 +-
 fs/afs/cmservice.c         |   67 +--
 fs/afs/dir.c               | 1253 ++++++++++++++++++++----------------------
 fs/afs/dir_silly.c         |  190 +++----
 fs/afs/dynroot.c           |   93 ++++
 fs/afs/file.c              |   62 ++-
 fs/afs/flock.c             |  114 ++--
 fs/afs/fs_operation.c      |  239 ++++++++
 fs/afs/fs_probe.c          |  339 +++++++++---
 fs/afs/fsclient.c          | 1295 +++++++++++++++++---------------------------
 fs/afs/inode.c             |  491 ++++++++---------
 fs/afs/internal.h          |  523 ++++++++++--------
 fs/afs/main.c              |    6 +-
 fs/afs/proc.c              |   42 +-
 fs/afs/protocol_yfs.h      |    2 +-
 fs/afs/rotate.c            |  443 ++++++---------
 fs/afs/rxrpc.c             |   45 +-
 fs/afs/security.c          |    8 +-
 fs/afs/server.c            |  299 ++++++----
 fs/afs/server_list.c       |   40 +-
 fs/afs/super.c             |  107 ++--
 fs/afs/vl_alias.c          |  384 +++++++++++++
 fs/afs/vl_rotate.c         |    4 +
 fs/afs/vlclient.c          |  146 ++++-
 fs/afs/volume.c            |  152 ++++--
 fs/afs/write.c             |  148 +++--
 fs/afs/xattr.c             |  300 +++++-----
 fs/afs/yfsclient.c         |  914 +++++++++++++------------------
 fs/ext4/inode.c            |   44 +-
 fs/inode.c                 |  173 +++++-
 include/linux/fs.h         |    3 +
 include/trace/events/afs.h |  111 +++-
 net/rxrpc/peer_event.c     |    3 +
 net/rxrpc/proc.c           |    6 +-
 38 files changed, 4484 insertions(+), 3923 deletions(-)
 create mode 100644 fs/afs/fs_operation.c
 create mode 100644 fs/afs/vl_alias.c


