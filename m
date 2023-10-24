Return-Path: <linux-fsdevel+bounces-1086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164577D5470
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD51C20848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E4C30CEA;
	Tue, 24 Oct 2023 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqZ13b95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA62E64E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A01C433C8;
	Tue, 24 Oct 2023 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159244;
	bh=iuOglcChqbe4jFXhJE+CY0Jyv51Sh6M4fFVtedJpDJw=;
	h=From:Subject:Date:To:Cc:From;
	b=DqZ13b95PIYaMJOB92ZeKl5MZlXYM5So+ziTblA+IEnabC1UWuWPiXVGIrLdLI0hR
	 hVNrzb6WsS0DUrBm+/1zgS+yDYJKybmIyFIxy+LRSP/i7O7jw6F99Pr9vPezMdg+L3
	 HMSLFPPKie6Ik7MbeTP0LdWrDEj6xTZf4YShsi/zTIyZrTrFlu99JCUwBAktXJHzGh
	 /ihoqh7uv+gC95hnSwu7+u/Q75npNFhBLo8lyUA36zljPRamLKZb3keDkUSJnRmnd+
	 HB09ceTk/3IvCDMqEwGBYzE7eaO/NpIy3m87CW1hUAfmJh1Iusk7jUmZXl5Rdm/OKH
	 uFFEfvmvlTTZw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/6] fs,block: yield devices
Date: Tue, 24 Oct 2023 16:53:38 +0200
Message-Id: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLaN2UC/yXMQQrCQAyF4auUrE2ZTgdEt4IHcCsu0jG1QZiWB
 KtQendjXf4P3reAsQobHKsFlGcxGYtHs6sgD1QejHL3hhhi24SYcO4N7TWxovJ71CdmSmlPbUw
 hH8Bvk3Ivn428wuV8gpuPHRljp1Ty8NMcqTek/iOwrl8LM8wjigAAAA==
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iuOglcChqbe4jFXhJE+CY0Jyv51Sh6M4fFVtedJpDJw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSa3+qSis4WCgnkuljXtaBFoFG6av1PjRnTDcP3P3Re89OF
 1X9NRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERsfzIyLDgdObFQYibLm3ePym89OZ
 t4RLAnKPvgstDF4QdOv1zx/iHD/4hnzm4B0oJ7Llb+0P6d9n8RH5+Xi7nLFta2z7lPiubdZgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This is a mechanism that allows the holder of a block device to yield
device access before actually closing the block device.

If a someone yields a device then any concurrent opener claiming the
device exclusively with the same blk_holder_ops as the current owner can
wait for the device to be given up. Filesystems by default use
fs_holder_ps and so can wait on each other.

This mechanism allows us to simplify superblock handling quite a bit at
the expense of requiring filesystems to yield devices. A filesytems must
yield devices under s_umount. This allows costly work to be done outside
of s_umount.

There's nothing wrong with the way we currently do things but this does
allow us to simplify things and kills a whole class of theoretical UAF
when walking the superblock list.

I had originally considered doing it this way but wasn't able
(time-wise) to code that up but since we recently had that discussion
again here it is.

Survives both xfstests and blktests. Also tested this by introducing
custom delays into kill_block_super() to widen the race where a
superblock is removed from the instance list and the device is fully
closed and synced.
Based on on vfs.super and the freezer work sent out earlier.
Very barebones commit messages and less analyzed then usually for
possible side-effects.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (6):
      fs: simplify setup_bdev_super() calls
      xfs: simplify device handling
      ext4: simplify device handling
      bdev: simplify waiting for concurrent claimers
      block: mark device as about to be released
      fs: add ->yield_devices()

 block/bdev.c              | 54 +++++++++++++++++++++++++++-----------
 fs/ext4/super.c           | 15 ++++++++---
 fs/super.c                | 67 ++++++++++++++---------------------------------
 fs/xfs/xfs_super.c        | 46 +++++++++++++++++++++-----------
 include/linux/blk_types.h |  8 +++++-
 include/linux/blkdev.h    |  1 +
 include/linux/fs.h        |  1 +
 7 files changed, 109 insertions(+), 83 deletions(-)
---
base-commit: c6cc4b13e95115c13433136a17150768d562a54c
change-id: 20231024-vfs-super-rework-ca447a3240c9


