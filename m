Return-Path: <linux-fsdevel+bounces-44795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101ABA6CC4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D77F189ADE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9402356C2;
	Sat, 22 Mar 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ++w9SX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773C175A5;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675715; cv=none; b=MTtLzQtlJnRczJxYtCDQrcJgM5pquTD1QQ9wtGtVGBIH0geirZZNDgbwQI8ZeQrcAXRFqgX5OUBEamt316f4tzI6irHv5BU2fLxzHe09i5TdCulnSCcyJJcwfdeYi9c0bf1kkI+2xsmMP9D67R73jLLQbcv5t4Bz4Kr9b7/VIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675715; c=relaxed/simple;
	bh=BqYZpH0UiavMMal11keGKaBoUo5bpmMxlDCKzw1Ly2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lynbLDAKBtu1HuIWAbYHLjfDwB2d0evv8/mCizNRm0dt6r0meSJ9E/ZuDywJVGf7w1MA6hVsUtIIhoMwLNWANdairT0QVTZRo8MmQNQ294NGQ4joOj5zise7UcfV2vAe2GHb1B34R/ZPFN8B1kIwTPVgHmTsH7orhTxRuRGAUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ++w9SX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2746C4CEDD;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=BqYZpH0UiavMMal11keGKaBoUo5bpmMxlDCKzw1Ly2A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qQ++w9SX0vNEnL3vYRfbiKR/Qvu+jnUraHP5nquD/6swnBVQDCpp2hj/woU7KuZoh
	 wuVt3Ke2ZH8Ds91dEQauJzAwPkdoJnpL88ZA0KwkcQSkHyTbMe+U/Of3tSvD8HGGHq
	 cGsh/9sxcNGAqBNcNGX/hdj+xmTKLE0tm4xyZffpSrOCkWUzNf6uWpQMr5L3xy8mmj
	 tvYS4Tg1la07G7WRq8kAkCiRNe/ls9A8LsZ2l4rWgRd+/kyBLbECuSqVYCYCF4JsB0
	 /UK1sIOW4FKckBqjmvABIaYgwWYD+Ys75voiqE1sjdJmMGRMbF1ul9f16/xWGnJDuw
	 2TWXyLYJcjZ6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C0EC35FFC;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Subject: [PATCH v2 0/9] initrd: cleanup and erofs support
Date: Sat, 22 Mar 2025 21:34:12 +0100
Message-Id: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQe32cC/3XMQQ6CMBCF4auQWTsGiiC48h6GBW2nMIlpzRSJh
 PTuVvYu/5e8b4dIwhThVuwgtHLk4HOoUwFmHv1EyDY3qFI1Za1KZM+LWCQJLuK1pV41zrq2M5A
 vLyHHn4N7DLlnjkuQ7dDX6rf+gdYKK6wbrbXq60vbjXezaZJ3xIXM7MMzTNvZEgwppS8JgT30t
 AAAAA==
X-Change-ID: 20250320-initrd-erofs-76e925fdf68c
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
 Niklas Sturm <niklas.sturm@secunet.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675712; l=3257;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=BqYZpH0UiavMMal11keGKaBoUo5bpmMxlDCKzw1Ly2A=;
 b=/HaQH4dsGXfsHwAm/6oa8WAEYcLbW08CzgyyRCZ+LZG0q+uisaMe5G6LQ3QXxCEgqyOGnYwUU
 nkvDSuyxtGkAdFImX7HqJ4sntWriaHu7HcpiTN7J586G3+Di7DiIDBv
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

On my journey towards adding erofs support for initrd, Al Viro
suggested to move the filesystem detection code into the respective
filesystem modules. This patch series implements this, while also
adding erofs support.

To achieve this, I added a macro initrd_fs_detect() that allows
filesystem modules to add a filesystem detection hooks. I then moved
all existing filesystem detection code to this new API. While I was
there I also tried to clean up some of the code.

I've tested these changes with the following kinds of initrd
images:

- ext2
- Minix v1
- cramfs (padded/unpadded)
- romfs
- squashfs
- erofs

initrds are still relevant, because they have some advantages over
initramfs. They don't require unpacking all files before starting the
init process and allows them to stay compressed in memory. They also
allow using advanced file system features, such as extended
attributes. In the NixOS community, we are heavy users of erofs, due
to its sweet spot of compression, speed and features.

That being said, I'm totally in favor of cutting down the supported
filesystems for initrd and further simplify the code. I would be
surprised, if anyone is using ext2 or Minix v1 filesystems (64 MiB
filesystem size limit!) or cramfs (16 MiB file size limit!) as an
initrd these days! Squashfs and erofs seem genuinely useful, though.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
Changes in v2:
- Remove more legacy code
- Introduce initrd_fs_detect
- Move all other initrd filesystems to the new API
- Link to v1: https://lore.kernel.org/r/20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de

---
Julian Stecklina (9):
      initrd: remove ASCII spinner
      initrd: fix double fput for truncated ramdisks
      initrd: add a generic mechanism to add fs detectors
      fs: minix: register an initrd fs detector
      fs: cramfs: register an initrd fs detector
      fs: romfs: register an initrd fs detector
      fs: squashfs: register an initrd fs detector
      fs: ext2, ext4: register an initrd fs detector
      fs: erofs: register an initrd fs detector

 fs/cramfs/Makefile                |   5 ++
 fs/cramfs/initrd.c                |  41 +++++++++++++
 fs/erofs/Makefile                 |   5 ++
 fs/erofs/initrd.c                 |  19 ++++++
 fs/ext2/Makefile                  |   5 ++
 fs/ext2/initrd.c                  |  27 +++++++++
 fs/ext4/Makefile                  |   4 ++
 fs/minix/Makefile                 |   5 ++
 fs/minix/initrd.c                 |  23 +++++++
 fs/romfs/Makefile                 |   4 ++
 fs/romfs/initrd.c                 |  22 +++++++
 fs/squashfs/Makefile              |   5 ++
 fs/squashfs/initrd.c              |  23 +++++++
 include/asm-generic/vmlinux.lds.h |   6 ++
 include/linux/ext2_fs.h           |   9 ---
 include/linux/initrd.h            |  37 ++++++++++++
 init/do_mounts_rd.c               | 122 ++++++++------------------------------
 17 files changed, 257 insertions(+), 105 deletions(-)
---
base-commit: 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
change-id: 20250320-initrd-erofs-76e925fdf68c

Best regards,
-- 
Julian Stecklina <julian.stecklina@cyberus-technology.de>



