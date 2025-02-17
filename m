Return-Path: <linux-fsdevel+bounces-41887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A3A38B91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775D71891ECF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D0238D38;
	Mon, 17 Feb 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T/7wN16A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA003238D34;
	Mon, 17 Feb 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818290; cv=none; b=iiVY8s3YH7Oqyqql08fUrcDDdyCW4WPuO+BfZCa0VB1xTYhAgB7e2bgJ7eVnqRZ+ZiFNi9ykdXXQoFQ8kXpJQuvh4SQUH95nkBOjCWS9dDJJR0x2VhThqsN6+yZb6FpG+E+cNIyw1QMN0qJBY02XthOVWRDL4m0mB+eCeM9k2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818290; c=relaxed/simple;
	bh=7/g7PkYocx3sog9LT6t7W28WamInYF+l4TwIKIE1b9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/DqYLrTMtVlBeywNQMDYDPX6DfRWlLckj655oRn3g3P3P/vldN9pKmDSHCF46RdlhSKfkLfoiP+1Mg4goovDsCIvI/B39xk71TBhKtAH+vUhcTFfkb1W5+6qq3Im3mBEPKN2VHPGgGWDcjnl9Je2erFlMB6QFdBmPaeZIwHM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T/7wN16A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=beB88MU14NtXWJeQHCjJX0aesT7lOp97QvT884gDYW0=; b=T/7wN16Ae2koQ3K0EIi5VD3Xps
	o9U1ySnGWJQrZvOzD4WDU4pFGVEPyG8wGoTUlPDY5N9MGIxar++00YIuHHV6oJleP0lscKHan/rzh
	CMzVQ1yt1C+9684U5JL+DMeyRiBRlUg6O+0po/ZFeeDX77KJ2kYDK52dzHy7mFsoF2oJMU03VohrE
	kzx1D3wDcEvn5LhqEFCBgx0pj9RbC7kEjpXxTXQRsg4SNMEI5qQQYEmSVCVZ/1ssRzQdSHYC0PDQC
	dwYWSpmR+K6JGfXvRfhLXwsXNNUI5Gt+bGY0Z+gTxZRss+ac8oHRhoWDdn2yDE++8e2zvRjUk76eV
	C+K/dC5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nvg-1dD3;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 3/9] ceph: Convert ceph_find_incompatible() to take a folio
Date: Mon, 17 Feb 2025 18:51:11 +0000
Message-ID: <20250217185119.430193-4-willy@infradead.org>
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

Both callers already have the folio.  Pass it in and use it throughout.
Removes some hidden calls to compound_head() and a reference to
page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 045ec57e72b8..08f8bdfc275e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1781,56 +1781,56 @@ static int context_is_writeable_or_written(struct inode *inode,
 
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
@@ -1845,7 +1845,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 
-	snapc = ceph_find_incompatible(folio_page(*foliop, 0));
+	snapc = ceph_find_incompatible(*foliop);
 	if (snapc) {
 		int r;
 
@@ -2105,7 +2105,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			break;
 		}
 
-		snapc = ceph_find_incompatible(&folio->page);
+		snapc = ceph_find_incompatible(folio);
 		if (!snapc) {
 			/* success.  we'll keep the folio locked. */
 			folio_mark_dirty(folio);
-- 
2.47.2


