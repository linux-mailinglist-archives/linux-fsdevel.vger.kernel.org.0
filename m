Return-Path: <linux-fsdevel+bounces-55726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1EB0E426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0641C80335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CD28467D;
	Tue, 22 Jul 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkJB+hIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3332820B2;
	Tue, 22 Jul 2025 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212472; cv=none; b=f6K/+gUBiNr6ybWRWX0gizWnGve/TZR6Uxy1PR4KaUgLvutg8JtmwTmClBng5DWBwmS1rcQHUscBjtm4MBGn9Mn044a6v1U/Yn70eF7zb5McI2MaXpfDUF4Rf6P6ipPiEvv0jxKOh5vEqBUxnQ36zlv8pjrunrwkzFav11pN1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212472; c=relaxed/simple;
	bh=glOlgwBpX/BwRpM46/DOUDiLhPDQIYeqwbl90vqUHNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMUo+kEQaENULcQ1tLngpn7f1vcRDyqWKrXJJpj4o14deXe60hvJsP4pSJtaXdwKFxTGILfxmGBuQJrUxlxm5lDez3xHktjWkesSkos7LeWG0gYtUkgn8H0mz19z+xh0YSjKRlvqe2GIfagMUqCpZT3cuDW1/3Ih2xu434V9vbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkJB+hIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED5C4CEEB;
	Tue, 22 Jul 2025 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212471;
	bh=glOlgwBpX/BwRpM46/DOUDiLhPDQIYeqwbl90vqUHNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkJB+hIvdcod5OhwRAiTZjLTJD8PDsQyYDLf6CeCZNWPM4VTZ19cs2nvoLKdzdtt8
	 /Z7hSmlp4m+CcWb7fV2ToNBKzis44fCF0D8Isrej7Vi5Id/nDM/X3mbQcdYYsW1x3C
	 sFRdaFFq6MKddAfCXoZcJ3uZndtsyAL8/vJvfMtd/EVefdUuUD3nZ4QMbgJpyR6UfA
	 /yy96rE4cqbCISQL82L5ELoqF2DE4myQrlTlhoE+ANpbdomvNWyMX01E6yG0Rzr1T7
	 fKRP5ILL9v7FobPPD4HFZzGGB9udYjxsco2UenB9cT80wzf0hnByN8pKaIq24gorJR
	 K0QKJQVmly0Sg==
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
Subject: [PATCH v3 00/13] Move fscrypt and fsverity out of struct inode
Date: Tue, 22 Jul 2025 21:27:18 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-telefon-chloren-648e8850e6bb@brauner>
References: <20250722-telefon-chloren-648e8850e6bb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250715-work-inode-fscrypt-2b63b276e793
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=10114; i=brauner@kernel.org; h=from:subject:message-id; bh=glOlgwBpX/BwRpM46/DOUDiLhPDQIYeqwbl90vqUHNs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5PZ3SvKc2pHyJ3TvY+Pn2L9/2enzXaFpRtemF1sW X1wUcriUx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT0WdjZJhrJOLC/PjpA8vd V+XYrtoHPd0eqJDa5byfa19wnuv6rdMZGQ4a6Uc8nnW0bSdD62LBW16Xm6qdL69ik3Fs8j+nd8u ijRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

As discussed, this moves the fscrypt and fsverity pointers out of struct
inode shrinking it by 16 bytes. The pointers move into the individual
filesystems that actually do make use of them.

In order to find the fscrypt and fsverity data pointers offsets from the
embedded struct inode in the filesystem's private inode data are stored
in struct super_operations. This means we get fast access to the data
pointers without having to rely on indirect calls.

Thanks!
Christian

Test results:

+ sudo ./check -g encrypt,verity
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-g9cfff4adb101 #268 SMP PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
MKFS_OPTIONS  -- -F /dev/nvme1n1p6
MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme1n1p6 /mnt/scratch

ext4/024        3s
generic/395        5s
generic/396        3s
generic/397        3s
generic/398        4s
generic/399        35s
generic/419        3s
generic/421        5s
generic/429        13s
generic/435        23s
generic/440        4s
generic/548        10s
generic/549        9s
generic/550       [not run] encryption policy '-c 9 -n 9 -f 0' is unusable; probably missing kernel crypto API support
generic/572        6s
generic/573        4s
generic/574        36s
generic/575        9s
generic/576        5s
generic/577        4s
generic/579        24s
generic/580        5s
generic/581        11s
generic/582        10s
generic/583        9s
generic/584       [not run] encryption policy '-c 9 -n 9 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/592        10s
generic/593        4s
generic/595        7s
generic/602        9s
generic/613        20s
generic/621        8s
generic/624        4s
generic/625        4s
generic/692        5s
generic/693       [not run] encryption policy '-c 1 -n 10 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/739        18s
Ran: ext4/024 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
Not run: generic/550 generic/584 generic/693
Passed all 37 tests

+ sudo ./check -g encrypt,verity
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-g9cfff4adb101 #268 SMP PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
MKFS_OPTIONS  -- /dev/nvme1n1p6
MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme1n1p6 /mnt/scratch

f2fs/002       [not run] lz4 utility required, skipped this test
generic/395 5s ...  4s
generic/396 3s ...  4s
generic/397 3s ...  4s
generic/398 4s ...  4s
generic/399 35s ...  20s
generic/419 3s ...  4s
generic/421 5s ...  5s
generic/429 13s ...  14s
generic/435 23s ...  32s
generic/440 4s ...  4s
generic/548 10s ...  12s
generic/549 9s ...  12s
generic/550       [not run] encryption policy '-c 9 -n 9 -f 0' is unusable; probably missing kernel crypto API support
generic/572 6s ...  6s
generic/573 4s ...  4s
generic/574 36s ...  27s
generic/575 9s ...  10s
generic/576 5s ...  5s
generic/577 4s ...  4s
generic/579 24s ...  26s
generic/580 5s ...  5s
generic/581 11s ...  12s
generic/582 10s ...  12s
generic/583 9s ...  12s
generic/584       [not run] encryption policy '-c 9 -n 9 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/592 10s ...  13s
generic/593 4s ...  4s
generic/595 7s ...  7s
generic/602 9s ...  13s
generic/613 20s ...  24s
generic/621 8s ...  9s
generic/624 4s ...  3s
generic/625 4s ...  4s
generic/692 5s ...  5s
generic/693       [not run] encryption policy '-c 1 -n 10 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/739 18s ...  23s
Ran: f2fs/002 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
Not run: f2fs/002 generic/550 generic/584 generic/693
Passed all 37 tests

+ sudo ./check -g encrypt,verity
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-g9cfff4adb101 #268 SMP PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
MKFS_OPTIONS  -- /dev/nvme1n1p6
MOUNT_OPTIONS -- /dev/nvme1n1p6 /mnt/scratch

btrfs/277       [not run] kernel does not support send stream 3
btrfs/290       [not run] btrfs-corrupt-block utility required, skipped this test
btrfs/291       [not run] This test requires a valid $LOGWRITES_DEV
generic/395 4s ... [not run] No encryption support for btrfs
generic/396 4s ... [not run] No encryption support for btrfs
generic/397 4s ... [not run] No encryption support for btrfs
generic/398 4s ... [not run] No encryption support for btrfs
generic/399 20s ... [not run] No encryption support for btrfs
generic/419 4s ... [not run] No encryption support for btrfs
generic/421 5s ... [not run] No encryption support for btrfs
generic/429 14s ... [not run] No encryption support for btrfs
generic/435 32s ... [not run] No encryption support for btrfs
generic/440 4s ... [not run] No encryption support for btrfs
generic/548 12s ... [not run] No encryption support for btrfs
generic/549 12s ... [not run] No encryption support for btrfs
generic/550       [not run] No encryption support for btrfs
generic/572 6s ...  6s
generic/573 4s ...  3s
generic/574 27s ... [not run] btrfs-corrupt-block utility required, skipped this test
generic/575 10s ...  8s
generic/576 5s ... [not run] No encryption support for btrfs
generic/577 4s ...  5s
generic/579 26s ...  24s
generic/580 5s ... [not run] No encryption support for btrfs
generic/581 12s ... [not run] No encryption support for btrfs
generic/582 12s ... [not run] No encryption support for btrfs
generic/583 12s ... [not run] No encryption support for btrfs
generic/584       [not run] No encryption support for btrfs
generic/592 13s ... [not run] No encryption support for btrfs
generic/593 4s ... [not run] No encryption support for btrfs
generic/595 7s ... [not run] No encryption support for btrfs
generic/602 13s ... [not run] No encryption support for btrfs
generic/613 24s ... [not run] No encryption support for btrfs
generic/621 9s ... [not run] No encryption support for btrfs
generic/624 3s ...  2s
generic/625 4s ...  2s
generic/692 5s ...  3s
generic/693       [not run] No encryption support for btrfs
generic/739 23s ... [not run] No encryption support for btrfs
Ran: btrfs/277 btrfs/290 btrfs/291 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
Not run: btrfs/277 btrfs/290 btrfs/291 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/574 generic/576 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/693 generic/739
Passed all 39 tests

---
Changes in v3:
- Stash offsets in struct super_operations.
- Link to v2: https://lore.kernel.org/20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org

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
 fs/btrfs/inode.c             |  3 +++
 fs/btrfs/super.c             |  4 ++++
 fs/ceph/super.c              |  4 ++++
 fs/crypto/bio.c              |  2 +-
 fs/crypto/crypto.c           |  8 ++++----
 fs/crypto/fname.c            |  8 ++++----
 fs/crypto/fscrypt_private.h  |  2 +-
 fs/crypto/hooks.c            |  2 +-
 fs/crypto/inline_crypt.c     | 10 +++++-----
 fs/crypto/keysetup.c         | 27 ++++++++++++++++-----------
 fs/crypto/policy.c           |  6 +++---
 fs/ext4/ext4.h               |  8 ++++++++
 fs/ext4/mballoc-test.c       |  4 ++++
 fs/ext4/super.c              | 14 ++++++++++++++
 fs/f2fs/f2fs.h               |  6 ++++++
 fs/f2fs/super.c              | 14 ++++++++++++++
 fs/ubifs/super.c             |  4 ++++
 fs/ubifs/ubifs.h             |  3 +++
 fs/verity/enable.c           |  2 +-
 fs/verity/fsverity_private.h |  2 +-
 fs/verity/open.c             | 17 ++++++++++-------
 fs/verity/verify.c           |  2 +-
 include/linux/fs.h           | 10 ++--------
 include/linux/fscrypt.h      | 31 +++++++++++++++++++++++++++++--
 include/linux/fsverity.h     | 21 ++++++++++++++-------
 include/linux/netfs.h        |  6 ++++++
 27 files changed, 166 insertions(+), 57 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250715-work-inode-fscrypt-2b63b276e793


