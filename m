Return-Path: <linux-fsdevel+bounces-43299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58AA50CC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0CB3AD343
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7022571D5;
	Wed,  5 Mar 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="foizu0cY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90339254AEC
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207661; cv=none; b=FppNPieLNsqc2wz/EQ+9E8sMAGEmq5zbB+8bqhOD3+BSBEAjpN7w9sB7Mhhn/f0cAdYbvH038p/y4lofM8pKMzvuX73ZDQjb15FEg8F9550ebkJFMKP2Lb2ixe2JAVh6H4F+rQyHRF29ehqrz1Rjrdgg9noJYeiOShErHkC/zew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207661; c=relaxed/simple;
	bh=6kPFoFyf0spY1u41KXs2T92nBthGRXeV2CjZ5yQm6oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwtwXcQiOFfzX3AgPek43ZyXDxNMA0j2wSbuQzHwOzVZZSQ5xBN1b8D0jOL1CMcOdbUZ04VLu9bNYmbhgVAnH4AZbAFJgne2aKuv3rdum1qT9Lp9tjkHaeIcFhdbUBG1fpWlyQRmOWahsqEhJBObRyIG/2uAna1HPx35wguwj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=foizu0cY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=G+WShbGla95vGcpMugxqFQuk//QJP5tZtY68vSWvuKE=; b=foizu0cYYkQ5B6LCj1uetqNGLQ
	pcYdXbdJVpyGHWz5lq7/v8XYBJaB8Nn8bB7GF5yoepnKIYUbG4roVsPsTXq6RL6V+N/94W4qRsHyd
	nGBI6hylAVWwhQpADR49vmG8+aJQfBftB55unsBUXhNmoPIWTpPqCf/5/D/KR0PGvwLUA+6+VS2CN
	KNDT94gPDOy/7S5WiVeTE9uOh4OePxjHHxs8WG9X03C0gEiFPVaHscs+56aQCIet20fnC/qf8/3m4
	71CFbca5pkX9jHy67w+rSV2XdJY28475RyTXEK5+SWL9pZnOxtjwDztC6JzMxCvAenoeextZwjzU+
	b+mZ4ruA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveT-00000006Bnd-3C2c;
	Wed, 05 Mar 2025 20:47:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 8/9] orangefs: Simplify bvec setup in orangefs_writepages_work()
Date: Wed,  5 Mar 2025 20:47:32 +0000
Message-ID: <20250305204734.1475264-9-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This produces a bvec which is slightly different as the last page is added
in its entirety rather than only the portion which is being written back.
However we don't use this information anywhere; the iovec has its own
length parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 927c2829976c..7b5272931e3b 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -83,18 +83,18 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
+	size_t start;
 	loff_t len, off;
 	int i;
 
 	len = i_size_read(inode);
 
+	start = offset_in_page(ow->off);
 	for (i = 0; i < ow->npages; i++) {
 		set_page_writeback(ow->pages[i]);
-		bvec_set_page(&ow->bv[i], ow->pages[i],
-			      min(page_offset(ow->pages[i]) + PAGE_SIZE,
-			          ow->off + ow->len) -
-			      max(ow->off, page_offset(ow->pages[i])),
-			      i == 0 ? ow->off - page_offset(ow->pages[i]) : 0);
+		bvec_set_page(&ow->bv[i], ow->pages[i], PAGE_SIZE - start,
+			      start);
+		start = 0;
 	}
 	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
-- 
2.47.2


