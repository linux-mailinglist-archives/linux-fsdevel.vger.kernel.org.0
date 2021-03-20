Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB53342CC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 13:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhCTM07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 08:26:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48186 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCTM0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:26:45 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNagg-0004Pf-6E; Sat, 20 Mar 2021 12:26:38 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/4] tweak fs mapping helpers
Date:   Sat, 20 Mar 2021 13:26:20 +0100
Message-Id: <20210320122623.599086-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey,

/* v2 */
Add some kernel docs to helpers as suggested by Christoph.
Switch to Al's naming proposal for these helpers.
(Added Acks.)

This little series tries to improve naming and developer friendliness of
fs idmapping helpers triggered by a request/comment from Vivek.
Let's remove the two open-coded checks for whether there's a mapping for
fsuid/fsgid in the s_user_ns of the underlying filesystem. Instead move them
into a tiny helper, getting rid of redundancy and making sure that if we ever
change something it's changed in all places. Also add two helpers to initialize
and inode's i_uid and i_gid fields taking into account idmapped mounts making
it easier for fs developers.

The xfstests I sent out all pass for both xfs and ext4:

#### xfs
  1. Detached mount propagation
     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/631
     FSTYP         -- xfs (non-debug)
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
     MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
     
     generic/631 9s ...  11s
     Ran: generic/631
     Passed all 1 tests
    
  2. Idmapped mounts test-suite
     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/632
     FSTYP         -- xfs (non-debug)
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
     MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
     
     generic/632 13s ...  14s
     Ran: generic/632
     Passed all 1 tests
    
  3. Testing xfs quotas can't be exceeded/work correctly from idmapped mounts
     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/529
     FSTYP         -- xfs (non-debug)
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
     MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
     
     xfs/529 42s ...  44s
     Ran: xfs/529
     Passed all 1 tests
    
  4. Testing xfs qutoas on idmapped mounts
     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/530
     hFSTYP         -- xfs (non-debug)
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- -f -bsize=4096 /dev/loop1
     MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

     xfs/530 20s ...  20s
     Ran: xfs/530
     Passed all 1 tests

#### ext4
  1. Detached mount propagation

     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/631
     FSTYP         -- ext4
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- /dev/loop1
     MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt/scratch
     
     generic/631 11s ...  8s
     Ran: generic/631
     Passed all 1 tests

  2. Idmapped mounts test-suite

     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check generic/632
     FSTYP         -- ext4
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- /dev/loop1
     MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt/scratch
     
     generic/632 14s ...  10s
     Ran: generic/632
     Passed all 1 tests

  3. Testing xfs quotas can't be exceeded/work correctly from idmapped mounts
     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/529
     FSTYP         -- ext4
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- /dev/loop1
     MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt/scratch
     
     xfs/529 44s ... [not run] not suitable for this filesystem type: ext4
     Ran: xfs/529
     Not run: xfs/529
     Passed all 1 tests

  4. Testing xfs qutoas on idmapped mounts
     ubuntu@f1-vm:~/src/git/xfstests$ sudo ./check xfs/530
     FSTYP         -- ext4
     PLATFORM      -- Linux/x86_64 f1-vm 5.12.0-rc3-idmapped-mounts-inode-helpers #351 SMP Sat Mar 20 10:32:48 UTC 2021
     MKFS_OPTIONS  -- /dev/loop1
     MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt/scratch
     
     xfs/530 20s ... [not run] not suitable for this filesystem type: ext4
     Ran: xfs/530
     Not run: xfs/530
     Passed all 1 tests

Thanks!
Christian

Christian Brauner (4):
  fs: document mapping helpers
  fs: document and rename fsid helpers
  fs: introduce fsuidgid_has_mapping() helper
  fs: introduce two inode i_{u,g}id initialization helpers

 fs/ext4/ialloc.c     |   2 +-
 fs/inode.c           |   4 +-
 fs/namei.c           |  11 ++--
 fs/xfs/xfs_inode.c   |  10 ++--
 fs/xfs/xfs_symlink.c |   4 +-
 include/linux/fs.h   | 124 ++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 135 insertions(+), 20 deletions(-)


base-commit: 8b12a62a4e3ed4ae99c715034f557eb391d6b196
-- 
2.27.0

