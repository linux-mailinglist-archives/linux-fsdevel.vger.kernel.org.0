Return-Path: <linux-fsdevel+bounces-41681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79EA34DC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B09162CCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620AD245AE3;
	Thu, 13 Feb 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mC8JUfDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6024502A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471547; cv=none; b=QyBlyt6Tb7P87MQUB55w94z2DBbA+EuV8iy+a7n6SWRIlLFOwdG4y0BtBD0cYpUvdu1QHkvETGOUUWyCunsVbcFu/bsGA6Vq0kG58rzWV98nEy3+Yd5YS+rbjFYTZBR5RSokutcsdVwzqZ4erTnnZmzpE9v+YyZymMRSo3NWKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471547; c=relaxed/simple;
	bh=1Guw0mIYsriyCkIJv5cUVdIdT/LfBp2e760wpd5KxtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WQhBE54ju/kTRvKj0Scoklc/JRxtNztXCj7R+qretDWANRwKCzr5V1KjjQ3ZLnxU/LTato77snZjKT/0oBiGmtBRaKQ9nMMz8R23NWNa15vGNHEwrxbtb0RDfhDUh6VibbzuvAeDBOh61v/w/BVhUt6o6X0b8CfqcnXsS1VPodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mC8JUfDZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Feb 2025 13:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739471533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=o6tkCX033U5d2xKqyWKzKdrt36SevUnWjaFNpp4AzCk=;
	b=mC8JUfDZ8kavgRx3NUqUiyeSyB/1ovXGBEDtJGawLED156GAQGn2kjU+IklQZvho7OaQVP
	waK/h6HmBCrFRX/VxZjInTzfFjXgK3wi5Db64OPbZRGk4oBUvgzhMLxUXHjG8YqfAXM5Uf
	Wtz2a7z4lq+EPBzR9dcwoaLLYl0MvhA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14-rc3
Message-ID: <hodakekojuga62jmvqimb63dyyavx6jqdy7t67cltmha55fl5n@jl2guh3xzh4s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Just small stuff.

As a general announcement, on disk format is now frozen in my master
branch - future on disk format changes will be optional, not required.

The following changes since commit 4be214c26936813b636eed2fac906f585ddbf0f9:

  bcachefs: bch2_bkey_sectors_need_rebalance() now only depends on bch_extent_rebalance (2025-02-06 22:35:11 -0500)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-12

for you to fetch changes up to 406e445b3c6be65ab0ee961145e74bfd7ef6c9e1:

  bcachefs: Reuse transaction (2025-02-12 18:44:50 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc3

- More fixes for going read-only: the previous fix was insufficient, but
  with more work on ordering journal reclaim flushing (and a btree node
  accounting fix so we don't split until we have to) the
  tiering_replication test now consistently goes read-only in less than
  a second.

- fix for fsck when we have reflink pointers to missing indirect
  extents

- some transaction restart handling fixes from Alan; the "Pass
  _orig_restart_count to trans_was_restarted" likely fixes some rare
  undefined behaviour heisenbugs.

----------------------------------------------------------------
Alan Huang (3):
      bcachefs: Fix use after free
      bcachefs: Pass _orig_restart_count to trans_was_restarted
      bcachefs: Reuse transaction

Kent Overstreet (4):
      bcachefs: Fix marking reflink pointers to missing indirect extents
      bcachefs: Split out journal pins by btree level
      bcachefs: Fix want_new_bset() so we write until the end of the btree node
      bcachefs: CONFIG_BCACHEFS_INJECT_TRANSACTION_RESTARTS

 fs/bcachefs/Kconfig                 |  7 +++++++
 fs/bcachefs/btree_iter.c            | 33 ++++++++++++++++++++++++++++++++-
 fs/bcachefs/btree_iter.h            | 14 +++++++++++++-
 fs/bcachefs/btree_trans_commit.c    |  4 ++++
 fs/bcachefs/btree_types.h           |  3 +++
 fs/bcachefs/btree_update_interior.h |  4 ++--
 fs/bcachefs/disk_accounting.h       |  2 ++
 fs/bcachefs/io_write.c              | 12 +++++++++++-
 fs/bcachefs/journal_reclaim.c       | 37 ++++++++++++++++++-------------------
 fs/bcachefs/journal_types.h         |  5 ++++-
 fs/bcachefs/reflink.c               |  2 ++
 fs/bcachefs/sb-errors_format.h      |  4 ++--
 12 files changed, 100 insertions(+), 27 deletions(-)

