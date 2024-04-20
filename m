Return-Path: <linux-fsdevel+bounces-17354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F58AB907
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107F0B22884
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EFA29425;
	Sat, 20 Apr 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HVFavhfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0A2941E
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581469; cv=none; b=O7AAOTUMpQK+n5KidcekbRtBJP1JwY1dSlbNm8yVxYEVeJQA6w+WHEU+CB5vnsjvF+Pu9hN2lY+Lh8dMYHM6TepQ09n7OXV2qtqQHrDb92teZMS00Gobs7xfHftX4Cn1V03ir231DIPimkuSAp/4puUNa1oEFUKHZuMcpbFxIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581469; c=relaxed/simple;
	bh=w/a8xk8cry5wKM19zZntvWj1Gp/2jqHAfGvf1Bpt1Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI8AjIZBQNWv5lh9xf37JWSQhDvLyJV4gIBcizGHktV8CBH9hloXKpdPAJdi8tOU5XeJ+TUzHyERloeeCTw4NzBs1CEyB05cm7v3evCOreHbgv0gxXtPV+ClE99VVksD45cD/VlhVDjStIpgkAWzHavzJyIdJ/D79Or9GL42r7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HVFavhfb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/oTsqWZYEd80eXNdCVOXPUSFuXiId5+9LC3D93HN0Xw=; b=HVFavhfbsOhcbBCC1DsA01mBz+
	diQpTokTxyNcTF45mBtvTt2VVtc0l1doPvaj8qmXYq4MBYGZ/rojeMzZieYkIm+bunMaDQh8g3HyF
	7mChMy1SniJjWf3U15+fFvBjDuWifefMBfBzfXQysr23O9eWH10+Q5hft18b5QUlf6I8mKnaIG4f4
	Svi/JoEQGxIMbzwmjBfTdQmnCm1G+SKjrGcajbxdfmaJMmt2Bbtm1TsJAzIP3LwRmvp35zOG4wPKi
	skebIXgq1T2HnaKbuICrkjXGSv0iXqTxQwJOzlDyoArNxBFA/h3FuHXRtbA8FPmqz9+3Ma7RwcTI6
	Qvk7wNYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0od-000000095ga-44LH;
	Sat, 20 Apr 2024 02:51:00 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 25/30] vboxsf: Convert vboxsf_read_folio() to use a folio
Date: Sat, 20 Apr 2024 03:50:20 +0100
Message-ID: <20240420025029.2166544-26-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove conversion to a page and use folio APIs throughout.  This includes
a removal of setting the error flag as nobody checks the error flag on
vboxsf folios.  This does not include large folio support as we would
have to map each page individually.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/vboxsf/file.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 118dedef8ebe..e149158b105d 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -228,26 +228,19 @@ const struct inode_operations vboxsf_reg_iops = {
 
 static int vboxsf_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	struct vboxsf_handle *sf_handle = file->private_data;
-	loff_t off = page_offset(page);
+	loff_t off = folio_pos(folio);
 	u32 nread = PAGE_SIZE;
 	u8 *buf;
 	int err;
 
-	buf = kmap(page);
+	buf = kmap_local_folio(folio, 0);
 
 	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
-	if (err == 0) {
-		memset(&buf[nread], 0, PAGE_SIZE - nread);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-	} else {
-		SetPageError(page);
-	}
+	buf = folio_zero_tail(folio, nread, buf);
 
-	kunmap(page);
-	unlock_page(page);
+	kunmap_local(buf);
+	folio_end_read(folio, err == 0);
 	return err;
 }
 
@@ -295,7 +288,6 @@ static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
 	kref_put(&sf_handle->refcount, vboxsf_handle_release);
 
 	if (err == 0) {
-		ClearPageError(page);
 		/* mtime changed */
 		sf_i->force_restat = 1;
 	} else {
-- 
2.43.0


