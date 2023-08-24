Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95E787223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbjHXOrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241868AbjHXOrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB11FE0;
        Thu, 24 Aug 2023 07:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 812A56215B;
        Thu, 24 Aug 2023 14:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EABC433C7;
        Thu, 24 Aug 2023 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692888404;
        bh=km0iyFl6ClQp/HV57wmnrZ656sQ6Pqq7rdoNcl3bBYI=;
        h=From:To:Cc:Subject:Date:From;
        b=cEgWhjcXiHqfP/Sorec2yXGkVH3zDjUORrr1G958EMIX/dENUlK0f0sYuBYR49B0l
         WaXX0Bo+C1UiEvXBa7T0u51FyldV6R8C4D2QnKoU/7lgtI+zxtGPbmTXDd2cKDIz69
         +K8NeNBK5YJdX1MPZfldih7O/Ucuk1cUIpauuTBWfXufA0RwqGXPoLoEVaiHK2OqPm
         jBO02Yrg2ByJdhUOJiW3DCiUMxOQC6f1lAVK+r8d82vBrEgSah7PkTEWY18NVqmAPV
         R69Q8yCfq6yq9uaMM4FL2MukK7T2m/Ospy4YtWhbd117TjBhC+LcncZfPoEWVE6ufe
         waco1DPRv046Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mount api updates
Date:   Thu, 24 Aug 2023 16:46:32 +0200
Message-Id: <20230824-anzog-allheilmittel-e8c63e429a79@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6040; i=brauner@kernel.org; h=from:subject:message-id; bh=km0iyFl6ClQp/HV57wmnrZ656sQ6Pqq7rdoNcl3bBYI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8z+W0c+iSD3hX8NFj1bXvt4UbHq+y2i7myBMqf/lswPaw CZaLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSPZPhf5kp78ODq98u+yiYYDHffD 8zR7ffzjlpp6Zxhh7WKCv6b8HwT/l87S87/+QzMkdX+78xKuxctvgJu4v3mXklfhkqbQE9TAA=
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
This introduces FSCONFIG_CMD_CREATE_EXCL which allows userspace to
implement something like mount -t ext4 --exclusive /dev/sda /B which
fails if a superblock for the requested filesystem does already exist
instead of silently reusing an existing superblock (see [4] for the
source of the move-mount binary):

(1) ./move-mount -f xfs -o       source=/dev/sda4 /A
(2) ./move-mount -f xfs -o noacl,source=/dev/sda4 /B

The initial mounter (1) will create a superblock. The second mounter (2)
will reuse the existing superblock of (1), i.e., (2) creates a
bind-mount. The problem is that reusing an existing superblock means all
mount options other than read-only and read-write will be silently
ignored even if they are incompatible requests. For example, (2) has
requested no POSIX ACL support but since the existing superblock of (1)
is reused POSIX ACL support will remain enabled.

Such silent superblock reuse can easily become a security issue.

After adding support for FSCONFIG_CMD_CREATE_EXCL to mount(8)/util-linux
this can be fixed:

(1*) ./move-mount -f xfs --exclusive -o       source=/dev/sda4 /A
(2*) ./move-mount -f xfs --exclusive -o noacl,source=/dev/sda4 /B
     Device or resource busy | move-mount.c: 300: do_fsconfig: i xfs: reusing existing filesystem not allowed

Optional Details
================

As mentioned on the list (cf. [1]-[3]) regular mount requests of the
form mount -t ext4 /dev/sda /A are ambiguous. Userspace cannot be sure
whether this will simply create a bind-mount and therefore reuse an
existing superblock or create a new superblock:

P1                                                              P2
fd_fs = fsopen("ext4");                                         fd_fs = fsopen("ext4");
fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");     fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/dev/sda");
fsconfig(fd_fs, FSCONFIG_SET_STRING, "dax", "always");          fsconfig(fd_fs, FSCONFIG_SET_STRING, "resuid", "1000");

// wins and creates superblock
fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)
                                                                // finds compatible superblock of P1
                                                                // sleeps until P1 sets SB_BORN and grabs a reference
                                                                fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...)

fd_mnt1 = fsmount(fd_fs);                                       fd_mnt2 = fsmount(fd_fs);
move_mount(fd_mnt1, "/A")                                       move_mount(fd_mnt2, "/B")

Not just does P2 get a bind-mount but the mount options that P2
requests are silently ignored. The VFS itself doesn't, can't and
shouldn't enforce filesystem specific mount option compatibility. It
only enforces incompatibility for read-only <-> read-write transitions:

mount -t ext4       /dev/sda /A
mount -t ext4 -o ro /dev/sda /B

The read-only request will fail with EBUSY as the VFS can't just
silently transition a superblock from read-write to read-only or vica
versa without risking security issues.

The new FSCONFIG_CMD_CREATE_EXCL command for fsconfig() ensures that
EBUSY is returned if an existing superblock would be reused. Userspace
that needs to be sure that it did create a new superblock with the
requested mount options can request superblock creation using this
command.

This requires the new mount api. With the old mount api it would be
necessary to plumb this through every legacy filesystem's
file_system_type->mount() method. If they want this feature they are
most welcome to switch to the new mount api.

The commit adding the command has detailed explanations what this
command will mean for every single superblock allocation function and
filesystem we have. (Probably the oddest of the bunch is nfs as nfs
allocates one internal superblock per path component during mount - for
nfs4 at least. Superblock reuse here is lenient and frequent and an
implementation detail.)

Link: [1] https://lore.kernel.org/linux-block/20230704-fasching-wertarbeit-7c6ffb01c83d@brauner
Link: [2] https://lore.kernel.org/linux-block/20230705-pumpwerk-vielversprechend-a4b1fd947b65@brauner
Link: [3] https://lore.kernel.org/linux-fsdevel/20230725-einnahmen-warnschilder-17779aec0a97@brauner
Link: [4] https://github.com/brauner/move-mount-beneath

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.5-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.fs_context

for you to fetch changes up to 22ed7ecdaefe0cac0c6e6295e83048af60435b13:

  fs: add FSCONFIG_CMD_CREATE_EXCL (2023-08-14 18:48:02 +0200)

Please consider pulling these changes from the signed v6.6-vfs.fs_context tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.fs_context

----------------------------------------------------------------
Christian Brauner (4):
      super: remove get_tree_single_reconf()
      fs: add vfs_cmd_create()
      fs: add vfs_cmd_reconfigure()
      fs: add FSCONFIG_CMD_CREATE_EXCL

 fs/fs_context.c            |   1 +
 fs/fsopen.c                | 106 ++++++++++++++++++++++++++++++---------------
 fs/super.c                 |  64 +++++++++++++--------------
 include/linux/fs_context.h |   4 +-
 include/uapi/linux/mount.h |   3 +-
 5 files changed, 107 insertions(+), 71 deletions(-)
