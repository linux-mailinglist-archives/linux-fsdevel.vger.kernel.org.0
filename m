Return-Path: <linux-fsdevel+bounces-2437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893F7E5F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788B31C20B26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9D358B3;
	Wed,  8 Nov 2023 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8bVmGDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D219449;
	Wed,  8 Nov 2023 20:46:19 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC11FEE;
	Wed,  8 Nov 2023 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Xt7WoMjwUbI5RdtTS6T0Pd0aju4CIna8D3FtR/ZUNJY=; b=A8bVmGDA5X8zpf0hA5OgmOIx/8
	qYxROIW3tqyiNfHvkMIekZ92csUFAG6OtKNCXooUO+RjKPvtK+34VdIFCzg0h1Zs/LK855reBTbiz
	OvzurJrNUv3xjjx/ogOhLSoZ+MUNa6lHXfX28Vv3oFlHjS5xd1QmjpoITm1/ABzMfr1/ow0Ovq3qr
	ksWLBTWeBC/zClPOSGwZIdoiW28lSoIEXVogxx0/kcUmsOKR2AxeZhR/p4vQl7ZO/nbjQiqlP+MJf
	9hzzZqVarYtR/70v9HU9/wiUbXssoPHPb62tmrf3wxTsz4yLMK6p4Ka8IBOxSVVqfnjAgonPiUEpk
	GMTuFVmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0pRB-0037q8-Ub; Wed, 08 Nov 2023 20:46:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] smb: Do not test the return value of folio_start_writeback()
Date: Wed,  8 Nov 2023 20:46:04 +0000
Message-Id: <20231108204605.745109-4-willy@infradead.org>
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
in smb.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/smb/client/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index cf17e3dd703e..45ca492c141c 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2706,8 +2706,7 @@ static void cifs_extend_writeback(struct address_space *mapping,
 			 */
 			if (!folio_clear_dirty_for_io(folio))
 				WARN_ON(1);
-			if (folio_start_writeback(folio))
-				WARN_ON(1);
+			folio_start_writeback(folio);
 
 			*_count -= folio_nr_pages(folio);
 			folio_unlock(folio);
@@ -2742,8 +2741,7 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	int rc;
 
 	/* The folio should be locked, dirty and not undergoing writeback. */
-	if (folio_start_writeback(folio))
-		WARN_ON(1);
+	folio_start_writeback(folio);
 
 	count -= folio_nr_pages(folio);
 	len = folio_size(folio);
-- 
2.42.0


