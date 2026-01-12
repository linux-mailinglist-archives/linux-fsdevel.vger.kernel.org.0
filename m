Return-Path: <linux-fsdevel+bounces-73268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7540AD13D70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63110303ABDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB7345CDF;
	Mon, 12 Jan 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YydbnGqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E1266581;
	Mon, 12 Jan 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232840; cv=none; b=nbKCbjGqTqd8SwHMQ/OWywTDnF35/Xji9VI9u6BppsRZ5DMYnUKiK/H0VW6jYBgbK579rGSvmYmPRvuoQjV+5rjeNUXdHh7uTavS72ENRRaaCBO9//vBnczRzLskQtkjIMhs2nWSu4JYRJy3cfgK9cbP0uij/BHkcqvRRPM4Y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232840; c=relaxed/simple;
	bh=LvO60yDzjyxVBqGNXihhd8BocpvRUQMWP1sY/h4+IXM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YVhxvmCn6364HTQy9Rg7Jq8pnmXGHXf49bmsSSR/xnOMBN2/uk782GBr7ZuwIpIRKeLoEvTutNl0IVwpOvg6Pod5oSa2l1Sdu0vOcBNKUD8fVdzLODRJsHnFz1L9pF+C6jL5YHOurQq6Mpho3kphaif91X8ETqU2kQEZevKAbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YydbnGqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7668C19422;
	Mon, 12 Jan 2026 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232839;
	bh=LvO60yDzjyxVBqGNXihhd8BocpvRUQMWP1sY/h4+IXM=;
	h=From:Subject:Date:To:Cc:From;
	b=YydbnGqqxQHGhJt7YTdzTYqsBJuJYOyBtRONDTDRIyxLPJVMxU8ht6RDZfOI2TdSa
	 otGVKclF36RmNos507GYHZm6SwFg/L4mtC1d3N2JDzr8LBLZGquT/scMEFXuW4SX3f
	 UW0KynmU+K4hYHVFBz53mu51KMANM+3VRQUnE6+RAHh8BmdSQWDgKZcoVrnoPhcl+j
	 pHuWqCemrKR1L9TNBUsTNbX1vYM8GXCdTbaKfKon+/qAFlIELXH+fZmcTEfgHoroAN
	 cyyfegEBMoivJZ4AqgGRN+RSZmiqK1tTKgcYecfephjIaKywc9tQaKxUZVoA2R8Dbw
	 RV51zR0mcKRNQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/4] fs: add immutable rootfs
Date: Mon, 12 Jan 2026 16:47:07 +0100
Message-Id: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsXZWkC/4WOQQ6CMBBFr0K6dkg7BIiuvIdh0cIUGqA1U0QN4
 e4WLuDyLd77fxOR2FEUt2wTTKuLLvgEeMlEO2jfE7gusUCJlVQS4R14BDfPr0WbiYBDWGwEU1o
 sSNpSYy2S+2Sy7nN2H01ioyOBYe3b4ajNOi7E+Vrl6grcqkMZXFwCf88nqzrEf6OrAgkWZV0Y7
 FQl8T4Se5rywL1o9n3/AVJBBj7eAAAA
X-Change-ID: 20260102-work-immutable-rootfs-b5f23e0f5a27
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LvO60yDzjyxVBqGNXihhd8BocpvRUQMWP1sY/h4+IXM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmirf6Vsl/vnFw/8Zvq3rCd7769P/Fo2NWyxRETdWvx
 9gWzPzg3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAROSlGhvnsj7MVLR/uytMX
 rdjbtaX+eMPZs9NnRBwvjn6W1XJsxTFGhh9qOxm/7rF898/73s8Hcy/lHNhrJ3i8T+p+VUnGsn6
 h99wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently pivot_root() doesn't work on the real rootfs because it
cannot be unmounted. Userspace has to do a recursive removal of the
initramfs contents manually before continuing the boot.

Really all we want from the real rootfs is to serve as the parent mount
for anything that is actually useful such as the tmpfs or ramfs for
initramfs unpacking or the rootfs itself. There's no need for the real
rootfs to actually be anything meaningful or useful. Add a immutable
rootfs called "nullfs" that can be selected via the "nullfs_rootfs"
kernel command line option.

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

Now in vfs-7.0.nullfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Rename to "nullfs".
- Update documentation.
- Link to v1: https://patch.msgid.link/20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org

---
Christian Brauner (4):
      fs: ensure that internal tmpfs mount gets mount id zero
      fs: add init_pivot_root()
      fs: add immutable rootfs
      docs: mention nullfs

 .../filesystems/ramfs-rootfs-initramfs.rst         |  32 +++-
 fs/Makefile                                        |   2 +-
 fs/init.c                                          |  17 ++
 fs/internal.h                                      |   1 +
 fs/mount.h                                         |   1 +
 fs/namespace.c                                     | 181 ++++++++++++++-------
 fs/nullfs.c                                        |  70 ++++++++
 include/linux/init_syscalls.h                      |   1 +
 include/uapi/linux/magic.h                         |   1 +
 init/do_mounts.c                                   |  14 ++
 init/do_mounts.h                                   |   1 +
 11 files changed, 254 insertions(+), 67 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260102-work-immutable-rootfs-b5f23e0f5a27


