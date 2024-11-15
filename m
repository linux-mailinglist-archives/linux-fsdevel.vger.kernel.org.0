Return-Path: <linux-fsdevel+bounces-34909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F12E9CE0CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25669288F3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487FA1CDA13;
	Fri, 15 Nov 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS4wFG1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FF1DA23;
	Fri, 15 Nov 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679156; cv=none; b=pEvUB0zHIOdyL8cNasWaZfrhTLJXIY8A4dT8Rxp5DDKWzQ0DFHVVeWzWUMtOmCIiStKwYjvbab6Qj337zN+MescwvFfoRoBbM/jrImyvZOctnSwgjaC3UJNOWrCxTVzD2gJBT/XBvxNcV1HgDcOZurPiyF14h3ZS3U1Nr4p9094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679156; c=relaxed/simple;
	bh=h2C2D4Q7BLuHi0lPIr5O4bCEtewWS9pz+R+mQwo6ZoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHhgepjhR5sfmwHbP80yn0VQb2crBIwy6CgY0FCbOe9JfhgPyViRVVWefGm9Jxqmf4xEWvdDcFYNN9aU1drh+JHd1i1zxq8pHOqC31ACk0ypf/4evCFyjE72IOpUerpJzwhboi9dK4m82fMtUurQ6gyjyl9skspc6s8LVgtAtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS4wFG1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4E8C4CECF;
	Fri, 15 Nov 2024 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679156;
	bh=h2C2D4Q7BLuHi0lPIr5O4bCEtewWS9pz+R+mQwo6ZoM=;
	h=From:To:Cc:Subject:Date:From;
	b=GS4wFG1vav5Una/f5QSv3P4f0KN/ViJ+V24LAWRAo88DpW/brbNsxcx6De5WSNbmq
	 dzQpOtRHN3FCLL1hLU1ie5b16uyC7OLzk1JwpBVu+0guEaDE8zkbv2kyeBvyoriMiF
	 hKld4UJ8or51OWSka+rs9jb9aDKULeY91W+Kq4Lyk0lwdahW61EQuFUsCQSFTNuHmM
	 zY9x+jGhTZ8YUTK3ouFQ43UP5NS12QgbmJLkqLleQqYWr4cPSaqvrfijqaxPvwv3H/
	 Cmu9gbJvV7PXki1eYOSJ+Av3IJet1Vl4MBglFXaPhyaoQyqPR7VkAYL6kln8OFefSF
	 NMe4C8bJdEN2Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs pagecache
Date: Fri, 15 Nov 2024 14:58:59 +0100
Message-ID: <20241115-vfs-pagecache-a00177616c8d@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2356; i=brauner@kernel.org; h=from:subject:message-id; bh=h2C2D4Q7BLuHi0lPIr5O4bCEtewWS9pz+R+mQwo6ZoM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbB6/TU7kayxuyhTdVWT59njAHwxs3OcFXvN3f2lUdD 17Uy7jfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHcjwz/g+bcPiHnZPvb54mc pplcZUhj7WJ5pZjpy+fdyGJ72Mipz/BXfHatwuyz51eu49dWkOXIlrulx6c8649w2qocad1+n43 cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Cleanup filesystem page flag usage: This continues the work to make the
mappedtodisk/owner_2 flag available to filesystems which don't use
buffer heads. Further patches remove uses of Private2. This brings us
very close to being rid of it entirely.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

(1) linux-next: manual merge of the vfs-brauner tree with the btrfs tree
    https://lore.kernel.org/r/20241101092212.1c112872@canb.auug.org.au

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.pagecache

for you to fetch changes up to c6bbfc7ce1567eb7928f22d92b6ad34d8e4ea22b:

  Merge patch series "Filesystem page flags cleanup" (2024-10-04 09:24:28 +0200)

Please consider pulling these changes from the signed vfs-6.13.pagecache tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.pagecache

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Filesystem page flags cleanup"

Matthew Wilcox (Oracle) (6):
      fs: Move clearing of mappedtodisk to buffer.c
      nilfs2: Convert nilfs_copy_buffer() to use folios
      mm: Remove PageMappedToDisk
      btrfs: Switch from using the private_2 flag to owner_2
      ceph: Remove call to PagePrivate2()
      migrate: Remove references to Private2

 fs/btrfs/ctree.h           | 13 ++++---------
 fs/btrfs/inode.c           |  8 ++++----
 fs/btrfs/ordered-data.c    |  4 ++--
 fs/buffer.c                |  1 +
 fs/ceph/addr.c             | 20 ++++++++++----------
 fs/nilfs2/page.c           | 22 +++++++++++-----------
 include/linux/page-flags.h |  4 ++--
 mm/migrate.c               |  4 ++--
 mm/truncate.c              |  1 -
 9 files changed, 36 insertions(+), 41 deletions(-)

