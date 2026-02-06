Return-Path: <linux-fsdevel+bounces-76601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKlENB4dhmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E34C1009D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E16D3091EE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5BB334C3E;
	Fri,  6 Feb 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbFahG8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590D330B19;
	Fri,  6 Feb 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396688; cv=none; b=XX/12PxVVqfqPQlyqSM6GZjrqunHnx5538Owyhw2Xk+cnqbJRSkw4X4cPEw+AoQzUAMRfMpC0nER00Z6fJkFjJyedr9cQapwCLyUR4I2X+nWEA5L0VIeuawGxEnsR2da/ZPzx3fckZkSGYf9yX8yt1+q6ZM0OblU2XIU5DSVyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396688; c=relaxed/simple;
	bh=1LRXDt7RI+IMWSeoD5YYO/2KRUciC6Usl7JV6pWjFfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ/JvISOAIfbJ5YGIexszn7WMCgaZzIDUl5QpVOdudTPcr/skjkvtEglTXbSa8XaxZhWG2REYLtFfchDrMEu/94weJ7aUDvkbDzN+Z0qBhZsXCZj+P5l9Yatq7cGqtYxiKF/CwqYL62Hy2E8Q9eOXAvSWTTON/xQ/7XH48ZPQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbFahG8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E077FC19423;
	Fri,  6 Feb 2026 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396688;
	bh=1LRXDt7RI+IMWSeoD5YYO/2KRUciC6Usl7JV6pWjFfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbFahG8yZjsxVO0I0HYVnHd9ccKVMJ4bty0Fl5gtw4nJ/EiOSa4yq7N2qw018MHD4
	 TXwBLVrW4FHd5m04IDxmk1Xzt4QiY2ZrSWn3405PrmWv28WeLT/PeiKZiLOfo0oyH2
	 MyYaCA24qeVvWsWerJsCeSO5GRoy48zxU6k2FtW72M+nV+ea4rEyb2jsyyHu5h4R7b
	 EqiUNPWisItNr6H2pOjj1bQet/S9hDzqbpPVmqPI/yYmVys1maiA2yNOHWmTgRuup1
	 OyC6s2nw2L/+XqkcxrLsouTaOsDHD2kYUn0qBz4DGwF/J4kZz2Z1wJygOpF6V9gw+7
	 wn+uiDBjATY5A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/12 for v7.0] vfs nonblocking_timestamps
Date: Fri,  6 Feb 2026 17:49:59 +0100
Message-ID: <20260206-vfs-nonblocking_timestamps-v70-59f22fca9b3a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4119; i=brauner@kernel.org; h=from:subject:message-id; bh=1LRXDt7RI+IMWSeoD5YYO/2KRUciC6Usl7JV6pWjFfo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se+s2D7ftmnCb3Xlsz1na9dN5jZ++kXmU/4tW6kqu 47D4sbpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpF2NkaL7o15Ay5SlT9CSm ow6hkt3HTq25w2Blyrd4+aWL7IvnKjEyvP369faEoE2Pz81UX8Slu9Xx9TUvPfut7pOqv5+fcuf NZEYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76601-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E34C1009D5
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains the changes to support non-blocking timestamp updates.

Since 66fa3cedf16a ("fs: Add async write file modification handling.")
file_update_time_flags() unconditionally returns -EAGAIN when any
timestamp needs updating and IOCB_NOWAIT is set. This makes
non-blocking direct writes impossible on file systems with granular
enough timestamps, which in practice means all of them.

This series reworks the timestamp update path to propagate IOCB_NOWAIT
through ->update_time so that file systems which can update timestamps
without blocking are no longer penalized.

With that groundwork in place, the core change passes IOCB_NOWAIT into
->update_time and returns -EAGAIN only when the file system indicates it
would block. XFS implements non-blocking timestamp updates by using the
new ->sync_lazytime and open-coding generic_update_time without the
S_NOWAIT check, since the lazytime path through the generic helpers can
never block in XFS.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.nonblocking_timestamps

for you to fetch changes up to 77ef2c3ff5916d358c436911ca6a961060709f04:

  Merge patch series "re-enable IOCB_NOWAIT writes to files v6" (2026-01-12 14:01:42 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.nonblocking_timestamps

Please consider pulling these changes from the signed vfs-7.0-rc1.nonblocking_timestamps tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "re-enable IOCB_NOWAIT writes to files v6"

Christoph Hellwig (11):
      fs: remove inode_update_time
      fs: allow error returns from generic_update_time
      nfs: split nfs_update_timestamps
      fat: cleanup the flags for fat_truncate_time
      fs: refactor ->update_time handling
      fs: factor out a sync_lazytime helper
      fs: add a ->sync_lazytime method
      fs: add support for non-blocking timestamp updates
      fs: refactor file_update_time_flags
      xfs: implement ->sync_lazytime
      xfs: enable non-blocking timestamp updates

 Documentation/filesystems/locking.rst |   5 +-
 Documentation/filesystems/vfs.rst     |   9 +-
 fs/bad_inode.c                        |   3 +-
 fs/btrfs/inode.c                      |  13 ++-
 fs/fat/dir.c                          |   2 +-
 fs/fat/fat.h                          |  11 +-
 fs/fat/file.c                         |  14 +--
 fs/fat/inode.c                        |   2 +-
 fs/fat/misc.c                         |  59 ++++------
 fs/fat/namei_msdos.c                  |  13 +--
 fs/fat/namei_vfat.c                   |   9 +-
 fs/fs-writeback.c                     |  33 ++++--
 fs/gfs2/inode.c                       |   9 +-
 fs/inode.c                            | 202 ++++++++++++++++++----------------
 fs/internal.h                         |   3 +-
 fs/nfs/inode.c                        |  37 +++----
 fs/orangefs/inode.c                   |  29 +++--
 fs/orangefs/orangefs-kernel.h         |   3 +-
 fs/overlayfs/inode.c                  |   7 +-
 fs/overlayfs/overlayfs.h              |   3 +-
 fs/sync.c                             |   4 +-
 fs/ubifs/file.c                       |  28 ++---
 fs/ubifs/ubifs.h                      |   3 +-
 fs/xfs/xfs_iops.c                     |  49 ++++++---
 fs/xfs/xfs_super.c                    |  29 -----
 include/linux/fs.h                    |  30 +++--
 include/trace/events/writeback.h      |   6 -
 27 files changed, 325 insertions(+), 290 deletions(-)

