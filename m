Return-Path: <linux-fsdevel+bounces-58121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893CB2996D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AC2189F56A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D05272E6B;
	Mon, 18 Aug 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N/UFkEmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2F272E65;
	Mon, 18 Aug 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497427; cv=none; b=WCAfOyDy5S9XEJjc2dT67KwtyaDXyoyTGeOuHPZ4A3Zg+BUy4emSEOvL6unRidj4X40PYNLeOoyNmztfF4IGcobrLWPMtqgP7eBR1oj8wyRpx4qoY9qB3+7Eoqq/rSWWk0UjHXBaOfb5yxQR1C6HE1Nbq6WuEUow4k94bFmLKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497427; c=relaxed/simple;
	bh=reSFOGg5xPO8WWEOS2u4PTzfEy156YKHAmMYjiDQSYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZ9KNUrbRdMvqQIqC+zpZBjVIlIHEnqBvq0XnnsZTY/6ReS0Vt+6lsywXVCfZHqzrMX6I4UzdAdgVDYZ6ApgLxqath0/gB4IOoQuKQe7XQS5mPsUJJZoiFY8YUpsYansXcJZ+qOd5ihTdGjQuEWbj+k5qzsrUARjk+uzdI4a1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N/UFkEmL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Am3rhvkj1HDRHYITqQ4Yl4Zll62VZGAnL3MYltPMarQ=; b=N/UFkEmLQcsNQvpe6Ho+xfC6EE
	pWoPB1MlrFGGQbWL+wXmCroFBraPb7xm2tbxerHxgZmIcdiNUWpt9O+zqLGbCrX1crz4wMB9amlLW
	z4gjt9KocV/EwpEdpl+eq+b+yCdCjfphG3qgayvm2eU5NhtuPsHTrqs9EtO8xwQF+iIcP/txGmIw8
	bx3cVzLka9UbbuGGGvvM1Fxr7QWERlue81n5TsTfHYFhBAqIUD+nwLWLVGuI89Q/y2eeMCfJUW2ZL
	AcSDUjnWgbXAPuuzUOYeKmeNoZD9y1e3AUfYO8q3VX/hUJ13jQDrI8UXl3WZ2lwiHjmG/Z5kMP0Ta
	Pvkf8d1w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unt4b-00000006bmd-0KlO;
	Mon, 18 Aug 2025 06:10:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-bcachefs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] bcachefs: stop using write_cache_pages
Date: Mon, 18 Aug 2025 08:10:09 +0200
Message-ID: <20250818061017.1526853-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818061017.1526853-1-hch@lst.de>
References: <20250818061017.1526853-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Stop using the obsolete write_cache_pages and use writeback_iter
directly.  This basically just open codes write_cache_pages
without the indirect call, but there's probably ways to structure
the code even nicer as a follow on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/bcachefs/fs-io-buffered.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 1c54b9b5bd69..fdeaa25189f2 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -655,6 +655,17 @@ static int __bch2_writepage(struct folio *folio,
 	return 0;
 }
 
+static int bch2_write_cache_pages(struct address_space *mapping,
+		      struct writeback_control *wbc, void *data)
+{
+	struct folio *folio = NULL;
+	int error;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		error = __bch2_writepage(folio, wbc, data);
+	return error;
+}
+
 int bch2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct bch_fs *c = mapping->host->i_sb->s_fs_info;
@@ -663,7 +674,7 @@ int bch2_writepages(struct address_space *mapping, struct writeback_control *wbc
 	bch2_inode_opts_get(&w->opts, c, &to_bch_ei(mapping->host)->ei_inode);
 
 	blk_start_plug(&w->plug);
-	int ret = write_cache_pages(mapping, wbc, __bch2_writepage, w);
+	int ret = bch2_write_cache_pages(mapping, wbc, w);
 	if (w->io)
 		bch2_writepage_do_io(w);
 	blk_finish_plug(&w->plug);
-- 
2.47.2


