Return-Path: <linux-fsdevel+bounces-39587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88203A15D23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1598F18854C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5C18DF73;
	Sat, 18 Jan 2025 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqbaZbEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCAA95C;
	Sat, 18 Jan 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205777; cv=none; b=C1WwRS8R1yO6UkVuyM27q9N52oGgQQHJOrmvmZmEINTrlMWjPT+QSYn0p4N3seW14mG7eACw8mTJbA229KuZHM4o5/j2AEjsEx2rQ6R9AGUXSFX8v6zq+2H16myTNQah8NIr1MbqV7d9Nz1PjA9CREa2fRMIJ7MDRgxQxFuGYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205777; c=relaxed/simple;
	bh=ZFeszbBvDxrj95PM+3TVCrBKLa2J597zSLAeeyPVT1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2aks9aoZL6KJ1krSFh1at+LnAyO75503iObxFsud95tfV9uz4+A/IyvPlLtRmhm/QPYxkGph0yzn0wUZW5Uo7Y/zmr5Roqec2PlcdWOxkHgOKG0cmQ+e4YJkWnUac0Bpdf7ZYKyIbegU2RNDWale336D2/LnMI7VMDJHFHMhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqbaZbEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03911C4CED1;
	Sat, 18 Jan 2025 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205776;
	bh=ZFeszbBvDxrj95PM+3TVCrBKLa2J597zSLAeeyPVT1I=;
	h=From:To:Cc:Subject:Date:From;
	b=YqbaZbEoM1TdOOPkdML7t7Wgey71P0kakUWWG+SXWS2w1Imek0ZjeM7DkC0SyP7bu
	 hTbHS5GdU8liZa3sLgP0fDi/guFJVQK6hLmy4mU5DQKrLhwEjd3KM8UcXVskBDpelj
	 brbf6Dv0VzewrQ215VXPAGiBt2VmGN+6iMGTyM+gFLXvcgEkWW8+nVHSHb/hsOytyb
	 Ui5gd11+ge8kCJodeS+XMEl0JjWl+OSaJ+sMf3tGo/4q42tPvHhpUh505h6unooufc
	 YWibOIvRYMmkkJS8TAD9ZRxTeJi7QUPWzqHzTQtInVU1O2nxsJ30mOV6IOn8Ek/oRH
	 3OXyOG6Mgwuow==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs dio
Date: Sat, 18 Jan 2025 14:09:26 +0100
Message-ID: <20250118-vfs-dio-3ca805947186@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=brauner@kernel.org; h=from:subject:message-id; bh=ZFeszbBvDxrj95PM+3TVCrBKLa2J597zSLAeeyPVT1I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3r+AUXXXwrt7UtBmlLxt5EuZo517+5DKh4Eiu2Z2zm rM37tXi6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIls0M//RP3D8TazjJa9nv oIMzHl2JPH9iui2/3WYj0yeT3iWwJagw/DN+dmp6qtW52r/7dTcyrH7wgMV/sSrPm4tmTPqvJ2y f8ogXAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

File systems that write out of place usually require different alignment
for direct I/O writes than what they can do for reads.

Add a separate dio read align field to statx, as many out of place write
file systems can easily do reads aligned to the device sector size, but
require bigger alignment for writes.

This is usually papered over by falling back to buffered I/O for smaller
writes and doing read-modify-write cycles, but performance for this
sucks, so applications benefit from knowing the actual write alignment.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.statx.dio

for you to fetch changes up to cf40ebb2ed9fde24195260637e00e47a6f0e7c15:

  Merge patch series "add STATX_DIO_READ_ALIGN v3" (2025-01-09 16:23:26 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.statx.dio tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.statx.dio

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "add STATX_DIO_READ_ALIGN v3"

Christoph Hellwig (5):
      fs: reformat the statx definition
      fs: add STATX_DIO_READ_ALIGN
      xfs: cleanup xfs_vn_getattr
      xfs: report the correct read/write dio alignment for reflinked inodes
      xfs: report larger dio alignment for COW inodes

 fs/stat.c                 |  1 +
 fs/xfs/xfs_ioctl.c        | 11 +++++-
 fs/xfs/xfs_iops.c         | 62 +++++++++++++++++------------
 include/linux/stat.h      |  1 +
 include/uapi/linux/stat.h | 99 +++++++++++++++++++++++++++++++++++------------
 5 files changed, 125 insertions(+), 49 deletions(-)

