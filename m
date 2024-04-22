Return-Path: <linux-fsdevel+bounces-17423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F528AD4E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D47280E72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E18155357;
	Mon, 22 Apr 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVFuun5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6A154BF9;
	Mon, 22 Apr 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814330; cv=none; b=L8MYjpmnj700CTK/UdiN4MwtA+F7+LbZLpxsWSOY6AKcDxSBtYkhB5XorMSu2o66TESYKF/r1tyg4FIyGOCh8kvq7tq3rHxWCFOmr1qVGczdY9jdJwNp0TsPU6fvwD1NTHjDno91GBo49NUhqxerPbZ+vvwhVZTpMJkM7ecLn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814330; c=relaxed/simple;
	bh=b2Rj3opjZh9SU8ZcSv7ZbtD0LkK9I7FqyE5TDSDPVWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tT1c0Xe8Ihd0bTHuyzEIh+ITe79e+IIIXxexQfABkbagMbbM2QB1Hy5c9GtAvO2+pYP//+eqa/LdlBwUX7v9b94LtM2/h01rdD4JGrZiHv96ojCOiqeYeAkmgJssPVIuXqRTe1hCG2jx8A0yyl3+nlKRYYxo5DsuLurZlmDaVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iVFuun5F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BsRcT1p9Rq9k0lqFVsL1BQMyOG2CLnUhTtPKipHdYSs=; b=iVFuun5FewOm3RInvwv4fMnNex
	D/ThQ1NFGSLHzklJpgtVi0NPeAb4g1PmIzyAQrhr0rYB/pH1IT8hPXvRe0vMJRwAE5VHWxdv6QTBJ
	k5vgXkzRHH8umR/N+t9oXiLbWCdip+FCiliRDZWn7QNFIQh4FU/eCDQJBAIr30abdYQJzwKVrScDl
	HQ+Kiv9H1r96UJmCovqps8XXDyqErjjkoF47GOlacsyjTpROH/8EOiTObERqgSD0jaabWg/MLJ+G6
	QG2i5/x3vu3sYXtGcYWd20K3u99RAhncyBuliq6LoqmWcHiG97QXzqaccHWEHoCPZazM49q9dx1NW
	B6zHTxAA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOY-0000000EpO4-3n4C;
	Mon, 22 Apr 2024 19:32:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/11] Convert (most of) ntfs3 to use folios
Date: Mon, 22 Apr 2024 20:31:50 +0100
Message-ID: <20240422193203.3534108-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm not making any attempt here to support large folios.  This is just
to remove uses of the page-based APIs.  There are still a number of
places in ntfs3 which use a struct page, but this is a good start on
the conversions.

v2:
 - Rebase on next-20240422
 - Drop "Convert reading $AttrDef to use folios", "Use a folio to read
   UpCase", "Remove inode_write_data()" and "Remove ntfs_map_page and
   ntfs_unmap_page" due to changes.
 - Add "Convert inode_read_data() to use folios", "Remove calls to
   set/clear the error flag", "Convert attr_wof_frame_info() to use a
   folio", "Convert ntfs_get_frame_pages() to use a folio", "Convert
   ni_readpage_cmpr() to take a folio"

Matthew Wilcox (Oracle) (11):
  ntfs3: Convert ntfs_read_folio to use a folio
  ntfs3: Convert ntfs_write_begin to use a folio
  ntfs3: Convert attr_data_read_resident() to take a folio
  ntfs3: Convert ntfs_write_end() to work on a folio
  ntfs3: Convert attr_data_write_resident to use a folio
  ntfs3: Convert attr_make_nonresident to use a folio
  ntfs3: Convert inode_read_data() to use folios
  ntfs3: Remove calls to set/clear the error flag
  ntfs3: Convert attr_wof_frame_info() to use a folio
  ntfs3: Convert ntfs_get_frame_pages() to use a folio
  ntfs3: Convert ni_readpage_cmpr() to take a folio

 fs/ntfs3/attrib.c  | 94 ++++++++++++++++++++--------------------------
 fs/ntfs3/file.c    | 17 +++++----
 fs/ntfs3/frecord.c | 29 +++++++-------
 fs/ntfs3/inode.c   | 73 ++++++++++++++++++-----------------
 fs/ntfs3/ntfs_fs.h |  8 ++--
 5 files changed, 102 insertions(+), 119 deletions(-)

-- 
2.43.0


