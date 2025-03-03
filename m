Return-Path: <linux-fsdevel+bounces-42991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA0A4CA88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653731884141
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1924F21577E;
	Mon,  3 Mar 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uzeKq0Ji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10F13A265
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024596; cv=none; b=kPBWwk+HpdvygHvaqbBnpbgVfrI2ySq8jir3GBnXi6nXs7WUKvWEb5teAyIBz5KFPczoCxsiJXghidqD0i7SSfhlplyJsp/IRW+u4wickQL+hDdjok8UT+qLveybt7t9M7fIEuTf8WwGGbk8bWM2Xu3J/6EopNK6JIWtc7EYJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024596; c=relaxed/simple;
	bh=EST9vMPqktKaUUbOVjBEqE4D6p4oXDL71IPCkKvUmoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4up2rdaPTyeEFm3iEC8llC3hR4wIy6gVNhUvwXi0sq/faTP8TOLEzR7yP2k6EQsQtIystvIGZWNUOD7Pqk9tz20C5tPMuzMTC0AMY8B3QmP0RIWe9dxJepg2zWAdkVRyC4rCsf2ojZtBGNM0T7oYjmncyl0dp1+fB7dAk3c1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uzeKq0Ji; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XmP3TyT8TdEGRL7DCj8hNBlSkCF/pqykHtlplsm+ulI=; b=uzeKq0JiLJq/lf5+FdtIGtaSEh
	/qLx+dtz30R0tydv14iPN5a6eYwnNu+625qAa4kbxdKu/9s7zQWLB9Vx+7UHYPDKqDCScXs0S3bWm
	DtJ61hBR8AmOriy2D1djaLDxLDetigt0efdx/cGbamRVVB4RRmaTWbjl0JoU1c4tTQhNSJ3zKPTlR
	41V/kJRRXvQ4u+6SF/YQM6K6vaNl7/HVy2iZlSRsYnLqRSoeHJuLgM527eLCODZ2Z75x4YTsBaDva
	vHTjMnuUtAESctAM3lQEz5gLRd9fZT2o7k4U5vLgV0HFm1FBsg9nVY9UPvr3NoIMjc0iJ/eIz2bAZ
	YtPDL1pw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp9yg-0000000DklD-3xvN;
	Mon, 03 Mar 2025 17:53:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6] ITER_XARRAY cleanups and consequences
Date: Mon,  3 Mar 2025 17:53:10 +0000
Message-ID: <20250303175317.3277891-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iov_iter currently extracts pages from the xarray when only folios have
been stored there.  This needs to be fixed before we can separate struct
folio from struct page.  __readahead_batch() is in the same situation,
and converting all three of these places lets us remove find_subpage()
and thp_nr_pages().  Removing readahead_page_batch() isn't particularly
related to these changes, but it may as well go in with this batch.

Matthew Wilcox (Oracle) (6):
  iov_iter: Convert iter_xarray_populate_pages() to use folios
  iov_iter: Convert iov_iter_extract_xarray_pages() to use folios
  pagemap: Remove find_subpage()
  filemap: Convert __readahead_batch() to use a folio
  pagemap: Remove readahead_page_batch()
  mm: Delete thp_nr_pages()

 include/linux/mm.h      |  9 ---------
 include/linux/pagemap.h | 40 ++++++----------------------------------
 lib/iov_iter.c          | 30 +++++++++++++++---------------
 3 files changed, 21 insertions(+), 58 deletions(-)

-- 
2.47.2


