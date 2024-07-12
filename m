Return-Path: <linux-fsdevel+bounces-23614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261792FBFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D2328338C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A7171653;
	Fri, 12 Jul 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXLgVsnD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBD171081;
	Fri, 12 Jul 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792808; cv=none; b=vAsit1bfjrSk77zz56SYc/ESMVU29gzyVVZl3xP+8gjCXtRYhByp0c8mciWcC8VD2rrY+Nff+w0Jh5w0eQTorhNcqrWAdI3E8+ip2TjiIrcB9dGPTCWECKql2yzP0Qa4hmNqFROuaF3GqLXXgiw+AbcKNO1cFngCLeIk5FJr+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792808; c=relaxed/simple;
	bh=DGSZ+m3mBiM3CPnjUI1G13NKvpVkuZFnkMu0JX/X7jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiDoCFaEMKI289P4QSw6cJMx8x5gLcZ81asVhnnVkeTIEnHwKRxh7tSVWdr4fDS9N1YY6hfokgHh+MdIS1zp3Qw6Gc5SYk3sDoM745AfGRDBP0qq6Rrds3OYLyeq2KD2bjvZ9HHzoIrEz8UXi63rdOETNW1GlIZn/8EYit8h63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXLgVsnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92851C32786;
	Fri, 12 Jul 2024 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792808;
	bh=DGSZ+m3mBiM3CPnjUI1G13NKvpVkuZFnkMu0JX/X7jM=;
	h=From:To:Cc:Subject:Date:From;
	b=YXLgVsnDJKOdnonyl1AsfSxjn+yxsu8LxLtm+80pCGmk+p9iyKya80BCUCItGCD0i
	 FRl3ck8joWeumoppnTB5KnM7hBaCwawhHA4FHLZCpaVSVnzSQvDK4RZwRGqObjfLdN
	 pH447kGaWm92WXXSL9K6x7EHPjMbnFN2Ly6OrLow/vzXlDnl0CBYKq0/RSuxav5uBy
	 KnB3X2/NpKRRFgZ9AM7MJ2bftNIXMfE0eCFhC8kNH5gFpWgMTLhhZ2LMQtFSyWw5fL
	 QasfNGerNMQR0eIsT0sEOv+Dgbn/rg6IXTN8IEsuvxutOnUdNsSjCaj3JwWdxZ5/fY
	 yFHBVZHn38SCw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs mount
Date: Fri, 12 Jul 2024 15:59:50 +0200
Message-ID: <20240712-vfs-mount-8fd93381a87f@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5287; i=brauner@kernel.org; h=from:subject:message-id; bh=DGSZ+m3mBiM3CPnjUI1G13NKvpVkuZFnkMu0JX/X7jM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNLvR/oDrkYC0n8E0v7tTHpd2than1q9oeKqUtmbhx 2r+gDXzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay6DTD/0ixH9J/H6yZJs3j 5ewixX5Sd6H6u0MlHxjMfxhLh/RIyDMyXNp4Ks+Np7ls3vb0JrF77F5zGxvEeJwtNkrf31Dl9la EFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains work to extend the abilities of listmount() and statmount() and
various fixes and cleanups.

Features:

- Allow iterating through mounts via listmount() from newest to oldest. This
  makes it possible for mount(8) to keep iterating the mount table in reverse
  order so it gets newest mounts first.

- Relax permissions on listmount() and statmount(). It's not necessary to have
  capabilities in the initial namespace. It's sufficient to have capabilities
  in the owning namespace of the mount namespace we're located in to list
  unreachable mounts in that namespace.

- Extend both listmount() and statmount() to list and stat mounts in foreign
  mount namespaces.

  Currently the only way to iterate over mount entries in mount namespaces that
  aren't in the caller's mount namespace is by crawling through /proc in order
  to find /proc/<pid>/mountinfo for the relevant mount namespace. This is both
  very clumsy and hugely inefficient. So extend struct mnt_id_req with a new
  member that allows to specify the mount namespace id of the mount namespace
  we want to look at.

  Luckily internally we already have most of the infrastructure for this so we
  just need to expose it to userspace. Give userspace a way to retrieve the id
  of a mount namespace via statmount() and through a new nsfs ioctl() on mount
  namespace file descriptor.

  This comes with appropriate selftests.

- Expose mount options through statmount().

  Currently if userspace wants to get mount options for a mount and with
  statmount(), they still have to open /proc/<pid>/mountinfo to parse mount
  options. Simply the information through statmount() directly.

  Afterwards it's possible to only rely on statmount() and listmount() to
  retrieve all and more information than /proc/<pid>/mountinfo provides.           

  This comes with appropriate selftests.

Fixes:

- Avoid copying to userspace under the namespace semaphore in listmount.

Cleanups:

- Simplify the error handling in listmount by relying on our newly added
  cleanup infrastructure.

- Refuse invalid mount ids early for both listmount and statmount.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.mount

for you to fetch changes up to 4bed843b10004d9101b49ac7270131051c39a92b:

  fs: reject invalid last mount id early (2024-07-08 06:32:18 +0200)

Please consider pulling these changes from the signed vfs-6.11.mount tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.mount

----------------------------------------------------------------
Christian Brauner (15):
      path: add cleanup helper
      fs: don't copy to userspace under namespace semaphore
      fs: simplify error handling
      fs: relax permissions for listmount()
      listmount: allow listing in reverse order
      fs: relax permissions for statmount()
      fs: Allow listmount() in foreign mount namespace
      fs: Allow statmount() in foreign mount namespace
      Merge patch series "Support foreign mount namespace with statmount/listmount"
      fs: use guard for namespace_sem in statmount()
      Merge patch series "Add the ability to query mount options in statmount"
      fs: only copy to userspace on success in listmount()
      fs: find rootfs mount of the mount namespace
      fs: refuse mnt id requests with invalid ids early
      fs: reject invalid last mount id early

Josef Bacik (7):
      fs: keep an index of current mount namespaces
      fs: export the mount ns id via statmount
      fs: add an ioctl to get the mnt ns id from nsfs
      selftests: add a test for the foreign mnt ns extensions
      fs: rename show_mnt_opts -> show_vfsmnt_opts
      fs: export mount options via statmount()
      sefltests: extend the statmount test for mount options

 fs/mount.h                                         |   2 +
 fs/namespace.c                                     | 450 +++++++++++++++++----
 fs/nsfs.c                                          |  14 +
 fs/proc_namespace.c                                |   6 +-
 include/linux/path.h                               |   9 +
 include/uapi/linux/mount.h                         |  10 +-
 include/uapi/linux/nsfs.h                          |   2 +
 .../selftests/filesystems/statmount/Makefile       |   2 +-
 .../selftests/filesystems/statmount/statmount.h    |  46 +++
 .../filesystems/statmount/statmount_test.c         | 144 +++++--
 .../filesystems/statmount/statmount_test_ns.c      | 364 +++++++++++++++++
 11 files changed, 926 insertions(+), 123 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount.h
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount_test_ns.c

