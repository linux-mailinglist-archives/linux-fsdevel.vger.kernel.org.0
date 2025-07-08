Return-Path: <linux-fsdevel+bounces-54247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C6AFCC78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067071AA7121
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E700B2DECAE;
	Tue,  8 Jul 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KIFPQnKZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3F2DEA76;
	Tue,  8 Jul 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982700; cv=none; b=DdLnW30fkQGBk6rTjS7J1YNC1g233w3bTRhZYuQSLctIdq63OI9WVXPQsVqcxhQu7Qm0gLBUtTMabz4qkVSapuGwlEsgiYTkp3pPMBKIhCwBmvZA5n94YomDgno3Eiwti3zpBXKUHbWolTIPUtVSHZ5TCvpA32rqBS38ouNabVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982700; c=relaxed/simple;
	bh=oIWBqLmskZuT/2QX09N+bGfyYxxJcQ6fikosBmRCKx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k20MeuyPDd/9ZIYUdLfa44S1bGekD1E1OQ0Cvi+C7GKZSliE7KQIuXp5jtlHlYVRShQ+ZHTKEj6BBksg1WpOzTOfGRoVjxnuydp+sjR0JkqZjY9RtEM2m+/EP+BaQCCqWAzURReAs/iEpSBeJgAhjRTA+X1RQbH4RFK7eadBpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KIFPQnKZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JWUKQEHin5ADm1d3OlADiFwfYmc6RvQ5U4cxm83waxc=; b=KIFPQnKZrvuB7xw3M8Noas0Fmf
	hZJX4zoNMxw79VC2+7MD/hh/bO9TEa0OAYYL8EFbPjIhHYd/eL5ZT57LM9xn3i+RSC20TC7ekoRJu
	8Vpo1B/qwqEPfLVdGdANdKwwiVkDg0KixYMxmtL8wAuBc0qgk2+6FU8LLyKMENBEt2DeW1/rBTJR8
	ZcKqMKAhF/KMZ9LRDtySz41UEoTODOe8yYq5uG4PKxjEdcJ+YZRxFZx4Sva1uzepK7kgRo65qcwxg
	sUVaQQax3MZUYJFkeuAgGERT4WiyP/BECI5uBruXmEsE90sKr4iyjB1XCQF7WF47W3JpKY5rZMxwk
	oTcHV1Ew==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8jP-00000005UNW-3BQg;
	Tue, 08 Jul 2025 13:51:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: refactor the iomap writeback code v4
Date: Tue,  8 Jul 2025 15:51:06 +0200
Message-ID: <20250708135132.3347932-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is an alternative approach to the writeback part of the
"fuse: use iomap for buffered writes + writeback" series from Joanne.
It doesn't try to make the code build without CONFIG_BLOCK yet.

The big difference compared to Joanne's version is that I hope the
split between the generic and ioend/bio based writeback code is a bit
cleaner here.  We have two methods that define the split between the
generic writeback code, and the implemementation of it, and all knowledge
of ioends and bios now sits below that layer.

This version passes testing on xfs, and gets as far as mainline for
gfs2 (crashes in generic/361).

Changes since v3:
 - add a patch to drop unused includes
 - drop the iomap_writepage_ctx renaming - we should do this separately and
   including the variable names if desired
 - add a comment about special casing of holes in iomap_writeback_range
 - split the cleanups to iomap_read_folio_sync into a separate prep patch
 - explain the IOMAP_HOLE check in xfs_iomap_valid
 - explain the iomap_writeback_folio later folio unlock vs dropbehind
 - some cargo culting for the #$W# RST formatting
 - "improve" the documentation coverage a bit

Changes since v2:
 - rename iomap_writepage_ctx to iomap_writeback_ctx
 - keep local map_blocks helpers in XFS
 - allow buildinging the writeback and write code for !CONFIG_BLOCK

Changes since v1:
 - fix iomap reuse in block/zonefs/gfs2 
 - catch too large return value from ->writeback_range
 - mention the correct file name in a commit log
 - add patches for folio laundering
 - add patches for read/modify write in the generic write helpers

Diffstat:
 Documentation/filesystems/iomap/design.rst     |    3 
 Documentation/filesystems/iomap/operations.rst |   57 +-
 block/fops.c                                   |   37 +
 fs/gfs2/aops.c                                 |    8 
 fs/gfs2/bmap.c                                 |   48 +-
 fs/gfs2/bmap.h                                 |    1 
 fs/gfs2/file.c                                 |    3 
 fs/iomap/Makefile                              |    6 
 fs/iomap/buffered-io.c                         |  554 +++++++------------------
 fs/iomap/direct-io.c                           |    5 
 fs/iomap/fiemap.c                              |    3 
 fs/iomap/internal.h                            |    1 
 fs/iomap/ioend.c                               |  220 +++++++++
 fs/iomap/iter.c                                |    1 
 fs/iomap/seek.c                                |    4 
 fs/iomap/swapfile.c                            |    3 
 fs/iomap/trace.c                               |    1 
 fs/iomap/trace.h                               |    4 
 fs/xfs/xfs_aops.c                              |  212 +++++----
 fs/xfs/xfs_file.c                              |    6 
 fs/xfs/xfs_iomap.c                             |   12 
 fs/xfs/xfs_iomap.h                             |    1 
 fs/xfs/xfs_reflink.c                           |    3 
 fs/zonefs/file.c                               |   40 +
 include/linux/iomap.h                          |   82 ++-
 25 files changed, 705 insertions(+), 610 deletions(-)

