Return-Path: <linux-fsdevel+bounces-49771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116ADAC22F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF64A25578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E32C859;
	Fri, 23 May 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lETD6H8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB78136351;
	Fri, 23 May 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004570; cv=none; b=TDA+aC76dNtkgl6nUv/cfwD3qu2w1t4KMeqrStaGPAnYxBT1bLUtIu5Z65O5tYwLthgXHu67f47TAkhfcRBo31Ed6tn6gniaX/nr7L2ivJpx0tY6uXO7QkF4dlklTDjbRuJwUY8k91RNIgchnSQyuaGIHASb4OlcpT2+R+ZHp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004570; c=relaxed/simple;
	bh=oYSERoZVkIwf/mlHFZCDcywmHo4m4e+XX1h2/mtLxMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQJSK1wyUAjdV7DFH/ReKIL0OuLsYgH86a6a2bZwt34Lz1spsKQoaBzevlZV7TlXg4BOR4ILs/M3l3JHJpmNTCWtcrxZWwMuktzLjb37St1VrYciE7sFAjpKFBsL/vUeP/N8hmheaB5TxqLjNiD/N72EpVV1U8jTuvpaH2i5YZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lETD6H8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF9BC4CEE9;
	Fri, 23 May 2025 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004569;
	bh=oYSERoZVkIwf/mlHFZCDcywmHo4m4e+XX1h2/mtLxMs=;
	h=From:To:Cc:Subject:Date:From;
	b=lETD6H8EO0bALoGfX7lnnsP424ZTYlVeYT1go2ockRaV61gMgtfjEuRus6sgtW6qa
	 6JL3LWgeQYT+V0NFa0m1wogiJifWisI0jzNQ+IycUGvSAbxDFYwQQwQiChuyLVW53O
	 NrPEqy0IzKAamSvHsPh4hwZooWDcUBGCXuVgFGD6iFKORjb23L2BHBmDTjhBmdo/pE
	 gnvJA88kA71QNPzwsvWhiol+QLwByDqrhGqPQwjTtzSgCp7w5XcVcZU9UNwe9H8+mE
	 /qxZeoeLe6nEEAiFdnogAm9LUfYY4AGUxNdhOLiucSvqPFTv9UpbkLNYZFu8WyIaaO
	 OJS6EyYZL2XwQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs iomap
Date: Fri, 23 May 2025 14:49:22 +0200
Message-ID: <20250523-vfs-iomap-e3468c51c620@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2394; i=brauner@kernel.org; h=from:subject:message-id; bh=oYSERoZVkIwf/mlHFZCDcywmHo4m4e+XX1h2/mtLxMs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5F3ZWn9vg/AXuw1tikmv9grdX/Qvo7Lqi6hp5sZFL my/cmcadZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkhwPD/0TrZu0Hf7zvr+hp 0ex0S3qa+1Pbi/+Q69eJZtWPz625mMvIsHJuo5yD0KGYd8zVwgtCLlhubM0svRh5t/7E1wsHV+x dyg0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains iomap updates for this cycle:

- More fallout and preparatory work associated with the folio batch prototype
  posted a while back. Mainly this just cleans up some of the helpers
  and pushes some pos/len trimming further down in the write begin path.

- Add missing flag descriptions to the iomap documentation.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.iomap

for you to fetch changes up to 2cb0e96cb01b4d165d0cee4d26996bb2b02a5109:

  Merge patch series "iomap: misc buffered write path cleanups and prep" (2025-05-09 12:35:35 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.iomap

----------------------------------------------------------------
Brian Foster (6):
      iomap: resample iter->pos after iomap_write_begin() calls
      iomap: drop unnecessary pos param from iomap_write_[begin|end]
      iomap: drop pos param from __iomap_[get|put]_folio()
      iomap: helper to trim pos/bytes to within folio
      iomap: push non-large folio check into get folio path
      iomap: rework iomap_write_begin() to return folio offset and length

Christian Brauner (2):
      Merge patch series "Documentation: iomap: Add missing flags description"
      Merge patch series "iomap: misc buffered write path cleanups and prep"

Ritesh Harjani (IBM) (2):
      Documentation: iomap: Add missing flags description
      iomap: trace: Add missing flags to [IOMAP_|IOMAP_F_]FLAGS_STRINGS

 Documentation/filesystems/iomap/design.rst |  16 ++++-
 fs/iomap/buffered-io.c                     | 100 +++++++++++++++++------------
 fs/iomap/trace.h                           |  27 ++++++--
 3 files changed, 93 insertions(+), 50 deletions(-)

