Return-Path: <linux-fsdevel+bounces-41883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21289A38B88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E998D16CF46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D83B2376EA;
	Mon, 17 Feb 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IsjKj4lQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C4233D7B;
	Mon, 17 Feb 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818285; cv=none; b=ODfZbO084RE9x7/p0WKPZSQp/w0pBKsh4EiN6jEFHvS1swHKAc4Dqk9WZ5ahYI+HFuoVSsjO8RFIzC6WiZwCwfqZ24rlifJUy2Vgl8FQwPY7VT+86mEkeBc+zirKXheAVcvD/62mqv3ka66V6xlO61+uVfybxI6s+4hwJnyf3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818285; c=relaxed/simple;
	bh=ha667yhBEKpIWOKugO6ASVYMb6Ivy6UReJx8v3vEZq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gbi78kNiGAss+6wFhesuEDnnru/Gkx6ZVjiGbd14TGezDqNCuHft6ACuaJfaaIUSuSmP1x3cqTyudKhBmOvoNXMJHMr5t0qOBF8DZS2vUdau4kXIGfl+img+NRfQDN2E/87fROYPqN0j3zYk+uK37+FQ0jkJUZ8Eh8pyf+m9CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IsjKj4lQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ECNBFjb6MoEuLImk4Hbzs7mELbVqH/NDKI4gdMmQYb8=; b=IsjKj4lQB7GdrAmiyhnoecJMX2
	aA5SC4tAmF6LfNfx0AcFPyzCXJKOBhTEVEcfiTo0TIZxsHli1Cnj+p/cG7SUniB9J2vHvG2cwAW8s
	xMSlflDk7zFqWpXqoU5GfT6IBDOUw9p6JBWriP4M+LAmQE/HLksA3GLnRQ49YGl9I64cINfYy+qs9
	3sgXSOyy4k2z+zaKS/PaHhs0FIlrfiGWsInpr1zfvnXEoIaBJ1uRycPsSqh4rQW1ovjjmSxZLGFDG
	6LvAgCQ3TupDugaLiFpH865/a6n79lStc9kJgZwyy5tYAQH9NONcNYAdf45/uac/AwxhTJ55KuvvN
	2ZN52pqA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nwB-41yz;
	Mon, 17 Feb 2025 18:51:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 8/9] ceph: Convert ceph_move_dirty_page_in_page_array() to move_dirty_folio_in_page_array()
Date: Mon, 17 Feb 2025 18:51:16 +0000
Message-ID: <20250217185119.430193-9-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217185119.430193-1-willy@infradead.org>
References: <20250217185119.430193-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shorten the name of this internal function by dropping the 'ceph_'
prefix and pass in a folio instead of a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fd46eab12ded..3545eaa416e8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1246,11 +1246,9 @@ bool is_write_congestion_happened(struct ceph_fs_client *fsc)
 		CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb);
 }
 
-static inline
-int ceph_move_dirty_page_in_page_array(struct address_space *mapping,
-					struct writeback_control *wbc,
-					struct ceph_writeback_ctl *ceph_wbc,
-					struct page *page)
+static inline int move_dirty_folio_in_page_array(struct address_space *mapping,
+		struct writeback_control *wbc,
+		struct ceph_writeback_ctl *ceph_wbc, struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1260,7 +1258,7 @@ int ceph_move_dirty_page_in_page_array(struct address_space *mapping,
 	gfp_t gfp_flags = ceph_wbc->locked_pages ? GFP_NOWAIT : GFP_NOFS;
 
 	if (IS_ENCRYPTED(inode)) {
-		pages[index] = fscrypt_encrypt_pagecache_blocks(page,
+		pages[index] = fscrypt_encrypt_pagecache_blocks(&folio->page,
 								PAGE_SIZE,
 								0,
 								gfp_flags);
@@ -1277,7 +1275,7 @@ int ceph_move_dirty_page_in_page_array(struct address_space *mapping,
 			return PTR_ERR(pages[index]);
 		}
 	} else {
-		pages[index] = page;
+		pages[index] = &folio->page;
 	}
 
 	ceph_wbc->locked_pages++;
@@ -1369,8 +1367,8 @@ int ceph_process_folio_batch(struct address_space *mapping,
 
 		fsc->write_congested = is_write_congestion_happened(fsc);
 
-		rc = ceph_move_dirty_page_in_page_array(mapping, wbc,
-							ceph_wbc, &folio->page);
+		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
+				folio);
 		if (rc) {
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
-- 
2.47.2


