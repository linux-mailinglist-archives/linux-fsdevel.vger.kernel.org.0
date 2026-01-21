Return-Path: <linux-fsdevel+bounces-74783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMRhLZ9zcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:35:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC535219A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32628505533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E1C3A0B20;
	Wed, 21 Jan 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAJIqYxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7D4418F2;
	Wed, 21 Jan 2026 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977289; cv=none; b=jWKmuJiRC4XJ5kuZwtwDHgFvlGNpM584v7MWu9Mgs3w6GlAuK8BWbCbjFHkh1GoK59CeoiMmyDXbIs1V92izok5aMWhjshD5spcYre2X0lKJs0WPRlTi5yQmgF/G0ukuFOn09kmCI5OYjs3H5zPzsv+O0mz3InvBs8W2Bn/XMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977289; c=relaxed/simple;
	bh=FUfx1npqUCMH/lB9s1+iPEWAZNDaunKrjr9NYeD8WQA=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=hMHa9auf52bX+1ihtMPkIG/sXOB78qMrQQZZBeeNMxhoPegEPLZAFAfF0qHMwr+2XQJ7PSGQYnNXXOMdP8XX4eZPPG+m7XcDbPcPE4pd0xQPh2W3uPLW9BozLRXxMteleI7pAk7LQiq5A2KEshaVsbEirIqs6hYnVwrKrX0z6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAJIqYxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B1CC116D0;
	Wed, 21 Jan 2026 06:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768977288;
	bh=FUfx1npqUCMH/lB9s1+iPEWAZNDaunKrjr9NYeD8WQA=;
	h=Date:Subject:From:To:Cc:From;
	b=TAJIqYxXzTORg7+GbF2TCjfG3UtKVfEiEnthDgbsArv0hZWN457NzQo83gH6LadZv
	 4wb4hcYIYsf6ElMCk2IPJkLbXy/Yc4+IwAvqtPskcMTwQR6XSwcejKhF7Jlh1ZM6lK
	 nqhKGFb4Z6/WX6+nBysWSf1X7OmX3TQIDfoGxB67cUF6fkxxIAt3utROlmgbNsdJJX
	 jnEcSapQdFnABshvOrv6V9lq5YzLiRzRrkeF3wVhCe6eErLgssW3xtvor4LswPUrFk
	 Jc8EhIhRTCxZuPmYV9CB80rMljj4UFS6uo8/A90KVncWRELEDKSYJhd9Ysf5k+wnxe
	 XRapvzNz3wb4Q==
Date: Tue, 20 Jan 2026 22:34:48 -0800
Subject: [PATCHSET v7 1/3] xfs: autonomous self healing of filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de
Message-ID: <176897694953.202109.15171131238404759078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74783-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3BC535219A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v7: more cleanups of the media verification ioctl, improve comments, and
    reuse the bio
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
 fs/xfs/xfs_verify_media.c                          |  445 +++++++
 17 files changed, 2924 insertions(+), 7 deletions(-)
 create mode 100644 fs/xfs/xfs_healthmon.h
 create mode 100644 fs/xfs/xfs_verify_media.h
 create mode 100644 fs/xfs/xfs_healthmon.c
 create mode 100644 fs/xfs/xfs_verify_media.c


