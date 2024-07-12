Return-Path: <linux-fsdevel+bounces-23610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDF92FBED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B6E1C21356
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24C171640;
	Fri, 12 Jul 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugySXiRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE616D4C0;
	Fri, 12 Jul 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792555; cv=none; b=FHu+TrPhRrlc2+hH794mo47rBytSRVWw7Qv6kUusoFnvf6ed343c7/QcIssDtwp3K+9+QEmPJnIyfJe/S0HODM40Wxjly34DJJwu65R43F/WuxPPFecfPSmWgDFyJDT6umzMecsUEwdZSHcvmEi0E4ril/wqhu2EWfgcPKcE7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792555; c=relaxed/simple;
	bh=CSZadZ3S2hbNqK7vpQbuXOyEYF9smErz7q0oizKFpV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIsUC5aZjh3M7Vk4j8QxM+zIL8La1nfNYV4LE7/LgsVxn+9+5EpH1ym5gTeMROnApCClGlURVi0TIArtQKa+hR2REvT/oPSLInEn5u6KwMgmllBHydSxwJaZHonrUdvA/R9uKqGD6XI9OwlhDL5dlfkKeiGiJ/gvDYAeo6Bm+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugySXiRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0C4C32782;
	Fri, 12 Jul 2024 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792555;
	bh=CSZadZ3S2hbNqK7vpQbuXOyEYF9smErz7q0oizKFpV0=;
	h=From:To:Cc:Subject:Date:From;
	b=ugySXiRghfMOYtlEvtT25hMaTcTXwgUQ5g0IEgOXYyuQFgZ5dgu2sxlA6rMYGgxj8
	 gJgkiPDcLJG+yQksGYm+ZrQaF4Qu2I4ZVuTsEstckbOkvYQvi6z6qqq8AwH390x8t3
	 ARbtYZaR1NQedrB+3yp0GZwEwNE2EbHgJs/VoB0K+MN2VM/hXIJT9bjMMQUmeWHE0R
	 c6aQAVCzV9HpR2LnNkeLFRMz/iuVnr9FffSReNOxeLLzTdAQ8XjU/DhFThmN5QJ6z2
	 CFbb3LWqUfZTNpUiy2KrnzAOg+H96BqXd0FOuEYy7bRLCKzbeLjpnRQr1FHlUOMi5N
	 c0WU1EMo8+a1A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs mount api
Date: Fri, 12 Jul 2024 15:55:41 +0200
Message-ID: <20240712-vfs-mount-42ac86732006@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3945; i=brauner@kernel.org; h=from:subject:message-id; bh=CSZadZ3S2hbNqK7vpQbuXOyEYF9smErz7q0oizKFpV0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNH2kH/tKbBLvm2tei3bMZpUq35Tm1rvOXOuRm/Wsy Ma2zk75jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIno7WL4w++UH2i/vj23xWvm zHXH9J69OnhhBYvu1ytckgXJYj/dtjIyvFx1xaZ8+9400dmL36qWNq7I9t6gJ8b9amvb24J/Dl3 SPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains work for the mount api:

- Add a generic helper to parse uid and gid mount options. Currently we
  open-code the same logic in various filesystems which is error prone.
  Especially since the verification of uid and gid mount options is a sensitive
  operation in the face of idmappings. Add a generic helper and convert all
  filesystems over to it. Make sure that filesystems that are mountable in
  unprivileged containers verify that the specified uid and gid can be
  represented in the owning namespace of the filesystem.

- Convert hostfs to the new mount api.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.mount.api

for you to fetch changes up to eea6a8322efd3982e59c41a5b61948a0b043ca58:

  fuse: Convert to new uid/gid option parsing helpers (2024-07-03 16:55:11 +0200)

Please consider pulling these changes from the signed vfs-6.11.mount.api tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.mount.api

----------------------------------------------------------------
Eric Sandeen (18):
      fs_parse: add uid & gid option option parsing helpers
      autofs: Convert to new uid/gid option parsing helpers
      debugfs: Convert to new uid/gid option parsing helpers
      efivarfs: Convert to new uid/gid option parsing helpers
      exfat: Convert to new uid/gid option parsing helpers
      ext4: Convert to new uid/gid option parsing helpers
      hugetlbfs: Convert to new uid/gid option parsing helpers
      isofs: Convert to new uid/gid option parsing helpers
      ntfs3: Convert to new uid/gid option parsing helpers
      tmpfs: Convert to new uid/gid option parsing helpers
      smb: client: Convert to new uid/gid option parsing helpers
      tracefs: Convert to new uid/gid option parsing helpers
      vboxsf: Convert to new uid/gid option parsing helpers
      fat: move debug into fat_mount_options
      fat: Convert to new mount api
      fat: Convert to new uid/gid option parsing helpers
      fuse: verify {g,u}id mount options correctly
      fuse: Convert to new uid/gid option parsing helpers

Hongbo Li (1):
      hostfs: convert hostfs to use the new mount API

Nathan Chancellor (1):
      hostfs: Add const qualifier to host_root in hostfs_fill_super()

 Documentation/filesystems/mount_api.rst |   9 +-
 fs/autofs/inode.c                       |  16 +-
 fs/debugfs/inode.c                      |  16 +-
 fs/efivarfs/super.c                     |  12 +-
 fs/exfat/super.c                        |   8 +-
 fs/ext4/super.c                         |  22 +-
 fs/fat/fat.h                            |  18 +-
 fs/fat/inode.c                          | 674 ++++++++++++++++----------------
 fs/fat/namei_msdos.c                    |  38 +-
 fs/fat/namei_vfat.c                     |  38 +-
 fs/fs_parser.c                          |  34 ++
 fs/fuse/inode.c                         |  24 +-
 fs/hostfs/hostfs_kern.c                 |  83 +++-
 fs/hugetlbfs/inode.c                    |  12 +-
 fs/isofs/inode.c                        |  16 +-
 fs/ntfs3/super.c                        |  12 +-
 fs/smb/client/fs_context.c              |  39 +-
 fs/tracefs/inode.c                      |  16 +-
 fs/vboxsf/super.c                       |  16 +-
 include/linux/fs_parser.h               |   6 +-
 mm/shmem.c                              |  12 +-
 21 files changed, 594 insertions(+), 527 deletions(-)

