Return-Path: <linux-fsdevel+bounces-40335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8CA2250B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB743A5D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 20:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8281E2858;
	Wed, 29 Jan 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mXz+s1aA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C81DF754
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181881; cv=none; b=RIcVTJ8aZRK6ZEf4i3mtv8TMHP0nkBr8F6Yfycy1H3o+2NvTM5rifYNIvxR4EycbLIzrhpmWzWyob7UCVuPaSEYeVv4Xy3gIwe6CB5df+krNAm0CvPvqbtxnDR3ak2L0AHT4aRumYzv+ig7n4CRinU3VUGtyPrKFhovh2W1FffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181881; c=relaxed/simple;
	bh=sAwAWdqGNxs88O3PkdoXrdr3ThCAcll0McarPw6UcoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p4ZTe4IPGWgvBqjfCAyNzohIxmGVKYW39g9ENgosid7A2gqO7ekHjjnszuSMK2hhDXrM5WUJFuf6BLnmcoP6iVA2nwEyDT5EzBHObZ27NeJLckQaRagutzWAMfDKkMnD+BLFingWMd8kEP0EhugPjzYBrHu8uVlFTFeV0/8v05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mXz+s1aA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Jan 2025 15:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738181862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2/GG4KjjxZAkPe+5N7kxlF2QFWmnJiuPbGo4VtAF/No=;
	b=mXz+s1aAxE41fShKi6Hsb+kuMfQoJapC1m9g5fycAuvJqqB2EXY5X3wf9oz10iGL9LIQso
	W1ADzdCkzgu7xoWKa7QQnB/gb6WU1g/Cw0BQvRZ5yDDFjs++l3sIqrlYTULlBQGVHE9ion
	QgSG8XdLxCTAmCYFOFhKSQ8cOuZxaHc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14-rc1
Message-ID: <uez7twvxdrdam2uoatpvtaeph2vkfru57r5oh33j2zjov2vqwq@2gtoztjt2p3d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, just some small stuff.

users seeing specific (reproducable) performance issues should ping me,
I have some new tools for tracking those down

The following changes since commit ff0b7ed607e779f0e109f7f24388e0ce07af2ebe:

  bcachefs: Fix check_inode_hash_info_matches_root() (2025-01-15 15:28:23 -0500)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-01-29

for you to fetch changes up to 5d9ccda9ba7e80893cd67905882315a4a7ab6ec1:

  bcachefs: Improve trace_move_extent_finish (2025-01-26 23:02:28 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc1

- second half of a fix for a bug that'd been causing oopses on
  filesystems using snapshots with memory pressure (key cache fills for
  snaphots btrees are tricky)
- build fix for strange compiler configurations that double stack frame
  size
- "journal stuck timeout" now takes into account device latency: this
  fixes some spurious warnings, and the main remaining source of SRCU
  lock hold time warnings (I'm no longer seeing this in my CI, so any
  users still seeing this should definitely ping me)
- fix for slow/hanging unmounts (" Improve journal pin flushing")
- some more tracepoint fixes/improvements, to chase down the "rebalance
  isn't making progress" issues

----------------------------------------------------------------
Kent Overstreet (11):
      bcachefs: Fix btree_trans_peek_key_cache()
      bcachefs: Reduce stack frame size of __bch2_str_hash_check_key()
      bcachefs: "Journal stuck" timeout now takes into account device latency
      bcachefs: bset_blacklisted_journal_seq is now AUTOFIX
      bcachefs: Improve decompression error messages
      bcachefs: rebalance, copygc enabled are runtime opts
      bcachefs: fix bch2_btree_node_flags
      bcachefs: Improve journal pin flushing
      bcachefs: Journal writes are now IOPRIO_CLASS_RT
      bcachefs: Fix trace_copygc
      bcachefs: Improve trace_move_extent_finish

 fs/bcachefs/btree_cache.c        |   5 +-
 fs/bcachefs/btree_iter.c         |   3 +-
 fs/bcachefs/btree_key_cache.c    |   4 +-
 fs/bcachefs/btree_trans_commit.c |   2 +-
 fs/bcachefs/compress.c           |  31 ++++++---
 fs/bcachefs/compress.h           |   4 +-
 fs/bcachefs/data_update.c        |  50 +++++++++-----
 fs/bcachefs/debug.c              |   1 +
 fs/bcachefs/io_write.c           |   4 +-
 fs/bcachefs/io_write.h           |   2 +
 fs/bcachefs/journal.c            |  92 +++++++++----------------
 fs/bcachefs/journal.h            |   9 ++-
 fs/bcachefs/journal_io.c         |   2 +
 fs/bcachefs/journal_reclaim.c    | 142 +++++++++++++++++++++++++++++++++------
 fs/bcachefs/journal_reclaim.h    |   3 +
 fs/bcachefs/journal_types.h      |  13 ++--
 fs/bcachefs/movinggc.c           |  11 +--
 fs/bcachefs/opts.h               |   4 +-
 fs/bcachefs/sb-errors_format.h   |   2 +-
 fs/bcachefs/str_hash.c           |  24 +++----
 fs/bcachefs/trace.h              |  26 ++++---
 21 files changed, 275 insertions(+), 159 deletions(-)

