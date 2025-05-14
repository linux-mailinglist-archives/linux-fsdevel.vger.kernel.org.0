Return-Path: <linux-fsdevel+bounces-48986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8831AB724C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8735E3A24C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541F27CCE7;
	Wed, 14 May 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8ZOLzYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F423CE;
	Wed, 14 May 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242373; cv=none; b=DYgQE1erPo0z8vb1qa4oHT4OeqASf6XwJYiU6mrbkv19AJ7GHoNwWB/qkQlJaLlTumdwrpJqyTHJoVjri0jdp06vd7g47NHLpqMM9hL9qoIF6wEF7y4ReodJNM0AoBsxbp80eYgmdYUA3uSWD+YXaYVEW+uVTk4nPlDE1w5URp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242373; c=relaxed/simple;
	bh=R/NptLT2JbWgzSLPeEsHj5cQhvfj6SEkp5vGXr1ekHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZ2GEBINEjHR4OxRjWIfTuGK+8nJkz0jthgqGqq/L/WpZJ5g2s23KfA2oj5/Wod6NbPP3vzsIgh8Nmfx3W+FIYKutuLz68cI5qBowa7J2O879NapWARkLTtdwdmPu52Vn13mCb2PXRPmuGhrvfJywK8lckgmZaoiApmnxd8MFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H8ZOLzYv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6JsMQlnluyAQsCrWn0bN/ZzrS37Nw3uH35+Y7+DKKG8=; b=H8ZOLzYvLj1VNkWXzzrBFTs+jx
	PCUMQuNSol6b0i2/B0l61jCZyyCf/wiuUiqoELfT9MVLClOQXy+S9aAdN0riMmGmyXHgGH6XBtJP8
	5hMVZHzTCVC6l8+QsI36ll3bUvR41P9SHqIRNArAXk6FnLCDHwjQusX4tECR8AtIpitsBtbfypaWi
	DyFwwZRkY2Wkm4uHBbwQR/kLVULf6HTb+Lyj68Iz3o/lyk0GphGWVGpAX4CY8GgHc5JJpr50NKkF8
	tIMqNN7PndYFXFs+lz7howxOVCmSW7MFNF4BsPtfmuYpDrdKLpO9B+GzAR93SpezwXzZluKElIS64
	fb2gN4Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFYW-0000000CahP-20Xs;
	Wed, 14 May 2025 17:06:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 0/3] Remove copy_page_from_iter_atomic()
Date: Wed, 14 May 2025 18:06:01 +0100
Message-ID: <20250514170607.3000994-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch here is a bug-fix that enables
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP to work correctly with
filesystems that support large folios.  Then we convert ntfs3 to use
copy_folio_from_iter_atomic() instead of copy_page_from_iter_atomic()
and finally remove copy_page_from_iter_atomic().

Matthew Wilcox (Oracle) (3):
  highmem: Add folio_test_partial_kmap()
  ntfs3: Use folios more in ntfs_compress_write()
  iov: Remove copy_page_from_iter_atomic()

 fs/ntfs3/file.c            | 31 +++++++++++++------------------
 include/linux/highmem.h    | 10 +++++-----
 include/linux/page-flags.h |  7 +++++++
 include/linux/uio.h        | 10 ++--------
 lib/iov_iter.c             | 29 +++++++++++++----------------
 5 files changed, 40 insertions(+), 47 deletions(-)

-- 
2.47.2


