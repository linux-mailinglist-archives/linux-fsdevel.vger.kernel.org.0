Return-Path: <linux-fsdevel+bounces-70147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA0C929B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82A9B4E305D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE4298CDC;
	Fri, 28 Nov 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0lMc8xm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865823D7C0;
	Fri, 28 Nov 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348388; cv=none; b=jhWyxziJwM5WHrcgcemuncuga+nwXIks87Ic4HZWGbzLFeoT75yj5OOLa6qGRW4j7X4dC8w5QUae86CsLPu2jOBXuJjcqafs3WGIooHKaPv50xaDEmAyypWg3cyeyqxfwrfL5nij47+/uRp0MZQCvNvfrLEWDaBCQJJTespv/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348388; c=relaxed/simple;
	bh=gqXKPbx6bAhHFAnWvPsvCD38nqglxkiPmPlhZAWr7JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6pIPGAQfGXGxda5vsIYRYfLBVKGCHD+bTmWUb+OwCjDUPP56Ig0rXdRXNaUAe8beEeiTgrerot7kAh9aQXDDLw9VVHNXC4OMUZR2FIwA7BulCST/jH96F/IXT8XNMUr5GzVY87HICgPU4dIDXJuqTsHDwm00Ae7x90mWvoYW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0lMc8xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDDAC4CEF1;
	Fri, 28 Nov 2025 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348387;
	bh=gqXKPbx6bAhHFAnWvPsvCD38nqglxkiPmPlhZAWr7JA=;
	h=From:To:Cc:Subject:Date:From;
	b=G0lMc8xmkL9MLXH8+qSyXuXe/Gbn1CDSc6rOPrT7OeOIreXn8ipE2phdmhoPrNjww
	 3hN5+oS59P85qJOTNaFblyMlxzM3iqF/9cUTxQ6DUjCOl6/UaUBvXYbBTEznXZ4EIV
	 TPJJs0XV+3RcvzJnOxC2paRPK5slqwa4HBoEKefeBj3LO3DIAA93Rpj5l+fdPB5pbF
	 jx+FQIfcX7kZ6pkjXAR3/lxs7qANsacH897S2mMma6YgvhwQDnP63ED1+qR1nk2WuA
	 y69cda//H+/PkmnBQilHZrG7WQD6ot9u4WQ06aCIVK8965KuuFwTAFWHGw6VVli851
	 u6H278nc1aOAA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 28 Nov 2025 17:46:06 +0100
Message-ID: <20251128-vfs-fixes-v618-8dea546e893b@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503; i=brauner@kernel.org; h=from:subject:message-id; bh=gqXKPbx6bAhHFAnWvPsvCD38nqglxkiPmPlhZAWr7JA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXrzZ3WbT/H3WHJdFZyuW5azmt00M4gx4cu7z/1TxS t/rT9rkO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSqc3whyfL7KzYoaUmbVMX rnqzS0vit+axUplF3p8mVGxg9rgw3YHhf13t4eXSOg1qd5UT+g1yJl3vFM/hbLtaf7fGP67Dtbm JCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains some final fixes for the current cycle:

- afs: Fix delayed allocation of a cell's anonymous key

  The allocation of a cell's anonymous key is done in a background thread
  along with other cell setup such as doing a DNS upcall. The normal key
  lookup tries to use the key description on the anonymous authentication
  key as the reference for request_key() - but it may not yet be set,
  causing an oops.

- ovl: fail ovl_lock_rename_workdir() if either target is unhashed

  As well as checking that the parent hasn't changed after getting the lock,
  the code needs to check that the dentry hasn't been unhashed. Otherwise
  overlayfs might try to rename something that has been removed.

- namespace: fix a reference leak in grab_requested_mnt_ns

  lookup_mnt_ns() already takes a reference on mnt_ns. grab_requested_mnt_ns()
  doesn't need to take an extra reference.

/* Testing */

gcc (Debian 15.2.0-7) 15.2.0
Debian clang version 19.1.7 (10)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d:

  Linux 6.18-rc7 (2025-11-23 14:53:16 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc8.fixes

for you to fetch changes up to d27c71257825dced46104eefe42e4d9964bd032e:

  afs: Fix delayed allocation of a cell's anonymous key (2025-11-28 11:30:10 +0100)

Please consider pulling these changes from the signed vfs-6.18-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc8.fixes

----------------------------------------------------------------
Andrei Vagin (1):
      fs/namespace: fix reference leak in grab_requested_mnt_ns

David Howells (1):
      afs: Fix delayed allocation of a cell's anonymous key

NeilBrown (1):
      ovl: fail ovl_lock_rename_workdir() if either target is unhashed

 fs/afs/cell.c       | 43 ++++++++-----------------------------------
 fs/afs/internal.h   |  1 +
 fs/afs/security.c   | 48 ++++++++++++++++++++++++++++++++++++++++--------
 fs/namespace.c      |  7 ++++---
 fs/overlayfs/util.c |  4 ++--
 5 files changed, 55 insertions(+), 48 deletions(-)

