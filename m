Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813727AA9B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjIVHHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 03:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVHHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:07:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734918F;
        Fri, 22 Sep 2023 00:07:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631F3C433C7;
        Fri, 22 Sep 2023 07:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695366434;
        bh=5mc7QDNPsWG80dur3Ssvxv2WoJhmtfg/kPi7/0MdrL4=;
        h=From:To:Cc:Subject:Date:From;
        b=NTujho/ZU0LA35BgvAkZWcc6zlkwH7V1gmRZroPcAnSzi//ahfuHLIShQHkd8Ibh/
         8AQ7oY5sWTS00ZtJB/6RibQN7sXINVDcd058nBOFa0TARug4nwqFBFFwV5Qg+88WL5
         9pvJgTl8d/yPTX01Gmj2qHtae30zAPK60Casr0qWbKuCdvSODGFiczI2T68yL1z7wE
         OgDx4tSRuzZJYYOPDsxxpQJ+VkZm2+KHsEGLL1HJDopBxqwh6UkSUfgqmLsIftvfQq
         gnpsGKHjKFzglr00+i2X6ilYAbZFEL/hacHUDU9rEf+TAk7OLS2Lx7zVR24Z3W5Elo
         M2dRDmOKMQlyA==
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, bodonnel@redhat.com,
        david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org,
        harshit.m.mogalapalli@oracle.com, lukas.bulwahn@gmail.com,
        peterz@infradead.org, ritesh.list@gmail.com, sandeen@sandeen.net,
        srikanth.c.s@oracle.com, sshegde@linux.vnet.ibm.com,
        tglx@linutronix.de, wangjc136@midea.com, wen.gang.wang@oracle.com
Subject: [GIT PULL] xfs: bug fixes for 6.6
Date:   Fri, 22 Sep 2023 12:22:00 +0530
Message-ID: <87ediqit40.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for xfs for 6.6-rc3. The changes are
limited to only bug fixes whose summary is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.6-fixes-1

for you to fetch changes up to 8b010acb3154b669e52f0eef4a6d925e3cc1db2f:

  xfs: use roundup_pow_of_two instead of ffs during xlog_find_tail (2023-09-13 10:38:20 +0530)

----------------------------------------------------------------
Bug fixes for 6.6-rc3:

 * Fix an integer overflow bug when processing an fsmap call.

 * Fix crash due to CPU hot remove event racing with filesystem mount
   operation.

 * During read-only mount, XFS does not allow the contents of the log to be
   recovered when there are one or more unrecognized rcompat features in the
   primary superblock, since the log might have intent items which the kernel
   does not know how to process.

 * During recovery of log intent items, XFS now reserves log space sufficient
   for one cycle of a permanent transaction to execute. Otherwise, this could
   lead to livelocks due to non-availability of log space.

 * On an fs which has an ondisk unlinked inode list, trying to delete a file
   or allocating an O_TMPFILE file can cause the fs to the shutdown if the
   first inode in the ondisk inode list is not present in the inode cache.
   The bug is solved by explicitly loading the first inode in the ondisk
   unlinked inode list into the inode cache if it is not already cached.

   A similar problem arises when the uncached inode is present in the middle
   of the ondisk unlinked inode list. This second bug is triggered when
   executing operations like quotacheck and bulkstat. In this case, XFS now
   reads in the entire ondisk unlinked inode list.

 * Enable LARP mode only on recent v5 filesystems.

 * Fix a out of bounds memory access in scrub.

 * Fix a performance bug when locating the tail of the log during mounting a
   filesystem.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Chandan Babu R (8):
      Merge tag 'fix-fsmap-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      Merge tag 'fix-percpu-lists-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      Merge tag 'fix-ro-mounts-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      Merge tag 'fix-efi-recovery-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      Merge tag 'fix-iunlink-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      Merge tag 'fix-iunlink-list-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      Merge tag 'fix-larp-requirements-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA
      Merge tag 'fix-scrub-6.6_2023-09-12' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesA

Darrick J. Wong (14):
      xfs: fix per-cpu CIL structure aggregation racing with dying cpus
      xfs: fix an agbno overflow in __xfs_getfsmap_datadev
      xfs: use per-mount cpumask to track nonempty percpu inodegc lists
      xfs: remove the all-mounts list
      xfs: remove CPU hotplug infrastructure
      xfs: use i_prev_unlinked to distinguish inodes that are not on the unlinked list
      xfs: allow inode inactivation during a ro mount log recovery
      xfs: reload entire unlinked bucket lists
      xfs: fix log recovery when unknown rocompat bits are set
      xfs: reserve less log space when recovering log intent items
      xfs: load uncached unlinked inodes into memory on demand
      xfs: make inode unlinked bucket recovery work with quotacheck
      xfs: require a relatively recent V5 filesystem for LARP mode
      xfs: only call xchk_stats_merge after validating scrub inputs

Lukas Bulwahn (1):
      xfs: fix select in config XFS_ONLINE_SCRUB_STATS

Wang Jianchao (1):
      xfs: use roundup_pow_of_two instead of ffs during xlog_find_tail

 fs/xfs/Kconfig                  |   2 +-
 fs/xfs/libxfs/xfs_log_recover.h |  22 +++++
 fs/xfs/libxfs/xfs_sb.c          |   3 +-
 fs/xfs/scrub/scrub.c            |   4 +-
 fs/xfs/scrub/stats.c            |   5 +-
 fs/xfs/xfs_attr_inactive.c      |   1 -
 fs/xfs/xfs_attr_item.c          |   7 +-
 fs/xfs/xfs_bmap_item.c          |   4 +-
 fs/xfs/xfs_export.c             |   6 ++
 fs/xfs/xfs_extfree_item.c       |   4 +-
 fs/xfs/xfs_fsmap.c              |  25 +++--
 fs/xfs/xfs_icache.c             |  80 ++++++---------
 fs/xfs/xfs_icache.h             |   1 -
 fs/xfs/xfs_inode.c              | 209 +++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_inode.h              |  34 ++++++-
 fs/xfs/xfs_itable.c             |   9 ++
 fs/xfs/xfs_log.c                |  17 ----
 fs/xfs/xfs_log_cil.c            |  52 +++-------
 fs/xfs/xfs_log_priv.h           |  14 ++-
 fs/xfs/xfs_log_recover.c        |   4 +-
 fs/xfs/xfs_mount.h              |  17 +++-
 fs/xfs/xfs_qm.c                 |   7 ++
 fs/xfs/xfs_refcount_item.c      |   6 +-
 fs/xfs/xfs_rmap_item.c          |   6 +-
 fs/xfs/xfs_super.c              |  86 +----------------
 fs/xfs/xfs_trace.h              |  45 +++++++++
 fs/xfs/xfs_xattr.c              |  11 +++
 include/linux/cpuhotplug.h      |   1 -
 28 files changed, 441 insertions(+), 241 deletions(-)
