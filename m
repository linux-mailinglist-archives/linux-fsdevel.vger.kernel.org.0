Return-Path: <linux-fsdevel+bounces-41889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F9A38B92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA491890DC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6923906B;
	Mon, 17 Feb 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLxpS4rI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADC239068;
	Mon, 17 Feb 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818296; cv=none; b=T8kbS1EqoacYlFUH7SpM1me/jGEH05tjXp/A/nQvvm6xI7uj17id25bg4L1cZxaa9ruA7MYdubqhgfdJreQKeSWHvo89/4WHL9tXJTboTtuR0JgZlIa2clNvVV1/1alFJW7D6pYvQ0fJqADk2t7JPiCsQOqQILX4Kk7SHDRg9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818296; c=relaxed/simple;
	bh=B/3q1PuA3g2mfK/rumE0qLYuwt/N5QhCu3ARKSg7OrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzYYlZryC3EHILo29bs3Sdp4x1FL/xx4z7+sOHzFFCsMqxN7bb4tbH0RVgLntoHKe+KbSBGceJLh0vGSN44zn+DIS8BaICE3FkWhuP+AY3Ont6sY8uBi2Pm1BslAfCgA56ph+MejELRPGpcFupz68NovgFa75cnRMgK7NokFA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mLxpS4rI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jYKZ4Jkgvk1KBHEHPR95FonCX1ihPxFnk2t5aEejb5Q=; b=mLxpS4rIBevnl8DM9AEmX1pBoF
	eLnaYeXiUOAx8InEbxlFt1SGovx4tPlFRpe9snhq1elNvn+Ctc5QN+97oGHnl8+xBBJJ1NfEO1RUN
	oOXDLXh9dduQ5UnXbrS/4LVEH5pD1uXhS1Dz7uLMLj9Vg0tQT2Nb+f9zL/RIzEyE2Bv34n5hcqG1S
	3C4n8+K1yVPTrtrDLTNj8LyihZd+4cGhl7FW16ljY4x+Md41Qz6c6zNWNc6vcmP6eoiL5RIUcspNX
	DpWLNWbuk/CF6PO8O7sDcXdSL4NfBySaY+GBThBrI21x8pJ1zamtiMbqb++OFtLzSUQr+aXUdp6Xb
	/UykfwQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6DB-00000001nve-1Fo0;
	Mon, 17 Feb 2025 18:51:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 2/9] ceph: Use a folio in ceph_page_mkwrite()
Date: Mon, 17 Feb 2025 18:51:10 +0000
Message-ID: <20250217185119.430193-3-willy@infradead.org>
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

Convert the passed page to a folio and use it
throughout ceph_page_mkwrite().  Removes the last call to
page_mkwrite_check_truncate(), the last call to offset_in_thp() and one
of the last calls to thp_size().  Saves a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/addr.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 200dca1ff2d6..045ec57e72b8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2052,8 +2052,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	struct ceph_cap_flush *prealloc_cf;
-	struct page *page = vmf->page;
-	loff_t off = page_offset(page);
+	struct folio *folio = page_folio(vmf->page);
+	loff_t off = folio_pos(folio);
 	loff_t size = i_size_read(inode);
 	size_t len;
 	int want, got, err;
@@ -2070,10 +2070,10 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	ceph_block_sigs(&oldset);
 
-	if (off + thp_size(page) <= size)
-		len = thp_size(page);
+	if (off + folio_size(folio) <= size)
+		len = folio_size(folio);
 	else
-		len = offset_in_thp(page, size);
+		len = offset_in_folio(folio, size);
 
 	doutc(cl, "%llx.%llx %llu~%zd getting caps i_size %llu\n",
 	      ceph_vinop(inode), off, len, size);
@@ -2090,30 +2090,30 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	doutc(cl, "%llx.%llx %llu~%zd got cap refs on %s\n", ceph_vinop(inode),
 	      off, len, ceph_cap_string(got));
 
-	/* Update time before taking page lock */
+	/* Update time before taking folio lock */
 	file_update_time(vma->vm_file);
 	inode_inc_iversion_raw(inode);
 
 	do {
 		struct ceph_snap_context *snapc;
 
-		lock_page(page);
+		folio_lock(folio);
 
-		if (page_mkwrite_check_truncate(page, inode) < 0) {
-			unlock_page(page);
+		if (folio_mkwrite_check_truncate(folio, inode) < 0) {
+			folio_unlock(folio);
 			ret = VM_FAULT_NOPAGE;
 			break;
 		}
 
-		snapc = ceph_find_incompatible(page);
+		snapc = ceph_find_incompatible(&folio->page);
 		if (!snapc) {
-			/* success.  we'll keep the page locked. */
-			set_page_dirty(page);
+			/* success.  we'll keep the folio locked. */
+			folio_mark_dirty(folio);
 			ret = VM_FAULT_LOCKED;
 			break;
 		}
 
-		unlock_page(page);
+		folio_unlock(folio);
 
 		if (IS_ERR(snapc)) {
 			ret = VM_FAULT_SIGBUS;
-- 
2.47.2


