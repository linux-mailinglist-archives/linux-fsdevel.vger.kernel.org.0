Return-Path: <linux-fsdevel+bounces-2440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D625D7E5F64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911622816F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820AD30F94;
	Wed,  8 Nov 2023 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r427iEVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03F374C3;
	Wed,  8 Nov 2023 20:46:24 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935CD213A;
	Wed,  8 Nov 2023 12:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xqFPBE5qVQWbofW/ruyffDXQJchhDI2KkWtP9SqFK1k=; b=r427iEVk8E2Qb1R/31XH9BolVG
	bu6sYWVbCqXXi59Q71AFxgZ/0OVs0t6mTGtZ344H69gFiw75+bVCeF3DcywK3Lp2+KvwxQzn5Dq2i
	SG5hbS9q0hmX1csAe3LgGvFfUx2mb+PhHcCcI7fRbLmCzTe1bYBVKfsR3eOnJQYLL51ALDdbwpurO
	oC2L/mwGlpOw8PRa7w21+lLqzCAYTbsJINnubS6Jzoxtrrk2/y6yAmx3ipHvzTzUS/QRwAX7UVz1a
	JG9slK6y8zg4kqLRj5yZAe6vrnXM7Q0uZS+pVuC98uObA0n5AEhysfJS10vTl90wLFYK/okB5HgNO
	qlPAlZLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0pRB-0037q6-Rl; Wed, 08 Nov 2023 20:46:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] afs: Do not test the return value of folio_start_writeback()
Date: Wed,  8 Nov 2023 20:46:03 +0000
Message-Id: <20231108204605.745109-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108204605.745109-1-willy@infradead.org>
References: <20231108204605.745109-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing the return value entirely, stop testing it
in afs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 4a168781936b..57d05d67f0c2 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -559,8 +559,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 
 			if (!folio_clear_dirty_for_io(folio))
 				BUG();
-			if (folio_start_writeback(folio))
-				BUG();
+			folio_start_writeback(folio);
 			afs_folio_start_fscache(caching, folio);
 
 			*_count -= folio_nr_pages(folio);
@@ -595,8 +594,7 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 
 	_enter(",%lx,%llx-%llx", folio_index(folio), start, end);
 
-	if (folio_start_writeback(folio))
-		BUG();
+	folio_start_writeback(folio);
 	afs_folio_start_fscache(caching, folio);
 
 	count -= folio_nr_pages(folio);
-- 
2.42.0


