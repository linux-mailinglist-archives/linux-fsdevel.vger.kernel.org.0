Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924F033BF2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 16:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbhCOOyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 10:54:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37935 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbhCOOyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:54:37 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lLoc2-0006o5-JN; Mon, 15 Mar 2021 14:54:30 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3] tweak idmap helpers
Date:   Mon, 15 Mar 2021 15:54:16 +0100
Message-Id: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey,

This little series tries to improve naming and developer friendliness of fs
idmapping helpers triggered by a request/comment from Vivek.
Let's remove the two open-coded checks for whether there's a mapping for
fsuid/fsgid in the s_user_ns of the underlying filesystem. Instead move them
into a tiny helper, getting rid of redundancy and making sure that if we ever
change something it's changed in all places. Also add two helpers to initialize
and inode's i_uid and i_gid fields taking into account idmapped mounts making
it easier for fs developers.

This patch series is on top of Darrick's changes in the xfs-5.12-fixes-2
tag or xfs-5.12-fixes branch since renaming the two helpers in the second patch
affects xfs which calls them when initializing quotas.

The xfstests I sent out all pass:

1. Idmapped mounts test-suite
ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/627
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/627      16s
Ran: generic/627
Passed all 1 tests

2. Detached mount propagation
ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/626
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/626 10s ...  9s
Ran: generic/626
Passed all 1 tests

3. Testing xfs quotas can't be exceeded/work correctly from idmapped mounts
ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/528
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

xfs/528 41s ...  44s
Ran: xfs/528
Passed all 1 tests

4. Testing xfs qutoas on idmapped mounts
ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/529
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-inode-helpers #343 SMP Mon Mar 15 12:57:02 UTC 2021
MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

xfs/529 23s ...  25s
Ran: xfs/529
Passed all 1 tests

Thanks!
Christian

Christian Brauner (3):
  fs: introduce fsuidgid_has_mapping() helper
  fs: improve naming for fsid helpers
  fs: introduce two little fs{u,g}id inode initialization helpers

 fs/ext4/ialloc.c     |  2 +-
 fs/inode.c           |  4 ++--
 fs/namei.c           | 11 +++--------
 fs/xfs/xfs_inode.c   | 10 +++++-----
 fs/xfs/xfs_symlink.c |  4 ++--
 include/linux/fs.h   | 27 +++++++++++++++++++++++++--
 6 files changed, 38 insertions(+), 20 deletions(-)


base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
prerequisite-patch-id: 0bdc07ef3137ce6d6ef284ad308de9a9bc2ea1f3
prerequisite-patch-id: a1c05069d67f08ea75e88f54f5fdf86db4d82865
prerequisite-patch-id: 707b24a3c6f71599e038a66aa3474b270d2699fe
prerequisite-patch-id: c42d85f64933a4e48aa10192c374bebad07ca5c0
prerequisite-patch-id: 5fcf22eea4b225691a034308a23c309f1583f970
-- 
2.27.0

