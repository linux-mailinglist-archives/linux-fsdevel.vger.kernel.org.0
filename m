Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAED5649ED0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 13:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiLLMfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 07:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiLLMez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:34:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5678A11A17;
        Mon, 12 Dec 2022 04:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18D29B80D0C;
        Mon, 12 Dec 2022 12:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5620C433F0;
        Mon, 12 Dec 2022 12:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670848442;
        bh=xtdAmCMl29VEatoJ4kmd4nWM9mHIzeabHXzaRNDlt6c=;
        h=From:To:Cc:Subject:Date:From;
        b=WPElUzUhbwqbhqrVW/KnFjqhzJKRMMF65RQAROvEyxu/tMyQ+nqOFDwInqgywOwcu
         /WgDrgd/qBYJZ4sTrhRjGaPizPRhHNXvFFbWRiGNYpN8Y/V3vt9ghUMxJafXu7BwFL
         9Hm+y9KFoesoEUjeuMlC9qKA3sy5rk/MNNsxOg5FjaIYrNMp6G0NVNhgVFrCM3h0TD
         o/5k91AyaETIcv9oNwYTktIA7IuYxnU6UPKs3mPON4PL9TIbR1JC4Gq9U+eBPDjmHa
         /JTiBbzOLEREZsHcJlYEO8GpkrcisMyiGW3U5PBJJeMY5TIrVnam+dQz7/ZBlq+vz/
         t2B+7f09IcjAw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfsuid updates for v6.2
Date:   Mon, 12 Dec 2022 13:33:48 +0100
Message-Id: <20221212123348.169903-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5064; i=brauner@kernel.org; h=from:subject; bh=xtdAmCMl29VEatoJ4kmd4nWM9mHIzeabHXzaRNDlt6c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRPl18yk8c2re+m1IQ6/dWb3v/QsvUzm7D8yNXAeH+B3Nip HtPndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExknS0jw+sQtruzil4/Ck7/M+lLiH pmXqLjpv/rrud7xEyZL79y5k9Ghm+ZBTeeHY38eOxhUcOfzByLA6J//P16/R8+3eOp/WPDJkYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
Last cycle we introduced the vfs{g,u}id_t types and associated helpers to gain
type safety when dealing with idmapped mounts. That initial pull request back
then already converted a lot of places over but there were still some left,

This pull request converts all remaining places that still make use of non-type
safe idmapping helpers to rely on the new type safe vfs{g,u}id based helpers.
Afterwards it removes all the old non-type safe helpers.

Note that this pull request has the setgid inheritance branch merged in as the
setgid inheritance branch unifies multiple open-coded checks into a single
helper making the conversion here easier. I've sent a pull request for that
work rearlier so it's on the list and in your inbox before this one. The lore
url is:
https://lore.kernel.org/lkml/20221212112053.99208-1-brauner@kernel.org

In case you don't want to pull "setgid inheritance updates for v6.2" but still
would like to pull the remaining vfs{g,u}id_t conversions (That would be
greatly appreciated as it gets rid of duplicated functionality between the
different helpers.) I prepared the tag

  fs.vfsuid.conversion.standalone.v6.2

This tag only contains all the vfs{g,u}id_t patches without any of the "setgid
inheritance updates for v6.2" patches.

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.conversion.standalone.v6.2

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.1-rc1 and have been sitting in linux-next. No build
failures or warnings were observed. The vfsuid conversionn portion passes all
old and new tests in fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.conversion.v6.2

__Alternatively__, a standalone version without the setgid patches merged in
can be found at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.conversion.standalone.v6.2

for you to fetch changes up to eb7718cdb73c6b0c93002f8f73f4dd4701f8d2bb:

  fs: remove unused idmapping helpers (2022-10-26 10:03:34 +0200)

Please consider pulling these changes from the signed fs.vfsuid.conversion.v6.2
or fs.vfsuid.conversion.standalone.v6.2 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.vfsuid.conversion.v6.2

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: remove privs in ovl_copyfile()
      ovl: remove privs in ovl_fallocate()

Christian Brauner (12):
      attr: add in_group_or_capable()
      fs: move should_remove_suid()
      attr: add setattr_should_drop_sgid()
      attr: use consistent sgid stripping checks
      mnt_idmapping: add missing helpers
      fs: use type safe idmapping helpers
      caps: use type safe idmapping helpers
      apparmor: use type safe idmapping helpers
      ima: use type safe idmapping helpers
      fuse: port to vfs{g,u}id_t and associated helpers
      ovl: port to vfs{g,u}id_t and associated helpers
      fs: remove unused idmapping helpers

 Documentation/trace/ftrace.rst      |   2 +-
 fs/attr.c                           |  74 +++++++++++++++++++++++---
 fs/coredump.c                       |   4 +-
 fs/exec.c                           |  16 +++---
 fs/fuse/acl.c                       |   2 +-
 fs/fuse/file.c                      |   2 +-
 fs/inode.c                          |  72 ++++++++++++--------------
 fs/internal.h                       |  10 +++-
 fs/namei.c                          |  40 +++++++--------
 fs/ocfs2/file.c                     |   4 +-
 fs/open.c                           |   8 +--
 fs/overlayfs/file.c                 |  28 ++++++++--
 fs/overlayfs/util.c                 |   9 +++-
 fs/remap_range.c                    |   2 +-
 fs/stat.c                           |   7 ++-
 include/linux/fs.h                  |  36 +------------
 include/linux/mnt_idmapping.h       | 100 ++++++++++++------------------------
 kernel/capability.c                 |   4 +-
 security/apparmor/domain.c          |   8 +--
 security/apparmor/file.c            |   4 +-
 security/apparmor/lsm.c             |  25 ++++++---
 security/commoncap.c                |  51 +++++++++---------
 security/integrity/ima/ima_policy.c |  34 ++++++------
 23 files changed, 289 insertions(+), 253 deletions(-)
