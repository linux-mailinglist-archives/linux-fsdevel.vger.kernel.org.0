Return-Path: <linux-fsdevel+bounces-51880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF161ADC8C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324E81897A01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D12D9EEA;
	Tue, 17 Jun 2025 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DbTBsYFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CC29B773;
	Tue, 17 Jun 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157719; cv=none; b=Gz/DHPzBkmqMoohcVoHSelm206IY4QHlpAooYLvgN6dTizSrK0ftGju/WP/IolNpXSbKkk3SJzr8oqIIP6Hb2STxOIVksgKRbq7iWB5f8dXQ+VhraRKN+7spzo26KQii7VIjViOrI4nbAXJGS3Nkk5EyeEdnKHqyIfdXBZTKCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157719; c=relaxed/simple;
	bh=It7C+z+ZQiZjTYV4U6l464Mu4t1CnrcCeSXc2XOZIIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OD0wGAjwwiUL2KTmaw7KwQbAbwRBBk7Yoib8HO8gNJ02lOoue4Aamw8ADTk6dBFkb+tTVh5djaVDvpp9mA7ujqEYwD64m5pAlxrrcqmfEkCy77ZoxDywgMRByeiAU4Rvw8pvh94xJ5961AsnJTSdzuOskSZmXd3sM0R4bBBIOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DbTBsYFR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FdTRRm0oC/RSm8PxtVXN0Oov8m8H711ZJMG4xk6+HFo=; b=DbTBsYFRUOkdLQd1w+CFIYHQC+
	0hJVrG6HzYTdzsX1i49N6p4NrR1Obab2nTzlFN0FP5ci940MNPMuQ134FB79Qb9/WyeJVJc41wqpV
	FUlQzdcIcN2RynrOI/4j6Gdd5olpiQUN3pt+/nLp3w8xum2TyMydduU5O945QrbGo/jsNVOAknWrT
	bsseHpLpZYeeSXPPnvjEjpsZ7rkYnpfjDzB6wya1b8kpjAuGLfbwB5L2P0SNp9cBWS6WXoAlp9J/6
	Ugheyb3Tw08NOJQrqfxjhOFrrLDTyXlizzCiPRdMJLOrB4WfCmV+vltiGB7IqYEYI+G2qF9fKuPiJ
	UOzDqFWA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRTyH-00000006yks-2FyS;
	Tue, 17 Jun 2025 10:55:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: refactor the iomap writeback code v2
Date: Tue, 17 Jun 2025 12:54:59 +0200
Message-ID: <20250617105514.3393938-1-hch@lst.de>
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

This version passes basic testing on xfs, and gets as far as mainline
for gfs2 (crashes in generic/361).

Changes since v1:
 - fix iomap reuse in block/zonefs/gfs2 
 - catch too large return value from ->writeback_range
 - mention the correct file name in a commit log
 - add patches for folio laundering
 - add patches for read/modify write in the generic write helpers

Diffstat:
 Documentation/filesystems/iomap/design.rst     |    3 
 Documentation/filesystems/iomap/operations.rst |   51 --
 block/fops.c                                   |   37 +-
 fs/gfs2/aops.c                                 |    8 
 fs/gfs2/bmap.c                                 |   48 +-
 fs/gfs2/bmap.h                                 |    1 
 fs/gfs2/file.c                                 |    3 
 fs/iomap/buffered-io.c                         |  438 ++++++-------------------
 fs/iomap/internal.h                            |    1 
 fs/iomap/ioend.c                               |  220 ++++++++++++
 fs/iomap/trace.h                               |    2 
 fs/xfs/xfs_aops.c                              |  238 +++++++------
 fs/xfs/xfs_file.c                              |    6 
 fs/xfs/xfs_iomap.c                             |   12 
 fs/xfs/xfs_iomap.h                             |    1 
 fs/xfs/xfs_reflink.c                           |    3 
 fs/zonefs/file.c                               |   40 +-
 include/linux/iomap.h                          |   81 ++--
 18 files changed, 630 insertions(+), 563 deletions(-)

