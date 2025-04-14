Return-Path: <linux-fsdevel+bounces-46346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA0A87C77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE8C3B4597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FB82676EE;
	Mon, 14 Apr 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meWazmN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C0267386;
	Mon, 14 Apr 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624438; cv=none; b=LGrthAxnjPIHb75s/BcxLP7bVtGyqfGq5gP5c/MifDnDz0mjddL7hql5MPgOnhHrpVl5myJrdyu1ylLJZ8pKilLlOHb0A/QNHL0MJ1/SDTkd5m7Ze7ytWeLVkJN1Yj2ZcE0REu/qIJVHSbYWn/EcTrbTrRtebFUMBtizsl4e2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624438; c=relaxed/simple;
	bh=6dH+b9MaL6GsV1HwwP7gMxj2ujMAyYYOTi7g4Qz1eBE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a0LYhXpjG0hnjoLtRhAm12P0vYTMu6phjpoOSCAVF1Q/k9rHMNsyQLU/0Hb0MlHLr2yiCk2EnHahx3P1XAC9dQH/FV88ngSuPB0bNz7cLSdD6JaYk/E+vtNeXhUgpccc8TMSB4i+4vyWOljriqMV1QFtdp6QbrILbJGtTePaR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meWazmN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B8C4CEE2;
	Mon, 14 Apr 2025 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744624437;
	bh=6dH+b9MaL6GsV1HwwP7gMxj2ujMAyYYOTi7g4Qz1eBE=;
	h=From:Subject:Date:To:Cc:From;
	b=meWazmN1Swt2j23Qjj6Fs6l9Uw7Yq3VFoPwuR05kiFG77PDcljvQW/sPr3vbPE7LC
	 j3STWi7dU5DFauTvmBEXVkZDhn70i+c2iMkGhqs0F8eB+kC9S0cPJtFRthiv8EWj6S
	 2tMXZB5uy+MZlGGiRSuyt62AU8IE72zre/Ur07cYfSIAZA/OXRYfhyHY4k+tDSftIy
	 uad14pTq/5gTe/TWxL35zO3VtivsMiTejD0ieu3I2a+4kJ1+5vH1GQat4k05b5frfb
	 mRHdsWeskWyOzoCit0bzbLk67rKAxxT9LugXw3g2+ylIOTjGoJy30C3sNFGPhSSVnq
	 ippr6bI2IIXvA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] coredump: hand a pidfd to the usermode coredump helper
Date: Mon, 14 Apr 2025 11:53:35 +0200
Message-Id: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/b/GcC/x3MQQ6CMBBA0auQWTukAwUSr2JcDGUqjaElU0USw
 t2tLt/i/wOyaJAM1+oAlS3kkGIBXSpwM8eHYJiKoTFNZyy1+En6RJdUpveyovGD50F6S9ZBaVY
 VH/b/73YvHjkLjsrRzb/LwvklWm99TR2qIzjPL1poCHiCAAAA
X-Change-ID: 20250413-work-coredump-0f7fa7e6414c
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6dH+b9MaL6GsV1HwwP7gMxj2ujMAyYYOTi7g4Qz1eBE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/uW1UsG7jgqD/bCf3BWps/dUf6Dz9geU38wIDs2v1n
 AqOpxkvd5SwMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk6i3DN6XLTFZvm00kgk8Z
 vlyxJ4qX7+DE2BfZAi/E3kQV8LzmZvinLHHpzCXJbYoqR0TYuPlvFIW5d8++F3ne8YPvrPgLQeJ
 cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Give userspace a way to instruct the kernel to install a pidfd for the
crashing process into the process started as a usermode helper. There's
still tricky race-windows that cannot be easily or sometimes not closed
at all by userspace. There's various ways like looking at the start time
of a process to make sure that the usermode helper process is started
after the crashing process but it's all very very brittle and fraught
with peril.

The crashed-but-not-reaped process can be killed by userspace before
coredump processing programs like systemd-coredump have had time to
manually open a PIDFD from the PID the kernel provides them, which means
they can be tricked into reading from an arbitrary process, and they run
with full privileges as they are usermode helper processes.

Even if that specific race-window wouldn't exist it's still the safest
and cleanest way to let the kernel provide the pidfd directly instead of
requiring userspace to do it manually. In parallel with this commit we
already have systemd adding support for this in [1].

We create a pidfs file for the coredumping process when we process the
corename pattern. When the usermode helper process is forked we then
install the pidfs file as file descriptor three into the usermode
helpers file descriptor table so it's available to the exec'd program.

Since usermode helpers are either children of the system_unbound_wq
workqueue or kthreadd we know that the file descriptor table is empty
and can thus always use three as the file descriptor number.

Note, that we'll install a pidfd for the thread-group leader even if a
subthread is calling do_coredump(). We know that task linkage hasn't
been removed yet and even if this @current isn't the actual thread-group
leader we know that the thread-group leader cannot be reaped until
@current has exited.

[1]: https://github.com/systemd/systemd/pull/37125

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      pidfs: move O_RDWR into pidfs_alloc_file()
      coredump: fix error handling for replace_fd()
      coredump: hand a pidfd to the usermode coredump helper

 fs/coredump.c            | 92 +++++++++++++++++++++++++++++++++++++++++++++---
 fs/pidfs.c               |  1 +
 include/linux/coredump.h |  1 +
 kernel/fork.c            |  2 +-
 4 files changed, 90 insertions(+), 6 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250413-work-coredump-0f7fa7e6414c


