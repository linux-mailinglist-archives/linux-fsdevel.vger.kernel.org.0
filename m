Return-Path: <linux-fsdevel+bounces-17185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1496F8A8A92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E7528438E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB48173355;
	Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qIO3xfIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD91172BCA
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376623; cv=none; b=c6Zx8OFqzzTxaWTYgR08aGECDt+L+98IlJ0HScKb0/EjekSvFA30D1SM/IcdwpVzu42bLyIDiiusjJ2mXvAz5BXykD4GludCbogjBadXvnn/zjx6/6akLg5HmQ21dk00frpqFhmlWMJJXkz9JNhFd7HPfDasxK3eaDBa5kWtTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376623; c=relaxed/simple;
	bh=n57jzba+Gfbvg1uOXbMVNTMAFabp2509sfnvSq/Uyew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RswaAj007LM30Yz2D3Bg+vSTgWOW5Zvi31a38nIVsom6v1KAfZgpuBtmprk1u3y+a7M+ple5iIKgty0+vgZhFBmxYtfvvVpQoJvFHXN7TH4bVZVJrHD5iMvZNg3ozqzo0fSsh6X2Bpcpd/H2lXvOUGme8CWfE8CtwhE4DzBLhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qIO3xfIy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=368AqJWBal9TUQCrUQFqs/NdTKLLVAvptgY7mzFVvjc=; b=qIO3xfIyPpkuK2l2RyiBv21xIs
	tvZlS98dv77eWMXSrElKvZCuecb9jw6gUbCU70TOTH7+J+90Y8HRJre2Lr1GUsngTJGQDRv250U+6
	uo4CVS11Av2kdpz1zFiOaIzv5QgPT1eK4DsaUF01rFRkzh83OsKnUsKSOf5zZeG517u8IBlg10WmW
	wqcfygtVoKs2qVJ+iqpxYqNanPBwCVDT2u8aZG215fsUnn7Y+v0tlzlLU81YGW+MgX1cZjPxq3BZu
	13qp//0Y2Z4t/HJiGo+Wkq7vF0bNG65eryB5k5P7HY1btn4ok9yDnjP2R4iqHynsntm+iZJgAcNKF
	u+XUY7iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wm-00000003Qsf-3GW3;
	Wed, 17 Apr 2024 17:57:00 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/13] JFS folio conversion
Date: Wed, 17 Apr 2024 18:56:44 +0100
Message-ID: <20240417175659.818299-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset removes uses of struct page from the I/O paths of JFS.
write_begin and write_end are still passed a struct page, but they convert
to a folio as their first thing.  The logmgr still uses a struct page,
but I think that's one we actually don't want to convert since it's
never inserted into the page cache.

I've included the removal of i_blocks_per_page() in this series as JFS
is the last user.

Tested with xfstests; some failures observed, but they don't seem to be
related to these patches.  I haven't tried with PAGE_SIZE > 4kB, so the
MPS_PER_PAGE > 1 paths are untested.

v2:
 - Fix build errors on machines with PAGE_SIZE > 4096

Matthew Wilcox (Oracle) (13):
  jfs: Convert metapage_read_folio to use folio APIs
  jfs: Convert metapage_writepage to metapage_write_folio
  jfs: Convert __get_metapage to use a folio
  jfs: Convert insert_metapage() to take a folio
  jfs; Convert release_metapage to use a folio
  jfs: Convert drop_metapage and remove_metapage to take a folio
  jfs: Convert dec_io to take a folio
  jfs; Convert __invalidate_metapages to use a folio
  jfs: Convert page_to_mp to folio_to_mp
  jfs: Convert inc_io to take a folio
  jfs: Convert force_metapage to use a folio
  jfs: Change metapage->page to metapage->folio
  fs: Remove i_blocks_per_page

 fs/jfs/jfs_logmgr.c     |   2 +-
 fs/jfs/jfs_metapage.c   | 299 ++++++++++++++++++++--------------------
 fs/jfs/jfs_metapage.h   |  16 +--
 include/linux/pagemap.h |   6 -
 4 files changed, 156 insertions(+), 167 deletions(-)

-- 
2.43.0


