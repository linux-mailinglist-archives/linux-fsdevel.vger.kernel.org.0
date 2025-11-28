Return-Path: <linux-fsdevel+bounces-70164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3BC92A94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938363AE52E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B462F6913;
	Fri, 28 Nov 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqyrpy4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281482F6187;
	Fri, 28 Nov 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348694; cv=none; b=CMTmE63RCHJH28WmRuqImvgPgJbcCCE2r2H+g12oRGSh578uLEqaVfi4zg4IgGcO6IUxmdqLbX6JISfYE7S8pdNsGZneMfAeXsiURF14qvmDDMU46ky3g4gEdjcl24pTJ7un/QsTPViPbE6Do8/X/4KyPwYHUQrWgUoVRuZSX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348694; c=relaxed/simple;
	bh=k4zBxddvnIJK3IAyS+EsTbdCTz+q+6CCqbLsSXMTfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvMpLwkC0ZYjjLVwdbEVQ+k1MhK6zSx1aGQbDlBIAt++CYuGNVNQW+GWWZgIYqvlzBjR17PSBLlXWQgegiM532yx8+XJj8T+bpQUaiQXHGwmmhGpFgu21BZXEUK1v5J92oQGPDuS+KD/Qtxp0QaAMo8lIXf4siSxiy/TNTYGDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqyrpy4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CF1C116B1;
	Fri, 28 Nov 2025 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348692;
	bh=k4zBxddvnIJK3IAyS+EsTbdCTz+q+6CCqbLsSXMTfAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqyrpy4V8Px+IIJ2fFUUQQ6/t+si9qbTQd1nZOGr6AF/42K9R8Idu3Mspy9KaAmc1
	 B44EVQEzqB7PRyhRjK+QWT//7Ft8sHnd4aWXi2nBuyaiNt3oIyqozM7i9AZgpl3fVB
	 pCK7+24HUwHnNnVCMOKW8KJLDZ9bsokj0mlkPAikFIAJefz8yAgcCmuLQaS89uQQCq
	 Nazw7sJf+zP+3opnXvnBWinSzRX/QBDgTMWanaJAkFBV0B0L2g4uvICMYqqW1rHDPO
	 1aqcz7wrUJmXs2QeqEA+vvi4H3juKCGYgXGePfvwnrkMer1SV466u6JbMHTDSuKsHL
	 6vYiAOg3gGB3Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 14/17 for v6.19] overlayfs cred guards
Date: Fri, 28 Nov 2025 17:48:25 +0100
Message-ID: <20251128-vfs-ovl-cred-guards-v619-15a5d2f80226@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13043; i=brauner@kernel.org; h=from:subject:message-id; bh=k4zBxddvnIJK3IAyS+EsTbdCTz+q+6CCqbLsSXMTfAg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnr83adj95w/6ivEnm9XT5iiJ1WUusVb8LLMqb119 +S9Sg+IdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk6SpGhuftwncOzFUxKcp9 aHvgYHVogK3awbvZbLcOOy20K3tx0Q6o4mfXjPa2PxKzQnYV6fAstVQ0PPhXLOV2fMBubolXvA+ ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This converts all of overlayfs to use credential guards, eliminating
manual credential management throughout the filesystem. It depends on
the directory locking changes, the kbuild -fms-extensions support, and
the credential guard infrastructure.

Complete Credential Guard Conversion

- Convert all of overlayfs to use credential guards, replacing the manual
  ovl_override_creds()/ovl_revert_creds() pattern with scoped guards. This
  makes credential handling visually explicit and eliminates a class of
  potential bugs from mismatched override/revert calls.

  (1) Basic credential guard (with_ovl_creds)
  (2) Creator credential guard (ovl_override_creator_creds):

      Introduced a specialized guard for file creation operations that handles
      the two-phase credential override (mounter credentials, then fs{g,u}id
      override). The new pattern is much clearer:

      with_ovl_creds(dentry->d_sb) {
              scoped_class(prepare_creds_ovl, cred, dentry, inode, mode) {
                      if (IS_ERR(cred))
                              return PTR_ERR(cred);
                      /* creation operations */
              }
      }

  (3) Copy-up credential guard (ovl_cu_creds):

      Introduced a specialized guard for copy-up operations, simplifying the
      previous struct ovl_cu_creds helper and associated functions.

      Ported ovl_copy_up_workdir() and ovl_copy_up_tmpfile() to this pattern.

Cleanups

- Remove ovl_revert_creds() after all callers converted to guards

- Remove struct ovl_cu_creds and associated functions

- Drop ovl_setup_cred_for_create() after conversion

- Refactor ovl_fill_super(), ovl_lookup(), ovl_iterate(), ovl_rename()
  for cleaner credential guard scope

- Introduce struct ovl_renamedata to simplify rename handling

- Don't override credentials for ovl_check_whiteouts() (unnecessary)

- Remove unneeded semicolon

Dependencies

- Directory locking changes

- Kbuild -fms-extensions support

- Kernel credential guard infrastructure

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.ovl

for you to fetch changes up to 2579e21be532457742d4100bbda1c2a5b81cbdef:

  ovl: remove unneeded semicolon (2025-11-28 11:05:52 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.ovl tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.ovl

----------------------------------------------------------------
Chen Ni (1):
      ovl: remove unneeded semicolon

Christian Brauner (99):
      cleanup: fix scoped_class()
      cred: add kernel_cred() helper
      cred: make init_cred static
      cred: add scoped_with_kernel_creds()
      firmware: don't copy kernel creds
      nbd: don't copy kernel creds
      target: don't copy kernel creds
      unix: don't copy creds
      Merge patch series "creds: add {scoped_}with_kernel_creds()"
      cred: add scoped_with_creds() guards
      aio: use credential guards
      backing-file: use credential guards for reads
      backing-file: use credential guards for writes
      backing-file: use credential guards for splice read
      backing-file: use credential guards for splice write
      backing-file: use credential guards for mmap
      binfmt_misc: use credential guards
      erofs: use credential guards
      nfs: use credential guards in nfs_local_call_read()
      nfs: use credential guards in nfs_local_call_write()
      nfs: use credential guards in nfs_idmap_get_key()
      smb: use credential guards in cifs_get_spnego_key()
      act: use credential guards in acct_write_process()
      cgroup: use credential guards in cgroup_attach_permissions()
      net/dns_resolver: use credential guards in dns_query()
      Merge patch series "credentials guards: the easy cases"
      cred: add prepare credential guard
      sev-dev: use guard for path
      sev-dev: use prepare credential guard
      sev-dev: use override credential guards
      coredump: move revert_cred() before coredump_cleanup()
      coredump: pass struct linux_binfmt as const
      coredump: mark struct mm_struct as const
      coredump: split out do_coredump() from vfs_coredump()
      coredump: use prepare credential guard
      coredump: use override credential guard
      trace: use prepare credential guard
      trace: use override credential guard
      Merge patch series "credential guards: credential preparation"
      Merge patch "kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS"
      Merge patch series "Create and use APIs to centralise locking for directory ops."
      Merge branch 'kbuild-6.19.fms.extension'
      Merge branch 'vfs-6.19.directory.locking' into base.vfs-6.19.ovl
      ovl: add override_creds cleanup guard extension for overlayfs
      ovl: port ovl_copy_up_flags() to cred guards
      ovl: port ovl_create_or_link() to cred guard
      ovl: port ovl_set_link_redirect() to cred guard
      ovl: port ovl_do_remove() to cred guard
      ovl: port ovl_create_tmpfile() to cred guard
      ovl: port ovl_open_realfile() to cred guard
      ovl: port ovl_llseek() to cred guard
      ovl: port ovl_fsync() to cred guard
      ovl: port ovl_fallocate() to cred guard
      ovl: port ovl_fadvise() to cred guard
      ovl: port ovl_flush() to cred guard
      ovl: port ovl_setattr() to cred guard
      ovl: port ovl_getattr() to cred guard
      ovl: port ovl_permission() to cred guard
      ovl: port ovl_get_link() to cred guard
      ovl: port do_ovl_get_acl() to cred guard
      ovl: port ovl_set_or_remove_acl() to cred guard
      ovl: port ovl_fiemap() to cred guard
      ovl: port ovl_fileattr_set() to cred guard
      ovl: port ovl_fileattr_get() to cred guard
      ovl: port ovl_maybe_validate_verity() to cred guard
      ovl: port ovl_maybe_lookup_lowerdata() to cred guard
      ovl: don't override credentials for ovl_check_whiteouts()
      ovl: refactor ovl_iterate() and port to cred guard
      ovl: port ovl_dir_llseek() to cred guard
      ovl: port ovl_check_empty_dir() to cred guard
      ovl: port ovl_nlink_start() to cred guard
      ovl: port ovl_nlink_end() to cred guard
      ovl: port ovl_xattr_set() to cred guard
      ovl: port ovl_xattr_get() to cred guard
      ovl: port ovl_listxattr() to cred guard
      ovl: introduce struct ovl_renamedata
      ovl: refactor ovl_rename()
      ovl: port ovl_rename() to cred guard
      ovl: port ovl_copyfile() to cred guard
      ovl: refactor ovl_lookup()
      ovl: port ovl_lookup() to cred guard
      ovl: port ovl_lower_positive() to cred guard
      ovl: refactor ovl_fill_super()
      ovl: port ovl_fill_super() to cred guard
      ovl: remove ovl_revert_creds()
      Merge patch series "ovl: convert to cred guard"
      ovl: add ovl_override_creator_creds cred guard
      ovl: port ovl_create_tmpfile() to new ovl_override_creator_creds cleanup guard
      ovl: reflow ovl_create_or_link()
      ovl: mark ovl_setup_cred_for_create() as unused temporarily
      ovl: port ovl_create_or_link() to new ovl_override_creator_creds cleanup guard
      ovl: drop ovl_setup_cred_for_create()
      ovl: add copy up credential guard
      ovl: port ovl_copy_up_workdir() to cred guard
      ovl: mark *_cu_creds() as unused temporarily
      ovl: port ovl_copy_up_tmpfile() to cred guard
      ovl: remove struct ovl_cu_creds and associated functions
      Merge patch series "ovl: convert creation credential override to cred guard"
      Merge patch series "ovl: convert copyup credential override to cred guard"

Nathan Chancellor (2):
      jfs: Rename _inline to avoid conflict with clang's '-fms-extensions'
      kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS

NeilBrown (15):
      debugfs: rename end_creating() to debugfs_end_creating()
      VFS: introduce start_dirop() and end_dirop()
      VFS: tidy up do_unlinkat()
      VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
      VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()
      VFS: introduce start_creating_noperm() and start_removing_noperm()
      smb/server: use end_removing_noperm for for target of smb2_create_link()
      VFS: introduce start_removing_dentry()
      VFS: add start_creating_killable() and start_removing_killable()
      VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
      VFS/ovl/smb: introduce start_renaming_dentry()
      Add start_renaming_two_dentries()
      ecryptfs: use new start_creating/start_removing APIs
      VFS: change vfs_mkdir() to unlock on failure.
      VFS: introduce end_creating_keep()

Rasmus Villemoes (1):
      Kbuild: enable -fms-extensions

 Documentation/filesystems/porting.rst |  13 +
 Makefile                              |   3 +
 arch/arm64/kernel/vdso32/Makefile     |   3 +-
 arch/loongarch/vdso/Makefile          |   2 +-
 arch/parisc/boot/compressed/Makefile  |   2 +-
 arch/powerpc/boot/Makefile            |   3 +-
 arch/s390/Makefile                    |   3 +-
 arch/s390/purgatory/Makefile          |   3 +-
 arch/x86/Makefile                     |   4 +-
 arch/x86/boot/compressed/Makefile     |   7 +-
 drivers/base/firmware_loader/main.c   |  59 ++-
 drivers/block/nbd.c                   |  54 +--
 drivers/crypto/ccp/sev-dev.c          |  17 +-
 drivers/firmware/efi/libstub/Makefile |   4 +-
 drivers/target/target_core_configfs.c |  14 +-
 fs/aio.c                              |   6 +-
 fs/backing-file.c                     | 147 +++----
 fs/binfmt_misc.c                      |   7 +-
 fs/btrfs/ioctl.c                      |  41 +-
 fs/cachefiles/interface.c             |  11 +-
 fs/cachefiles/namei.c                 |  96 +++--
 fs/cachefiles/volume.c                |   9 +-
 fs/coredump.c                         | 142 +++----
 fs/debugfs/inode.c                    |  74 ++--
 fs/ecryptfs/inode.c                   | 153 ++++---
 fs/erofs/fileio.c                     |   6 +-
 fs/fuse/dir.c                         |  19 +-
 fs/internal.h                         |   3 +
 fs/jfs/jfs_incore.h                   |   6 +-
 fs/libfs.c                            |  36 +-
 fs/namei.c                            | 747 +++++++++++++++++++++++++++++-----
 fs/nfs/localio.c                      |  59 +--
 fs/nfs/nfs4idmap.c                    |   7 +-
 fs/nfsd/nfs3proc.c                    |  14 +-
 fs/nfsd/nfs4proc.c                    |  14 +-
 fs/nfsd/nfs4recover.c                 |  34 +-
 fs/nfsd/nfsproc.c                     |  11 +-
 fs/nfsd/vfs.c                         | 151 +++----
 fs/overlayfs/copy_up.c                | 143 +++----
 fs/overlayfs/dir.c                    | 585 +++++++++++++-------------
 fs/overlayfs/file.c                   |  97 ++---
 fs/overlayfs/inode.c                  | 118 +++---
 fs/overlayfs/namei.c                  | 402 +++++++++---------
 fs/overlayfs/overlayfs.h              |  53 ++-
 fs/overlayfs/readdir.c                | 110 ++---
 fs/overlayfs/super.c                  | 138 +++----
 fs/overlayfs/util.c                   |  29 +-
 fs/overlayfs/xattrs.c                 |  35 +-
 fs/smb/client/cifs_spnego.c           |   6 +-
 fs/smb/server/smb2pdu.c               |   6 +-
 fs/smb/server/vfs.c                   | 114 ++----
 fs/smb/server/vfs.h                   |   8 +-
 fs/xfs/scrub/orphanage.c              |  11 +-
 include/linux/cleanup.h               |  15 +-
 include/linux/cred.h                  |  22 +
 include/linux/fs.h                    |   2 +
 include/linux/init_task.h             |   1 -
 include/linux/namei.h                 |  82 ++++
 include/linux/sched/coredump.h        |   2 +-
 init/init_task.c                      |  27 ++
 ipc/mqueue.c                          |  32 +-
 kernel/acct.c                         |  29 +-
 kernel/cgroup/cgroup.c                |  10 +-
 kernel/cred.c                         |  27 --
 kernel/trace/trace_events_user.c      |  22 +-
 net/dns_resolver/dns_query.c          |   6 +-
 net/unix/af_unix.c                    |  17 +-
 scripts/Makefile.extrawarn            |   4 +-
 security/apparmor/apparmorfs.c        |   8 +-
 security/keys/process_keys.c          |   2 +-
 security/selinux/selinuxfs.c          |  15 +-
 71 files changed, 2276 insertions(+), 1886 deletions(-)

