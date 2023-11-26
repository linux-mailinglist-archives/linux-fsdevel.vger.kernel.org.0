Return-Path: <linux-fsdevel+bounces-3845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AF27F92AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015192811CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBBED313;
	Sun, 26 Nov 2023 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uSLC1Xi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1367AE5;
	Sun, 26 Nov 2023 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v1PUYd9IhEWG+moQCvLaYD8aOxotdARhrKE2eE2JJ/E=; b=uSLC1Xi9Y9AO4iRi5mVnOWLrln
	M10PIAuVcZQCILhzW5KSAm2av7CYhVep5t5RzwbBnr3GbduP1KxEaEbEfcWDBNlYqW2PmgufGEy/f
	8KwFOU0PAmm6vMFwOdkivqFI37xzRuiMCGF2PVLmYpdusgqlahj/EcKgZEf6slQuSRk82vgv6MI/4
	aiMN203q8OMcNEMBSGNTnczY7HESS2ToVvJMEL0kFpXvCHoGXZTTVn3JGQa05HY9QEIxRXgveBkl8
	naEd2ueBXuEQpbzJMt4TVQVEGpUpu5g0zdcyHDJ4IVg2bRnlE/vw1WfJup/QdW3CvmbS112v7Vtjm
	JzOTT2TA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EXy-00BCGH-0L;
	Sun, 26 Nov 2023 12:47:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/13] iomap: drop the obsolete PF_MEMALLOC check in iomap_do_writepage
Date: Sun, 26 Nov 2023 13:47:11 +0100
Message-Id: <20231126124720.1249310-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The iomap writepage implementation has been removed in commit
478af190cb6c ("iomap: remove iomap_writepage") and this code is now only
called through ->writepages which never happens from memory reclaim.
Remove the canary in the coal mine now that the coal mine has been shut
down.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b28c57f8603303..8148e4c9765dac 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1910,20 +1910,6 @@ static int iomap_do_writepage(struct folio *folio,
 
 	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
 
-	/*
-	 * Refuse to write the folio out if we're called from reclaim context.
-	 *
-	 * This avoids stack overflows when called from deeply used stacks in
-	 * random callers for direct reclaim or memcg reclaim.  We explicitly
-	 * allow reclaim from kswapd as the stack usage there is relatively low.
-	 *
-	 * This should never happen except in the case of a VM regression so
-	 * warn about it.
-	 */
-	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
-			PF_MEMALLOC))
-		goto redirty;
-
 	/*
 	 * Is this folio beyond the end of the file?
 	 *
@@ -1989,8 +1975,6 @@ static int iomap_do_writepage(struct folio *folio,
 
 	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
 
-redirty:
-	folio_redirty_for_writepage(wbc, folio);
 unlock:
 	folio_unlock(folio);
 	return 0;
-- 
2.39.2


