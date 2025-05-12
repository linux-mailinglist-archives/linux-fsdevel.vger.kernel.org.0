Return-Path: <linux-fsdevel+bounces-48736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBFAB357B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4EC37A41C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA826A0BA;
	Mon, 12 May 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofxybq/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AB254AFE;
	Mon, 12 May 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047726; cv=none; b=b4vUoER9Nbxbgfl4VK73xmvqqzQTMHMN7v4HuU1rsTn1TmFNTLNiQHLVGqcCUXmgEb4UTAEUqyM8tEOXVcR2doRJB/MwtMST+ir1+v5l5R+WUUF2H0K5qSye6EnBDCjCATehirwu6JtT5jef46zwZJMh8w+wupyVqsU685avx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047726; c=relaxed/simple;
	bh=rac1BuZ4TNtTHplpSRdXfm/PeyQHJhhxli3tyXrLWiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hd8wD15uLUJhHNDJTkMQGLwrHEIX9hLbZ4sjKRQyiJlTzph42uc4dek7wOV1gSQKtYrIGDlJdAlmw9yU2qTq7u4y9Bg2gg/WIqYIwwRpz0apnEWCv6izZMur3T7jVdloZmHpFyLMQ7ti3I4dj94XQenwcb63nnP5kyGj5KSr6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofxybq/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB164C4CEE7;
	Mon, 12 May 2025 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047724;
	bh=rac1BuZ4TNtTHplpSRdXfm/PeyQHJhhxli3tyXrLWiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ofxybq/Thr9eaOrELRZnbafsDc6C1HNKLtVwoHU67mbiM40b+24J9ZvTH3UKfm/p7
	 o73uPfhC/RndfLu25EqnzrDiOBjxcgUn7evYCnm5m2IkLZZ3aV+Ty9TBe9L0giOV4c
	 Lvy1STSweNYVHvB7X9Tn5LNqUvhoJ0QZmOxWg7mQFAXN7uZhrodaRLOPu5Lrr9I+3Q
	 h4WHjlt7XtqEZPRL95CalFk4J5zzYEnAuf9SinpGbFHzFss0Xit+3Dg6ngMbVU9NPM
	 jH1rlkCNqzx/b2RwdcqFJFsVg2/PN+ggb0i2ILX24ZqFv9tAAJrBgxhd05fZ/mRwc8
	 6Q7MPFj8w05OA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 12 May 2025 13:01:54 +0200
Message-ID: <20250512-vfs-fixes-5cd1f86de6df@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=brauner@kernel.org; h=from:subject:message-id; bh=rac1BuZ4TNtTHplpSRdXfm/PeyQHJhhxli3tyXrLWiQ=; b=kA0DAAoWkcYbwGV43KIByyZiAGgh1SXI662xDD6mcCnYG1i7bGN/rfX+WS3dwomzZAx1aH0jc oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmgh1SUACgkQkcYbwGV43KIUbQD/fKyg 0kPJUocMyYQPgQtPbMN14ao8fTb6TEZDiNtCnTIA/2ZCYNTdGebbkT0UEoUSASZ7isjZR/Anz0x zsMHH+6EO
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various fixes for this cycle:

* Ensure that simple_xattr_list() always includes security.* xattrs.

* Fix eventpoll busy loop optimization when combined with timeouts.

* Disable swapon() for devices with block sizes greater than page sizes.

* Done call errseq_set() twice during mark_buffer_write_io_error(). Just use
  mapping_set_error() which takes care to not deference unconditionally.

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

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc7.fixes

for you to fetch changes up to 04679f3c27e132c1a2d3881de2f0c5d7128de7c1:

  fs: Remove redundant errseq_set call in mark_buffer_write_io_error. (2025-05-09 12:31:57 +0200)

Please consider pulling these changes from the signed vfs-6.15-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc7.fixes

----------------------------------------------------------------
Jeremy Bongio (1):
      fs: Remove redundant errseq_set call in mark_buffer_write_io_error.

Luis Chamberlain (1):
      swapfile: disable swapon for bs > ps devices

Max Kellermann (1):
      fs/eventpoll: fix endless busy loop after timeout has expired

Stephen Smalley (1):
      fs/xattr.c: fix simple_xattr_list to always include security.* xattrs

 fs/buffer.c    |  4 +---
 fs/eventpoll.c |  7 ++++---
 fs/xattr.c     | 24 ++++++++++++++++++++++++
 mm/swapfile.c  |  9 +++++++++
 4 files changed, 38 insertions(+), 6 deletions(-)

