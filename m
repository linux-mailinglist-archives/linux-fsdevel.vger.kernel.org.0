Return-Path: <linux-fsdevel+bounces-65246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21212BFEA14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 01:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD393A4C5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 23:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E962F3C23;
	Wed, 22 Oct 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNivmhk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E62C21C6;
	Wed, 22 Oct 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177587; cv=none; b=bllcLKdHSzEVKOlcMyVIuEMwiTC/uZxA/3ujz556bUAEFvjekk5aryqYT9CPY2+Y8sYYNN9UU4PGK14H0SxBBOr8eNy4AGJBJ7VjEkj9UMFfpiQjpgEgVy8wXgTJKsVxqWlf+inaPIqm/HtQWYk4J3WCBLJqAaTw+2dHJjBHbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177587; c=relaxed/simple;
	bh=RtZeOHFXu/73gMFw11AUbDi+s1xrg0n8HJ1+IQuKODM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koGPQgPjLT/wJ62E+eNKg7gQI2tFOhjFahd7d49GPHztayqPXWyMsR/rYmXHVkx4NamQFQh208SI9Bx2FMU4lHtrrEvhLuNVzrFgUhmnnwEYAe904rHZTKWfR3TgQcNQrQ91eEQtfQXjA8XCnx5qpS9F8MoJk7hbWsnL1Mp6gWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNivmhk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DF7C4CEFF;
	Wed, 22 Oct 2025 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177586;
	bh=RtZeOHFXu/73gMFw11AUbDi+s1xrg0n8HJ1+IQuKODM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tNivmhk0dBSEU0Kw1DC1iPmiNQRL0mbXC1pS4jUnmhvfg6W1j+sFwr69ETPI1nE5w
	 txXPvtF++2E8tNnq/6OQgLbkd2f3THipi800yhj50szRbbpNHAEVJAa0CiHN0+xlNk
	 od29UCwfwCzUz3VKi9YhpDlNr7grOlCPCaOMCmCOiLufE4XB06GE/acQZxiBcwfkQH
	 U8bJUvCbdfUubuixKbhJ4MMJtM9KvG/X0pU/ABrZ630aNLN8WT5EjFWHNzBRzCj1T8
	 MQzNjxGrW46MeiQJ4sjuy1FWraUwXB+fhFAjYpo0ApX2OMd89JlSOHOY9VX2YCqTz/
	 ckiAn+Uw3QeOw==
Date: Wed, 22 Oct 2025 16:59:46 -0700
Subject: [PATCHSET V2] xfs: autonomous self healing of filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
In-Reply-To: <20251022235646.GO3356773@frogsfrogsfrogs>
References: <20251022235646.GO3356773@frogsfrogsfrogs>
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
---
 fs/iomap/internal.h                                |    2 
 fs/xfs/libxfs/xfs_fs.h                             |  173 ++
 fs/xfs/libxfs/xfs_health.h                         |   52 +
 fs/xfs/xfs_file.h                                  |   36 
 fs/xfs/xfs_fsops.h                                 |   14 
 fs/xfs/xfs_healthmon.h                             |  107 +
 fs/xfs/xfs_linux.h                                 |    3 
 fs/xfs/xfs_mount.h                                 |   13 
 fs/xfs/xfs_notify_failure.h                        |   44 +
 fs/xfs/xfs_super.h                                 |   13 
 fs/xfs/xfs_trace.h                                 |  404 +++++
 include/linux/fs.h                                 |    4 
 include/linux/iomap.h                              |    2 
 Documentation/filesystems/vfs.rst                  |    7 
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  336 +---
 fs/iomap/buffered-io.c                             |   27 
 fs/iomap/direct-io.c                               |    4 
 fs/iomap/ioend.c                                   |    4 
 fs/xfs/Kconfig                                     |    8 
 fs/xfs/Makefile                                    |    7 
 fs/xfs/libxfs/xfs_healthmon.schema.json            |  648 +++++++
 fs/xfs/xfs_aops.c                                  |    2 
 fs/xfs/xfs_file.c                                  |  167 ++
 fs/xfs/xfs_fsops.c                                 |   75 +
 fs/xfs/xfs_health.c                                |  269 +++
 fs/xfs/xfs_healthmon.c                             | 1741 ++++++++++++++++++++
 fs/xfs/xfs_ioctl.c                                 |    7 
 fs/xfs/xfs_notify_failure.c                        |  135 +-
 fs/xfs/xfs_super.c                                 |  109 +
 fs/xfs/xfs_trace.c                                 |    4 
 lib/seq_buf.c                                      |    1 
 31 files changed, 4173 insertions(+), 245 deletions(-)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/libxfs/xfs_healthmon.schema.json
 create mode 100644 fs/xfs/xfs_healthmon.c


