Return-Path: <linux-fsdevel+bounces-54498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 965AEB0036C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6F1C4766F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068025C6EE;
	Thu, 10 Jul 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1oem0Rlo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31EF258CFF;
	Thu, 10 Jul 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154433; cv=none; b=uy3n5+vIdubIykSEVlsJEsL8lb5e6q5ZpZ3bbshhjdNMCqnlcrXuXqYhc7/M7trZyCojgY1EaGdtRZ4ItzRH9kZ9IMj4Q3xgA8IjYrHazmAVVRzvkPheteOxShpq8BL/orCARO1WAA0bqtxxWxtC5ueVWX6Z/isOup9vG90Rlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154433; c=relaxed/simple;
	bh=MWn5XlCdAjB+sK9dSdXIVMPxxACg3YrERKdTXwshHVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVrQFUzvVoFYGvCCQA24UldrNluyjfDCrC/zDc6hZNRL8pgSkM5AjeP7rLBRaVFlXD8K+8VVTZW1fBl/sbUrh3LiDn8W9aF9yeKtR1GuTYJ+3rqlhWpvOUdzYp8QbIKodd5ctWNbYXKbCCHt3IpWlM1+/s+I4S/XiXS/Z7KBRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1oem0Rlo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tetkzlCfenrpH7MgGkZct/9GsLBQFBzGpcaOg7hONcs=; b=1oem0RlogcLMNVqqMJ4Y/EJTeP
	cWLlfzX7BH8XzjU0z7Bcx7TTQLlM1R8QHpcxv5YT+5NnGw0i0cr7gYVkUflo8bojjqInu3ThiRRXZ
	XIxmKal8isykNv6LnYb5G05wRnujmp2EjhdOPBdjaZ7xQJUrroEi52bQ/+YEHrVgSW6j2VRa4821U
	dZtcl0/n91f5q4TuChnxrkunFYm57HDRxsv8g64cYxrVGa8O6gud9V22PvGNz/QEQgB4SrplM7hjK
	8op6FfnX32uYJqWPGBg6/gUhee9M8rVq2hKIITyi4Vys7sIMcFGDe9A/YfNSMRNLHOHNgXQv94m0h
	p48NlWgg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPI-0000000BwQQ-2Dbk;
	Thu, 10 Jul 2025 13:33:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: refactor the iomap writeback code v5
Date: Thu, 10 Jul 2025 15:33:24 +0200
Message-ID: <20250710133343.399917-1-hch@lst.de>
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

Changes since v4:
 - add back includes needed in some configs
 - drop an include not needed after a code move

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
 fs/iomap/buffered-io.c                         |  553 +++++++------------------
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
 25 files changed, 705 insertions(+), 609 deletions(-)

