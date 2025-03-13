Return-Path: <linux-fsdevel+bounces-43886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1090A5EF41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265F317069B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E965826462B;
	Thu, 13 Mar 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUrnCwXz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C52641DC;
	Thu, 13 Mar 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857206; cv=none; b=FsedAe2MQJ0wG5KvUhPU+yYqfvaDM7ubLfx/5jOPGiz9heeiiwDi45uMdG2zt/XHyDdPu472GrPJPE4R9Zjze+HLd5gubcnGtdJvWdSDzAACMRRyHgek3MYaSQLFOv/B8Vzqg0zFchsQs65dOJjHU67cQTeSwQGw1oFOlpOgAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857206; c=relaxed/simple;
	bh=XPChNfFXlAoEhDDQGCfLjaxmtcrf+d26j4cITHrFFaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mpr3+5EiGwc+sQX/rjyxz72J1Gd9o0ZyM78jF1fLsDFlMtu6FfQVLQw+rzh52KNSJcQh8ITHT7DD9XGX+WiyQcmPCjuiNNa6C4w4VP6BFjw9tFr338oAHOeg7sx3tr7A4tKMfnbJM0pGtr467PrfXHu75Z5//6kUwDHpI+KZaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUrnCwXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D330C4CEEB;
	Thu, 13 Mar 2025 09:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857205;
	bh=XPChNfFXlAoEhDDQGCfLjaxmtcrf+d26j4cITHrFFaM=;
	h=From:To:Cc:Subject:Date:From;
	b=KUrnCwXzugBobwjVxouwhmGfeB0FbL0KotVpkA+nMiAxJqGLyKPmFarApKHNkvHob
	 NBBqTG+H3n8kEuaYispMI++tro2enNEwgwCHvE3HAwcl+cDmrkQSf3TOUxVw78ACyr
	 1bszEhcq0kqU5JCLVKvRguf9sv4DdQ6+0UcOqj4p8ostIK6hyiI10q32LZ/YeWi8fB
	 Vo8ZfXdk0Qkm3uJkMyHAOlsHHtLUUjV87fbUQHFH91KADNicFupDOIRd9l0rRPCKWA
	 oDEYuyH6d1DCQ4RgtI0u0u2RWhWp4vcaI607kMeAqoYDldM1GF+r+/vCKyFM4khyD8
	 ArVvBDc7MMOhg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu, 13 Mar 2025 10:13:15 +0100
Message-ID: <20250313-vfs-fixes-a0e878b9a930@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=brauner@kernel.org; h=from:subject:message-id; bh=XPChNfFXlAoEhDDQGCfLjaxmtcrf+d26j4cITHrFFaM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRfWrh6wgGNRy2OD3meL53uFZPjnPrBfMpu2VULE/885 s3el2dS1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRZ7YM/9Mj5p9mfp/I8t94 6bUy6QNxXrJ28a31JxTWpy2PUzE0OcDwv/zhGf8V2TH8b67wTOzI2v7Z6Gdx17x7jfbMC9KOqe3 7xAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */

This contains various fixes for this cycle:

- Bring in an RCU pathwalk fix for afs. This is brought in as a merge
  from the vfs-6.15.shared.afs branch that needs this commit and other
  trees already depend on it.

- Fix vboxfs unterminated string handling.

/* Testing */

gcc version (Debian 14.2.0-8) 14.2.0
Debian clang version 19.1.4 (1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 00a7d39898c8010bfd5ff62af31ca5db34421b38:

  fs/pipe: add simpler helpers for common cases (2025-03-06 18:25:35 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc7.fixes

for you to fetch changes up to 986a6f5eacb900ea0f6036ef724b26e76be40f65:

  vboxsf: Add __nonstring annotations for unterminated strings (2025-03-11 13:06:39 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc7.fixes

----------------------------------------------------------------
Christian Brauner (1):
      Merge afs RCU pathwalk fix

David Howells (1):
      afs: Fix afs_atcell_get_link() to handle RCU pathwalk

Kees Cook (1):
      vboxsf: Add __nonstring annotations for unterminated strings

 fs/afs/cell.c     | 11 ++++++-----
 fs/afs/dynroot.c  | 15 +++++++++++++--
 fs/afs/internal.h |  2 +-
 fs/afs/proc.c     |  4 ++--
 fs/vboxsf/super.c |  3 +--
 5 files changed, 23 insertions(+), 12 deletions(-)

