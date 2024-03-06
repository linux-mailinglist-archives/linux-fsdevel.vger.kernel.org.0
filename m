Return-Path: <linux-fsdevel+bounces-13772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90252873B0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11481C2258D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0613540E;
	Wed,  6 Mar 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSwGhMyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82264133402;
	Wed,  6 Mar 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739942; cv=none; b=pJbtD6iKC9netI0AiwomCSVBHbzamEUfGH5rUgWDM5fGkPeUfgIrsTrzihDIkaHkjTR2Z7ixsERPLmk314GuxMB1N2LkR+x43Gd9JlXpZ8d86ghWQcrKye5yqFrMheCus5fdD24Hls5OlRJOVrqb3VXLHTF2OYaPry01elrT6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739942; c=relaxed/simple;
	bh=Ftuq41PzbFHr/8KgHVscUxW7Bf3SXW0yTv1U4T5F8Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1YPUFRLroLTiaaTb3ZqYwC8QULFH5d3tEXkoDYNO0bTcfr/cuEdZdssMwIH4rZZgezVLYISf0LhkEuk7Qwoy43fzJosyVumbX86f8mPUHS4URd3ccFHVZrG3CN1cmWc87o8q1K31wJjIPIGabiWeNHu9OzZqqbuCP/fPGbdhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSwGhMyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8E5C433F1;
	Wed,  6 Mar 2024 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709739942;
	bh=Ftuq41PzbFHr/8KgHVscUxW7Bf3SXW0yTv1U4T5F8Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=LSwGhMyuGlrSgm3hK1t7CzWTJyisrR6O09rIZ8Dz2XqjLUwkZxgu7Ey1vVQ4VYOGf
	 Im0lH7cm99nBZdv9Prt/yBCrADQqOmGP97tlzIP3uTQH8bgRDXW23J0VBSWksya3lm
	 Jv+lpfvRu9EicDekBTPQg4nAjnrfpOKSeP/tqBzo9l/kT4kM4xPiatEWQjZ5AHpWqk
	 sFaujhhodSWHpWuhVFpLZ2pOvEP0tRBn6OSniJyF8mLhWrcYHenrgCnEdShm0++Ckq
	 jp0ERfB0uKnAC6JtDZsLxK3VGBT6XBRd4IMYnS1eVYLINPUJhu/5n2v/CK34XjNyWu
	 hYVB5efQNH9dw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Wed,  6 Mar 2024 16:45:13 +0100
Message-ID: <20240306-vfs-fixes-e08261f0e45a@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=brauner@kernel.org; h=from:subject:message-id; bh=Ftuq41PzbFHr/8KgHVscUxW7Bf3SXW0yTv1U4T5F8Lc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+6J91z92u54m55lyrCVFmfVqvPA6wJH866/3N75HTN 9fOxKv/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi1svw30+BYXnQff9ffVtX HOb42jIl29il5kjz94jSf9O4Hx92bGT4Z8XpwvxWpW/SF7b/Oy7o8Ozcmbn7/1LDW/cOe12IfbE +kRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains three fixes:

* Get rid of copy_mc flag in iov_iter which really only makes sense for
  the core dumping code so move it out of the generic iov iter code and
  make it coredump's problem. See the detailed commit description.
* Revert fs/aio: Make io_cancel() generate completions again
  The initial fix here was predicated on the assumption that calling
  ki_cancel() didn't complete aio requests. However, that turned out to
  be wrong since the two drivers that actually make use of this set
  a cancellation function that performs the cancellation correctly.
  So revert this change.
* Ensure that the test for IOCB_AIO_RW always happens before the read
  from ki_ctx.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc7 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-release.fixes

for you to fetch changes up to a50026bdb867c8caf9d29e18f9fe9e1390312619:

  iov_iter: get rid of 'copy_mc' flag (2024-03-06 10:52:12 +0100)

Please consider pulling these changes from the signed vfs-6.8-release.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.8-release.fixes

----------------------------------------------------------------
Bart Van Assche (2):
      Revert "fs/aio: Make io_cancel() generate completions again"
      fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Linus Torvalds (1):
      iov_iter: get rid of 'copy_mc' flag

 fs/aio.c            | 35 ++++++++++++++++++++++-------------
 fs/coredump.c       | 45 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/uio.h | 16 ----------------
 lib/iov_iter.c      | 23 -----------------------
 4 files changed, 64 insertions(+), 55 deletions(-)

