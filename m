Return-Path: <linux-fsdevel+bounces-31191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BE992F04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8FA1C237B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2E1D47AC;
	Mon,  7 Oct 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e26xsIAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811B1D1F76
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311075; cv=none; b=nxapi+TbDRQ1yx8aBcC439ZLWFEJRTrqHrV7yVXP4/4x8O6o0rc3HmOLqddjRnD/Af5SXIK9qMIkFc1PwLHjNrc/YVBUG+N4rob3+zU41Su+4eBybqEpoUpNUt7P2CHy0yiCUSLcPftNGUbDpQkzFbt5Z7Ek42nk2JkdwkBjPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311075; c=relaxed/simple;
	bh=qROs4JxiTGfNaMYyHNnuOH9Ab6ZFVJYV+sBD3g6MCec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z9iJVknmblRbpwBQxhnajiWOmVmvcBlpZEwCeXOTXqq9u3G1PTPk/LmySVuWpvOihIOjQ0p+U7tB4DfipcdfVHqOLaA8fLs4zPiNSkgg6hCvbmWEF0+kTNFpjI0kzOL+qI2HCkKyYujYQaOJ48IWpJnM4xs1KBbMbWoMlCmhN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e26xsIAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72645C4CEC6;
	Mon,  7 Oct 2024 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311074;
	bh=qROs4JxiTGfNaMYyHNnuOH9Ab6ZFVJYV+sBD3g6MCec=;
	h=From:Subject:Date:To:Cc:From;
	b=e26xsIADHreleuxlan4tfNU/Y8QoGDLZ83D9p0am3dW2ikNV0pURMVrf6gkSRy97K
	 ddcugPf1PiAsWXRjGMCXcctqoM+OXlcSwO8hl2kCaijAERSMPkovxJtYX6VUtZhw+7
	 uBHsP95ptsqIaZi6Uey5RsijDrwP78tXWZheOFPP0LjC3x6rVLyPg7Bpq5iDEXKAuE
	 wQLs2DvjOPmpP9sTLAIaoIu5kSqomn1BW1tMQPajUK8OfSEbLdgKdJddkjXkhbOBa+
	 6ZiD6u5l3IUs/ddOhnmlGSIBl6RzxbVk8OHrnDsudXkc6Es5NQbhEkI4SJgubhQ3ya
	 y+3i4sVsdFPkw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/3] fs: introduce file_ref_t
Date: Mon, 07 Oct 2024 16:23:56 +0200
Message-Id: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzuA2cC/33OQQ6DIBCF4asY1sUAitaueo/GBeCopBabQUkb4
 90Lrrppl4/k+4eNeEALnlyyjSAE6+3s4hCnjJhRuQGo7eImgomSNaKmGtXqAGlvJ6BoVoSe6l6
 VqtSq4VKTKJ/x0b6O6q2NWysPCTozptZD+QUwD1XORUzwREbrlxnfxz8CT/D/ycApo6wwAjjrC
 lOr6x3QwZTPOKRewpwx+RvXQnYSal6Yc/WN233fP0bo/KcXAQAA
X-Change-ID: 20240927-brauner-file-rcuref-bfa4a4ba915b
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qROs4JxiTGfNaMYyHNnuOH9Ab6ZFVJYV+sBD3g6MCec=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzv1eounjbLVlNTEf0h7iQpWqcXE90iIIn8/X7Zds+S
 0k+anjfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEdDxgZ1n26NznCviNEo/yH
 nfuUd0Hn5+9i3/aoSacik29Oj3fYXkaGd9MLj+5x+x77LGONtsP07J+nLygmfYn/xmv/n4/1yIu
 vbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

As atomic_inc_not_zero() is implemented with a try_cmpxchg() loop it has
O(N^2) behaviour under contention with N concurrent operations and it is
in a hot path in __fget_files_rcu().

The rcuref infrastructures remedies this problem by using an
unconditional increment relying on safe- and dead zones to make this
work and requiring rcu protection for the data structure in question.
This not just scales better it also introduces overflow protection.

However, in contrast to generic rcuref, files require a memory barrier
and thus cannot rely on *_relaxed() atomic operations and also require
to be built on atomic_long_t as having massive amounts of reference
isn't unheard of even if it is just an attack.

As suggested by Linus, add a file specific variant instead of making
this a generic library.

I've been testing this with will-it-scale using a multi-threaded fstat()
on the same file descriptor on a machine that Jens gave me access (thank
you very much!):

processor       : 511
vendor_id       : AuthenticAMD
cpu family      : 25
model           : 160
model name      : AMD EPYC 9754 128-Core Processor

and I consistently get a 3-5% improvement on workloads with 256+ and
more threads comparing v6.12-rc1 as base with and without these patches
applied.

In vfs.file now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Don't introduce a separate rcuref_long_t library just implement it
  only for files for now.
- Retain memory barrier by using atomic_long_add_negative() instead of
  atomic_long_add_negative_relaxed() to order the loads before and after
  the increment in __fget_files_rcu().
- Link to v1: https://lore.kernel.org/r/20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org

---
Christian Brauner (3):
      fs: protect backing files with rcu
      fs: add file_ref
      fs: port files to file_ref

 drivers/gpu/drm/i915/gt/shmem_utils.c |   2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c   |   2 +-
 fs/eventpoll.c                        |   2 +-
 fs/file.c                             | 120 ++++++++++++++++++++++++++++++++--
 fs/file_table.c                       |  23 +++++--
 include/linux/file_ref.h              | 116 ++++++++++++++++++++++++++++++++
 include/linux/fs.h                    |   9 +--
 7 files changed, 253 insertions(+), 21 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240927-brauner-file-rcuref-bfa4a4ba915b


