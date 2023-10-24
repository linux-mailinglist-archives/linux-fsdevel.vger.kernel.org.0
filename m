Return-Path: <linux-fsdevel+bounces-1027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD07D50ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E901C20C03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC228E0A;
	Tue, 24 Oct 2023 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND+XyeZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6214A84
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB437C433C7;
	Tue, 24 Oct 2023 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152771;
	bh=vj6lmWbcnOTpI0tTkWgywQZrJa1X5XEK/atpeQMZOWs=;
	h=From:Subject:Date:To:Cc:From;
	b=ND+XyeZixhdDEuRUAVFev0uvN+B2S9YJC2oGM7YgMiR0nSJZteTOfwnuamLibA/Tc
	 RaxupNx51fnHfTOQGN3S4IaVgL9e8GA93AadqixI2zGmAam4115oo3yD3js9zHI5n1
	 o9QrvtqKDpnV5uhMiICZdiT8+SLY7wWaVlfuH2PRynev6pbz2MbbeKPoTy5QZLhLWq
	 iGPoRwJBeGTOvSM5V8Wa9jGcpIa2I+Io6fbc1USweg1xmRUBcheobBKg0vdvezKn+p
	 5/0qY5amZdv6Z8+Hbkt73jnHPNf57H6XntuZ5ql03dUVBhDSynpa6JkUvJ8wkv/lgd
	 QHBQHzHgbaN0A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/10] Implement freeze and thaw as holder operations
Date: Tue, 24 Oct 2023 15:01:06 +0200
Message-Id: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPAN2UC/32NQQ6CMBBFr0K6dkgpWoMr72FYtGUKjaaQGW1U0
 rtbOIDLl/z3/ioYKSCLS7UKwhQ4zLGAOlTCTSaOCGEoLJRUrezUGZJn4NeCBJ4QvwjovT5Jr7W
 VWhRtIfThvSdvfWFrGMGSiW7aQsWvd3/bToGfM33299Rsxp+j1IAEdK7VQ2fsceiud6SIj3qmU
 fQ55x+zKW4hzQAAAA==
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vj6lmWbcnOTpI0tTkWgywQZrJa1X5XEK/atpeQMZOWs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3Q4eFQgfHZXkJZl2k/TlWlTZ26ZcEh/V19Ss3Tk1rOB
 FrtOd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwEeG/1lr19Tp37qs/mrHs2ec0/
 PsJa/VxcpM6Lfyn8TzooVJ3Irhn+pOM9mw2Tu8pY5uiX5z4Kuu0MQof/kDQVPe5wQ+V/2hxQoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey Christoph,
Hey Jan,
Hey Darrick,

This is v2 and based on vfs.super. I'm sending this out right now
because frankly, shortly before the merge window is the time when I have
time to do something. Otherwise, I would've waited a bit.

This implements block device freezing and thawing as holder operations.

This allows us to extend block device freezing to all devices associated
with a superblock and not just the main device.

It also allows us to remove get_active_super() and thus another function
that scans the global list of superblocks.

Freezing via additional block devices only works if the filesystem
chooses to use @fs_holder_ops for these additional devices as well. That
currently only includes ext4 and xfs.

Earlier releases switched get_tree_bdev() and mount_bdev() to use
@fs_holder_ops. The remaining nilfs2 open-coded version of mount_bdev()
has been converted to rely on @fs_holder_ops as well. So block device
freezing for the main block device will continue to work as before.

There should be no regressions in functionality. The only special case
is btrfs where block device freezing for the main block device never
worked because sb->s_bdev isn't set. Block device freezing for btrfs can
be fixed once they can switch to @fs_holder_ops but that can happen
whenever they're ready.

This survives

(1) xfstests: check -g quick
(2) xfstests: check -g freeze
(3) blktests: check

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>

Changes in v2:
- Call sync_blockdev() consistently under bd_holder_lock.
- Return early with error in fs_bdev_freeze() if we can't get an active
  reference and don't call sync_blockdev().
- Keep bd_fsfreeze_mutex now that we don't hold bd_holder_lock over
  freeze and thaw anymore.
- Link to v1: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org

---



---
base-commit: 79ac81458fb58e1bac836450d6c68da1da9911d9
change-id: 20230927-vfs-super-freeze-eff650f66b06


