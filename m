Return-Path: <linux-fsdevel+bounces-36118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D529DBF42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 06:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEED164E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 05:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14215852E;
	Fri, 29 Nov 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RnPPorrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805D1547FF;
	Fri, 29 Nov 2024 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859470; cv=none; b=Z/drqd1ar8JIRZAyh07bYgq57AY3m71Bokx0ZSbffgW370cXPeYmPA9XH7oW/q3KNwHy/90HL+nfVboCqE9k5KI01RJGFzANj6QKfUqE1sBj4syKRgfi2OuLXofDPYRerMYYED5IP/DuEfaDTyY7T8BAhrgnuYhlHi46ghlnCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859470; c=relaxed/simple;
	bh=D92FE35Fk/CFs1/lSYl2/RKgdMp2Jonrjc12LbHhgTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozsqHRU8yP/+XqnSk+0howFhAKm9KR8OQFOJwu3yYSmDBtokTI5iNG4IXeXUrz7c1wlUrHCx6S7BuKCMZfGIFQ0uzch0j77zHv8vYhBJGcMMcNnRySMmLWiTiG9w1JOBK2hTtXgENYZeoUWmRgsKYHpcjStBCAuXCZc4rdMCIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RnPPorrB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=L6RYcpip9PIPAEEeJcaJdFO0izrVL0D7iO1BcmZeoNI=; b=RnPPorrBOIH4lq0yIUnXyeciZp
	t7xQMkVKxdSbHVTsS5JAeIOOD7BA2EJKY+wreRpfUb33xAGiZ/4YfW1aDmc+Utfl+IdRtkq7QT7O6
	IpiATPj43WBJI9v1WImwT1ShvTyQuf0ifns3LkF5DcYVDlmji4k/S4trdWo9uOYbkMDzOr+O0eUCF
	E0zR9NDhLPZw/szgU5i18ag6K2hfesH97NdoPTfp+A1dLUjwXNI8gadBbOYK6Tz8nyCyK1G0pwbla
	g/7mDmcLTBNL1xT5JU4/qCd7/HBh3Y3nuO4cdZK5PRbZRxBRB5kssxfhgZnOgzNjRNTnr4gPU6viH
	lTTmw3KA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtu9-00000003bSA-15BV;
	Fri, 29 Nov 2024 05:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 2/5] ceph: Use a folio in ceph_page_mkwrite()
Date: Fri, 29 Nov 2024 05:50:53 +0000
Message-ID: <20241129055058.858940-3-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129055058.858940-1-willy@infradead.org>
References: <20241129055058.858940-1-willy@infradead.org>
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
---
 fs/ceph/addr.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 284a6244fcdf..a5c59fec8a76 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1711,8 +1711,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
@@ -1729,10 +1729,10 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
@@ -1749,30 +1749,30 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
2.45.2


