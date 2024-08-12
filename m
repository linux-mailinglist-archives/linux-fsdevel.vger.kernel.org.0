Return-Path: <linux-fsdevel+bounces-25630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38794E6AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0102282404
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6E153565;
	Mon, 12 Aug 2024 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JKDWWdaB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5402599;
	Mon, 12 Aug 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444310; cv=none; b=V1D1JJP/DFLXvBj4W2JpzrnZn3k/5zFo7tEtdTLYkQRAxZAayQqt9SXMvpeQI56CMWF53ZRCxMoZqyjScWeSwUzio/TFUeLLW3PaDBis2A6hwDOqvh7ee9IZGXonk7/xSADI2crmkzVPiY+CQmbbpamTtz5C7TDqbp7nkTe1kTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444310; c=relaxed/simple;
	bh=yGngzFisU3hHM/W+/P9PCmF6ot5hT/WB3q7V+4e6Sqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3pE76T/zGXezKUFxE+7JX/de/DJenx4RNcojVk7gd4z9WayLKFqjQLZumVXlXYdRa9ABKUJNRoQErrWluzuht5E/UGwjucIOANtj6Dapl4COX4+72iPuSua4LGsUUIiDnGbs9WUUQVMn/iLkQq4PihTysEnua3EpqapGrIElbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JKDWWdaB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FuyQkuQbkI6CMzqgMD1lf+z72iAYbcxitO6ISRVGreY=; b=JKDWWdaBFDZ62CMNAal85eU9iv
	MsbwcVQaHQA6SUi3Zn0vLwWn1eOgE+FkiiLTCh5zjG2RzlAx8KelK6ahb5r3WdknDokvmhWnIXmwq
	eoTJCZCETv5t5Ll+pwGaO9z596zDLpq2HYFPR3uUyxGcEek5aG7OH+E4Kwah3MUvtg4zcZM8zPas5
	PSMSTr8sgVxD95JhgQob+feDXghhTq65+sOUMAuu88AtpTLQLK/ke3b4duSrQBevFDteUnGWZTDLs
	y2ySCF3h073H9aPSzwX1+DnP4b0wjXpP4BKy5tcXnOGkkb1TdK25efwogfcTXB/Qfswg7yqN22aZX
	9t0SF+iA==;
Received: from 2a02-8389-2341-5b80-ee60-2eea-6f8f-8d7f.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ee60:2eea:6f8f:8d7f] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOao-0000000H1JW-3sGv;
	Mon, 12 Aug 2024 06:31:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: conver XFS perag lookup to xarrays
Date: Mon, 12 Aug 2024 08:30:59 +0200
Message-ID: <20240812063143.3806677-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

for a project with the pending RT group code in XFS that reuses the basic
perag concepts I'd much prefer to use xarrays over the old radix tree for
nicer iteration semantics.

This series converts the perag code to xarrays to keep them in sync and
throws in the use of kfree_rcu_mightsleep in the same area.

To easily allow porting libxfs code to userspace this can't use xa_set
which requires stealing bits from the pointer, and as part of
investigating that I realized that the xa_set API is generally not so
nice for callers for which a pre-existing entry in the xarray is
always an error.  Thus the first patch adds a new xa_set wrapper that
treats an existing entry as an error and avoids the need to use of
xa_err.  It could also be used to clean up a significant number of
existing callers.

Diffstat:
 fs/xfs/libxfs/xfs_ag.c |   93 ++++---------------------------------------------
 fs/xfs/libxfs/xfs_ag.h |   14 -------
 fs/xfs/xfs_icache.c    |   77 ++++++++++++++++++++++++++--------------
 fs/xfs/xfs_mount.h     |    3 -
 fs/xfs/xfs_super.c     |    3 -
 fs/xfs/xfs_trace.h     |    3 -
 include/linux/xarray.h |    1 
 lib/xarray.c           |   33 +++++++++++++++++
 8 files changed, 96 insertions(+), 131 deletions(-)

