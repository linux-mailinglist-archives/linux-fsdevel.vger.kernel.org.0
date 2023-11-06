Return-Path: <linux-fsdevel+bounces-2153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3647E2B5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6382818A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA92E648;
	Mon,  6 Nov 2023 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErdbLEVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94352D7B6
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:24 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F26D6D;
	Mon,  6 Nov 2023 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=AYLrLzMd96wdOm5CVv6L+hQ8+shGbfBweIymmP++Mr0=; b=ErdbLEVDt8UZxb8B7ua3XL+A4Z
	iUS1uRA/PHLPwEe0y0szLOVP6s50ka8w+tc15CRjMtuH0thktSpvRrhWLnMO23ZTpJ5dHilDj0g7p
	yw1oaI7SdqUIb4IbDDlS1rIrv5kUbPsa/7apRh3byFRcQTpc1ZX/xst1JbtWfAAaWbQvXS8lvPfFN
	t7cdnN75S1I7oDfi1J8EOFhh4oTiP0FNLrc1HTJWdyl03uIrJ3fkiH4QdCVk/B6hgpX0xqSC0fgYO
	+nOejuMxpk0xtjMnYr/bvF+seHLfg8Cpa84bHj1N3C+9SP8hZNG0HxTpyMJP0yMAcGgjHd36/Ls7O
	8S6ClGIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z3-007H7n-O6; Mon, 06 Nov 2023 17:39:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/35] nilfs2: Folio conversions
Date: Mon,  6 Nov 2023 17:38:28 +0000
Message-Id: <20231106173903.1734114-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series does most of the page->folio conversions needed in
nilfs2.  I haven't done the work to support large folios in nilfs2;
I don't know if that conversion will be worth the effort.  There are
still a few page uses left, but the infrastructure isn't quite there to
get rid of them yet.

Arguably, this is two separate series; the first takes care of the file
paths and the second takes care of directories.  I've tried my best to
include large folio support in the directory code because it'll be needed
for large block size devices.  It also tries to stay as close as possible
to the current ext2 code (so it also includes kmap_local support).

These patches are only compile-tested.  xfstests doesn't seem to know
about nilfs2.

Matthew Wilcox (Oracle) (35):
  nilfs2: Add nilfs_end_folio_io()
  nilfs2: Convert nilfs_abort_logs to use folios
  nilfs2: Convert nilfs_segctor_complete_write to use folios
  nilfs2: Convert nilfs_forget_buffer to use a folio
  nilfs2: Convert to nilfs_folio_buffers_clean()
  nilfs2: Convert nilfs_writepage() to use a folio
  nilfs2: Convert nilfs_mdt_write_page() to use a folio
  nilfs2: Convert to nilfs_clear_folio_dirty()
  nilfs2: Convert to __nilfs_clear_folio_dirty()
  nilfs2: Convert nilfs_segctor_prepare_write to use folios
  nilfs2: Convert nilfs_page_mkwrite() to use a folio
  nilfs2: Convert nilfs_mdt_create_block to use a folio
  nilfs2: Convert nilfs_mdt_submit_block to use a folio
  nilfs2: Convert nilfs_gccache_submit_read_data to use a folio
  nilfs2: Convert nilfs_btnode_create_block to use a folio
  nilfs2: Convert nilfs_btnode_submit_block to use a folio
  nilfs2: Convert nilfs_btnode_delete to use a folio
  nilfs2: Convert nilfs_btnode_prepare_change_key to use a folio
  nilfs2: Convert nilfs_btnode_commit_change_key to use a folio
  nilfs2: Convert nilfs_btnode_abort_change_key to use a folio
  nilfs2: Remove page_address() from nilfs_set_link
  nilfs2: Remove page_address() from nilfs_add_link
  nilfs2: Remove page_address() from nilfs_delete_entry
  nilfs2: Return the mapped address from nilfs_get_page()
  nilfs2: Pass the mapped address to nilfs_check_page()
  nilfs2: Switch to kmap_local for directory handling
  nilfs2: Add nilfs_get_folio()
  nilfs2: Convert nilfs_readdir to use a folio
  nilfs2: Convert nilfs_find_entry to use a folio
  nilfs2: Convert nilfs_rename() to use folios
  nilfs2: Convert nilfs_add_link() to use a folio
  nilfs2: Convert nilfs_empty_dir() to use a folio
  nilfs2: Convert nilfs_make_empty() to use a folio
  nilfs2: Convert nilfs_prepare_chunk() and nilfs_commit_chunk() to
    folios
  nilfs2: Convert nilfs_page_bug() to nilfs_folio_bug()

 fs/nilfs2/btnode.c  |  62 +++++------
 fs/nilfs2/dir.c     | 248 ++++++++++++++++++++------------------------
 fs/nilfs2/file.c    |  28 ++---
 fs/nilfs2/gcinode.c |   4 +-
 fs/nilfs2/inode.c   |  11 +-
 fs/nilfs2/mdt.c     |  23 ++--
 fs/nilfs2/namei.c   |  33 +++---
 fs/nilfs2/nilfs.h   |  20 ++--
 fs/nilfs2/page.c    |  93 +++++++++--------
 fs/nilfs2/page.h    |  12 +--
 fs/nilfs2/segment.c | 157 ++++++++++++++--------------
 11 files changed, 338 insertions(+), 353 deletions(-)

-- 
2.42.0


