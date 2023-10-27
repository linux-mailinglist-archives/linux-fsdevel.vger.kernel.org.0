Return-Path: <linux-fsdevel+bounces-1375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C467D9BCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07236B21481
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98718E05;
	Fri, 27 Oct 2023 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O26UC/Uu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20F1773E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4474C433C8;
	Fri, 27 Oct 2023 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698417774;
	bh=Fo/Q1tCDWCMX1UtKnc1Cp7UAgDSwFYYmaR8Bh6BaonY=;
	h=From:To:Cc:Subject:Date:From;
	b=O26UC/UuNw0xh6Zdv/uqfIDo9PzFFgslo71++vldE9+ovHIqcDtcdJ32DOklnNysD
	 8vw8fNJ/Koxx0NIs4H3bUoW04tOt+U5nFt08FIbLWvIH7626CeDqFpsxRsTJ26qT4i
	 AsGJhlHelTxBGjM3+OOdVG2Rg/6uFjZONyM1nB9jAo+P8u2PkJJmvTK33WXrsiHFJW
	 RTPmxtr7U1qyd3Gmj6zWfeCKJDLaTiHzLAztaNDEIwgLDQwWi1s6QDVU4okFRXsR7P
	 P7DnfSZvHM7Sp0kcivY0fqivsp2D4QAErP3xfOTJ8enJXdeMFIuzHXCc+c4wSO8y8K
	 kSf0cgoU/fItw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.7] vfs io updates
Date: Fri, 27 Oct 2023 16:42:35 +0200
Message-Id: <20231027-vfs-io-82cd868e9b4f@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4203; i=brauner@kernel.org; h=from:subject:message-id; bh=bS0RKv9WrQ4+qTFajR4rqczirZYMqhCIdwgz1AYwIEk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRanzpzjdFP5IDQkfiD9x6btUcWKmVN2dZx/XiV9Hr17uS4 lS1WHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpDGL4K2JfWBvDWxY5u0bUV17YyW e22pKr971PCV3/Fpp6/fH9Awz/XRrTfmROncllfFR3wxOBYzumuBtITJz5ezv/k5qzohIerAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contain's David's iov_iter cleanup work to convert the iov_iter
iteration macros to inline functions:

* Remove last_offset from iov_iter as it was only used by ITER_PIPE.
* Add a __user tag on copy_mc_to_user()'s dst argument on x86 to match
  that on powerpc and get rid of a sparse warning.
* Convert iter->user_backed to user_backed_iter() in the sound PCM
  driver.
* Convert iter->user_backed to user_backed_iter() in a couple of
  infiniband drivers.
* Renumber the type enum so that the ITER_* constants match the order in
  iterate_and_advance*().
* Since the preceding patch puts UBUF and IOVEC at 0 and 1, change
  user_backed_iter() to just use the type value and get rid of the extra
  flag.
* Convert the iov_iter iteration macros to always-inline functions to
  make the code easier to follow. It uses function pointers, but they
  get optimised away.
* Move the check for ->copy_mc to _copy_from_iter() and
  copy_page_from_iter_atomic() rather than in memcpy_from_iter_mc()
  where it gets repeated for every segment.  Instead, we check once and
  invoke a side function that can use iterate_bvec() rather than
  iterate_and_advance() and supply a different step function.
* Move the copy-and-csum code to net/ where it can be in proximity with
  the code that uses it.
* Fold memcpy_and_csum() in to its two users.
* Move csum_and_copy_from_iter_full() out of line and merge in
  csum_and_copy_from_iter() since the former is the only caller of the
  latter.
* Move hash_and_copy_to_iter() to net/ where it can be with its only
  caller.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iov_iter

for you to fetch changes up to b5f0e20f444cd150121e0ce912ebd3f2dabd12bc:

  iov_iter, net: Move hash_and_copy_to_iter() to net/ (2023-10-09 09:35:14 +0200)

Please consider pulling these changes from the signed vfs-6.7.iov_iter tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.iov_iter

----------------------------------------------------------------
David Howells (12):
      iov_iter: Remove last_offset from iov_iter as it was for ITER_PIPE
      iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()
      sound: Fix snd_pcm_readv()/writev() to use iov access functions
      infiniband: Use user_backed_iter() to see if iterator is UBUF/IOVEC
      iov_iter: Renumber ITER_* constants
      iov_iter: Derive user-backedness from the iterator type
      iov_iter: Convert iterate*() to inline funcs
      iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
      iov_iter, net: Move csum_and_copy_to/from_iter() to net/
      iov_iter, net: Fold in csum_and_memcpy()
      iov_iter, net: Merge csum_and_copy_from_iter{,_full}() together
      iov_iter, net: Move hash_and_copy_to_iter() to net/

 arch/x86/include/asm/uaccess.h           |   2 +-
 arch/x86/lib/copy_mc.c                   |   8 +-
 drivers/infiniband/hw/hfi1/file_ops.c    |   2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c |   2 +-
 include/linux/iov_iter.h                 | 274 +++++++++++++++++++
 include/linux/skbuff.h                   |   3 +
 include/linux/uio.h                      |  34 +--
 lib/iov_iter.c                           | 437 ++++++++++---------------------
 net/core/datagram.c                      |  75 +++++-
 net/core/skbuff.c                        |  40 +++
 sound/core/pcm_native.c                  |   4 +-
 11 files changed, 540 insertions(+), 341 deletions(-)
 create mode 100644 include/linux/iov_iter.h

