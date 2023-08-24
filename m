Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E247F787181
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbjHXO1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjHXO0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9D1BC5;
        Thu, 24 Aug 2023 07:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9856E61CAC;
        Thu, 24 Aug 2023 14:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA1CC433C7;
        Thu, 24 Aug 2023 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692887192;
        bh=WxJD574H7krNgyP3LzoiejrmKQAUaptTer2UcqBvyHw=;
        h=From:To:Cc:Subject:Date:From;
        b=kJ9VA3ZgmV1jXabQpQ99vOlY8SNyj/T7YMNkj7hvFA6alGA1aYj8zscFWqEGWSOlI
         ARxbaHggD5gpwX64rbl4rm9L9EkuKgiulImg2YeGrC2l9d/HbX7bNKzANu9XTVw+iY
         Z+So1ZC9nIAA46eewWt2DXS+nJOGLHWE5zYORh0AkGupS/b7PO51yT6oBcT1Un88tx
         x3tAlzDsi8JFiuq2fLgpuVWbTu+b7Tzi0soYwMxgjvuczli7jiVL6FpbYeXyeBYYRf
         VlKVBbv8jXQvu9KWdDiPWAWIC1xT4w7+61VL0BfJo3f0LPRLj8lRNcX2gYuhHJUeCW
         CGUy2R0tNX0qg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] misc updates
Date:   Thu, 24 Aug 2023 16:26:13 +0200
Message-Id: <20230824-umgerechnet-luftschicht-6dc072d6dbc2@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8234; i=brauner@kernel.org; h=from:subject:message-id; bh=WxJD574H7krNgyP3LzoiejrmKQAUaptTer2UcqBvyHw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8z6gym769kW+akOPXjwJuAQrnZ75Q/ylyN+La8waN511v PXuYO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayQ5KR4fq/2NNhmfUyr+S47541P+ HW0rk/Q905yP6dqZmxmPFfOYb/sW+rftjc2rmtJTNBd+8EC527/Xy3Vec8zHmyf5VJTpgzMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains the usual miscellaneous features, cleanups, and fixes for
vfs and individual fses.

Features
========

* Block mode changes on symlinks and rectify our broken semantics.
* Report file modifications via fsnotify() for splice.
* Allow specifying an explicit timeout for the "rootwait" kernel command
  line option. This allows to timeout and reboot instead of always
  waiting indefinitely for the root device to show up.
* Use synchronous fput for the close system call.

Cleanups
========

* Get rid of open-coded lockdep workarounds for async io submitters and
  replace it all with a single consolidated helper.
* Simplify epoll allocation helper.
* Convert simple_write_begin and simple_write_end to use a folio.
* Convert page_cache_pipe_buf_confirm() to use a folio.
* Simplify __range_close to avoid pointless locking.
* Disable per-cpu buffer head cache for isolated cpus.
* Port ecryptfs to kmap_local_page() api.
* Remove redundant initialization of pointer buf in pipe code.
* Unexport the d_genocide() function which is only used within core vfs.
* Replace printk(KERN_ERR) and WARN_ON() with WARN().

Fixes
=====

* Fix various kernel-doc issues.
* Fix refcount underflow for eventfds when used as EFD_SEMAPHORE.
* Fix a mainly theoretical issue in devpts.
* Check the return value of __getblk() in reiserfs.
* Fix a racy assert in i_readcount_dec.
* Fix integer conversion issues in various functions.
* Fix LSM security context handling during automounts that prevented NFS
  superblock sharing.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.misc

for you to fetch changes up to e6fa4c728fb671765291cca3a905986612c06b6e:

  cachefiles: use kiocb_{start,end}_write() helpers (2023-08-21 17:27:27 +0200)

Please consider pulling these changes from the signed v6.6-vfs.misc tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.misc

----------------------------------------------------------------
Ahelenia Ziemiańska (3):
      splice: always fsnotify_access(in), fsnotify_modify(out) on success
      splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
      splice: fsnotify_access(in), fsnotify_modify(out) on success in tee

Alexander Mikhalitsyn (1):
      docs: filesystems: idmappings: clarify from where idmappings are taken

Amir Goldstein (7):
      io_uring: rename kiocb_end_write() local helper
      fs: add kerneldoc to file_{start,end}_write() helpers
      fs: create kiocb_{start,end}_write() helpers
      io_uring: use kiocb_{start,end}_write() helpers
      aio: use kiocb_{start,end}_write() helpers
      ovl: use kiocb_{start,end}_write() helpers
      cachefiles: use kiocb_{start,end}_write() helpers

Anh Tuan Phan (1):
      fs/dcache: Replace printk and WARN_ON by WARN

Christian Brauner (1):
      attr: block mode changes of symlinks

Christoph Hellwig (1):
      fs: unexport d_genocide

Colin Ian King (1):
      fs/pipe: remove redundant initialization of pointer buf

David Howells (1):
      vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing

Fabio M. De Francesco (3):
      fs/ecryptfs: Replace kmap() with kmap_local_page()
      fs/ecryptfs: Use kmap_local_page() in ecryptfs_write()
      fs/ecryptfs: Use kmap_local_page() in copy_up_encrypted_with_header()

GONG, Ruiqi (1):
      doc: idmappings: fix an error and rephrase a paragraph

Linus Torvalds (1):
      fs: use __fput_sync in close(2)

Loic Poulain (1):
      init: Add support for rootwait timeout parameter

Luca Vizzarro (4):
      fcntl: Cast commands with int args explicitly
      fs: Pass argument to fcntl_setlease as int
      pipe: Pass argument of pipe_fcntl as int
      dnotify: Pass argument of fcntl_dirnotify as int

Marcelo Tosatti (1):
      fs/buffer.c: disable per-CPU buffer_head cache for isolated CPUs

Mateusz Guzik (2):
      file: mostly eliminate spurious relocking in __range_close
      vfs: fix up the assert in i_readcount_dec

Matthew Wilcox (1):
      reiserfs: Check the return value from __getblk()

Matthew Wilcox (Oracle) (4):
      devpts: Fix kernel-doc warnings
      fs: Fix kernel-doc warnings
      libfs: Convert simple_write_begin and simple_write_end to use a folio
      splice: Convert page_cache_pipe_buf_confirm() to use a folio

Wang Ming (1):
      fs: Fix error checking for d_hash_and_lookup()

Wen Yang (1):
      eventfd: prevent underflow for eventfd semaphores

Yang Li (1):
      fs: Fix one kernel-doc comment

Zhen Lei (1):
      epoll: simplify ep_alloc()

Zhu Wang (1):
      fs/ecryptfs: remove kernel-doc warnings

 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 Documentation/filesystems/idmappings.rst        | 14 ++++--
 fs/aio.c                                        | 20 ++------
 fs/attr.c                                       | 20 +++++++-
 fs/buffer.c                                     |  7 ++-
 fs/cachefiles/io.c                              | 16 ++-----
 fs/dcache.c                                     |  5 +-
 fs/devpts/inode.c                               | 10 ++--
 fs/ecryptfs/crypto.c                            |  8 ++--
 fs/ecryptfs/mmap.c                              |  5 +-
 fs/ecryptfs/read_write.c                        | 12 ++---
 fs/eventfd.c                                    |  2 +-
 fs/eventpoll.c                                  | 12 +----
 fs/fcntl.c                                      | 29 +++++------
 fs/file.c                                       | 30 ++++++------
 fs/file_table.c                                 |  5 +-
 fs/fs_context.c                                 | 35 ++++++++++++--
 fs/ioctl.c                                      | 10 ++--
 fs/kernel_read_file.c                           | 12 ++---
 fs/libfs.c                                      | 42 ++++++++--------
 fs/locks.c                                      | 20 ++++----
 fs/namei.c                                      |  5 +-
 fs/nfs/nfs4_fs.h                                |  2 +-
 fs/nfs/nfs4file.c                               |  2 +-
 fs/nfs/nfs4proc.c                               |  4 +-
 fs/notify/dnotify/dnotify.c                     |  4 +-
 fs/open.c                                       | 31 ++++++++++--
 fs/overlayfs/file.c                             | 10 +---
 fs/pipe.c                                       |  8 ++--
 fs/read_write.c                                 |  2 +-
 fs/reiserfs/journal.c                           |  4 +-
 fs/smb/client/cifsfs.c                          |  2 +-
 fs/splice.c                                     | 64 ++++++++++++++-----------
 include/linux/dnotify.h                         |  4 +-
 include/linux/filelock.h                        | 12 ++---
 include/linux/fs.h                              | 60 ++++++++++++++++++++---
 include/linux/lsm_hook_defs.h                   |  1 +
 include/linux/pipe_fs_i.h                       |  4 +-
 include/linux/security.h                        |  6 +++
 init/do_mounts.c                                | 38 ++++++++++++++-
 io_uring/rw.c                                   | 33 ++++---------
 security/security.c                             | 14 ++++++
 security/selinux/hooks.c                        | 22 +++++++++
 security/smack/smack_lsm.c                      | 51 ++++++++++++++++++++
 44 files changed, 458 insertions(+), 243 deletions(-)
