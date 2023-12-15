Return-Path: <linux-fsdevel+bounces-6223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63448150CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C341C23D99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7799563B5;
	Fri, 15 Dec 2023 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aB+irrCa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492759E40;
	Fri, 15 Dec 2023 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=97FcQZQjQrmA6OamzvNbQTkU/hd/MlI4iESmvm3umZo=; b=aB+irrCaGgsM25+DU3EtTIj+kO
	pwIhQlsNdbFA+gEMEbwHVdKFXq8o4wFiTU0TEdslVJO6byMLNQkCBex7I/XGM5RsZ2h2Jh+uxnULx
	7GaUSIPspkjfceg8JA0MEQ6GYpQZ3cYcgj/YcQ0EU/nDUPZnHp0kXIxTRvyad1vALL/AJbqhQ2I5O
	G1fovOIvhZtiwjvyM9+sgQwqkV0xrmnX+v3QwzGvnAUxt94hk7j8STcauKQH3n7wA1yQ/qooTp/0N
	LWhsThfb/6FbtX1gl9AsWjpUK9zfbW3VLxyJp+ZtuZDs5Ycn0ct4q0TlEXLgGrLcZL7BD6dI0YpyG
	t7pAngzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOU-0038i4-QW; Fri, 15 Dec 2023 20:02:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 00/14] Clean up the writeback paths
Date: Fri, 15 Dec 2023 20:02:31 +0000
Message-Id: <20231215200245.748418-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I don't think any of this conflicts with the writeback refactoring that
Christoph has kindly taken over from me, although we might want to redo
patch 13 on that infrastructure rather than using write_cache_pages().
That can be a later addition.

Most of these patches verge on the trivial, converting filesystems that
just use block_write_full_page() to use mpage_writepages().  But as we
saw with Christoph's earlier patchset, there can be some "interesting"
gotchas, and I clearly haven't tested the majority of filesystems I've
touched here.

Patches 3 & 4 get rid of a lot of stack usage on architectures with
larger page sizes; 1024 bytes on 64-bit systems with 64KiB pages.
It starts to open the door to larger folio sizes on all architectures,
but it's certainly not enough yet.

Patch 14 is kind of trivial, but it's nice to get that simplification in.

Matthew Wilcox (Oracle) (14):
  fs: Remove clean_page_buffers()
  fs: Convert clean_buffers() to take a folio
  fs: Reduce stack usage in __mpage_writepage
  fs: Reduce stack usage in do_mpage_readpage
  adfs: Remove writepage implementation
  bfs: Remove writepage implementation
  hfs: Really remove hfs_writepage
  hfsplus: Really remove hfsplus_writepage
  minix: Remove writepage implementation
  ocfs2: Remove writepage implementation
  sysv: Remove writepage implementation
  ufs: Remove writepage implementation
  fs: Convert block_write_full_page to block_write_full_folio
  fs: Remove the bh_end_io argument from __block_write_full_folio

 block/fops.c                | 21 +++++++++++--
 fs/adfs/inode.c             | 11 ++++---
 fs/bfs/file.c               |  9 ++++--
 fs/buffer.c                 | 36 ++++++++++-----------
 fs/ext4/page-io.c           |  2 +-
 fs/gfs2/aops.c              |  6 ++--
 fs/hfs/inode.c              |  8 ++---
 fs/hfsplus/inode.c          |  8 ++---
 fs/minix/inode.c            |  9 ++++--
 fs/mpage.c                  | 62 +++++++++++++++++--------------------
 fs/ntfs/aops.c              |  4 +--
 fs/ocfs2/alloc.c            |  2 +-
 fs/ocfs2/aops.c             | 15 ++++-----
 fs/ocfs2/file.c             |  2 +-
 fs/ocfs2/ocfs2_trace.h      |  2 --
 fs/sysv/itree.c             |  9 ++++--
 fs/ufs/inode.c              | 11 ++++---
 include/linux/buffer_head.h |  9 ++----
 18 files changed, 115 insertions(+), 111 deletions(-)

-- 
2.42.0


