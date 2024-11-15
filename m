Return-Path: <linux-fsdevel+bounces-34914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1069CE128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF3B33CAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0181CEAD1;
	Fri, 15 Nov 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcM7F5nB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2D1B2EEB;
	Fri, 15 Nov 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679554; cv=none; b=hWXNTYC2waQQOrzQo3ivw/iAOfW4OoZrl72l1iTma6Lz3bonD3KIsKY96iEZ4SpuN2Dclhr8jK2YBbfRfgyPYi0X7paCFlU3DH1Nan73YHpAq0F89vetP3454QXsWDNFLUflJ6E4gF8pE1jew4zCP7VqJyiAnYIkmun+DBRBuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679554; c=relaxed/simple;
	bh=TYgQin0qTnaZZ696HmpSDx6TeHJYLdcX8+1R6Rh/3IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFkxaRvm5OntUXa5Mt/YiirrTpgRcZgBoxlFWgMdEKTRTUfc+UONJtlXyKi8Bfkzfk5sVM/pwXiMyOPIY4hNjAM3gKXx8DZeIuamiJQPUlZ5J/O6vOGeBGGI59cH0C8krdKTnYHe7N7yPG+jdLscNg69cp2sTlT4FOvmXZ8QJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcM7F5nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C033EC4CECF;
	Fri, 15 Nov 2024 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679554;
	bh=TYgQin0qTnaZZ696HmpSDx6TeHJYLdcX8+1R6Rh/3IY=;
	h=From:To:Cc:Subject:Date:From;
	b=GcM7F5nBn42/VjQRCVsbeBov1chR16HYctMh8ttaxmpl/pCg65MLokNtzmKDbOt5b
	 SYV2JPMz3P7Ci5GIdLnRui9TN9wPZEMFFNhvcxwLxPZSFBtjFSj95OcsmlHj4BqjhI
	 H4DVLetsJhx0p6oqyqW2r1tO40b7+0zKwSA5Hwyb9jrmoCKlGMGQSNG/BKURYtv+Lt
	 7MTFFm6NghjRwKudo7kagDVREu/w1GgNjcLk7xSh2RMZS61nMjPv6YQTOEmJXG2hz5
	 yJ4E8fGFYNIT3YlV1OCcPK7sKIpnvjHM+LLAPRZraJdDvqWfyUcT7RQoD9ZV+dwT20
	 ZYaCNghAJWiAw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs copy_struct_to_user()
Date: Fri, 15 Nov 2024 15:05:46 +0100
Message-ID: <20241115-vfs-usercopy-82de2c4b92b7@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=brauner@kernel.org; h=from:subject:message-id; bh=TYgQin0qTnaZZ696HmpSDx6TeHJYLdcX8+1R6Rh/3IY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbh9ootfj6sxntb9698Hjk1Fmhu/w1n8mKhZ0IP3XvW FtqIsetjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInYvmH47/iGN6XBRaXek2d/ 0Lmtnm4z7n9fv6V2lun/7WbLP+ie72f4X9u89rtg7Jff674GzueweXbt+puyPUde/nqwwyTi50d uE14A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds a copy_struct_to_user() helper which is a companion helper to
the already widely used copy_struct_from_user().

It copies a struct from kernel space to userspace, in a way that
guarantees backwards-compatibility for struct syscall arguments as long
as future struct extensions are made such that all new fields are
appended to the old struct, and zeroed-out new fields have the same
meaning as the old struct.

The first user is sched_getattr() system call but once the pidfs updates
for this cycle have landed the new extensible ioctl will be ported to it
as well.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc3 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.usercopy

for you to fetch changes up to 112cca098a7010c02a4d535a253af72e4e5bbd06:

  sched_getattr: port to copy_struct_to_user (2024-10-21 16:51:31 +0200)

Please consider pulling these changes from the signed vfs-6.13.usercopy tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.usercopy

----------------------------------------------------------------
Aleksa Sarai (2):
      uaccess: add copy_struct_to_user helper
      sched_getattr: port to copy_struct_to_user

 include/linux/uaccess.h | 97 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/syscalls.c | 42 +--------------------
 2 files changed, 99 insertions(+), 40 deletions(-)

