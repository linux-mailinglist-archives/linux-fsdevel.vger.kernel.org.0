Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57573B5CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjFWLCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjFWLCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E2199D;
        Fri, 23 Jun 2023 04:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F2D61A27;
        Fri, 23 Jun 2023 11:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC68C433C8;
        Fri, 23 Jun 2023 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687518122;
        bh=lv0cb2CC6XipBwd13XcV4N1pnsNBtmcT0pIn0JUXRmk=;
        h=From:To:Cc:Subject:Date:From;
        b=Ft13eh5MV9KsCSxojn3ps24SWZzgbo8r6zD9JkJ0geaMQy/eBQHe4oxP+fGPdw6jH
         I/mDk9cVeodnAVuJj0+MLA94J3EfxlXWCFomu/Vu7CWAsYNfSxpTTUhhMyAuqRyk9L
         54L0bgv4+ZQAoIPuVMvui1/ibFsxpEfQK4f+tBsBc/6mMa45jCuSeoFMHvZdS0izVw
         +pjv9PJj/HRrmkdJURdhS7Uc90TMtn7M/bXSLFOdXoYY3/3bPIersnthoJjx9KyfRc
         3oQm6h7dd40bi0WWScrgsJRqgnWng7AS0CfPiHfue3NJMG4MdfygKTw8HeOwDHdlFz
         xw4yEfKRAUM6A==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs: misc
Date:   Fri, 23 Jun 2023 13:01:48 +0200
Message-Id: <20230623-motor-quirlig-c6afec03aeb4@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9112; i=brauner@kernel.org; h=from:subject:message-id; bh=lv0cb2CC6XipBwd13XcV4N1pnsNBtmcT0pIn0JUXRmk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMrZ7GeWXrh7/7ZeyqNs/cos3MH2QV9ut29YYVEft/rYlb PGWVZkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEXkswMlxb8Cz5qJ9zs6hC7usA0+ jKLIYPW56He0ufeaQrdnzF6xZGhimv28v23b0g+Ja9+kHqjBU7nRntMyMZ5ortOH/2hfS3DBYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
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
This contains miscellaneous features, cleanups, and fixes for vfs and
individual fs.

Features
========
* Use mode 0600 for file created by cachefilesd so it can be run by
  unprivileged users. This aligns them with directories which are
  already created with mode 0700 by cachefilesd.
* Reorder a few members in struct file to prevent some false sharing
  scenarios.
* Indicate that an eventfd is used a semaphore in the eventfd's fdinfo
  procfs file.
* Add a missing uapi header for eventfd exposing relevant uapi defines.
* Let the VFS protect transitions of a superblock from read-only to
  read-write in addition to the protection it already provides for
  transitions from read-write to read-only. Protecting read-only to
  read-write transitions allows filesystems such as ext4 to perform
  internal writes, keeping writers away until the transition is
  completed.

Cleanups
========
* Arnd removed the architecture specific arch_report_meminfo()
  prototypes and added a generic one into procfs.h.
  Note, we got a report about a warning in amdpgpu codepaths that
  suggested this was bisectable to this change but we concluded it was a
  false positive.
* Remove unused parameters from split_fs_names().
* Rename put_and_unmap_page() to unmap_and_put_page() to let the name
  reflect the order of the cleanup operation that has to unmap before
  the actual put.
* Unexport buffer_check_dirty_writeback() as it is not used outside of
  block device aops.
* Stop allocating aio rings from highmem.
* Protecting read-{only,write} transitions in the VFS used open-coded
  barriers in various places. Replace them with proper little helpers
  and document both the helpers and all barrier interactions involved
  when transitioning between read-{only,write} states.
* Use flexible array members in old readdir codepaths.

Fixes
=====
* Use the correct type __poll_t for epoll and eventfd.
* Replace all deprecated strlcpy() invocations, whose return value isn't
  checked with an equivalent strscpy() call.
* Fix some kernel-doc warnings in fs/open.c
* Reduce the stack usage in jffs2's xattr codepaths finally getting
  rid of this:
  fs/jffs2/xattr.c:887:1: error: the frame size of 1088 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
  royally annoying compilation warning.
* Use __FMODE_NONOTIFY instead of FMODE_NONOTIFY where an int and not
  fmode_t is required to avoid fmode_t to integer degradation warnings.
* Create coredumps with O_WRONLY instead of O_RDWR. There's a long
  explanation in that commit how O_RDWR is actually a bug which we found
  out with the help of Linus and git archeology.
* Fix "no previous prototype" warnings in the pipe codepaths.
* Add overflow calculations for remap_verify_area() as a signed addition
  overflow could be triggered in xfstests.
* Fix a null pointer dereference in sysv.
* Use an unsigned variable for length calculations in jfs avoiding
  compilation warnings with gcc 13.
* Fix a dangling pipe pointer in the watch queue codepath.
* The legacy mount option parser provided as a fallback by the VFS for
  filesystems not yet converted to the new mount api did prefix the
  generated mount option string with a leading ',' causing issues for
  some filesystems.
* Fix a repeated word in a comment in fs.h.
* autofs: Update the ctime when mtime is updated as mandated by POSIX.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.4-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
There are two merge conflicts:

(1) This will cause a minor merge conflict with my v6.5/vfs.file pull
    request which renames an internal helper that's used in cachefiles.
    I would suggest to merge v6.5/vfs.misc first.
(2) linux-next: manual merge of the tip tree with the vfs-brauner tree
    https://lore.kernel.org/all/20230622131108.19059f3c@canb.auug.org.au

At the time of creating this PR no merge conflicts showed up doing a
test-merge with current mainline.

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.misc

for you to fetch changes up to 2507135e4ff231a368eae38000a501da0b96c662:

  readdir: Replace one-element arrays with flexible-array members (2023-06-21 09:06:59 +0200)

Please consider pulling these changes from the signed v6.5/vfs.misc tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/vfs.misc

----------------------------------------------------------------
Anuradha Weeraman (1):
      fs/open.c: Fix W=1 kernel doc warnings

Arnd Bergmann (3):
      fs: d_path: include internal.h
      fs: pipe: reveal missing function protoypes
      procfs: consolidate arch_report_meminfo declaration

Azeem Shaikh (1):
      vfs: Replace all non-returning strlcpy with strscpy

Christoph Hellwig (1):
      fs: unexport buffer_check_dirty_writeback

David Howells (1):
      cachefiles: Allow the cache to be non-root

David Sterba (1):
      fs: use UB-safe check for signed addition overflow in remap_verify_area

Fabian Frederick (1):
      jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Fabio M. De Francesco (2):
      highmem: Rename put_and_unmap_page() to unmap_and_put_page()
      fs/aio: Stop allocating aio rings from HIGHMEM

Gustavo A. R. Silva (1):
      readdir: Replace one-element arrays with flexible-array members

Jan Kara (2):
      fs: Protect reconfiguration of sb read-write from racing writes
      fs: Provide helpers for manipulating sb->s_readonly_remount

Jeff Layton (1):
      autofs: set ctime as well when mtime changes on a dir

Kees Cook (1):
      jfs: Use unsigned variable for length calculations

Mao Zhu (1):
      fs: Fix comment typo

Min-Hua Chen (2):
      fs: use correct __poll_t type
      fs: fix incorrect fmode_t casts

Prince Kumar Maurya (1):
      fs/sysv: Null check to prevent null-ptr-deref bug

Siddh Raman Pant (1):
      watch_queue: prevent dangling pipe pointer

Thomas Weißschuh (1):
      fs: avoid empty option when generating legacy mount string

Vladimir Sementsov-Ogievskiy (1):
      coredump: require O_WRONLY instead of O_RDWR

Wen Yang (2):
      eventfd: show the EFD_SEMAPHORE flag in fdinfo
      eventfd: add a uapi header for eventfd userspace APIs

Yihuan Pan (1):
      init: remove unused names parameter in split_fs_names()

chenzhiyin (1):
      fs.h: Optimize file struct to prevent false sharing

 arch/parisc/include/asm/pgtable.h    |  3 ---
 arch/powerpc/include/asm/pgtable.h   |  3 ---
 arch/s390/include/asm/pgtable.h      |  3 ---
 arch/s390/mm/pageattr.c              |  1 +
 arch/x86/include/asm/pgtable.h       |  1 +
 arch/x86/include/asm/pgtable_types.h |  3 ---
 arch/x86/mm/pat/set_memory.c         |  1 +
 fs/aio.c                             | 26 ++++++++---------------
 fs/autofs/root.c                     |  6 +++---
 fs/buffer.c                          |  1 -
 fs/cachefiles/namei.c                |  3 ++-
 fs/char_dev.c                        |  2 +-
 fs/coredump.c                        |  2 +-
 fs/d_path.c                          |  1 +
 fs/eventfd.c                         | 12 ++++++-----
 fs/eventpoll.c                       |  2 +-
 fs/fs_context.c                      |  3 ++-
 fs/internal.h                        | 41 ++++++++++++++++++++++++++++++++++++
 fs/jffs2/build.c                     |  5 ++++-
 fs/jffs2/xattr.c                     | 13 ++++++++----
 fs/jffs2/xattr.h                     |  4 ++--
 fs/jfs/namei.c                       |  6 +++---
 fs/namespace.c                       | 25 ++++++++++++++--------
 fs/open.c                            | 14 +++---------
 fs/overlayfs/file.c                  |  2 +-
 fs/readdir.c                         |  8 +++----
 fs/remap_range.c                     |  5 ++++-
 fs/super.c                           | 22 +++++++++++--------
 fs/sysv/dir.c                        | 22 +++++++++----------
 fs/sysv/itree.c                      |  4 ++++
 fs/sysv/namei.c                      |  8 +++----
 include/linux/eventfd.h              |  8 ++-----
 include/linux/fs.h                   | 20 ++++++++++++------
 include/linux/highmem.h              |  2 +-
 include/linux/pipe_fs_i.h            |  4 ----
 include/linux/proc_fs.h              |  2 ++
 include/linux/watch_queue.h          |  3 +--
 include/uapi/linux/eventfd.h         | 11 ++++++++++
 init/do_mounts.c                     |  6 +++---
 kernel/watch_queue.c                 | 12 +++++------
 40 files changed, 188 insertions(+), 132 deletions(-)
 create mode 100644 include/uapi/linux/eventfd.h
