Return-Path: <linux-fsdevel+bounces-20359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F18D21E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28541F2228F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B3B173340;
	Tue, 28 May 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OwlVGNob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB949172BC2;
	Tue, 28 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914914; cv=none; b=CVjAeToYrUDfHtdOwR20KPjEAG4ebnuRFk/cra66iyvmnN2X16sFx3+VI6ZUlboJFD3gZD67r/8qBsMszBvgt+34fULmCl6p3SBbkV9USuxVQAz9rINCtsy5InMh+WfCpnPy1xjvi9ln03dhOJntZ7DS5p38siyRPhjR3bdj6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914914; c=relaxed/simple;
	bh=9K8GpZ7etcSnucxFF2G1cHPXRI8rRbghQxoNFvCHJmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kY/Z6N9XGmVbfueqYgu5djQaF+ZZBrFm/NZC1KDQAIyuPjDYA5WPCw1noMS6bNOJIGcpaPZsMKe0pXBOPduQ/nJdVGPsSbhuDFJ17nulrLUd4dWc5yfmDKMQBPYkdfu1I3rt72+ZrjxMGBTxWipvrN8f895m+a5d6ft+cHHsuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OwlVGNob; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DPY4ewgOL9ef20dl6XfcBF6gsAnbZ4L7NDlpo9pBiTc=; b=OwlVGNob6pQ4jomRtv9o8Y7MTW
	1qJl9gNS4lGLHsyGM4aDvMj+404kFFadw+lULZVjPVoMCGNn0uD9p2yDrqkfv70UsJkY2Xqjd0itb
	otY1Mr1suid9aAlz0W4sQbgrDea4LX7IQu3Av24sNe4pl7/rqaiPeq3gxDgvwrP/OgWxXLklP4mdB
	PRLlfDi0IkntSVmFH6lYCrPA4WsLhzsPRoBsEqb3EaYtSZvq1U6Ho+FmwCb+S4feGnWtaonquhec6
	Ca1301sDlqopNfTuN7cMD5NMczXRldOKd/vYRdWYmVfN9XeT1+Qpc3+lpandCi4woWawU/VNHNTTO
	iZisxO1g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pj1-0LjG;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 0/7] Start moving write_begin/write_end out of aops
Date: Tue, 28 May 2024 17:48:21 +0100
Message-ID: <20240528164829.2105447-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christoph wants to remove write_begin/write_end from aops and pass them
to filemap as callback functions.  Here's one possible route to do this.
I combined it with the folio conversion (because why touch the same code
twice?) and tweaked some of the other things (support for ridiculously
large folios with size_t lengths, remove the need to initialise fsdata
by passing only a pointer to the fsdata pointer).  And then I converted
ext4, which is probably the worst filesystem to convert because it needs
three different bwops.  Most fs will only need one.

Not written yet: convert all the other fs, remove wrappers.

v2:
 - Redo how we pass fsdata around so it can persist across multiple
   invocations of filemap_perform_write()
 - Add ext2
 - Minor tweak to iomap

This is against 2bfcfd584ff5 (Linus current head) and will conflict with
other patches in flight.

Matthew Wilcox (Oracle) (7):
  fs: Introduce buffered_write_operations
  fs: Supply optional buffered_write_operations in buffer.c
  buffer: Add buffer_write_begin, buffer_write_end and
    __buffer_write_end
  fs: Add filemap_symlink()
  ext2: Convert to buffered_write_operations
  ext4: Convert to buffered_write_operations
  iomap: Return the folio from iomap_write_begin()

 Documentation/filesystems/locking.rst |  23 ++++
 fs/buffer.c                           | 158 ++++++++++++++++++--------
 fs/ext2/ext2.h                        |   1 +
 fs/ext2/file.c                        |   4 +-
 fs/ext2/inode.c                       |  55 ++++-----
 fs/ext2/namei.c                       |   2 +-
 fs/ext4/ext4.h                        |  24 ++--
 fs/ext4/file.c                        |  12 +-
 fs/ext4/inline.c                      |  66 +++++------
 fs/ext4/inode.c                       | 134 ++++++++++------------
 fs/iomap/buffered-io.c                |  35 +++---
 fs/jfs/file.c                         |   3 +-
 fs/namei.c                            |  25 ++++
 fs/ramfs/file-mmu.c                   |   3 +-
 fs/ufs/file.c                         |   2 +-
 include/linux/buffer_head.h           |  28 ++++-
 include/linux/fs.h                    |   3 -
 include/linux/pagemap.h               |  23 ++++
 mm/filemap.c                          |  77 ++++++++-----
 19 files changed, 417 insertions(+), 261 deletions(-)

-- 
2.43.0


