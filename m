Return-Path: <linux-fsdevel+bounces-41881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D23A38B8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16D23A5A7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55808237165;
	Mon, 17 Feb 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/XIt56h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF3137C35;
	Mon, 17 Feb 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818284; cv=none; b=afWl3nwsL4S5VVHwhbxzQ6k2z5eqRxxx0zi3POGz0uBzl+JzlE5I1XMh9FgOAbNlyJFdiiHicJMXHrADv5piy4MrUBoB5HoUdtoQoTBjxkGQNKtU5Nhkw1bqq+5V6Krw3bIS2/b4BWPcTIGywAGrRxr5V+lPS8KdyBkAD6YHtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818284; c=relaxed/simple;
	bh=A8SS/SNsC7BDdLD2EHBLBV0wGEfsd8UVmSwHL9c9vFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpBkU9Khs7A6U2gg48ak4QYjO4SEVR4lcw8S5bpBjirqFZ9a0hKod9V4wyRN8VZYl5VO3HdMGMMfeJwvGyKJ1h18+6/rUv/D+EAzYI6rYwz4m+vO4iYZ1RqIwXDjbofqBgDQ3Kx7LxmyWjpDN8WGZD6n/QmHIhkqjtZBf3o37j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m/XIt56h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rn2njdNn6ph2Vk7Kpzg8/A1Zubraa+/VWHpj3Yk0nlM=; b=m/XIt56hsr7vda2W7ULzWuturJ
	P0xr1tEipFC6fxLvsz0zw3ymMrbXk1zoQfjy4zUHQZj15RBjNhx2sZijxbj2wh4+tJH9jlEGop2sR
	VhQUK6/JqvQx/gIa2952PQFxyk9S/Ab2TVUksmeVIcqEZ8sMQNryoU8YclUGB9+SRnvCAitHlDV3U
	zyjVLWYe13MXB33oeANJdlWZy3KnB6DdF8SfkjpphnsqvkohHP6KSIbzTVSmJS+0MkEMfSGnL+s4m
	/JNwUdVIQwTXS5e3WiIt3yQ0E9bxv0I8gMrGaiaBujKQiKdGErtfp/aVJ7TPU1OzLVt/kfo1GWcEV
	pK3vtkJg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nvr-32Lc;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 6/9] ceph: Convert ceph_check_page_before_write() to use a folio
Date: Mon, 17 Feb 2025 18:51:14 +0000
Message-ID: <20250217185119.430193-7-willy@infradead.org>
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

Remove the conversion back to a struct page and just use the folio
passed in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 871adfa82c1f..90d154bc4808 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1142,18 +1142,17 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_snap_context *pgsnapc;
-	struct page *page = &folio->page;
 
-	/* only dirty pages, or our accounting breaks */
-	if (unlikely(!PageDirty(page)) || unlikely(page->mapping != mapping)) {
-		doutc(cl, "!dirty or !mapping %p\n", page);
+	/* only dirty folios, or our accounting breaks */
+	if (unlikely(!folio_test_dirty(folio) || folio->mapping != mapping)) {
+		doutc(cl, "!dirty or !mapping %p\n", folio);
 		return -ENODATA;
 	}
 
 	/* only if matching snap context */
-	pgsnapc = page_snap_context(page);
+	pgsnapc = page_snap_context(&folio->page);
 	if (pgsnapc != ceph_wbc->snapc) {
-		doutc(cl, "page snapc %p %lld != oldest %p %lld\n",
+		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
 		      ceph_wbc->snapc, ceph_wbc->snapc->seq);
 
@@ -1164,7 +1163,7 @@ int ceph_check_page_before_write(struct address_space *mapping,
 		return -ENODATA;
 	}
 
-	if (page_offset(page) >= ceph_wbc->i_size) {
+	if (folio_pos(folio) >= ceph_wbc->i_size) {
 		doutc(cl, "folio at %lu beyond eof %llu\n",
 		      folio->index, ceph_wbc->i_size);
 
@@ -1177,8 +1176,8 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	}
 
 	if (ceph_wbc->strip_unit_end &&
-	    (page->index > ceph_wbc->strip_unit_end)) {
-		doutc(cl, "end of strip unit %p\n", page);
+	    (folio->index > ceph_wbc->strip_unit_end)) {
+		doutc(cl, "end of strip unit %p\n", folio);
 		return -E2BIG;
 	}
 
-- 
2.47.2


