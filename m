Return-Path: <linux-fsdevel+bounces-70821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B684CA7C80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 512C230AD6B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50906330311;
	Fri,  5 Dec 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwgPtfZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3A281504;
	Fri,  5 Dec 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764941811; cv=none; b=MIaOAtdSStdMyeqs2J2HjZyu1u+U2d3BK/oylddyK0mMxWB1YK2mrpaxDTRVovgTqXJX4qDmK+XrwfmM0tMWC+zp0+6fvNip6mw6grWetGkiqKYvkonhK0gH+nm+LAXn0oEBweBhfqtbMa3iGmRy32NVjs8veJlfZqYjLFcSlFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764941811; c=relaxed/simple;
	bh=p3T1ulfSLPL03s2NnroT2XsKoZTK2w4K4wqpqJsbhLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UzMtV5CN2IQ+BUzMk2im1gquQjGFIH/cZjDqtIzoT2zfQPkUwT8U9OkU5lfkqaJJSQ6hDy/+qi0cZo/YBA9kQBoAWjA0sR9HC2Aor1XIWbLq7Ovb7PteRMDmrTyCxEVycTtX4YYpp99dQsoYxYTM+2ERpd3kHm0owV1dkA8do1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwgPtfZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B751C4CEF1;
	Fri,  5 Dec 2025 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764941810;
	bh=p3T1ulfSLPL03s2NnroT2XsKoZTK2w4K4wqpqJsbhLY=;
	h=From:To:Cc:Subject:Date:From;
	b=XwgPtfZT5LWHmr2dmxZlWN4/1S9ebstaiz5Qf4chkjQnG/qtdUTQ/U7t9PQAJ9UUC
	 oMFlC36GQqo5YnfGC9Jd8eVMfkdvVeJb87mwYMNhny0/vqcHkWuzM46YxTrY6RyADy
	 y7JlIcnf8QsQdJYTX7owqdM+BoW2ot6O30UUJ4mtJw6pypubUjIPtCbT68IC3ev+fy
	 F7iGctqziL56vAFeDroYwZwoyLM+1CzeCIrzW/Ctc9X87yUdlnZUggR4ME0drHE/Zm
	 /JEvlY9g7hFZTMzlwQy4bEaZ2GScp1yrSlODxz8PSd+BW5XL4LFZrD8YXHxVn0Qiyy
	 an5y5lQpfXjPA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri,  5 Dec 2025 14:36:15 +0100
Message-ID: <20251205-vfs-fixes-23ea52006d69@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2596; i=brauner@kernel.org; h=from:subject:message-id; bh=p3T1ulfSLPL03s2NnroT2XsKoZTK2w4K4wqpqJsbhLY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQa3b/5ad5LbVMPHY1yN/spCerTTRbrxlc5rL5yo+PUh huOUhfKO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYibMjwV/DVChfltpvcyn7t L9JNrp++Otv8i63OyrOPrv+pznO6FcXIsK4wjeFPltX3+1dOOihI3DosO+nBqVxuraOvNfzfnI3 V4AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a few fixes for this cycle:

- Fix a type conversion bug in the ipc subsystem.

- Fix per-dentry timeout warning in autofs.

- Drop the fd conversion from sockets.

- Move assert from iput_not_last() to iput().

- Fix reversed check in filesystems_freeze_callback().

- Use proper uapi types for new struct delegation definitions.

- There's an overlayfs fix waiting as well but it's waiting for testing
  confirmation from the reporter. By the time you're up this might
  already have happened so if this isn't asking too much you could
  choose to apply the fix in [1] directly. Otherwise this will be
  delayed because of upcoming travel
  (Finger's crossed I'll recover well enough.):
  [1]: https://lore.kernel.org/20251205-tortur-amtieren-1273b2eef469@brauner

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 3f9f0252130e7dd60d41be0802bf58f6471c691d:

  Merge tag 'random-6.19-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random (2025-12-02 19:00:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fixes

for you to fetch changes up to fe93446b5ebdaa89a8f97b15668c077921a65140:

  vfs: use UAPI types for new struct delegation definition (2025-12-05 13:57:39 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.fixes

----------------------------------------------------------------
Christian Brauner (1):
      Revert "net/socket: convert sock_map_fd() to FD_ADD()"

Edward Adam Davis (1):
      mqueue: correct the type of ro to int

Ian Kent (1):
      autofs: fix per-dentry timeout warning

Mateusz Guzik (1):
      fs: assert on I_FREEING not being set in iput() and iput_not_last()

Rafael J. Wysocki (1):
      fs: PM: Fix reverse check in filesystems_freeze_callback()

Thomas Weißschuh (1):
      vfs: use UAPI types for new struct delegation definition

 fs/autofs/dev-ioctl.c      | 22 ++++++++++++----------
 fs/inode.c                 |  3 ++-
 fs/super.c                 |  2 +-
 include/uapi/linux/fcntl.h | 10 +++-------
 ipc/mqueue.c               |  2 +-
 net/socket.c               | 19 ++++++++++++++-----
 6 files changed, 33 insertions(+), 25 deletions(-)

