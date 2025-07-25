Return-Path: <linux-fsdevel+bounces-56024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6AB11D89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C5A1CE41E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243F72EACEB;
	Fri, 25 Jul 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOClVBah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CB2EAB86;
	Fri, 25 Jul 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442858; cv=none; b=iPQ+7Qkdp/XUCCLJ9xOgLouDiKABkcGl7ndYKITqKykolDV4pV4xKMUkNnpreIQx+0m/f/Ni0VFfGIG1k8HTo9GdheY6qYyiJzlIqLbJZWMbkOvU0NeK80m8dEaBmT1BrkDdtgrKZqgryiHTB6GGj13Vm7lR4zm+t3BbtCj5DuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442858; c=relaxed/simple;
	bh=7KFWBy/AOQppgST99u7tmBQE3aL/idMf5xmj3kNGWnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVhuUsQm3Zja6NgoYWzA00slZPoGYnR25LxektMsqn53IWDf6mcOokojh/nWgF0T5sgsX9NiJxkSu+EX39fBp4UXP0aY8DotipoF4rT1Ylc4R460EDGWhWZmci1TiEA4cijsFVV+uTFr4ROSw+PBvMLqznzQJc5J3Liu5OZ0swI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOClVBah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAA2C4CEE7;
	Fri, 25 Jul 2025 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442858;
	bh=7KFWBy/AOQppgST99u7tmBQE3aL/idMf5xmj3kNGWnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOClVBahbsjxJnsouYCcg6aBIzzaEbPbArW3qx8Kj6FX9omXGZS97m94ruufG7MwT
	 qadGnUDdB0AGk9pweosdRv0IuC+ICdDzrbFHGL+iExF7hvp6a1BLDIB3Wu2IH2dcp6
	 T6FRcuDeGt/usfKlWWgErbqwgYZdslZQr+Qzl2rxxqX2ZQIDfPal9jsuw0GSl0dLOV
	 4/FL4XpNGzdOuLsKZ0Cjlfi84wJ5I/r3P7eg7WiWeMeZR+FK6bbCox5NBZWANTpgc6
	 Ega07IwwFjEGr3RulSDwnwtQrDHlv8je7qiIzibuxfa1QkwFG29D3ZZ59neh17kK+8
	 cXU8SWbjpj7Sw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 11/14 for v6.17] vfs integrity
Date: Fri, 25 Jul 2025 13:27:19 +0200
Message-ID: <20250725-vfs-integrity-d16cb92bb424@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; i=brauner@kernel.org; h=from:subject:message-id; bh=7KFWBy/AOQppgST99u7tmBQE3aL/idMf5xmj3kNGWnY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4nyGn/3WXPq/tazW7h3/n52K+eW8tHflb2+VVXyK RvNpq281FHCwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRv4EM/2s4Sn/Y6Jxi+iWa uOzVxIv/xe8HTNw0ZavLvkkOPrPSc8QZvod6OOy4pqH7etLSsvU/NkS+vB5bKmYtkVLw4/Bx398 6rAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This adds the new FS_IOC_GETLBMD_CAP ioctl() to query metadata and
protection info (PI) capabilities. This ioctl returns information about
the files integrity profile. This is useful for userspace applications
to understand a files end-to-end data protection support and configure
the I/O accordingly.

For now this interface is only supported by block devices. However the
design and placement of this ioctl in generic FS ioctl space allows us
to extend it to work over files as well. This maybe useful when
filesystems start supporting PI-aware layouts.

A new structure struct logical_block_metadata_cap is introduced, which
contains the following fields:

- lbmd_flags:
  bitmask of logical block metadata capability flags

- lbmd_interval:
  the amount of data described by each unit of logical block metadata

- lbmd_size:
  size in bytes of the logical block metadata associated with each
  interval

- lbmd_opaque_size:
  size in bytes of the opaque block tag associated with each interval

- lbmd_opaque_offset:
  offset in bytes of the opaque block tag within the logical block
  metadata

- lbmd_pi_size:
  size in bytes of the T10 PI tuple associated with each interval

- lbmd_pi_offset:
  offset in bytes of T10 PI tuple within the logical block metadata

- lbmd_pi_guard_tag_type:
  T10 PI guard tag type
    
- lbmd_pi_app_tag_size:
   size in bytes of the T10 PI application tag

- lbmd_pi_ref_tag_size:
   size in bytes of the T10 PI reference tag

- lbmd_pi_storage_tag_size:
  size in bytes of the T10 PI storage tag

The internal logic to fetch the capability is encapsulated in a helper
function blk_get_meta_cap(), which uses the blk_integrity profile
associated with the device. The ioctl returns -EOPNOTSUPP, if
CONFIG_BLK_DEV_INTEGRITY is not enabled.

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

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.integrity

for you to fetch changes up to bc5b0c8febccbeabfefc9b59083b223ec7c7b53a:

  block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP (2025-07-23 14:55:51 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.integrity tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.integrity

----------------------------------------------------------------
Anuj Gupta (5):
      block: rename tuple_size field in blk_integrity to metadata_size
      block: introduce pi_tuple_size field in blk_integrity
      nvme: set pi_offset only when checksum type is not BLK_INTEGRITY_CSUM_NONE
      fs: add ioctl to query metadata and protection info capabilities
      block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP

Arnd Bergmann (1):
      block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()

Christian Brauner (1):
      Merge patch series "add ioctl to query metadata and protection info capabilities"

 block/bio-integrity-auto.c        |  4 +--
 block/blk-integrity.c             | 70 ++++++++++++++++++++++++++++++++++++++-
 block/blk-settings.c              | 44 ++++++++++++++++++++++--
 block/ioctl.c                     |  6 ++++
 block/t10-pi.c                    | 16 ++++-----
 drivers/md/dm-crypt.c             |  4 +--
 drivers/md/dm-integrity.c         | 12 +++----
 drivers/nvdimm/btt.c              |  2 +-
 drivers/nvme/host/core.c          |  7 ++--
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/scsi/sd_dif.c             |  3 +-
 include/linux/blk-integrity.h     | 11 ++++--
 include/linux/blkdev.h            |  3 +-
 include/uapi/linux/fs.h           | 59 +++++++++++++++++++++++++++++++++
 14 files changed, 213 insertions(+), 30 deletions(-)

