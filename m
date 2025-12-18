Return-Path: <linux-fsdevel+bounces-71589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 846DFCCA090
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BCDF30237A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8EC2750ED;
	Thu, 18 Dec 2025 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+j1uXJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966BF1D5CD4;
	Thu, 18 Dec 2025 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023365; cv=none; b=tPPBp7x9tMWZRMejqz4+KUX6q1dxL491J9m0jEtRuE6H5L78H1bnV5alcISc4HzHC5iAphwfovhHsZfc9zk97vsjvgRvMpfmWtLpnwW+NRTz75Wo+W4vuFQI1Wi0OsUFAG0jX8CC4EPSRAZ1zWAL+Dvw3vX4hp3+DfufN3137b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023365; c=relaxed/simple;
	bh=u76OWdWN5eeNBkvlN2MC7QTcfUrXbEvUqPLzjrIxIdQ=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=KNHL9vw//uCuGYKRdfjVWukXCxTbfMrWYnyTDgfMbegdYm8mfXV21VDkUR7rK4CMRTSfrJySclklCgb7HXYwfqHPCu5nQBiGF6cqQFFKGtSTRyVrlfLtT2OUzF+4ezf2m30t7m4i8OTuOXa6j103bl+8imBK/C203gNblIMgkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+j1uXJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185CAC116B1;
	Thu, 18 Dec 2025 02:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023365;
	bh=u76OWdWN5eeNBkvlN2MC7QTcfUrXbEvUqPLzjrIxIdQ=;
	h=Date:Subject:From:To:Cc:From;
	b=p+j1uXJMSevQnBN9YQCxDFxiW3b9URZnH3oHaYi6tA8aRxPrMUFiZN8dB5g8KTaxJ
	 g4idxaHWo6DFhmLnlXk/cbandUV2vYdoVUUa5o/3RoFUhnsSfSy0ycil2QNzn/54yh
	 aEy0Gui8Vno5cTq9dltljvgwSLYKD4ZQZhAPFGN0yHQKVGX1q1EPE0t8LZ3N9+y4Pf
	 emy6y270WMS2NFOzcwSgQM/bUMagTcUpgk8zC68g3ZXosLDI9z7St/QX1Ec5/I/b6U
	 yfKGB3C1zIGRxtOGV2bGyFu8YrqGZ4tJhFOGu513jPnCU+BUI7cDgpJzd1fj25Hw1B
	 puwQqWIJSWeig==
Date: Wed, 17 Dec 2025 18:02:44 -0800
Subject: [PATCHSET V4 1/2] fs: generic file IO error reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-api@vger.kernel.org, hch@lst.de, linux-ext4@vger.kernel.org,
 jack@suse.cz, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Message-ID: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset adds some generic helpers so that filesystems can report
errors to fsnotify in a standard way.  Then it adapts iomap to use the
generic helpers so that any iomap-enabled filesystem can report I/O
errors through this mechanism as well.  Finally, it makes XFS report
metadata errors through this mechanism in much the same way that ext4
does now.

These are a prerequisite for the XFS self-healing V4 series which will
come at a later time.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=filesystem-error-reporting

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=filesystem-error-reporting
---
Commits in this patchset:
 * uapi: promote EFSCORRUPTED and EUCLEAN to errno.h
 * fs: report filesystem and file I/O errors to fsnotify
 * iomap: report file I/O errors to the VFS
 * xfs: report fs metadata errors via fsnotify
 * xfs: translate fsdax media errors into file "data lost" errors when convenient
 * ext4: convert to new fserror helpers
---
 arch/alpha/include/uapi/asm/errno.h        |    2 
 arch/mips/include/uapi/asm/errno.h         |    2 
 arch/parisc/include/uapi/asm/errno.h       |    2 
 arch/sparc/include/uapi/asm/errno.h        |    2 
 fs/erofs/internal.h                        |    2 
 fs/ext2/ext2.h                             |    1 
 fs/ext4/ext4.h                             |    3 -
 fs/f2fs/f2fs.h                             |    3 -
 fs/minix/minix.h                           |    2 
 fs/udf/udf_sb.h                            |    2 
 fs/xfs/xfs_linux.h                         |    2 
 include/linux/fs/super_types.h             |    7 +
 include/linux/fserror.h                    |   93 ++++++++++++++++
 include/linux/jbd2.h                       |    3 -
 include/uapi/asm-generic/errno.h           |    2 
 tools/arch/alpha/include/uapi/asm/errno.h  |    2 
 tools/arch/mips/include/uapi/asm/errno.h   |    2 
 tools/arch/parisc/include/uapi/asm/errno.h |    2 
 tools/arch/sparc/include/uapi/asm/errno.h  |    2 
 tools/include/uapi/asm-generic/errno.h     |    2 
 fs/Makefile                                |    2 
 fs/ext4/ioctl.c                            |    2 
 fs/ext4/super.c                            |   13 ++
 fs/fserror.c                               |  168 ++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c                     |   23 ++++
 fs/iomap/direct-io.c                       |   12 ++
 fs/iomap/ioend.c                           |    6 +
 fs/super.c                                 |    3 +
 fs/xfs/xfs_fsops.c                         |    4 +
 fs/xfs/xfs_health.c                        |   14 ++
 fs/xfs/xfs_notify_failure.c                |    4 +
 31 files changed, 365 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/fserror.h
 create mode 100644 fs/fserror.c


