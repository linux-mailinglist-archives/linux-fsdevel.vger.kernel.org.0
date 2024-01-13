Return-Path: <linux-fsdevel+bounces-7906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447882CCB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 13:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F91C21743
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3A2110B;
	Sat, 13 Jan 2024 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/TsCCds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF1DDB5;
	Sat, 13 Jan 2024 12:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AF1C433F1;
	Sat, 13 Jan 2024 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705149140;
	bh=t2Rxld++6LxnRpwfNKlxPU3qyMSRsXCrdRX2fXTMQdY=;
	h=From:To:Cc:Subject:Date:From;
	b=g/TsCCdsCF+lflwqOWfY7INUWUY5fC/ElZLV7OPSkr36g3WcP9fKzDVn6GokaV9PF
	 7MaalnZ1UF8Jq1uhfsrM3XYpOStwyW3hhsxVnav1vWBeZtIAGgkcSGJ6aO0l+5lf8X
	 vO+Z4M1dtBzgfL1l/WRW5azB7GpTsraIupfkiyAdghRQcBz7UDpLpOyTZtVnPA325A
	 NA9/Rz77/Kr3t/qCru/iZYM6VQKgiT/QKZdU9xqt1zWa5MXdJg5+2CbpFKh0hhi2K6
	 omgw1nVSk3Yi9xpGTzBVsXHMwfwFhbYakzVxPYdmzNTlxkZR6vnTD7ntDAU1Y7ZdHD
	 iX9wdr6P4xBeA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Sat, 13 Jan 2024 13:31:03 +0100
Message-ID: <20240113-vfs-fixes-23fdefd76783@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763; i=brauner@kernel.org; h=from:subject:message-id; bh=t2Rxld++6LxnRpwfNKlxPU3qyMSRsXCrdRX2fXTMQdY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQuaupl28ihu1z4y++IddNjH131E9xoeoRDqz7lT6ID4 8IPj8V/dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE9SUjwwwL64WTVbrcDGxP RysL/zu78ZSAp8K1deo5bbsWXpJj8mRkaHz9LnLtkspvry/IRAgHrQxSCTywlrG061acfYarwuH l/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains two fixes for the current merge window. The listmount changes
that you requested and a fix for a fsnotify performance regression:

* The proposed listmount changes are currently under my authorship. I wasn't
  sure whether you'd wanted to be author as the patch wasn't signed off. If you
  do I'm happy if you just apply your own patch.

  I've tested the patch with my sh4 cross-build setup. And confirmed that a)
  the build failure with sh on current upstream is reproducible and that b) the
  proposed patch fixes the build failure. That should only leave the task of
  fixing put_user on sh.

* The fsnotify regression was caused by moving one of the hooks out of the
  security hook in preparation for other fsnotify work. This meant that
  CONFIG_SECURITY would have compiled out the fsnotify hook before but didn't
  do so now. That lead to up to 6% performance regression in some io_uring
  workloads that compile all fsnotify and security checks out. Fix this by
  making sure that the relevant hooks are covered by the already existing
  CONFIG_FANOTIFY_ACCESS_PERMISSIONS where the relevant hook belongs.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on mainline as of yesterday. No build failures or
warnings were observed. I've successfully tested the changes to listmount with
the selftests we added.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 70d201a40823acba23899342d62bc2644051ad2e:

  Merge tag 'f2fs-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2024-01-11 20:39:15 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc1.fixes

for you to fetch changes up to ba5afb9a84df2e6b26a1b6389b98849cd16ea757:

  fs: rework listmount() implementation (2024-01-13 13:06:25 +0100)

Please consider pulling these changes from the signed vfs-6.8-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.8-rc1.fixes

----------------------------------------------------------------
Amir Goldstein (1):
      fsnotify: compile out fsnotify permission hooks if !FANOTIFY_ACCESS_PERMISSIONS

Christian Brauner (1):
      fs: rework listmount() implementation

 fs/namespace.c           | 50 +++++++++++++++++++++++++++---------------------
 include/linux/fsnotify.h | 19 ++++++++++++++++++
 include/linux/syscalls.h |  2 +-
 3 files changed, 48 insertions(+), 23 deletions(-)

