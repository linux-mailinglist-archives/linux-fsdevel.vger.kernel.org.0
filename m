Return-Path: <linux-fsdevel+bounces-49764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA0AC22B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE16C4E71FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892B3C465;
	Fri, 23 May 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWyQ0Onz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F435959;
	Fri, 23 May 2025 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003967; cv=none; b=CQf7Mmc1BbfmEEq0HzLaRDMEraqbvTHOhzkw6Fq6lqtwElx/rTCu7jCpWoFKGXLOcIhuTm0vkOyap+jd8l4myur8tP6SGpUfbb3F4vMDUAZWNA185Uj3joAc8ud3EJ5NQZQaobtcbg1A/btL5VLdopbrQmE6s71DwHg5Y54tbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003967; c=relaxed/simple;
	bh=OUQkaRkvEiz/pdMgE3eL/orof3usA5g8/VZnQmg35FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGDIO8+YaZBbY6dNrPu+PSSPTBr0aGCSVV6fH4SINIcN75KkJV4JSQrrc2NUy3r3VCdmbneQifT3A4jmE8XKyQePsHFy8e2sVKwo/O2AdGl6B6P8CgLjC8fhhQmkRFYsghozFYjIOjQFLMVyLFrvUmfIroVA7lp7sToAePVlHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWyQ0Onz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB1C4CEE9;
	Fri, 23 May 2025 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748003966;
	bh=OUQkaRkvEiz/pdMgE3eL/orof3usA5g8/VZnQmg35FY=;
	h=From:To:Cc:Subject:Date:From;
	b=OWyQ0Onz/ByKuZhP+1YvsIl4pW7bDdjstkK4JhMNYESILdsTB2khdHoeE65ALx3J6
	 v/AG+ngk8Dpo/kPgN7BNknnLtPXCgv5vHyLa8l8GSyGKDq4Dkphqe8tX1/jNnCHSWb
	 i+0+STm93TeE/YlDJzJn38+y0YXIFcKjCYCBaRzLI1OgEdiL0ZOP0Zh0HKzEpxKjjd
	 kIzLPW9HKRR+HMOOkAaa96Kb3NqWaqtzTnddu0UDm04r0826zJj07w48Dkv0nwKUdE
	 lejA2GuSkggjBRMfQW49ENUB2aD7DKjp2j8dpWCkzBDEi9rozvGgAiCtXnSfSPN8vm
	 8q3T4rwWP0YSw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs mount api
Date: Fri, 23 May 2025 14:39:17 +0200
Message-ID: <20250523-vfs-mount-api-7c425ef2eee6@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=brauner@kernel.org; h=from:subject:message-id; bh=OUQkaRkvEiz/pdMgE3eL/orof3usA5g8/VZnQmg35FY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5JR/v2civrDoe4HMmTWS9avNNvP47f15vjWj66Mdl 7NDy/JPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5eYjhf8kk0x3CXqkqZ70n RItldUqv2O7dxmJvPd9xlrH7S62Jnxn+u70NcXqxVvYEc1DuttIPJ7rCz9S8vryFx/rPcVtfpW3 TWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This converts the bfs and omfs filesystems to the new mount api.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.mount.api

for you to fetch changes up to 759cfedc5ee7e5a34fd53a4412a4645204bf7f8d:

  omfs: convert to new mount API (2025-04-28 10:54:39 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.mount.api tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.mount.api

----------------------------------------------------------------
Pavel Reichl (2):
      bfs: convert bfs to use the new mount api
      omfs: convert to new mount API

 fs/bfs/inode.c  |  30 +++++++---
 fs/omfs/inode.c | 176 +++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 125 insertions(+), 81 deletions(-)

