Return-Path: <linux-fsdevel+bounces-48504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339DAB0434
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AACFA01403
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7B28C2CE;
	Thu,  8 May 2025 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="okVQq+H4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9128B7D6
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734318; cv=none; b=jpjjQ1Iy4Y9tP3H+eDwkwzjS0h2WHbd4zmSchsrBfcUN06slxOLf6N3HR48A5DevEOADrdj4xssqxYKXUobwVIvhXhi5rgj64o6EMjK+IKHjY0IwAUsWHARWLnjKls6tvlgp27y/SWYUlvC3/3GlN7/J/0xg+WyNl4fomRxYr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734318; c=relaxed/simple;
	bh=J3cKKOH7s7U79ixbNkjgk4QebBIXp0UsdbtkJVytPIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oaUhLe3QrIZxtrCr0ZLtuy4t2Pw+JOUvYcuSD9tVg9L+kvZWKQRjxqVIxCt08st2FtzRVU1mMR5JmeNab6eKYIzUd6vDRj0sSZrSJ/ncaF9WqpoEKaYRtQcpxmmgOn6a1uMTR3zNtm1Hmg87/GDvn88IyY1RfVDLvBwiv6sghLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=okVQq+H4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 May 2025 15:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746734302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dT6RVuiifS8Rip44Q88vbxcm6+1Lj1H0/0sdfRyNf0s=;
	b=okVQq+H46tP1gC21BTyPNa64Eu0BA1dN4Ov2yvXgRF+aPmKWi0jUTpaIM136Nqu+8KZ7rE
	fuJ6XFy3m1lBo+wp895CrH/R7amKCtgeS+nts3BQGnOf2RecfFHJ4h9xs1zjd1POrjFqsV
	Fuws3Q1dOUf1BJb6VreLJ6uZ/6ns7gA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.15-rc6
Message-ID: <pdixxswan4bhmajjvnczxa2nxh5tm52itlttopnuk3w6lzv3ms@inq7k7aws2rg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 6846100b00d97d3d6f05766ae86a0d821d849e78:

  bcachefs: Remove incorrect __counted_by annotation (2025-05-01 16:38:58 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-08

for you to fetch changes up to 8e4d28036c293241b312b1fceafb32b994f80fcc:

  bcachefs: Don't aggressively discard the journal (2025-05-07 17:10:10 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.15-rc6

- Some fixes to help with filesystem analysis: ensure superblock error
  count gets written if we go ERO, don't discard the journal
  aggressively (so it's available for list_journal -a).

- Fix lost wakeup on arm causing us to get stuck when reading btree
  nodes.

- Fix fsck failing to exit on ctrl-c.

- An additional fix for filesystems with misaligned bucket sizes: we now
  ensure that allocations are properly aligned.

- Setting background target but not promote target will now leave that
  data cached on the foreground target, as it used to.

- Revert a change to when we allocate the VFS superblock, this was done
  for implementing blk_holder_ops but ended up not being needed, and
  allocating a superblock and not setting SB_BORN while we do recovery
  caused sync() calls and other things to hang.

- Assorted fixes for harmless error messages that caused concern to
  users.

----------------------------------------------------------------
Kent Overstreet (10):
      bcachefs: thread_with_stdio: fix spinning instead of exiting
      bcachefs: Improve want_cached_ptr()
      bcachefs: Ensure proper write alignment
      bcachefs: Add missing barriers before wake_up_bit()
      bcachefs: fix hung task timeout in journal read
      bcachefs: Call bch2_fs_start before getting vfs superblock
      bcachefs: journal_shutdown is EROFS, not EIO
      bcachefs: Filter out harmless EROFS error messages
      bcachefs: Ensure superblock gets written when we go ERO
      bcachefs: Don't aggressively discard the journal

 fs/bcachefs/alloc_foreground.c | 22 +++++++++++++++++++++-
 fs/bcachefs/btree_io.c         |  9 ++++++++-
 fs/bcachefs/buckets.h          |  1 +
 fs/bcachefs/ec.h               |  1 +
 fs/bcachefs/errcode.h          |  2 +-
 fs/bcachefs/extents.c          |  5 +++--
 fs/bcachefs/fs.c               | 11 +++--------
 fs/bcachefs/journal_io.c       |  4 +++-
 fs/bcachefs/journal_reclaim.c  |  7 ++++---
 fs/bcachefs/move.c             |  3 ++-
 fs/bcachefs/super.c            |  5 +++++
 fs/bcachefs/thread_with_file.c |  4 +++-
 12 files changed, 55 insertions(+), 19 deletions(-)

