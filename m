Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF01939D955
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGKN2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 7 Jun 2021 06:13:28 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:29707 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230207AbhFGKN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:13:27 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-r5eD3qrcOUupjQ27LLY2Fg-1; Mon, 07 Jun 2021 06:11:32 -0400
X-MC-Unique: r5eD3qrcOUupjQ27LLY2Fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EE36A29F;
        Mon,  7 Jun 2021 10:11:30 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19C4D5D6D3;
        Mon,  7 Jun 2021 10:11:21 +0000 (UTC)
Subject: [PATCH v5 0/6] kernfs: proposed locking and concurrency improvement
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
Date:   Mon, 07 Jun 2021 18:11:20 +0800
Message-ID: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
      kernfs: add kernfs_need_inode_refresh()


 fs/kernfs/dir.c             | 155 ++++++++++++++++++++----------------
 fs/kernfs/file.c            |   4 +-
 fs/kernfs/inode.c           |  45 +++++++++--
 fs/kernfs/kernfs-internal.h |  29 ++++++-
 fs/kernfs/mount.c           |  12 +--
 fs/kernfs/symlink.c         |   4 +-
 include/linux/kernfs.h      |   7 +-
 7 files changed, 166 insertions(+), 90 deletions(-)

--
Ian

