Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6463A7BBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhFOK2A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:28:00 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:43677 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231327AbhFOK17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:27:59 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-h_lDR4XNM2Kg48Ch7OVvDA-1; Tue, 15 Jun 2021 06:25:50 -0400
X-MC-Unique: h_lDR4XNM2Kg48Ch7OVvDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46A5280364C;
        Tue, 15 Jun 2021 10:25:48 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-40.sin2.redhat.com [10.67.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F098060C0F;
        Tue, 15 Jun 2021 10:25:39 +0000 (UTC)
Subject: [PATCH v7 0/6] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Jun 2021 18:25:35 +0800
Message-ID: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There have been a few instances of contention on the kernfs_mutex during
path walks, a case on very large IBM systems seen by myself, a report by
Brice Goglin and followed up by Fox Chen, and I've since seen a couple
of other reports by CoreOS users.

The common thread is a large number of kernfs path walks leading to
slowness of path walks due to kernfs_mutex contention.

The problem being that changes to the VFS over some time have increased
it's concurrency capabilities to an extent that kernfs's use of a mutex
is no longer appropriate. There's also an issue of walks for non-existent
paths causing contention if there are quite a few of them which is a less
common problem.

This patch series is relatively straight forward.

All it does is add the ability to take advantage of VFS negative dentry
caching to avoid needless dentry alloc/free cycles for lookups of paths
that don't exit and change the kernfs_mutex to a read/write semaphore.

This patch series is relatively straight forward.

All it does is add the ability to take advantage of VFS negative dentry
caching to avoid needless dentry alloc/free cycles for lookups of paths
that don't exit and change the kernfs_mutex to a read/write semaphore.

The patch that tried to stay in VFS rcu-walk mode during path walks has
been dropped for two reasons. First, it doesn't actually give very much
improvement and, second, if there's a place where mistakes could go
unnoticed it would be in that path. This makes the patch series simpler
to review and reduces the likelihood of problems going unnoticed and
popping up later.

Changes since v6:
- ensure negative dentry as rename target gets invalidated.
- don't bother checking if node is a directory in revision helpers.
- don't use dget_parent(), just use dentry d_lock to ensure parent
  is stable.
- fix kernfs_iop_getattr() and kernfs_iop_permission() locking.
- drop add kernfs_need_inode_refresh() patch, it can't be used.

Changes since v5:
- change kernfs_dir_changed() comparison.
- move negative dentry out from under kernfs node lock in revalidate.
- only set d_time for negative dentries.
- add patch to move d_splice_alias() out from under kernfs node lock
  in lookup.

Changes since v4:
- fixed kernfs_active() naming.
- added back kernfs_node revision patch to use for negative dentry
  validation.
- minor updates to patch descriptions.

Changes since v3:
- remove unneeded indirection when referencing the super block.
- check if inode attribute update is actually needed.

Changes since v2:
- actually fix the inode attribute update locking.
- drop the patch that tried to stay in rcu-walk mode.
- drop the use a revision to identify if a directory has changed patch.

Changes since v1:
- fix locking in .permission() and .gated() by re-factoring the
  attribute handling code.
---

Ian Kent (6):
      kernfs: move revalidate to be near lookup
      kernfs: add a revision to identify directory node changes
      kernfs: use VFS negative dentry caching
      kernfs: switch kernfs to use an rwsem
      kernfs: use i_lock to protect concurrent inode updates
      kernfs: dont call d_splice_alias() under kernfs node lock


 fs/kernfs/dir.c             | 151 ++++++++++++++++++++----------------
 fs/kernfs/file.c            |   4 +-
 fs/kernfs/inode.c           |  26 ++++---
 fs/kernfs/kernfs-internal.h |  24 +++++-
 fs/kernfs/mount.c           |  12 +--
 fs/kernfs/symlink.c         |   4 +-
 include/linux/kernfs.h      |   7 +-
 7 files changed, 136 insertions(+), 92 deletions(-)

--
Ian

