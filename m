Return-Path: <linux-fsdevel+bounces-41689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81747A3509E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 22:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F3816CCE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 21:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01326981C;
	Thu, 13 Feb 2025 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mydFkLWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6626619B;
	Thu, 13 Feb 2025 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483144; cv=none; b=c1rTecxDFCCW6y6VpLdFDWpccmaxW+adk8O12FgL/jryOA2TRqJyAbiCM9Dn4Q03Vo4n7w87tz4Y3nnVQciFxD94MLPuTGeUpVH8NHI5c0X+vEFnwdb8P12vow2Kbx1+Eco1v6bz0xAJGgN08qrzO41t+GH+qHlp6TiTTd8+cjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483144; c=relaxed/simple;
	bh=fUBtFvvJHRLK+SDuu3RCloY1xYnVPpd9PSso9zmAJvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRhuUKGlLvQCwtSdGnT+NXEr3NmekcwlTYNWCJtOSClt27TQx9oaHkPVyJdBPHoAIJU/PxTQ2QtUAl72AtWPgG1Pu5XV3z0JrolTTK/zAl1XHV1XPdYQ6u9x8QKxRDQtkP3OFl0Do0dXSQQaLCH/HKU9POofZPOIp6RmR8655eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mydFkLWX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YomykI0Ujf1LnWUgNzfl0FjziVHhPoqYtSuIaORBnbM=; b=mydFkLWXvo2vVmPJ5wSTRVJuow
	Aqju14Qe7Wnd6muoQNsV7KNpLh1t3n6CN725deHbW8y133PWm9m8W7T+FNQt91JA9JBnScgqgKw6o
	D8GmKg/4zHhJyeQEUZh/ttU31W+eIkinMBC6RdtdjuErFUbb2F8DTuZmi1cZfIkTK2l+zLSxFLSk2
	g1xG96C8d1wkqPu2iTwTg6EXVrfnPH4kCbpZ0EG/TgGc/R+O4j0hr7rChaOkFWG/uLS7DWTwB5l3s
	Cce8N42pPE2ov4ZAbdwD2TVXCGY42kiEy6+pwXgmLFT1h+nZZVi+Fw82bQ2occxDRft/jyn+oy9Ca
	j6vC8o6w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tih1b-00000009PJ3-0QB2;
	Thu, 13 Feb 2025 21:45:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Tinguely <mark.tinguely@oracle.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ocfs2: Use memcpy_to_folio() in ocfs2_symlink_get_block()
Date: Thu, 13 Feb 2025 21:45:30 +0000
Message-ID: <20250213214533.2242224-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace use of kmap_atomic() with the higher-level construct
memcpy_to_folio().  This removes a use of b_page and supports
large folios as well as being easier to understand.  It also
removes the check for kmap_atomic() failing (because it can't).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/aops.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 5bbeb6fbb1ac..ccf2930cd2e6 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -46,7 +46,6 @@ static int ocfs2_symlink_get_block(struct inode *inode, sector_t iblock,
 	struct buffer_head *bh = NULL;
 	struct buffer_head *buffer_cache_bh = NULL;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
-	void *kaddr;
 
 	trace_ocfs2_symlink_get_block(
 			(unsigned long long)OCFS2_I(inode)->ip_blkno,
@@ -91,17 +90,11 @@ static int ocfs2_symlink_get_block(struct inode *inode, sector_t iblock,
 		 * could've happened. Since we've got a reference on
 		 * the bh, even if it commits while we're doing the
 		 * copy, the data is still good. */
-		if (buffer_jbd(buffer_cache_bh)
-		    && ocfs2_inode_is_new(inode)) {
-			kaddr = kmap_atomic(bh_result->b_page);
-			if (!kaddr) {
-				mlog(ML_ERROR, "couldn't kmap!\n");
-				goto bail;
-			}
-			memcpy(kaddr + (bh_result->b_size * iblock),
-			       buffer_cache_bh->b_data,
-			       bh_result->b_size);
-			kunmap_atomic(kaddr);
+		if (buffer_jbd(buffer_cache_bh) && ocfs2_inode_is_new(inode)) {
+			memcpy_to_folio(bh_result->b_folio,
+					bh_result->b_size * iblock,
+					buffer_cache_bh->b_data,
+					bh_result->b_size);
 			set_buffer_uptodate(bh_result);
 		}
 		brelse(buffer_cache_bh);
-- 
2.47.2


