Return-Path: <linux-fsdevel+bounces-62869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5789BA3619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909A9174267
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399F32F3607;
	Fri, 26 Sep 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruQqIn5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3B21D3CA;
	Fri, 26 Sep 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883178; cv=none; b=GLY6rI27hbs/IfUg0lh+xhOOC6HE+S1EmxjB3lcIxrkEuO9WqjKvwcMRXLbA0ZfOA8xrSfzyGArJkt0Y0NLyPUirTvdajKMb60pR971ZwyRvdk2Ud7xQl7sdP7s/0DNCRw9/msICQW6xTMa8ooGvQgaX0jlTn6rkgOWmmBAUGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883178; c=relaxed/simple;
	bh=NaREPQyslYpw3yZG2Tv5+CbuYH4zU8itwcqQWQ+T/QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNFYbumxoWXE35RcoExSmkOWc3VkQ8vlAW0kzBnFabmQ1uWWYuMROQnwNVi3O8NDpa1kDpmMj571YtXYM57J4YV8n8fNFxBBwsMUIFXLs4K9d1B6/D3ZVngfaN58RQmiahv2su60PIw0RN4ztDzRzy50LRyol0HuhhSCec80VWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruQqIn5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BCCC4CEF4;
	Fri, 26 Sep 2025 10:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758883178;
	bh=NaREPQyslYpw3yZG2Tv5+CbuYH4zU8itwcqQWQ+T/QY=;
	h=From:To:Cc:Subject:Date:From;
	b=ruQqIn5ND+xfYOf49puUia1tRETmhf7seGZbtekNQweUUhURpTvPZoMjgo+5RvLG4
	 zKkgzt40vRS8e4hH0bmIsDEGga5+/kzi43MdCH+iWoI78lSiwjyuq1I+GotDNJ9Vhq
	 V+81WEAfOilQd9fnHLPz5mHLMhXw6wZQHEoB1WD5n4C44NiLsAaCZ/1HNJa7JRBTKl
	 IBRDgR9qHs8GZnkr5u8OqG4zMxlV6AJEk38ona1Nvt3MUkVTMxuqy8EO03lAbilRJx
	 qlKN3rJeObek+WyQIroW81aYuQMUKYGdA57Hbb2yf7JR4nB5KweReeLExSCUN7E7RL
	 9QE5ammZSNL/Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 26 Sep 2025 12:39:22 +0200
Message-ID: <20250926-vfs-fixes-16a994dd1ae5@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=brauner@kernel.org; h=from:subject:message-id; bh=NaREPQyslYpw3yZG2Tv5+CbuYH4zU8itwcqQWQ+T/QY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcy028PVV/S1MLg06/5+292//sPrV42meNI83rb/95y LeqV+v3245SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ8Okx/C/9OfPYMr6Dudzv 25U7bnoItOc42hwU//IilDFPPuSccjAjw/rmuHWbouMfqOhxr8l7yF2/3yh2Y7G19cmZtt2lpWs WMwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few final fixes for this cycle:

- Prevent double unlock in netfs.

- Fix a NULL pointer dereference in afs_put_server().

- Fix a reference leak in netfs.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc8.fixes

for you to fetch changes up to 4d428dca252c858bfac691c31fa95d26cd008706:

  netfs: fix reference leak (2025-09-26 10:14:19 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc8.fixes

----------------------------------------------------------------
Lizhi Xu (1):
      netfs: Prevent duplicate unlocking

Max Kellermann (1):
      netfs: fix reference leak

Zhen Ni (1):
      afs: Fix potential null pointer dereference in afs_put_server

 fs/afs/server.c           |  3 ++-
 fs/netfs/buffered_read.c  | 10 +++++-----
 fs/netfs/buffered_write.c |  2 +-
 fs/netfs/direct_read.c    |  7 ++++++-
 fs/netfs/direct_write.c   |  6 +++++-
 fs/netfs/internal.h       |  1 +
 fs/netfs/objects.c        | 30 +++++++++++++++++++++++++++---
 fs/netfs/read_pgpriv2.c   |  2 +-
 fs/netfs/read_single.c    |  2 +-
 fs/netfs/write_issue.c    |  3 +--
 10 files changed, 50 insertions(+), 16 deletions(-)

