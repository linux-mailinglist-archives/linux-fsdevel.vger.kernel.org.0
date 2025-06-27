Return-Path: <linux-fsdevel+bounces-53141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0395DAEAF85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAC93BFA88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A061219EAD;
	Fri, 27 Jun 2025 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THeVxSsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758823A9;
	Fri, 27 Jun 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007814; cv=none; b=WwAAplgzd7t2NSprbmHWTVmb3p96nhR4KoOU3GxxK8Oy1ethxuA0+wOB55QSP4Bt2Z1ldFaUztUCluSZADoVr8cnKBK+O/4irOD3U+QMP9uTD+lvyprUIYSpDxJb+U07fDFYYxGAI2hxe9wFkXAfupAm23uGe7+4BaJtn90bVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007814; c=relaxed/simple;
	bh=WPP+XTvVkt7wsAkjbdVaTPogFknzrFJCyO2mfGj9f7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPzSm7C8dx6GEy/19+xsVhmxdTu6ExNKSvmyedF6JGbjThxexgXp53AUlp2Ag8M42IUmuG5qABobPHLCnNCJVn7k4KJvD7e1wuugcos75TcWbEejbM8vHokXr/Lx3ZhLc6xfriF8OqbAigJMFiBTo5qwA9VMCDINTwtCDVeb/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=THeVxSsP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nRU7JFAUN/cCq121u96OGibkfR2EFFjUYjqgAvFiquc=; b=THeVxSsPV7hZfuEUx2Dss5024q
	d9su6kh0tTRaVU6jIoX+yUoz7bUqSnmnB0CycJ2tiP7H+YkzkirpRhGyVopdnYiM22QUAQHKns/n6
	7ffOH96q2bRU6o0vsg0uEmztkMYqWQ2y+Ixn5+wGYeaDQU1RfMNzZmcNGsndstb+IOkkks5U4zzvb
	WpSRO7AjqDLKqnD7ih7dw5P1R6Jvj3yHdoHKBDr7k5LW4kn7FRCfbEzP/L76NTQJu5KR9B1fMPVZf
	B4CDVM92HkmztVlxwE8ZdapDfZaZri2pUv/mtPHt+kV8Ga6vx+fTNUnG8IkRl+EwGML+cke9HJbTa
	4YNxBlTQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV37T-0000000Dlsc-2O0a;
	Fri, 27 Jun 2025 07:03:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: refactor the iomap writeback code v3
Date: Fri, 27 Jun 2025 09:02:33 +0200
Message-ID: <20250627070328.975394-1-hch@lst.de>
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
 Documentation/filesystems/iomap/operations.rst |   51 --
 block/fops.c                                   |   37 +
 fs/gfs2/aops.c                                 |    8 
 fs/gfs2/bmap.c                                 |   48 +-
 fs/gfs2/bmap.h                                 |    1 
 fs/gfs2/file.c                                 |    3 
 fs/iomap/Makefile                              |    6 
 fs/iomap/buffered-io.c                         |  541 +++++++------------------
 fs/iomap/internal.h                            |    1 
 fs/iomap/ioend.c                               |  220 ++++++++++
 fs/iomap/trace.h                               |    4 
 fs/xfs/xfs_aops.c                              |  226 ++++++----
 fs/xfs/xfs_file.c                              |    6 
 fs/xfs/xfs_iomap.c                             |   12 
 fs/xfs/xfs_iomap.h                             |    1 
 fs/xfs/xfs_reflink.c                           |    3 
 fs/zonefs/file.c                               |   40 +
 include/linux/iomap.h                          |   85 ++-
 19 files changed, 695 insertions(+), 601 deletions(-)

