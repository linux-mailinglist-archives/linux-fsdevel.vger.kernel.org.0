Return-Path: <linux-fsdevel+bounces-43427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0DA5698D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6D189B549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71721C174;
	Fri,  7 Mar 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P2q4tSdD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF021ABB5
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355659; cv=none; b=s9yPrRcm1d9b2JkfzvgUVLK7CAPBrEZbuZygLcCJ6GTDiBZAdyU3UVlYZzAgBCUpvhPNi7cql8G3ygjOjp88Wg3FFSgOAq60dS7SGHTj5DUX1BTAtbBt8n95cT5LOYzdantNMUN1Yz/nw93GPTpzv7cRdSAnsOXZJ7kRZQtEMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355659; c=relaxed/simple;
	bh=b2aCBsRuNCnxXbfqx1KMyiXiBzciBCbR0uJx02S9RPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XptWrcjkWUHhCHXK6W7lDcC3/bOx8c2QX+/wDURjgIlbot77mhocJRvLtpLP9kKHs1+QHAMK5rI5R/iC98i7JLN9mSyuqyjPK6HBXOMtNU33LcHpJsgnHESBBwTdLihgT4xchkfHRYxpAR0DxEOxNgo1zXHs/dArFxUi2WUxHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P2q4tSdD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+taT2QSuxL8BkaKw5rATlyAdw/O8TmblfYyY8TlzKtQ=; b=P2q4tSdDk1vTyS4yQ8UtnlEgiT
	rTSbqcb1hggXVwczLfNokNr5lTyrPEmcEg9r2Fiddr8Ss/ztL1ISAkKwd3Xp1h1AdltBA8yHGj0zq
	fAN0Aafq6BV5Vzl0gPlbyi25y20AX4pC76CprIgFG86Uo0cmkBkdXFm0Du0za+Tvhkb6/RPJ3uDXo
	LtkaIPnCP5Q8dWNheEuAj2hBm+3seeDOOjbHCSXry/3tcU9f/goxuo4P7bpoQ5glrzpezR87yhSwN
	3RxFVJGiIlAO3KufL58simBwsjQ9qquBDzYKK5vbatEuLXrmO5uy8zipnmf78uNCrh7kCDzmgrsFg
	cGvenHsA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9X-0000000CXFp-1xdu;
	Fri, 07 Mar 2025 13:54:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 00/11] Remove aops->writepage
Date: Fri,  7 Mar 2025 13:54:00 +0000
Message-ID: <20250307135414.2987755-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was preparing for LSFMM and noticed that actually we're almost done
with the writepage conversion.  This patchset finishes it off.
Something changed in my test environment and now it crashes before
even starting a run, so this is only build tested.

The first five patches (f2fs and vboxsf) are uninteresting.  I'll try
and get those into linux-next for the imminent merge window.  I think
the migrate and writeback patches are good, but maybe I've missed
something.  Then we come to i915 needing to tell shmem to do writeout,
so I added a module-accessible function to do that.  I also removed
the setting/clearing of reclaim, which would be easy to bring back if
it's really needed.  Patch 10 is probably the exciting one where
pageout() calls swap or shmem directly.  And then patch 11 really just
removes the op itself and the documentation for it.  I may have
over-trimmed here, but some of the documentation was so out of date it
was hard to tell what was worth preserving.

Anyway, let's see what the bots make of this.  This is against
next-20250307.

Matthew Wilcox (Oracle) (11):
  f2fs: Remove check for ->writepage
  f2fs: Remove f2fs_write_data_page()
  f2fs: Remove f2fs_write_meta_page()
  f2fs: Remove f2fs_write_node_page()
  vboxsf: Convert to writepages
  migrate: Remove call to ->writepage
  writeback: Remove writeback_use_writepage()
  shmem: Add shmem_writeout()
  i915: Use writeback_iter()
  mm: Remove swap_writepage() and shmem_writepage()
  fs: Remove aops->writepage

 Documentation/admin-guide/cgroup-v2.rst   |  2 +-
 Documentation/filesystems/fscrypt.rst     |  2 +-
 Documentation/filesystems/locking.rst     | 54 +--------------------
 Documentation/filesystems/vfs.rst         | 39 ++++------------
 block/blk-wbt.c                           |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 32 ++++---------
 fs/buffer.c                               |  4 +-
 fs/f2fs/checkpoint.c                      |  7 ---
 fs/f2fs/data.c                            | 28 -----------
 fs/f2fs/node.c                            |  8 ----
 fs/vboxsf/file.c                          | 47 ++++++++++---------
 include/linux/fs.h                        |  1 -
 include/linux/shmem_fs.h                  |  7 +--
 mm/migrate.c                              | 57 ++---------------------
 mm/page-writeback.c                       | 28 +----------
 mm/page_io.c                              |  3 +-
 mm/shmem.c                                | 33 ++++++-------
 mm/swap.h                                 |  4 +-
 mm/swap_state.c                           |  1 -
 mm/swapfile.c                             |  2 +-
 mm/vmscan.c                               | 29 ++++++------
 21 files changed, 93 insertions(+), 297 deletions(-)

-- 
2.47.2


