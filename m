Return-Path: <linux-fsdevel+bounces-20571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EEB8D53B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F49E282DC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC7D159568;
	Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sjdc1+xt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13B158DC3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100480; cv=none; b=ogqUZbQfh3H7vK/upviKFzYn9TyDGeA2Z407c0tmrExiHAbZkA02UjQ9X7M0evw6txMFOBr5IGU6trAXCBX1HvG8FcSSMaHdrXqEKbIt4FNw77xunXITQcE9AIPaFcilNcEiyLUMUaEu1v2miaYQiTkiTGsNU4ddBjmx+wHMmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100480; c=relaxed/simple;
	bh=w+EgPosudnazrPUvmyjwiPipfqXgKaePpiK5borLaeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrOHnkK++ms1vOJlr1Nosoc9/cwt+O/mX8aakVTxLAMryllltMcuVPc5hhPSctI+7f3KUgoGXYlvfFXky7SX8W9FG2ypkSgt7J7oxCSd7sD3ojgpSMPcbarjf0CwZR721BDBl/EpBEb5cFkQJ8uhQFoaz6Z6rh2FH8S5k7OnLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sjdc1+xt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8lHt3izCsvoZaTLU7kDDsS+Xn5S9A6gh6T1gLJ2PtDA=; b=Sjdc1+xt6LZWnpNGFh+WX+bTQI
	DA+aLs/rDga7kiY01C4nrX1EsSzKTt8R/D5Wj2X+PJnT+qR5mHhbg+ltyy1/7Dr75011jpgPqOuBP
	jixc/IozTI5a52VPEUBzv0rU1dTfeKKMP/JzHc7eQa1DNQV7VRfx7/GgrNtKnk2CYhOcc663Ce6Nx
	vYy7H3OgQOktSRNvA6hODnkAHody2/EjMUG6pNc79dDgmXm4bPlDCYYcIn95n8tEgfHmSMAR4/Ii2
	WmW0ypWPCmOWrzGEvWG22k2WxNVrB97b807jPPXg7Xk3q9KYYO7a5cC7RV0RRroZwiF5I3LMzgsjA
	cGi+GM5w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGy-0000000B8Km-39xT;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/16] Prepare to remove PG_error
Date: Thu, 30 May 2024 21:20:52 +0100
Message-ID: <20240530202110.2653630-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches remove almost all remaining uses of PG_error from
filesystems and filesystem helper libraries.  In Linus' tree right now,
there is one place which tests the PG_error bit, and that is removed in
the jfs-next tree.  Thus, it is safe to remove all places which set or
clear the PG_error bit since it is not tested.

The ntfs3 patches are allegedly in progress:
https://lore.kernel.org/linux-fsdevel/85317479-4f03-4896-a2e1-d16b912e8b91@paragon-software.com/
so I haven't included a patch here for them.  We also need to remove one
spot in memory-failure that still sets it, so I haven't gone as far as
deleting PG_error yet.  I guess that's for next merge window.

Matthew Wilcox (Oracle) (16):
  befs: Convert befs_symlink_read_folio() to use folio_end_read()
  coda: Convert coda_symlink_filler() to use folio_end_read()
  cramfs: Convert cramfs_read_folio to use a folio
  efs: Convert efs_symlink_read_folio to use a folio
  hpfs: Convert hpfs_symlink_read_folio to use a folio
  isofs: Convert rock_ridge_symlink_read_folio to use a folio
  hostfs: Convert hostfs_read_folio() to use a folio
  jffs2: Remove calls to set/clear the folio error flag
  nfs: Remove calls to folio_set_error
  orangefs: Remove calls to set/clear the error flag
  reiserfs: Remove call to folio_set_error()
  romfs: Convert romfs_read_folio() to use a folio
  ufs: Remove call to set the folio error flag
  vboxsf: Convert vboxsf_read_folio() to use a folio
  iomap: Remove calls to set and clear folio error flag
  buffer: Remove calls to set and clear the folio error flag

 fs/befs/linuxvfs.c            | 10 ++++------
 fs/buffer.c                   |  7 +------
 fs/coda/symlink.c             | 10 +---------
 fs/cramfs/inode.c             | 25 ++++++++++---------------
 fs/efs/symlink.c              | 14 +++++---------
 fs/hostfs/hostfs_kern.c       | 23 ++++++-----------------
 fs/hpfs/namei.c               | 15 +++------------
 fs/iomap/buffered-io.c        |  8 --------
 fs/isofs/rock.c               | 17 ++++++++---------
 fs/jffs2/file.c               | 14 +++-----------
 fs/mpage.c                    | 13 +++----------
 fs/nfs/read.c                 |  2 --
 fs/nfs/symlink.c              | 12 ++----------
 fs/nfs/write.c                |  1 -
 fs/orangefs/inode.c           | 13 +++----------
 fs/orangefs/orangefs-bufmap.c |  4 +---
 fs/reiserfs/inode.c           |  1 -
 fs/romfs/super.c              | 22 ++++++----------------
 fs/ufs/dir.c                  |  1 -
 fs/vboxsf/file.c              | 18 +++++-------------
 20 files changed, 61 insertions(+), 169 deletions(-)

-- 
2.43.0


