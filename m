Return-Path: <linux-fsdevel+bounces-30376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A098A5C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B086B1C216C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05D18FC9F;
	Mon, 30 Sep 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdi6RxGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CA17C21B;
	Mon, 30 Sep 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704003; cv=none; b=r9TkaDUSPxNWz9HNBy9gsSkcGye/OncNPRgRmZIg9BBVrpLaOP2/NXt4fcGrY2/B4uvpzGkYBnJFvG3TkF+ba8aKqlVMh06J8Plqjw9saeYXGtM1S14+IqmsDMCizk8J5NzGgtI/rETOuBrr/l3NuQzRFVF8/2Q1z26ALQk8SS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704003; c=relaxed/simple;
	bh=GxAiUuq0Wy2S7R+JT9seOJxEAJ7pXPNyTraE+Y9IWk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyqyiWKNGRtHlbUxc6kIkOHZNTSC6NTvd59cKFOZOObqlmV8W+j0sWaDyfcXZK3b9sRoThGYpGSoAE1O60EIA6eDNg/uoLXfKvJNwy66s0rm/PMwmQjQTGRsNr8A4ZBRccBoXIlvse5U20w2dN11P69h9ODXqF+tPoqVJ0MKyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdi6RxGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBA6C4CEC7;
	Mon, 30 Sep 2024 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704003;
	bh=GxAiUuq0Wy2S7R+JT9seOJxEAJ7pXPNyTraE+Y9IWk4=;
	h=From:To:Cc:Subject:Date:From;
	b=Rdi6RxGGBxYXeYLiJVuDnkk5oKeFX47e2I/R54i4091f1K3YGfwwjFPMVvsFLl8AH
	 nQnaLCLpxBYsMc7GSXsSiKaiNfpBSgWXGnDwEXVtGnCslKKuqG0FsiD1+D2TugGZNC
	 qkvH3tVtdJhv5TP/8wcC31YZ1wdRSQcNlxVlu0iBbZwUqugdK0k+4SGAgBQTPSatDC
	 qAG3UIVqR2tww6Xuttz7W8jpC+FmL3U+IU0eDbK3jPoopIq/zFWmav0MtOl8RXupm1
	 uNabCiIK0CSUy2TnXp6JrgfMvpksjvViCEjcU31G7mLwVFPXChBU0SlTbYCW+nATAS
	 4NsogbeGiJ72g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 30 Sep 2024 15:46:29 +0200
Message-ID: <20240930-vfs-fixes-cfedf8d8fa81@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3004; i=brauner@kernel.org; h=from:subject:message-id; bh=GxAiUuq0Wy2S7R+JT9seOJxEAJ7pXPNyTraE+Y9IWk4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9Wr29IvPCp19itadrjTO3LUppst2nrnRq2981uzOb7 p+Z9f1LfUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEwgsY/tk4L6h17MlTa0/5 6GJqcOvL7d39SceyLn51PnYyTT3mmS/DPxUHyQMnajYxb7jBJMNo8GralmOy+gL5Swz6X3J+zn1 8lw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains fixes for this merge window:

afs:

- Fix setting of the server responding flag.

- Remove unused struct afs_address_list and afs_put_address_list() function.

- Fix infinite loop because of unresponsive servers.

- Ensure that afs_retry_request() function is correctly added to the
  afs_req_ops netfs operations table.

netfs:

- Fix netfs_folio tracepoint handling to handle NULL mappings.

- Add a missing folio_queue API documentation.

- Ensure that netfs_write_folio() correctly advances the iterator via
  iov_iter_advance().

- Fix a dentry leak during concurrent cull and cookie lookup operations in
  cachefiles.

pidfs:

- Correctly handle accessing another task's pid namespace.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

/* Conflicts */

No known conflicts.

The following changes since commit 075dbe9f6e3c21596c5245826a4ee1f1c1676eb8:

  Merge tag 'soc-ep93xx-dt-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2024-09-26 12:00:25 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc2.fixes

for you to fetch changes up to f801850bc263d7fa0a4e6d9a36cddf4966c79c14:

  netfs: Fix the netfs_folio tracepoint to handle NULL mapping (2024-09-30 14:11:05 +0200)

Please consider pulling these changes from the signed vfs-6.12-rc2.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12-rc2.fixes

----------------------------------------------------------------
Baokun Li (1):
      cachefiles: fix dentry leak in cachefiles_open_file()

Christian Brauner (1):
      pidfs: check for valid pid namespace

David Howells (5):
      afs: Fix missing wire-up of afs_retry_request()
      afs: Fix the setting of the server responding flag
      netfs: Advance iterator correctly rather than jumping it
      netfs: Add folio_queue API documentation
      netfs: Fix the netfs_folio tracepoint to handle NULL mapping

Marc Dionne (1):
      afs: Fix possible infinite loop with unresponsive servers

Thorsten Blum (1):
      afs: Remove unused struct and function prototype

 Documentation/core-api/folio_queue.rst | 212 +++++++++++++++++++++++++++++++++
 fs/afs/afs_vl.h                        |   9 --
 fs/afs/file.c                          |   1 +
 fs/afs/fs_operation.c                  |   2 +-
 fs/afs/fs_probe.c                      |   4 +-
 fs/afs/rotate.c                        |  11 +-
 fs/cachefiles/namei.c                  |   7 +-
 fs/netfs/write_issue.c                 |  12 +-
 fs/pidfs.c                             |   5 +-
 include/linux/folio_queue.h            | 168 ++++++++++++++++++++++++++
 include/trace/events/netfs.h           |   3 +-
 11 files changed, 410 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/core-api/folio_queue.rst

