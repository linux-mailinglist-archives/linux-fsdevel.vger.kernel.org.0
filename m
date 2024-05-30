Return-Path: <linux-fsdevel+bounces-20581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884238D53BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB0B2872C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB316F0D6;
	Thu, 30 May 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GsIwjYph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9821591E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100482; cv=none; b=vCMqAM1V9lQXLV+NGxnj/310E7nWWzpn/olgriC7fmKJw/StsVqkHTkTBvavwuJfgZq89C3NZJqo+f4bvI4flTCPTT3B365WxCwe2SuRJ2BKOWerRIdM/0zaHrEqzDtJggZXL1PZRg5d9jKokMedxckq4g5/GEM4uxF3wuX71Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100482; c=relaxed/simple;
	bh=UJy8f6ZWcblFAMa4JzSNZFfvhlrtyqo8Nv2/n6Ropzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4Boq5A8o+tUczZRHldCz5lSFzAyaw3qTP7n0Z9xe9KTR4FdkxzJ8aH5wjnVqurHAAh7ST17Tj1cMv5/1d2v9u7WHKqiNeXy94us+6mCTOCzhO6pWLiGOMOeb/q4M23cf62x0zBbGAowKyAGkcoke9D2sBdwt9UrvfsdYCV3DOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GsIwjYph; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OVnmJh0dZ5waDkf7W6hgDh//gJkJckKQxE8pidyMhso=; b=GsIwjYph7o3c358/dFxb1kZ0Il
	xDQ3JqrX5TAlcazptV9oiBSQG9yfmm7PujuK8YFa82S8f6XSd8FZrCllccnlyYjPWPVh9KvgOZ4RC
	vOo4TZpN1bsdrqQO6f7+VhvzF7K+zIvrzuWL9+q7+QTHFGSVcRlVPnga6UG4zF/83AQ3s0TeFxIwc
	FMA65eZMENysFGutTxfAn/XW9ip0uKTpnCGputskMQEbBiEDSjsJqvhvZB2ZQmT5jHCWil9x3z9dB
	9kT0Ce+e4QjhTS0OTh/mjCq1ppVc/HqaJBxW2pbCRxh7ZiQ8+gff4lH64RiOn5772/MFWWagHIgcQ
	LqrI/VxA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH0-0000000B8LS-0nmG;
	Thu, 30 May 2024 20:21:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH 10/16] orangefs: Remove calls to set/clear the error flag
Date: Thu, 30 May 2024 21:21:02 +0100
Message-ID: <20240530202110.2653630-11-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on orangefs folios, so stop setting and
clearing it.  We can also use folio_end_read() to simplify
orangefs_read_folio().

Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c           | 13 +++----------
 fs/orangefs/orangefs-bufmap.c |  4 +---
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 085912268442..fdb9b65db1de 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -56,7 +56,6 @@ static int orangefs_writepage_locked(struct page *page,
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
 	    len, wr, NULL, NULL);
 	if (ret < 0) {
-		SetPageError(page);
 		mapping_set_error(page->mapping, ret);
 	} else {
 		ret = 0;
@@ -119,7 +118,6 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	    0, &wr, NULL, NULL);
 	if (ret < 0) {
 		for (i = 0; i < ow->npages; i++) {
-			SetPageError(ow->pages[i]);
 			mapping_set_error(ow->pages[i]->mapping, ret);
 			if (PagePrivate(ow->pages[i])) {
 				wrp = (struct orangefs_write_range *)
@@ -303,15 +301,10 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 	iov_iter_zero(~0U, &iter);
 	/* takes care of potential aliasing */
 	flush_dcache_folio(folio);
-	if (ret < 0) {
-		folio_set_error(folio);
-	} else {
-		folio_mark_uptodate(folio);
+	if (ret > 0)
 		ret = 0;
-	}
-	/* unlock the folio after the ->read_folio() routine completes */
-	folio_unlock(folio);
-        return ret;
+	folio_end_read(folio, ret == 0);
+	return ret;
 }
 
 static int orangefs_write_begin(struct file *file,
diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index b501dc07f922..edcca4beb765 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -274,10 +274,8 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
 		gossip_err("orangefs error: asked for %d pages, only got %d.\n",
 				bufmap->page_count, ret);
 
-		for (i = 0; i < ret; i++) {
-			SetPageError(bufmap->page_array[i]);
+		for (i = 0; i < ret; i++)
 			unpin_user_page(bufmap->page_array[i]);
-		}
 		return -ENOMEM;
 	}
 
-- 
2.43.0


