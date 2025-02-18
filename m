Return-Path: <linux-fsdevel+bounces-41937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80BA3932B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC381890DEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2E21B87CB;
	Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2dzg8tq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3329D05
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857929; cv=none; b=ReoDOKD7oGCRLav4aYVwJ/r3SURO+PLjxrA8r1v7k6dkYfF/cDLISus5Le0MEtQa5WcSK54L/dwnIw19FIbqpb9/vDVNh2cQfdn+NO/c7mj3Srz68TsHeRUWstbokw+l5+KE0qNzwrYyJGqW6Xiv+2guafdOxbjZQuN1YtVchU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857929; c=relaxed/simple;
	bh=pQ9r7NvQSANmG4X1dPWfgoh8CabblT4kKEsiz/UBwE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuFcTkrr1njnvFCdQVN3v+nT7xkQdzxTqt75zs+bwhnq8xqLhCrY1xwTil3h80Ax82rkMCQMcN0gGMwxccgxoyfuBvKN9dw4Ot25Fi0FuCswFEEsh5KctqAPk61U6Qqzyhlpam1wGdaDNxfg4btsrsILcDZS++e5eXkTWsVBCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e2dzg8tq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=QSBcAaMb/qljfoVgIF4wX+lU6va9sOZY2zsNylGwXQg=; b=e2dzg8tqt/QSPBSeNAzY1ONhod
	Hoa0X16axLyTsvZu924I+7nVrEryNCvx6c53V0dgzZqX8cm6JvIX/iDZLc5cKG4UY/iRwyNEpbG9Y
	2V+g0P8n25gLwGorLdGC1Cbi+svqLcnU3DsfxEUstid1GGNsgPijjoGZu/c4yVzx45mx0q7Kf3qkQ
	pphGccOQUVme3Wg2vE1GbjwUAJGih2YjhWg0qhLFVnPWxep2NA3QoyU2UkLE3ZldrhiMRIcUmJW+O
	69YuOJvjdL/Iei1Bza4B9WjRHoIHxE7OaiMJajPKUYLeDY1N2bojYy6mzv1X+Tr9R6LGDa5Gvv33F
	j4+gikfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWb-00000002Tqv-1Abt;
	Tue, 18 Feb 2025 05:52:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/27] f2fs folio conversions for v6.15
Date: Tue, 18 Feb 2025 05:51:34 +0000
Message-ID: <20250218055203.591403-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More f2fs folio conversions.  This time I'm focusing on removing
accesses to page->mapping as well as getting rid of accesses to
old APIs.  f2fs was the last user of wait_for_stable_page(),
grab_cache_page_write_begin() and wait_on_page_locked(), so
I've included those removals in this series too.

Matthew Wilcox (Oracle) (27):
  f2fs: Add f2fs_folio_wait_writeback()
  mm: Remove wait_for_stable_page()
  f2fs: Add f2fs_folio_put()
  f2fs: Convert f2fs_flush_inline_data() to use a folio
  f2fs: Convert f2fs_sync_node_pages() to use a folio
  f2fs: Pass a folio to flush_dirty_inode()
  f2fs: Convert f2fs_fsync_node_pages() to use a folio
  f2fs: Convert last_fsync_dnode() to use a folio
  f2fs: Return a folio from last_fsync_dnode()
  f2fs: Add f2fs_grab_cache_folio()
  mm: Remove grab_cache_page_write_begin()
  f2fs: Use a folio in __get_node_page()
  f2fs: Use a folio in do_write_page()
  f2fs: Convert f2fs_write_end_io() to use a folio_iter
  f2fs: Mark some functions as taking a const page pointer
  f2fs: Convert f2fs_in_warm_node_list() to take a folio
  f2fs: Add f2fs_get_node_folio()
  f2fs: Use a folio throughout f2fs_truncate_inode_blocks()
  f2fs: Use a folio throughout __get_meta_page()
  f2fs: Hoist the page_folio() call to the start of
    f2fs_merge_page_bio()
  f2fs: Add f2fs_get_read_data_folio()
  f2fs: Add f2fs_get_lock_data_folio()
  f2fs: Convert move_data_page() to use a folio
  f2fs: Convert truncate_partial_data_page() to use a folio
  f2fs: Convert gc_data_segment() to use a folio
  f2fs: Add f2fs_find_data_folio()
  mm: Remove wait_on_page_locked()

 fs/f2fs/checkpoint.c    |  26 ++--
 fs/f2fs/data.c          | 130 ++++++++++---------
 fs/f2fs/f2fs.h          |  90 +++++++++----
 fs/f2fs/file.c          |  24 ++--
 fs/f2fs/gc.c            |  42 +++---
 fs/f2fs/node.c          | 279 ++++++++++++++++++++--------------------
 fs/f2fs/node.h          |   6 +-
 fs/f2fs/segment.c       |  26 ++--
 include/linux/pagemap.h |   9 --
 mm/filemap.c            |   2 +-
 mm/folio-compat.c       |  14 --
 11 files changed, 338 insertions(+), 310 deletions(-)

-- 
2.47.2


