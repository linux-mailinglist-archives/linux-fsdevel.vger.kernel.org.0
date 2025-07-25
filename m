Return-Path: <linux-fsdevel+bounces-56022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDAB11D86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDAC561FA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206C2E6103;
	Fri, 25 Jul 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ4eIs1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549272E8E0F;
	Fri, 25 Jul 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442855; cv=none; b=d+7nKCMg2IL/dcCp15oqaDq60KLLDKszaDNvTTBuZMc5kdJ+gjYfeBNldZHvvUZlIjf3nSo5o9QivyIC5kaX5OIuTNPU23f/ntAcZVvTL4MeT/XsQYCEdJ1BwmegHyTIG9nPNNGzsYGTwvMyDHQMFnBhKN3fJXMomMazhdNhh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442855; c=relaxed/simple;
	bh=qyWq+hKzuIa8hMAydBNZAckNnUT5ZdxfWE+A5AtbJSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQIr7hUSWdD32HO5xjp8FSiLDVl+wDuCk2ikbi8oTjRwiudoVGEIeYeRQMsLMdgsNNcj1lk7i3t6msL7LiX1iS39o3E8372swPzqovuUedb4UcvPcDEiGX/diuXSOwcvnJzFY5cZG1nXOn8e5s8bKWkx5jsIl5aCMmCd/nQ5G7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ4eIs1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56B1C4CEEF;
	Fri, 25 Jul 2025 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442854;
	bh=qyWq+hKzuIa8hMAydBNZAckNnUT5ZdxfWE+A5AtbJSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJ4eIs1qoFbYjFckr9Qfaa4QN730MxjYqKwWAtDMRz7ocaOAb4SkrGxKQiK2Unlyp
	 oZjoUoNv4MjhHF1vGVw7gAwPL/7O46I6pJyQ4LfeLJPjVqXOis1RDkohzCyT6Tt/u5
	 tlMtoDPS/KGK4QQKULU7B0MiYhLuQ8xBjZPsRwsFlVXIRcU55tQiOa2ni+CMwvAYIp
	 GFMUgdV0UYXAI5FWAT+VbfISMEihwCiVquxQqae73mPElVWr8lTmnxq8KwJZdE/6ST
	 wew+/gwxgEKZ8zJEoYsZHba14C2o8sQ8rmjyXP27EZe9FfnY1vedBLXbH0SM6GrwQm
	 ByYUd9aFgfsWg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/14 for v6.17] vfs fallocate
Date: Fri, 25 Jul 2025 13:27:17 +0200
Message-ID: <20250725-vfs-fallocate-91b9067277e8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4503; i=brauner@kernel.org; h=from:subject:message-id; bh=qyWq+hKzuIa8hMAydBNZAckNnUT5ZdxfWE+A5AtbJSs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4n+r25ienjhm/TWJrn7lT6Lwo7pfkxNLrA513Bs5 pa2O9MXdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEj4uRoYN32xXmwB/7HK1N io2/9hnWFE6R4lNcF1y5tmSf44PMbkaGlT9DGzl3a4dI7exxZ0vhaV++xscn70B1gO5dIZWSViM +AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
fallocate() currently supports creating preallocated files efficiently.
However, on most filesystems fallocate() will preallocate blocks in an
unwriten state even if FALLOC_FL_ZERO_RANGE is specified.

The extent state must later be converted to a written state when the
user writes data into this range, which can trigger numerous metadata
changes and journal I/O. This may leads to significant write
amplification and performance degradation in synchronous write mode.

At the moment, the only method to avoid this is to create an empty file
and write zero data into it (for example, using 'dd' with a large block
size). However, this method is slow and consumes a considerable amount
of disk bandwidth.

Now that more and more flash-based storage devices are available it is
possible to efficiently write zeros to SSDs using the unmap write zeroes
command if the devices do not write physical zeroes to the media.

For example, if SCSI SSDs support the UMMAP bit or NVMe SSDs support the
DEAC bit[1], the write zeroes command does not write actual data to the
device, instead, NVMe converts the zeroed range to a deallocated state,
which works fast and consumes almost no disk write bandwidth.

This series implements the BLK_FEAT_WRITE_ZEROES_UNMAP feature and
BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED flag for SCSI, NVMe and
device-mapper drivers, and add the FALLOC_FL_WRITE_ZEROES and
STATX_ATTR_WRITE_ZEROES_UNMAP support for ext4 and raw bdev devices.

fallocate() is subsequently extended with the FALLOC_FL_WRITE_ZEROES
flag. FALLOC_FL_WRITE_ZEROES zeroes a specified file range in such a way
that subsequent writes to that range do not require further changes to
the file mapping metadata. This flag is beneficial for subsequent pure
overwriting within this range, as it can save on block allocation and,
consequently, significant metadata changes.

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

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.fallocate

for you to fetch changes up to 4f984fe7b4d9aea332c7ff59827a4e168f0e4e1b:

  Merge patch series "fallocate: introduce FALLOC_FL_WRITE_ZEROES flag" (2025-06-23 12:45:32 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.fallocate tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.fallocate

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fallocate: introduce FALLOC_FL_WRITE_ZEROES flag"

Zhang Yi (9):
      block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits
      nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit
      nvmet: set WZDS and DRB if device enables unmap write zeroes operation
      scsi: sd: set max_hw_wzeroes_unmap_sectors if device supports SD_ZERO_*_UNMAP
      dm: clear unmap write zeroes limits when disabling write zeroes
      fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
      block: factor out common part in blkdev_fallocate()
      block: add FALLOC_FL_WRITE_ZEROES support
      ext4: add FALLOC_FL_WRITE_ZEROES support

 Documentation/ABI/stable/sysfs-block | 33 ++++++++++++++++++
 block/blk-settings.c                 | 20 +++++++++--
 block/blk-sysfs.c                    | 26 ++++++++++++++
 block/fops.c                         | 44 +++++++++++++-----------
 drivers/md/dm-table.c                |  4 ++-
 drivers/nvme/host/core.c             | 20 ++++++-----
 drivers/nvme/target/io-cmd-bdev.c    |  4 +++
 drivers/scsi/sd.c                    |  5 +++
 fs/ext4/extents.c                    | 66 ++++++++++++++++++++++++++++++------
 fs/open.c                            |  1 +
 include/linux/blkdev.h               | 10 ++++++
 include/linux/falloc.h               |  3 +-
 include/trace/events/ext4.h          |  3 +-
 include/uapi/linux/falloc.h          | 17 ++++++++++
 14 files changed, 212 insertions(+), 44 deletions(-)

