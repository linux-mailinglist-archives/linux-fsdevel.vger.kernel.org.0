Return-Path: <linux-fsdevel+bounces-24362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79493DE06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B983283429
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA14AEF5;
	Sat, 27 Jul 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtI7eiVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23063CF65;
	Sat, 27 Jul 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071136; cv=none; b=JryAr+gc1EYQWOZpxzbhv84JTns0LuIsLDZ/NTrvTpxL5kNa3oSHQHrHFsbsGK/w0YpW8VSQ0BmiQxp03swx5Jj8GGhhT+a1TFWGQVDuWjpP84XKA/Sa2p0h6ts0llp64rcWgL6rRgw2hvE0gYffcB7i8iVGnsCKvYgt3oBUzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071136; c=relaxed/simple;
	bh=gr91wZ7eBkttZxgijqGMSmT/j1QO8PoBfStGv0ABvWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2b0ShgXb6odabJOF5/r8jtGDQc7p/A0VQm9uO0aYQFd8XNbVc9RsScxEtiUN0cnsRXl4CsynOXTauYHD2cuZl5nVKaplmZiBbWIoH/F0zvQBNZlknGFVznAEgz7oSo7rs2rYYnnBnYoLzaRp183k6KL0iqR2w7+HRdj+L2HpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtI7eiVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904F2C32781;
	Sat, 27 Jul 2024 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071136;
	bh=gr91wZ7eBkttZxgijqGMSmT/j1QO8PoBfStGv0ABvWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BtI7eiVXSKIBzl/dz/cBE5MUTNt64boPEsoZepW9ynNz4WRxn24kGKpNqpIoTdaIH
	 ebp+otVYyzD4oWLu/7SbqXMmvyKvZZCAG1v1TNrsdBihBheZ9h6nbGXY7E+l3ktJE+
	 t3GeFMHCbOQZWVkM7+uWi2fsHJmGJIzpWauAGvscdTC41N4ceOdouadSf6k33LM7MG
	 R7mEDUiGaQZAOo4OC18c1GbZnSnyrWDhv5Pp19C/LEP9RFlHrZzx+WKk3tOo3gofO0
	 /zKJaey3zw5HsqUP/NgGO0UUAY59w+nDYfhSWNppwNCJh0bfZYVXk+vG+B4QDwiIPA
	 r+oeKiSE1gG9Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Sat, 27 Jul 2024 11:05:08 +0200
Message-ID: <20240727-vfs-fixes-c054317e0d77@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2703; i=brauner@kernel.org; h=from:subject:message-id; bh=gr91wZ7eBkttZxgijqGMSmT/j1QO8PoBfStGv0ABvWQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQt2eFX/TFdUuzHr2p1ad6jxzZv7VJVVpVid8m7Knxq5 /XNctrbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS+JqR4XhB0EK1SN7tV5Y/ +ePz9MaxvU95RW4rMmRP4lzAWGCl4cbwP98qRqhA433VGS2hdXcvZzY7HyoT19vJOKHt4IZz++W smQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */
This contains two fixes for this merge window:

VFS:

- I noticed that it is possible for a privileged user to mount most filesystems
  with a non-initial user namespace in sb->s_user_ns. When fsopen() is called
  in a non-init namespace the caller's namespace is recorded in
  fs_context->user_ns. If the returned file descriptor is then passed to a
  process privileged in init_user_ns, that process can call
  fsconfig(fd_fs, FSCONFIG_CMD_CREATE*), creating a new superblock with
  sb->s_user_ns set to the namespace of the process which called fsopen().

  This is problematic as only filesystems that raise FS_USERNS_MOUNT are known
  to be able to support a non-initial s_user_ns. Others may suffer security
  issues, on-disk corruption or outright crash the kernel. Prevent that by
  restricting such delegation to filesystems that allow FS_USERNS_MOUNT.

  Note, that this delegation requires a privileged process to actually create
  the superblock so either the privileged process is cooperaing or someone must
  have tricked a privileged process into operating on a fscontext file
  descriptor whose origin it doesn't know (a stupid idea).

  The bug dates back to about 5 years afaict.

misc:

- Fix hostfs parsing when the mount request comes in via the legacy mount api.
  In the legacy mount api hostfs allows to specify the host directory mount
  without any key. Restore that behavior.

/* Testing */
clang: Debian clang version 16.0.6 (27)
gcc: (Debian 13.2.0-25) 13.2.0

/* Conflicts */
No known conflicts.

The following changes since commit c33ffdb70cc6df4105160f991288e7d2567d7ffa:

  Merge tag 'phy-for-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy (2024-07-24 13:11:28 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes.3

for you to fetch changes up to ef9ca17ca458ac7253ae71b552e601e49311fc48:

  hostfs: fix the host directory parse when mounting. (2024-07-27 09:56:33 +0200)

Please consider pulling these changes from the signed vfs-6.11-rc1.fixes.3 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11-rc1.fixes.3

----------------------------------------------------------------
Hongbo Li (1):
      hostfs: fix the host directory parse when mounting.

Seth Forshee (DigitalOcean) (1):
      fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT

 fs/hostfs/hostfs_kern.c | 65 +++++++++++++++++++++++++++++++++++++++++--------
 fs/super.c              | 11 +++++++++
 2 files changed, 66 insertions(+), 10 deletions(-)

