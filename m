Return-Path: <linux-fsdevel+bounces-23617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4792FC0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 16:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A501F22622
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF11171075;
	Fri, 12 Jul 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNsE5ps2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A115DBAE;
	Fri, 12 Jul 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793033; cv=none; b=nb9eX1na2aBvF5tQ5fBUID1dda2FOSDFI3V7qQpqMK5S+v2vbSP6V8vEJwwB9nx6kbNXtYnh1gd+FszJYJl9CjGEovWWdzOHaIz8ZQit/JCDJ0T94+fHrw25M37DhyQwadN2DH4d1+DlPNLMeFQhraAzxFd8iv7nbmRXKasYYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793033; c=relaxed/simple;
	bh=ZXBFAQVGEFkiwbLpGmCzm7NLMrH0l+RFmgkXOlXjIGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mb9P3oE3EMDrcy2IGGhDy+owIksEBfLHpVB4S5pGkfZveDRRZTRWBucd8JgTnPMZJDWFO9CN9Gh4IMMPs85YDpNqZfLjwkhunNcgsoazIjV76AKa/COsZ41D6dgU9dreOfeXwr2cixduHFlbOpZp8+/6Xg+GZL/Ri6/VRlQvDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNsE5ps2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DC9C4AF0F;
	Fri, 12 Jul 2024 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793033;
	bh=ZXBFAQVGEFkiwbLpGmCzm7NLMrH0l+RFmgkXOlXjIGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SNsE5ps2OZbMF4IjH2zUu7zT4EU4xz+gTMmwpHeumrzriBEDBpLDw62kZiDiMn0l4
	 L6xpxae9Y1vTp8DVU9hgHlumjsIPdrCMeYRQrMuuOHqd1I5B13Pxr4dLkqBcTYQ+Rn
	 OvHxTfqlKQHR8uYzFnOlFKKyZvL8saqP9Gqpi3rLFPgBwG4DECNKlJ+2oq0kGN33Oi
	 bOA2vGjUAA3/lb2Ode/LLMVjxwR/Lyx4smQu6xklqLcSCJ+bCbUJeLlQpLGrkj5FmN
	 RFwTjrMIMZ7TY74ubHN86w3Z8Gi4vRhT0N9Z+8Y1WTsjM5poZmx2oQMAmbe86pAwcD
	 sY97O2eX2JMIQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs iomap
Date: Fri, 12 Jul 2024 16:03:24 +0200
Message-ID: <20240712-vfs-iomap-8b6a04cb891d@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450; i=brauner@kernel.org; h=from:subject:message-id; bh=ZXBFAQVGEFkiwbLpGmCzm7NLMrH0l+RFmgkXOlXjIGQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNN8/tfrXJT/xB9/rZ33J+lIx75+Q9GMRV/VsoedPD s2vKMr711HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRswoM/8x8HY4bO6b3mXbf 3/7vsH/IqX2+cRf3dL1cI23etdTWq5aR4ePdmhVFbu3t4YenyoYlfQ7kWnv6eMratfLch476HKz NZAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains some minor work for the iomap subsystem:

- Add documentaiton on the design of iomap and how to port to it.

- Optimize iomap_read_folio().

- Bring back the change to iomap_write_end() to no increase i_size. This is
  accompanied by a change to xfs to reserve blocks for truncating large
  realtime inodes to avoid exposing stale data when iomap_write_end()
  stops increasing i_size.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc4 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.iomap

for you to fetch changes up to 602f09f4029c7b5e1a2f44a7651ac8922a904a1b:

  iomap: don't increase i_size in iomap_write_end() (2024-06-19 15:58:28 +0200)

Please consider pulling these changes from the signed vfs-6.11.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.iomap

----------------------------------------------------------------
Darrick J. Wong (1):
      Documentation: the design of iomap and how to port

Ritesh Harjani (IBM) (1):
      iomap: Optimize iomap_read_folio

Zhang Yi (2):
      xfs: reserve blocks for truncating large realtime inode
      iomap: don't increase i_size in iomap_write_end()

 Documentation/filesystems/index.rst            |   1 +
 Documentation/filesystems/iomap/design.rst     | 441 +++++++++++++++
 Documentation/filesystems/iomap/index.rst      |  13 +
 Documentation/filesystems/iomap/operations.rst | 713 +++++++++++++++++++++++++
 Documentation/filesystems/iomap/porting.rst    | 120 +++++
 MAINTAINERS                                    |   1 +
 fs/iomap/buffered-io.c                         |  73 ++-
 fs/xfs/xfs_iops.c                              |  15 +-
 8 files changed, 1351 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/filesystems/iomap/design.rst
 create mode 100644 Documentation/filesystems/iomap/index.rst
 create mode 100644 Documentation/filesystems/iomap/operations.rst
 create mode 100644 Documentation/filesystems/iomap/porting.rst

