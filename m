Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440CB3A0EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhFIIvd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 9 Jun 2021 04:51:33 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:28958 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229740AbhFIIvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:51:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-JBFnEtmXMAmnbWzYpR0ofw-1; Wed, 09 Jun 2021 04:49:34 -0400
X-MC-Unique: JBFnEtmXMAmnbWzYpR0ofw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E73919057A5;
        Wed,  9 Jun 2021 08:49:32 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-20.sin2.redhat.com [10.67.116.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EAE45D9E3;
        Wed,  9 Jun 2021 08:49:16 +0000 (UTC)
Subject: [PATCH v6 0/7] kernfs: proposed locking and concurrency improvement
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
Date:   Wed, 09 Jun 2021 16:49:14 +0800
Message-ID: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

The patch that tried to stay in VFS rcu-walk mode during path walks has
been dropped for two reasons. First, it doesn't actually give very much
improvement and, second, if there's a place where mistakes could go
unnoticed it would be in that path. This makes the patch series simpler
to review and reduces the likelihood of problems going unnoticed and
popping up later.

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

Ian Kent (7):
      kernfs: move revalidate to be near lookup
      kernfs: add a revision to identify directory node changes
      kernfs: use VFS negative dentry caching
      kernfs: switch kernfs to use an rwsem
      kernfs: use i_lock to protect concurrent inode updates
      kernfs: add kernfs_need_inode_refresh()
      kernfs: dont call d_splice_alias() under kernfs node lock


 fs/kernfs/dir.c             | 150 +++++++++++++++++++-----------------
 fs/kernfs/file.c            |   4 +-
 fs/kernfs/inode.c           |  45 +++++++++--
 fs/kernfs/kernfs-internal.h |  28 ++++++-
 fs/kernfs/mount.c           |  12 +--
 fs/kernfs/symlink.c         |   4 +-
 include/linux/kernfs.h      |   7 +-
 7 files changed, 160 insertions(+), 90 deletions(-)

--
Ian

