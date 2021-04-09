Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA2359135
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhDIBPJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 8 Apr 2021 21:15:09 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:38768 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233118AbhDIBPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:15:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-xYBwDj1mPMuHmM2iYtXvxQ-1; Thu, 08 Apr 2021 21:14:51 -0400
X-MC-Unique: xYBwDj1mPMuHmM2iYtXvxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8174E801814;
        Fri,  9 Apr 2021 01:14:49 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-30.sin2.redhat.com [10.67.116.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DAE25B69B;
        Fri,  9 Apr 2021 01:14:46 +0000 (UTC)
Subject: [PATCH v3 0/4] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Brice Goglin <brice.goglin@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 09 Apr 2021 09:14:44 +0800
Message-ID: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

The patch to use a revision to identify if a directory has changed has
also been dropped. If the directory has changed the dentry revision
needs to be updated to avoid subsequent rb tree searches and after
changing to use a read/write semaphore the update also requires a lock.
But the d_lock is the only lock available at this point which might
itself be contended.

Changes since v2:
- actually fix the inode attribute update locking.
- drop the patch that tried to stay in rcu-walk mode.
- drop the use a revision to identify if a directory has changed patch.

Changes since v1:
- fix locking in .permission() and .getattr() by re-factoring the attribute
  handling code.

---

Ian Kent (4):
      kernfs: move revalidate to be near lookup
      kernfs: use VFS negative dentry caching
      kernfs: switch kernfs to use an rwsem
      kernfs: use i_lock to protect concurrent inode updates


 fs/kernfs/dir.c             |  240 +++++++++++++++++++++++--------------------
 fs/kernfs/file.c            |    4 -
 fs/kernfs/inode.c           |   18 ++-
 fs/kernfs/kernfs-internal.h |    5 +
 fs/kernfs/mount.c           |   12 +-
 fs/kernfs/symlink.c         |    4 -
 include/linux/kernfs.h      |    2 
 7 files changed, 155 insertions(+), 130 deletions(-)

--

