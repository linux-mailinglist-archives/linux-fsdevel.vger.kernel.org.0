Return-Path: <linux-fsdevel+bounces-17565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A228AFC51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476FBB24290
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB836AFE;
	Tue, 23 Apr 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="et9bn3Ck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAA2E647;
	Tue, 23 Apr 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912973; cv=none; b=kroX0wQemcMkN6es/mR5nwxXXl3FnkeVduXu+fjHIBxEAR6WJz9DptXGVLKHv5c6SJfmgHLK2c6eawsIajCbTWQRVURwxxlVLG9IWB0x3NoEJIz5mGA1xEvQqIrVKOCtuvq/6cuGNFDdgWMICSBD/JUweB7Q76Cm14wfi9ieglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912973; c=relaxed/simple;
	bh=BB3TxBW/zPDgVw5dpEkk69bicMyAu3O3vQR+R8OcYiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEbuoaN9xTvqn2yLLBuZCHOSr5xewEuI/nyeJ2HLgZ9/fbnancdd38KVH1y3AsZmxBAfz/Oxb8GL6U3mCVfnjTSZZj5AEBqJK+Puh696fKhRaGoO9lDSolp1DsNKZnnGLHsU75FNn4l1F0KVhB6b+6w9T38Ai/ZUsKWw8YycuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=et9bn3Ck; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Jo/OjuBX7+Ck/BIUygFAqUDlJfqBAMZkQTNEoiLOR9g=; b=et9bn3CkzMB3+HnIrCN3Uj3Sn2
	aQLlknGrRBNyt2qdPxSs7VeHT1SLo+HbT0YcdFSv3TF/TVQeNP7EeDbic5eG7ZKL3wPS3QKD4jPnr
	kOSe1jybNRVlGA8HI6UrFbPU+KYQ6CffAi2CuFYJGBn10G1tTPlpcYt+AwWWmVb8P1wwX+PyjUz85
	eJbvU3XFouLaJenbcOYHiRaD+ep0u/Zup/j0YriJASlYmqzfp4wlvDxY6m8WdWU9xqGuTgwOv157E
	JvcDWwo+ll3kG37kovqYhFcOEl0VyrsZ6yelcf5HVgG+QZ19crnhQ3aQNd3s58iAwHsPaWEinppT6
	rMLkR3mQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP3K-0000000HG6C-0rHA;
	Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 0/6] Remove page_mapping()
Date: Tue, 23 Apr 2024 23:55:31 +0100
Message-ID: <20240423225552.4113447-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are only a few users left.  Convert them all to either call
folio_mapping() or just use folio->mapping directly.

Matthew Wilcox (Oracle) (6):
  fscrypt: Convert bh_get_inode_and_lblk_num to use a folio
  f2fs: Convert f2fs_clear_page_cache_dirty_tag to use a folio
  memory-failure: Remove calls to page_mapping()
  migrate: Expand the use of folio in __migrate_device_pages()
  userfault; Expand folio use in mfill_atomic_install_pte()
  mm: Remove page_mapping()

 fs/crypto/inline_crypt.c |  6 +++---
 fs/f2fs/data.c           |  5 +++--
 include/linux/pagemap.h  |  1 -
 mm/folio-compat.c        |  6 ------
 mm/memory-failure.c      |  6 ++++--
 mm/migrate_device.c      | 13 +++++--------
 mm/userfaultfd.c         |  5 ++---
 7 files changed, 17 insertions(+), 25 deletions(-)

-- 
2.43.0


