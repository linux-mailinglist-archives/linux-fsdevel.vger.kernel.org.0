Return-Path: <linux-fsdevel+bounces-34906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E610F9CE0B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB76228E490
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60F18E023;
	Fri, 15 Nov 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsEg0O17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB261DA23;
	Fri, 15 Nov 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678907; cv=none; b=MAfdMt5wB3jwU2QPuWNp3GPG4wtNKVFfDUtwRpbi2xz4hKbDKPXAIRrgNl//Nk24lpBtmxyUbfz+sApeZ1G5vdD4Ge/Avm5h7wmoMqLyEyhL6Ljqtnu8hGXAFRqHfz0Jbif9IsuAJPB5GVrBT+Mj/rQ96hdP095ewddPe6QnsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678907; c=relaxed/simple;
	bh=MfjnwDVnHCvzo3pGwHwmRWPuFm514e2wRZeJpILxg2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9qg5OpuralOGVgJb3EWHAK3D3Yop/HRO182+K+RIuk1pjnSziBs7FDMr+lzJ9qu0X14qmLYp0EQW7cUJP4TBnonaiDIQi/U4CR7V5VDGztZezjFrcxsFcKB57Eq7f2NhlTfchf7+ZLHqfrZoPdg5SOQ2rG4/7ZUIKtctLgSHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsEg0O17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F307EC4CECF;
	Fri, 15 Nov 2024 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731678906;
	bh=MfjnwDVnHCvzo3pGwHwmRWPuFm514e2wRZeJpILxg2c=;
	h=From:To:Cc:Subject:Date:From;
	b=NsEg0O17zkAji3Xca3xZWV9qlglny77MlMDO51FsmIO8KbbkBUuq44h/2vsht1Mcs
	 nXZCTxMsC0FxyeHfGsd/2a7nZYuvLHm9+ng2W4fUDrFZIKp97b9vsCl1CLWzYdzAOu
	 VNkVi80AxOsUD4fkZ4SZe0PjKRLQdbCIFSs5IrEuU4CWGOFfKuuBi+Ou3STkUv99Jb
	 Z4nPBUNRTBEsgMrw8jPBzMTe5AWFw2HRXwjbIcMUtYmImONYW/hVTSv97Fq8E+q8zG
	 GtmeYQeq2sP8esCXZ/ODa/TFdZ4gfLSNShCKKetIVU07taLi/9oXsPSH8+A9sRtwT2
	 ibVr4lvC8wXbw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount api conversions
Date: Fri, 15 Nov 2024 14:54:56 +0100
Message-ID: <20241115-vfs-mount-api-6ab5111dc7c2@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2598; i=brauner@kernel.org; h=from:subject:message-id; bh=MfjnwDVnHCvzo3pGwHwmRWPuFm514e2wRZeJpILxg2c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbB216uPVWledFw/7w75anuWdlqlzvfCV3SCTF/P3/K V1fVCc/6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjImS6G/76zCtZHaPT6/jnO /6rq3pqwLEcDaT0tr3/iD0tS7ESCmhj+KUX9+P3m1sfT4nO3xrtG7TndyHM9e1N2ruaO5hkZl6N 2swAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains work to convert adfs, affs, befs, hfs, hfsplus, jfs, and
hpfs to the new mount api.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.mount.api

for you to fetch changes up to 51ceeb1a8142537b9f65aeaac6c301560a948197:

  efs: fix the efs new mount api implementation (2024-10-15 15:58:36 +0200)

Please consider pulling these changes from the signed vfs-6.13.mount.api tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.mount.api

----------------------------------------------------------------
Bill O'Donnell (1):
      efs: fix the efs new mount api implementation

Christian Brauner (1):
      Merge patch series "adfs, affs, befs, hfs, hfsplus: convert to new mount api"

David Howells (1):
      ubifs: Convert ubifs to use the new mount API

Eric Sandeen (7):
      adfs: convert adfs to use the new mount api
      affs: convert affs to use the new mount api
      befs: convert befs to use the new mount api
      hfs: convert hfs to use the new mount api
      hfsplus: convert hfsplus to use the new mount api
      jfs: convert jfs to use the new mount api
      hpfs: convert hpfs to use the new mount api

 fs/adfs/super.c         | 186 +++++++++----------
 fs/affs/super.c         | 374 +++++++++++++++++++-------------------
 fs/befs/linuxvfs.c      | 199 ++++++++++----------
 fs/efs/super.c          |  43 +----
 fs/hfs/super.c          | 342 ++++++++++++++++-------------------
 fs/hfsplus/hfsplus_fs.h |   4 +-
 fs/hfsplus/options.c    | 263 ++++++++++-----------------
 fs/hfsplus/super.c      |  84 +++++----
 fs/hpfs/super.c         | 414 +++++++++++++++++++++---------------------
 fs/jfs/jfs_filsys.h     |   1 +
 fs/jfs/super.c          | 469 +++++++++++++++++++++++++-----------------------
 fs/ubifs/super.c        | 399 ++++++++++++++++++++--------------------
 12 files changed, 1346 insertions(+), 1432 deletions(-)

