Return-Path: <linux-fsdevel+bounces-44767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54EA6C901
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DF63B79FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B91F5404;
	Sat, 22 Mar 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2ZOej8X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699C1F4E59;
	Sat, 22 Mar 2025 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638484; cv=none; b=hieqix0uheW1bsMMt7inq/dMLSCg0NHH9cCM3rkMt+89ifprajdQEZbbBaazEWa8LrSDViasi0CRVshat+tvWuhIWwi4UR3eVXsobbhzGQYVAW1XR7Ps2juNbs4qJC1y1X/TxybqcbErfuOmRzdHQMN1TxtDIuxpELnXuObakfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638484; c=relaxed/simple;
	bh=KoaBZiU24zoOJqndFMsPFyx7tsJlmHpdRY86je/cZac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwBfznzcy1D6bOjAEfmJ1Ld3fzO8NEDfgiKTJn1DfUDZah3PkwpboqYDEuTY9yHH/sOcFntJRYVv2bo+sn8CMNJMxjYthaLl8/8bjeA1K8169PzOsqdo0vYkoizsh+IQkz0MO2d34mDIiJ0F2w1idiJvhsU7BG79YzEycBjekNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2ZOej8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07989C4CEDD;
	Sat, 22 Mar 2025 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638484;
	bh=KoaBZiU24zoOJqndFMsPFyx7tsJlmHpdRY86je/cZac=;
	h=From:To:Cc:Subject:Date:From;
	b=D2ZOej8XEYjE/lG2q7rG3WjEKq4ZtGcy4nK7umd1DBLSLmJoPw+GsSo0dpsi68oNa
	 dBoDfMdBLkTrXAkVzkvMnTM/w1qKhvO4s53fBEWO6rRsWj/VEfAVBHwPWbGWJ5E5VS
	 CetVNIgC76Fv/MQYKZOwczHbwaId8y1gjOwmJcZ4fOJpgt2b3QE150tEGgt0B9QQtO
	 rkrX5UFAFYTp9kC4iWzZJSJ+z9X0fDh2Yrt98uVDYt+7ytldkSEWUbtAkKFsCycF78
	 CMHebk+axHzVV9VpplHL/XZAYdiwGEBJPvKu0MfxDHGZ6NTXQtqrZsmAU+FXPG0nAG
	 mi+sW5cwTlRPw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount api
Date: Sat, 22 Mar 2025 11:14:34 +0100
Message-ID: <20250322-vfs-mount-api-04accc00c1fa@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=brauner@kernel.org; h=from:subject:message-id; bh=KoaBZiU24zoOJqndFMsPFyx7tsJlmHpdRY86je/cZac=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6+3lYUl5WPJW65Kwmoqaxm7bavemqIuVXof62iasX O6w6YxJRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETmzGH4Z1khd9uJvcspXyp6 mbS970zGXwJvfUqOOovGyzxK5TirwsiwzOvDsRerRd9M2y3Q3NHitG7z1zu8ofOnO9nvbF/Ty9v FAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This converts the remaining pseudo filesystems to the new mount api. The
sysv conversion is a bit gratuitous because we remove sysv in another
pull request. But if we have to revert the removal we at least will have
it converted to the new mount api already.

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

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount.api

for you to fetch changes up to 00dac020ca2a2d82c3e4057a930794cca593ea77:

  sysv: convert sysv to use the new mount api (2025-02-06 15:26:12 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.mount.api tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.mount.api

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fs: last of the pseudofs mount api conversions"

David Howells (1):
      vfs: Convert devpts to use the new mount API

Eric Sandeen (4):
      pstore: convert to the new mount API
      devtmpfs: replace ->mount with ->get_tree in public instance
      vfs: remove some unused old mount api code
      sysv: convert sysv to use the new mount api

 drivers/base/devtmpfs.c    |  81 ++++++++++++---
 fs/devpts/inode.c          | 251 ++++++++++++++++++++-------------------------
 fs/pstore/inode.c          | 109 +++++++++++++-------
 fs/super.c                 |  55 ----------
 fs/sysv/super.c            |  57 ++++++----
 include/linux/fs.h         |   3 -
 include/linux/fs_context.h |   2 -
 7 files changed, 287 insertions(+), 271 deletions(-)

