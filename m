Return-Path: <linux-fsdevel+bounces-17193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8E8A8AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2139A1F2520A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF4175548;
	Wed, 17 Apr 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j5DtCS6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737C173340
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376625; cv=none; b=sYpLfXMRz+qJlUR08be6/g80e4ZeBP17OgxEhw4fFsl7Msy4hi0AbdzqabgfcmSnTcS80PFbo0MZMALnvgaXhCpuCldEXtJ9Ro/G8e3CnhOFe+BQGV3DAXQ77LVNVkaIsTxGgk9FeiWlOD3zh71uZ+ox16OHq3h0dWIJYyVwZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376625; c=relaxed/simple;
	bh=fpESyOj4y1fTuiIoUg4XUYeOXa1cDdUDPxGzlyc66lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkciP49gmlThnws9052u+RRS5vosPuPboAkokHWdhU7UR6pK60ef4v5HffMPth7XclaKCm459SG2SGq8KiCOcHmxYq/MbdP+KyuBEBkzGrNUGqE3nSzXMtf7W4yEYn4h+nt/8YDhqr/HPiJJi/MLrrpq6j7N5KuqG3cCjchxysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j5DtCS6X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LAnZW6GCFcQwsNj6nTs+m0g546UgN80/wr24RLPyHvw=; b=j5DtCS6Xx16WXXXgSfaUpeRV8y
	6gpKKTuf++yKQ7q1czBb1K3FRLW0wtQtgvxluWCQgzRbjIs/iwfM4xh2F4SlfVL3HfRi6T559Jk5U
	/ysmYPD3mwW0BOALVDbiuYuSbP5SVjRq0YSl11c1FMal+oNDFsYDC3WgRwBre7jR5Z61XzuTCMVcR
	2DrK+h/rl4qZbw9Apd58By9iC4hD8NOhtGPmsVjuIcMktQNav3d5H9lBBkth7QEHsZufrSN59zy+u
	W8heZf/HWQFnpY+unUwd85uE8WR/XV+FCzvFV6QMGeEG50hb/pAerkn6MS/XISnKB/mHtf558D0Xc
	V1gKYkIg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wo-00000003Qtj-2Pde;
	Wed, 17 Apr 2024 17:57:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/13] jfs: Convert inc_io to take a folio
Date: Wed, 17 Apr 2024 18:56:54 +0100
Message-ID: <20240417175659.818299-11-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All their callers now have a folio, so pass it in.  Remove mp_anchor()
as inc_io() was the last user.  No savings here, just cleaning up some
remnants.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 67d5d417fe01..f03e217ec1cb 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -78,7 +78,6 @@ struct meta_anchor {
 	atomic_t io_count;
 	struct metapage *mp[MPS_PER_PAGE];
 };
-#define mp_anchor(page) ((struct meta_anchor *)page_private(page))
 
 static inline struct metapage *folio_to_mp(struct folio *folio, int offset)
 {
@@ -132,9 +131,11 @@ static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 	}
 }
 
-static inline void inc_io(struct page *page)
+static inline void inc_io(struct folio *folio)
 {
-	atomic_inc(&mp_anchor(page)->io_count);
+	struct meta_anchor *anchor = folio->private;
+
+	atomic_inc(&anchor->io_count);
 }
 
 static inline void dec_io(struct folio *folio, void (*handler) (struct folio *))
@@ -166,7 +167,7 @@ static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 	kunmap(&folio->page);
 }
 
-#define inc_io(page) do {} while(0)
+#define inc_io(folio) do {} while(0)
 #define dec_io(folio, handler) handler(folio)
 
 #endif
@@ -395,14 +396,14 @@ static int metapage_write_folio(struct folio *folio,
 			 * Increment counter before submitting i/o to keep
 			 * count from hitting zero before we're through
 			 */
-			inc_io(&folio->page);
+			inc_io(folio);
 			if (!bio->bi_iter.bi_size)
 				goto dump_bio;
 			submit_bio(bio);
 			nr_underway++;
 			bio = NULL;
 		} else
-			inc_io(&folio->page);
+			inc_io(folio);
 		xlen = (folio_size(folio) - offset) >> inode->i_blkbits;
 		pblock = metapage_get_blocks(inode, lblock, &xlen);
 		if (!pblock) {
@@ -496,7 +497,7 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 		if (pblock) {
 			if (!folio->private)
 				insert_metapage(folio, NULL);
-			inc_io(&folio->page);
+			inc_io(folio);
 			if (bio)
 				submit_bio(bio);
 
-- 
2.43.0


