Return-Path: <linux-fsdevel+bounces-7060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44107821490
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B871C20933
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA0479C5;
	Mon,  1 Jan 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQ4sr2ta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F363C7;
	Mon,  1 Jan 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Jan 2024 11:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704128229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cmvErc4bVmNIdfsEyQKE+VfNG+TsormXZQZVPalSIsg=;
	b=jQ4sr2taSFWLfiAzp6+1xFur/KSny+47PWTKSD0SXJpvPF03vIYVvqEWHjXDPtLa3Q543V
	QtYFU9wqDpOOlqBavtBvK0sa+9rjrlScnIdv4FAwywbcc5G61m96ZGVH++8myaFqAE/9e2
	qkkWUIkVEbvjZ/+ptgMYJCNRl4dcH9M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs new years fixes for 6.7
Message-ID: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, some more fixes for you, and some compatibility work so that
6.7 will be able to handle the disk space accounting rewrite when it
rolls out.

Happy new year!

The following changes since commit 453f5db0619e2ad64076aab16ff5a00e0f7c53a2:

  Merge tag 'trace-v6.7-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2023-12-30 11:37:35 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-01

for you to fetch changes up to 0d72ab35a925d66b044cb62b709e53141c3f0143:

  bcachefs: make RO snapshots actually RO (2024-01-01 11:47:07 -0500)

----------------------------------------------------------------
More bcachefs bugfixes for 6.7, and forwards compatibility work:

 - fix for a nasty extents + snapshot interaction, reported when reflink
   of a snapshotted file wouldn't complete but turned out to be a more
   general bug
 - fix for an invalid free in dio write path when iov vector was longer
   than our inline vecotr
 - fix for a buffer overflow in the nocow write path - BCH_REPLICAS_MAX
   doesn't actually limit the number of pointers in an extent when
   cached pointers are included
 - RO snapshots are actually RO now
 - And, a new superblock section to avoid future breakage when the disk
   space acounting rewrite rolls out: the new superblock section
   describes versions that need work to downgrade, where the work
   required is a list of recovery passes and errors to silently fix.

----------------------------------------------------------------
Kent Overstreet (13):
      bcachefs: Fix extents iteration + snapshots interaction
      bcachefs: fix invalid free in dio write path
      bcachefs: fix setting version_upgrade_complete
      bcachefs: Factor out darray resize slowpath
      bcachefs: Switch darray to kvmalloc()
      bcachefs: DARRAY_PREALLOCATED()
      bcachefs: fix buffer overflow in nocow write path
      bcachefs: move BCH_SB_ERRS() to sb-errors_types.h
      bcachefs: prt_bitflags_vector()
      bcachefs: Add persistent identifiers for recovery passes
      bcachefs: bch_sb.recovery_passes_required
      bcachefs: bch_sb_field_downgrade
      bcachefs: make RO snapshots actually RO

 fs/bcachefs/Makefile          |   2 +
 fs/bcachefs/acl.c             |   3 +-
 fs/bcachefs/bcachefs.h        |   1 +
 fs/bcachefs/bcachefs_format.h |  51 ++++++---
 fs/bcachefs/btree_iter.c      |  35 ++++--
 fs/bcachefs/darray.c          |  24 ++++
 fs/bcachefs/darray.h          |  48 +++++---
 fs/bcachefs/errcode.h         |   3 +
 fs/bcachefs/error.c           |   3 +
 fs/bcachefs/fs-io-direct.c    |  13 +--
 fs/bcachefs/fs-ioctl.c        |  12 +-
 fs/bcachefs/fs.c              |  38 ++++++-
 fs/bcachefs/io_write.c        |  82 +++++++-------
 fs/bcachefs/printbuf.c        |  22 ++++
 fs/bcachefs/printbuf.h        |   2 +
 fs/bcachefs/recovery.c        | 137 +++++++++++++++++++----
 fs/bcachefs/recovery.h        |   3 +
 fs/bcachefs/recovery_types.h  |  86 ++++++++------
 fs/bcachefs/sb-clean.c        |   2 -
 fs/bcachefs/sb-downgrade.c    | 188 +++++++++++++++++++++++++++++++
 fs/bcachefs/sb-downgrade.h    |  10 ++
 fs/bcachefs/sb-errors.c       |   6 +-
 fs/bcachefs/sb-errors.h       | 253 +-----------------------------------------
 fs/bcachefs/sb-errors_types.h | 253 ++++++++++++++++++++++++++++++++++++++++++
 fs/bcachefs/subvolume.c       |  18 +++
 fs/bcachefs/subvolume.h       |   3 +
 fs/bcachefs/super-io.c        |  86 +++++++++++++-
 fs/bcachefs/super-io.h        |  12 +-
 fs/bcachefs/util.h            |   1 +
 fs/bcachefs/xattr.c           |   3 +-
 30 files changed, 977 insertions(+), 423 deletions(-)
 create mode 100644 fs/bcachefs/darray.c
 create mode 100644 fs/bcachefs/sb-downgrade.c
 create mode 100644 fs/bcachefs/sb-downgrade.h

