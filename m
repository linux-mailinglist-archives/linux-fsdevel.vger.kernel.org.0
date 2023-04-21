Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234646EAC0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjDUNtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjDUNtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD11FEE;
        Fri, 21 Apr 2023 06:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0946160E8B;
        Fri, 21 Apr 2023 13:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C965C433EF;
        Fri, 21 Apr 2023 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682084945;
        bh=itVvYtUCKUXnw42FKgTEtlLusOYvDeBHmMMmLd5Jo3M=;
        h=From:To:Cc:Subject:Date:From;
        b=fcsAx3zoPtrYZTnThrevizLHmkiGARuhfDyGVWMk0WsRn4e4v58u2IHMNd/JVxx/0
         1E3N7OlVdkzg1oFlujM4TIlbxASh6EpiihzdCmM3CrDpqxVUf59eD1nlkZPToNWF1F
         bgxpvFST80452bE8cwV5RSr8G7QsleKZ7kZNcK8KRUzEHFxmgjabo6ku7z9oXFR/R0
         K8UspfOxoo7n9fm16BYSZZJiGhS+Uky89n6w1bZq6qQYha1OmzWrDdeHZTYeoAetE0
         N7uqYG1uMouEPSCLW13pfXh8Lkq0Neme67jHQ5iCGxOA8415EjbJ0KwQRRbHaGa6b6
         XmGpnNIS62Vfg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs: misc updates
Date:   Fri, 21 Apr 2023 15:48:44 +0200
Message-Id: <20230421-mitspielen-frucht-996edfeceba5@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4277; i=brauner@kernel.org; h=from:subject:message-id; bh=itVvYtUCKUXnw42FKgTEtlLusOYvDeBHmMMmLd5Jo3M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ4TWGJdXp4zfZB25KE7ttHK6W2yS0TENjsd1GeW+fGtS1H S0s5O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiU8vwP6jnyfm7q6Kuxr8/pmG1Ym /+aXkGvydfmtVeaC6v8/p/RojhJyO3XhyjzKrlS8ycnDdIm+0/4H6xJvOAw666uIpnShoLmQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a pile of various smaller fixes. Most of them aren't very
interesting so this just highlights things worth mentioning:

* Various filesystems contained the same little helper to convert from
  the mode of a dentry to the DT_* type of that dentry. They have now
  all been switched to rely on the generic fs_umode_to_dtype() helper.
  All custom helpers are removed.
  (Jeff)
* Fsnotify now reports ACCESS and MODIFY events for splice.
  (Chung-Chiang Cheng)
* After converting timerfd a long time ago to rely on
  wait_event_interruptible_*() apis, convert eventfd as well. This
  removes the complex open-coded wait code.
  (Wen Yang)
* Simplify sysctl registration for devpts, avoiding the declaration of
  two tables. Instead, just use a prefixed path with register_sysctl().
  (Luis)
* The setattr_should_drop_sgid() helper is now exported so NFS can
  use it. By switching NFS to this helper an NFS setgid inheritance bug
  is fixed.
  (me)

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.3-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.misc

for you to fetch changes up to 81b21c0f0138ff5a499eafc3eb0578ad2a99622c:

  fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode() (2023-04-12 11:29:32 +0200)

Please consider pulling these changes from the signed v6.4/vfs.misc tag.

Thanks!
Christian

----------------------------------------------------------------
v6.4/vfs.misc

----------------------------------------------------------------
Andy Shevchenko (1):
      fs/namespace: fnic: Switch to use %ptTd

Changcheng Liu (1):
      eventpoll: align comment with nested epoll limitation

Christian Brauner (3):
      Documentation: update idmappings.rst
      nfs: use vfs setgid helper
      pnode: pass mountpoint directly

Chung-Chiang Cheng (1):
      splice: report related fsnotify events

Jeff Layton (1):
      fs: consolidate duplicate dt_type helpers

Jiapeng Chong (1):
      fs/buffer: Remove redundant assignment to err

Luis Chamberlain (1):
      devpts: simplify two-level sysctl registration for pty_kern_table

Ondrej Mosnacek (1):
      fs_context: drop the unused lsm_flags member

Stephen Kitt (1):
      Update relatime comments to include equality

Tetsuo Handa (1):
      fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()

Wen Yang (1):
      eventfd: use wait_event_interruptible_locked_irq() helper

 Documentation/filesystems/idmappings.rst | 178 ++++++++++++++++++++++---------
 Documentation/filesystems/mount_api.rst  |   1 -
 fs/attr.c                                |   1 +
 fs/buffer.c                              |   9 +-
 fs/configfs/dir.c                        |   9 +-
 fs/devpts/inode.c                        |  20 +---
 fs/eventfd.c                             |  41 ++-----
 fs/eventpoll.c                           |   4 +-
 fs/hfsplus/inode.c                       |  28 ++++-
 fs/inode.c                               |   8 +-
 fs/internal.h                            |   2 -
 fs/kernfs/dir.c                          |   8 +-
 fs/libfs.c                               |   9 +-
 fs/namespace.c                           |   9 +-
 fs/nfs/inode.c                           |   4 +-
 fs/nfs/super.c                           |   3 -
 fs/pnode.c                               |  12 +--
 fs/splice.c                              |   8 ++
 include/linux/fs.h                       |   2 +
 include/linux/fs_context.h               |   1 -
 include/linux/security.h                 |   2 +-
 21 files changed, 191 insertions(+), 168 deletions(-)
