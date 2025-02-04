Return-Path: <linux-fsdevel+bounces-40852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C1A27F58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5931887FA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E821CA1D;
	Tue,  4 Feb 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQXrbBpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B221C165;
	Tue,  4 Feb 2025 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710736; cv=none; b=fXsltvp0FV7h2KkbdjxL7f6yVP3Txt2JftRWOMyN3YEVM6cnD+HiAow89d5L6QlWMSQ4QWAbTKlYT7re9HZwvJ5h7uPekF5ffhIHv9PpPtaLF8tI9FTFvg0GwDO57XLMd9umFEHPSY9f+irPZW5tc3Zd1fUIU2t2aUzISj2UXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710736; c=relaxed/simple;
	bh=F7xenTjqnGD5aXkLVQCMlQcbOfxYcqUtL1eNNXM1DRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMk6b9e7Er8nlB8OxzcaP5BG51e1KPuewkzkRywkRQuk3J6pH3IgEJ6gUWEzogzWHxzMz1Y6qBdt4RNMr91HuGm+Rs3uSlqPb2Kt/N5DX97SiPgeRI0c6cTVhDQq1D1M28COykhMSuZdl05EUcNo5KkREDq+70gxpe4g0kEuJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KQXrbBpY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gIJE1yXpif2CCfNIqrsdZ1ScxfCjjJhcAk10zquVIzE=; b=KQXrbBpYImm6WQgyMBh8uZWBFd
	8fhOrvLjp0Y/9fv2pHE6+OciYfileSX4qGXBfSqqNu9NuyuYUkiJofTC4mo/bfK0FpAbSt6pdDTKx
	e3LX6yUYJrHxU5f+VyUaDtY8raa3hM28p6lQaeocODVMM1sVq4eLRSY2ePqRtbR3cjBM79DMzRDtf
	TIy7gt97JTaLPvTuNE6PocSik5aH8Vu9kzVyVX86STWSLRWJtL2OlOsgBQTvjR4PpS210bT8QSeoA
	+Vt5POzfHSI8ksLlgyPmqy283VLaWdT45QWNdGiDEEyLEehOpBPhZEzsPXJnJ7RmgrjQYwc8UZaMj
	y4Uc0O/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nhU-1fWW;
	Tue, 04 Feb 2025 23:12:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v2 5/8] fs/buffer fs/mpage: remove large folio restriction
Date: Tue,  4 Feb 2025 15:12:06 -0800
Message-ID: <20250204231209.429356-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204231209.429356-1-mcgrof@kernel.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Now that buffer-heads has been converted over to support large folios
we can remove the built-in VM_BUG_ON_FOLIO() checks which prevents
their use.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 2 --
 fs/mpage.c  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 167fa3e33566..194eacbefc95 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2371,8 +2371,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
 		limit = inode->i_sb->s_maxbytes;
 
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 
diff --git a/fs/mpage.c b/fs/mpage.c
index c17d7a724e4b..031230531a2a 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -170,9 +170,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	unsigned relative_block;
 	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 
-	/* MAX_BUF_PER_PAGE, for example */
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	if (args->is_readahead) {
 		opf |= REQ_RAHEAD;
 		gfp |= __GFP_NORETRY | __GFP_NOWARN;
-- 
2.45.2


