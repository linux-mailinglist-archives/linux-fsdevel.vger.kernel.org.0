Return-Path: <linux-fsdevel+bounces-12478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CC285FAB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B481C2598B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32EB14691A;
	Thu, 22 Feb 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TySaKi8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7791468FA;
	Thu, 22 Feb 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610683; cv=none; b=kNDPFcZHzW7zvdiGnWZtT0qNrO4gf2WcZ06z75KpZAqihFWH4qLeEeZxh/Xii1k2vBDgEuKuhhcJ4FoGtJWtcFgCT3/dSqeGeMoa6HX2FHI5jXJ5Jp9iKD/2P3NMtDDkwJYAFuDhXD2bRc5MAI2wxYZvMBt7WNizMtAVWibrd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610683; c=relaxed/simple;
	bh=1D90OTPu4zbi0aXCq6zV1eVFGZJcyQxAFGiZtTpgXYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5/x/6+YZGkaD+tjdZqKn/I72RxB0k3fjN8tbejAuGtP7NnWB5Yt5mOtGNeNZe3f5BsE/AD52OpdA8wOC8SvB5GmzQGuq177ZpgPOPZdTFkB8FLiSG9rtTPaKo8UIY4C0l4utPfgNHKbEP8VjN5AOMRRxWTTTX9zG4Tua2jlQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TySaKi8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D5EC433F1;
	Thu, 22 Feb 2024 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610682;
	bh=1D90OTPu4zbi0aXCq6zV1eVFGZJcyQxAFGiZtTpgXYs=;
	h=From:To:Cc:Subject:Date:From;
	b=TySaKi8Kg28e8vkLld/dJCh4yGaJgQVGxFP4nqUT+y7Zb9s63P4GIyQD/epU9A35u
	 FV7tzwLO0xRmcZ5j3PVgxp+Dm08eGrWwwL861ER+W8RjPhD66rH9sQRtS6J3hXqEjH
	 V3zYjMqzpOq7qe+Z0SCL/DwlNTEVveIZaAqe0aFQEmLck5y8tw+8mS7GdYHztT7xu6
	 LbXmezJ/S+kmUzJ9DLQROvG10ujGBh5SHasl2sa48EbsQCjZbooUA7Maxh0jEdDUhP
	 U09TeCKWsVablS1xDY6f6dRFfQDFPtrJGcMT1lyF7g+HukuWvw540pQ53Yw66CO72O
	 iuXd0IqFTDHpw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu, 22 Feb 2024 15:03:24 +0100
Message-ID: <20240222-vfs-fixes-90812d8f4995@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746; i=brauner@kernel.org; h=from:subject:message-id; bh=1D90OTPu4zbi0aXCq6zV1eVFGZJcyQxAFGiZtTpgXYs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReD8mNrY28LOPLa3dge91vu/STNyecELUvqPb9Xfbjn 1rARsnUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlo6DIyvNisovBbffHLd7ZH 958+mp2UKhP0I/v8R3HmXcwLb2yM0GT4p5HnryZTqMBdI3wp6Uvhr9Yn06snxRyJ0PwonB6tOlm MBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few fixes:

* Fix a memory leak in cachefiles.
* Restrict aio cancellations to I/O submitted through the aio interfaces as
  this is otherwise causing issues for I/O submitted via io_uring.
* Increase buffer for afs volume status to avoid overflow.
* Fix a missing zero-length check in unbuffered writes in the netfs library.
  If generic_write_checks() returns zero make netfs_unbuffered_write_iter()
  return right away.
* Prevent a leak in i_dio_count caused by netfs_begin_read() operaing pas
  i_size. It will return early and leave i_dio_count incremented.
* Account for ipv4 addresses as well ass ipv6 addresses when processing
  incoming callbacks in afs.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc6.fixes

for you to fetch changes up to b820de741ae48ccf50dd95e297889c286ff4f760:

  fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio (2024-02-21 16:31:49 +0100)

Please consider pulling these changes from the signed vfs-6.8-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.8-rc6.fixes

----------------------------------------------------------------
Baokun Li (1):
      cachefiles: fix memory leak in cachefiles_add_cache()

Bart Van Assche (1):
      fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Daniil Dulov (1):
      afs: Increase buffer size in afs_update_volume_status()

David Howells (1):
      netfs: Fix missing zero-length check in unbuffered write

Marc Dionne (2):
      netfs: Fix i_dio_count leak on DIO read past i_size
      afs: Fix ignored callbacks over ipv4

 fs/afs/internal.h         |  6 ++----
 fs/afs/main.c             |  3 +--
 fs/afs/server.c           | 14 +++++---------
 fs/afs/volume.c           |  4 ++--
 fs/aio.c                  |  9 ++++++++-
 fs/cachefiles/cache.c     |  2 ++
 fs/cachefiles/daemon.c    |  1 +
 fs/netfs/buffered_write.c |  3 +++
 fs/netfs/direct_write.c   |  5 ++++-
 fs/netfs/io.c             |  2 ++
 include/linux/fs.h        |  2 ++
 11 files changed, 32 insertions(+), 19 deletions(-)

