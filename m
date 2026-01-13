Return-Path: <linux-fsdevel+bounces-73336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A45CCD1609B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE213044C19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893321D3C5;
	Tue, 13 Jan 2026 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqNzNFuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED322D4C3;
	Tue, 13 Jan 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264264; cv=none; b=XzoTefZTxPqsiSay9zywqJGFHOcHFk8W7osQolnUJObpjLrBuzirSZLqzfBbW3D25So6c7fURPKnKiGv3LlZ3Tod7b4F+Qewo+s1DY959rzZj/8efqWDjl2Ejj4NfDUfj+YX0GOU6MAltkB38UiXETVtT1NaeL7H3o3KHc/44pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264264; c=relaxed/simple;
	bh=DoVnohM3KBF8iAxZ57g2+ikEUZiTeD/SvaJUOQDGUb0=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=r+H/VRzzInPfwhN4mBBT+dmvIEaQRc35dpTr3Ody86V9l3QkaU8cjjVGC7Q4H+xlSxmOGYN+N+MmetpxcB0HkVNEGtCpYU7LG+uvWurppKYRF+mt8g3P569M+A+hjMHaToMHwh4riyN5UjBIaHkEBJwRyKVdYeaN7gNavLL2Ujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqNzNFuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D196C19421;
	Tue, 13 Jan 2026 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264264;
	bh=DoVnohM3KBF8iAxZ57g2+ikEUZiTeD/SvaJUOQDGUb0=;
	h=Date:Subject:From:To:Cc:From;
	b=hqNzNFuMthw4J+yzmREuEB3Gwe2OlW3IN5iINtmqtdwl2zGwmu4UPvB85KVzPty6S
	 pqTDsuxyxNTRg9nixgpOm212BlTPwON0o4SLqm0nLkLiHwGHXQrP0YV80gMzPZjlDm
	 i900BBAew1SrCI/hPT2WotSWIcZuNnVNDGfgS4mRRvGGjP5BlDXf+KOL4m0TQzRzM1
	 adGcyi+BasBoDNiiSsss5+4xZOZwM9aPTik8QZ19kRXEeXbssPHoCeBmIzksGfuPNZ
	 ldzbGUmf2rNu1bJp1I9g2w7raKnfXBouVD4jk5c6Oum0ItoVwJR8mAcbDPDJwVwOlB
	 iwZgbbQsiUTiA==
Date: Mon, 12 Jan 2026 16:31:03 -0800
Subject: [PATCHSET v5] fs: generic file IO error reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: linux-api@vger.kernel.org, jack@suse.cz, hch@lst.de,
 hsiangkao@linux.alibaba.com, linux-xfs@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Message-ID: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
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

These are a prerequisite for the XFS self-healing series which will
come at a later time.

v5: tidy comments, un-inline the unmount function
v4: drag out of RFC status, finalize the sign of errnos that we accept

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
 fs/ext4/ext4.h                             |    3 
 fs/f2fs/f2fs.h                             |    3 
 fs/minix/minix.h                           |    2 
 fs/udf/udf_sb.h                            |    2 
 fs/xfs/xfs_linux.h                         |    2 
 include/linux/fs/super_types.h             |    7 +
 include/linux/fserror.h                    |   75 +++++++++++
 include/linux/jbd2.h                       |    3 
 include/uapi/asm-generic/errno.h           |    2 
 tools/arch/alpha/include/uapi/asm/errno.h  |    2 
 tools/arch/mips/include/uapi/asm/errno.h   |    2 
 tools/arch/parisc/include/uapi/asm/errno.h |    2 
 tools/arch/sparc/include/uapi/asm/errno.h  |    2 
 tools/include/uapi/asm-generic/errno.h     |    2 
 fs/Makefile                                |    2 
 fs/ext4/ioctl.c                            |    2 
 fs/ext4/super.c                            |   13 +-
 fs/fserror.c                               |  194 ++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c                     |   23 +++
 fs/iomap/direct-io.c                       |   12 ++
 fs/iomap/ioend.c                           |    6 +
 fs/super.c                                 |    3 
 fs/xfs/xfs_fsops.c                         |    4 +
 fs/xfs/xfs_health.c                        |   14 ++
 fs/xfs/xfs_notify_failure.c                |    4 +
 31 files changed, 373 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/fserror.h
 create mode 100644 fs/fserror.c


