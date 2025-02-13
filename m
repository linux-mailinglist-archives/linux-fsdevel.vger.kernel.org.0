Return-Path: <linux-fsdevel+bounces-41682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03248A34DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D4D7A25E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F124169B;
	Thu, 13 Feb 2025 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gAgLO/EM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EF28A2D5;
	Thu, 13 Feb 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471860; cv=none; b=qP4gU8gxCLvfUO8KEHRTBQDIdFi9oqQADtjoOm1ID9B+KpB4CFf+nTbB7wVIx6dE2vbmOJE31YnfQTRiBmf8i80zyKTbeUNeDUh8UWKvkrMUcaGKMdVSx0XrT1bTsVen2Slf2eZ51vFQGn/VXw+tQ68P0374/1VS0geEhRjqwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471860; c=relaxed/simple;
	bh=DqXAEPJ8ErZM7cycOGoIq9iksF2oj/fJ/1pz322nh4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMHV/TNfUQUhMdHVTX5XoMBpLBRGnDIPxgUXFH704Q7oW47F0p864lZFMDcMsM8JUPJF4hhbwEYtgDlV24AW9lwXcFBihX2Y5bgvDNE08J0kOmBgDEQeBl5plfbE3wI0h3RdWJJSK4TkMNBUy4MVIFeaf3otYd6GZPXmmzehn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gAgLO/EM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=bnvyc/NuV7z35ssyB2tkxyuod9W+bL9XL0cWnxJfv54=; b=gAgLO/EMNQwm3DJZlEMM0g0Saf
	zrEL4uOZLzSSxjZknHN7kch/adUm2KUn1zGlqtyxbJvqUgesnL7deYaO2NfKBROnAujUBhCeywCTt
	bGPgtmZGEPyOhpCcrxbKDJ609IxJnu/9dnRFv64qkcffNVEDZel8aOX3pL0n5c99proWpJq21kP1u
	6i+mbyqj9jf8jFia7TU7R7IKwXWRCn3D+7pGNtyPr0vXDrzfJDwuohFNSBEkSK086J3Tuxpbshp9E
	r8pSHk57Gx3DGLTrGaLUqXA7DiRK0BZPSdeTdCmyJ5KKqs1huJEsW4aWe0utHSfwgxENKx5BSdyHD
	2pKK7B9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tie5d-00000008z7e-3Ym0;
	Thu, 13 Feb 2025 18:37:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Tinguely <mark.tinguely@oracle.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] ocfs2: Use b_folio in ocfs2_symlink_get_block()
Date: Thu, 13 Feb 2025 18:37:27 +0000
Message-ID: <20250213183730.2141556-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are preparing to remove bh->b_page.  While modifying this function,
switch from kmap_atomic to kmap_local, remove the test for kmap_local
failing (it cannot), and reflow the conditional to match kernel coding
style.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/aops.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 5bbeb6fbb1ac..4790e2ba1671 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -91,17 +91,12 @@ static int ocfs2_symlink_get_block(struct inode *inode, sector_t iblock,
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
+			kaddr = kmap_local_folio(bh_result->b_folio,
+					bh_result->b_size * iblock);
+			memcpy(kaddr, buffer_cache_bh->b_data,
+					bh_result->b_size);
+			kunmap_local(kaddr);
 			set_buffer_uptodate(bh_result);
 		}
 		brelse(buffer_cache_bh);
-- 
2.47.2


