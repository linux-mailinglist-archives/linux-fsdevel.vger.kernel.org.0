Return-Path: <linux-fsdevel+bounces-9490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0381C841B94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3480F1C24F40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D08381D9;
	Tue, 30 Jan 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d2e4ZlsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CF381B0;
	Tue, 30 Jan 2024 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594060; cv=none; b=REHnbFgBOH+crydjMFK5GuDz8EBaZTzv/zLLBblcpeQj+XblySzUbOAC+CkDBfW7vmTXP+q/8epo+BM2ImwtmwE7pg6qhxDoW4CV4yO8QZgvCkRYMBq7fhdCOCZWQK8WSkHm3ZLwhlLfChbyGrUkTiA1aoVPIfCGSqAnJrN/iUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594060; c=relaxed/simple;
	bh=oxmf8oEiU85Akg58cWkdalKcMLx7W+ekN0HZlMD53wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLLlJTM5XQslWZhcEx8ABL+HzmY2gCRJG7x18xT65HJ39EYsj1M24lIjmfwebiZqnqID0Zd3GM4hafO2YtpWrzNPrRNLCkkzOMoRJUS0QgQ4E2KXyyDqYy7uFHkNGzsrp2ryKd6TQC7cZgdY/iu3tatmE6vMzGe+5onRP33iLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d2e4ZlsV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MDuK9twlOjIDfGFwkBlH48dI/3VqFjrv/DTly2AcIPg=; b=d2e4ZlsVGbe9cy16c5uErZPLtI
	v7sA4zAUutzQEIhn4oxHa8FATZHTL4iB5uAiCDRWMT3OfQ8zv9RHPtpPDjit8ZxdB6Z5W1CsPbxYA
	kzPjzaKtK3CP3JgzqA9kNP7J6EuRuhQhhOaVEn//5ASFvRsp2TnlpkeNMkc58o7xR3nAOYBkrXgDx
	w+MtItMka6BoAfCRljO63DW+ikzRfAmmJsSixPQvVa8+4kL2yjKW5KlE29OKCQvNhXh9NPxV2gtDa
	gdLqyiBFjcWKxuy0jjc/q7KdHUNfdGeJuecDl7pUMN7KnoeNbr1WM42aWpQT/idUU2POdrac9W4So
	1TU7ji2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUh4a-00000008zkf-0Foq;
	Tue, 30 Jan 2024 05:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 0/3] Start moving write_begin/write_end out of aops
Date: Tue, 30 Jan 2024 05:54:10 +0000
Message-ID: <20240130055414.2143959-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christoph wants to remove write_begin/write_end from aops and pass them
to filemap as callback functions.  Hre's one possible route to do this.
I combined it with the folio conversion (because why touch the same code
twice?) and tweaked some of the other things (support for ridiculously
large folios with size_t lengths, remove the need to initialise fsdata
by passing only a pointer to the fsdata pointer).  And then I converted
ext4, which is probably the worst filesystem to convert because it needs
three different bwops.  Most fs will only need one.

Not written yet: convert all the other fs, remove wrappers.

Matthew Wilcox (Oracle) (3):
  fs: Introduce buffered_write_operations
  fs: Supply optional buffered_write_operations in buffer.c
  ext4: Convert to buffered_write_operations

 fs/buffer.c                 | 62 +++++++++++++++++++++++--------
 fs/ext4/ext4.h              |  8 +++-
 fs/ext4/file.c              | 10 ++++-
 fs/ext4/inline.c            | 15 +++-----
 fs/ext4/inode.c             | 73 +++++++++++++++++++------------------
 fs/jfs/file.c               |  3 +-
 fs/ramfs/file-mmu.c         |  3 +-
 fs/ufs/file.c               |  2 +-
 include/linux/buffer_head.h | 22 +++++++++--
 include/linux/fs.h          |  3 --
 include/linux/pagemap.h     | 22 +++++++++++
 mm/filemap.c                | 70 +++++++++++++++++++++++------------
 12 files changed, 193 insertions(+), 100 deletions(-)

-- 
2.43.0


