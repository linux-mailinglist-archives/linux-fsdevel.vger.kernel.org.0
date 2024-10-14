Return-Path: <linux-fsdevel+bounces-31867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFB399C5FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152572863C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8F15990E;
	Mon, 14 Oct 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0mnqt8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96D15852E;
	Mon, 14 Oct 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898868; cv=none; b=u9W1tDSjvz5FgQO1Zv99YmIiXBeIUBL2hGHjn43+S2oLbJwCr5TcNeUzCOlLILMHNYOgGkRes1Lilvb1c+hWHsoLbmT3+GkY/5tcrVNs70rkW4cXbImMFb70yiyJNaiZKv7we7Mq3OIlU30vYQzsTUqOlUcUK9cjjIkQUOOot9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898868; c=relaxed/simple;
	bh=ovamm8oTH0n34MwRCAL67cOIII8Ui+4Ioy2CcJA6g98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EWGQf9AXYCfXVkZWQvjIXdBUn/8RoGvTlLO39EqZ7iKjttevM4RK0aVnUJxr7pHeDzq5j+uf5DY5hX4lH1XaFgtK5PHCnjQtcUV2nNcyojyWd2PxOlX/5AcAppFuICjZxfsKQDV2rtjW5f9/trxcz2PqWxNWCMpiyCMsN6UPgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0mnqt8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E99BC4CECE;
	Mon, 14 Oct 2024 09:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898867;
	bh=ovamm8oTH0n34MwRCAL67cOIII8Ui+4Ioy2CcJA6g98=;
	h=From:Subject:Date:To:Cc:From;
	b=d0mnqt8iz5qRga9i88TqH01vCZG/77CJwZCIMFiiPyP0tSV3sfLeaKitzX1M2YbtG
	 M10/abR1eJ46B3dP2F7O2m+WWwRFR0ZnOGse+Nq4ACErJ+iSZymO/znW2C7mMRFQYa
	 Jbch/SsrkxmKFdIJKpvW96JQ+FZYSGFxmqvXv7AzCOdLOFZXNsBJAioQxobYm22tji
	 Bhjg6wpz7mKPKnQEZP/bVEOMWvc4yAOJ0SOJegyMXyO31IObvQJk6pjMjZb7+bYbna
	 qX7LGobMwkfmuBkggF9N7cpZhzyac9YRZ2VBRKANchVHnXBG6LWZwoLaHqJ+FNEm12
	 js+K+yK13rcVw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/5] ovl: file descriptors based layer setup
Date: Mon, 14 Oct 2024 11:40:55 +0200
Message-Id: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfnDGcC/33OwQ7CIBAE0F8xnKXpLqjVk/9hPADdtkQtZjGoa
 frvQm8e9DiHNzOTiMSeojisJsGUfPRhzEGtV8INZuxJ+jZngTVqqAHkM/BFhkR8Ne8uyta6zuw
 RFTU7kdGdqfOvpfB0ztmaSNKyGd1Qam4mPoirtK0AJTssZPDxEfi9XEhQ4M+1BLKWpDRq1WjA3
 f54IR7pWgXuRZlL+N9j9mC1Uti4jVHw5ed5/gArNdxGEAEAAA==
X-Change-ID: 20241011-work-overlayfs-dbcfa9223e87
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ovamm8oTH0n34MwRCAL67cOIII8Ui+4Ioy2CcJA6g98=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzPDe85262f+Elq8Wzz4qt1Vz4f/XpSvUHS+ckmy4yT
 jz+N521saOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAixVMY/rtkan+Mc9bmkfl1
 RNHBcirTzMke30K1uzTeHXtmyszvtY2R4X77rAn1022c41N8zz4oveUksXhLutBRFvl/azrPmvz
 ezgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Currently overlayfs only allows specifying layers through path names.
This is inconvenient for users such as systemd that want to assemble an
overlayfs mount purely based on file descriptors.

When porting overlayfs to the new mount api I already mentioned this.
This enables user to specify both:

     fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper);
     fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work);
     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);

in addition to:

     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper",  0);
     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",   0);
     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1", 0);
     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2", 0);

The selftest contains an example for this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Add documentation into overlayfs.rst.
- Rename new mount api parsing helper.
- Change cleanup scope in helper.
- Link to v2: https://lore.kernel.org/r/20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org

Changes in v2:
- Alias fd and path based mount options.
- Link to v1: https://lore.kernel.org/r/20241011-work-overlayfs-v1-0-e34243841279@kernel.org

---
Christian Brauner (5):
      fs: add helper to use mount option as path or fd
      ovl: specify layers via file descriptors
      Documentation,ovl: document new file descriptor based layers
      selftests: use shared header
      selftests: add overlayfs fd mounting selftests

 Documentation/filesystems/overlayfs.rst            |  17 +++
 fs/fs_parser.c                                     |  20 +++
 fs/overlayfs/params.c                              | 116 ++++++++++++----
 include/linux/fs_parser.h                          |   5 +-
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   2 +-
 .../selftests/filesystems/overlayfs/dev_in_maps.c  |  27 +---
 .../filesystems/overlayfs/set_layers_via_fds.c     | 152 +++++++++++++++++++++
 .../selftests/filesystems/overlayfs/wrappers.h     |  47 +++++++
 9 files changed, 334 insertions(+), 53 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241011-work-overlayfs-dbcfa9223e87


