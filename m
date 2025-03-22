Return-Path: <linux-fsdevel+bounces-44766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 382FDA6C903
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DA21B61709
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADFE1F4E54;
	Sat, 22 Mar 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4xRJQuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E441F03F0;
	Sat, 22 Mar 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638467; cv=none; b=f4553VBeMcLnXTfsmhD/WGNkMD1YG7h8du2xAParjP1TijuHmhymSEE8uhRqIbF48rVPfgLSBgnxmEhqmb6kSncnQoGhwSL+hnWzpRYpGobWlp6o9hhA+9vDi7Ms8JgQFJZGyQgYsIZfTPbuNRL2uhN0XvZVAdHM2htyIoCCEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638467; c=relaxed/simple;
	bh=mQSuwrntYEMg0m0zhElfPTystgEzsEcXX+jk3CB1OUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYUNyX9uWYLFVtD/ZyLWZMUcG2iNVmILyu2a7LYux/Q49yHT4KRK3qz79j/dWzhCOWfvM0MwtLi/VgYFiCbvKST4pVZujmZ6red9SB0epZKhNRTjBq5y/PshEZJAAnoRhSd/6XVKXfcWQmTuwcT9zpVWgoxxDZJQVadC+5kY8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4xRJQuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFFDC4CEDD;
	Sat, 22 Mar 2025 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638466;
	bh=mQSuwrntYEMg0m0zhElfPTystgEzsEcXX+jk3CB1OUc=;
	h=From:To:Cc:Subject:Date:From;
	b=M4xRJQuH21ETdjHgcg7J8gcFVZ67KIxTgRI8aFlBJuQKj4EQndhTJpSU0pa7k5hxe
	 zBpzc8kWg/Yt4v10ls07H53JbDekRzdQ2hs3UGeggdHdB4ugQeJJ5a853NxLlCMC/W
	 s7gYJc+TfTKVg4ocHimCbaBmJV5La57M4qrkzzfMLu981YmJe9H13I9QQMxvFMc2Iv
	 UINjkbYAPBYtl9O3zSN7fEVCeTGGXAGICsw6f9lgpsDBlNy7dLbP5gjzYGKayIu/GB
	 ZrGKH6WyitgVU/DIGHCewwjPOCSlvSZDDo0cPxbAizgthu9UDugqTP4MXTn3gQooix
	 8FsMbxqAqIoIw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] tasklist lock
Date: Sat, 22 Mar 2025 11:14:06 +0100
Message-ID: <20250322-kernel-tasklist-lock-38eaec7fea1e@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=brauner@kernel.org; h=from:subject:message-id; bh=mQSuwrntYEMg0m0zhElfPTystgEzsEcXX+jk3CB1OUc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6813YxBzd1jtmy2sez6p1edR6NGZb0KyWqX6WvK+v j5wpPxnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEReHmL4X5bRaeD0f55spkiC 0oRFGgkH5H09E+b7C4VIbKr5wG71m5Hht//W0E8Wza4cna8Nthx+lPX70fynIt//XJ/vNvF08c4 3DAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

According to the performance testbots this brings a 23% performance
increase when creating new processes:

- Reduce tasklist_lock hold time on exit.

  - Perform add_device_randomness() without tasklist_lock.

  - Perform free_pid() calls outside of tasklist_lock.

- Drop irq disablement around pidmap_lock.

- Add some tasklist_lock asserts.

- Call flush_sigqueue() lockless by changing release_task().

- Don't pointlessly clear __exit_signal()->clear_tsk_thread_flag(TIF_SIGPENDING).

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.15-rc1.tasklist_lock

for you to fetch changes up to 0a7713ac0d98d02f2c69145754c93715ab07b307:

  Merge patch series "reduce tasklist_lock hold time on exit and do some pid cleanup" (2025-02-07 11:22:44 +0100)

Please consider pulling these changes from the signed kernel-6.15-rc1.tasklist_lock tag.

Thanks!
Christian

----------------------------------------------------------------
kernel-6.15-rc1.tasklist_lock

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "exit: change the release_task() paths to call flush_sigqueue() lockless"
      Merge patch series "reduce tasklist_lock hold time on exit and do some pid cleanup"

Mateusz Guzik (5):
      exit: perform add_device_randomness() without tasklist_lock
      exit: hoist get_pid() in release_task() outside of tasklist_lock
      pid: sprinkle tasklist_lock asserts
      pid: perform free_pid() calls outside of tasklist_lock
      pid: drop irq disablement around pidmap_lock

Oleg Nesterov (2):
      exit: change the release_task() paths to call flush_sigqueue() lockless
      exit: kill the pointless __exit_signal()->clear_tsk_thread_flag(TIF_SIGPENDING)

 include/linux/pid.h |  7 +++--
 kernel/exit.c       | 56 ++++++++++++++++++++++--------------
 kernel/pid.c        | 82 +++++++++++++++++++++++++++++------------------------
 kernel/sys.c        | 14 +++++----
 4 files changed, 93 insertions(+), 66 deletions(-)

