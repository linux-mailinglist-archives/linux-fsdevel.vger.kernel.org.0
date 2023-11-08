Return-Path: <linux-fsdevel+bounces-2441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F27E5F65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B93F1C20C07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95081358A2;
	Wed,  8 Nov 2023 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wj3L/Htn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8632C65;
	Wed,  8 Nov 2023 20:46:27 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F021FEE;
	Wed,  8 Nov 2023 12:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wES3ZsmVvtSqA0ACphY6ZvSicUCAZFemtVPzexjSemw=; b=Wj3L/HtnRHZuk7esIJOBq4i3RR
	PzWM9RLmA0VuVFV2UImD0b6RCn/LW+AeGImfYlq44gOkhr8pnNVWoTvkNX1Z+kaLtyaqtpgYez0W2
	xpkZPDmpWiu3HZZj4w7u67DS9eeGmLRuL+4tB53PEjoTP9vrXrLpl69oEu+BD1VzwSshLqaeZO2N3
	OpzXP860037HjhoQpN4CvKgTrnjvTIuTigYXCqV5pKipmiRNK1i2V+a9beKFXCoxtyOMtRPZ6+wWC
	KMtCYCCXjqcQrkScXlD2c4ZCTzN2iokxuzAIKR5rjKs/hEjts0Abvma/T8Zgj9Cr4W20+bDuqaV3o
	3VonDV0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0pRB-0037q4-Or; Wed, 08 Nov 2023 20:46:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] mm: Remove test_set_page_writeback()
Date: Wed,  8 Nov 2023 20:46:02 +0000
Message-Id: <20231108204605.745109-2-willy@infradead.org>
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

There are no more callers of this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a88e64acebfe..a440062e9386 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -780,11 +780,6 @@ bool set_page_writeback(struct page *page);
 #define folio_start_writeback_keepwrite(folio)	\
 	__folio_start_writeback(folio, true)
 
-static inline bool test_set_page_writeback(struct page *page)
-{
-	return set_page_writeback(page);
-}
-
 static __always_inline bool folio_test_head(struct folio *folio)
 {
 	return test_bit(PG_head, folio_flags(folio, FOLIO_PF_ANY));
-- 
2.42.0


