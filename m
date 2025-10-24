Return-Path: <linux-fsdevel+bounces-65545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2192AC077CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640DA1C47CF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8C340DBF;
	Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJfpYvG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35531B107;
	Fri, 24 Oct 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325709; cv=none; b=WhxYfLkczfMpKZMgOfLX70aA3HA2HmkaSSW3GIsxw79EKukT7KDtbJYWNpCoLfo6Kc43KX6r1SI9gA/dKZ1AqXVZ4fMRUp/GUIyRgdHoJpbTKK1SLWR82gi0lskAkepovtHpo7Q3GdzmT1qL0cFWfnKYrudKzn9u0QwEkPH8XDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325709; c=relaxed/simple;
	bh=wqSctaGLbOAG3AL2aieD8HcgdkAcPp298miUKnaPAcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXo9Wl2sVMq2JN6ajRoUWWh3tyzOlyRX6SeVszN3RAscQ2sRad7d0IRjWYYTyGMKTqUq3dHZsmF3REijSLMhKaUTX2iFgg2aiHEcCMZSOvo7CRALvOKpg8fHi1hyLMWJD7WrjIFexxv1S2XWXeRE4J2bqZtenZSEMJ3H3/gh4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJfpYvG2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gTsFlozDDQueOcQeXRYwaYxHus94+6oFOdygmX+dCc4=; b=XJfpYvG2Uf/JVUNOPkuZ4brb2A
	PT/lc56IQMftmbIEMDHy/cG/LWACoppKiR6P4vV082GQeQVRf859A+FpFAMWNg3b50aQqacxB8plY
	jISSlR90ucNLVzJlZFi81mNQdt54n87dzWBgYfs5Vncc4vp2a0nVszkMRnZs1iXUi3qYWbxXJlFLU
	NLq3bRl50j7k8Qj4uPwoX8ugzyDljeozkZK4qTcBwOJ04xvXLMeG1cY78pPUkoZY0SfYt7ZrUx5q3
	FIPPN+qsCvd9uYFxlMM29ZMk54OgvEJ5FQSSVSq1jZT4ZEuX5y/sJbum1x4vpO15nAzeo92SuYm+T
	UXYHVStg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH7-00000005zLo-1Kyu;
	Fri, 24 Oct 2025 17:08:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org
Subject: [PATCH 07/10] iomap: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:15 +0100
Message-ID: <20251024170822.1427218-8-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one instruction more efficient than open-coding folio_pos() +
folio_size().  It's the equivalent of (x + y) << z rather than
x << z + y << z.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
---
 fs/iomap/buffered-io.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8b847a1e27f1..32a27f36372d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -707,7 +707,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 	 * are not changing pagecache contents.
 	 */
 	if (!(iter->flags & IOMAP_UNSHARE) && pos <= folio_pos(folio) &&
-	    pos + len >= folio_pos(folio) + folio_size(folio))
+	    pos + len >= folio_next_pos(folio))
 		return 0;
 
 	ifs = ifs_alloc(iter->inode, folio, iter->flags);
@@ -1097,8 +1097,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 	if (!ifs)
 		return;
 
-	last_byte = min_t(loff_t, end_byte - 1,
-			folio_pos(folio) + folio_size(folio) - 1);
+	last_byte = min_t(loff_t, end_byte - 1, folio_next_pos(folio) - 1);
 	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
 	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
 	for (i = first_blk; i <= last_blk; i++) {
@@ -1129,8 +1128,7 @@ static void iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 	 * Make sure the next punch start is correctly bound to
 	 * the end of this data range, not the end of the folio.
 	 */
-	*punch_start_byte = min_t(loff_t, end_byte,
-				folio_pos(folio) + folio_size(folio));
+	*punch_start_byte = min_t(loff_t, end_byte, folio_next_pos(folio));
 }
 
 /*
@@ -1170,7 +1168,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
 				start_byte, end_byte, iomap, punch);
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_pos(folio) + folio_size(folio);
+		start_byte = folio_next_pos(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.47.2


