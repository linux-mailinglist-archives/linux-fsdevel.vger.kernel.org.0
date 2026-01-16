Return-Path: <linux-fsdevel+bounces-74097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DED2F658
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA1B330E8D45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A68D35C1BE;
	Fri, 16 Jan 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y63Dk/S4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895E35EDB8
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558364; cv=none; b=NwXRTeOpKBrcOjjXK3xXhvJ8HRqj55pY78q/24LSnAf5Y77asG9N6FWGH9ML1ZOsB0URfKJ5SA1NYOyfW6kQ+0M4JTUY4XmHkCssHa4D1R1T7ApAO/LVkm3b4j9Zxj8F9lKO+eb74yy8lmYUpG7u0iMQDwh8l6ZSH3Is8o1N+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558364; c=relaxed/simple;
	bh=CkgSQfP50keuntmdZG6qAxJkhuOBA43ancMViB+6tQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=TefnvoLwZ1igefDwkabZaL6a4wtFexh3gRi92lspvtL565Yv93kWgSAXVS4rW97rP0S7EulrqiSZU6AbGG04TqOpK9eUkY3ZDb33bzHiOn7fSsitWJSS64H4dYElMcSn2SCUby6/X4+amkgp0l7SZu+rOIbcosvcy6cISG9Y2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y63Dk/S4; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260116101239epoutp0291ff935e50a395cdf088354be81a95d8~LLnUnwwcz0443004430epoutp02i
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:12:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260116101239epoutp0291ff935e50a395cdf088354be81a95d8~LLnUnwwcz0443004430epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768558359;
	bh=JAzX5xgjVm43mfj6cQjqFjI15Ts3QYdwTmH3kOjyoio=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Y63Dk/S4sI4gCiKFfH3k6CzRe1T5TUwO2afyUr0BhQayz3gNVqGJDemun1t+b2Mf9
	 xEc29M5aQPhw02V7YELVgN/ud7LiDYYND4iXhBPmzckJu4zzJJ7VzrR3AcfqybHZAn
	 TtoJoA14TrxQiO0DpIpv7BsD+M6hdNeTELfDxBSI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260116101238epcas5p4c15d799da203f7f934c340c72e44f11e~LLnUDGRsh1433714337epcas5p40;
	Fri, 16 Jan 2026 10:12:38 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dswdd5hKmz3hhT4; Fri, 16 Jan
	2026 10:12:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4~LLnR0H4d90903009030epcas5p1a;
	Fri, 16 Jan 2026 10:12:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260116101233epsmtip2bbc5466cb9511273e75408cb93992cbd~LLnO8r4Wh0748107481epsmtip2J;
	Fri, 16 Jan 2026 10:12:33 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, kundan.kumar@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v3 0/6] AG aware parallel writeback for XFS
Date: Fri, 16 Jan 2026 15:38:12 +0530
Message-Id: <20260116100818.7576-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4
References: <CGME20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4@epcas5p1.samsung.com>

This series explores AG aware parallel writeback for XFS. The goal is
to reduce writeback contention and improve scalability by allowing
writeback to be distributed across allocation groups (AGs).

Problem statement
=================
Today, XFS writeback walks the page cache serially per inode and funnels
all writeback through a single writeback context. For aging filesystems,
especially with high parallel buffered IO this leads to limited
concurrency across independent AGs.

The filesystem already has strong AG level parallelism for allocation and
metadata operations, but writeback remains largely AG agnostic.

High-level approach
===================
This series introduces an AG aware writeback with following model:
1) Predict the target AG for buffered writes (mapped or delalloc) at write
   time.
2) Tag AG hints per folio (via lightweight metadata / xarray).
3) Track dirty AGs per inode using bitmap.
4) Offload writeback to per AG worker threads, each performing a onepass
   scan.
5) Workers filter folios and submit folios which are tagged for its AG.

Unlike our earlier approach that parallelized writeback by introducing
multiple writeback contexts per BDI, this series keeps all changes within
XFS and is orthogonal to that work. The AG aware mechanism uses per folio
AG hints to route writeback to AG specific workers, and therefore applies
even when a single inode’s data spans multiple AGs. This avoids the
earlier limitation of relying on inode-based AG locality, which can break
down on aged/fragmented filesystems.

IOPS and throughput
===================
We see significant improvemnt in IOPS if files span across multiple AG

Workload 12 files each of 500M in 12 directories(AGs) - numjobs = 12
    - NVMe device Intel Optane
        Base XFS                : 308 MiB/s
        Parallel Writeback XFS  : 1534 MiB/s  (+398%)

Workload 6 files each of 6G in 6 directories(AGs) - numjobs = 12
    - NVMe device Intel Optane
        Base XFS                : 409 MiB/s
        Parallel Writeback XFS  : 1245 MiB/s  (+204%)

These changes are on top of the v6.18 kernel release.

Future work involves tighten writeback control (wbc) handling to integrate
with global writeback accounting and range semantics, also evaluate
interaction with higher level writeback parallelism.

Kundan Kumar (6):
  iomap: add write ops hook to attach metadata to folios
  xfs: add helpers to pack AG prediction info for per-folio tracking
  xfs: add per-inode AG prediction map and dirty-AG bitmap
  xfs: tag folios with AG number during buffered write via iomap attach
    hook
  xfs: add per-AG writeback workqueue infrastructure
  xfs: offload writeback by AG using per-inode dirty bitmap and per-AG
    workers

 fs/iomap/buffered-io.c |   3 +
 fs/xfs/xfs_aops.c      | 257 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_aops.h      |   3 +
 fs/xfs/xfs_icache.c    |  27 +++++
 fs/xfs/xfs_inode.h     |   5 +
 fs/xfs/xfs_iomap.c     | 114 ++++++++++++++++++
 fs/xfs/xfs_iomap.h     |  31 +++++
 fs/xfs/xfs_mount.c     |   2 +
 fs/xfs/xfs_mount.h     |  10 ++
 fs/xfs/xfs_super.c     |   2 +
 include/linux/iomap.h  |   3 +
 11 files changed, 457 insertions(+)

-- 
2.25.1


