Return-Path: <linux-fsdevel+bounces-74047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 702EFD2C142
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749333027A53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8382F5485;
	Fri, 16 Jan 2026 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMxr1BHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9634679A;
	Fri, 16 Jan 2026 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542132; cv=none; b=eFZuIav4g/fbeNnbgQAxcwm4ENLEZLi8FLBu69zPseVczbK13FTyvQOFTv80VdCLbvuLHfmgTOvT4XM1JZaqAv0j4Jft5guWvLgZ2Lp57NCPdJfbTqBXJ5FZ4lIz0rGC9celIckiTZIAzZ35z57tOHDWapA9zZe+0kOYae1a+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542132; c=relaxed/simple;
	bh=InOm0YgX3Se7eLjYtQN8ewweDDMOfqDYHfiE6x/OPGM=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=Cf1y/79a+GmLwMECB00Hlzh9o90GPlf7Zm00gGSazbd7JHaaBoke5/RsbueDDKqswOz9SCv/kWzurDdLn+ecmHzteSctuwjs9UKwXkThmnD9YbDSi7ZwbZ1yNySKD5dTxGb5GGCGIPUv0L4F6LHG5REB99TZH4WX8ul11yLuSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMxr1BHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7736C116C6;
	Fri, 16 Jan 2026 05:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768542131;
	bh=InOm0YgX3Se7eLjYtQN8ewweDDMOfqDYHfiE6x/OPGM=;
	h=Date:Subject:From:To:Cc:From;
	b=PMxr1BHz1FFqk4S1U8HlCzMCtgSDqaXmc8KLjbfLLT4EQ4SkL0bmRIJhei8usV8oM
	 pTGfO5NReWTnxpY2pA32urqjPvcqWC2iGk46yXsDhFeRyuYyEOPnlDImz0z0yACS7k
	 QXz0rc/Wra553ht26L+dyS7AJeYSey4erieZnCshZS9+j67vPCkQnLO+llHP0vH/e5
	 TDXqq7IBEFsJM6bIUz+prXi3D5kGiXQzFm0yu/LCEhqvLU1ow/sCTRASwjGLKm1lYb
	 Cjv5e12/BJV6gleh8jU0hGzQZQ2jJ74YC1++RgpaHo1ovcqE5xBZu3mU8c+QSEFiw2
	 lEGOW/Zgn0XIw==
Date: Thu, 15 Jan 2026 21:42:11 -0800
Subject: [PATCHSET v6] xfs: autonomous self healing of filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de
Message-ID: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
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
as C structs for the xfs_healer daemon.

In userspace, we create a new daemon program that will read the event
objects and initiate repairs automatically.  This daemon is managed
entirely by systemd and will not block unmounting of the filesystem
unless repairs are ongoing.  They are auto-started by a starter
service that uses fanotify.

This patchset depends on the new fserror code that Christian Brauner
has tentatively accepted for Linux 7.0:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.0.fserror

v6: fix pi-breaking bugs, make verify failures trigger health reports
    and filter bio status flags better
v5: add verify-media ioctl, collapse small helper funcs with only
    one caller
v4: drop multiple client support so we can make direct calls into
    healthmon instead of chasing pointers and doing indirect calls
v3: drag out of rfc status

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

Unreviewed patches in this series:
  [PATCH 04/11] xfs: convey filesystem unmount events to the health
  [PATCH 06/11] xfs: convey filesystem shutdown events to the health
  [PATCH 11/11] xfs: add media verification ioctl

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=health-monitoring
---
Commits in this patchset:
 * docs: discuss autonomous self healing in the xfs online repair design doc
 * xfs: start creating infrastructure for health monitoring
 * xfs: create event queuing, formatting, and discovery infrastructure
 * xfs: convey filesystem unmount events to the health monitor
 * xfs: convey metadata health events to the health monitor
 * xfs: convey filesystem shutdown events to the health monitor
 * xfs: convey externally discovered fsdax media errors to the health monitor
 * xfs: convey file I/O errors to the health monitor
 * xfs: allow toggling verbose logging on the health monitoring file
 * xfs: check if an open file is on the health monitored fs
 * xfs: add media verification ioctl
---
 fs/xfs/libxfs/xfs_fs.h                             |  189 +++
 fs/xfs/libxfs/xfs_health.h                         |    5 
 fs/xfs/xfs_healthmon.h                             |  184 +++
 fs/xfs/xfs_mount.h                                 |    4 
 fs/xfs/xfs_trace.h                                 |  512 ++++++++
 fs/xfs/xfs_verify_media.h                          |   13 
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  153 ++
 fs/xfs/Makefile                                    |    2 
 fs/xfs/xfs_fsops.c                                 |    2 
 fs/xfs/xfs_health.c                                |  124 ++
 fs/xfs/xfs_healthmon.c                             | 1255 ++++++++++++++++++++
 fs/xfs/xfs_ioctl.c                                 |    7 
 fs/xfs/xfs_mount.c                                 |    2 
 fs/xfs/xfs_notify_failure.c                        |   17 
 fs/xfs/xfs_super.c                                 |   12 
 fs/xfs/xfs_trace.c                                 |    5 
 fs/xfs/xfs_verify_media.c                          |  459 +++++++
 17 files changed, 2938 insertions(+), 7 deletions(-)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/xfs_verify_media.h
 create mode 100644 fs/xfs/xfs_healthmon.c
 create mode 100644 fs/xfs/xfs_verify_media.c


