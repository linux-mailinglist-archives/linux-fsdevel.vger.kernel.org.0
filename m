Return-Path: <linux-fsdevel+bounces-76608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODxHOsUdhmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:58:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F8C100A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3338230304B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F42E173B;
	Fri,  6 Feb 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2CsDpnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A32D0618;
	Fri,  6 Feb 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396699; cv=none; b=M/Mb5zN9hQGME+yJ4dY4xzciYJdarZO5KUYQbMy4sSd4G3lS9XwlZV2pGmfYbKrPa+CnTxY+q4do0vmnWU/b3HSwU86dTxZ+77Slr4Q32Q5zKU46YcNFHuUB+Xc8YI4NSer8cG2ZfvgfQw9S5VeHU4iGmbDg9BS6Ge/ck00gQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396699; c=relaxed/simple;
	bh=aRSn7S2oExf3r/hn00OpscBJx2trUr554oTuddpdHSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqFp0UbJvUqMHymdLNt3+kyR3ZyhqhkT992fj/031smeZpj9glYt26WEWD3NccianfAo3xKCRpGbKGYwuO43HnSlZoyt34kkuMmXGwygdDG01bueI4umoZOgMMgKMoc18GTxpuLjevSXI8fniDr1yVqjU6tSoxGt0rOUqfRQ+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2CsDpnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F401C19422;
	Fri,  6 Feb 2026 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396699;
	bh=aRSn7S2oExf3r/hn00OpscBJx2trUr554oTuddpdHSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2CsDpnhryc4rgG+bXc2aA9XWgyjHOYOj05/BiRyvnn2Seq9zINDSDCsvUw9NutGK
	 txyGftP7BqmgYodarR6q/ZqP1WOKi7MAnh+MtzMTvP3kpbAgUr3dmOBzGXl96qrF8+
	 whf8XfrZTjsDYSEFoxJ6l71b/v6/k80h7X45vZ+VK2VnY/VeSHzrEWmny24mdPUpjK
	 3JDppw5oDvizi2v4DWuETs++cM5QL2zzn6FAP05wUyU0c0vezZdfwlSIQ5zIozZ3CU
	 zzChGeqHFZETzX+/o1M5O9mDuezkDpjMxHILu3W1LbeoYSXQA241EQclx2o6H8npwJ
	 jzC96Rf7afkFQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/12 for v7.0] vfs namespace
Date: Fri,  6 Feb 2026 17:50:06 +0100
Message-ID: <20260206-vfs-namespace-v70-f8476aa664c3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5344; i=brauner@kernel.org; h=from:subject:message-id; bh=aRSn7S2oExf3r/hn00OpscBJx2trUr554oTuddpdHSA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se8663YwcclSrpabWgfc1lUGvfnM1bv9Y7PS3hmed bcLG9bpdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEagfDH14b7zhvM1ftXy90 NYW4L1z6M8tW5+d+bv7g8/YpndLnfzL8ZFzQdUDGLH5H4vU8mxsacU/1D16ozj+84RLzjAfhJgy buAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76608-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67F8C100A5D
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains the mount changes for this cycle.

statmount: accept fd as a parameter

  Extend struct mnt_id_req with a file descriptor field and a new
  STATMOUNT_BY_FD flag. When set, statmount() returns mount information for the
  mount the fd resides on — including detached mounts (unmounted via
  umount2(MNT_DETACH)). For detached mounts the STATMOUNT_MNT_POINT and
  STATMOUNT_MNT_NS_ID mask bits are cleared since neither is meaningful. The
  capability check is skipped for STATMOUNT_BY_FD since holding an fd already
  implies prior access to the mount and equivalent information is available
  through fstatfs() and /proc/pid/mountinfo without privilege. Includes
  comprehensive selftests covering both attached and detached mount cases.

fs: Remove internal old mount API code (1 patch)

  Now that every in-tree filesystem has been converted to the new mount API,
  remove all the legacy shim code in fs_context.c that handled unconverted
  filesystems. This deletes ~280 lines including legacy_init_fs_context(), the
  legacy_fs_context struct, and associated wrappers. The mount(2) syscall path
  for userspace remains untouched. Documentation references to the legacy
  callbacks are cleaned up.

mount: add OPEN_TREE_NAMESPACE (2 patches)

  Add OPEN_TREE_NAMESPACE to open_tree(). Container runtimes currently use
  CLONE_NEWNS to copy the caller's entire mount namespace — only to then
  pivot_root() and recursively unmount everything they just copied. With large
  mount tables and thousands of parallel container launches this creates
  significant contention on the namespace semaphore.

  OPEN_TREE_NAMESPACE copies only the specified mount tree (like
  OPEN_TREE_CLONE) but returns a mount namespace fd instead of a detached mount
  fd. The new namespace contains the copied tree mounted on top of a clone of
  the real rootfs. This functions as a combined unshare(CLONE_NEWNS) +
  pivot_root() in a single syscall. Works with user namespaces: an
  unshare(CLONE_NEWUSER) followed by OPEN_TREE_NAMESPACE creates a mount
  namespace owned by the new user namespace. Mount namespace file mounts are
  excluded from the copy to prevent cycles. Includes ~1000 lines of selftests.

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

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.namespace

for you to fetch changes up to 1bce1a664ac25d37a327c433a01bc347f0a81bd6:

  Merge patch series "mount: add OPEN_TREE_NAMESPACE" (2026-01-16 19:21:40 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.namespace

Please consider pulling these changes from the signed vfs-7.0-rc1.namespace tag.

Thanks!
Christian

----------------------------------------------------------------
Bhavik Sachdev (3):
      statmount: permission check should return EPERM
      statmount: accept fd as a parameter
      selftests: statmount: tests for STATMOUNT_BY_FD

Christian Brauner (4):
      Merge patch series "statmount: accept fd as a parameter"
      mount: add OPEN_TREE_NAMESPACE
      selftests/open_tree: add OPEN_TREE_NAMESPACE tests
      Merge patch series "mount: add OPEN_TREE_NAMESPACE"

Eric Sandeen (1):
      fs: Remove internal old mount API code

 Documentation/filesystems/locking.rst              |    8 -
 Documentation/filesystems/mount_api.rst            |    2 -
 Documentation/filesystems/porting.rst              |    7 +-
 Documentation/filesystems/vfs.rst                  |   58 +-
 fs/fs_context.c                                    |  208 +---
 fs/fsopen.c                                        |   10 -
 fs/internal.h                                      |    2 +-
 fs/namespace.c                                     |  265 ++++-
 fs/nsfs.c                                          |   13 +
 include/linux/fs.h                                 |    2 -
 include/linux/fs/super_types.h                     |    1 -
 include/uapi/linux/mount.h                         |   13 +-
 .../selftests/filesystems/open_tree_ns/.gitignore  |    1 +
 .../selftests/filesystems/open_tree_ns/Makefile    |   10 +
 .../filesystems/open_tree_ns/open_tree_ns_test.c   | 1030 ++++++++++++++++++++
 .../selftests/filesystems/statmount/statmount.h    |   15 +-
 .../filesystems/statmount/statmount_test.c         |  261 ++++-
 .../filesystems/statmount/statmount_test_ns.c      |  101 +-
 tools/testing/selftests/filesystems/utils.c        |   26 +
 tools/testing/selftests/filesystems/utils.h        |    1 +
 20 files changed, 1669 insertions(+), 365 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/open_tree_ns/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/open_tree_ns/Makefile
 create mode 100644 tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c

