Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67D3CB556
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhGPJkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:40:32 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:22594
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhGPJkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:40:31 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2021 05:40:26 EDT
X-SMTP-MATCH: 0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASxB18qHuKXxEEb4ipLqE0seALOsnbusQ8z?=
 =?us-ascii?q?AXPiFKJSC9F/byqynAppsmPHPP5gr5OktBpTnwAsi9qBrnnPYejLX5W43SPj?=
 =?us-ascii?q?UO01HYT72Kg7GSpAHIKmnT8fNcyLclU4UWMqyXMbGit7ee3OBvKadF/OW6?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AQBwA6UPFg/y2ELHlQCoEJCYFQAoF?=
 =?us-ascii?q?0ggKEbkaQEwEBAQEBAQaBQIpphW+LCIF8CwEBAQEBAQEBAUoEAQGEVIJ+ASU?=
 =?us-ascii?q?0CQ4CBBUBAQEFAQEBAQEGAwGBDoV1QwEMAYYeVigNAhgOAkkWAYVlJadngTI?=
 =?us-ascii?q?aAmWKQ4EQKgGHCIJohCEcfYEQgUgDgjh1hBeDRIJkBIJ4GQYBAXMaARM4NCA?=
 =?us-ascii?q?RKhYPERgWNzCRBSaCewFGihlbnQyDLp5kF4NMkgMDFpBflgiCHJ1ihxCCFE0?=
 =?us-ascii?q?uCoMlTxmdCTdnAgYKAQEDCYJyhyInBoIYAQE?=
X-IPAS-Result: =?us-ascii?q?A2AQBwA6UPFg/y2ELHlQCoEJCYFQAoF0ggKEbkaQEwEBA?=
 =?us-ascii?q?QEBAQaBQIpphW+LCIF8CwEBAQEBAQEBAUoEAQGEVIJ+ASU0CQ4CBBUBAQEFA?=
 =?us-ascii?q?QEBAQEGAwGBDoV1QwEMAYYeVigNAhgOAkkWAYVlJadngTIaAmWKQ4EQKgGHC?=
 =?us-ascii?q?IJohCEcfYEQgUgDgjh1hBeDRIJkBIJ4GQYBAXMaARM4NCARKhYPERgWNzCRB?=
 =?us-ascii?q?SaCewFGihlbnQyDLp5kF4NMkgMDFpBflgiCHJ1ihxCCFE0uCoMlTxmdCTdnA?=
 =?us-ascii?q?gYKAQEDCYJyhyInBoIYAQE?=
X-IronPort-AV: E=Sophos;i="5.84,244,1620662400"; 
   d="scan'208";a="329873529"
Received: from unknown (HELO web.messagingengine.com) ([121.44.132.45])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 16 Jul 2021 17:28:13 +0800
Subject: [PATCH v8 0/5] kernfs: proposed locking and concurrency improvement
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
Date:   Fri, 16 Jul 2021 17:28:13 +0800
Message-ID: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Changes since v7:
- remove extra tab in helper kernfs_dir_changed.
- fix thinko adding an unnecessary kernfs_inc_rev() in kernfs_rename_ns().

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

Ian Kent (5):
      kernfs: add a revision to identify directory node changes
      kernfs: use VFS negative dentry caching
      kernfs: switch kernfs to use an rwsem
      kernfs: use i_lock to protect concurrent inode updates
      kernfs: dont call d_splice_alias() under kernfs node lock


 fs/kernfs/dir.c             | 151 ++++++++++++++++++++----------------
 fs/kernfs/file.c            |   4 +-
 fs/kernfs/inode.c           |  26 ++++---
 fs/kernfs/kernfs-internal.h |   5 +-
 fs/kernfs/mount.c           |  12 +--
 fs/kernfs/symlink.c         |   4 +-
 include/linux/kernfs.h      |   2 +-
 7 files changed, 112 insertions(+), 92 deletions(-)

--
Ian

