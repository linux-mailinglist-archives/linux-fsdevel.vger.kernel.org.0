Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA558D786
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbiHIKkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 06:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiHIKkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBE41C130;
        Tue,  9 Aug 2022 03:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB84E60EC4;
        Tue,  9 Aug 2022 10:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038C3C433D6;
        Tue,  9 Aug 2022 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660041608;
        bh=NS6k3uL1NjcupValfKgOqJ9BkGsUQFmuAaFk6pzVKTA=;
        h=From:To:Cc:Subject:Date:From;
        b=pQo9a4N76ZxxgI8CH7jy9Ll8eG9GdQTCIyJtClJL93ccSsOqeGMPlTEs8BYzEfaRZ
         UEgfKbKx5UY4bqyj23p0/l8669UqvtIIuPiwxyYHCWwcJxnOOjrJ+YgNMv4i6UaxFJ
         YmCAsM6FKuhW2zDPdbrUIkP6gC2AgWN59lGizjyHZW3I7p+w3Gbx72OYmcUMIFBHym
         hLukE8fMXuio16QsnsZWEnLN/RNEj5ilbIEB7mf3hpKiVn56wnjqSlwbBYBgkn1LOf
         AXA9OoWCndsHcph7zlCcdofh3WrhD5lpyWAPLTfpwXr+O7nmYohqNITrJHlMEdXsC0
         NEcA7Ukn2IdLA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: [GIT PULL] setgid inheritance for v5.20/v6.0
Date:   Tue,  9 Aug 2022 12:39:57 +0200
Message-Id: <20220809103957.1851931-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains the work to move setgid stripping out of individual filesystems
and into the VFS itself. (I think you might've been Cced on this briefly a few
weeks ago.)

Creating files that have both the S_IXGRP and S_ISGID bit raised in directories
that themselves have the S_ISGID bit set requires additional privileges to
avoid security issues.

When a filesystem creates a new inode it needs to take care that the caller is
either in the group of the newly created inode or they have CAP_FSETID in their
current user namespace and are privileged over the parent directory of the new
inode. If any of these two conditions is true then the S_ISGID bit can be
raised for an S_IXGRP file and if not it needs to be stripped.

However, there are several key issues with the current implementation:

* S_ISGID stripping logic is entangled with umask stripping.

  For example, if the umask removes the S_IXGRP bit from the file about to be
  created then the S_ISGID bit will be kept.

  The inode_init_owner() helper is responsible for S_ISGID stripping and is
  called before posix_acl_create(). So we can end up with two different
  orderings:

  1. FS without POSIX ACL support
     First strip umask then strip S_ISGID in inode_init_owner().

     In other words, if a filesystem doesn't support or enable POSIX ACLs then
     umask stripping is done directly in the vfs before calling into the
     filesystem:

  2. FS with POSIX ACL support
     First strip S_ISGID in inode_init_owner() then strip umask in
     posix_acl_create().

     In other words, if the filesystem does support POSIX ACLs then unmask
     stripping may be done in the filesystem itself when calling
     posix_acl_create().

  Note that technically filesystems are free to impose their own ordering
  between posix_acl_create() and inode_init_owner() meaning that there's
  additional ordering issues that influence S_ISGID inheritance.

  (Note that the commit message of commit 1639a49ccdce ("fs: move S_ISGID
   stripping into the vfs_*() helpers") gets the ordering between
   inode_init_owner() and posix_acl_create() the wrong way around. I realized
   this too late.)

* Filesystems that don't rely on inode_init_owner() don't get S_ISGID
  stripping logic.

  While that may be intentional (e.g. network filesystems might just
  defer setgid stripping to a server) it is often just a security issue.

  Note that mandating the use of inode_init_owner() was proposed as an
  alternative solution but that wouldn't fix the ordering issues and there are
  examples such as afs where the use of inode_init_owner() isn't possible. In
  any case, we should also try the cleaner and generalized solution first
  before resorting to this approach.

* We still have S_ISGID inheritance bugs years after the initial round of
  S_ISGID inheritance fixes:
  e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes")
  01ea173e103e ("xfs: fix up non-directory creation in SGID directories")
  fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories")

All of us led us to conclude that the current state is too messy. While we
won't be able to make it completely clean as posix_acl_create() is still a
filesystem specific call we can improve the S_SIGD stripping situation quite a
bit by hoisting it out of inode_init_owner() and into the respective vfs
creation operations.

The obvious advantage is that we don't need to rely on individual filesystems
getting S_ISGID stripping right and instead can standardize the ordering
between S_ISGID and umask stripping directly in the VFS.

A few short implementation notes:
* The stripping logic needs to happen in vfs_*() helpers for the sake of
  stacking filesystems such as overlayfs that rely on these helpers taking care
  of S_ISGID stripping.
* Security hooks have never seen the mode as it is ultimately seen by the
  filesystem because of the ordering issue we mentioned. Nothing is changed for
  them. We simply continue to strip the umask before passing the mode down to
  the security hooks.
* The following filesystems use inode_init_owner() and thus relied on
   S_ISGID stripping: spufs, 9p, bfs, btrfs, ext2, ext4, f2fs, hfsplus,
   hugetlbfs, jfs, minix, nilfs2, ntfs3, ocfs2, omfs, overlayfs, ramfs,
   reiserfs, sysv, ubifs, udf, ufs, xfs, zonefs, bpf, tmpfs. We've audited all
   callchains as best as we could. More details can be found in the commit
   message to 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").

Finally a note on __regression potential__. I want to be very clear and open
that this carries a non-zero regression risk which is also why I defered the
pull request for this until this week because I was out to get married last
week and wouldn't have been around to deal with potential fallout:

  The patch will have an effect on ext2 when the EXT2_MOUNT_GRPID mount option
  is used, on ext4 when the EXT4_MOUNT_GRPID mount option is used, and on xfs
  when the XFS_FEAT_GRPID mount option is used.

  When any of these filesystems are mounted with their respective GRPID option
  then newly created files inherit the parent directory's group
  unconditionally. In these cases none of the filesystems call
  inode_init_owner() and thus they did never strip the S_ISGID bit for newly
  created files.

  Moving this logic into the VFS means that they now get the S_ISGID bit
  stripped. This is a potential user visible change. If this leads to
  regressions we will either need to figure out a better way or we need to
  revert. However, given the various setgid bugs that we found just in the last
  two years this is a regression risk we should take.

Associated with this change is a new set of fstests and LTP tests that are
currently reviewed and waiting for this series to be upstreamed.

/* Testing */
All patches are based on v5.19-rc7 and have been sitting in linux-next. No
build failures or warnings were observed and fstests and selftests have seen no
regressions. The series has existed for at least two kernel releases and
multiple eyes on it.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.setgid.v6.0

for you to fetch changes up to 5fadbd992996e9dda7ebcb62f5352866057bd619:

  ceph: rely on vfs for setgid stripping (2022-07-21 11:34:16 +0200)

Please consider pulling these changes from the signed fs.setgid.v6.0 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.setgid.v6.0

----------------------------------------------------------------
Yang Xu (4):
      fs: add mode_strip_sgid() helper
      fs: Add missing umask strip in vfs_tmpfile
      fs: move S_ISGID stripping into the vfs_*() helpers
      ceph: rely on vfs for setgid stripping

 fs/ceph/file.c     |  4 ---
 fs/inode.c         | 34 ++++++++++++++++++++---
 fs/namei.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/ocfs2/namei.c   |  1 +
 include/linux/fs.h |  2 ++
 5 files changed, 102 insertions(+), 19 deletions(-)
