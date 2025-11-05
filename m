Return-Path: <linux-fsdevel+bounces-67022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B1C33833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0273B2B39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D609B23D7F2;
	Wed,  5 Nov 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSxHIbzd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752623ABB9;
	Wed,  5 Nov 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303690; cv=none; b=T++SGW/+HV5N8ELWYumAk5A0gkdcdGXLAHcmFLmURFAjmhS6RivlhzIbjXKuKR2nc9xlcww7WyxN9lLcw+ZogHJGzCZyrLKVG1oRH7chktxPwAZvMzBSytqve8A5BBFyIblfEWgG24SWDRSlUn0oZeh8S/PwWnEBB1ctzU7g65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303690; c=relaxed/simple;
	bh=a94+by3QXCVzfzjH4aRuXfqIG9EbvwPBWlfDD/+7nNw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1BqFmGjcdgxH2gFAlVT5S3jQi8W2OIef2PmbnP9/jDgaCt8dJrL17Xulf0ktMP5NoikCG6GYY6AQQ/Zxd825PudGKfKIfX3cdcIRceEg/vwygR31BECJcTGYcwDLLbGVwvO+1G+2vL3v4rgR3ap38bN5vriydHPDRw2d0MLKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSxHIbzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08811C4CEF7;
	Wed,  5 Nov 2025 00:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303690;
	bh=a94+by3QXCVzfzjH4aRuXfqIG9EbvwPBWlfDD/+7nNw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KSxHIbzdzdxnpHZV6iMkQOTOSkDRPYkaP+Xl5HR81Wa1EcuTYT3XCGdqATKlDEuYc
	 7nzF4Mbp8IpplbA1RJGAtCSv7EWTP+EXcjUnK3dO8IihTZtd8Tl04cUXUxlWygVecy
	 SDiBCcFKFaCgU3jTuvOzS1ZSbP1QGnnteP9jXo4pdmZElUWkYBV9oOVxYdinlcqD38
	 fNDANo2SFUY7gfO0sPDnM9+nHlY2oIU4BxhB2cWqitQuxyxvGgZ50eR373iZutcvIr
	 HeCMu885OGS1clrfmOCEpaSjQSTb0ePEF/D+b8W2aLuSxRA+9cwAr81BpF3cx6UTJD
	 dCYSzGfr4xgmA==
Date: Tue, 04 Nov 2025 16:48:09 -0800
Subject: [PATCHSET V3 1/2] xfs: autonomous self healing of filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
In-Reply-To: <20251105004649.GA196370@frogsfrogsfrogs>
References: <20251105004649.GA196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset builds new functionality to deliver live information about
filesystem health events to userspace.  This is done by creating an
anonymous file that can be read() for events by userspace programs.
Events are captured by hooking various parts of XFS and iomap so that
metadata health failures, file I/O errors, and major changes in
filesystem state (unmounts, shutdowns, etc.) can be observed by
programs.

When an event occurs, the hook functions queue an event object to each
event anonfd for later processing.  Programs must have CAP_SYS_ADMIN
to open the anonfd and there's a maximum event lag to prevent resource
overconsumption.  The events themselves can be read() from the anonfd
either as json objects for human readability, or as C structs for
daemons.

In userspace, we create a new daemon program that will read the event
objects and initiate repairs automatically.  This daemon is managed
entirely by systemd and will not block unmounting of the filesystem
unless repairs are ongoing.  It is autostarted via some udev rules.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=health-monitoring
---
Commits in this patchset:
 * docs: remove obsolete links in the xfs online repair documentation
 * docs: discuss autonomous self healing in the xfs online repair design doc
 * xfs: create debugfs uuid aliases
 * xfs: create hooks for monitoring health updates
 * xfs: create a filesystem shutdown hook
 * xfs: create hooks for media errors
 * iomap: report buffered read and write io errors to the filesystem
 * iomap: report directio read and write errors to callers
 * xfs: create file io error hooks
 * xfs: create a special file to pass filesystem health to userspace
 * xfs: create event queuing, formatting, and discovery infrastructure
 * xfs: report metadata health events through healthmon
 * xfs: report shutdown events through healthmon
 * xfs: report media errors through healthmon
 * xfs: report file io errors through healthmon
 * xfs: allow reconfiguration of the health monitoring device
 * xfs: validate fds against running healthmon
 * xfs: add media error reporting ioctl
 * xfs: send uevents when major filesystem events happen
 * xfs: merge health monitoring events when possible
 * xfs: restrict healthmon users further
 * xfs: charge healthmon event objects to the memcg of the listening process
---
 fs/iomap/internal.h                                |    2 
 fs/xfs/libxfs/xfs_fs.h                             |  171 ++
 fs/xfs/libxfs/xfs_health.h                         |   52 +
 fs/xfs/xfs_file.h                                  |   37 +
 fs/xfs/xfs_fsops.h                                 |   11 
 fs/xfs/xfs_healthmon.h                             |  108 +
 fs/xfs/xfs_linux.h                                 |    3 
 fs/xfs/xfs_mount.h                                 |   13 
 fs/xfs/xfs_notify_failure.h                        |   39 +
 fs/xfs/xfs_super.h                                 |   13 
 fs/xfs/xfs_trace.h                                 |  407 ++++++
 include/linux/fs.h                                 |    4 
 include/linux/iomap.h                              |    2 
 Documentation/filesystems/vfs.rst                  |    7 
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  450 +++---
 fs/iomap/buffered-io.c                             |   27 
 fs/iomap/direct-io.c                               |    4 
 fs/iomap/ioend.c                                   |    4 
 fs/xfs/Kconfig                                     |    8 
 fs/xfs/Makefile                                    |    7 
 fs/xfs/xfs_aops.c                                  |    2 
 fs/xfs/xfs_file.c                                  |  174 ++
 fs/xfs/xfs_fsops.c                                 |   60 +
 fs/xfs/xfs_health.c                                |  271 ++++
 fs/xfs/xfs_healthmon.c                             | 1466 ++++++++++++++++++++
 fs/xfs/xfs_ioctl.c                                 |    7 
 fs/xfs/xfs_notify_failure.c                        |  258 +++-
 fs/xfs/xfs_super.c                                 |  109 +
 fs/xfs/xfs_trace.c                                 |    4 
 lib/seq_buf.c                                      |    1 
 30 files changed, 3477 insertions(+), 244 deletions(-)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/xfs_healthmon.c


