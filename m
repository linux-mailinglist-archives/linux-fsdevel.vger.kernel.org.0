Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7BF455CFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKRNxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 08:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhKRNxa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:53:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4AAB61A64;
        Thu, 18 Nov 2021 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637243429;
        bh=Nh9PYUyMhBG7vuAZ1jspnIiSd+WlrA9t7fuK8YSr/F8=;
        h=From:To:Cc:Subject:Date:From;
        b=FYh3Onrpg/Zg2DvlOkkeikUr6aqI+9K7CtymqHHpBydAW3vOmv2+icDNg4QDjiJKF
         dfgA1L79UPrbwdsuicA6wpFrygjZfkwcCBlZwg3OZEE/ESNnX8Od3OZ3Yzh9PcJfc+
         knvPq5N4wbSiep28CxUt7qx7qW9okIQb5Tfde4mBezF14SKnAGmddyl9jkwnFS5Svb
         IczFEtuYikJBml+UBA6nD7lDfvK2YyJFb0Hae/TxlaF8Gs4H6qDCPYRVb/599vl4BQ
         M/Zjv01qHUtwRCwZmVVfhfB/uArFEVUQ9q/sd2IxS74IVhDdw6C7zk0vIyVlyHhGo4
         xZ76s7Bhhancw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs mapping fixes
Date:   Thu, 18 Nov 2021 14:50:01 +0100
Message-Id: <20211118135001.2800727-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This contains a simple fix for setattr. When determining the validity of the
attributes the ia_{g,u}id fields contain the value that will be written to
inode->i_{g,u}id. When the {g,u}id attribute of the file isn't altered and the
caller's fs{g,u}id matches the current {g,u}id attribute the attribute change
is allowed.

The value in ia_{g,u}id does already account for idmapped mounts and will have
taken the relevant idmapping into account. So in order to verify that the
{g,u}id attribute isn't changed we simple need to compare the ia_{g,u}id value
against the inode's i_{g,u}id value.

This only has any meaning for idmapped mounts as idmapping helpers are
idempotent without them. And for idmapped mounts this really only has a meaning
when circular idmappings are used, i.e. mappings where e.g. id 1000 is mapped
to id 1001 and id 1001 is mapped to id 1000. Such ciruclar mappings can e.g. be
useful when sharing the same home directory between multiple users at the same
time.

Before this patch we could end up denying legitimate attribute changes and
allowing invalid attribute changes when circular mappings are used. To even get
into this situation the caller must've been privileged both to create that
mapping and to create that idmapped mount.

This hasn't been seen in the wild anywhere but came up when expanding the
fstest suite during work on a series of hardening patches. All idmapped fstests
pass without any regressions and we're adding new tests to verify the behavior
of circular mappings.

The new tests can be found at
https://lore.kernel.org/linux-fsdevel/20211109145713.1868404-2-brauner@kernel.org
and will be included in fstests after this is merged.

(I've caught a solid winter flu so not very active this week but will try to
 keep an eye on this pr.)

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.16-rc2

for you to fetch changes up to 968219708108440b23bc292e0486e3cc1d9a1bed:

  fs: handle circular mappings correctly (2021-11-17 09:26:09 +0100)

/* Testing */
All patches are based on v5.16-rc1 and have been sitting in linux-next (albeit
briefly). No build failures or warnings were observed. All old and new tests
and fstests are passing:

ubuntu@f2-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-rc1-idmapped-968219708108 #2 SMP PREEMPT Thu Nov 18 12:21:26 UTC 2021
MKFS_OPTIONS  -- -f /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/633 5s ...  5s
generic/644 2s ...  1s
generic/645 2s ...  3s
generic/651 2s ...  1s
xfs/152 41s ...  39s
xfs/153 7s ...  8s
Ran: generic/633 generic/644 generic/645 generic/651 xfs/152 xfs/153
Passed all 6 tests

ubuntu@f2-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-rc1-idmapped-968219708108 #2 SMP PREEMPT Thu Nov 18 12:21:26 UTC 2021
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt/scratch

generic/633 5s ...  2s
generic/644 1s ...  1s
generic/645 3s ...  1s
generic/651 1s ...  1s
Ran: generic/633 generic/644 generic/645 generic/651
Passed all 4 tests

ubuntu@f2-vm:~/src/git/xfstests$ sudo ./check -g idmapped
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-rc1-idmapped-968219708108 #2 SMP PREEMPT Thu Nov 18 12:21:26 UTC 2021
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/245 3s ...  2s
generic/633 2s ...  3s
generic/644 1s ...  1s
generic/645 1s ...  2s
generic/651 1s ...  0s
Ran: btrfs/245 generic/633 generic/644 generic/645 generic/651
Passed all 5 tests

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

Please consider pulling these changes from the signed fs.idmapped.v5.16-rc2 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.v5.16-rc2

----------------------------------------------------------------
Christian Brauner (1):
      fs: handle circular mappings correctly

 fs/attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
