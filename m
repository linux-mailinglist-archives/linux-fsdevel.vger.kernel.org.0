Return-Path: <linux-fsdevel+bounces-41399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8AA2EE62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85E718894F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831F231A2C;
	Mon, 10 Feb 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EbKBdZ2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8D22FF4E;
	Mon, 10 Feb 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194497; cv=none; b=kp0aB9PSZtDNO8hI6vgwQ1lZsQIAaAwYGXGV3OAVzJ0vGD7Hjr8UTYhTc6YubAiOCvOhYw8F2tu/SosL19pFHdpELsbJCU0pB3OpYvLd2uAqhjNVwOVo5PSbiFXHg0AXlRlTzjLCaZaJMst5Pr2IbzH/iB/QIDYPaVi55OYScKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194497; c=relaxed/simple;
	bh=x8GbB17f+XACoqPfyFB5QtZ2aYZ3oALkmXLuixabR58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ut3+5PL5T43wNI35L/VsHIO/MKk3DGAP5BLTtzRpimxzbYtOGz8WQ9t3pg99CKrjKuAKJTPZ8frXDuEj1+RkZc8tULAJZ9ALvwf5KAUDtxGzvBPRsVsq2e+9c0qrl50RXh3KlpND+EpjmTVoM5DdQdRIflu/24aZRyY1Fo+gQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EbKBdZ2f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bK8uaTq/6q3eiML8MeseZqvIp5yMjC6ra65Zo4NGdn0=; b=EbKBdZ2fIPmlD5hL2vpL0LTl7u
	JUYQbNvy90B5V6Z8Zoau4vaoNWIN+h8UlbrCTS5qnVraKaci51mEJbyl51bEDWYImXOGvV2+AnPIH
	xjex9fUTZBczwtBZblSM5uHgKmH1F5rE6FIK53p2NKwV5pKoS8avS5rrsYMNBj3+hQqDDJ3PtRrjy
	Pgt6kHleT5FsWPwDOEkmIMEA1NWeHCipGq33WBISqc1VFECI/DqwMU2bAr14yz1eeOXOEPf2hxLaa
	CzEC9Zd0OB9a+Vzk+vVnePD1fz/IIjpoByH4g9fOzil7EQsPJ5GYuO1Ibk/s1VSzxJayY/Xs5SJZQ
	aQTxBu1A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw6-0000000Fva9-17Pe;
	Mon, 10 Feb 2025 13:34:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/8] gfs2: Convert gfs2_find_jhead() to use a folio
Date: Mon, 10 Feb 2025 13:34:44 +0000
Message-ID: <20250210133448.3796209-7-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133448.3796209-1-willy@infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a call to grab_cache_page() by using a folio throughout
this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 09e4c5915243..30597b0f7cc3 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -514,7 +514,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 	struct gfs2_journal_extent *je;
 	int sz, ret = 0;
 	struct bio *bio = NULL;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	bool done = false;
 	errseq_t since;
 
@@ -527,9 +527,10 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 		u64 dblock = je->dblock;
 
 		for (; block < je->lblock + je->blocks; block++, dblock++) {
-			if (!page) {
-				page = grab_cache_page(mapping, block >> shift);
-				if (!page) {
+			if (!folio) {
+				folio = filemap_grab_folio(mapping,
+						block >> shift);
+				if (!folio) {
 					ret = -ENOMEM;
 					done = true;
 					goto out;
@@ -541,7 +542,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 				sector_t sector = dblock << sdp->sd_fsb2bb_shift;
 
 				if (bio_end_sector(bio) == sector) {
-					sz = bio_add_page(bio, page, bsize, off);
+					sz = bio_add_folio(bio, folio, bsize, off);
 					if (sz == bsize)
 						goto block_added;
 				}
@@ -562,12 +563,12 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 			bio = gfs2_log_alloc_bio(sdp, dblock, gfs2_end_log_read);
 			bio->bi_opf = REQ_OP_READ;
 add_block_to_new_bio:
-			sz = bio_add_page(bio, page, bsize, off);
+			sz = bio_add_folio(bio, folio, bsize, off);
 			BUG_ON(sz != bsize);
 block_added:
 			off += bsize;
-			if (off == PAGE_SIZE)
-				page = NULL;
+			if (off == folio_size(folio))
+				folio = NULL;
 			if (blocks_submitted <= blocks_read + max_blocks) {
 				/* Keep at least one bio in flight */
 				continue;
-- 
2.47.2


