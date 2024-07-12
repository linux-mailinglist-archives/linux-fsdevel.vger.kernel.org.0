Return-Path: <linux-fsdevel+bounces-23611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890892FBF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037A5283255
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700917109D;
	Fri, 12 Jul 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow6CZxAG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746A16D4C0;
	Fri, 12 Jul 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792648; cv=none; b=nFwlU+Y9lbE1wO+18EIBAOS+24e1B/z65ToPWxqt6yxn/4wKwBCUdAv171ABXLWL0vxUoin9CJKoHEfItq/v3jdT4WTTqEEeCHJK7a0bJOnvxX/uusDJVB43AHrxOoQGoTNDrUuAQ3xoC6k6Z6f7I6K9jJKiqmplXrz679aiyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792648; c=relaxed/simple;
	bh=Uyk6AB+bYksY/VYkF5ya+cDeE1LChcPYgC0umXpAbxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQP70mC4MikF2pw5sJPDCx7TicxjEE5CgUuDUSd8Jyj9xI8kX7ee1C2J3CfpX4Edb4ubhfSpNY1BFR8mxgBLZ/qvuh+fxVpvc7GX3ZH0deB9QilhyjkZ1x1JcuClhGu1DQApoIlb/ekxTEAcugEgGRklHlexDj/kRNJ+033b/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow6CZxAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77934C32782;
	Fri, 12 Jul 2024 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792648;
	bh=Uyk6AB+bYksY/VYkF5ya+cDeE1LChcPYgC0umXpAbxs=;
	h=From:To:Cc:Subject:Date:From;
	b=ow6CZxAGBcyK2UM1Gctp288Oeu3BFBJX9fojunjCbkFAcrnJo2FLp7aep/Mn+y7J2
	 P+Um0D+G3MK5wgDImAEj9qq+1SSCvxudgVkTzxdEuk+wJSMF3PHyW5yTUQrnrLVVXu
	 N23op0RxQcFaj9JiRdaj06bYqnMK/az+/Ao06CBau9mTjKaH6mCDf22foYen+WeEjK
	 Da7YSFmPY5nzWomLB31kk3KAXJiiO3W/Psm2nR9WlGNNsfpzuTgNS3qb5xbxggTQ3H
	 FLf/aWVNoPqRQ/o4FMoHc6dEGPlhKCZoHbxM+aSi6Iml83HCV7+AJ1hsWkulWjXbyX
	 d9muGJy7+Bujw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs casefold
Date: Fri, 12 Jul 2024 15:57:15 +0200
Message-ID: <20240712-vfs-casefold-816b45ce2d57@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=brauner@kernel.org; h=from:subject:message-id; bh=Uyk6AB+bYksY/VYkF5ya+cDeE1LChcPYgC0umXpAbxs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNLN788+0N7xaeN3VKFmWxlVGTVd4zzyfsTp00pS2q I5fE9irOkpYGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy4wLDj5Vt+8PME/9dXFh9 fLX30R3b62p3/tz4VMh+R9XJ70cPSTH8jzx44JnXj1U7ttZoV77iXHvywEw9xclHxPet3lUaP3e eAxcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains some work to simplify the handling of casefolded names:

- Simplify the handling of casefolded names in f2fs and ext4 by keeping the
  names as a qstr to avoiding unnecessary conversions.

- Introduce a new generic_ci_match() libfs case-insensitive lookup helper and
  use it in both f2fs and ext4 allowing to remove the filesystem specific
  implementations.

- Remove a bunch of ifdefs by making the unicode built checks part of the code
  flow.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.casefold

for you to fetch changes up to 28add38d545f445f01eec844b85eed4593c31733:

  f2fs: Move CONFIG_UNICODE defguards into the code flow (2024-06-07 17:00:45 +0200)

Please consider pulling these changes from the signed vfs-6.11.casefold tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.casefold

----------------------------------------------------------------
Gabriel Krisman Bertazi (7):
      ext4: Simplify the handling of cached casefolded names
      f2fs: Simplify the handling of cached casefolded names
      libfs: Introduce case-insensitive string comparison helper
      ext4: Reuse generic_ci_match for ci comparisons
      f2fs: Reuse generic_ci_match for ci comparisons
      ext4: Move CONFIG_UNICODE defguards into the code flow
      f2fs: Move CONFIG_UNICODE defguards into the code flow

 fs/ext4/crypto.c   |  10 +----
 fs/ext4/ext4.h     |  35 +++++++++------
 fs/ext4/namei.c    | 122 ++++++++++++++++-------------------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 105 ++++++++++++++-------------------------------
 fs/f2fs/f2fs.h     |  16 ++++++-
 fs/f2fs/namei.c    |  10 ++---
 fs/f2fs/recovery.c |   9 +---
 fs/f2fs/super.c    |   8 ++--
 fs/libfs.c         |  74 ++++++++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 195 insertions(+), 202 deletions(-)

