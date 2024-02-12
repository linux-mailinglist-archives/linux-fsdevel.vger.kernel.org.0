Return-Path: <linux-fsdevel+bounces-11119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF738513F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453681F2315E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD13A1B4;
	Mon, 12 Feb 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx+kF18+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBA39FFE;
	Mon, 12 Feb 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742835; cv=none; b=K4HwIPCeAXtpQ2uaxp+BKrItVa7Rh7PHHA24nKbbObKxylmtCKncI0tZhQeipEQORtyL21RxEWUZqvhoVSqcBfV1pAp/iLRLh2W3jmrJOfvitRPbILPzVtnOVq5WNjb8u5w6bQrFKM5Tyoyhs44GPIXCgEWKYSopjmX8xPBHfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742835; c=relaxed/simple;
	bh=aPEce8iGKTp2tOgGLV5BSLoGJ1V3rA/nAT8AZDNOKXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMnRnTKXtlXRes2wrFm2Rz/yNwU2LkKdnIOLciwuocm4Gr+GcpTyg7R4sly7lTNv7RnszE1uO1TX6DB+DpVqqyIvO0pMS9izQcxf7K/u0EgyBE/z/Dkolb/U21x5/lw5FBTdcfc1mGP5MjmAKqqHRUtUEvKKWO32Lf2dC1rW2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx+kF18+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B49C433C7;
	Mon, 12 Feb 2024 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707742834;
	bh=aPEce8iGKTp2tOgGLV5BSLoGJ1V3rA/nAT8AZDNOKXg=;
	h=From:To:Cc:Subject:Date:From;
	b=bx+kF18+gFz/VXBRlkk7kvMsPZIol4pIOmUJrcsfvSt39GK0rcewspFodtSHYEuFo
	 fpyqkQJw8s6/0PDFKVkVaQtRgetVX0qj0UqhXK9J2Z+PC5bC+mIYTF3YzOTY/Sjixs
	 7K6NlSG2B7rxMvSqqQq8bVyU17/YQ/eJZjR7Y5cGWxMByWRfZjE5Otd5+AtR1q7B/4
	 tR5exKCfvYG3CwvJuhYyuSi/tuV+2ZUDMEtRA1wW8oDBjoA54B85ue8wC40X1ZJZxd
	 F8kRNF/ARtTYMx//ld4OqNp/W14Wfv3fwcWmz8EKeecz7XbZw8GWQ3eLyABYKETu3F
	 3tfqEXgS6hZhg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 12 Feb 2024 14:00:11 +0100
Message-ID: <20240212-vfs-fixes-bd692dfd338a@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=brauner@kernel.org; h=from:subject:message-id; bh=aPEce8iGKTp2tOgGLV5BSLoGJ1V3rA/nAT8AZDNOKXg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSeEotVfHG+wv2Vy6ptmja8Zzkiyz9JNUeLNW59Pqkpi e0wv+GEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlINjD84dq93yJg5X1rn9PM OWraRZ+naUWn/TdQnWNcMnMSd4N6IMM/+6dtF19fPj/lruSjdSfCjq++WPPz2kT1nNBumxM/4lb N4QcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains two small fixes:

* Fix performance regression introduced by moving the security permission hook
  out of do_clone_file_range() and into its caller vfs_clone_file_range(). This
  causes the security hook to be called in situation were it wasn't called
  before as the fast permission checks were left in do_clone_file_range(). Fix
  this by merging the two implementations back together and restoring the old
  ordering: fast permission checks first, expensive ones later.

* Tweak mount_setattr() permission checking so that mount properties on the
  real rootfs can be changed.

  When we added mount_setattr() we added additional checks compared to legacy
  mount(2). If the mouna had a parent then verify that the caller and the mount
  namespace the mount is attached to match and if not make sure that it's an
  anonymous mount.

  But the real rootfs falls into neither category. It is neither an anoymous
  mount because it is obviously attached to the initial mount namespace but it
  also obviously doesn't have a parent mount. So that means legacy mount(2)
  allows changing mount properties on the real rootfs but mount_setattr(2)
  blocks this. This causes regressions (See the commit for details).

  Fix this by relaxing the check. If the mount has a parent or if it isn't a
  detached mount, verify that the mount namespaces of the caller and the mount
  are the same. Technically, we could probably write this even simpler and
  check that the mount namespaces match if it isn't a detached mount. But the
  slightly longer check makes it clearer what conditions one needs to think
  about.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc5.fixes

for you to fetch changes up to 46f5ab762d048dad224436978315cbc2fa79c630:

  fs: relax mount_setattr() permission checks (2024-02-07 21:16:29 +0100)

Please consider pulling these changes from the signed vfs-6.8-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.8-rc5.fixes

----------------------------------------------------------------
Amir Goldstein (1):
      remap_range: merge do_clone_file_range() into vfs_clone_file_range()

Christian Brauner (1):
      fs: relax mount_setattr() permission checks

 fs/namespace.c         | 11 ++++++++---
 fs/overlayfs/copy_up.c | 14 ++++++--------
 fs/remap_range.c       | 31 +++++++++----------------------
 include/linux/fs.h     |  3 ---
 4 files changed, 23 insertions(+), 36 deletions(-)

