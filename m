Return-Path: <linux-fsdevel+bounces-41728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF39A3626F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E31893267
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B578267723;
	Fri, 14 Feb 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FsNaH9NT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7226738A;
	Fri, 14 Feb 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548639; cv=none; b=pShSc42SugjA+OVk3xJ+f1U5XtiaQHZ7zM+WJL/XoYVHlztwrhg1NCps4Cq26+Jw4kNpcrlIj9Bxd0lYYuKI/EY4YpQC55xFASLvzrgwdCvS0DFQYL5IHSLVrHXUlDhj+QGzEtWyXOrF6+EYwClBhLyFG6mmyJni3ymv0BqUfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548639; c=relaxed/simple;
	bh=jKe5to7vakjmiEbUlPI0tWTh7WmIT2vDKVWRZYqNtWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPC8tf5xvjU9bavN5dnBe5a6t/46d5IADqx+kPgwqW98GpYEf/ut3t1NG4PrKLKssIwbPgM5WfIlqzJ82n9L5gLs/ljgSxRHeC9sK9hwuiDCmKDkwLM/HU881Cl1+Vc8ZNG9IoClHlwk5HckPkUWR4uKl1QCmHmPw5lWAg0kJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FsNaH9NT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CBgvTZFwisU0hNpixuf6QfQQPek/Bppv2tG5FWlyK9E=; b=FsNaH9NTmq3kV6dZkArkqdonPg
	ibQ8mFiiFx8kZNF8spTBDkeUuHwmaXwEYdKJrptF2w6BkjGL9MXBxQBnEBq+Hg29P5zctP7a75/Yf
	Vl/J0CNp4cAUYls0u82d1V1KGW9vMahQcP6uKWr6jUHTvwwj8v4Y0ANKD5UQYYydKTQMLUI9rWINK
	6AfmX1a+6T8vCVXooPv2X4TcXYayVIEOgFI7wg+znNqjQxrkb25cDqfH8jFSlelwbkN5M2hPD+Ou3
	puwCxSgaqphYl3foq1KXeBRO67+VXYS+XS8VhYeW22ukcXDJ/CLtFRnz97mDKJYLA68gB5UOixVc9
	oVE0E82A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy40-0000000Bhyu-2kaH;
	Fri, 14 Feb 2025 15:57:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 4/7] ceph: Convert ceph_find_incompatible() to take a folio
Date: Fri, 14 Feb 2025 15:57:06 +0000
Message-ID: <20250214155710.2790505-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214155710.2790505-1-willy@infradead.org>
References: <20250214155710.2790505-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers already have the folio.  Pass it in and use it throughout.
Removes some hidden calls to compound_head() and a reference to
page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b659100f290a..7a2aa81b20eb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1424,56 +1424,56 @@ static int context_is_writeable_or_written(struct inode *inode,
 
 /**
  * ceph_find_incompatible - find an incompatible context and return it
- * @page: page being dirtied
+ * @folio: folio being dirtied
  *
- * We are only allowed to write into/dirty a page if the page is
+ * We are only allowed to write into/dirty a folio if the folio is
  * clean, or already dirty within the same snap context. Returns a
  * conflicting context if there is one, NULL if there isn't, or a
  * negative error code on other errors.
  *
- * Must be called with page lock held.
+ * Must be called with folio lock held.
  */
 static struct ceph_snap_context *
-ceph_find_incompatible(struct page *page)
+ceph_find_incompatible(struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (ceph_inode_is_shutdown(inode)) {
-		doutc(cl, " %llx.%llx page %p is shutdown\n",
-		      ceph_vinop(inode), page);
+		doutc(cl, " %llx.%llx folio %p is shutdown\n",
+		      ceph_vinop(inode), folio);
 		return ERR_PTR(-ESTALE);
 	}
 
 	for (;;) {
 		struct ceph_snap_context *snapc, *oldest;
 
-		wait_on_page_writeback(page);
+		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(page);
+		snapc = page_snap_context(&folio->page);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 
 		/*
-		 * this page is already dirty in another (older) snap
+		 * this folio is already dirty in another (older) snap
 		 * context!  is it writeable now?
 		 */
 		oldest = get_oldest_context(inode, NULL, NULL);
 		if (snapc->seq > oldest->seq) {
 			/* not writeable -- return it for the caller to deal with */
 			ceph_put_snap_context(oldest);
-			doutc(cl, " %llx.%llx page %p snapc %p not current or oldest\n",
-			      ceph_vinop(inode), page, snapc);
+			doutc(cl, " %llx.%llx folio %p snapc %p not current or oldest\n",
+			      ceph_vinop(inode), folio, snapc);
 			return ceph_get_snap_context(snapc);
 		}
 		ceph_put_snap_context(oldest);
 
-		/* yay, writeable, do it now (without dropping page lock) */
-		doutc(cl, " %llx.%llx page %p snapc %p not current, but oldest\n",
-		      ceph_vinop(inode), page, snapc);
-		if (clear_page_dirty_for_io(page)) {
-			int r = writepage_nounlock(page, NULL);
+		/* yay, writeable, do it now (without dropping folio lock) */
+		doutc(cl, " %llx.%llx folio %p snapc %p not current, but oldest\n",
+		      ceph_vinop(inode), folio, snapc);
+		if (folio_clear_dirty_for_io(folio)) {
+			int r = writepage_nounlock(&folio->page, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
@@ -1488,7 +1488,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 
-	snapc = ceph_find_incompatible(folio_page(*foliop, 0));
+	snapc = ceph_find_incompatible(*foliop);
 	if (snapc) {
 		int r;
 
@@ -1748,7 +1748,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			break;
 		}
 
-		snapc = ceph_find_incompatible(&folio->page);
+		snapc = ceph_find_incompatible(folio);
 		if (!snapc) {
 			/* success.  we'll keep the folio locked. */
 			folio_mark_dirty(folio);
-- 
2.47.2


