Return-Path: <linux-fsdevel+bounces-31076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6239919D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0F31C2154A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D6446A1;
	Sat,  5 Oct 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPsT3jYg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F55231C90
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155845; cv=none; b=ODBb6dVMb/5X3WrgsYyOU+sQeAskPLGM+QjYWAzpylQ/LRIWA5LuGghFlCswYIU1RB1VUe79ZYZqR1su3H8WBZMFYHnLgZZHn6sQZIBdsHzNLt2Tyw6ZEbWWtOtaaO01El/8IeWFaCEfLoNmAlHyAqj1d64CTlJM8vNOqxE0Vms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155845; c=relaxed/simple;
	bh=sAfKqfLsnTVrChqPZekZwY5QDeTUvYQmbxu0utxSnNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lo9TItokNgTWQtRHCNCq0m5yOjoaSiv/I77gfI3ivcYzUDiQQdPmnOrH8IMAbAvuyZnG8XFqyNz7cS/HPanz8VM4Cp96fIrxxFhcQLCr3fjXz2jlDTBVxaSWlBsjWdj9iNR3GiM6Mcm7tidBdxxokRDdpMW1zvysNcG5BFpIIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPsT3jYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7624DC4CEC2;
	Sat,  5 Oct 2024 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728155844;
	bh=sAfKqfLsnTVrChqPZekZwY5QDeTUvYQmbxu0utxSnNc=;
	h=From:Subject:Date:To:Cc:From;
	b=hPsT3jYg4Nfi9GNvxm+xovojL9Lo8whG3YbhALQZ6VrGN4D84YuC8aGABw3BjqnW6
	 LV2qEiQ998AYrhtFIhlzKn1KE4vQDEk3N8QpcGbjLs+txkomOgv8/NGGBlkwRkHP6Y
	 nBFJ+paBg+qW7Xd9B1Y1rhH5GRXG5Xi/6WViYJIvipNMNkNjaldsZMsg80phLbntrm
	 yda6wslq4bqVQLTqcd7mJ69kX6ZzftKd+uD7rlOPLK34yzMlqbI6HhGYzc51136Oxb
	 b9sEDDFVXfQgcQUDT0bMMko86UG69P4euMO2Oau0VWTpwAutC1qJjRs8uoMpJYDUO/
	 a724tQrryB2SQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/4] fs: port files to rcuref_long_t
Date: Sat, 05 Oct 2024 21:16:43 +0200
Message-Id: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJuQAWcC/32OQQ6CMBBFr0JmbUlbUIIrExMP4NawmJYBGrGYK
 RAN4e4WDuDy/+S9/xcIxI4CnJMFmGYX3OBjUIcEbIe+JeHqmEFLnctSF8IwTp5YNK4nwXZiaoR
 pMMfcYKmOBiL5jqX77NYH3G9XqGJpMNBGe9ttwheGkTidT6nS0aM2rnNhHPi7n5nVTv/dnZWQQ
 mZWk5J1Zgu8PIk99enALVTruv4AOkH2Gd8AAAA=
X-Change-ID: 20240927-brauner-file-rcuref-bfa4a4ba915b
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sAfKqfLsnTVrChqPZekZwY5QDeTUvYQmbxu0utxSnNc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzTji0XGK68/mtCksuMwScuF09teuGXNCyV0EPs2yX7
 WmN1t7O3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARmzKG/54Nez1fbIngLvkz
 N9LXObTjRnRzMuPc/Jp51aovj+ZdFmL4w/FaduJLybKIlSs1Il1ei7W1s65e1FXXYnJ1edDRdo9
 DTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

As atomic_inc_not_zero() is implemented with a try_cmpxchg() loop it has
O(N^2) behaviour under contention with N concurrent operations. The
rcuref infrastructure uses atomic_add_negative_relaxed() for the fast
path, which scales better under contention and we get overflow
protection for free.

I've been testing this with will-it-scale using a multi-threaded fstat()
on the same file descriptor on a machine that Jens gave me access (thank
you very much!):

processor       : 511
vendor_id       : AuthenticAMD
cpu family      : 25
model           : 160
model name      : AMD EPYC 9754 128-Core Processor

and I consistently get a 3-5% improvement on workloads with 256+ and
more threads comparing v6.12-rc1 as base against with these patches
applied.

Note that atomic_inc_not_zero() contained a full memory barrier that we
relied upon. But we only need an acquire barrier and so I replaced the
second load from the file table with a smp_load_acquire(). I'm not
completely sure this is correct or if we could get away with something
else. Linus, maybe you have input here?

Maybe this is all a bad idea but I've wasted enough time on performance
testing this that I at least wanted to have it on list.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (4):
      fs: protect backing files with rcu
      types: add rcuref_long_t
      rcuref: add rcuref_long_*() helpers
      fs: port files to rcuref_long_t

 drivers/gpu/drm/i915/gt/shmem_utils.c |   2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c   |   2 +-
 fs/eventpoll.c                        |   2 +-
 fs/file.c                             |  17 ++--
 fs/file_table.c                       |  18 ++--
 include/linux/fs.h                    |   9 +-
 include/linux/rcuref_long.h           | 166 ++++++++++++++++++++++++++++++++++
 include/linux/types.h                 |  10 ++
 lib/rcuref.c                          | 104 +++++++++++++++++++++
 9 files changed, 308 insertions(+), 22 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240927-brauner-file-rcuref-bfa4a4ba915b


