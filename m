Return-Path: <linux-fsdevel+bounces-72321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38744CEEC57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 15:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2473012BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F732066F7;
	Fri,  2 Jan 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeWAMy7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF41C28E;
	Fri,  2 Jan 2026 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364591; cv=none; b=tTaRw8x9VH5jse4eT1q15f1eN3CACUC+RVBhIhdXxCFT2kULPTSku5cT7ixSd5TnyCToBh5mDDK5SaKZhqFqkGUNMGCvJJRQFIS/uWIBhh5GnBqDWZ6hqio8juwQby+EQ3P4IQYa78IrPZjm0T1h6CjMkyJJ1xSYoilBeDg+lf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364591; c=relaxed/simple;
	bh=AxgCvUCXpz4dxbXlHvTuGbgKdJAoi4s5xk5t0+E3TEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VyCcYiw2pxqOfsL8PLXVvg/FumcLDRK6k65P2RxGMIkTBl0rza19Mdnnw1P6jBHJWW7T3xB4f7imbF+chpxEzPrj9O2LZ4HD3r081PunBZ/WiEtPdZaHJCOq0/lDQgfJd6WMm+Bg8/RcB0x6m++ck8gh1TFB96e9Q6SD41FEKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeWAMy7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABA0C116B1;
	Fri,  2 Jan 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767364591;
	bh=AxgCvUCXpz4dxbXlHvTuGbgKdJAoi4s5xk5t0+E3TEE=;
	h=From:Subject:Date:To:Cc:From;
	b=GeWAMy7TIfz+igZ5IujH0Pni3gtoSGvzfVW8UQUGOD8MJQfltBg362ObmyxEuV7vA
	 BmU5Hpe9VFgRNbocGYMpbmTiGC6rvmIoeIJf+djNFt7X/hmzWZvEdBGCP3yDGyOsl5
	 2Wf0968lxHw9zl3tdRWJNv+u9/BmSnThB0DgQvcu8xo8rSHvBFsFFFmALcxTD8kE8w
	 /wzGpBxGPlWejOfezY4sC5jPSFxSchH2L7fS6N96729zkN3VBww/tCYjvdr3DBkZUS
	 hRloBQ4sesNCKst49bXBcE6fAAnOlKEJfo0L5PgO/JwWcoQA9bcr/oeJliJ0q6s6p/
	 UfpqY8DdRKYiA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] fs: add immutable rootfs and support pivot_root() in
 the initramfs
Date: Fri, 02 Jan 2026 15:36:21 +0100
Message-Id: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOXXV2kC/x3MQQ7CIBBA0as0s3YawLRGr2JcAA52ohQzg9Wk6
 d1Fl2/x/wpKwqRw6lYQWli5zA1210Gc/Hwj5GszOONGY43Dd5E7cs6v6sODUEqpSTEMye3JpMG
 7A7T2KZT48/+eL83BK2EQP8fpd8teK0m/jL09okQL2/YFdBFovIoAAAA=
X-Change-ID: 20260102-work-immutable-rootfs-b5f23e0f5a27
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AxgCvUCXpz4dxbXlHvTuGbgKdJAoi4s5xk5t0+E3TEE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSGX3+jfPd0Ru6zh73SP/9ayt0RWhpT2nDu/AfnYquXy
 4tbUqM/dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEaBLDX9nfhv83/ew6tU/G
 7Yu11JZdHp/j+BXXifrZqnEdjZoiVsHwz+rU4hCp/olu8936J7lMrPTNnfxONjkhKWhOttz8ey/
 uMAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently pivot_root() doesnt't work on the real rootfs because it
cannot be unmounted. Userspace has to do a recursive removal of the
initramfs contents manually before continuing the boot.

Really all we want from the real rootfs is to serve as the parent mount
for anything that is actually useful such as the tmpfs or ramfs for
initramfs unpacking or the rootfs itself. There's no need for the real
rootfs to actually be anything meaningful or useful. Add a immutable
rootfs that can be selected via the "immutable_rootfs" kernel command
line option.

The kernel will mount a tmpfs/ramfs on top of it, unpack the initramfs
and fire up userspace which mounts the rootfs and can then just do:

  chdir(rootfs);
  pivot_root(".", ".");
  umount2(".", MNT_DETACH);

and be done with it. (Ofc, userspace can also choose to retain the
initramfs contents by using something like pivot_root(".", "/initramfs")
without unmounting it.)

Technically this also means that the rootfs mount in unprivileged
namespaces doesn't need to become MNT_LOCKED anymore as it's guaranteed
that the immutable rootfs remains permanently empty so there cannot be
anything revealed by unmounting the covering mount.

In the future this will also allow us to create completely empty mount
namespaces without risking to leak anything.

systemd already handles this all correctly as it tries to pivot_root()
first and falls back to MS_MOVE only when that fails.

This goes back to various discussion in previous years and a LPC 2024
presentation about this very topic.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      fs: ensure that internal tmpfs mount gets mount id zero
      fs: add init_pivot_root()
      fs: add immutable rootfs

 fs/Makefile                   |   2 +-
 fs/init.c                     |  17 ++++
 fs/internal.h                 |   1 +
 fs/mount.h                    |   1 +
 fs/namespace.c                | 181 +++++++++++++++++++++++++++++-------------
 fs/rootfs.c                   |  65 +++++++++++++++
 include/linux/init_syscalls.h |   1 +
 include/uapi/linux/magic.h    |   1 +
 init/do_mounts.c              |  13 ++-
 init/do_mounts.h              |   1 +
 10 files changed, 223 insertions(+), 60 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260102-work-immutable-rootfs-b5f23e0f5a27


