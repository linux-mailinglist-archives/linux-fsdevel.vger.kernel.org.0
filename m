Return-Path: <linux-fsdevel+bounces-55801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207FB0F085
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA9E3BBDD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E444F2D879C;
	Wed, 23 Jul 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4FcudMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1992D3A89;
	Wed, 23 Jul 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268283; cv=none; b=qZ8jNR1k456GoyVKwCnBbmVDrzTyHSK+TLendlp+B5j8R5YYRA2yNqBgQA64sWAcvpwTTSQxRabQ7e15MGS6eqU4R3PIf5GQVY/Y+53alZcXQoQHTMubliFxlLqBuw3LRlQeBuNHGKVSRA0Kzz9TsHHsaKq9qug9cpENZ8rKDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268283; c=relaxed/simple;
	bh=48vooci2gQplmaGBQLVtUPqrxJSQUsE2mQ1c95KeKJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqCwKOozr/uC2IzuLN6AILlMLrTbZNkE3kSyOf2JQv+TWR/LNT8bivf4XeuEmYa7UBlorWl1k5BCLayN2/VMf6nCS8MJkN9rZt+kMMICpoQx9pb5f+NgAke+5e7d6Bvbi8uGuhRjLj7KWLmgCNnrpZWxO6Wg5KQY2ZXQo8qq5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4FcudMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4598BC4CEE7;
	Wed, 23 Jul 2025 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268282;
	bh=48vooci2gQplmaGBQLVtUPqrxJSQUsE2mQ1c95KeKJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4FcudMJ1fiKMY8ytty5UYpE2uaauyalHp43Ph0iupLPvYvMF4HvAcFv6m3m+LAAE
	 S7ekFFwNgtH0eFg2waTT5udvUE318uw9dn5GGzlibM1Um+fvpasjkOz9Qrk2j8k5XU
	 Yh9qaYSFBdOvKFo47GvJXaXvBx6QTiV5tkProuSkaHt3VFvLZS6wWxKrkus6yu+a3E
	 6Q+WQrAJONFJ1WzVlD4Bm8PjUZJ0po93dFJeDbKE/4HrL92GYZK+vyLk/iK/1XANln
	 a9nODc1SKgbX0ZWTOFywUOx9HNunp1dfrPQKp/EQE7AmdXBIhj8xoLTm4u6Ec5l9MM
	 SuQ+M9YbcyshQ==
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
Subject: [PATCH v4 00/15] Move fscrypt and fsverity out of struct inode
Date: Wed, 23 Jul 2025 12:57:38 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250715-work-inode-fscrypt-2b63b276e793
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=10922; i=brauner@kernel.org; h=from:subject:message-id; bh=48vooci2gQplmaGBQLVtUPqrxJSQUsE2mQ1c95KeKJ4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNCcse3sfoao4JQbLxvNHc8eKE2b4uJSZ5H83LVgh vch/lsrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai0sfw32vhKkH33FkftL5m frVdkfaKce/aX73zWeI/TH5/YJ4k2xuGvzJB2fn5Wv0rHq3LEFmk4ejMtH32lWlNQqlFcW/X7w+ u5gQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

As discussed, this moves the fscrypt and fsverity pointers out of struct
inode shrinking it by 16 bytes. The pointers move into the individual
filesystems that actually do make use of them.

In order to find the fscrypt and fsverity data pointers offsets from the
embedded struct inode in the filesystem's private inode data are stored
in struct fscrypt_operations and struct fsverity_operations
respectively. This means we get fast access to the data pointers without
having to rely on indirect calls.

Thanks to everyone for the very helpful reviews! The two obvious
suggestions other than moving it into struct super_operations were
moving it directly into struct super_block and moving it into struct
fscrypt_operations and struct fsverity_operations. I chose the latter as
I think that's just cleaner.

Thanks!
Christian

Test results:

+ sudo ./check -g encrypt,verity
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-gaa8ca50672ad #275 SMP PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
MKFS_OPTIONS  -- -F /dev/nvme0n1p6
MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme0n1p6 /mnt/scratch

ext4/024        3s
generic/395        4s
generic/396        3s
generic/397        4s
generic/398        4s
generic/399        35s
generic/419        4s
generic/421        4s
generic/429        14s
generic/435        23s
generic/440        4s
generic/548        9s
generic/549        9s
generic/550       [not run] encryption policy '-c 9 -n 9 -f 0' is unusable; probably missing kernel crypto API support
generic/572        6s
generic/573        3s
generic/574        38s
generic/575        10s
generic/576        5s
generic/577        4s
generic/579        25s
generic/580        4s
generic/581        11s
generic/582        10s
generic/583        10s
generic/584       [not run] encryption policy '-c 9 -n 9 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/592        10s
generic/593        4s
generic/595        8s
generic/602        11s
generic/613        21s
generic/621        9s
generic/624        4s
generic/625        4s
generic/692        5s
generic/693       [not run] encryption policy '-c 1 -n 10 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/739        18s
Ran: ext4/024 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
Not run: generic/550 generic/584 generic/693
Passed all 37 tests

+ sudo ./check -g encrypt,verity
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-gaa8ca50672ad #275 SMP PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
MKFS_OPTIONS  -- /dev/nvme0n1p6
MOUNT_OPTIONS -- /dev/nvme0n1p6 /mnt/scratch

btrfs/277       [not run] kernel does not support send stream 3
btrfs/290       [not run] btrfs-corrupt-block utility required, skipped this test
btrfs/291       [not run] This test requires a valid $LOGWRITES_DEV
generic/395 4s ... [not run] No encryption support for btrfs
generic/396 3s ... [not run] No encryption support for btrfs
generic/397 4s ... [not run] No encryption support for btrfs
generic/398 5s ... [not run] No encryption support for btrfs
generic/399 35s ... [not run] No encryption support for btrfs
generic/419 4s ... [not run] No encryption support for btrfs
generic/421 4s ... [not run] No encryption support for btrfs
generic/429 14s ... [not run] No encryption support for btrfs
generic/435 23s ... [not run] No encryption support for btrfs
generic/440 4s ... [not run] No encryption support for btrfs
generic/548 9s ... [not run] No encryption support for btrfs
generic/549 9s ... [not run] No encryption support for btrfs
generic/550       [not run] No encryption support for btrfs
generic/572 6s ...  7s
generic/573 3s ...  3s
generic/574 38s ... [not run] btrfs-corrupt-block utility required, skipped this test
generic/575 10s ...  9s
generic/576 5s ... [not run] No encryption support for btrfs
generic/577 4s ...  4s
generic/579 25s ...  24s
generic/580 4s ... [not run] No encryption support for btrfs
generic/581 11s ... [not run] No encryption support for btrfs
generic/582 10s ... [not run] No encryption support for btrfs
generic/583 10s ... [not run] No encryption support for btrfs
generic/584       [not run] No encryption support for btrfs
generic/592 10s ... [not run] No encryption support for btrfs
generic/593 4s ... [not run] No encryption support for btrfs
generic/595 8s ... [not run] No encryption support for btrfs
generic/602 11s ... [not run] No encryption support for btrfs
generic/613 21s ... [not run] No encryption support for btrfs
generic/621 9s ... [not run] No encryption support for btrfs
generic/624 4s ...  4s
generic/625 4s ...  3s
generic/692 5s ...  5s
generic/693       [not run] No encryption support for btrfs
generic/739 18s ... [not run] No encryption support for btrfs
Ran: btrfs/277 btrfs/290 btrfs/291 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
Not run: btrfs/277 btrfs/290 btrfs/291 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/574 generic/576 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/693 generic/739
Passed all 39 tests

+ sudo ./check -g encrypt,verity
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 localhost 6.16.0-rc1-gaa8ca50672ad #275 SMP PREEMPT_DYNAMIC Fri Jun  5 15:58:00 CEST 2015
MKFS_OPTIONS  -- /dev/nvme0n1p6
MOUNT_OPTIONS -- -o acl,user_xattr /dev/nvme0n1p6 /mnt/scratch

f2fs/002        22s
generic/395 4s ...  4s
generic/396 3s ...  3s
generic/397 4s ...  4s
generic/398 5s ...  5s
generic/399 35s ...  19s
generic/419 4s ...  4s
generic/421 4s ...  5s
generic/429 14s ...  14s
generic/435 23s ...  34s
generic/440 4s ...  5s
generic/548 9s ...  12s
generic/549 9s ...  12s
generic/550       [not run] encryption policy '-c 9 -n 9 -f 0' is unusable; probably missing kernel crypto API support
generic/572 7s ...  7s
generic/573 3s ...  4s
generic/574 38s ...  29s
generic/575 9s ...  10s
generic/576 5s ...  5s
generic/577 4s ...  4s
generic/579 24s ...  25s
generic/580 4s ...  3s
generic/581 11s ...  8s
generic/582 10s ...  9s
generic/583 10s ...  9s
generic/584       [not run] encryption policy '-c 9 -n 9 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/592 10s ...  9s
generic/593 4s ...  3s
generic/595 8s ...  7s
generic/602 11s ...  9s
generic/613 21s ...  18s
generic/621 9s ...  8s
generic/624 4s ...  2s
generic/625 3s ...  3s
generic/692 5s ...  3s
generic/693       [not run] encryption policy '-c 1 -n 10 -v 2 -f 0' is unusable; probably missing kernel crypto API support
generic/739 18s ...  17s
Ran: f2fs/002 generic/395 generic/396 generic/397 generic/398 generic/399 generic/419 generic/421 generic/429 generic/435 generic/440 generic/548 generic/549 generic/550 generic/572 generic/573 generic/574 generic/575 generic/576 generic/577 generic/579 generic/580 generic/581 generic/582 generic/583 generic/584 generic/592 generic/593 generic/595 generic/602 generic/613 generic/621 generic/624 generic/625 generic/692 generic/693 generic/739
Not run: generic/550 generic/584 generic/693
Passed all 37 tests

---
Changes in v4:
- Stash offsets in struct fscrypt_operations and struct
  fsverity_operations.
- Link to v3: https://lore.kernel.org/20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org

Changes in v3:
- Stash offsets in struct super_operations.
- Link to v2: https://lore.kernel.org/20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org

Changes in v2:
- First full implementation.
- Link to v1: https://lore.kernel.org/20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org

---
Christian Brauner (15):
      fs: add fscrypt offset
      fs/crypto: use accessors
      ext4: move fscrypt to filesystem inode
      ubifs: move fscrypt to filesystem inode
      f2fs: move fscrypt to filesystem inode
      ceph: move fscrypt to filesystem inode
      fs: drop i_crypt_info from struct inode
      fscrypt: rephrase documentation and comments
      fs: add fsverity offset
      fs/verity: use accessors
      btrfs: move fsverity to filesystem inode
      ext4: move fsverity to filesystem inode
      f2fs: move fsverity to filesystem inode
      fs: drop i_verity_info from struct inode
      fsverity: rephrase documentation and comments

 fs/btrfs/btrfs_inode.h       |  3 +++
 fs/btrfs/inode.c             |  3 +++
 fs/btrfs/verity.c            |  4 ++++
 fs/ceph/crypto.c             |  4 ++++
 fs/ceph/inode.c              |  1 +
 fs/ceph/super.h              |  1 +
 fs/crypto/bio.c              |  2 +-
 fs/crypto/crypto.c           |  8 ++++----
 fs/crypto/fname.c            |  8 ++++----
 fs/crypto/fscrypt_private.h  |  4 ++--
 fs/crypto/hooks.c            |  2 +-
 fs/crypto/inline_crypt.c     | 10 +++++-----
 fs/crypto/keysetup.c         | 44 +++++++++++++++++++++++++++-----------------
 fs/crypto/policy.c           |  6 +++---
 fs/ext4/crypto.c             |  4 ++++
 fs/ext4/ext4.h               |  8 ++++++++
 fs/ext4/super.c              |  6 ++++++
 fs/ext4/verity.c             |  4 ++++
 fs/f2fs/f2fs.h               |  6 ++++++
 fs/f2fs/super.c              | 10 ++++++++++
 fs/f2fs/verity.c             |  4 ++++
 fs/ubifs/crypto.c            |  4 ++++
 fs/ubifs/ubifs.h             |  3 +++
 fs/verity/enable.c           |  6 +++---
 fs/verity/fsverity_private.h |  9 +++++----
 fs/verity/open.c             | 25 ++++++++++++++++---------
 fs/verity/verify.c           |  2 +-
 include/linux/fs.h           | 10 ----------
 include/linux/fscrypt.h      | 42 ++++++++++++++++++++++++++++++++++++++----
 include/linux/fsverity.h     | 34 +++++++++++++++++++++++++++-------
 include/linux/netfs.h        |  7 +++++++
 31 files changed, 209 insertions(+), 75 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250715-work-inode-fscrypt-2b63b276e793


