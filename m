Return-Path: <linux-fsdevel+bounces-41951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368BA3933A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B73163EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D51C84AD;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nw/1Hpsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743F1B4257
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857931; cv=none; b=MZqv4kvf9HGKUuz/1dRwEc7EwVRYFpshaeMVxF3J4/OctvbnnT0lrvj5FCGHBEkW7Kp4UdP3xuHO3EkTk8eS3fw/XasJi62wWNCaKucyf/pGBTlL/114MODQO/CmM2l8V1o0avOyW/vBBvC55f7tKfsc3g2Dpqv5bgrNhwrZiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857931; c=relaxed/simple;
	bh=IcfUIuJFe1jSg2nfBErvtw7oeGJX2WbxFfY4yCcJLOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tADbjoUgjXCGMnLvwEFHjCI1e+nR6EKFLxXE2ecvOv3QoNIp3StFQr0cF/IX75oHpTQqiLahCVc4oE1tER8vTTB9rO+OCT3xIEl+23y0i9YOOUQ6aZN0HS3W5EWSZ+JmcerFfOUORrUTog8yXOKcE0VafpxLJ7l5tkFgJeUze9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nw/1Hpsz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Mg8CE4y5cf1Snnnvi8f+NPDzZONlmEcVa2aiieEuBaA=; b=Nw/1HpszThT9iCqTEk4sQAiZK2
	yeqli20VboViPfpHNFI/hU+cQPYD84UyG3KQ67ONrPZpuORE/6o1oeZJqBmSA04XmiuDwsRNx9FOw
	Su85IOGF5kZ0P0eyJXPBepKHEIAgU6u+oYX52+uIRs+OAqU/SSxeXjmtIhPJDuJS72KsWK8f5s5jU
	4ySJavkhcvPI3DvSh5HzqHAENSgMzdQoRl8Vrae+mGKHcTFW+fMw5dGWxbM8MEyU4Bx0X0CE4HSjN
	+dgeK0c4BL6ZbAKWFdojGIE2a9kNIti4dSmw7a9fm8besxiQR9OM0QXr3xbkxGOIh2PBbD7nK86vr
	vI5NW0MA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWe-00000002Tt8-0nfT;
	Tue, 18 Feb 2025 05:52:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/27] f2fs: Hoist the page_folio() call to the start of f2fs_merge_page_bio()
Date: Tue, 18 Feb 2025 05:51:54 +0000
Message-ID: <20250218055203.591403-21-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove one call to compound_head() and a reference to page->mapping
by calling page_folio() early on.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d297e9ae6391..fe7fa08b20c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -888,6 +888,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	struct bio *bio = *fio->bio;
 	struct page *page = fio->encrypted_page ?
 			fio->encrypted_page : fio->page;
+	struct folio *folio = page_folio(fio->page);
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
@@ -901,8 +902,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_VECS);
-		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
-				page_folio(fio->page)->index, fio, GFP_NOIO);
+		f2fs_set_bio_crypt_ctx(bio, folio->mapping->host,
+				folio->index, fio, GFP_NOIO);
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
 	} else {
@@ -911,8 +912,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	}
 
 	if (fio->io_wbc)
-		wbc_account_cgroup_owner(fio->io_wbc, page_folio(fio->page),
-					 PAGE_SIZE);
+		wbc_account_cgroup_owner(fio->io_wbc, folio, folio_size(folio));
 
 	inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
 
-- 
2.47.2


