Return-Path: <linux-fsdevel+bounces-42733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF54A4705A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 01:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78BA16EB53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299917C77;
	Thu, 27 Feb 2025 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VhCSHvPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4091D528
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616664; cv=none; b=Jtcc2sTj1TfaLLzj4e4LS4Az9xd9Ly1LCGJQWX/N2is9gX9XPC+Frs9+5d19gSwksoBVgyVnR6SSyk0WdbE7hqGr81BGIrv0F1hp+6iDcwaBrmm+m7etsBggb1pzti9gI4/YHLDSG3fE3yNFEUytP2glRUjY39zCECuGZzLNYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616664; c=relaxed/simple;
	bh=4oR8/akrv9h99E5/0q46DrQwOgYl3Aj5OIoGH8fu7ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UwcwMK/UxwfAofZPhbPG92PDRzZn8SeDry1sJBfnYeBndo9SgqW9+/ZfGYTMNAG8/dsZLncq3Gkfr3+kds6TBoMH/Z0ByOlbxE2KWX8yeSLO+MSDwUiZMlbyS50zWEIKz3pjbOQWQTesF/2A/aMLPprmw/kWVMdZw/AvnSRUApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VhCSHvPU; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 19:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740616649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8r7ZBWen2aHvNkU/gKusFsPhdVjQwKX/sY5JWKex0t8=;
	b=VhCSHvPUyGXE3MdpKB5c2Wm5RiQWHTmE85ttyz//taG++KnRsGN/TTAyQggL5DJoUVx87W
	LgaRXcxfZ9KDmZ1Qv6U/07Hdxw7lEjVHo/pAIfUimRyXscDgroNlW2b4klFRfw2wCLLeJh
	zYUh1/Dk2/smbftEOOHpMkqE38CwaWE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14-rc5
Message-ID: <6xhke7esvj47xpl6ylxtcz5b2ol2ckwup2q3yunjo6zudthrtm@emmsdk3bpusy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


The following changes since commit b04974f759ac7574d8556deb7c602a8d01a0dcc6:

  bcachefs: Fix srcu lock warning in btree_update_nodes_written() (2025-02-19 18:52:42 -0500)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-26

for you to fetch changes up to eb54d2695b57426638fed0ec066ae17a18c4426c:

  bcachefs: Fix truncate sometimes failing and returning 1 (2025-02-26 19:31:05 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc5

Couple small ones, the main user visible changes/fixes are:

- Fix a bug where truncate would rarely fail and return 1

- Revert the directory i_size code: this turned out to have a number of
  issues that weren't noticed because the fsck code wasn't correctly
  reporting errors (ouch), and we're late enough in the cycle that it
  can just wait until 6.15.

----------------------------------------------------------------
Alan Huang (2):
      bcachefs: Fix memmove when move keys down
      bcachefs: Fix deadlock

Kent Overstreet (5):
      bcachefs: print op->nonce on data update inconsistency
      bcachefs: fix bch2_extent_ptr_eq()
      bcachefs: Revert directory i_size
      bcachefs: Check for -BCH_ERR_open_buckets_empty in journal resize
      bcachefs: Fix truncate sometimes failing and returning 1

 fs/bcachefs/btree_cache.c     |  9 +++++----
 fs/bcachefs/btree_io.c        |  2 +-
 fs/bcachefs/btree_key_cache.c |  2 +-
 fs/bcachefs/btree_locking.c   |  5 +++--
 fs/bcachefs/btree_locking.h   |  2 +-
 fs/bcachefs/data_update.c     |  1 +
 fs/bcachefs/dirent.h          |  5 -----
 fs/bcachefs/extents.h         |  2 +-
 fs/bcachefs/fs-common.c       | 11 -----------
 fs/bcachefs/fs-io.c           |  1 +
 fs/bcachefs/fsck.c            | 21 ---------------------
 fs/bcachefs/journal.c         |  4 +++-
 fs/bcachefs/sb-downgrade.c    |  5 +----
 fs/bcachefs/six.c             |  5 +++--
 fs/bcachefs/six.h             |  7 ++++---
 15 files changed, 25 insertions(+), 57 deletions(-)

