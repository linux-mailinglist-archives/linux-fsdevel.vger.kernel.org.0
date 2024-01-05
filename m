Return-Path: <linux-fsdevel+bounces-7466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E482537B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 13:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5CC1C230BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA62D61A;
	Fri,  5 Jan 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoTKVzIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B22D60E;
	Fri,  5 Jan 2024 12:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3054EC433C7;
	Fri,  5 Jan 2024 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704459149;
	bh=Lu9yqV/DIh8EzS9ngZEY7rUI7n6BDXSqnlb2oaaxrsY=;
	h=From:To:Cc:Subject:Date:From;
	b=uoTKVzIaz+SXh/2MZ2F1RP54pLbTtMa6sA7wvjemWWkQgJIqncARN+VgGhfU7MmK8
	 Bh9yF+m/Am2iZSTDw+i+0ASBTEGeW/xnk/rtANKpZAKdhizhqQ+Ix0bfqHJov0U4RK
	 awuJfGiakW2pWKyx1yFObCKBoaasDY5rOd2IaOYTducKAlDX4PGk5GmUgVN21OBY/O
	 80l6ZTSq6CPetuOrGykFTSShJ7i7z/IzZiuCQXnpkwxnT3MWNVr/9uagzaASSakWfh
	 LNbSTfcr1oDKxMLPtealvUtyC+8bqXJKck4NuyNStI/RlRjEFCpsteMc5fF0YDbPMw
	 un1UrIp9aGoXw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs iov updates
Date: Fri,  5 Jan 2024 13:52:04 +0100
Message-ID: <20240105-vfs-iov-52b480d953c4@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=brauner@kernel.org; h=from:subject:message-id; bh=Lu9yqV/DIh8EzS9ngZEY7rUI7n6BDXSqnlb2oaaxrsY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRO/138rdc1lKeiWPCzhmv2ldczjE5clNtSFyGiwLj3f 17JzcXbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbySpKR4VyTuNWjKMfl648E PMgL3y031fpY2qN9831fWy1dfSF3zilGhj1PTq7oOeikwjWxg+PW6VkPepNjDsgIux8+sXJW9SI /UV4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a minor cleanup. The patches drop an unused argument from
import_single_range() allowing to replace import_single_range() with
import_ubuf() and dropping import_single_range() completely.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.7-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.iov_iter

for you to fetch changes up to 9fd7874c0e5c89d7da0b4442271696ec0f8edcba:

  iov_iter: replace import_single_range() with import_ubuf() (2023-12-05 11:57:37 +0100)

Please consider pulling these changes from the signed vfs-6.8.iov_iter tag.

Happy New Year!
Christian

----------------------------------------------------------------
vfs-6.8.iov_iter

----------------------------------------------------------------
Jens Axboe (2):
      iov_iter: remove unused 'iov' argument from import_single_range()
      iov_iter: replace import_single_range() with import_ubuf()

 drivers/block/ublk_drv.c         |  9 ++-------
 drivers/char/random.c            |  6 ++----
 fs/aio.c                         |  2 +-
 include/linux/uio.h              |  2 --
 kernel/trace/trace_events_user.c |  4 +---
 lib/iov_iter.c                   | 13 -------------
 net/ipv4/tcp.c                   | 10 ++++------
 net/socket.c                     |  6 ++----
 security/keys/keyctl.c           |  5 ++---
 9 files changed, 14 insertions(+), 43 deletions(-)

