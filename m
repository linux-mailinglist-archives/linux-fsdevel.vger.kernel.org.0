Return-Path: <linux-fsdevel+bounces-49763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58DAC22B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADEFA24FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D218EAE7;
	Fri, 23 May 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl+C82wS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5525E56A;
	Fri, 23 May 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003926; cv=none; b=qPUM/tDfa4qVEpstuffLiBcheMK5rFeRr+p95I/JdOOpB4kJeLqB+E9qb7N+xmVZKChZd1zyd228Sal/Y49/BSxRRhNqrltLc7LuPFPFGvmVV1GgWVA0CmMot4iutsYloe1CmniCHs83n2XuLRgsW89uaAoBxoZZzqGNfL3HgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003926; c=relaxed/simple;
	bh=XVNu4dyr7CqFaBgq6wnAd0uXqRpquMHskcdqzRjbx/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvUWtXSALiPVJtKM962XBI74iOo57ujhc93xpmTqh9ejr8dappTIF+wqNNZaR+RPWuCxyRdQL469Q8ejn5V6ZfyHQR1isfG2C1GmMTSnwZtMrKfV2sN4yQeC0fdJJmYVcYdsudMw0eV/0NdwLbIvB2blwv778z3qXLleMX3t8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl+C82wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBE0C4CEE9;
	Fri, 23 May 2025 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748003926;
	bh=XVNu4dyr7CqFaBgq6wnAd0uXqRpquMHskcdqzRjbx/8=;
	h=From:To:Cc:Subject:Date:From;
	b=cl+C82wSVNDCCauR/Lx25+SmpL0ciHLslMQ1kM003EsdeoEe4J94bHq5CUZn/at0L
	 G0Gjrs1+xsI2ghuaL08HBpaknNo8nvYnXgOvv6D1PTCEOL3jUk1YG+VLUsu5zDVJCO
	 GWEXNUXPGgg0ozOIlkqPPTu1G8ip06IgAfaUc6HSvt9IYNfvuzx0maDE5ZV++zKtMQ
	 mNA54lLfSK0qrfjdiI0wceDIhtSVxIhBnGQZeRWioDMZ+ZkY0EiCJunfre0ORwkev2
	 /VenpbGLb6arqKj0AeqEQaWrq+w5VEmr9RSfToc/mLWQSLJHXlSsCMZJ40L4KYvxNQ
	 +Eo7BMrUHuvgw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs lookup_{noperm,one}() cleanup
Date: Fri, 23 May 2025 14:36:59 +0200
Message-ID: <20250523-vfs-cleanups-f29f2bd1fce7@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5304; i=brauner@kernel.org; h=from:subject:message-id; bh=XVNu4dyr7CqFaBgq6wnAd0uXqRpquMHskcdqzRjbx/8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQYZH/WfzFpa9MEvUlP7tVn9EhNUlonJNJ1zKLw6Ryd9 6XKK/XcO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSYM/I0KFzVijwjK2Id9qP 72vmCyzW9DpXbTZ7moT+/5211kvaqhkZXke2bz4s8aXtjLraYYtWb0mJxU83lNharr/SJyi2NEO eAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains cleanups for the lookup_one*() family of helpers.

We expose a set of functions with names containing "lookup_one_len" and
others without the "_len".  This difference has nothing to do with
"len". It's rater a historical accident that can be confusing.

The functions without "_len" take a "mnt_idmap" pointer. This is found
in the "vfsmount" and that is an important question when choosing which
to use: do you have a vfsmount, or are you "inside" the filesystem. A
related question is "is permission checking relevant here?".

nfsd and cachefiles *do* have a vfsmount but *don't* use the non-_len
functions. They pass nop_mnt_idmap and refuse to work on filesystems
which have any other idmap.

This work changes nfsd and cachefile to use the lookup_one family of
functions and to explictily pass &nop_mnt_idmap which is consistent with
all other vfs interfaces used where &nop_mnt_idmap is explicitly passed.

The remaining uses of the "_one" functions do not require permission
checks so these are renamed to be "_noperm" and the permission checking
is removed.

This series also changes these lookup function to take a qstr instead of
separate name and len. In many cases this simplifies the call.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.async.dir

for you to fetch changes up to 4e5c53e03806359e68dde5e951e50cd1f4908405:

  Merge patch series "VFS: improve interface for lookup_one functions" (2025-04-08 11:24:42 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.async.dir tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.async.dir

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "VFS: improve interface for lookup_one functions"

NeilBrown (6):
      VFS: improve interface for lookup_one functions
      nfsd: Use lookup_one() rather than lookup_one_len()
      cachefiles: Use lookup_one() rather than lookup_one_len()
      VFS: rename lookup_one_len family to lookup_noperm and remove permission check
      Use try_lookup_noperm() instead of d_hash_and_lookup() outside of VFS
      VFS: change lookup_one_common and lookup_noperm_common to take a qstr

 Documentation/filesystems/porting.rst |  40 +++++++++
 arch/s390/hypfs/inode.c               |   2 +-
 drivers/android/binderfs.c            |   4 +-
 drivers/infiniband/hw/qib/qib_fs.c    |   4 +-
 fs/afs/dir.c                          |   2 +-
 fs/afs/dir_silly.c                    |   6 +-
 fs/autofs/dev-ioctl.c                 |   3 +-
 fs/binfmt_misc.c                      |   2 +-
 fs/btrfs/ioctl.c                      |   9 +-
 fs/cachefiles/internal.h              |   1 -
 fs/cachefiles/key.c                   |   1 -
 fs/cachefiles/namei.c                 |  14 +--
 fs/dcache.c                           |   1 -
 fs/debugfs/inode.c                    |   6 +-
 fs/ecryptfs/inode.c                   |  16 ++--
 fs/efivarfs/super.c                   |  15 ++--
 fs/exportfs/expfs.c                   |   5 +-
 fs/internal.h                         |   1 +
 fs/kernfs/mount.c                     |   2 +-
 fs/namei.c                            | 156 +++++++++++++++++-----------------
 fs/nfs/unlink.c                       |  11 ++-
 fs/nfsd/nfs3proc.c                    |   4 +-
 fs/nfsd/nfs3xdr.c                     |   4 +-
 fs/nfsd/nfs4proc.c                    |   4 +-
 fs/nfsd/nfs4recover.c                 |  13 +--
 fs/nfsd/nfs4xdr.c                     |   4 +-
 fs/nfsd/nfsproc.c                     |   5 +-
 fs/nfsd/vfs.c                         |  17 ++--
 fs/overlayfs/export.c                 |   6 +-
 fs/overlayfs/namei.c                  |  14 +--
 fs/overlayfs/overlayfs.h              |   2 +-
 fs/overlayfs/readdir.c                |   9 +-
 fs/proc/base.c                        |   2 +-
 fs/quota/dquot.c                      |   2 +-
 fs/smb/client/cached_dir.c            |   5 +-
 fs/smb/client/cifsfs.c                |   3 +-
 fs/smb/client/readdir.c               |   3 +-
 fs/smb/server/smb2pdu.c               |   7 +-
 fs/tracefs/inode.c                    |   2 +-
 fs/xfs/scrub/orphanage.c              |   7 +-
 include/linux/dcache.h                |   4 +-
 include/linux/namei.h                 |  17 ++--
 ipc/mqueue.c                          |   5 +-
 kernel/bpf/inode.c                    |   2 +-
 net/sunrpc/rpc_pipe.c                 |  12 +--
 security/apparmor/apparmorfs.c        |   4 +-
 security/inode.c                      |   2 +-
 security/selinux/selinuxfs.c          |   4 +-
 48 files changed, 254 insertions(+), 210 deletions(-)

