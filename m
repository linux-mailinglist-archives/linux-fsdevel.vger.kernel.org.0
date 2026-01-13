Return-Path: <linux-fsdevel+bounces-73343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BDCD16077
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16BA9302CC41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19555248F66;
	Tue, 13 Jan 2026 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAkQr3BQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6F187346;
	Tue, 13 Jan 2026 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264364; cv=none; b=ccQKyVV+8NDUIwbYUL+I8kP+o1YZ1jKyBBryTDOIpywRKpsb9WIdwkxo/gwnH+rubWyGXx9NByw1pUrA1g2AxwrdTSzrpxKkkf6cxCFm4BsJiIlJWI25jGYA7UnYgFpEjjm7vUnZF9XrLXxJc39GjTdy9j/c11Tdn6di/IgXIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264364; c=relaxed/simple;
	bh=Gf1dkWwmuahNnZO8rJPy8SZ39tVuGw65N78TIX+9yaY=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=CkfhiR24JRSnXTtHSPdyozdSj9h+QlUFEpXYpeHXtYSz+TW9Rlkv8C6pmXDHY8FdDoefdE2wvLlREntuteKagLApWlD2TmqS82LSJpEHvyHx9l5uwTdbRG57ySgspt4L0p/BBV069bqhKnVKhL5/hh+zifTAFNepxIIW4fcZdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAkQr3BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D8EC116D0;
	Tue, 13 Jan 2026 00:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264364;
	bh=Gf1dkWwmuahNnZO8rJPy8SZ39tVuGw65N78TIX+9yaY=;
	h=Date:Subject:From:To:Cc:From;
	b=eAkQr3BQJhzYUZ2TIYTQU90U9OnaclKYpPuOYGyLYD5LXFXtkQQwXW/4gRa5PLSca
	 CVWMUlObmk7t0Gjo0vNzfnUQ98DLVKud8g/smU7k6ApAk0IwPI9BauYjeJqoIGonAb
	 VGEpwUaZSe0unbgU8m27uFKo4KzK/pAYpzUylQSJQeWxDyffEBn+FQZ6qg+2t1lph4
	 DWAsCed/u7Rzteq9vu2Mg5Pb0zm1CHq9mwYqtuvoxHOk5hniC10RhMpirOW7Mn6RzH
	 9NWY3vPLKku050TWv8ma3BKUfyH+qU7IoIiLEiIq1Kz2AfEn4wpK5o5ZVaOciM6Lfv
	 XGkuNqbk3ZEHw==
Date: Mon, 12 Jan 2026 16:32:43 -0800
Subject: [PATCHSET v5] xfs: autonomous self healing of filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
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

v5: add verify-media ioctl, collapse small helper funcs with only
    one caller
v4: drop multiple client support so we can make direct calls into
    healthmon instead of chasing pointers and doing indirect calls
v3: drag out of rfc status

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
 * docs: discuss autonomous self healing in the xfs online repair design doc
 * xfs: start creating infrastructure for health monitoring
 * xfs: create event queuing, formatting, and discovery infrastructure
 * xfs: convey filesystem unmount events to the health monitor
 * xfs: convey metadata health events to the health monitor
 * xfs: convey filesystem shutdown events to the health monitor
 * xfs: convey externally discovered fsdax media errors to the health monitor
 * xfs: convey file I/O errors to the health monitor
 * xfs: allow reconfiguration of the health monitoring device
 * xfs: check if an open file is on the health monitored fs
 * xfs: add media verification ioctl
---
 fs/xfs/libxfs/xfs_fs.h                             |  186 +++
 fs/xfs/libxfs/xfs_health.h                         |    5 
 fs/xfs/xfs_healthmon.h                             |  181 +++
 fs/xfs/xfs_mount.h                                 |    4 
 fs/xfs/xfs_notify_failure.h                        |    4 
 fs/xfs/xfs_trace.h                                 |  511 ++++++++
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  153 ++
 fs/xfs/Makefile                                    |    7 
 fs/xfs/xfs_fsops.c                                 |   15 
 fs/xfs/xfs_health.c                                |  124 ++
 fs/xfs/xfs_healthmon.c                             | 1257 ++++++++++++++++++++
 fs/xfs/xfs_ioctl.c                                 |    7 
 fs/xfs/xfs_mount.c                                 |    2 
 fs/xfs/xfs_notify_failure.c                        |  392 ++++++
 fs/xfs/xfs_super.c                                 |   12 
 fs/xfs/xfs_trace.c                                 |    5 
 16 files changed, 2846 insertions(+), 19 deletions(-)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/xfs_healthmon.c


