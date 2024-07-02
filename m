Return-Path: <linux-fsdevel+bounces-22975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090C92488C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 21:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733C51C22B61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6181BBBF3;
	Tue,  2 Jul 2024 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb6kHIgP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0D14F7A;
	Tue,  2 Jul 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949551; cv=none; b=HusuNPnOhSWqGTN42igCc0RATbCwsC3YkRp0rDUjrlMXlcQrGWDlS1odXQ8NzspleTmw+MJTLYptU8PeMzQGScqti1L62TpcvIZtgwNaykKmkGkm5FxzQEfCkTzaXRvkPM2eQsu9y9C+axnSydog0Uq8F1aw+Gmaa3nIQRtUk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949551; c=relaxed/simple;
	bh=hGfQI2Ehn8ygen6cblJjPQfXi2Rj/CizY3+P7kvje9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oF7gbZ9q1U/vX2ORvXlTuPVxTLhoHeGHOlWKEh3U2tZbgk8fOzSqUANzfX/Cc33toQ+3qdrwUtvfeaACaiAobo1ltzlpo1ukYBM6mqCG80f8MO8xYGVksTaFsObKtGnghVTu7SprTjWNF1VYUvPz7UaTxCZ15hETwn7lc4gzQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb6kHIgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E96C116B1;
	Tue,  2 Jul 2024 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719949551;
	bh=hGfQI2Ehn8ygen6cblJjPQfXi2Rj/CizY3+P7kvje9k=;
	h=From:To:Cc:Subject:Date:From;
	b=lb6kHIgPsIUe/XXB8mnxMkCwvEqZrnfuANbXJDv6H8VSjtvDhJwHx35M5wVEtsQy8
	 7Ifle3iN8HI0qDnJSlEF3zaG8m9884bB+RdGVOPbX3quS0FBJg1dRlM9W6xpiqPhDx
	 Nn/nlOTU2RJEawQhcqfOGlBUCtvhZrDSlxVIKH8NQaNSV1vfXunrM1cbAof5Th4UER
	 x+ADmYk5WWKxETwHrb3vnxrJi4qCkBb1jK4x9ByIz3UAeZlaIQ5VFEbWqGEvN14Mir
	 fxYVtb6BwDY7w+tHQ/BprvZFvCqcd3f1MfGXSRr9Dlne5lWkzkjuHSD/8OFD7wv3Ld
	 DEXeV4lAu4RPA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Tue,  2 Jul 2024 21:44:27 +0200
Message-ID: <20240702-vfs-fixes-7b80dba61b09@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=brauner@kernel.org; h=from:subject:message-id; bh=hGfQI2Ehn8ygen6cblJjPQfXi2Rj/CizY3+P7kvje9k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1RNyYafXWnTF/dvv/GW4bHtVw/operZ8ibmd30j61c deXDJ/NHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpamP4H/7o9bG5NQfXTVJ/ fL8x+F6O1dOTVw/MeOV07gzHlmepT+cw/C+7ePnF/3v36u85q4Z73BG/HWK8r367SvU3thDT+9L 9xswA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains three fixes:

VFS:

- Improve handling of deep ancestor chains in is_subdir().
- Release locks cleanly when fctnl_setlk() races with close().
  When setting a file lock fails the VFS tries to cleanup the already
  created lock. The helper used for this calls back into the LSM layer
  which may cause it to fail, leaving the lock accessible via
  /proc/locks.

AFS:

- Fix a comma/semicolon typo.

/* Testing */
clang: Debian clang version 16.0.6 (27)
gcc: (Debian 13.2.0-25) 13.2.0

All patches are based on v6.10-rc6. No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc7.fixes.2

for you to fetch changes up to 655593a40efc577edc651f1d5c5dfde83367c477:

  afs: Convert comma to semicolon (2024-07-02 21:23:00 +0200)

Please consider pulling these changes from the signed vfs-6.10-rc7.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10-rc7.fixes.2

----------------------------------------------------------------
Chen Ni (1):
      afs: Convert comma to semicolon

Christian Brauner (1):
      fs: better handle deep ancestor chains in is_subdir()

Jann Horn (1):
      filelock: Remove locks reliably when fcntl/close race is detected

 fs/afs/inode.c |  4 ++--
 fs/dcache.c    | 31 ++++++++++++++-----------------
 fs/locks.c     |  9 ++++-----
 3 files changed, 20 insertions(+), 24 deletions(-)

