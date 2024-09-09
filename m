Return-Path: <linux-fsdevel+bounces-28949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13E971BDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092631C229AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752951BA881;
	Mon,  9 Sep 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UZXv1nfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C41BF325
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889953; cv=none; b=Q7Fg39LaERPKM/tiGRwubEWcYeg6iNrtj3H4k2zh0c1WYSIsIT5MxIUXJkpRVBvWRsXEOJC9zlsWIJ+ht2Vd7lT7QsnaH/db1RyE/8uLIPMjWM5Gs/sJPg+B6Oa1QEE8XoUq/i7goqjbtbb+h+28RLKyXLR1s0Mdp2o5BlBWITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889953; c=relaxed/simple;
	bh=jjQFYMgyUAKr7GPyMSddKKP70RLlpHOV9E1bqzIQKqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pDS1pPZgIy/Yk9yg5gqXwMVm6JOckN+CZbDRYtORaT4w3VluRnIYBsu5pH2KxWx8P0UaC3hkiWJkKyII/qQcQXGWLTJO4RhvMETL3/zhA6q+0oysiS+dEwblmTFIUzsSrVwxcJ3uApxIW4k4QnmteCvlA6jEBI7DZk5LkY7LCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UZXv1nfz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Sep 2024 09:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725889949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aeqj0nbUuy/cfdqtEFeg/xP2DE4BRqCeRoWhaRbnTtc=;
	b=UZXv1nfzfvWUuvyoZJjtc/cYXdFGpfvHv5tGnkOBK1agYn2CshH2JKTclzG5qZA/zkZ1ta
	wCQHcR7Cume1M3wtd7iYXVTBTO8XXwGBwpVzvXockJZQNOrMnX3ywhqecPy6uqITJ8+H2P
	S7NhmOCUClNrqmnuci0tIkwXIl8jmHo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc8/final
Message-ID: <uyzlav7jahhammvvx2eymn4thh5vvpo3ngu7tdmkmyygdwim6c@3b7dyx3tbqyo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

this closes out the main critical bug users have been hitting

now to dig through the bug tracker some more...

The following changes since commit 53f6619554fb1edf8d7599b560d44dbea085c730:

  bcachefs: BCH_SB_MEMBER_INVALID (2024-09-03 20:43:14 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-09

for you to fetch changes up to 16005147cca41a0f67b5def2a4656286f8c0db4a:

  bcachefs: Don't delete open files in online fsck (2024-09-09 09:41:47 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc8

- fix ca->io_ref usage; analagous to previous patch doing that for main
  discard path
- cond_resched() in __journal_keys_sort(), cutting down on "hung task"
  warnings when journal is big
- rest of basic BCH_SB_MEMBER_INVALID support
- and the critical one: don't delete open files in online fsck, this was
  causing the "dirent points to inode that doesn't point back"
  inconsistencies some users were seeing

----------------------------------------------------------------
Kent Overstreet (6):
      bcachefs: Fix ca->io_ref usage
      bcachefs: Add a cond_resched() to __journal_keys_sort()
      bcachefs: Simplify bch2_bkey_drop_ptrs()
      bcachefs: More BCH_SB_MEMBER_INVALID support
      bcachefs: fix btree_key_cache sysfs knob
      bcachefs: Don't delete open files in online fsck

 fs/bcachefs/alloc_background.c   | 24 ++++++++++++------------
 fs/bcachefs/btree_journal_iter.c |  2 ++
 fs/bcachefs/buckets.c            | 15 ++++++++-------
 fs/bcachefs/ec.h                 |  4 +++-
 fs/bcachefs/extents.c            | 26 ++++++++++----------------
 fs/bcachefs/extents.h            | 23 +++++++++--------------
 fs/bcachefs/fs.c                 |  8 ++++++++
 fs/bcachefs/fs.h                 |  7 +++++++
 fs/bcachefs/fsck.c               | 18 ++++++++++++++++++
 fs/bcachefs/replicas.c           |  2 +-
 fs/bcachefs/sysfs.c              |  2 +-
 11 files changed, 79 insertions(+), 52 deletions(-)

