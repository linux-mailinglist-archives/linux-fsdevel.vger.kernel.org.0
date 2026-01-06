Return-Path: <linux-fsdevel+bounces-72417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FFECF6FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0843A3015D39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D05309EE4;
	Tue,  6 Jan 2026 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of+5DpMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692C22127E;
	Tue,  6 Jan 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683449; cv=none; b=W7XYY2c0La7qxJmFDX2rENtlzCgDIWHPOwCH/ZCaNkc3J0Dbh3WsxJPA9mCZ6r1SsQ22hZUIm75jfmqcVu/1ZhtfAtVawLbITyRX56ricZrcf9qULwvzlj91syeWImAbocKzXIkGBrtCCc9DFE4DEC+QArCkTzBy5S19sp7eUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683449; c=relaxed/simple;
	bh=uGeBDr9C7T4irA07dxIpHgCfKWMA9RRFiR5WqFfCgkU=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=kAA33NvKeeD9ghLMxASUY39G0n7cGZIZNgI3PNeuwnSUaPAlB9mv+8iCUWAGNmO4mkt7UoYQihRfIZYsl3DEp4+ygYsAuNBLjVwYUwTDZCn6fqkSuZ7eGSJN8bGoT8MBNe1IIDPlcvqtCOZyIb+2ivNi5JxqAzFnL04yqQLW0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of+5DpMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECD3C116C6;
	Tue,  6 Jan 2026 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683447;
	bh=uGeBDr9C7T4irA07dxIpHgCfKWMA9RRFiR5WqFfCgkU=;
	h=Date:Subject:From:To:Cc:From;
	b=Of+5DpMOxn0/3RXJ9+Sxd1nfkiSxQHBAcqelDdX4lUi8osBTxrfTkOYGjUNjlyRK0
	 BJcH3UdQEiiuxteYA+HTiuSMaKGsda2HRdvWDjKy+cz9ee/L0jPR3mK9dhhs3GU10Q
	 eMfQRZYmebSuZQB9ArQieajFc8S7jK4j0IrTQuusdagfjc8qsZQT77xgLIgtYXvwiR
	 9BeP8LIg9q3QO9FqcYjSuA3E0JUAck5/qhQx8dpYkHpgi7zS1B2UhABci7/jWVoMBl
	 oKPyk/PGr/urYXkVbKxU8Ns1B2DH+fn1wzWeIQnOmKlJ8/b03bdMC14auxFj/7z1+7
	 IMDxxeALfpdwQ==
Date: Mon, 05 Jan 2026 23:10:47 -0800
Subject: [PATCHSET V4] xfs: autonomous self healing of filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
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
 * xfs: add media error reporting ioctl
---
 fs/xfs/libxfs/xfs_fs.h                             |  178 +++
 fs/xfs/libxfs/xfs_health.h                         |    5 
 fs/xfs/xfs_healthmon.h                             |  181 +++
 fs/xfs/xfs_mount.h                                 |    4 
 fs/xfs/xfs_notify_failure.h                        |    4 
 fs/xfs/xfs_trace.h                                 |  414 ++++++
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  218 +++
 fs/xfs/Makefile                                    |    7 
 fs/xfs/xfs_fsops.c                                 |   15 
 fs/xfs/xfs_health.c                                |  124 ++
 fs/xfs/xfs_healthmon.c                             | 1305 ++++++++++++++++++++
 fs/xfs/xfs_ioctl.c                                 |    7 
 fs/xfs/xfs_mount.c                                 |    2 
 fs/xfs/xfs_notify_failure.c                        |  195 +++
 fs/xfs/xfs_super.c                                 |   12 
 fs/xfs/xfs_trace.c                                 |    5 
 16 files changed, 2657 insertions(+), 19 deletions(-)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/xfs_healthmon.c


