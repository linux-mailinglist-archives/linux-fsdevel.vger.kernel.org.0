Return-Path: <linux-fsdevel+bounces-41724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A237A36268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C777A3B50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC72673B7;
	Fri, 14 Feb 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNKeIKsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A5267382;
	Fri, 14 Feb 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548637; cv=none; b=Uw7BD/VqBKM7GeaSgr3hGnHqeaWFl3BSuRxLL8l1Mn2Ji0gQBAsG5XKJMkNRs9k20q21ZQjdJW7SwL/VL9+gJvSne+iQaIgj6m/EmVfcdulcVSy+v+8mvXms9bA8HNI26wSC1F4AV0jDNQoHXg87q5KdKMi3ViC63kzzZjehboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548637; c=relaxed/simple;
	bh=LISIa+7vdZrbrVN6yCamiSHHxhwA++Ae06QYVa6388w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgr1/oPl10tqO1Sn38Z19W6D+uX3d2/R1h607ro3GqLY7MpyfY2V70xeb9GD4qw6cb6M5SZLNxP3eL3d2aLVVdS/2FYv2B7Ekg17X2da9MAX2ajhc+WoTyZAPKwouL4BRzSPJ0MjI89MQbO/H7PcIyU/uUoBEmm/G7R9hilzAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pNKeIKsW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eYmNe4gx2jeIslDHzSyJDjaUdHZgSheFXq85TZUJtLM=; b=pNKeIKsW5dlaN1IJlaoq9/Lu39
	3bldHS1Y7QMZwtJgvKCDlCg28sDgv7W9jrW1/wJIstSzG3b8eN9rSmqFMTSWmmUtGZAMJKXRMB10x
	k80kTy1uXKws/CjkVcNrbeT4hCIr9/gCSwqzi2FIlkbNKzi1rEuxOM3NZ+sCF0V+RdOjqH93fdeZc
	nKLzuKUAyV+mtJpmqRkIUVEr+4mz7QNlKkjXPkiyCPJiuXxMUddkDL84ul7flpl7Sqpdd+F1290KQ
	DAliGCl0lCAJL5yh8VrH6tMj8D9IXqPjq6VH1RSrrCs/YJOJVIqLEYlRV5Ou9Ujbf+l9Ps2okTvjE
	/nZwo/Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy40-0000000BhyZ-2NzI;
	Fri, 14 Feb 2025 15:57:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 3/7] ceph: Use a folio in ceph_page_mkwrite()
Date: Fri, 14 Feb 2025 15:57:05 +0000
Message-ID: <20250214155710.2790505-4-willy@infradead.org>
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

Convert the passed page to a folio and use it
throughout ceph_page_mkwrite().  Removes the last call to
page_mkwrite_check_truncate(), the last call to offset_in_thp() and one
of the last calls to thp_size().  Saves a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9b972251881a..b659100f290a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1695,8 +1695,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
@@ -1713,10 +1713,10 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
@@ -1733,30 +1733,30 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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


