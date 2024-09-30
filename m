Return-Path: <linux-fsdevel+bounces-30366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20698A5B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469BF2842C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8819006F;
	Mon, 30 Sep 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jaayH1i4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B518E046
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703940; cv=none; b=ZIKwGkamxe7fAFlZm/cPDen1RdqGSumbZmaShUqIsOc24i6XXPZ9EOuc9yfWWftlEhad67P9TS6tai7wMy1/OHsxUp//BEHbvNJS/9e0hEavOkr5M11Dbln3NE0Xhha/9YgWkrbKfP37Eyzh7+4gQG5jND9oO8fsfw4MAwAEbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703940; c=relaxed/simple;
	bh=f/Gk8KLKsEiYexhk0587re0F37sdJg/L6HMGRpEpYb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3RsihhAFlMJ7+NZMUPOxGkODiXm07zHkqqbxATET4PrJedA9/sH1/wtyJFzNN0UAdMGN+QolwzXLS7OkkUsJxKNt6ikWgtRz6CCpqLGUH0sp1YXMeHzEQEQ75WSErP6oTsVJi+EDL77R8gA0MMaLLtkZz78ORdETR+mJ+5Xm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jaayH1i4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9b049251eso349101985a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703937; x=1728308737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcyFx8sF4r8eQa55DYdki2Qz8c+eiUu+NpKKcrfpvFc=;
        b=jaayH1i4i/ZYbj26I1QJ14anDtP5tIITIIhXdiYvMhLcUCikJH/mKcEVdzIv41HYBU
         m5w8FrctOpZslgNnnomPlBWp45xzSBON2eMm5x/HWnvtsxdhr8TAA31p1IvgTxxyclvL
         NNftFLSOvMNdtpL7MNbea7POSft/Ddo0MD+i+PfTkYK/IuNFSZCrDvGYELqY/+HHPaiu
         LEpXTXTSK8l+KhkFAKb4PyihOtJI2EnRYnMQY92X2gSJbpBrQCmG5a8WEj6aR3FVejjS
         u/AD4Or09HGPkswN+ovPSZo43Bd3BGOdwN7CJMVhtBXVEzx/bn6CsYUVqz4de9fgR9AB
         FdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703937; x=1728308737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcyFx8sF4r8eQa55DYdki2Qz8c+eiUu+NpKKcrfpvFc=;
        b=Dgp1RJYXVqadTZo98yN1K3ii0OpGXXKUSZrAJ8/LcMXnr79BXtkkpZSKDWjC+B6KnR
         wzRYwdORF6TQmHxoANNF4h92p90kd6MkJsjKH7cnwv+U44Nm33F177tIIgHpOE95jYlS
         fnFcp31OTUB5TzvVWQkRe1gN7Qm04BgdZM+mD+vY1Ymhv9nRXZOfT6qLDXWdrIl4lYm+
         i3ou7NNlS7BM67wZZUt5TSQEWQ/vT1mm6OR/eG7T5f3EenXHZOalAqLmgEFi3L3cYbIb
         Rc5MvGsaCZxZwZ7ZSp5r/KhmT/1oP/K1XeA8KtI6a0cfNx7D3n0JV7o7GPrntWkYvGre
         3m6g==
X-Gm-Message-State: AOJu0Yy1vV7tT6r+gT9TZfJxb1s8sxh0eihmmL4gvD4khnLJa2Qtsbfh
	AubJsBZWbLsFzpUDpotMAaL+HsLlbPlHQioeTwIzqdOIKSNoFQ/6tK2IH/7Asxwdjtw2w/bvRaI
	w
X-Google-Smtp-Source: AGHT+IF8N/+kgY+LXfQWYBuBp2J6rfSLBwBCB66B/OyM8xaDjnokwBwlHZ9XEP1Wp09geGXaMY0rMw==
X-Received: by 2002:a0c:f651:0:b0:6cb:3bb7:93fc with SMTP id 6a1803df08f44-6cb3bb79422mr160312476d6.2.1727703937124;
        Mon, 30 Sep 2024 06:45:37 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68fd9asm39720186d6.137.2024.09.30.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v4 01/10] fuse: convert readahead to use folios
Date: Mon, 30 Sep 2024 09:45:09 -0400
Message-ID: <ffa6fe7ca63c4b2647447ddc9e5c1a67fe0fbb2d.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we're using the __readahead_batch() helper which populates our
fuse_args_pages->pages array with pages.  Convert this to use the newer
folio based pattern which is to call readahead_folio() to get the next
folio in the read ahead batch.  I've updated the code to use things like
folio_size() and to take into account larger folio sizes, but this is
purely to make that eventual work easier to do, we currently will not
get large folios so this is more future proofing than actual support.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f33fbce86ae0..132528cde745 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -938,7 +938,6 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		struct folio *folio = page_folio(ap->pages[i]);
 
 		folio_end_read(folio, !err);
-		folio_put(folio);
 	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
@@ -985,18 +984,36 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	unsigned int i, max_pages, nr_pages = 0;
+	unsigned int max_pages, nr_pages;
+	pgoff_t first = readahead_index(rac);
+	pgoff_t last = first + readahead_count(rac) - 1;
 
 	if (fuse_is_bad(inode))
 		return;
 
+	wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));
+
 	max_pages = min_t(unsigned int, fc->max_pages,
 			fc->max_read / PAGE_SIZE);
 
-	for (;;) {
+	/*
+	 * This is only accurate the first time through, since readahead_folio()
+	 * doesn't update readahead_count() from the previous folio until the
+	 * next call.  Grab nr_pages here so we know how many pages we're going
+	 * to have to process.  This means that we will exit here with
+	 * readahead_count() == folio_nr_pages(last_folio), but we will have
+	 * consumed all of the folios, and read_pages() will call
+	 * readahead_folio() again which will clean up the rac.
+	 */
+	nr_pages = readahead_count(rac);
+
+	while (nr_pages) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
+		struct folio *folio;
+		unsigned cur_pages = min(max_pages, nr_pages);
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -1006,23 +1023,19 @@ static void fuse_readahead(struct readahead_control *rac)
 			 */
 			break;
 
-		nr_pages = readahead_count(rac) - nr_pages;
-		if (nr_pages > max_pages)
-			nr_pages = max_pages;
-		if (nr_pages == 0)
-			break;
-		ia = fuse_io_alloc(NULL, nr_pages);
+		ia = fuse_io_alloc(NULL, cur_pages);
 		if (!ia)
 			return;
 		ap = &ia->ap;
-		nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
-		for (i = 0; i < nr_pages; i++) {
-			fuse_wait_on_page_writeback(inode,
-						    readahead_index(rac) + i);
-			ap->descs[i].length = PAGE_SIZE;
+
+		while (ap->num_pages < cur_pages &&
+		       (folio = readahead_folio(rac)) != NULL) {
+			ap->pages[ap->num_pages] = &folio->page;
+			ap->descs[ap->num_pages].length = folio_size(folio);
+			ap->num_pages++;
 		}
-		ap->num_pages = nr_pages;
 		fuse_send_readpages(ia, rac->file);
+		nr_pages -= cur_pages;
 	}
 }
 
-- 
2.43.0


