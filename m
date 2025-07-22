Return-Path: <linux-fsdevel+bounces-55670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8BFB0DA38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA4F6C2FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A92E9EA9;
	Tue, 22 Jul 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKpQkyQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902C2E92BB;
	Tue, 22 Jul 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189066; cv=none; b=Y9SA3aG+WH2lcKK9Zc5UPhqj2AZrC2KZiB7lmLiXhZD34455pE3DPO3nv3IkTi27ubAYYime3AWyVf6vF7nLqYn9EzIC7D3Lv/B7PaPIRleJTxo8H/LlS8j5AoECE9vIRnnzXJ4bNYJlL9SpjjefFA5m3NIngCi7qt9FcsGwMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189066; c=relaxed/simple;
	bh=bARCOiL08uAQyeDe2f2/r8lHI1O0I1oEsRX/5nIpCN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+TCBX33hVVr0cbdSlDbuB9oq9uGJwqd3kATkJfcdL39okyfNIl4EsiZhsJtmZ/uK7cuhjTYz+ZBs55ht0b5SKdVu1bBvFnVcyEdpX5RLhlo09kNvjzadF0zqzPWfzjYVT14bc9jydcKEzTANiSLQbrRVbPNhyAaaYr/ri1Swm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKpQkyQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B20DC4CEEB;
	Tue, 22 Jul 2025 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189065;
	bh=bARCOiL08uAQyeDe2f2/r8lHI1O0I1oEsRX/5nIpCN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKpQkyQgnbLAvYwJJegHOhFRALLQmD30v4UVCKw0DK3+04FRo1JiV7hldvrUwiaDU
	 uLbZcIYdN8zqRC0MSK8WGpXn+kb8pfCw/h0IMIDCsqbxXgTeskdoEyaWNPq+VTPEQ+
	 zEFagTD655Kl2AWHzZXB5kv8t2YvemtOgDg5G4oF5sw51z3zkJSuFmSMHd91jno3In
	 BtIrQ7j4FzE+DUemV7WKkdTWfxy3VlYaN661KiQMrROo6ClxJrJwW2sOpuACwKJB8Z
	 LO73x0F1/xOyA/sArZzFPhpZhP1l2oBGgYDVKZCgJ5I1YMIvA06VmXLRtWuUHZnDpZ
	 nhyCmcbZ5oKIQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 00/13] Move fscrypt and fsverity out of struct inode
Date: Tue, 22 Jul 2025 14:57:06 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <fhppu2rnsykr5obrib3btw7wemislq36wufnbl67salvoguaof@kkxaosrv3oho>
References: <fhppu2rnsykr5obrib3btw7wemislq36wufnbl67salvoguaof@kkxaosrv3oho>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250715-work-inode-fscrypt-2b63b276e793
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=6684; i=brauner@kernel.org; h=from:subject:message-id; bh=bARCOiL08uAQyeDe2f2/r8lHI1O0I1oEsRX/5nIpCN4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd2287uroEXgkRHPB3b9LuR/P71gUxHHP8NTVqRG/Z i0qXnbIraOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiN3sZGfZrbo6K8T52xSNB kFE8VmXFtiN8DXcmxRX9f/bvVPbU4uuMDDO3yx2N+G+utsvX6NCcTd6fTJjuLRUtXanNxzNHw6e +iQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

This is a POC. We're still discussing alternatives and I want to provide
some useful data on what I learned about using offsets to drop fscrypt
and fsverity from struct inode.

As discussed, this moves the fscrypt and fsverity pointers out of struct
inode shrinking it by 16 bytes. The pointers move into the individual
filesystems that actually do make use of them.

In order to find the fscrypt and fsverity data pointers offsets from the
embedded struct inode in the filesystem's private inode data are
stored in struct inode_operations. This means we get fast access to the
data pointers without having to rely on indirect calls.

Bugs & Issues
=============

* For fscrypt specifically the biggest issue is
  fscrypt_prepare_new_inode() is called in filesystem's inode allocation
  functions before inode->i_op is set. That means the offset isn't
  available at the time when we would need it. To fix this we can set
  dummy encrypted inode operations for the respective filesystem with an
  initialized offset.

* For both fscrypt & fsverity the biggest issue is that every codepath
  that currently calls make_bad_inode() after having initialized fscrypt
  or fsverity data will override inode->i_op with bad_inode_ops. At
  which point we're back to the previous problem: The offset isn't
  available anymore. So when inode->i_sb->s_op->evict_inode() is called
  fscrypt_put_encryption_info() doesn't have the offset available
  anymore and would corrupt the hell out of everything and also leak
  memory.

  Obviously we could use a flag to detect a bad inodes instead of i_op
  and let the filesystem assign it's own bad inode operations including
  the correct offset. Is it worth it?

  The other way I see we can fix this if we require fixed offsets in the
  filesystems inode so fscrypt and fsverity always now what offset to
  calculate. We could use two consecutive pointers at the beginning of
  the filesystem's inode. Does that always work and is it worth it?

Thanks!
Christian

Test results:

+ sudo ./check -g encrypt,verity
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-g15c8eb9cdbd3 #267 SMP PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
MKFS_OPTIONS  -- -F /dev/nvme3n1p6
MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme3n1p6 /mnt/scratch

ext4/024 3s ...  3s
generic/395 4s ...  4s
generic/396 3s ...  3s
generic/397 4s ...  3s
generic/398 4s ...  4s
generic/399 39s ...  35s
generic/419 3s ...  4s
generic/421 4s ...  4s
generic/429 14s ...  14s
generic/435 23s ...  22s
generic/440 3s ...  4s
generic/548 10s ...  9s
generic/549 9s ...  9s
generic/550       [not run] encryption policy '-c 9 -n 9 -f 0' is unusable; probably missing kernel crypto API support
generic/572        6s
generic/573        4s
generic/574        28s
generic/575        9s
generic/576 5s ...  4s
generic/577        4s
generic/579        24s
generic/580 4s ...  4s
generic/581 10s ...  11s
generic/582 10s ...  9s
generic/583 9s ...  9s
generic/584       [not run] encryption policy '-c 9 -n 9 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/592 10s ...  10s
generic/593 4s ...  4s
generic/595 7s ...  7s
generic/602 9s ...  10s
generic/613 20s ...  20s
generic/621 9s ...  9s
generic/624        3s
generic/625        3s
generic/692        5s
generic/693       [not run] encryption policy '-c 1 -n 10 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/739 17s ...  18s
Ran: ext4/024 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
Not run: generic/550 generic/584 generic/693
Passed all 37 tests

---
Changes in v2:
- First full implementation.
- Link to v1: https://lore.kernel.org/20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org

---
Christian Brauner (13):
      fs: add fscrypt offset
      fs/crypto: use accessors
      ext4: move fscrypt to filesystem inode
      ubifs: move fscrypt to filesystem inode
      f2fs: move fscrypt to filesystem inode
      ceph: move fscrypt to filesystem inode
      fs: drop i_crypt_info from struct inode
      fs: add fsverity offset
      fs/verity: use accessors
      btrfs: move fsverity to filesystem inode
      ext4: move fsverity to filesystem inode
      f2fs: move fsverity to filesystem inode
      fs: drop i_verity_info from struct inode

 fs/btrfs/btrfs_inode.h       |  3 +++
 fs/btrfs/inode.c             | 20 ++++++++++++++++-
 fs/ceph/dir.c                |  8 +++++++
 fs/ceph/inode.c              | 21 ++++++++++++++++++
 fs/crypto/bio.c              |  2 +-
 fs/crypto/crypto.c           |  8 +++----
 fs/crypto/fname.c            |  8 +++----
 fs/crypto/fscrypt_private.h  |  2 +-
 fs/crypto/hooks.c            |  2 +-
 fs/crypto/inline_crypt.c     | 10 ++++-----
 fs/crypto/keysetup.c         | 27 +++++++++++++----------
 fs/crypto/policy.c           |  6 ++---
 fs/ext4/ext4.h               |  9 ++++++++
 fs/ext4/file.c               |  8 +++++++
 fs/ext4/ialloc.c             |  2 ++
 fs/ext4/inode.c              |  1 +
 fs/ext4/mballoc.c            |  3 +++
 fs/ext4/namei.c              | 23 ++++++++++++++++++++
 fs/ext4/super.c              |  6 +++++
 fs/ext4/symlink.c            | 24 ++++++++++++++++++++
 fs/f2fs/f2fs.h               |  7 ++++++
 fs/f2fs/file.c               |  8 +++++++
 fs/f2fs/inode.c              |  1 +
 fs/f2fs/namei.c              | 41 ++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c              |  6 +++++
 fs/ubifs/dir.c               | 52 ++++++++++++++++++++++++--------------------
 fs/ubifs/file.c              |  8 +++++++
 fs/ubifs/super.c             |  8 +++++++
 fs/ubifs/ubifs.h             |  3 +++
 fs/verity/enable.c           |  2 +-
 fs/verity/fsverity_private.h |  2 +-
 fs/verity/open.c             | 18 +++++++++------
 fs/verity/verify.c           |  2 +-
 include/linux/fs.h           | 10 ++-------
 include/linux/fscrypt.h      | 31 ++++++++++++++++++++++++--
 include/linux/fsverity.h     | 21 ++++++++++++------
 include/linux/netfs.h        |  6 +++++
 37 files changed, 337 insertions(+), 82 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250715-work-inode-fscrypt-2b63b276e793


